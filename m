Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129945AbRBHWFg>; Thu, 8 Feb 2001 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRBHWF2>; Thu, 8 Feb 2001 17:05:28 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:6162 "EHLO tepid.osl.fast.no")
	by vger.kernel.org with ESMTP id <S129067AbRBHWFQ>;
	Thu, 8 Feb 2001 17:05:16 -0500
Date: Thu, 8 Feb 2001 22:21:27 GMT
Message-Id: <200102082221.WAA90927@tepid.osl.fast.no>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.uit.no
From: Dag Brattli <dag@brattli.net>
Reply-To: dag@brattli.net
Subject: [patch] patch-2.4.1-irda4 (irlap speed)
X-Mailer: Pygmy (v0.4.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a patch that fixes some IrDA problems with speed 
changes in the IrLAP layer, and also a missing kfree's in all
of the IrDA device drivers. This patch is also credited 
Jean Tourrilhes. It's been tested for a month or so by
the Linux-IrDA mailing-list, and found to be working OK.

Please apply to your latest 2.4 code.

-- Dag

diff -urpN linux-2.4.1-patch/net/irda/irlap.c linux-2.4.1-irda-patch/net/irda/irlap.c
--- linux-2.4.1-patch/net/irda/irlap.c	Sun Nov 12 03:11:23 2000
+++ linux-2.4.1-irda-patch/net/irda/irlap.c	Thu Feb  8 22:34:14 2001
@@ -998,7 +998,7 @@ void irlap_init_qos_capabilities(struct 
 }
 
 /*
- * Function irlap_apply_default_connection_parameters (void)
+ * Function irlap_apply_default_connection_parameters (void, now)
  *
  *    Use the default connection and transmission parameters
  * 
@@ -1010,14 +1010,16 @@ void irlap_apply_default_connection_para
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
+	/* xbofs : Default value in NDM */
+	self->next_bofs   = 12;
+	self->bofs_count  = 12;
+
+	/* NDM Speed is 9600 */
 	irlap_change_speed(self, 9600, TRUE);
 
 	/* Set mbusy when going to NDM state */
 	irda_device_set_media_busy(self->netdev, TRUE);
 
-	/* Default value in NDM */
-	self->bofs_count = 12;
-
 	/* 
 	 * Generate random connection address for this session, which must
 	 * be 7 bits wide and different from 0x00 and 0xfe 
@@ -1056,23 +1058,31 @@ void irlap_apply_default_connection_para
 }
 
 /*
- * Function irlap_apply_connection_parameters (qos)
+ * Function irlap_apply_connection_parameters (qos, now)
  *
  *    Initialize IrLAP with the negotiated QoS values
  *
+ * If 'now' is false, the speed and xbofs will be changed after the next
+ * frame is sent.
+ * If 'now' is true, the speed and xbofs is changed immediately
  */
-void irlap_apply_connection_parameters(struct irlap_cb *self) 
+void irlap_apply_connection_parameters(struct irlap_cb *self, int now) 
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 	
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
-	irlap_change_speed(self, self->qos_tx.baud_rate.value, FALSE);
+	/* Set the negociated xbofs value */
+	self->next_bofs   = self->qos_tx.additional_bofs.value;
+	if(now)
+		self->bofs_count = self->next_bofs;
+
+	/* Set the negociated link speed (may need the new xbofs value) */
+	irlap_change_speed(self, self->qos_tx.baud_rate.value, now);
 
 	self->window_size = self->qos_tx.window_size.value;
 	self->window      = self->qos_tx.window_size.value;
-	self->bofs_count  = self->qos_tx.additional_bofs.value;
 
 	/*
 	 *  Calculate how many bytes it is possible to transmit before the
diff -urpN linux-2.4.1-patch/net/irda/irlap_event.c linux-2.4.1-irda-patch/net/irda/irlap_event.c
--- linux-2.4.1-patch/net/irda/irlap_event.c	Tue Nov 28 03:07:31 2000
+++ linux-2.4.1-irda-patch/net/irda/irlap_event.c	Thu Feb  8 22:34:14 2001
@@ -684,25 +684,26 @@ static int irlap_state_conn(struct irlap
 
 		irlap_initiate_connection_state(self);
 
-#if 0
 		/* 
-		 * We are allowed to send two frames, but this may increase
-		 * the connect latency, so lets not do it for now.
+		 * Applying the parameters now will make sure we change speed
+		 * *after* we have sent the next frame
 		 */
-		irlap_send_ua_response_frame(self, &self->qos_rx);
-#endif
+		irlap_apply_connection_parameters(self, FALSE);
 
 		/* 
-		 * Applying the parameters now will make sure we change speed
-		 * after we have sent the next frame
+		 * Sending this frame will force a speed change after it has
+		 * been sent (i.e. the frame will be sent at 9600).
 		 */
-		irlap_apply_connection_parameters(self);
+		irlap_send_ua_response_frame(self, &self->qos_rx);
 
+#if 0
 		/* 
-		 * Sending this frame will force a speed change after it has
-		 * been sent
+		 * We are allowed to send two frames, but this may increase
+		 * the connect latency, so lets not do it for now.
 		 */
+		/* What the hell is this ? - Jean II */
 		irlap_send_ua_response_frame(self, &self->qos_rx);
+#endif
 
 		/*
 		 *  The WD-timer could be set to the duration of the P-timer 
@@ -794,8 +795,9 @@ static int irlap_state_setup(struct irla
 
 			irlap_qos_negotiate(self, skb);
 			
+			/* Send UA frame and then change link settings */
+			irlap_apply_connection_parameters(self, FALSE);
 			irlap_send_ua_response_frame(self, &self->qos_rx);
-			irlap_apply_connection_parameters(self);
 
 			irlap_next_state(self, LAP_NRM_S);
 			irlap_connect_confirm(self, skb);
@@ -827,10 +829,19 @@ static int irlap_state_setup(struct irla
 
 		irlap_qos_negotiate(self, skb);
 
-		irlap_apply_connection_parameters(self);
+		/* Set the new link setting *now* (before the rr frame) */
+		irlap_apply_connection_parameters(self, TRUE);
 		self->retry_count = 0;
 		
-		/* This frame will actually force the speed change */
+		/* Wait for turnaround time to give a chance to the other
+		 * device to be ready to receive us.
+		 * Note : the time to switch speed is typically larger
+		 * than the turnaround time, but as we don't have the other
+		 * side speed switch time, that's our best guess...
+		 * Jean II */
+		irlap_wait_min_turn_around(self, &self->qos_tx);
+
+		/* This frame will actually be sent at the new speed */
 		irlap_send_rr_frame(self, CMD_FRAME);
 
 		irlap_start_final_timer(self, self->final_timeout/2);
@@ -991,7 +1002,8 @@ static int irlap_state_pclose(struct irl
 	case RECV_UA_RSP: /* FALLTHROUGH */
 	case RECV_DM_RSP:
 		del_timer(&self->final_timer);
-		
+
+		/* Set new link parameters */
 		irlap_apply_default_connection_parameters(self);
 
 		/* Always switch state before calling upper layers */
@@ -1944,10 +1956,13 @@ static int irlap_state_nrm_s(struct irla
 		/* Always switch state before calling upper layers */
 		irlap_next_state(self, LAP_NDM);
 
+		/* Send disconnect response */
 		irlap_wait_min_turn_around(self, &self->qos_tx);
 		irlap_send_ua_response_frame(self, NULL);
+
 		del_timer(&self->wd_timer);
 		irlap_flush_all_queues(self);
+		/* Set default link parameters */
 		irlap_apply_default_connection_parameters(self);
 
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
@@ -2000,10 +2015,13 @@ static int irlap_state_sclose(struct irl
 	case RECV_DISC_CMD:
 		/* Always switch state before calling upper layers */
 		irlap_next_state(self, LAP_NDM);
-		
+
+		/* Send disconnect response */
 		irlap_wait_min_turn_around(self, &self->qos_tx);
 		irlap_send_ua_response_frame(self, NULL);
+
 		del_timer(&self->wd_timer);
+		/* Set default link parameters */
 		irlap_apply_default_connection_parameters(self);
 
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
diff -urpN linux-2.4.1-patch/net/irda/irlap_frame.c linux-2.4.1-irda-patch/net/irda/irlap_frame.c
--- linux-2.4.1-patch/net/irda/irlap_frame.c	Sun Nov 12 03:11:23 2000
+++ linux-2.4.1-irda-patch/net/irda/irlap_frame.c	Thu Feb  8 22:34:07 2001
@@ -60,7 +60,7 @@ static inline void irlap_insert_info(str
 	 */
 	cb->magic = LAP_MAGIC;
 	cb->mtt = self->mtt_required;
-	cb->speed = self->speed;
+	cb->next_speed = self->speed;
 
 	/* Reset */
 	self->mtt_required = 0;
@@ -70,10 +70,13 @@ static inline void irlap_insert_info(str
 	 * force the negotiated minimum turnaround time 
 	 */
 	cb->xbofs = self->bofs_count;
+	cb->next_xbofs = self->next_bofs;
 	cb->xbofs_delay = self->xbofs_delay;
 	
 	/* Reset XBOF's delay (used only for getting min turn time) */
 	self->xbofs_delay = 0;
+	/* Put the correct xbofs value for the next packet */
+	self->bofs_count = self->next_bofs;
 }
 
 /*
diff -urpN linux-2.4.1-patch/net/irda/irttp.c linux-2.4.1-irda-patch/net/irda/irttp.c
--- linux-2.4.1-patch/net/irda/irttp.c	Sun Nov 12 03:11:23 2000
+++ linux-2.4.1-irda-patch/net/irda/irttp.c	Thu Feb  8 22:34:07 2001
@@ -139,6 +139,15 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 	ASSERT(irttp != NULL, return NULL;);
 	ASSERT(irttp->magic == TTP_MAGIC, return NULL;);
 
+	/* The IrLMP spec (IrLMP 1.1 p10) says that we have the right to
+	 * use only 0x01-0x6F. Of course, we can use LSAP_ANY as well.
+	 * JeanII */
+	if((stsap_sel != LSAP_ANY) &&
+	   ((stsap_sel < 0x01) || (stsap_sel >= 0x70))) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), invalid tsap!\n");
+		return NULL;
+	}
+
 	self = kmalloc(sizeof(struct tsap_cb), GFP_ATOMIC);
 	if (self == NULL) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), unable to kmalloc!\n");
@@ -1564,9 +1573,9 @@ int irttp_proc_read(char *buf, char **st
 			       self->remote_credit);
 		len += sprintf(buf+len, "send credit: %d\n",
 			       self->send_credit);
-		len += sprintf(buf+len, "  tx packets: %d, ",
+		len += sprintf(buf+len, "  tx packets: %ld, ",
 			       self->stats.tx_packets);
-		len += sprintf(buf+len, "rx packets: %d, ",
+		len += sprintf(buf+len, "rx packets: %ld, ",
 			       self->stats.rx_packets);
 		len += sprintf(buf+len, "tx_queue len: %d ", 
 			       skb_queue_len(&self->tx_queue));
diff -urpN linux-2.4.1-patch/include/net/irda/irda.h linux-2.4.1-irda-patch/include/net/irda/irda.h
--- linux-2.4.1-patch/include/net/irda/irda.h	Tue Jan 30 08:25:32 2001
+++ linux-2.4.1-irda-patch/include/net/irda/irda.h	Thu Feb  8 22:34:07 2001
@@ -177,9 +177,10 @@ typedef union {
  */
 struct irda_skb_cb {
 	magic_t magic;       /* Be sure that we can trust the information */
-	__u32   speed;       /* The Speed this frame should be sent with */
+	__u32   next_speed;  /* The Speed to be set *after* this frame */
 	__u16   mtt;         /* Minimum turn around time */
 	__u16   xbofs;       /* Number of xbofs required, used by SIR mode */
+	__u16   next_xbofs;  /* Number of xbofs required *after* this frame */
 	void    *context;    /* May be used by drivers */
 	void    (*destructor)(struct sk_buff *skb); /* Used for flow control */
 	__u16   xbofs_delay; /* Number of xbofs used for generating the mtt */
diff -urpN linux-2.4.1-patch/include/net/irda/irda_device.h linux-2.4.1-irda-patch/include/net/irda/irda_device.h
--- linux-2.4.1-patch/include/net/irda/irda_device.h	Tue Jan 30 08:24:54 2001
+++ linux-2.4.1-irda-patch/include/net/irda/irda_device.h	Thu Feb  8 22:34:07 2001
@@ -218,29 +218,54 @@ extern inline __u16 irda_get_mtt(struct 
 #endif
 
 /*
- * Function irda_get_speed (skb)
+ * Function irda_get_next_speed (skb)
  *
- *    Extact the speed this frame should be sent out with from the skb
+ *    Extract the speed that should be set *after* this frame from the skb
  *
+ * Note : return -1 for user space frames
  */
-#define irda_get_speed(skb) (	                                        \
+#define irda_get_next_speed(skb) (	                                        \
 	(((struct irda_skb_cb*) skb->cb)->magic == LAP_MAGIC) ? 	\
-                  ((struct irda_skb_cb *)(skb->cb))->speed : 9600 	\
+                  ((struct irda_skb_cb *)(skb->cb))->next_speed : -1 	\
 )
 
 #if 0
-extern inline __u32 irda_get_speed(struct sk_buff *skb)
+extern inline __u32 irda_get_next_speed(struct sk_buff *skb)
 {
 	__u32 speed;
 
 	if (((struct irda_skb_cb *)(skb->cb))->magic != LAP_MAGIC)
-		speed = 9600;
+		speed = -1;
 	else
-		speed = ((struct irda_skb_cb *)(skb->cb))->speed;
+		speed = ((struct irda_skb_cb *)(skb->cb))->next_speed;
 
 	return speed;
 }
 #endif
+
+/*
+ * Function irda_get_next_xbofs (skb)
+ *
+ *    Extract the xbofs that should be set for this frame from the skb
+ *
+ * Note : default to 10 for user space frames
+ */
+#define irda_get_xbofs(skb) (	                                        \
+	(((struct irda_skb_cb*) skb->cb)->magic == LAP_MAGIC) ? 	\
+                  ((struct irda_skb_cb *)(skb->cb))->xbofs : 10 	\
+)
+
+/*
+ * Function irda_get_next_xbofs (skb)
+ *
+ *    Extract the xbofs that should be set *after* this frame from the skb
+ *
+ * Note : return -1 for user space frames
+ */
+#define irda_get_next_xbofs(skb) (	                                        \
+	(((struct irda_skb_cb*) skb->cb)->magic == LAP_MAGIC) ? 	\
+                  ((struct irda_skb_cb *)(skb->cb))->next_xbofs : -1 	\
+)
 
 #endif /* IRDA_DEVICE_H */
 
diff -urpN linux-2.4.1-patch/include/net/irda/irlap.h linux-2.4.1-irda-patch/include/net/irda/irlap.h
--- linux-2.4.1-patch/include/net/irda/irlap.h	Tue Jan 30 08:24:54 2001
+++ linux-2.4.1-irda-patch/include/net/irda/irlap.h	Thu Feb  8 22:34:14 2001
@@ -168,7 +168,7 @@ struct irlap_cb {
 	hashbin_t   *discovery_log;
  	discovery_t *discovery_cmd;
 
-	__u32 speed; 
+	__u32 speed;		/* Link speed */
 
 	struct qos_info  qos_tx;   /* QoS requested by peer */
 	struct qos_info  qos_rx;   /* QoS requested by self */
@@ -179,6 +179,7 @@ struct irlap_cb {
 	int    mtt_required;  /* Minumum turnaround time required */
 	int    xbofs_delay;   /* Nr of XBOF's used to MTT */
 	int    bofs_count;    /* Negotiated extra BOFs */
+	int    next_bofs;     /* Negotiated extra BOFs after next frame */
 
 #ifdef CONFIG_IRDA_COMPRESSION
 	struct irda_compressor compressor;
@@ -237,7 +238,7 @@ void irlap_wait_min_turn_around(struct i
 
 void irlap_init_qos_capabilities(struct irlap_cb *, struct qos_info *);
 void irlap_apply_default_connection_parameters(struct irlap_cb *self);
-void irlap_apply_connection_parameters(struct irlap_cb *self);
+void irlap_apply_connection_parameters(struct irlap_cb *self, int now);
 void irlap_set_local_busy(struct irlap_cb *self, int status);
 
 #define IRLAP_GET_HEADER_SIZE(self) 2 /* Will be different when we get VFIR */
diff -urpN linux-2.4.1-patch/include/net/irda/irlap_frame.h linux-2.4.1-irda-patch/include/net/irda/irlap_frame.h
--- linux-2.4.1-patch/include/net/irda/irlap_frame.h	Tue Jan 30 08:24:54 2001
+++ linux-2.4.1-irda-patch/include/net/irda/irlap_frame.h	Thu Feb  8 22:34:07 2001
@@ -110,6 +110,7 @@ struct snrm_frame {
 	__u8  ncaddr;
 } PACK;
 
+void irlap_queue_xmit(struct irlap_cb *self, struct sk_buff *skb);
 void irlap_send_discovery_xid_frame(struct irlap_cb *, int S, __u8 s, 
 				    __u8 command, discovery_t *discovery);
 void irlap_send_snrm_frame(struct irlap_cb *, struct qos_info *);
diff -urpN linux-2.4.1-patch/drivers/net/irda/irport.c linux-2.4.1-irda-patch/drivers/net/irda/irport.c
--- linux-2.4.1-patch/drivers/net/irda/irport.c	Mon Nov 13 05:43:07 2000
+++ linux-2.4.1-irda-patch/drivers/net/irda/irport.c	Thu Feb  8 22:34:07 2001
@@ -616,7 +616,7 @@ int irport_hard_xmit(struct sk_buff *skb
 	struct irport_cb *self;
 	unsigned long flags;
 	int iobase;
-	__u32 speed;
+	__s32 speed;
 
 	ASSERT(dev != NULL, return 0;);
 	
@@ -628,12 +628,14 @@ int irport_hard_xmit(struct sk_buff *skb
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			irda_task_execute(self, __irport_change_speed, 
 					  irport_change_speed_complete, 
 					  NULL, (void *) speed);
+			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
diff -urpN linux-2.4.1-patch/drivers/net/irda/irtty.c linux-2.4.1-irda-patch/drivers/net/irda/irtty.c
--- linux-2.4.1-patch/drivers/net/irda/irtty.c	Thu Feb  8 22:33:50 2001
+++ linux-2.4.1-irda-patch/drivers/net/irda/irtty.c	Thu Feb  8 22:34:07 2001
@@ -629,7 +629,7 @@ static int irtty_hard_xmit(struct sk_buf
 {
 	struct irtty_cb *self;
 	int actual = 0;
-	__u32 speed;
+	__s32 speed;
 
 	self = (struct irtty_cb *) dev->priv;
 	ASSERT(self != NULL, return 0;);
@@ -638,12 +638,14 @@ static int irtty_hard_xmit(struct sk_buf
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			irda_task_execute(self, irtty_change_speed, 
 					  irtty_change_speed_complete, 
 					  NULL, (void *) speed);
+			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
diff -urpN linux-2.4.1-patch/drivers/net/irda/nsc-ircc.c linux-2.4.1-irda-patch/drivers/net/irda/nsc-ircc.c
--- linux-2.4.1-patch/drivers/net/irda/nsc-ircc.c	Tue Nov 28 03:07:31 2000
+++ linux-2.4.1-irda-patch/drivers/net/irda/nsc-ircc.c	Thu Feb  8 22:34:07 2001
@@ -1064,7 +1064,7 @@ static int nsc_ircc_hard_xmit_sir(struct
 	struct nsc_ircc_cb *self;
 	unsigned long flags;
 	int iobase;
-	__u32 speed;
+	__s32 speed;
 	__u8 bank;
 	
 	self = (struct nsc_ircc_cb *) dev->priv;
@@ -1076,10 +1076,12 @@ static int nsc_ircc_hard_xmit_sir(struct
 	netif_stop_queue(dev);
 		
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			nsc_ircc_change_speed(self, speed); 
+			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
@@ -1116,7 +1118,7 @@ static int nsc_ircc_hard_xmit_fir(struct
 	struct nsc_ircc_cb *self;
 	unsigned long flags;
 	int iobase;
-	__u32 speed;
+	__s32 speed;
 	__u8 bank;
 	int mtt, diff;
 	
@@ -1126,10 +1128,12 @@ static int nsc_ircc_hard_xmit_fir(struct
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			nsc_ircc_change_speed(self, speed); 
+			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
diff -urpN linux-2.4.1-patch/drivers/net/irda/smc-ircc.c linux-2.4.1-irda-patch/drivers/net/irda/smc-ircc.c
--- linux-2.4.1-patch/drivers/net/irda/smc-ircc.c	Fri Dec 29 23:07:22 2000
+++ linux-2.4.1-irda-patch/drivers/net/irda/smc-ircc.c	Thu Feb  8 22:34:07 2001
@@ -606,7 +606,7 @@ static int ircc_hard_xmit(struct sk_buff
 	struct irport_cb *irport;
 	struct ircc_cb *self;
 	unsigned long flags;
-	__u32 speed;
+	__s32 speed;
 	int iobase;
 	int mtt;
 
@@ -619,10 +619,12 @@ static int ircc_hard_xmit(struct sk_buff
 	netif_stop_queue(dev);
 
 	/* Check if we need to change the speed after this frame */
-	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			ircc_change_speed(self, speed); 
+			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
diff -urpN linux-2.4.1-patch/drivers/net/irda/toshoboe.c linux-2.4.1-irda-patch/drivers/net/irda/toshoboe.c
--- linux-2.4.1-patch/drivers/net/irda/toshoboe.c	Thu Jan  4 21:50:12 2001
+++ linux-2.4.1-irda-patch/drivers/net/irda/toshoboe.c	Thu Feb  8 22:34:07 2001
@@ -263,7 +263,7 @@ static int
 toshoboe_hard_xmit (struct sk_buff *skb, struct net_device *dev)
 {
   struct toshoboe_cb *self;
-  __u32 speed;
+  __s32 speed;
   int mtt, len;
 
   self = (struct toshoboe_cb *) dev->priv;
@@ -272,10 +272,12 @@ toshoboe_hard_xmit (struct sk_buff *skb,
     );
 
   /* Check if we need to change the speed */
-  if ((speed = irda_get_speed(skb)) != self->io.speed) {
+  speed = irda_get_next_speed(skb);
+  if ((speed != self->io.speed) && (speed != -1)) {
 	/* Check for empty frame */
 	if (!skb->len) {
 	    toshoboe_setbaud(self, speed); 
+	    dev_kfree_skb(skb);
 	    return 0;
 	} else
 	    self->new_speed = speed;
diff -urpN linux-2.4.1-patch/drivers/net/irda/w83977af_ir.c linux-2.4.1-irda-patch/drivers/net/irda/w83977af_ir.c
--- linux-2.4.1-patch/drivers/net/irda/w83977af_ir.c	Sun Nov 12 03:11:23 2000
+++ linux-2.4.1-irda-patch/drivers/net/irda/w83977af_ir.c	Thu Feb  8 22:34:07 2001
@@ -497,7 +497,7 @@ void w83977af_change_speed(struct w83977
 int w83977af_hard_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct w83977af_ir *self;
-	__u32 speed;
+	__s32 speed;
 	int iobase;
 	__u8 set;
 	int mtt;
@@ -513,10 +513,12 @@ int w83977af_hard_xmit(struct sk_buff *s
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+	speed = irda_get_next_speed(skb);
+	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			w83977af_change_speed(self, speed); 
+			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
