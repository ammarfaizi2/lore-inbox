Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314515AbSDSCcf>; Thu, 18 Apr 2002 22:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314516AbSDSCcd>; Thu, 18 Apr 2002 22:32:33 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:23781 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314515AbSDSCbN>;
	Thu, 18 Apr 2002 22:31:13 -0400
Date: Thu, 18 Apr 2002 19:29:39 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        irda-users@lists.sourceforge.net
Subject: [PATCH] : ir258_wait_event_fixes-2.diff
Message-ID: <20020418192939.D988@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir258_wait_event_fixes-2.diff :
-----------------------------
	        <Following patch from Martin Diehl, mangled by me>
	o [FEATURE] Replace interruptible_sleep_on() with wait_event().
		Most races were taken care off, but cleaner anyway

--------------------------------------------

diff -u -p linux/net/irda/ircomm/ircomm_tty.d7.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d7.c	Wed Apr 10 16:44:12 2002
+++ linux/net/irda/ircomm/ircomm_tty.c	Wed Apr 10 16:44:40 2002
@@ -453,8 +453,21 @@ static int ircomm_tty_open(struct tty_st
 	 */
 	if (tty_hung_up_p(filp) ||
 	    (self->flags & ASYNC_CLOSING)) {
-		if (self->flags & ASYNC_CLOSING)
-			interruptible_sleep_on(&self->close_wait);
+
+		/* Hm, why are we blocking on ASYNC_CLOSING if we
+		 * do return -EAGAIN/-ERESTARTSYS below anyway?
+		 * IMHO it's either not needed in the first place
+		 * or for some reason we need to make sure the async
+		 * closing has been finished - if so, wouldn't we
+		 * probably better sleep uninterruptible?
+		 */
+
+		if (wait_event_interruptible(self->close_wait, !(self->flags&ASYNC_CLOSING))) {
+			WARNING("%s - got signal while blocking on ASYNC_CLOSING!\n",
+				__FUNCTION__);
+			return -ERESTARTSYS;
+		}
+
 		/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
 #ifdef SERIAL_DO_RESTART
 		return ((self->flags & ASYNC_HUP_NOTIFY) ?
diff -u -p linux/net/irda/af_irda.d7.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d7.c	Wed Apr 10 16:44:21 2002
+++ linux/net/irda/af_irda.c	Fri Apr 12 16:25:19 2002
@@ -568,15 +568,17 @@ static int irda_find_lsap_sel(struct ird
 	if(self->iriap == NULL)
 		return -ENOMEM;
 
-	/* Treat unexpected signals as disconnect */
+	/* Treat unexpected wakeup as disconnect */
 	self->errno = -EHOSTUNREACH;
 
 	/* Query remote LM-IAS */
 	iriap_getvaluebyclass_request(self->iriap, self->saddr, self->daddr,
 				      name, "IrDA:TinyTP:LsapSel");
-	/* Wait for answer (if not already failed) */
-	if(self->iriap != NULL)
-		interruptible_sleep_on(&self->query_wait);
+
+	/* Wait for answer, if not yet finished (or failed) */
+	if (wait_event_interruptible(self->query_wait, (self->iriap==NULL)))
+		/* Treat signals as disconnect */
+		return -EHOSTUNREACH;
 
 	/* Check what happened */
 	if (self->errno)
@@ -877,16 +879,47 @@ static int irda_accept(struct socket *so
 	 *	The read queue this time is holding sockets ready to use
 	 *	hooked into the SABM we saved
 	 */
-	do {
-		if ((skb = skb_dequeue(&sk->receive_queue)) == NULL) {
-			if (flags & O_NONBLOCK)
-				return -EWOULDBLOCK;
 
-			interruptible_sleep_on(sk->sleep);
-			if (signal_pending(current)) 
-				return -ERESTARTSYS;
+	/*
+	 * We can perform the accept only if there is incomming data
+	 * on the listening socket.
+	 * So, we will block the caller until we receive any data.
+	 * If the caller was waiting on select() or poll() before
+	 * calling us, the data is waiting for us ;-)
+	 * Jean II
+	 */
+	skb = skb_dequeue(&sk->receive_queue);
+	if (skb == NULL) {
+		int ret = 0;
+		DECLARE_WAITQUEUE(waitq, current);
+
+		/* Non blocking operation */
+		if (flags & O_NONBLOCK)
+			return -EWOULDBLOCK;
+
+		/* The following code is a cut'n'paste of the
+		 * wait_event_interruptible() macro.
+		 * We don't us the macro because the condition has
+		 * side effects : we want to make sure that only one
+		 * skb get dequeued - Jean II */
+		add_wait_queue(sk->sleep, &waitq);
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			skb = skb_dequeue(&sk->receive_queue);
+			if (skb != NULL)
+				break;
+			if (!signal_pending(current)) {
+				schedule();
+				continue;
+			}
+			ret = -ERESTARTSYS;
+			break;
 		}
-	} while (skb == NULL);
+		current->state = TASK_RUNNING;
+		remove_wait_queue(sk->sleep, &waitq);
+		if(ret)
+			return -ERESTARTSYS;
+	}
 
  	newsk = newsock->sk;
 	newsk->state = TCP_ESTABLISHED;
@@ -1024,19 +1057,9 @@ static int irda_connect(struct socket *s
 	if (sk->state != TCP_ESTABLISHED && (flags & O_NONBLOCK))
 		return -EINPROGRESS;
 
-	/* Here, there is a race condition : the state may change between
-	 * our test and the sleep, via irda_connect_confirm().
-	 * The way to workaround that is to sleep with a timeout, so that
-	 * we don't sleep forever and check the state when waking up.
-	 * 50ms is plenty good enough, because the LAP is already connected.
-	 * Jean II */
-	while (sk->state == TCP_SYN_SENT) {
-		interruptible_sleep_on_timeout(sk->sleep, HZ/20);
-		if (signal_pending(current)) {
-			return -ERESTARTSYS;
-		}
-	}
-	
+	if (wait_event_interruptible(*(sk->sleep), (sk->state!=TCP_SYN_SENT)))
+		return -ERESTARTSYS;
+
 	if (sk->state != TCP_ESTABLISHED) {
 		sock->state = SS_UNCONNECTED;
 		return sock_error(sk);	/* Always set at this point */
@@ -1280,17 +1303,14 @@ static int irda_sendmsg(struct socket *s
 	ASSERT(self != NULL, return -1;);
 
 	/* Check if IrTTP is wants us to slow down */
-	while (self->tx_flow == FLOW_STOP) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), IrTTP is busy, going to sleep!\n");
-		interruptible_sleep_on(sk->sleep);
-		
-		/* Check if we are still connected */
-		if (sk->state != TCP_ESTABLISHED)
-			return -ENOTCONN;
-		/* Handle signals */
-		if (signal_pending(current)) 
-			return -ERESTARTSYS;
-	}
+
+	if (wait_event_interruptible(*(sk->sleep),
+	    (self->tx_flow != FLOW_STOP  ||  sk->state != TCP_ESTABLISHED)))
+		return -ERESTARTSYS;
+
+	/* Check if we are still connected */
+	if (sk->state != TCP_ESTABLISHED)
+		return -ENOTCONN;
 
 	/* Check that we don't send out to big frames */
 	if (len > self->max_data_size) {
@@ -1382,14 +1402,23 @@ static int irda_recvmsg_dgram(struct soc
  *
  *    Sleep until data has arrive. But check for races..
  *
+ *    The caller is expected to deal with the situation when we return
+ *    due to pending signals. And even if not, the peeked skb might have
+ *    been already dequeued due to concurrent operation.
+ *    Currently irda_recvmsg_stream() is the only caller and is ok.
+ * Return 0 if condition packet has arrived, -ERESTARTSYS if signal_pending()
+ * Only used once in irda_recvmsg_stream() -> inline
  */
-static void irda_data_wait(struct sock *sk)
+static inline int irda_data_wait(struct sock *sk)
 {
+	int ret = 0;
 	if (!skb_peek(&sk->receive_queue)) {
 		set_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
-		interruptible_sleep_on(sk->sleep);
+		__wait_event_interruptible(*(sk->sleep),
+			(skb_peek(&sk->receive_queue)!=NULL), ret);
 		clear_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
 	}
+	return(ret);
 }
 
 /*
@@ -1444,8 +1473,8 @@ static int irda_recvmsg_stream(struct so
 
 			if (noblock)
 				return -EAGAIN;
-			irda_data_wait(sk);
-			if (signal_pending(current))
+			/* Wait process until data arrives */
+			if (irda_data_wait(sk))
 				return -ERESTARTSYS;
 			continue;
 		}
@@ -2281,7 +2310,12 @@ bed:
 		self->iriap = iriap_open(LSAP_ANY, IAS_CLIENT, self,
 					 irda_getvalue_confirm);
 
-		/* Treat unexpected signals as disconnect */
+		if (self->iriap == NULL) {
+			kfree(ias_opt);
+			return -ENOMEM;
+		}
+
+		/* Treat unexpected wakeup as disconnect */
 		self->errno = -EHOSTUNREACH;
 
 		/* Query remote LM-IAS */
@@ -2289,9 +2323,17 @@ bed:
 					      self->saddr, daddr,
 					      ias_opt->irda_class_name,
 					      ias_opt->irda_attrib_name);
-		/* Wait for answer (if not already failed) */
-		if(self->iriap != NULL)
-			interruptible_sleep_on(&self->query_wait);
+
+		/* Wait for answer, if not yet finished (or failed) */
+		if (wait_event_interruptible(self->query_wait,
+					     (self->iriap == NULL))) {
+			/* pending request uses copy of ias_opt-content
+			 * we can free it regardless! */
+			kfree(ias_opt);
+			/* Treat signals as disconnect */
+			return -EHOSTUNREACH;
+		}
+
 		/* Check what happened */
 		if (self->errno)
 		{
@@ -2348,12 +2390,14 @@ bed:
 		irlmp_update_client(self->ckey, self->mask,
 				    irda_selective_discovery_indication,
 				    NULL, (void *) self);
-		
+
 		/* Do some discovery (and also return cached results) */
 		irlmp_discovery_request(self->nslots);
-		
+
 		/* Wait until a node is discovered */
 		if (!self->cachediscovery) {
+			int ret = 0;
+
 			IRDA_DEBUG(1, __FUNCTION__ 
 				   "(), nothing discovered yet, going to sleep...\n");
 
@@ -2362,9 +2406,12 @@ bed:
 			self->watchdog.data = (unsigned long) self;
 			self->watchdog.expires = jiffies + (val * HZ/1000);
 			add_timer(&(self->watchdog));
+			self->errno = 0;
 
 			/* Wait for IR-LMP to call us back */
-			interruptible_sleep_on(&self->query_wait);
+			__wait_event_interruptible(self->query_wait,
+			   (self->cachediscovery!=NULL || self->errno==-ETIME),
+						   ret);
 
 			/* If watchdog is still activated, kill it! */
 			if(timer_pending(&(self->watchdog)))
@@ -2372,6 +2419,9 @@ bed:
 
 			IRDA_DEBUG(1, __FUNCTION__ 
 				   "(), ...waking up !\n");
+
+			if (ret != 0)
+				return ret;
 		}
 		else
 			IRDA_DEBUG(1, __FUNCTION__ 
