Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314473AbSDSCar>; Thu, 18 Apr 2002 22:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314476AbSDSCaq>; Thu, 18 Apr 2002 22:30:46 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:16357 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314473AbSDSCa0>;
	Thu, 18 Apr 2002 22:30:26 -0400
Date: Thu, 18 Apr 2002 19:28:53 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        irda-users@lists.sourceforge.net
Subject: [PATCH] : ir258_flow_sched_ttp-6.diff
Message-ID: <20020418192853.C988@bougret.hpl.hp.com>
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

ir258_flow_sched_ttp-6.diff :
---------------------------
		<Won't compile without ir258_flow_sched_lap_lmp-6.diff>
	o [CORRECT] Fix race condition when starting todo timer
	o [CORRECT] Fix race condition when stopping higher layer
		Higher layer would think it is stopped and us it is started
	o [CORRECT] Give credit even if packets in Tx queue
		If Tx queue was stopped, could starve peer and deadlock
	o [CORRECT] Protect Rx credit update with spinlock
	o [CORRECT] Calculate properly self->avail_credit
		Didn't take into account queued Rx fragments
		Incremented even if Rx frame not delivered to higher layer
		-> would never stop the peer (i.e. not flow control)
		-> could become infinite
	o [CORRECT] Send credit when higher layer reenable receive
		Peer wouldn't restart Tx to us if flow stopped
	o [FEATURE] Implement LAP queue not full notification
		Lower latency, ...
	o [FEATURE] Reduce Tx queue to 8 packets (from 10)
		But make sure we can always send a full LAP window (7)
	o [FEATURE] Fix and optimise TTP flow control
		Make sure peer can always send a full LAP window (7)
		Minimise explicit credit updates (give_credit)
	o [FEATURE] Remove need for todo timer in Tx/Rx paths
		Less potential races, lower latency, lower context switches
		Could not use tasklet because broken API, better anyway ;-)

--------------------------------------------

diff -u -p -r linux/include/net/irda/irttp.d6.h linux/include/net/irda/irttp.h
--- linux/include/net/irda/irttp.d6.h	Wed Apr 10 14:04:47 2002
+++ linux/include/net/irda/irttp.h	Wed Apr 10 16:31:44 2002
@@ -42,11 +42,48 @@
 #define TTP_PARAMETERS         0x80
 #define TTP_MORE               0x80
 
-#define DEFAULT_INITIAL_CREDIT 14
+/* Transmission queue sizes */
+/* Worst case scenario, two window of data - Jean II */
+#define TTP_TX_MAX_QUEUE	14
+/* We need to keep at least 5 frames to make sure that we can refill
+ * appropriately the LAP layer. LAP keeps only two buffers, and we need
+ * to have 7 to make a full window - Jean II */
+#define TTP_TX_LOW_THRESHOLD	5
+/* Most clients are synchronous with respect to flow control, so we can
+ * keep a low number of Tx buffers in TTP - Jean II */
+#define TTP_TX_HIGH_THRESHOLD	7
+
+/* Receive queue sizes */
+/* Minimum of credit that the peer should hold.
+ * If the peer has less credits than 9 frames, we will explicitely send
+ * him some credits (through irttp_give_credit() and a specific frame).
+ * Note that when we give credits it's likely that it won't be sent in
+ * this LAP window, but in the next one. So, we make sure that the peer
+ * has something to send while waiting for credits (one LAP window == 7
+ * + 1 frames while he process the credits). - Jean II */
+#define TTP_RX_MIN_CREDIT	8
+/* This is the default maximum number of credits held by the peer, so the
+ * default maximum number of frames he can send us before needing flow
+ * control answer from us (this may be negociated differently at TSAP setup).
+ * We want to minimise the number of times we have to explicitely send some
+ * credit to the peer, hoping we can piggyback it on the return data. In
+ * particular, it doesn't make sense for us to send credit more than once
+ * per LAP window.
+ * Moreover, giving credits has some latency, so we need strictly more than
+ * a LAP window, otherwise we may already have credits in our Tx queue.
+ * But on the other hand, we don't want to keep too many Rx buffer here
+ * before starting to flow control the other end, so make it exactly one
+ * LAP window + 1 + MIN_CREDITS. - Jean II */
+#define TTP_RX_DEFAULT_CREDIT	16
+/* Maximum number of credits we can allow the peer to have, and therefore
+ * maximum Rx queue size.
+ * Note that we try to deliver packets to the higher layer every time we
+ * receive something, so in normal mode the Rx queue will never contains
+ * more than one or two packets. - Jean II */
+#define TTP_RX_MAX_CREDIT	21
 
-#define TTP_LOW_THRESHOLD       4
-#define TTP_HIGH_THRESHOLD     10
-#define TTP_MAX_QUEUE          14
+/* What clients should use when calling ttp_open_tsap() */
+#define DEFAULT_INITIAL_CREDIT	TTP_RX_DEFAULT_CREDIT
 
 /* Some priorities for disconnect requests */
 #define P_NORMAL    0
