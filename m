Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKKVij>; Sat, 11 Nov 2000 16:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKKVi2>; Sat, 11 Nov 2000 16:38:28 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:59913 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129094AbQKKViQ>; Sat, 11 Nov 2000 16:38:16 -0500
Date: Sat, 11 Nov 2000 21:39:16 GMT
Message-Id: <200011112139.VAA32779@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda21 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda21 (was: Re: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda21.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda21.diff :
-----------------
	o [CORRECT] Replace ASSERT with proper test (non DEBUG compiles)
	o [CORRECT] Increase BOFs value and handle xbofs_delay as delay
	o [FEATURE] Cleanups
	o [OUPS   ] Broken init of self->N1 (disable case)

diff -urpN old-linux/include/net/irda/irda.h linux/include/net/irda/irda.h
--- old-linux/include/net/irda/irda.h	Thu Nov  9 17:52:56 2000
+++ linux/include/net/irda/irda.h	Thu Nov  9 17:59:48 2000
@@ -176,12 +176,14 @@ typedef union {
  * (must not exceed 48 bytes, check with struct sk_buff) 
  */
 struct irda_skb_cb {
-	magic_t magic;     /* Be sure that we can trust the information */
-	__u32   speed;     /* The Speed this frame should be sent with */
-	__u16     mtt;     /* Minimum turn around time */
-	int     xbofs;     /* Number of xbofs required, used by SIR mode */
-	__u8     line;     /* Used by IrCOMM in IrLPT mode */
-	void (*destructor)(struct sk_buff *skb); /* Used for flow control */
+	magic_t magic;       /* Be sure that we can trust the information */
+	__u32   speed;       /* The Speed this frame should be sent with */
+	__u16   mtt;         /* Minimum turn around time */
+	__u16   xbofs;       /* Number of xbofs required, used by SIR mode */
+	void    *context;    /* May be used by drivers */
+	void    (*destructor)(struct sk_buff *skb); /* Used for flow control */
+	__u16   xbofs_delay; /* Number of xbofs used for generating the mtt */
+	__u8    line;        /* Used by IrCOMM in IrLPT mode */
 };
 
 /* Misc status information */
diff -urpN old-linux/include/net/irda/irlmp.h linux/include/net/irda/irlmp.h
--- old-linux/include/net/irda/irlmp.h	Thu Nov  9 17:52:56 2000
+++ linux/include/net/irda/irlmp.h	Thu Nov  9 17:59:48 2000
@@ -252,9 +252,12 @@ static inline hashbin_t *irlmp_get_cache
 
 static inline int irlmp_get_lap_tx_queue_len(struct lsap_cb *self)
 {
-	ASSERT(self != NULL, return 0;);
-	ASSERT(self->lap != NULL, return 0;);
-	ASSERT(self->lap->irlap != NULL, return 0;);
+	if (self == NULL)
+		return 0;
+	if (self->lap == NULL)
+		return 0;
+	if (self->lap->irlap == NULL)
+		return 0;
 
 	return IRLAP_GET_TX_QUEUE_LEN(self->lap->irlap);
 }
diff -urpN old-linux/include/net/irda/qos.h linux/include/net/irda/qos.h
--- old-linux/include/net/irda/qos.h	Thu Nov  9 17:52:56 2000
+++ linux/include/net/irda/qos.h	Thu Nov  9 17:59:48 2000
@@ -107,7 +107,3 @@ void irda_qos_bits_to_value(struct qos_i
 
 #endif
 
-
-
-
-
diff -urpN old-linux/net/irda/irlan/irlan_client.c linux/net/irda/irlan/irlan_client.c
--- old-linux/net/irda/irlan/irlan_client.c	Thu Nov  9 17:32:39 2000
+++ linux/net/irda/irlan/irlan_client.c	Thu Nov  9 17:59:48 2000
@@ -159,7 +159,7 @@ void irlan_client_discovery_indication(d
 
 	/* Find instance */
 	self = (struct irlan_cb *) hashbin_get_first(irlan);
-    if (self) {
+	if (self) {
 		ASSERT(self->magic == IRLAN_MAGIC, return;);
 
 		IRDA_DEBUG(1, __FUNCTION__ "(), Found instance (%08x)!\n",
diff -urpN old-linux/net/irda/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- old-linux/net/irda/irlan/irlan_common.c	Thu Nov  9 17:41:49 2000
+++ linux/net/irda/irlan/irlan_common.c	Thu Nov  9 17:59:48 2000
@@ -122,6 +122,7 @@ int __init irlan_init(void)
 	struct irlan_cb *new;
 	__u16 hints;
 
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 	/* Allocate master structure */
 	irlan = hashbin_new(HB_LOCAL); 
 	if (irlan == NULL) {
@@ -136,7 +137,7 @@ int __init irlan_init(void)
 	hints = irlmp_service_to_hint(S_LAN);
 
 	/* Register with IrLMP as a client */
-	ckey = irlmp_register_client(hints, irlan_client_discovery_indication,
+	ckey = irlmp_register_client(hints, &irlan_client_discovery_indication,
 				     NULL, NULL);
 	
 	/* Register with IrLMP as a service */
diff -urpN old-linux/net/irda/irlap.c linux/net/irda/irlap.c
--- old-linux/net/irda/irlap.c	Thu Nov  9 17:52:56 2000
+++ linux/net/irda/irlap.c	Thu Nov  9 17:59:48 2000
@@ -1011,7 +1011,7 @@ void irlap_apply_default_connection_para
 	irda_device_set_media_busy(self->netdev, TRUE);
 
 	/* Default value in NDM */
-	self->bofs_count = 11;
+	self->bofs_count = 12;
 
 	/* 
 	 * Generate random connection address for this session, which must
@@ -1039,8 +1039,8 @@ void irlap_apply_default_connection_para
 	self->qos_rx.data_size.value = 64;
 	self->qos_tx.window_size.value = 1;
 	self->qos_rx.window_size.value = 1;
-	self->qos_tx.additional_bofs.value = 11;
-	self->qos_rx.additional_bofs.value = 11;
+	self->qos_tx.additional_bofs.value = 12;
+	self->qos_rx.additional_bofs.value = 12;
 	self->qos_tx.link_disc_time.value = 0;
 	self->qos_rx.link_disc_time.value = 0;
 
@@ -1084,11 +1084,12 @@ void irlap_apply_connection_parameters(s
 	 */
 	ASSERT(self->qos_tx.max_turn_time.value != 0, return;);
 	if (self->qos_tx.link_disc_time.value == 3)
-		/*self->N1 = 0;*/
-		/* If we set N1 to 0, it will trigger immediately, which is
-		 * *not* what we want. What we really want is to disable it,
-		 * so we set it to -10 ;-) Jean II */
-		self->N1 = -10;
+		/* 
+		 * If we set N1 to 0, it will trigger immediately, which is
+		 * not what we want. What we really want is to disable it,
+		 * Jean II 
+		 */
+		self->N1 = -1; /* Disable */
 	else
 		self->N1 = 3000 / self->qos_tx.max_turn_time.value;
 	
diff -urpN old-linux/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- old-linux/net/irda/irlap_event.c	Thu Nov  9 17:54:58 2000
+++ linux/net/irda/irlap_event.c	Thu Nov  9 17:59:48 2000
@@ -1921,7 +1921,6 @@ static int irlap_state_nrm_s(struct irla
 			
 			/* Always switch state before calling upper layers */
 			irlap_next_state(self, LAP_NDM);
-
 			irlap_disconnect_indication(self, LAP_NO_RESPONSE);
 		}
 		break;
diff -urpN old-linux/net/irda/irlap_frame.c linux/net/irda/irlap_frame.c
--- old-linux/net/irda/irlap_frame.c	Thu Nov  9 17:11:25 2000
+++ linux/net/irda/irlap_frame.c	Thu Nov  9 17:59:48 2000
@@ -69,7 +69,8 @@ static inline void irlap_insert_info(str
 	 * Delay equals negotiated BOFs count, plus the number of BOFs to 
 	 * force the negotiated minimum turnaround time 
 	 */
-	cb->xbofs = self->bofs_count+self->xbofs_delay;
+	cb->xbofs = self->bofs_count;
+	cb->xbofs_delay = self->xbofs_delay;
 	
 	/* Reset XBOF's delay (used only for getting min turn time) */
 	self->xbofs_delay = 0;
diff -urpN old-linux/net/irda/qos.c linux/net/irda/qos.c
--- old-linux/net/irda/qos.c	Thu Nov  9 17:52:56 2000
+++ linux/net/irda/qos.c	Thu Nov  9 17:59:48 2000
@@ -184,7 +184,7 @@ void irda_init_max_qos_capabilies(struct
 	sysctl_max_inactive_time = index_value(i, link_disc_times);
 
 	/* LSB is first byte, MSB is second byte */
-	qos->baud_rate.bits    &= 0x01ff;	/* Mask out 16 Mb/s ??? */
+	qos->baud_rate.bits    &= 0x03ff;
 
 	qos->window_size.bits     = 0x7f;
 	qos->min_turn_time.bits   = 0xff;
@@ -633,7 +633,6 @@ int msb_index (__u16 word) 
 		msb >>=1;
 		index--;
 	}
-	
 	return index;
 }
 
diff -urpN old-linux/net/irda/wrapper.c linux/net/irda/wrapper.c
--- old-linux/net/irda/wrapper.c	Thu Nov  9 12:00:52 2000
+++ linux/net/irda/wrapper.c	Thu Nov  9 17:59:48 2000
@@ -69,6 +69,7 @@ static void (*state[])(struct net_device
  */
 int async_wrap_skb(struct sk_buff *skb, __u8 *tx_buff, int buffsize)
 {
+	struct irda_skb_cb *cb = (struct irda_skb_cb *) skb->cb;
 	int xbofs;
  	int i;
 	int n;
@@ -85,7 +86,8 @@ int async_wrap_skb(struct sk_buff *skb, 
 	 *  Send  XBOF's for required min. turn time and for the negotiated
 	 *  additional XBOFS
 	 */
-	if (((struct irda_skb_cb *)(skb->cb))->magic != LAP_MAGIC) {
+	
+	if (cb->magic != LAP_MAGIC) {
 		/* 
 		 * This will happen for all frames sent from user-space.
 		 * Nothing to worry about, but we set the default number of 
@@ -94,7 +96,7 @@ int async_wrap_skb(struct sk_buff *skb, 
 		IRDA_DEBUG(1, __FUNCTION__ "(), wrong magic in skb!\n");
 		xbofs = 10;
 	} else
-		xbofs = ((struct irda_skb_cb *)(skb->cb))->xbofs;
+		xbofs = cb->xbofs + cb->xbofs_delay;
 
 	IRDA_DEBUG(4, __FUNCTION__ "(), xbofs=%d\n", xbofs);
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
