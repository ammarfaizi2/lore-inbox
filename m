Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSFRV6W>; Tue, 18 Jun 2002 17:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSFRV5z>; Tue, 18 Jun 2002 17:57:55 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:2283 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317639AbSFRV5c>;
	Tue, 18 Jun 2002 17:57:32 -0400
Date: Tue, 18 Jun 2002 14:57:33 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir252_cache_wait_data-2.diff
Message-ID: <20020618145733.B7819@bougret.hpl.hp.com>
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

ir252_cache_wait_data-2.diff :
----------------------------
	o [CRITICA] Fix one instance were we forgot to clear LSAP cache
	o [CORRECT] Fix a bogus conversion to wait_event()
		The socket closure would never propagate to the app


diff -u -p linux/net/irda/irlmp.d0.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d0.c	Tue Jun 18 14:04:05 2002
+++ linux/net/irda/irlmp.c	Tue Jun 18 14:06:56 2002
@@ -647,6 +647,9 @@ int irlmp_disconnect_request(struct lsap
 	ASSERT(self->lap->lsaps != NULL, return -1;);
 
 	lsap = hashbin_remove(self->lap->lsaps, (int) self, NULL);
+#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
+	self->lap->cache.valid = FALSE;
+#endif
 
 	ASSERT(lsap != NULL, return -1;);
 	ASSERT(lsap->magic == LMP_LSAP_MAGIC, return -1;);
diff -u -p linux/net/irda/af_irda.d0.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d0.c	Tue Jun 18 14:04:13 2002
+++ linux/net/irda/af_irda.c	Tue Jun 18 14:06:56 2002
@@ -126,8 +126,10 @@ static void irda_disconnect_indication(v
 		dev_kfree_skb(skb);
 
 	sk = self->sk;
-	if (sk == NULL)
+	if (sk == NULL) {
+		IRDA_DEBUG(0, __FUNCTION__ "(%p) : BUG : sk is NULL\n", self);
 		return;
+	}
 
 	/* Prevent race conditions with irda_release() and irda_shutdown() */
 	if ((!sk->dead) && (sk->state != TCP_CLOSE)) {
@@ -1303,12 +1305,12 @@ static int irda_sendmsg(struct socket *s
 		len = self->max_data_size;
 	}
 
-	skb = sock_alloc_send_skb(sk, len + self->max_header_size,
+	skb = sock_alloc_send_skb(sk, len + self->max_header_size + 16, 
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return -ENOBUFS;
 
-	skb_reserve(skb, self->max_header_size);
+	skb_reserve(skb, self->max_header_size + 16);
 
 	asmptr = skb->h.raw = skb_put(skb, len);
 	memcpy_fromiovec(asmptr, msg->msg_iov, len);
@@ -1381,30 +1383,6 @@ static int irda_recvmsg_dgram(struct soc
 }
 
 /*
- * Function irda_data_wait (sk)
- *
- *    Sleep until data has arrive. But check for races..
- *
- *    The caller is expected to deal with the situation when we return
- *    due to pending signals. And even if not, the peeked skb might have
- *    been already dequeued due to concurrent operation.
- *    Currently irda_recvmsg_stream() is the only caller and is ok.
- * Return 0 if condition packet has arrived, -ERESTARTSYS if signal_pending()
- * Only used once in irda_recvmsg_stream() -> inline
- */
-static inline int irda_data_wait(struct sock *sk)
-{
-	int ret = 0;
-	if (!skb_peek(&sk->receive_queue)) {
-		set_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
-		__wait_event_interruptible(*(sk->sleep),
-			(skb_peek(&sk->receive_queue)!=NULL), ret);
-		clear_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
-	}
-	return(ret);
-}
-
-/*
  * Function irda_recvmsg_stream (sock, msg, size, flags, scm)
  */
 static int irda_recvmsg_stream(struct socket *sock, struct msghdr *msg,
@@ -1415,6 +1393,7 @@ static int irda_recvmsg_stream(struct so
 	int noblock = flags & MSG_DONTWAIT;
 	int copied = 0;
 	int target = 1;
+	DECLARE_WAITQUEUE(waitq, current);
 
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
 
@@ -1437,25 +1416,43 @@ static int irda_recvmsg_stream(struct so
 
 		skb=skb_dequeue(&sk->receive_queue);
 		if (skb==NULL) {
+			int ret = 0;
+
 			if (copied >= target)
 				break;
 
+			/* The following code is a cut'n'paste of the
+			 * wait_event_interruptible() macro.
+			 * We don't us the macro because the test condition
+			 * is messy. - Jean II */
+			set_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
+			add_wait_queue(sk->sleep, &waitq);
+			set_current_state(TASK_INTERRUPTIBLE);
+
 			/*
 			 *	POSIX 1003.1g mandates this order.
 			 */
+			if (sk->err)
+				ret = sock_error(sk);
+			else if (sk->shutdown & RCV_SHUTDOWN)
+				;
+			else if (noblock)
+				ret = -EAGAIN;
+			else if (signal_pending(current))
+				ret = -ERESTARTSYS;
+			else if (skb_peek(&sk->receive_queue) == NULL)
+				/* Wait process until data arrives */
+				schedule();
 
-			if (sk->err) {
-				return sock_error(sk);
-			}
+			current->state = TASK_RUNNING;
+			remove_wait_queue(sk->sleep, &waitq);
+			clear_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
 
+			if(ret)
+				return(ret);
 			if (sk->shutdown & RCV_SHUTDOWN)
 				break;
 
-			if (noblock)
-				return -EAGAIN;
-			/* Wait process until data arrives */
-			if (irda_data_wait(sk))
-				return -ERESTARTSYS;
 			continue;
 		}
 
@@ -2369,11 +2366,11 @@ bed:
 				   "(), nothing discovered yet, going to sleep...\n");
 
 			/* Set watchdog timer to expire in <val> ms. */
+			self->errno = 0;
 			self->watchdog.function = irda_discovery_timeout;
 			self->watchdog.data = (unsigned long) self;
 			self->watchdog.expires = jiffies + (val * HZ/1000);
 			add_timer(&(self->watchdog));
-			self->errno = 0;
 
 			/* Wait for IR-LMP to call us back */
 			__wait_event_interruptible(self->query_wait,