@@ -90,7 +127,7 @@ struct tsap_cb {
 
 	struct net_device_stats stats;
 	struct timer_list todo_timer; 
-	
+
 	__u32 max_seg_size;     /* Max data that fit into an IrLAP frame */
 	__u8  max_header_size;
 
@@ -131,6 +168,7 @@ int irttp_disconnect_request(struct tsap
 void irttp_flow_request(struct tsap_cb *self, LOCAL_FLOW flow);
 void irttp_status_indication(void *instance,
 			     LINK_STATUS link, LOCK_STATUS lock);
+void irttp_flow_indication(void *instance, void *sap, LOCAL_FLOW flow);
 struct tsap_cb *irttp_dup(struct tsap_cb *self, void *instance);
 
 static __inline __u32 irttp_get_saddr(struct tsap_cb *self)
diff -u -p -r linux/net/irda/irttp.d6.c linux/net/irda/irttp.c
--- linux/net/irda/irttp.d6.c	Wed Apr 10 16:31:06 2002
+++ linux/net/irda/irttp.c	Wed Apr 10 16:31:44 2002
@@ -59,8 +59,8 @@ static void irttp_run_rx_queue(struct ts
 
 static void irttp_flush_queues(struct tsap_cb *self);
 static void irttp_fragment_skb(struct tsap_cb *self, struct sk_buff *skb);
-static void irttp_start_todo_timer(struct tsap_cb *self, int timeout);
 static struct sk_buff *irttp_reassemble_skb(struct tsap_cb *self);
+static void irttp_todo_expired(unsigned long data);
 static int irttp_param_max_sdu_size(void *instance, irda_param_t *param, 
 				    int get);
 
@@ -72,6 +72,8 @@ static pi_minor_info_t pi_minor_call_tab
 static pi_major_info_t pi_major_call_table[] = {{ pi_minor_call_table, 2 }};
 static pi_param_info_t param_info = { pi_major_call_table, 1, 0x0f, 4 };
 
+/************************ GLOBAL PROCEDURES ************************/
+
 /*
  * Function irttp_init (void)
  *
@@ -126,6 +128,239 @@ void irttp_cleanup(void) 
 }
 #endif
 
+/*************************** SUBROUTINES ***************************/
+
+/*
+ * Function irttp_start_todo_timer (self, timeout)
+ *
+ *    Start todo timer. 
+ *
+ * Made it more effient and unsensitive to race conditions - Jean II
+ */
+static inline void irttp_start_todo_timer(struct tsap_cb *self, int timeout)
+{
+	/* Set new value for timer */
+	mod_timer(&self->todo_timer, jiffies + timeout);
+}
+
+/*
+ * Function irttp_todo_expired (data)
+ *
+ *    Todo timer has expired!
+ *
+ * One of the restriction of the timer is that it is run only on the timer
+ * interrupt which run every 10ms. This mean that even if you set the timer
+ * with a delay of 0, it may take up to 10ms before it's run.
+ * So, to minimise latency and keep cache fresh, we try to avoid using
+ * it as much as possible.
+ * Note : we can't use tasklets, because they can't be asynchronously
+ * killed (need user context), and we can't guarantee that here...
+ * Jean II
+ */
+static void irttp_todo_expired(unsigned long data)
+{
+	struct tsap_cb *self = (struct tsap_cb *) data;
+
+	/* Check that we still exist */
+	if (!self || self->magic != TTP_TSAP_MAGIC)
+		return;
+	
+	IRDA_DEBUG(4, __FUNCTION__ "(instance=%p)\n", self);
+
+	/* Try to make some progress, especially on Tx side - Jean II */
+	irttp_run_rx_queue(self);
+	irttp_run_tx_queue(self);
+
+	/* Check if time for disconnect */
+	if (test_bit(0, &self->disconnect_pend)) {
+		/* Check if it's possible to disconnect yet */
+		if (skb_queue_empty(&self->tx_queue)) {
+			/* Make sure disconnect is not pending anymore */
+			clear_bit(0, &self->disconnect_pend);	/* FALSE */
+
+			/* Note : self->disconnect_skb may be NULL */
+			irttp_disconnect_request(self, self->disconnect_skb,
+						 P_NORMAL);
+			self->disconnect_skb = NULL;
+		} else {
+			/* Try again later */
+			irttp_start_todo_timer(self, HZ/10);
+			
+			/* No reason to try and close now */
+			return;
+		}
+	}
+	
+	/* Check if it's closing time */
+	if (self->close_pend)
+		/* Finish cleanup */
+		irttp_close_tsap(self);
+}
+
+/*
+ * Function irttp_flush_queues (self)
+ *
+ *     Flushes (removes all frames) in transitt-buffer (tx_list)
+ */
+void irttp_flush_queues(struct tsap_cb *self)
+{
+	struct sk_buff* skb;
+	
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+
+	ASSERT(self != NULL, return;);
+	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
+	
+	/* Deallocate frames waiting to be sent */
+	while ((skb = skb_dequeue(&self->tx_queue)) != NULL)
+		dev_kfree_skb(skb);
+	
+	/* Deallocate received frames */
+	while ((skb = skb_dequeue(&self->rx_queue)) != NULL)
+		dev_kfree_skb(skb);
+	
+	/* Deallocate received fragments */
+	while ((skb = skb_dequeue(&self->rx_fragments)) != NULL)
+		dev_kfree_skb(skb);
+}
+
+/*
+ * Function irttp_reassemble (self)
+ *
+ *    Makes a new (continuous) skb of all the fragments in the fragment
+ *    queue
+ *
+ */
+static struct sk_buff *irttp_reassemble_skb(struct tsap_cb *self)
+{
+	struct sk_buff *skb, *frag;
+	int n = 0;  /* Fragment index */
+	
+      	ASSERT(self != NULL, return NULL;);
+	ASSERT(self->magic == TTP_TSAP_MAGIC, return NULL;);
+
+	IRDA_DEBUG(2, __FUNCTION__ "(), self->rx_sdu_size=%d\n", 
+		   self->rx_sdu_size);
+
+	skb = dev_alloc_skb(TTP_HEADER + self->rx_sdu_size);
+	if (!skb)
+		return NULL;
+
+	/* 
+	 * Need to reserve space for TTP header in case this skb needs to 
+	 * be requeued in case delivery failes
+	 */
+	skb_reserve(skb, TTP_HEADER);
+	skb_put(skb, self->rx_sdu_size);
+
+	/*
+	 *  Copy all fragments to a new buffer
+	 */
+	while ((frag = skb_dequeue(&self->rx_fragments)) != NULL) {
+		memcpy(skb->data+n, frag->data, frag->len);
+		n += frag->len;
+		
+		dev_kfree_skb(frag);
+	}
+	IRDA_DEBUG(2, __FUNCTION__ "(), frame len=%d\n", n);
+
+	IRDA_DEBUG(2, __FUNCTION__ "(), rx_sdu_size=%d\n", self->rx_sdu_size);
+	ASSERT(n <= self->rx_sdu_size, return NULL;);
+
+	/* Set the new length */
+	skb_trim(skb, n);
+
+	self->rx_sdu_size = 0;
+
+	return skb;
+}
+
+/*
+ * Function irttp_fragment_skb (skb)
+ *
+ *    Fragments a frame and queues all the fragments for transmission
+ *
+ */
+static inline void irttp_fragment_skb(struct tsap_cb *self,
+				      struct sk_buff *skb)
+{
+	struct sk_buff *frag;
+	__u8 *frame;
+
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	ASSERT(self != NULL, return;);
+	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
+	ASSERT(skb != NULL, return;);
+
+	/*
+	 *  Split frame into a number of segments
+	 */
+	while (skb->len > self->max_seg_size) {
+		IRDA_DEBUG(2, __FUNCTION__  "(), fragmenting ...\n");
+
+		/* Make new segment */
+		frag = dev_alloc_skb(self->max_seg_size+self->max_header_size);
+		if (!frag)
+			return;
+
+		skb_reserve(frag, self->max_header_size);
+
+		/* Copy data from the original skb into this fragment. */
+		memcpy(skb_put(frag, self->max_seg_size), skb->data, 
+		       self->max_seg_size);
+
+		/* Insert TTP header, with the more bit set */
+		frame = skb_push(frag, TTP_HEADER);
+		frame[0] = TTP_MORE;
+		
+		/* Hide the copied data from the original skb */
+		skb_pull(skb, self->max_seg_size);
+
+		/* Queue fragment */
+		skb_queue_tail(&self->tx_queue, frag);
+	}
+	/* Queue what is left of the original skb */
+	IRDA_DEBUG(2, __FUNCTION__  "(), queuing last segment\n");
+	
+	frame = skb_push(skb, TTP_HEADER);
+	frame[0] = 0x00; /* Clear more bit */
+
+	/* Queue fragment */
+	skb_queue_tail(&self->tx_queue, skb);
+}
+
+/*
+ * Function irttp_param_max_sdu_size (self, param)
+ *
+ *    Handle the MaxSduSize parameter in the connect frames, this function
+ *    will be called both when this parameter needs to be inserted into, and
+ *    extracted from the connect frames
+ */
+static int irttp_param_max_sdu_size(void *instance, irda_param_t *param, 
+				    int get)
+{
+	struct tsap_cb *self;
+
+	self = (struct tsap_cb *) instance;
+
+	ASSERT(self != NULL, return -1;);
+	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
+
+	if (get)
+		param->pv.i = self->tx_max_sdu_size;
+	else
+		self->tx_max_sdu_size = param->pv.i;
+
+	IRDA_DEBUG(1, __FUNCTION__ "(), MaxSduSize=%d\n", param->pv.i);
+	
+	return 0;
+}
+
+/*************************** CLIENT CALLS ***************************/
+/************************** LMP CALLBACKS **************************/
+/* Everything is happily mixed up. Waiting for next clean up - Jean II */
+
 /*
  * Function irttp_open_tsap (stsap, notify)
  *
@@ -157,7 +392,10 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 	memset(self, 0, sizeof(struct tsap_cb));
 	spin_lock_init(&self->lock);
 
+	/* Initialise todo timer */
 	init_timer(&self->todo_timer);
+	self->todo_timer.data     = (unsigned long) self;
+	self->todo_timer.function = &irttp_todo_expired;
 
 	/* Initialize callbacks for IrLMP to use */
 	irda_notify_init(&ttp_notify);
@@ -166,6 +404,7 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 	ttp_notify.disconnect_indication = irttp_disconnect_indication;
 	ttp_notify.data_indication = irttp_data_indication;
 	ttp_notify.udata_indication = irttp_udata_indication;
+	ttp_notify.flow_indication = irttp_flow_indication;
 	if(notify->status_indication != NULL)
 		ttp_notify.status_indication = irttp_status_indication;
 	ttp_notify.instance = self;
@@ -199,8 +438,8 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 
 	hashbin_insert(irttp->tsaps, (irda_queue_t *) self, (int) self, NULL);
 
-	if (credit > TTP_MAX_QUEUE)
-		self->initial_credit = TTP_MAX_QUEUE;
+	if (credit > TTP_RX_MAX_CREDIT)
+		self->initial_credit = TTP_RX_MAX_CREDIT;
 	else
 		self->initial_credit = credit;
 
@@ -224,7 +463,7 @@ static void __irttp_close_tsap(struct ts
 
 	del_timer(&self->todo_timer);
 
-	/* This one won't be cleaned up if we are diconnect_pend + close_pend
+	/* This one won't be cleaned up if we are disconnect_pend + close_pend
 	 * and we receive a disconnect_indication */
 	if (self->disconnect_skb)
 		dev_kfree_skb(self->disconnect_skb);
@@ -262,7 +501,7 @@ int irttp_close_tsap(struct tsap_cb *sel
 			irttp_disconnect_request(self, NULL, P_NORMAL);
 		}
 		self->close_pend = TRUE;
-		irttp_start_todo_timer(self, 1*HZ);
+		irttp_start_todo_timer(self, HZ/10);
 
 		return 0; /* Will be back! */
 	}
@@ -327,6 +566,9 @@ int irttp_data_request(struct tsap_cb *s
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
 	ASSERT(skb != NULL, return -1;);
 
+	IRDA_DEBUG(2, __FUNCTION__ " : queue len = %d\n",
+		   skb_queue_len(&self->tx_queue));
+
 	/* Check that nothing bad happens */
 	if ((skb->len == 0) || (!self->connected)) {
 		WARNING(__FUNCTION__ "(), No data, or not connected\n");
@@ -358,12 +600,14 @@ int irttp_data_request(struct tsap_cb *s
 	/* 
 	 *  Check if transmit queue is full
 	 */
-	if (skb_queue_len(&self->tx_queue) >= TTP_MAX_QUEUE) {
+	if (skb_queue_len(&self->tx_queue) >= TTP_TX_MAX_QUEUE) {
 		/*
 		 *  Give it a chance to empty itself
 		 */
 		irttp_run_tx_queue(self);
-		
+
+		/* Drop packet. This error code should trigger the caller
+		 * to requeue the packet in the client code - Jean II */
 		return -ENOBUFS;
 	}
        
@@ -387,20 +631,25 @@ int irttp_data_request(struct tsap_cb *s
 
 	/* Check if we can accept more data from client */
 	if ((!self->tx_sdu_busy) && 
-	    (skb_queue_len(&self->tx_queue) > TTP_HIGH_THRESHOLD)) {
-		
-		/* Tx queue filling up, so stop client */
-		self->tx_sdu_busy = TRUE;
-		
-	 	if (self->notify.flow_indication) {
+	    (skb_queue_len(&self->tx_queue) > TTP_TX_HIGH_THRESHOLD)) {
+		/* Tx queue filling up, so stop client. */
+		if (self->notify.flow_indication) {
  			self->notify.flow_indication(self->notify.instance, 
 						     self, FLOW_STOP);
 		}
- 	}
+		/* self->tx_sdu_busy is the state of the client.
+		 * Update state after notifying client to avoid
+		 * race condition with irttp_flow_indication().
+		 * If the queue empty itself after our test but before
+		 * we set the flag, we will fix ourselves below in
+		 * irttp_run_tx_queue().
+		 * Jean II */
+		self->tx_sdu_busy = TRUE;
+	}
 	
 	/* Try to make some progress */
 	irttp_run_tx_queue(self);
-	
+
 	return 0;
 }
 
@@ -416,28 +665,20 @@ static void irttp_run_tx_queue(struct ts
 	unsigned long flags;
 	int n;
 
+	IRDA_DEBUG(2, __FUNCTION__ "() : send_credit = %d, queue_len = %d\n",
+		   self->send_credit, skb_queue_len(&self->tx_queue));
+
 	/* Get exclusive access to the tx queue, otherwise don't touch it */
 	if (irda_lock(&self->tx_queue_lock) == FALSE)
 		return;
 
-	/* Try to send out frames as long as we have credits */
+	/* Try to send out frames as long as we have credits
+	 * and as long as LAP is not full. If LAP is full, it will
+	 * poll us through irttp_flow_indication() - Jean II */
 	while ((self->send_credit > 0) &&
+	       (!irlmp_lap_tx_queue_full(self->lsap)) &&
 	       (skb = skb_dequeue(&self->tx_queue)))
 	{
-		/* 
-		 * Make sure we don't flood IrLAP with frames just because
-		 * the remote device has given us a lot of credits
-		 */
-		if (irlmp_get_lap_tx_queue_len(self->lsap) > LAP_MAX_QUEUE) {
-			/* Re-queue packet */
-			skb_queue_head(&self->tx_queue, skb);
-
-			/* Try later. Would be better if IrLAP could notify us */
-			irttp_start_todo_timer(self, MSECS_TO_JIFFIES(10));
-			
-			break;
-		}
-
 		/*
 		 *  Since we can transmit and receive frames concurrently, 
 		 *  the code below is a critical region and we must assure that
@@ -484,32 +725,35 @@ static void irttp_run_tx_queue(struct ts
 		 * Jean II */
 		if (skb->sk != NULL) {
 			/* IrSOCK application, IrOBEX, ... */
-			IRDA_DEBUG(4, __FUNCTION__ "() : Detaching SKB from socket.\n");
-
-			/* That's the right way to do it - Jean II */
 			skb_orphan(skb);
-		} else {
-			/* IrCOMM over IrTTP, IrLAN, ... */
-			IRDA_DEBUG(4, __FUNCTION__ "() : Got SKB not attached to a socket.\n");
 		}
+			/* IrCOMM over IrTTP, IrLAN, ... */
 
 		/* Pass the skb to IrLMP - done */
 		irlmp_data_request(self->lsap, skb);
 		self->stats.tx_packets++;
+	}
 
-		/* Check if we can accept more frames from client */
-		if ((self->tx_sdu_busy) && 
-		    (skb_queue_len(&self->tx_queue) < TTP_LOW_THRESHOLD)) 
-		{
-			self->tx_sdu_busy = FALSE;
-			
-			if (self->notify.flow_indication)
-				self->notify.flow_indication(
-					self->notify.instance, self,
-					FLOW_START);
-		}
+	/* Check if we can accept more frames from client.
+	 * We don't want to wait until the todo timer to do that, and we
+	 * can't use tasklets (grr...), so we are obliged to give control
+	 * to client. That's ok, this test will be true not too often
+	 * (max once per LAP window) and we are called from places
+	 * where we can spend a bit of time doing stuff. - Jean II */
+	if ((self->tx_sdu_busy) && 
+	    (skb_queue_len(&self->tx_queue) < TTP_TX_LOW_THRESHOLD) &&
+	    (!self->close_pend))
+	{
+		if (self->notify.flow_indication)
+			self->notify.flow_indication(self->notify.instance,
+						     self, FLOW_START);
+
+		/* self->tx_sdu_busy is the state of the client.
+		 * We don't really have a race here, but it's always safer
+		 * to update our state after the client - Jean II */
+		self->tx_sdu_busy = FALSE;
 	}
-	
+
 	/* Reset lock */
 	self->tx_queue_lock = 0;
 }
@@ -520,7 +764,7 @@ static void irttp_run_tx_queue(struct ts
  *    Send a dataless flowdata TTP-PDU and give available credit to peer
  *    TSAP
  */
-void irttp_give_credit(struct tsap_cb *self) 
+static inline void irttp_give_credit(struct tsap_cb *self) 
 {
 	struct sk_buff *tx_skb = NULL;
 	unsigned long flags;
@@ -531,7 +775,7 @@ void irttp_give_credit(struct tsap_cb *s
 
 	IRDA_DEBUG(4, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n", 
 		   self->send_credit, self->avail_credit, self->remote_credit);
-	
+
 	/* Give credit to peer */
 	tx_skb = dev_alloc_skb(64);
 	if (!tx_skb)
@@ -606,6 +850,7 @@ static int irttp_data_indication(void *i
 				 struct sk_buff *skb)
 {
 	struct tsap_cb *self;
+	unsigned long flags;
 	int n;
 
 	self = (struct tsap_cb *) instance;
@@ -614,47 +859,66 @@ static int irttp_data_indication(void *i
 
 	self->stats.rx_packets++;
 
+	/*  Deal with inbound credit
+	 *  Since we can transmit and receive frames concurrently, 
+	 *  the code below is a critical region and we must assure that
+	 *  nobody messes with the credits while we update them.
+	 */
+	spin_lock_irqsave(&self->lock, flags);
+	self->send_credit += n;
+	if (skb->len > 1)
+		self->remote_credit--;
+	spin_unlock_irqrestore(&self->lock, flags);
+
 	/* 
 	 *  Data or dataless packet? Dataless frames contains only the 
 	 *  TTP_HEADER. 
 	 */
 	if (skb->len > 1) {
-		/* Deal with inbound credit */
-		self->send_credit += n;
-		self->remote_credit--;
-		
 		/* 
 		 *  We don't remove the TTP header, since we must preserve the
 		 *  more bit, so the defragment routing knows what to do
 		 */
 		skb_queue_tail(&self->rx_queue, skb);
 	} else {
-		self->send_credit += n;	/* Dataless flowdata TTP-PDU */
+		/* Dataless flowdata TTP-PDU */
 		dev_kfree_skb(skb);
 	}
 
+
+	/* Push data to the higher layer.
+	 * We do it synchronously because running the todo timer for each
+	 * receive packet would be too much overhead and latency.
+	 * By passing control to the higher layer, we run the risk that
+	 * it may take time or grab a lock. Most often, the higher layer
+	 * will only put packet in a queue.
+	 * Anyway, packets are only dripping through the IrDA, so we can
+	 * have time before the next packet.
+	 * Further, we are run from NET_BH, so the worse that can happen is
+	 * us missing the optimal time to send back the PF bit in LAP.
+	 * Jean II */
 	irttp_run_rx_queue(self);
 
-	/* 
-	 *  Give avay some credits to peer? 
-	 */
-	if ((skb_queue_empty(&self->tx_queue)) && 
-	    (self->remote_credit < TTP_LOW_THRESHOLD) && 
-	    (self->avail_credit > 0)) 
-	{
-		/* Schedule to start immediately after this thread */
-		irttp_start_todo_timer(self, 0);
-		/*irttp_give_credit(self);*/
-	}
-	
+	/* We now give credits to peer in irttp_run_rx_queue().
+	 * We need to send credit *NOW*, otherwise we are going
+	 * to miss the next Tx window. The todo timer may take
+	 * a while before it's run... - Jean II */
+
 	/* 
 	 * If the peer device has given us some credits and we didn't have
-         * anyone from before, the we need to shedule the tx queue?  
+         * anyone from before, then we need to shedule the tx queue.
+	 * We need to do that because our Tx have stopped (so we may not
+	 * get any LAP flow indication) and the user may be stopped as
+	 * well. - Jean II
 	 */
 	if (self->send_credit == n) {
-		/*irttp_run_tx_queue(self);*/
-		irttp_start_todo_timer(self, 0);
+		/* Restart pushing stuff to LAP */
+		irttp_run_tx_queue(self);
+		/* Note : we don't want to schedule the todo timer
+		 * because it has horrible latency. No tasklets
+		 * because the tasklet API is broken. - Jean II */
 	}
+
 	return 0;
 }
 
@@ -687,6 +951,50 @@ void irttp_status_indication(void *insta
 }
 
 /*
+ * Function irttp_flow_indication (self, reason)
+ *
+ *    Flow_indication : IrLAP tells us to send more data.
+ *
+ */
+void irttp_flow_indication(void *instance, void *sap, LOCAL_FLOW flow)
+{
+	struct tsap_cb *self;
+
+	self = (struct tsap_cb *) instance;
+	
+	ASSERT(self != NULL, return;);
+	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
+	
+	IRDA_DEBUG(4, __FUNCTION__ "(instance=%p)\n", self);
+
+	/* We are "polled" directly from LAP, and the LAP want to fill
+	 * its Tx window. We want to do our best to send it data, so that
+	 * we maximise the window. On the other hand, we want to limit the
+	 * amount of work here so that LAP doesn't hang forever waiting
+	 * for packets. - Jean II */
+
+	/* Try to send some packets. Currently, LAP calls us every time
+	 * there is one free slot, so we will send only one packet.
+	 * This allow the scheduler to do its round robin - Jean II */
+	irttp_run_tx_queue(self);
+
+	/* Note regarding the interraction with higher layer.
+	 * irttp_run_tx_queue() may call the client when its queue
+	 * start to empty, via notify.flow_indication(). Initially.
+	 * I wanted this to happen in a tasklet, to avoid client
+	 * grabbing the CPU, but we can't use tasklets safely. And timer
+	 * is definitely too slow.
+	 * This will happen only once per LAP window, and usually at
+	 * the third packet (unless window is smaller). LAP is still
+	 * doing mtt and sending first packet so it's sort of OK
+	 * to do that. Jean II */
+
+	/* If we need to send disconnect. try to do it now */
+	if(self->disconnect_pend)
+		irttp_start_todo_timer(self, 0);
+}
+
+/*
  * Function irttp_flow_request (self, command)
  *
  *    This funtion could be used by the upper layers to tell IrTTP to stop
@@ -709,7 +1017,10 @@ void irttp_flow_request(struct tsap_cb *
 		IRDA_DEBUG(1, __FUNCTION__ "(), flow start\n");
 		self->rx_sdu_busy = FALSE;
 		
+		/* Client say he can accept more data, try to free our
+		 * queues ASAP - Jean II */
 		irttp_run_rx_queue(self);
+
 		break;
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown flow command!\n");
@@ -1147,10 +1458,15 @@ int irttp_disconnect_request(struct tsap
 
 			irttp_run_tx_queue(self);
 
-			irttp_start_todo_timer(self, MSECS_TO_JIFFIES(1000));
+			irttp_start_todo_timer(self, HZ/10);
 			return -1;
 		}
 	}
+	/* Note : we don't need to check if self->rx_queue is full and the
+	 * state of self->rx_sdu_busy because the disconnect response will
+	 * be sent at the LMP level (so even if the peer has its Tx queue
+	 * full of data). - Jean II */
+
 	IRDA_DEBUG(1, __FUNCTION__ "(), Disconnecting ...\n");
 	self->connected = FALSE;
 
@@ -1281,8 +1597,7 @@ void irttp_run_rx_queue(struct tsap_cb *
 	 *  Reassemble all frames in receive queue and deliver them
 	 */
 	while (!self->rx_sdu_busy && (skb = skb_dequeue(&self->rx_queue))) {
-		self->avail_credit++;
-
+		/* This bit will tell us if it's the last fragment or not */
 		more = skb->data[0] & 0x80;
 
 		/* Remove TTP header */
@@ -1293,7 +1608,7 @@ void irttp_run_rx_queue(struct tsap_cb *
 
 		/*  
 		 * If SAR is disabled, or user has requested no reassembly
-		 * of received fragements then we just deliver them
+		 * of received fragments then we just deliver them
 		 * immediately. This can be requested by clients that
 		 * implements byte streams without any message boundaries
 		 */
@@ -1353,236 +1668,46 @@ void irttp_run_rx_queue(struct tsap_cb *
 		}
 		self->rx_sdu_size = 0;
 	}
-	/* Reset lock */
-	self->rx_queue_lock = 0;
-}
-
-/*
- * Function irttp_flush_queues (self)
- *
- *     Flushes (removes all frames) in transitt-buffer (tx_list)
- */
-void irttp_flush_queues(struct tsap_cb *self)
-{
-	struct sk_buff* skb;
-	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
-	
-	/* Deallocate frames waiting to be sent */
-	while ((skb = skb_dequeue(&self->tx_queue)) != NULL)
-		dev_kfree_skb(skb);
-	
-	/* Deallocate received frames */
-	while ((skb = skb_dequeue(&self->rx_queue)) != NULL)
-		dev_kfree_skb(skb);
-	
-	/* Deallocate received fragments */
-	while ((skb = skb_dequeue(&self->rx_fragments)) != NULL)
-		dev_kfree_skb(skb);
-}
-
-/*
- * Function irttp_reasseble (self)
- *
- *    Makes a new (continuous) skb of all the fragments in the fragment
- *    queue
- *
- */
-static struct sk_buff *irttp_reassemble_skb(struct tsap_cb *self)
-{
-	struct sk_buff *skb, *frag;
-	int n = 0;  /* Fragment index */
-	
-      	ASSERT(self != NULL, return NULL;);
-	ASSERT(self->magic == TTP_TSAP_MAGIC, return NULL;);
-
-	IRDA_DEBUG(2, __FUNCTION__ "(), self->rx_sdu_size=%d\n", 
-		   self->rx_sdu_size);
-
-	skb = dev_alloc_skb(TTP_HEADER + self->rx_sdu_size);
-	if (!skb)
-		return NULL;
-
-	/* 
-	 * Need to reserve space for TTP header in case this skb needs to 
-	 * be requeued in case delivery failes
-	 */
-	skb_reserve(skb, TTP_HEADER);
-	skb_put(skb, self->rx_sdu_size);
 
 	/*
-	 *  Copy all fragments to a new buffer
+	 * It's not trivial to keep track of how many credits are available
+	 * by incrementing at each packet, because delivery may fail 
+	 * (irttp_do_data_indication() may requeue the frame) and because
+	 * we need to take care of fragmentation.
+	 * We want the other side to send up to initial_credit packets.
+	 * We have some frames in our queues, and we have already allowed it
+	 * to send remote_credit.
+	 * No need to spinlock, write is atomic and self correcting...
+	 * Jean II
 	 */
-	while ((frag = skb_dequeue(&self->rx_fragments)) != NULL) {
-		memcpy(skb->data+n, frag->data, frag->len);
-		n += frag->len;
-		
-		dev_kfree_skb(frag);
-	}
-	IRDA_DEBUG(2, __FUNCTION__ "(), frame len=%d\n", n);
-
-	IRDA_DEBUG(2, __FUNCTION__ "(), rx_sdu_size=%d\n", self->rx_sdu_size);
-	ASSERT(n <= self->rx_sdu_size, return NULL;);
-
-	/* Set the new length */
-	skb_trim(skb, n);
-
-	self->rx_sdu_size = 0;
-
-	return skb;
-}
-
-/*
- * Function irttp_fragment_skb (skb)
- *
- *    Fragments a frame and queues all the fragments for transmission
- *
- */
-static void irttp_fragment_skb(struct tsap_cb *self, struct sk_buff *skb)
-{
-	struct sk_buff *frag;
-	__u8 *frame;
-
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
-	ASSERT(skb != NULL, return;);
-
-	/*
-	 *  Split frame into a number of segments
-	 */
-	while (skb->len > self->max_seg_size) {
-		IRDA_DEBUG(2, __FUNCTION__  "(), fragmenting ...\n");
-
-		/* Make new segment */
-		frag = dev_alloc_skb(self->max_seg_size+self->max_header_size);
-		if (!frag)
-			return;
-
-		skb_reserve(frag, self->max_header_size);
-
-		/* Copy data from the original skb into this fragment. */
-		memcpy(skb_put(frag, self->max_seg_size), skb->data, 
-		       self->max_seg_size);
-
-		/* Insert TTP header, with the more bit set */
-		frame = skb_push(frag, TTP_HEADER);
-		frame[0] = TTP_MORE;
-		
-		/* Hide the copied data from the original skb */
-		skb_pull(skb, self->max_seg_size);
-
-		/* Queue fragment */
-		skb_queue_tail(&self->tx_queue, frag);
-	}
-	/* Queue what is left of the original skb */
-	IRDA_DEBUG(2, __FUNCTION__  "(), queuing last segment\n");
-	
-	frame = skb_push(skb, TTP_HEADER);
-	frame[0] = 0x00; /* Clear more bit */
-
-	/* Queue fragment */
-	skb_queue_tail(&self->tx_queue, skb);
-}
-
-/*
- * Function irttp_param_max_sdu_size (self, param)
- *
- *    Handle the MaxSduSize parameter in the connect frames, this function
- *    will be called both when this parameter needs to be inserted into, and
- *    extracted from the connect frames
- */
-static int irttp_param_max_sdu_size(void *instance, irda_param_t *param, 
-				    int get)
-{
-	struct tsap_cb *self;
-
-	self = (struct tsap_cb *) instance;
-
-	ASSERT(self != NULL, return -1;);
-	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
-
-	if (get)
-		param->pv.i = self->tx_max_sdu_size;
-	else
-		self->tx_max_sdu_size = param->pv.i;
-
-	IRDA_DEBUG(1, __FUNCTION__ "(), MaxSduSize=%d\n", param->pv.i);
-	
-	return 0;
-}
-
-/*
- * Function irttp_todo_expired (data)
- *
- *    Todo timer has expired!
- *
- */
-static void irttp_todo_expired(unsigned long data)
-{
-	struct tsap_cb *self = (struct tsap_cb *) data;
-
-	/* Check that we still exist */
-	if (!self || self->magic != TTP_TSAP_MAGIC)
-		return;
-	
-	irttp_run_rx_queue(self);
-	irttp_run_tx_queue(self);
-		
-	/*  Give avay some credits to peer?  */
-	if ((self->remote_credit < TTP_LOW_THRESHOLD) && 
-	    (self->avail_credit > 0) && (skb_queue_empty(&self->tx_queue)))
-	{
+	self->avail_credit = (self->initial_credit -
+			      (self->remote_credit +
+			       skb_queue_len(&self->rx_queue) +
+			       skb_queue_len(&self->rx_fragments)));
+
+	/* Do we have too much credits to send to peer ? */
+	if ((self->remote_credit <= TTP_RX_MIN_CREDIT) &&
+	    (self->avail_credit > 0)) {
+		/* Send explicit credit frame */
 		irttp_give_credit(self);
+		/* Note : do *NOT* check if tx_queue is non-empty, that
+		 * will produce deadlocks. I repeat : send a credit frame
+		 * even if we have something to send in our Tx queue.
+		 * If we have credits, it means that our Tx queue is blocked.
+		 *
+		 * Let's suppose the peer can't keep up with our Tx. He will
+		 * flow control us by not sending us any credits, and we
+		 * will stop Tx and start accumulating credits here.
+		 * Up to the point where the peer will stop its Tx queue,
+		 * for lack of credits.
+		 * Let's assume the peer application is single threaded.
+		 * It will block on Tx and never consume any Rx buffer.
+		 * Deadlock. Guaranteed. - Jean II
+		 */
 	}
 
-	/* Check if time for disconnect */
-	if (test_bit(0, &self->disconnect_pend)) {
-		/* Check if it's possible to disconnect yet */
-		if (skb_queue_empty(&self->tx_queue)) {
-			/* Make sure disconnect is not pending anymore */
-			clear_bit(0, &self->disconnect_pend);	/* FALSE */
-
-			/* Note : self->disconnect_skb may be NULL */
-			irttp_disconnect_request(self, self->disconnect_skb,
-						 P_NORMAL);
-			self->disconnect_skb = NULL;
-		} else {
-			/* Try again later */
-			irttp_start_todo_timer(self, 1*HZ);
-			
-			/* No reason to try and close now */
-			return;
-		}
-	}
-	
-	/* Check if it's closing time */
-	if (self->close_pend)
-		irttp_close_tsap(self);
-}
-
-/*
- * Function irttp_start_todo_timer (self, timeout)
- *
- *    Start todo timer. 
- *
- */
-static void irttp_start_todo_timer(struct tsap_cb *self, int timeout)
-{
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
-
-	del_timer(&self->todo_timer);
-	
-	self->todo_timer.data     = (unsigned long) self;
-	self->todo_timer.function = &irttp_todo_expired;
-	self->todo_timer.expires  = jiffies + timeout;
-
-	add_timer(&self->todo_timer);
+	/* Reset lock */
+	self->rx_queue_lock = 0;
 }
 
 #ifdef CONFIG_PROC_FS
