Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSFJMwY>; Mon, 10 Jun 2002 08:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFJMvD>; Mon, 10 Jun 2002 08:51:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29959 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314227AbSFJMrp>; Mon, 10 Jun 2002 08:47:45 -0400
Message-ID: <3D04922F.80000@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:49:03 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 17/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010201020800000200090708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010201020800000200090708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

irttp.c was infected too.

--------------010201020800000200090708
Content-Type: text/plain;
 name="warn-2.5.21-17.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-17.diff"

diff -urN linux-2.5.21/net/irda/irttp.c linux/net/irda/irttp.c
--- linux-2.5.21/net/irda/irttp.c	2002-06-09 07:26:53.000000000 +0200
+++ linux/net/irda/irttp.c	2002-06-09 21:03:12.000000000 +0200
@@ -89,15 +89,15 @@
 			return -ENOMEM;
 	}
 	memset(irttp, 0, sizeof(struct irttp_cb));
-	
+
 	irttp->magic = TTP_MAGIC;
 
 	irttp->tsaps = hashbin_new(HB_LOCAL);
 	if (!irttp->tsaps) {
-		ERROR(__FUNCTION__ "(), can't allocate IrTTP hashbin!\n");
+		ERROR("%s: can't allocate IrTTP hashbin!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
-	
+
 	return 0;
 }
 
@@ -108,19 +108,19 @@
  *
  */
 #ifdef MODULE
-void irttp_cleanup(void) 
+void irttp_cleanup(void)
 {
 	/* Check for main structure */
 	ASSERT(irttp != NULL, return;);
 	ASSERT(irttp->magic == TTP_MAGIC, return;);
-	
+
 	/*
 	 *  Delete hashbin and close all TSAP instances in it
 	 */
 	hashbin_delete(irttp->tsaps, (FREE_FUNC) __irttp_close_tsap);
 
 	irttp->magic = 0;
-	
+
 	/* De-allocate main structure */
 	kfree(irttp);
 
@@ -133,7 +133,7 @@
 /*
  * Function irttp_start_todo_timer (self, timeout)
  *
- *    Start todo timer. 
+ *    Start todo timer.
  *
  * Made it more effient and unsensitive to race conditions - Jean II
  */
@@ -164,7 +164,7 @@
 	/* Check that we still exist */
 	if (!self || self->magic != TTP_TSAP_MAGIC)
 		return;
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "(instance=%p)\n", self);
 
 	/* Try to make some progress, especially on Tx side - Jean II */
@@ -185,12 +185,12 @@
 		} else {
 			/* Try again later */
 			irttp_start_todo_timer(self, HZ/10);
-			
+
 			/* No reason to try and close now */
 			return;
 		}
 	}
-	
+
 	/* Check if it's closing time */
 	if (self->close_pend)
 		/* Finish cleanup */
@@ -205,20 +205,20 @@
 void irttp_flush_queues(struct tsap_cb *self)
 {
 	struct sk_buff* skb;
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
-	
+
 	/* Deallocate frames waiting to be sent */
 	while ((skb = skb_dequeue(&self->tx_queue)) != NULL)
 		dev_kfree_skb(skb);
-	
+
 	/* Deallocate received frames */
 	while ((skb = skb_dequeue(&self->rx_queue)) != NULL)
 		dev_kfree_skb(skb);
-	
+
 	/* Deallocate received fragments */
 	while ((skb = skb_dequeue(&self->rx_fragments)) != NULL)
 		dev_kfree_skb(skb);
@@ -235,19 +235,19 @@
 {
 	struct sk_buff *skb, *frag;
 	int n = 0;  /* Fragment index */
-	
-      	ASSERT(self != NULL, return NULL;);
+
+	ASSERT(self != NULL, return NULL;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return NULL;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), self->rx_sdu_size=%d\n", 
+	IRDA_DEBUG(2, __FUNCTION__ "(), self->rx_sdu_size=%d\n",
 		   self->rx_sdu_size);
 
 	skb = dev_alloc_skb(TTP_HEADER + self->rx_sdu_size);
 	if (!skb)
 		return NULL;
 
-	/* 
-	 * Need to reserve space for TTP header in case this skb needs to 
+	/*
+	 * Need to reserve space for TTP header in case this skb needs to
 	 * be requeued in case delivery failes
 	 */
 	skb_reserve(skb, TTP_HEADER);
@@ -259,7 +259,7 @@
 	while ((frag = skb_dequeue(&self->rx_fragments)) != NULL) {
 		memcpy(skb->data+n, frag->data, frag->len);
 		n += frag->len;
-		
+
 		dev_kfree_skb(frag);
 	}
 	IRDA_DEBUG(2, __FUNCTION__ "(), frame len=%d\n", n);
@@ -307,13 +307,13 @@
 		skb_reserve(frag, self->max_header_size);
 
 		/* Copy data from the original skb into this fragment. */
-		memcpy(skb_put(frag, self->max_seg_size), skb->data, 
+		memcpy(skb_put(frag, self->max_seg_size), skb->data,
 		       self->max_seg_size);
 
 		/* Insert TTP header, with the more bit set */
 		frame = skb_push(frag, TTP_HEADER);
 		frame[0] = TTP_MORE;
-		
+
 		/* Hide the copied data from the original skb */
 		skb_pull(skb, self->max_seg_size);
 
@@ -322,7 +322,7 @@
 	}
 	/* Queue what is left of the original skb */
 	IRDA_DEBUG(2, __FUNCTION__  "(), queuing last segment\n");
-	
+
 	frame = skb_push(skb, TTP_HEADER);
 	frame[0] = 0x00; /* Clear more bit */
 
@@ -337,7 +337,7 @@
  *    will be called both when this parameter needs to be inserted into, and
  *    extracted from the connect frames
  */
-static int irttp_param_max_sdu_size(void *instance, irda_param_t *param, 
+static int irttp_param_max_sdu_size(void *instance, irda_param_t *param,
 				    int get)
 {
 	struct tsap_cb *self;
@@ -353,7 +353,7 @@
 		self->tx_max_sdu_size = param->pv.i;
 
 	IRDA_DEBUG(1, __FUNCTION__ "(), MaxSduSize=%d\n", param->pv.i);
-	
+
 	return 0;
 }
 
@@ -366,7 +366,7 @@
  *
  *    Create TSAP connection endpoint,
  */
-struct tsap_cb *irttp_open_tsap(__u8 stsap_sel, int credit, notify_t *notify) 
+struct tsap_cb *irttp_open_tsap(__u8 stsap_sel, int credit, notify_t *notify)
 {
 	struct tsap_cb *self;
 	struct lsap_cb *lsap;
@@ -421,10 +421,10 @@
 	 */
 	lsap = irlmp_open_lsap(stsap_sel, &ttp_notify, 0);
 	if (lsap == NULL) {
-		WARNING(__FUNCTION__ "(), unable to allocate LSAP!!\n");
+		WARNING("%s: unable to allocate LSAP!!\n", __FUNCTION__);
 		return NULL;
 	}
-	
+
 	/*
 	 *  If user specified LSAP_ANY as source TSAP selector, then IrLMP
 	 *  will replace it with whatever source selector which is free, so
@@ -443,7 +443,7 @@
 	else
 		self->initial_credit = credit;
 
-	return self;	
+	return self;
 }
 
 /*
@@ -497,7 +497,7 @@
 	if (self->connected) {
 		/* Check if disconnect is not pending */
 		if (!test_bit(0, &self->disconnect_pend)) {
-			WARNING(__FUNCTION__ "(), TSAP still connected!\n");
+			WARNING("%s: TSAP still connected!\n", __FUNCTION__);
 			irttp_disconnect_request(self, NULL, P_NORMAL);
 		}
 		self->close_pend = TRUE;
@@ -505,7 +505,7 @@
 
 		return 0; /* Will be back! */
 	}
-	
+
 	tsap = hashbin_remove(irttp->tsaps, (int) self, NULL);
 
 	ASSERT(tsap == self, return -1;);
@@ -527,7 +527,7 @@
  *    Send unreliable data on this TSAP
  *
  */
-int irttp_udata_request(struct tsap_cb *self, struct sk_buff *skb) 
+int irttp_udata_request(struct tsap_cb *self, struct sk_buff *skb)
 {
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
@@ -540,12 +540,12 @@
 		IRDA_DEBUG(1, __FUNCTION__ "(), No data, or not connected\n");
 		return -1;
 	}
-	
+
 	if (skb->len > self->max_seg_size) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), UData is to large for IrLAP!\n");
 		return -1;
 	}
-		    
+
 	irlmp_udata_request(self->lsap, skb);
 	self->stats.tx_packets++;
 
@@ -555,10 +555,10 @@
 /*
  * Function irttp_data_request (handle, skb)
  *
- *    Queue frame for transmission. If SAR is enabled, fragement the frame 
+ *    Queue frame for transmission. If SAR is enabled, fragement the frame
  *    and queue the fragments for transmission
  */
-int irttp_data_request(struct tsap_cb *self, struct sk_buff *skb) 
+int irttp_data_request(struct tsap_cb *self, struct sk_buff *skb)
 {
 	__u8 *frame;
 
@@ -571,33 +571,33 @@
 
 	/* Check that nothing bad happens */
 	if ((skb->len == 0) || (!self->connected)) {
-		WARNING(__FUNCTION__ "(), No data, or not connected\n");
+		WARNING("%s: No data, or not connected\n", __FUNCTION__);
 		return -ENOTCONN;
 	}
 
-	/*  
+	/*
 	 *  Check if SAR is disabled, and the frame is larger than what fits
 	 *  inside an IrLAP frame
 	 */
 	if ((self->tx_max_sdu_size == 0) && (skb->len > self->max_seg_size)) {
-		ERROR(__FUNCTION__ 
-		      "(), SAR disabled, and data is to large for IrLAP!\n");
+		ERROR("%s: SAR disabled, and data is to large for IrLAP!\n",
+				__FUNCTION__);
 		return -EMSGSIZE;
 	}
 
-	/* 
-	 *  Check if SAR is enabled, and the frame is larger than the 
-	 *  TxMaxSduSize 
+	/*
+	 *  Check if SAR is enabled, and the frame is larger than the
+	 *  TxMaxSduSize
 	 */
-	if ((self->tx_max_sdu_size != 0) && 
-	    (self->tx_max_sdu_size != TTP_SAR_UNBOUND) && 
+	if ((self->tx_max_sdu_size != 0) &&
+	    (self->tx_max_sdu_size != TTP_SAR_UNBOUND) &&
 	    (skb->len > self->tx_max_sdu_size))
 	{
-		ERROR(__FUNCTION__ "(), SAR enabled, "
-		      "but data is larger than TxMaxSduSize!\n");
+		ERROR("%s: SAR enabled, but data is larger than TxMaxSduSize!\n",
+		      __FUNCTION__);
 		return -EMSGSIZE;
 	}
-	/* 
+	/*
 	 *  Check if transmit queue is full
 	 */
 	if (skb_queue_len(&self->tx_queue) >= TTP_TX_MAX_QUEUE) {
@@ -610,14 +610,14 @@
 		 * to requeue the packet in the client code - Jean II */
 		return -ENOBUFS;
 	}
-       
+
 	/* Queue frame, or queue frame segments */
 	if ((self->tx_max_sdu_size == 0) || (skb->len < self->max_seg_size)) {
 		/* Queue frame */
 		ASSERT(skb_headroom(skb) >= TTP_HEADER, return -1;);
 		frame = skb_push(skb, TTP_HEADER);
 		frame[0] = 0x00; /* Clear more bit */
-		
+
 		skb_queue_tail(&self->tx_queue, skb);
 	} else {
 		/*
@@ -630,11 +630,11 @@
 	}
 
 	/* Check if we can accept more data from client */
-	if ((!self->tx_sdu_busy) && 
+	if ((!self->tx_sdu_busy) &&
 	    (skb_queue_len(&self->tx_queue) > TTP_TX_HIGH_THRESHOLD)) {
 		/* Tx queue filling up, so stop client. */
 		if (self->notify.flow_indication) {
- 			self->notify.flow_indication(self->notify.instance, 
+			self->notify.flow_indication(self->notify.instance,
 						     self, FLOW_STOP);
 		}
 		/* self->tx_sdu_busy is the state of the client.
@@ -646,7 +646,7 @@
 		 * Jean II */
 		self->tx_sdu_busy = TRUE;
 	}
-	
+
 	/* Try to make some progress */
 	irttp_run_tx_queue(self);
 
@@ -659,7 +659,7 @@
  *    Transmit packets queued for transmission (if possible)
  *
  */
-static void irttp_run_tx_queue(struct tsap_cb *self) 
+static void irttp_run_tx_queue(struct tsap_cb *self)
 {
 	struct sk_buff *skb;
 	unsigned long flags;
@@ -680,7 +680,7 @@
 	       (skb = skb_dequeue(&self->tx_queue)))
 	{
 		/*
-		 *  Since we can transmit and receive frames concurrently, 
+		 *  Since we can transmit and receive frames concurrently,
 		 *  the code below is a critical region and we must assure that
 		 *  nobody messes with the credits while we update them.
 		 */
@@ -688,7 +688,7 @@
 
 		n = self->avail_credit;
 		self->avail_credit = 0;
-		
+
 		/* Only room for 127 credits in frame */
 		if (n > 127) {
 			self->avail_credit = n-127;
@@ -699,19 +699,19 @@
 
 		spin_unlock_irqrestore(&self->lock, flags);
 
-		/* 
-		 *  More bit must be set by the data_request() or fragment() 
+		/*
+		 *  More bit must be set by the data_request() or fragment()
 		 *  functions
 		 */
 		skb->data[0] |= (n & 0x7f);
-		
+
 		/* Detach from socket.
 		 * The current skb has a reference to the socket that sent
 		 * it (skb->sk). When we pass it to IrLMP, the skb will be
 		 * stored in in IrLAP (self->wx_list). When we are within
 		 * IrLAP, we loose the notion of socket, so we should not
 		 * have a reference to a socket. So, we drop it here.
-		 * 
+		 *
 		 * Why does it matter ?
 		 * When the skb is freed (kfree_skb), if it is associated
 		 * with a socket, it release buffer space on the socket
@@ -740,7 +740,7 @@
 	 * to client. That's ok, this test will be true not too often
 	 * (max once per LAP window) and we are called from places
 	 * where we can spend a bit of time doing stuff. - Jean II */
-	if ((self->tx_sdu_busy) && 
+	if ((self->tx_sdu_busy) &&
 	    (skb_queue_len(&self->tx_queue) < TTP_TX_LOW_THRESHOLD) &&
 	    (!self->close_pend))
 	{
@@ -764,16 +764,16 @@
  *    Send a dataless flowdata TTP-PDU and give available credit to peer
  *    TSAP
  */
-static inline void irttp_give_credit(struct tsap_cb *self) 
+static inline void irttp_give_credit(struct tsap_cb *self)
 {
 	struct sk_buff *tx_skb = NULL;
 	unsigned long flags;
 	int n;
 
 	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);	
+	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
 
-	IRDA_DEBUG(4, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n", 
+	IRDA_DEBUG(4, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n",
 		   self->send_credit, self->avail_credit, self->remote_credit);
 
 	/* Give credit to peer */
@@ -785,7 +785,7 @@
 	skb_reserve(tx_skb, self->max_header_size);
 
 	/*
-	 *  Since we can transmit and receive frames concurrently, 
+	 *  Since we can transmit and receive frames concurrently,
 	 *  the code below is a critical region and we must assure that
 	 *  nobody messes with the credits while we update them.
 	 */
@@ -793,7 +793,7 @@
 
 	n = self->avail_credit;
 	self->avail_credit = 0;
-	
+
 	/* Only space for 127 credits in frame */
 	if (n > 127) {
 		self->avail_credit = n - 127;
@@ -805,7 +805,7 @@
 
 	skb_put(tx_skb, 1);
 	tx_skb->data[0] = (__u8) (n & 0x7f);
-	
+
 	irlmp_data_request(self->lsap, tx_skb);
 	self->stats.tx_packets++;
 }
@@ -816,8 +816,8 @@
  *    Received some unit-data (unreliable)
  *
  */
-static int irttp_udata_indication(void *instance, void *sap, 
-				  struct sk_buff *skb) 
+static int irttp_udata_indication(void *instance, void *sap,
+				  struct sk_buff *skb)
 {
 	struct tsap_cb *self;
 
@@ -843,10 +843,10 @@
 /*
  * Function irttp_data_indication (instance, sap, skb)
  *
- *    Receive segment from IrLMP. 
+ *    Receive segment from IrLMP.
  *
  */
-static int irttp_data_indication(void *instance, void *sap, 
+static int irttp_data_indication(void *instance, void *sap,
 				 struct sk_buff *skb)
 {
 	struct tsap_cb *self;
@@ -860,7 +860,7 @@
 	self->stats.rx_packets++;
 
 	/*  Deal with inbound credit
-	 *  Since we can transmit and receive frames concurrently, 
+	 *  Since we can transmit and receive frames concurrently,
 	 *  the code below is a critical region and we must assure that
 	 *  nobody messes with the credits while we update them.
 	 */
@@ -870,12 +870,12 @@
 		self->remote_credit--;
 	spin_unlock_irqrestore(&self->lock, flags);
 
-	/* 
-	 *  Data or dataless packet? Dataless frames contains only the 
-	 *  TTP_HEADER. 
+	/*
+	 *  Data or dataless packet? Dataless frames contains only the
+	 *  TTP_HEADER.
 	 */
 	if (skb->len > 1) {
-		/* 
+		/*
 		 *  We don't remove the TTP header, since we must preserve the
 		 *  more bit, so the defragment routing knows what to do
 		 */
@@ -904,7 +904,7 @@
 	 * to miss the next Tx window. The todo timer may take
 	 * a while before it's run... - Jean II */
 
-	/* 
+	/*
 	 * If the peer device has given us some credits and we didn't have
          * anyone from before, then we need to shedule the tx queue.
 	 * We need to do that because our Tx have stopped (so we may not
@@ -936,15 +936,15 @@
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
 	self = (struct tsap_cb *) instance;
-	
+
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
-	
+
 	/*
 	 *  Inform service user if he has requested it
 	 */
 	if (self->notify.status_indication != NULL)
-		self->notify.status_indication(self->notify.instance, 
+		self->notify.status_indication(self->notify.instance,
 					       link, lock);
 	else
 		IRDA_DEBUG(2, __FUNCTION__ "(), no handler\n");
@@ -961,10 +961,10 @@
 	struct tsap_cb *self;
 
 	self = (struct tsap_cb *) instance;
-	
+
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "(instance=%p)\n", self);
 
 	/* We are "polled" directly from LAP, and the LAP want to fill
@@ -998,7 +998,7 @@
  * Function irttp_flow_request (self, command)
  *
  *    This funtion could be used by the upper layers to tell IrTTP to stop
- *    delivering frames if the receive queues are starting to get full, or 
+ *    delivering frames if the receive queues are starting to get full, or
  *    to tell IrTTP to start delivering frames again.
  */
 void irttp_flow_request(struct tsap_cb *self, LOCAL_FLOW flow)
@@ -1016,7 +1016,7 @@
 	case FLOW_START:
 		IRDA_DEBUG(1, __FUNCTION__ "(), flow start\n");
 		self->rx_sdu_busy = FALSE;
-		
+
 		/* Client say he can accept more data, try to free our
 		 * queues ASAP - Jean II */
 		irttp_run_rx_queue(self);
@@ -1026,42 +1026,42 @@
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown flow command!\n");
 	}
 }
-	
+
 /*
  * Function irttp_connect_request (self, dtsap_sel, daddr, qos)
  *
  *    Try to connect to remote destination TSAP selector
  *
  */
-int irttp_connect_request(struct tsap_cb *self, __u8 dtsap_sel, 
+int irttp_connect_request(struct tsap_cb *self, __u8 dtsap_sel,
 			  __u32 saddr, __u32 daddr,
-			  struct qos_info *qos, __u32 max_sdu_size, 
-			  struct sk_buff *userdata) 
+			  struct qos_info *qos, __u32 max_sdu_size,
+			  struct sk_buff *userdata)
 {
 	struct sk_buff *skb;
 	__u8 *frame;
 	__u8 n;
-	
-	IRDA_DEBUG(4, __FUNCTION__ "(), max_sdu_size=%d\n", max_sdu_size); 
-	
+
+	IRDA_DEBUG(4, __FUNCTION__ "(), max_sdu_size=%d\n", max_sdu_size);
+
 	ASSERT(self != NULL, return -EBADR;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -EBADR;);
 
 	if (self->connected)
 		return -EISCONN;
-	
+
 	/* Any userdata supplied? */
 	if (userdata == NULL) {
 		skb = dev_alloc_skb(64);
-		if (!skb) 
+		if (!skb)
 			return -ENOMEM;
-		
+
 		/* Reserve space for MUX_CONTROL and LAP header */
 		skb_reserve(skb, TTP_MAX_HEADER);
 	} else {
 		skb = userdata;
-		/*  
-		 *  Check that the client has reserved enough space for 
+		/*
+		 *  Check that the client has reserved enough space for
 		 *  headers
 		 */
 		ASSERT(skb_headroom(userdata) >= TTP_MAX_HEADER, return -1;);
@@ -1079,7 +1079,7 @@
 
 	self->remote_credit = 0;
 	self->send_credit = 0;
-	
+
 	/*
 	 *  Give away max 127 credits for now
 	 */
@@ -1092,41 +1092,41 @@
 
 	/* SAR enabled? */
 	if (max_sdu_size > 0) {
-		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER + TTP_SAR_HEADER), 
+		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER + TTP_SAR_HEADER),
 		       return -1;);
 
 		/* Insert SAR parameters */
 		frame = skb_push(skb, TTP_HEADER+TTP_SAR_HEADER);
-		
-		frame[0] = TTP_PARAMETERS | n; 
+
+		frame[0] = TTP_PARAMETERS | n;
 		frame[1] = 0x04; /* Length */
 		frame[2] = 0x01; /* MaxSduSize */
 		frame[3] = 0x02; /* Value length */
 
-		put_unaligned(cpu_to_be16((__u16) max_sdu_size), 
+		put_unaligned(cpu_to_be16((__u16) max_sdu_size),
 			      (__u16 *)(frame+4));
 	} else {
 		/* Insert plain TTP header */
 		frame = skb_push(skb, TTP_HEADER);
-		
+
 		/* Insert initial credit in frame */
 		frame[0] = n & 0x7f;
 	}
 
 	/* Connect with IrLMP. No QoS parameters for now */
-	return irlmp_connect_request(self->lsap, dtsap_sel, saddr, daddr, qos, 
+	return irlmp_connect_request(self->lsap, dtsap_sel, saddr, daddr, qos,
 				     skb);
 }
 
 /*
  * Function irttp_connect_confirm (handle, qos, skb)
  *
- *    Sevice user confirms TSAP connection with peer. 
+ *    Sevice user confirms TSAP connection with peer.
  *
  */
-static void irttp_connect_confirm(void *instance, void *sap, 
+static void irttp_connect_confirm(void *instance, void *sap,
 				  struct qos_info *qos, __u32 max_seg_size,
-				  __u8 max_header_size, struct sk_buff *skb) 
+				  __u8 max_header_size, struct sk_buff *skb)
 {
 	struct tsap_cb *self;
 	int parameters;
@@ -1135,7 +1135,7 @@
 	__u8 n;
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
+
 	self = (struct tsap_cb *) instance;
 
 	ASSERT(self != NULL, return;);
@@ -1150,21 +1150,21 @@
 	 *  negotiated QoS for the link.
 	 */
 	if (qos) {
-		IRDA_DEBUG(4, "IrTTP, Negotiated BAUD_RATE: %02x\n", 
-		       qos->baud_rate.bits);			
-		IRDA_DEBUG(4, "IrTTP, Negotiated BAUD_RATE: %d bps.\n", 
+		IRDA_DEBUG(4, "IrTTP, Negotiated BAUD_RATE: %02x\n",
+		       qos->baud_rate.bits);
+		IRDA_DEBUG(4, "IrTTP, Negotiated BAUD_RATE: %d bps.\n",
 		       qos->baud_rate.value);
 	}
 
 	n = skb->data[0] & 0x7f;
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "(), Initial send_credit=%d\n", n);
-	
+
 	self->send_credit = n;
 	self->tx_max_sdu_size = 0;
 	self->connected = TRUE;
 
-	parameters = skb->data[0] & 0x80;	
+	parameters = skb->data[0] & 0x80;
 
 	ASSERT(skb->len >= TTP_HEADER, return;);
 	skb_pull(skb, TTP_HEADER);
@@ -1173,13 +1173,13 @@
 		plen = skb->data[0];
 
 		ret = irda_param_extract_all(self, skb->data+1,
-					     IRDA_MIN(skb->len-1, plen), 
+					     IRDA_MIN(skb->len-1, plen),
 					     &param_info);
 
 		/* Any errors in the parameter list? */
 		if (ret < 0) {
-			WARNING(__FUNCTION__ 
-				"(), error extracting parameters\n");
+			WARNING("%s: error extracting parameters\n",
+					__FUNCTION__);
 			dev_kfree_skb(skb);
 
 			/* Do not accept this connection attempt */
@@ -1188,8 +1188,8 @@
 		/* Remove parameters */
 		skb_pull(skb, IRDA_MIN(skb->len, plen+1));
 	}
-	
-	IRDA_DEBUG(4, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n", 
+
+	IRDA_DEBUG(4, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n",
 	      self->send_credit, self->avail_credit, self->remote_credit);
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), MaxSduSize=%d\n", self->tx_max_sdu_size);
@@ -1208,8 +1208,8 @@
  *
  */
 void irttp_connect_indication(void *instance, void *sap, struct qos_info *qos,
-			      __u32 max_seg_size, __u8 max_header_size, 
-			      struct sk_buff *skb) 
+			      __u32 max_seg_size, __u8 max_header_size,
+			      struct sk_buff *skb)
 {
 	struct tsap_cb *self;
 	struct lsap_cb *lsap;
@@ -1222,7 +1222,7 @@
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
- 	ASSERT(skb != NULL, return;);
+	ASSERT(skb != NULL, return;);
 
 	lsap = (struct lsap_cb *) sap;
 
@@ -1238,7 +1238,7 @@
 
 	self->send_credit = n;
 	self->tx_max_sdu_size = 0;
-	
+
 	parameters = skb->data[0] & 0x80;
 
 	ASSERT(skb->len >= TTP_HEADER, return;);
@@ -1246,17 +1246,17 @@
 
 	if (parameters) {
 		plen = skb->data[0];
-		
+
 		ret = irda_param_extract_all(self, skb->data+1,
-					     IRDA_MIN(skb->len-1, plen), 
+					     IRDA_MIN(skb->len-1, plen),
 					     &param_info);
 
 		/* Any errors in the parameter list? */
 		if (ret < 0) {
-			WARNING(__FUNCTION__ 
-				"(), error extracting parameters\n");
+			WARNING("%s: error extracting parameters\n",
+					__FUNCTION__);
 			dev_kfree_skb(skb);
-			
+
 			/* Do not accept this connection attempt */
 			return;
 		}
@@ -1266,8 +1266,8 @@
 	}
 
 	if (self->notify.connect_indication) {
-		self->notify.connect_indication(self->notify.instance, self, 
-						qos, self->tx_max_sdu_size, 
+		self->notify.connect_indication(self->notify.instance, self,
+						qos, self->tx_max_sdu_size,
 						self->max_header_size, skb);
 	} else
 		dev_kfree_skb(skb);
@@ -1278,9 +1278,9 @@
  *
  *    Service user is accepting the connection, just pass it down to
  *    IrLMP!
- * 
+ *
  */
-int irttp_connect_response(struct tsap_cb *self, __u32 max_sdu_size, 
+int irttp_connect_response(struct tsap_cb *self, __u32 max_sdu_size,
 			   struct sk_buff *userdata)
 {
 	struct sk_buff *skb;
@@ -1291,9 +1291,9 @@
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), Source TSAP selector=%02x\n", 
+	IRDA_DEBUG(4, __FUNCTION__ "(), Source TSAP selector=%02x\n",
 		   self->stsap_sel);
-	
+
 	/* Any userdata supplied? */
 	if (userdata == NULL) {
 		skb = dev_alloc_skb(64);
@@ -1304,13 +1304,13 @@
 		skb_reserve(skb, TTP_MAX_HEADER);
 	} else {
 		skb = userdata;
-		/*  
-		 *  Check that the client has reserved enough space for 
+		/*
+		 *  Check that the client has reserved enough space for
 		 *  headers
 		 */
 		ASSERT(skb_headroom(skb) >= TTP_MAX_HEADER, return -1;);
 	}
-	
+
 	self->avail_credit = 0;
 	self->remote_credit = 0;
 	self->rx_max_sdu_size = max_sdu_size;
@@ -1330,30 +1330,30 @@
 
 	/* SAR enabled? */
 	if (max_sdu_size > 0) {
-		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER+TTP_SAR_HEADER), 
+		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER+TTP_SAR_HEADER),
 		       return -1;);
-		
+
 		/* Insert TTP header with SAR parameters */
 		frame = skb_push(skb, TTP_HEADER+TTP_SAR_HEADER);
-		
+
 		frame[0] = TTP_PARAMETERS | n;
 		frame[1] = 0x04; /* Length */
 
 		/* irda_param_insert(self, IRTTP_MAX_SDU_SIZE, frame+1,  */
-/* 				  TTP_SAR_HEADER, &param_info) */
-		
+/*				  TTP_SAR_HEADER, &param_info) */
+
 		frame[2] = 0x01; /* MaxSduSize */
 		frame[3] = 0x02; /* Value length */
 
-		put_unaligned(cpu_to_be16((__u16) max_sdu_size), 
+		put_unaligned(cpu_to_be16((__u16) max_sdu_size),
 			      (__u16 *)(frame+4));
 	} else {
 		/* Insert TTP header */
 		frame = skb_push(skb, TTP_HEADER);
-		
+
 		frame[0] = n & 0x7f;
 	}
-	 
+
 	ret = irlmp_connect_response(self->lsap, skb);
 
 	return ret;
@@ -1365,7 +1365,7 @@
  *    Duplicate TSAP, can be used by servers to confirm a connection on a
  *    new TSAP so it can keep listening on the old one.
  */
-struct tsap_cb *irttp_dup(struct tsap_cb *orig, void *instance) 
+struct tsap_cb *irttp_dup(struct tsap_cb *orig, void *instance)
 {
 	struct tsap_cb *new;
 
@@ -1400,11 +1400,11 @@
 /*
  * Function irttp_disconnect_request (self)
  *
- *    Close this connection please! If priority is high, the queued data 
+ *    Close this connection please! If priority is high, the queued data
  *    segments, if any, will be deallocated first
  *
  */
-int irttp_disconnect_request(struct tsap_cb *self, struct sk_buff *userdata, 
+int irttp_disconnect_request(struct tsap_cb *self, struct sk_buff *userdata,
 			     int priority)
 {
 	struct sk_buff *skb;
@@ -1441,15 +1441,15 @@
 	 */
 	if (skb_queue_len(&self->tx_queue) > 0) {
 		if (priority == P_HIGH) {
-			/* 
-			 *  No need to send the queued data, if we are 
+			/*
+			 *  No need to send the queued data, if we are
 			 *  disconnecting right now since the data will
 			 *  not have any usable connection to be sent on
 			 */
 			IRDA_DEBUG(1, __FUNCTION__  "High priority!!()\n" );
 			irttp_flush_queues(self);
 		} else if (priority == P_NORMAL) {
-			/* 
+			/*
 			 *  Must delay disconnect until after all data segments
 			 *  have been sent and the tx_queue is empty
 			 */
@@ -1474,12 +1474,12 @@
 		skb = dev_alloc_skb(64);
 		if (!skb)
 			return -ENOMEM;
-		
-		/* 
-		 *  Reserve space for MUX and LAP header 
+
+		/*
+		 *  Reserve space for MUX and LAP header
 		 */
 		skb_reserve(skb, TTP_MAX_HEADER);
-		
+
 		userdata = skb;
 	}
 	ret = irlmp_disconnect_request(self->lsap, userdata);
@@ -1496,21 +1496,21 @@
  *    Disconnect indication, TSAP disconnected by peer?
  *
  */
-void irttp_disconnect_indication(void *instance, void *sap, LM_REASON reason, 
-				 struct sk_buff *skb) 
+void irttp_disconnect_indication(void *instance, void *sap, LM_REASON reason,
+				 struct sk_buff *skb)
 {
 	struct tsap_cb *self;
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
 	self = (struct tsap_cb *) instance;
-	
+
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
-	
+
 	/* Prevent higher layer to send more data */
 	self->connected = FALSE;
-	
+
 	/* Check if client has already tried to close the TSAP */
 	if (self->close_pend) {
 		/* In this case, the higher layer is probably gone. Don't
@@ -1558,18 +1558,18 @@
 	/* Usually the layer above will notify that it's input queue is
 	 * starting to get filled by using the flow request, but this may
 	 * be difficult, so it can instead just refuse to eat it and just
-	 * give an error back 
+	 * give an error back
 	 */
 	if (err == -ENOMEM) {
 		IRDA_DEBUG(0, __FUNCTION__ "() requeueing skb!\n");
 
 		/* Make sure we take a break */
 		self->rx_sdu_busy = TRUE;
-		
+
 		/* Need to push the header in again */
 		skb_push(skb, TTP_HEADER);
 		skb->data[0] = 0x00; /* Make sure MORE bit is cleared */
-		
+
 		/* Put skb back on queue */
 		skb_queue_head(&self->rx_queue, skb);
 	}
@@ -1581,18 +1581,18 @@
  *     Check if we have any frames to be transmitted, or if we have any
  *     available credit to give away.
  */
-void irttp_run_rx_queue(struct tsap_cb *self) 
+void irttp_run_rx_queue(struct tsap_cb *self)
 {
 	struct sk_buff *skb;
 	int more = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n", 
+	IRDA_DEBUG(2, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n",
 		   self->send_credit, self->avail_credit, self->remote_credit);
 
 	/* Get exclusive access to the rx queue, otherwise don't touch it */
 	if (irda_lock(&self->rx_queue_lock) == FALSE)
 		return;
-	
+
 	/*
 	 *  Reassemble all frames in receive queue and deliver them
 	 */
@@ -1606,7 +1606,7 @@
 		/* Add the length of the remaining data */
 		self->rx_sdu_size += skb->len;
 
-		/*  
+		/*
 		 * If SAR is disabled, or user has requested no reassembly
 		 * of received fragments then we just deliver them
 		 * immediately. This can be requested by clients that
@@ -1621,8 +1621,8 @@
 
 		/* Check if this is a fragment, and not the last fragment */
 		if (more) {
-			/*  
-			 *  Queue the fragment if we still are within the 
+			/*
+			 *  Queue the fragment if we still are within the
 			 *  limits of the maximum size of the rx_sdu
 			 */
 			if (self->rx_sdu_size <= self->rx_max_sdu_size) {
@@ -1638,32 +1638,32 @@
 		 *  This is the last fragment, so time to reassemble!
 		 */
 		if ((self->rx_sdu_size <= self->rx_max_sdu_size) ||
-		    (self->rx_max_sdu_size == TTP_SAR_UNBOUND)) 
+		    (self->rx_max_sdu_size == TTP_SAR_UNBOUND))
 		{
-			/* 
+			/*
 			 * A little optimizing. Only queue the fragment if
 			 * there are other fragments. Since if this is the
 			 * last and only fragment, there is no need to
-			 * reassemble :-) 
+			 * reassemble :-)
 			 */
 			if (!skb_queue_empty(&self->rx_fragments)) {
-				skb_queue_tail(&self->rx_fragments, 
+				skb_queue_tail(&self->rx_fragments,
 					       skb);
-				
+
 				skb = irttp_reassemble_skb(self);
 			}
-			
+
 			/* Now we can deliver the reassembled skb */
 			irttp_do_data_indication(self, skb);
 		} else {
 			IRDA_DEBUG(1, __FUNCTION__ "(), Truncated frame\n");
-			
+
 			/* Free the part of the SDU that is too big */
 			dev_kfree_skb(skb);
 
 			/* Deliver only the valid but truncated part of SDU */
 			skb = irttp_reassemble_skb(self);
-			
+
 			irttp_do_data_indication(self, skb);
 		}
 		self->rx_sdu_size = 0;
@@ -1671,7 +1671,7 @@
 
 	/*
 	 * It's not trivial to keep track of how many credits are available
-	 * by incrementing at each packet, because delivery may fail 
+	 * by incrementing at each packet, because delivery may fail
 	 * (irttp_do_data_indication() may requeue the frame) and because
 	 * we need to take care of fragmentation.
 	 * We want the other side to send up to initial_credit packets.
@@ -1721,11 +1721,11 @@
 	struct tsap_cb *self;
 	unsigned long flags;
 	int i = 0;
-	
+
 	ASSERT(irttp != NULL, return 0;);
-	
+
 	len = 0;
-	
+
 	save_flags(flags);
 	cli();
 
@@ -1735,9 +1735,9 @@
 			break;
 
 		len += sprintf(buf+len, "TSAP %d, ", i++);
-		len += sprintf(buf+len, "stsap_sel: %02x, ", 
+		len += sprintf(buf+len, "stsap_sel: %02x, ",
 			       self->stsap_sel);
-		len += sprintf(buf+len, "dtsap_sel: %02x\n", 
+		len += sprintf(buf+len, "dtsap_sel: %02x\n",
 			       self->dtsap_sel);
 		len += sprintf(buf+len, "  connected: %s, ",
 			       self->connected? "TRUE":"FALSE");
@@ -1751,9 +1751,9 @@
 			       self->stats.tx_packets);
 		len += sprintf(buf+len, "rx packets: %ld, ",
 			       self->stats.rx_packets);
-		len += sprintf(buf+len, "tx_queue len: %d ", 
+		len += sprintf(buf+len, "tx_queue len: %d ",
 			       skb_queue_len(&self->tx_queue));
-		len += sprintf(buf+len, "rx_queue len: %d\n", 
+		len += sprintf(buf+len, "rx_queue len: %d\n",
 			       skb_queue_len(&self->rx_queue));
 		len += sprintf(buf+len, "  tx_sdu_busy: %s, ",
 			       self->tx_sdu_busy? "TRUE":"FALSE");
@@ -1766,11 +1766,11 @@
 		len += sprintf(buf+len, "rx_max_sdu_size: %d\n",
 			       self->rx_max_sdu_size);
 
-		len += sprintf(buf+len, "  Used by (%s)\n", 
+		len += sprintf(buf+len, "  Used by (%s)\n",
 				self->notify.name);
 
 		len += sprintf(buf+len, "\n");
-		
+
 		self = (struct tsap_cb *) hashbin_get_next(irttp->tsaps);
 	}
 	restore_flags(flags);

--------------010201020800000200090708--

