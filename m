Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTEMWJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTEMWJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:09:38 -0400
Received: from palrel10.hp.com ([156.153.255.245]:23760 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263617AbTEMWH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:07:27 -0400
Date: Tue, 13 May 2003 15:20:12 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] IrDA skb leak fixes
Message-ID: <20030513222012.GB2634@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir259_skb_get-7.diff :
		<Inspired by patches from Jan Kiszka>
	o [CORRECT] Fix skb leaks in IrDA state machines
	o [CORRECT] Fix skb leaks in connect/request error paths
	o [FEATURE] Fix skb leaks in ASSERT
	o [FEATURE] Simplify & document skb handling throughout the stack
	o [FEATURE] other minor cleanups


diff -u -p -r linux/include/net/irda.d9/iriap.h linux/include/net/irda/iriap.h
--- linux/include/net/irda.d9/iriap.h	Mon Mar 24 14:00:13 2003
+++ linux/include/net/irda/iriap.h	Mon May 12 16:53:17 2003
@@ -66,7 +66,7 @@ struct iriap_cb {
 	__u32        daddr;
 	__u8         operation;
 
-	struct sk_buff *skb;
+	struct sk_buff *request_skb;
 	struct lsap_cb *lsap;
 	__u8 slsap_sel;
 
diff -u -p -r linux/include/net/irda.d9/irlmp_event.h linux/include/net/irda/irlmp_event.h
--- linux/include/net/irda.d9/irlmp_event.h	Mon Mar 24 14:01:53 2003
+++ linux/include/net/irda/irlmp_event.h	Mon May 12 16:53:17 2003
@@ -79,26 +79,6 @@ typedef enum {
 	LM_LAP_IDLE_TIMEOUT,
 } IRLMP_EVENT;
 
-/*
- *  Information which is used by the current thread, when executing in the
- *  state machine.
- */
-struct irlmp_event {
-	IRLMP_EVENT *event;
-	struct sk_buff *skb;
-
-	__u8 hint;
-	__u32 daddr;
-	__u32 saddr;
-
-	__u8 slsap;
-	__u8 dlsap;
-
-	int reason;
-
-	struct discovery_t *discovery;
-};
-
 extern const char *irlmp_state[];
 extern const char *irlsap_state[];
 
diff -u -p -r linux/net/irda.d9/af_irda.c linux/net/irda/af_irda.c
--- linux/net/irda.d9/af_irda.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/af_irda.c	Mon May 12 16:53:17 2003
@@ -11,7 +11,7 @@
  * Sources:       af_netroom.c, af_ax25.c, af_rose.c, af_x25.c etc.
  *
  *     Copyright (c) 1999 Dag Brattli <dagb@cs.uit.no>
- *     Copyright (c) 1999-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 1999-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     All Rights Reserved.
  *
  *     This program is free software; you can redistribute it and/or
@@ -190,6 +190,9 @@ static void irda_connect_confirm(void *i
 	if (sk == NULL)
 		return;
 
+	dev_kfree_skb(skb);
+	// Should be ??? skb_queue_tail(&sk->receive_queue, skb);
+
 	/* How much header space do we need to reserve */
 	self->max_header_size = max_header_size;
 
@@ -220,8 +223,6 @@ static void irda_connect_confirm(void *i
 		   self->max_data_size);
 
 	memcpy(&self->qos_tx, qos, sizeof(struct qos_info));
-	dev_kfree_skb(skb);
-	// Should be ??? skb_queue_tail(&sk->receive_queue, skb);
 
 	/* We are now connected! */
 	sk->state = TCP_ESTABLISHED;
@@ -260,6 +261,7 @@ static void irda_connect_indication(void
 	case SOCK_STREAM:
 		if (max_sdu_size != 0) {
 			ERROR("%s: max_sdu_size must be 0\n", __FUNCTION__);
+			kfree_skb(skb);
 			return;
 		}
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
@@ -267,6 +269,7 @@ static void irda_connect_indication(void
 	case SOCK_SEQPACKET:
 		if (max_sdu_size == 0) {
 			ERROR("%s: max_sdu_size cannot be 0\n", __FUNCTION__);
+			kfree_skb(skb);
 			return;
 		}
 		self->max_data_size = max_sdu_size;
@@ -359,7 +362,7 @@ static void irda_flow_indication(void *i
  * doesn't touch the dtsap_sel and save the full value structure...
  */
 static void irda_getvalue_confirm(int result, __u16 obj_id,
-					  struct ias_value *value, void *priv)
+				  struct ias_value *value, void *priv)
 {
 	struct irda_sock *self;
 
@@ -908,6 +911,7 @@ static int irda_accept(struct socket *so
 	new->tsap = irttp_dup(self->tsap, new);
 	if (!new->tsap) {
 		IRDA_DEBUG(0, "%s(), dup failed!\n", __FUNCTION__);
+		kfree_skb(skb);
 		return -1;
 	}
 
@@ -926,6 +930,7 @@ static int irda_accept(struct socket *so
 	/* Clean up the original one to keep it in listen state */
 	irttp_listen(self->tsap);
 
+	/* Wow ! What is that ? Jean II */
 	skb->sk = NULL;
 	skb->destructor = NULL;
 	kfree_skb(skb);
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_core.c linux/net/irda/ircomm/ircomm_core.c
--- linux/net/irda.d9/ircomm/ircomm_core.c	Mon Mar 24 13:59:52 2003
+++ linux/net/irda/ircomm/ircomm_core.c	Mon May 12 16:53:17 2003
@@ -10,6 +10,7 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -251,7 +252,6 @@ void ircomm_connect_indication(struct ir
 						info->max_header_size, skb);
 	else {
 		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__ );
-		dev_kfree_skb(skb);
 	}
 }
 
@@ -295,7 +295,6 @@ void ircomm_connect_confirm(struct ircom
 					     info->max_header_size, skb);
 	else {
 		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__ );
-		dev_kfree_skb(skb);
 	}
 }
 
@@ -338,7 +337,6 @@ void ircomm_data_indication(struct ircom
 		self->notify.data_indication(self->notify.instance, self, skb);
 	else {
 		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__ );
-		dev_kfree_skb(skb);
 	}
 }
 
@@ -370,9 +368,8 @@ void ircomm_process_data(struct ircomm_c
 	if (skb->len)
 		ircomm_data_indication(self, skb);		
 	else {
-		IRDA_DEBUG(4, 
-			   "%s(), data was control info only!\n", __FUNCTION__ );
-		dev_kfree_skb(skb);
+		IRDA_DEBUG(4, "%s(), data was control info only!\n",
+			   __FUNCTION__ );
 	}
 }
 
@@ -408,24 +405,28 @@ EXPORT_SYMBOL(ircomm_control_request);
 static void ircomm_control_indication(struct ircomm_cb *self, 
 				      struct sk_buff *skb, int clen)
 {
-	struct sk_buff *ctrl_skb;
-
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );	
 
-	ctrl_skb = skb_clone(skb, GFP_ATOMIC);
-	if (!ctrl_skb)
-		return;
+	/* Use udata for delivering data on the control channel */
+	if (self->notify.udata_indication) {
+		struct sk_buff *ctrl_skb;
+
+		/* We don't own the skb, so clone it */
+		ctrl_skb = skb_clone(skb, GFP_ATOMIC);
+		if (!ctrl_skb)
+			return;
 
-	/* Remove data channel from control channel */
-	skb_trim(ctrl_skb, clen+1);
+		/* Remove data channel from control channel */
+		skb_trim(ctrl_skb, clen+1);
 	
-	/* Use udata for delivering data on the control channel */
-	if (self->notify.udata_indication)
 		self->notify.udata_indication(self->notify.instance, self, 
 					      ctrl_skb);
-	else {
+
+		/* Drop reference count -
+		 * see ircomm_tty_control_indication(). */
+		dev_kfree_skb(ctrl_skb);
+	} else {
 		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__ );
-		dev_kfree_skb(skb);
 	}
 }
 
@@ -470,7 +471,6 @@ void ircomm_disconnect_indication(struct
 						   info->reason, skb);
 	} else {
 		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__ );
-		dev_kfree_skb(skb);
 	}
 }
 
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_event.c linux/net/irda/ircomm/ircomm_event.c
--- linux/net/irda.d9/ircomm/ircomm_event.c	Mon Mar 24 14:00:15 2003
+++ linux/net/irda/ircomm/ircomm_event.c	Mon May 12 16:53:17 2003
@@ -109,9 +109,7 @@ static int ircomm_state_idle(struct irco
 	default:
 		IRDA_DEBUG(4, "%s(), unknown event: %s\n", __FUNCTION__ ,
 			   ircomm_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 	return ret;
 }
@@ -141,8 +139,6 @@ static int ircomm_state_waiti(struct irc
 	default:
 		IRDA_DEBUG(0, "%s(), unknown event: %s\n", __FUNCTION__ ,
 			   ircomm_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 		ret = -EINVAL;
 	}
 	return ret;
@@ -176,8 +172,6 @@ static int ircomm_state_waitr(struct irc
 	default:
 		IRDA_DEBUG(0, "%s(), unknown event = %s\n", __FUNCTION__ ,
 			   ircomm_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 		ret = -EINVAL;
 	}
 	return ret;
@@ -220,8 +214,6 @@ static int ircomm_state_conn(struct irco
 	default:
 		IRDA_DEBUG(0, "%s(), unknown event = %s\n", __FUNCTION__ ,
 			   ircomm_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 		ret = -EINVAL;
 	}
 	return ret;
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_lmp.c linux/net/irda/ircomm/ircomm_lmp.c
--- linux/net/irda.d9/ircomm/ircomm_lmp.c	Mon Mar 24 13:59:55 2003
+++ linux/net/irda/ircomm/ircomm_lmp.c	Mon May 12 16:53:17 2003
@@ -11,6 +11,7 @@
  * Sources:       Previous IrLPT work by Thomas Davis
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -93,6 +94,10 @@ int ircomm_lmp_connect_request(struct ir
 
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
 
+	/* Don't forget to refcount it - should be NULL anyway */
+	if(userdata)
+		skb_get(userdata);
+
 	ret = irlmp_connect_request(self->lsap, info->dlsap_sel,
 				    info->saddr, info->daddr, NULL, userdata); 
 	return ret;
@@ -106,29 +111,32 @@ int ircomm_lmp_connect_request(struct ir
  */
 int ircomm_lmp_connect_response(struct ircomm_cb *self, struct sk_buff *userdata)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	int ret;
 
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
 	
 	/* Any userdata supplied? */
 	if (userdata == NULL) {
-		skb = dev_alloc_skb(64);
-		if (!skb)
+		tx_skb = dev_alloc_skb(64);
+		if (!tx_skb)
 			return -ENOMEM;
 
 		/* Reserve space for MUX and LAP header */
-		skb_reserve(skb, LMP_MAX_HEADER);
+		skb_reserve(tx_skb, LMP_MAX_HEADER);
 	} else {
-		skb = userdata;
 		/*  
 		 *  Check that the client has reserved enough space for 
 		 *  headers
 		 */
-		ASSERT(skb_headroom(skb) >= LMP_MAX_HEADER, return -1;);
+		ASSERT(skb_headroom(userdata) >= LMP_MAX_HEADER, return -1;);
+
+		/* Don't forget to refcount it - should be NULL anyway */
+		skb_get(userdata);
+		tx_skb = userdata;
 	}
 
-	ret = irlmp_connect_response(self->lsap, skb);
+	ret = irlmp_connect_response(self->lsap, tx_skb);
 
 	return 0;
 }
@@ -137,20 +145,24 @@ int ircomm_lmp_disconnect_request(struct
 				  struct sk_buff *userdata, 
 				  struct ircomm_info *info)
 {
-        struct sk_buff *skb;
+        struct sk_buff *tx_skb;
 	int ret;
 
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
 
         if (!userdata) {
-                skb = dev_alloc_skb(64);
-		if (!skb)
+		tx_skb = dev_alloc_skb(64);
+		if (!tx_skb)
 			return -ENOMEM;
 		
 		/*  Reserve space for MUX and LAP header */
-		skb_reserve(skb, LMP_MAX_HEADER);		
-		userdata = skb;
+		skb_reserve(tx_skb, LMP_MAX_HEADER);		
+		userdata = tx_skb;
+	} else {
+		/* Don't forget to refcount it - should be NULL anyway */
+		skb_get(userdata);
 	}
+
 	ret = irlmp_disconnect_request(self->lsap, userdata);
 
 	return ret;
@@ -217,8 +229,11 @@ int ircomm_lmp_data_request(struct ircom
 
 	IRDA_DEBUG(4, "%s(), sending frame\n", __FUNCTION__ );
 
+	/* Don't forget to refcount it - see ircomm_tty_do_softint() */
+	skb_get(skb);
+
 	skb->destructor = ircomm_lmp_flow_control;
-	
+
         if ((self->pkt_count++ > 7) && (self->flow_status == FLOW_START)) {
 		IRDA_DEBUG(2, "%s(), asking TTY to slow down!\n", __FUNCTION__ );
 	        self->flow_status = FLOW_STOP;
@@ -229,7 +244,7 @@ int ircomm_lmp_data_request(struct ircom
 	ret = irlmp_data_request(self->lsap, skb);
 	if (ret) {
 		ERROR("%s(), failed\n", __FUNCTION__);
-		dev_kfree_skb(skb);
+		/* irlmp_data_request already free the packet */
 	}
 
 	return ret;
@@ -254,6 +269,9 @@ int ircomm_lmp_data_indication(void *ins
 	
 	ircomm_do_event(self, IRCOMM_LMP_DATA_INDICATION, skb, NULL);
 
+	/* Drop reference count - see ircomm_tty_data_indication(). */
+	dev_kfree_skb(skb);
+
 	return 0;
 }
 
@@ -285,6 +303,9 @@ void ircomm_lmp_connect_confirm(void *in
 	info.qos = qos;
 
 	ircomm_do_event(self, IRCOMM_LMP_CONNECT_CONFIRM, skb, &info);
+
+	/* Drop reference count - see ircomm_tty_connect_confirm(). */
+	dev_kfree_skb(skb);
 }
 
 /*
@@ -315,6 +336,9 @@ void ircomm_lmp_connect_indication(void 
 	info.qos = qos;
 
 	ircomm_do_event(self, IRCOMM_LMP_CONNECT_INDICATION, skb, &info);
+
+	/* Drop reference count - see ircomm_tty_connect_indication(). */
+	dev_kfree_skb(skb);
 }
 
 /*
@@ -338,4 +362,8 @@ void ircomm_lmp_disconnect_indication(vo
 	info.reason = reason;
 
 	ircomm_do_event(self, IRCOMM_LMP_DISCONNECT_INDICATION, skb, &info);
+
+	/* Drop reference count - see ircomm_tty_disconnect_indication(). */
+	if(skb)
+		dev_kfree_skb(skb);
 }
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_ttp.c linux/net/irda/ircomm/ircomm_ttp.c
--- linux/net/irda.d9/ircomm/ircomm_ttp.c	Mon Mar 24 14:01:43 2003
+++ linux/net/irda/ircomm/ircomm_ttp.c	Mon May 12 16:53:17 2003
@@ -10,6 +10,7 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -94,9 +95,14 @@ int ircomm_ttp_connect_request(struct ir
 
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__ );
 
+	/* Don't forget to refcount it - should be NULL anyway */
+	if(userdata)
+		skb_get(userdata);
+
 	ret = irttp_connect_request(self->tsap, info->dlsap_sel,
 				    info->saddr, info->daddr, NULL, 
 				    TTP_SAR_DISABLE, userdata); 
+
 	return ret;
 }	
 
@@ -106,13 +112,18 @@ int ircomm_ttp_connect_request(struct ir
  *    
  *
  */
-int ircomm_ttp_connect_response(struct ircomm_cb *self, struct sk_buff *skb)
+int ircomm_ttp_connect_response(struct ircomm_cb *self,
+				struct sk_buff *userdata)
 {
 	int ret;
 
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__ );
 	
-	ret = irttp_connect_response(self->tsap, TTP_SAR_DISABLE, skb);
+	/* Don't forget to refcount it - should be NULL anyway */
+	if(userdata)
+		skb_get(userdata);
+
+	ret = irttp_connect_response(self->tsap, TTP_SAR_DISABLE, userdata);
 
 	return ret;
 }
@@ -126,7 +137,8 @@ int ircomm_ttp_connect_response(struct i
  *    some of them are sent after connection establishment, so this can 
  *    increase the latency a bit.
  */
-int ircomm_ttp_data_request(struct ircomm_cb *self, struct sk_buff *skb, 
+int ircomm_ttp_data_request(struct ircomm_cb *self,
+			    struct sk_buff *skb, 
 			    int clen)
 {
 	int ret;
@@ -140,6 +152,10 @@ int ircomm_ttp_data_request(struct ircom
 	 * only frames, to make things easier and avoid queueing
 	 */
 	ASSERT(skb_headroom(skb) >= IRCOMM_HEADER_SIZE, return -1;);
+
+	/* Don't forget to refcount it - see ircomm_tty_do_softint() */
+	skb_get(skb);
+
 	skb_push(skb, IRCOMM_HEADER_SIZE);
 
 	skb->data[0] = clen;
@@ -147,7 +163,7 @@ int ircomm_ttp_data_request(struct ircom
 	ret = irttp_data_request(self->tsap, skb);
 	if (ret) {
 		ERROR("%s(), failed\n", __FUNCTION__);
-		dev_kfree_skb(skb);
+		/* irttp_data_request already free the packet */
 	}
 
 	return ret;
@@ -172,6 +188,9 @@ int ircomm_ttp_data_indication(void *ins
 
 	ircomm_do_event(self, IRCOMM_TTP_DATA_INDICATION, skb, NULL);
 
+	/* Drop reference count - see ircomm_tty_data_indication(). */
+	dev_kfree_skb(skb);
+
 	return 0;
 }
 
@@ -189,12 +208,11 @@ void ircomm_ttp_connect_confirm(void *in
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
 	ASSERT(skb != NULL, return;);
-	ASSERT(qos != NULL, return;);
+	ASSERT(qos != NULL, goto out;);
 
 	if (max_sdu_size != TTP_SAR_DISABLE) {
 		ERROR("%s(), SAR not allowed for IrCOMM!\n", __FUNCTION__);
-		dev_kfree_skb(skb);
-		return;
+		goto out;
 	}
 
 	info.max_data_size = irttp_get_max_seg_size(self->tsap)
@@ -203,6 +221,10 @@ void ircomm_ttp_connect_confirm(void *in
 	info.qos = qos;
 
 	ircomm_do_event(self, IRCOMM_TTP_CONNECT_CONFIRM, skb, &info);
+
+out:
+	/* Drop reference count - see ircomm_tty_connect_confirm(). */
+	dev_kfree_skb(skb);
 }
 
 /*
@@ -226,12 +248,11 @@ void ircomm_ttp_connect_indication(void 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
 	ASSERT(skb != NULL, return;);
-	ASSERT(qos != NULL, return;);
+	ASSERT(qos != NULL, goto out;);
 
 	if (max_sdu_size != TTP_SAR_DISABLE) {
 		ERROR("%s(), SAR not allowed for IrCOMM!\n", __FUNCTION__);
-		dev_kfree_skb(skb);
-		return;
+		goto out;
 	}
 
 	info.max_data_size = irttp_get_max_seg_size(self->tsap)
@@ -240,6 +261,10 @@ void ircomm_ttp_connect_indication(void 
 	info.qos = qos;
 
 	ircomm_do_event(self, IRCOMM_TTP_CONNECT_INDICATION, skb, &info);
+
+out:
+	/* Drop reference count - see ircomm_tty_connect_indication(). */
+	dev_kfree_skb(skb);
 }
 
 /*
@@ -254,6 +279,10 @@ int ircomm_ttp_disconnect_request(struct
 {
 	int ret;
 
+	/* Don't forget to refcount it - should be NULL anyway */
+	if(userdata)
+		skb_get(userdata);
+
 	ret = irttp_disconnect_request(self->tsap, userdata, P_NORMAL);
 
 	return ret;
@@ -280,6 +309,10 @@ void ircomm_ttp_disconnect_indication(vo
 	info.reason = reason;
 
 	ircomm_do_event(self, IRCOMM_TTP_DISCONNECT_INDICATION, skb, &info);
+
+	/* Drop reference count - see ircomm_tty_disconnect_indication(). */
+	if(skb)
+		dev_kfree_skb(skb);
 }
 
 /*
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda.d9/ircomm/ircomm_tty.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/ircomm/ircomm_tty.c	Mon May 12 16:53:17 2003
@@ -11,6 +11,7 @@
  * Sources:       serial.c and previous IrCOMM work by Takahide Higuchi
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -663,8 +664,12 @@ static void ircomm_tty_do_softint(void *
 	spin_unlock_irqrestore(&self->spinlock, flags);
 
 	/* Flush control buffer if any */
-	if (ctrl_skb && self->flow == FLOW_START)
-		ircomm_control_request(self->ircomm, ctrl_skb);
+	if(ctrl_skb) {
+		if(self->flow == FLOW_START)
+			ircomm_control_request(self->ircomm, ctrl_skb);
+		/* Drop reference count - see ircomm_ttp_data_request(). */
+		dev_kfree_skb(ctrl_skb);
+	}
 
 	if (tty->hw_stopped)
 		return;
@@ -678,8 +683,11 @@ static void ircomm_tty_do_softint(void *
 	spin_unlock_irqrestore(&self->spinlock, flags);
 
 	/* Flush transmit buffer if any */
-	if (skb)
+	if (skb) {
 		ircomm_tty_do_event(self, IRCOMM_TTY_DATA_REQUEST, skb, NULL);
+		/* Drop reference count - see ircomm_ttp_data_request(). */
+		dev_kfree_skb(skb);
+	}
 		
 	/* Check if user (still) wants to be waken up */
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && 
@@ -1179,7 +1187,6 @@ static int ircomm_tty_data_indication(vo
 
 	if (!self->tty) {
 		IRDA_DEBUG(0, "%s(), no tty!\n", __FUNCTION__ );
-		dev_kfree_skb(skb);
 		return 0;
 	}
 
@@ -1204,7 +1211,8 @@ static int ircomm_tty_data_indication(vo
 	 * handler
 	 */
 	self->tty->ldisc.receive_buf(self->tty, skb->data, NULL, skb->len);
-	dev_kfree_skb(skb);
+
+	/* No need to kfree_skb - see ircomm_ttp_data_indication() */
 
 	return 0;
 }
@@ -1231,7 +1239,8 @@ static int ircomm_tty_control_indication
 
 	irda_param_extract_all(self, skb->data+1, IRDA_MIN(skb->len-1, clen), 
 			       &ircomm_param_info);
-	dev_kfree_skb(skb);
+
+	/* No need to kfree_skb - see ircomm_control_indication() */
 
 	return 0;
 }
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- linux/net/irda.d9/ircomm/ircomm_tty_attach.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Mon May 12 16:53:17 2003
@@ -10,6 +10,7 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -236,8 +237,9 @@ static void ircomm_tty_ias_register(stru
 		irias_insert_object(self->obj);
 	}
 	self->skey = irlmp_register_service(hints);
-	self->ckey = irlmp_register_client(
-		hints, ircomm_tty_discovery_indication, NULL, (void *) self);
+	self->ckey = irlmp_register_client(hints,
+					   ircomm_tty_discovery_indication,
+					   NULL, (void *) self);
 }
 
 /*
@@ -459,7 +461,7 @@ void ircomm_tty_connect_confirm(void *in
 
 	ircomm_tty_do_event(self, IRCOMM_TTY_CONNECT_CONFIRM, NULL, NULL);
 
-	dev_kfree_skb(skb);
+	/* No need to kfree_skb - see ircomm_ttp_connect_confirm() */
 }
 
 /*
@@ -496,7 +498,7 @@ void ircomm_tty_connect_indication(void 
 
 	ircomm_tty_do_event(self, IRCOMM_TTY_CONNECT_INDICATION, NULL, NULL);
 
-	dev_kfree_skb(skb);
+	/* No need to kfree_skb - see ircomm_ttp_connect_indication() */
 }
 
 /*
@@ -647,7 +649,7 @@ static int ircomm_tty_state_idle(struct 
 	default:
 		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__ ,
 			   ircomm_tty_event[event]);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 	return ret;
 }
@@ -718,7 +720,7 @@ static int ircomm_tty_state_search(struc
 	default:
 		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__ ,
 			   ircomm_tty_event[event]);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 	return ret;
 }
@@ -774,7 +776,7 @@ static int ircomm_tty_state_query_parame
 	default:
 		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__ ,
 			   ircomm_tty_event[event]);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 	return ret;
 }
@@ -822,7 +824,7 @@ static int ircomm_tty_state_query_lsap_s
 	default:
 		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__ ,
 			   ircomm_tty_event[event]);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 	return ret;
 }
@@ -874,7 +876,7 @@ static int ircomm_tty_state_setup(struct
 	default:
 		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__ ,
 			   ircomm_tty_event[event]);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 	return ret;
 }
@@ -917,7 +919,7 @@ static int ircomm_tty_state_ready(struct
 	default:
 		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__ ,
 			   ircomm_tty_event[event]);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 	return ret;
 }
diff -u -p -r linux/net/irda.d9/iriap.c linux/net/irda/iriap.c
--- linux/net/irda.d9/iriap.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/iriap.c	Mon May 12 16:54:48 2003
@@ -11,7 +11,7 @@
  *
  *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
@@ -210,8 +210,8 @@ static void __iriap_close(struct iriap_c
 
 	del_timer(&self->watchdog_timer);
 
-	if (self->skb)
-		dev_kfree_skb(self->skb);
+	if (self->request_skb)
+		dev_kfree_skb(self->request_skb);
 
 	self->magic = 0;
 
@@ -278,7 +278,7 @@ static int iriap_register_lsap(struct ir
  */
 static void iriap_disconnect_indication(void *instance, void *sap,
 					LM_REASON reason,
-					struct sk_buff *userdata)
+					struct sk_buff *skb)
 {
 	struct iriap_cb *self;
 
@@ -293,6 +293,10 @@ static void iriap_disconnect_indication(
 
 	del_timer(&self->watchdog_timer);
 
+	/* Not needed */
+	if (skb)
+		dev_kfree_skb(skb);
+
 	if (self->mode == IAS_CLIENT) {
 		IRDA_DEBUG(4, "%s(), disconnect as client\n", __FUNCTION__);
 
@@ -312,9 +316,6 @@ static void iriap_disconnect_indication(
 				      NULL);
 		iriap_close(self);
 	}
-
-	if (userdata)
-		dev_kfree_skb(userdata);
 }
 
 /*
@@ -322,15 +323,15 @@ static void iriap_disconnect_indication(
  */
 void iriap_disconnect_request(struct iriap_cb *self)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
 
-	skb = dev_alloc_skb(64);
-	if (skb == NULL) {
+	tx_skb = dev_alloc_skb(64);
+	if (tx_skb == NULL) {
 		IRDA_DEBUG(0, "%s(), Could not allocate an sk_buff of length %d\n", 
 			__FUNCTION__, 64);
 		return;
@@ -339,9 +340,9 @@ void iriap_disconnect_request(struct iri
 	/*
 	 *  Reserve space for MUX control and LAP header
 	 */
-	skb_reserve(skb, LMP_MAX_HEADER);
+	skb_reserve(tx_skb, LMP_MAX_HEADER);
 
-	irlmp_disconnect_request(self->lsap, skb);
+	irlmp_disconnect_request(self->lsap, tx_skb);
 }
 
 void iriap_getinfobasedetails_request(void)
@@ -379,7 +380,7 @@ int iriap_getvaluebyclass_request(struct
 				  __u32 saddr, __u32 daddr,
 				  char *name, char *attr)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	int name_len, attr_len, skb_len;
 	__u8 *frame;
 
@@ -405,14 +406,14 @@ int iriap_getvaluebyclass_request(struct
 	attr_len = strlen(attr);	/* Up to IAS_MAX_ATTRIBNAME = 60 */
 
 	skb_len = self->max_header_size+2+name_len+1+attr_len+4;
-	skb = dev_alloc_skb(skb_len);
-	if (!skb)
+	tx_skb = dev_alloc_skb(skb_len);
+	if (!tx_skb)
 		return -ENOMEM;
 
 	/* Reserve space for MUX and LAP header */
-	skb_reserve(skb, self->max_header_size);
-	skb_put(skb, 3+name_len+attr_len);
-	frame = skb->data;
+	skb_reserve(tx_skb, self->max_header_size);
+	skb_put(tx_skb, 3+name_len+attr_len);
+	frame = tx_skb->data;
 
 	/* Build frame */
 	frame[0] = IAP_LST | GET_VALUE_BY_CLASS;
@@ -421,7 +422,10 @@ int iriap_getvaluebyclass_request(struct
 	frame[2+name_len] = attr_len;              /* Insert length of attr */
 	memcpy(frame+3+name_len, attr, attr_len);  /* Insert attr */
 
-	iriap_do_client_event(self, IAP_CALL_REQUEST_GVBC, skb);
+	iriap_do_client_event(self, IAP_CALL_REQUEST_GVBC, tx_skb);
+
+	/* Drop reference count - see state_s_disconnect(). */
+	dev_kfree_skb(tx_skb);
 
 	return 0;
 }
@@ -495,7 +499,6 @@ void iriap_getvaluebyclass_confirm(struc
 
 			/* Aborting, close connection! */
 			iriap_disconnect_request(self);
-			dev_kfree_skb(skb);
 			return;
 			/* break; */
 		}
@@ -533,7 +536,6 @@ void iriap_getvaluebyclass_confirm(struc
 		IRDA_DEBUG(0, "%s(), missing handler!\n", __FUNCTION__);
 		irias_delete_value(value);
 	}
-	dev_kfree_skb(skb);
 }
 
 /*
@@ -545,7 +547,7 @@ void iriap_getvaluebyclass_confirm(struc
 void iriap_getvaluebyclass_response(struct iriap_cb *self, __u16 obj_id,
 				    __u8 ret_code, struct ias_value *value)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	int n;
 	__u32 tmp_be32, tmp_be16;
 	__u8 *fp;
@@ -565,15 +567,15 @@ void iriap_getvaluebyclass_response(stru
 	 *  value. We add 32 bytes because of the 6 bytes for the frame and
 	 *  max 5 bytes for the value coding.
 	 */
-	skb = dev_alloc_skb(value->len + self->max_header_size + 32);
-	if (!skb)
+	tx_skb = dev_alloc_skb(value->len + self->max_header_size + 32);
+	if (!tx_skb)
 		return;
 
 	/* Reserve space for MUX and LAP header */
-	skb_reserve(skb, self->max_header_size);
-	skb_put(skb, 6);
+	skb_reserve(tx_skb, self->max_header_size);
+	skb_put(tx_skb, 6);
 
-	fp = skb->data;
+	fp = tx_skb->data;
 
 	/* Build frame */
 	fp[n++] = GET_VALUE_BY_CLASS | IAP_LST;
@@ -589,21 +591,21 @@ void iriap_getvaluebyclass_response(stru
 
 	switch (value->type) {
 	case IAS_STRING:
-		skb_put(skb, 3 + value->len);
+		skb_put(tx_skb, 3 + value->len);
 		fp[n++] = value->type;
 		fp[n++] = 0; /* ASCII */
 		fp[n++] = (__u8) value->len;
 		memcpy(fp+n, value->t.string, value->len); n+=value->len;
 		break;
 	case IAS_INTEGER:
-		skb_put(skb, 5);
+		skb_put(tx_skb, 5);
 		fp[n++] = value->type;
 
 		tmp_be32 = cpu_to_be32(value->t.integer);
 		memcpy(fp+n, &tmp_be32, 4); n += 4;
 		break;
 	case IAS_OCT_SEQ:
-		skb_put(skb, 3 + value->len);
+		skb_put(tx_skb, 3 + value->len);
 		fp[n++] = value->type;
 
 		tmp_be16 = cpu_to_be16(value->len);
@@ -612,14 +614,17 @@ void iriap_getvaluebyclass_response(stru
 		break;
 	case IAS_MISSING:
 		IRDA_DEBUG( 3, "%s: sending IAS_MISSING\n", __FUNCTION__);
-		skb_put(skb, 1);
+		skb_put(tx_skb, 1);
 		fp[n++] = value->type;
 		break;
 	default:
 		IRDA_DEBUG(0, "%s(), type not implemented!\n", __FUNCTION__);
 		break;
 	}
-	iriap_do_r_connect_event(self, IAP_CALL_RESPONSE, skb);
+	iriap_do_r_connect_event(self, IAP_CALL_RESPONSE, tx_skb);
+
+	/* Drop reference count - see state_r_execute(). */
+	dev_kfree_skb(tx_skb);
 }
 
 /*
@@ -657,9 +662,6 @@ void iriap_getvaluebyclass_indication(st
 	memcpy(attr, fp+n, attr_len); n+=attr_len;
 	attr[attr_len] = '\0';
 
-	/* We do not need the buffer anymore */
-	dev_kfree_skb(skb);
-
 	IRDA_DEBUG(4, "LM-IAS: Looking up %s: %s\n", name, attr);
 	obj = irias_find_object(name);
 
@@ -694,7 +696,7 @@ void iriap_getvaluebyclass_indication(st
  */
 void iriap_send_ack(struct iriap_cb *self)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	__u8 *frame;
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
@@ -702,19 +704,19 @@ void iriap_send_ack(struct iriap_cb *sel
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
 
-	skb = dev_alloc_skb(64);
-	if (!skb)
+	tx_skb = dev_alloc_skb(64);
+	if (!tx_skb)
 		return;
 
 	/* Reserve space for MUX and LAP header */
-	skb_reserve(skb, self->max_header_size);
-	skb_put(skb, 1);
-	frame = skb->data;
+	skb_reserve(tx_skb, self->max_header_size);
+	skb_put(tx_skb, 1);
+	frame = tx_skb->data;
 
 	/* Build frame */
 	frame[0] = IAP_LST | IAP_ACK | self->operation;
 
-	irlmp_data_request(self->lsap, skb);
+	irlmp_data_request(self->lsap, tx_skb);
 }
 
 void iriap_connect_request(struct iriap_cb *self)
@@ -742,7 +744,7 @@ void iriap_connect_request(struct iriap_
 static void iriap_connect_confirm(void *instance, void *sap,
 				  struct qos_info *qos, __u32 max_seg_size,
 				  __u8 max_header_size,
-				  struct sk_buff *userdata)
+				  struct sk_buff *skb)
 {
 	struct iriap_cb *self;
 
@@ -750,14 +752,17 @@ static void iriap_connect_confirm(void *
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
-	ASSERT(userdata != NULL, return;);
+	ASSERT(skb != NULL, return;);
 
 	self->max_data_size = max_seg_size;
 	self->max_header_size = max_header_size;
 
 	del_timer(&self->watchdog_timer);
 
-	iriap_do_client_event(self, IAP_LM_CONNECT_CONFIRM, userdata);
+	iriap_do_client_event(self, IAP_LM_CONNECT_CONFIRM, skb);
+
+	/* Drop reference count - see state_s_make_call(). */
+	dev_kfree_skb(skb);
 }
 
 /*
@@ -769,7 +774,7 @@ static void iriap_connect_confirm(void *
 static void iriap_connect_indication(void *instance, void *sap,
 				     struct qos_info *qos, __u32 max_seg_size,
 				     __u8 max_header_size,
-				     struct sk_buff *userdata)
+				     struct sk_buff *skb)
 {
 	struct iriap_cb *self, *new;
 
@@ -777,22 +782,22 @@ static void iriap_connect_indication(voi
 
 	self = (struct iriap_cb *) instance;
 
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == IAS_MAGIC, return;);
+	ASSERT(skb != NULL, return;);
+	ASSERT(self != NULL, goto out;);
+	ASSERT(self->magic == IAS_MAGIC, goto out;);
 
 	/* Start new server */
 	new = iriap_open(LSAP_IAS, IAS_SERVER, NULL, NULL);
 	if (!new) {
 		IRDA_DEBUG(0, "%s(), open failed\n", __FUNCTION__);
-		dev_kfree_skb(userdata);
-		return;
+		goto out;
 	}
 
 	/* Now attach up the new "socket" */
 	new->lsap = irlmp_dup(self->lsap, new);
 	if (!new->lsap) {
 		IRDA_DEBUG(0, "%s(), dup failed!\n", __FUNCTION__);
-		return;
+		goto out;
 	}
 
 	new->max_data_size = max_seg_size;
@@ -801,7 +806,11 @@ static void iriap_connect_indication(voi
 	/* Clean up the original one to keep it in listen state */
 	irlmp_listen(self->lsap);
 
-	iriap_do_server_event(new, IAP_LM_CONNECT_INDICATION, userdata);
+	iriap_do_server_event(new, IAP_LM_CONNECT_INDICATION, skb);
+
+out:
+	/* Drop reference count - see state_r_disconnect(). */
+	dev_kfree_skb(skb);
 }
 
 /*
@@ -821,10 +830,9 @@ static int iriap_data_indication(void *i
 
 	self = (struct iriap_cb *) instance;
 
-	ASSERT(self != NULL, return 0;);
-	ASSERT(self->magic == IAS_MAGIC, return 0;);
-
 	ASSERT(skb != NULL, return 0;);
+	ASSERT(self != NULL, goto out;);
+	ASSERT(self->magic == IAS_MAGIC, goto out;);
 
 	frame = skb->data;
 
@@ -832,22 +840,19 @@ static int iriap_data_indication(void *i
 		/* Call server */
 		IRDA_DEBUG(4, "%s(), Calling server!\n", __FUNCTION__);
 		iriap_do_r_connect_event(self, IAP_RECV_F_LST, skb);
-
-		return 0;
+		goto out;
 	}
 	opcode = frame[0];
 	if (~opcode & IAP_LST) {
 		WARNING("%s:, IrIAS multiframe commands or "
 			"results is not implemented yet!\n", __FUNCTION__);
-		dev_kfree_skb(skb);
-		return 0;
+		goto out;
 	}
 
 	/* Check for ack frames since they don't contain any data */
 	if (opcode & IAP_ACK) {
 		IRDA_DEBUG(0, "%s() Got ack frame!\n", __FUNCTION__);
-		dev_kfree_skb(skb);
-		return 0;
+		goto out;
 	}
 
 	opcode &= ~IAP_LST; /* Mask away LST bit */
@@ -855,7 +860,6 @@ static int iriap_data_indication(void *i
 	switch (opcode) {
 	case GET_INFO_BASE:
 		IRDA_DEBUG(0, "IrLMP GetInfoBaseDetails not implemented!\n");
-		dev_kfree_skb(skb);
 		break;
 	case GET_VALUE_BY_CLASS:
 		iriap_do_call_event(self, IAP_RECV_F_LST, NULL);
@@ -876,7 +880,6 @@ static int iriap_data_indication(void *i
 			if (self->confirm)
 				self->confirm(IAS_CLASS_UNKNOWN, 0, NULL,
 					      self->priv);
-			dev_kfree_skb(skb);
 			break;
 		case IAS_ATTRIB_UNKNOWN:
 			IRDA_DEBUG(1, "%s(), No such attribute!\n", __FUNCTION__);
@@ -890,16 +893,18 @@ static int iriap_data_indication(void *i
 			if (self->confirm)
 				self->confirm(IAS_ATTRIB_UNKNOWN, 0, NULL,
 					      self->priv);
-			dev_kfree_skb(skb);
 			break;
 		}
 		break;
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown op-code: %02x\n", __FUNCTION__,
 			   opcode);
-		dev_kfree_skb(skb);
 		break;
 	}
+
+out:
+	/* Cleanup - sub-calls will have done skb_get() as needed. */
+	dev_kfree_skb(skb);
 	return 0;
 }
 
@@ -939,6 +944,7 @@ void iriap_call_indication(struct iriap_
 		iriap_getvaluebyclass_indication(self, skb);
 		break;
 	}
+	/* skb will be cleaned up in iriap_data_indication */
 }
 
 /*
diff -u -p -r linux/net/irda.d9/iriap_event.c linux/net/irda/iriap_event.c
--- linux/net/irda.d9/iriap_event.c	Mon Mar 24 14:01:22 2003
+++ linux/net/irda/iriap_event.c	Mon May 12 16:53:17 2003
@@ -11,6 +11,7 @@
  *
  *     Copyright (c) 1997, 1999-2000 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
@@ -174,8 +175,11 @@ static void state_s_disconnect(struct ir
 	switch (event) {
 	case IAP_CALL_REQUEST_GVBC:
 		iriap_next_client_state(self, S_CONNECTING);
-		ASSERT(self->skb == NULL, return;);
-		self->skb = skb;
+		ASSERT(self->request_skb == NULL, return;);
+		/* Don't forget to refcount it -
+		 * see iriap_getvaluebyclass_request(). */
+		skb_get(skb);
+		self->request_skb = skb;
 		iriap_connect_request(self);
 		break;
 	case IAP_LM_DISCONNECT_INDICATION:
@@ -251,20 +255,21 @@ static void state_s_call(struct iriap_cb
 static void state_s_make_call(struct iriap_cb *self, IRIAP_EVENT event,
 			      struct sk_buff *skb)
 {
+	struct sk_buff *tx_skb;
+
 	ASSERT(self != NULL, return;);
 
 	switch (event) {
 	case IAP_CALL_REQUEST:
-		skb = self->skb;
-		self->skb = NULL;
+		/* Already refcounted - see state_s_disconnect() */
+		tx_skb = self->request_skb;
+		self->request_skb = NULL;
 
-		irlmp_data_request(self->lsap, skb);
+		irlmp_data_request(self->lsap, tx_skb);
 		iriap_next_call_state(self, S_OUTSTANDING);
 		break;
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %d\n", __FUNCTION__, event);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 }
@@ -379,10 +384,6 @@ static void state_r_disconnect(struct ir
 		 *  care about LM_Idle_request()!
 		 */
 		iriap_next_r_connect_state(self, R_RECEIVING);
-
-		if (skb)
-			dev_kfree_skb(skb);
-
 		break;
 	default:
 		IRDA_DEBUG(0, "%s(), unknown event %d\n", __FUNCTION__, event);
@@ -450,7 +451,6 @@ static void state_r_receiving(struct iri
 		IRDA_DEBUG(0, "%s(), unknown event!\n", __FUNCTION__);
 		break;
 	}
-
 }
 
 /*
@@ -465,11 +465,8 @@ static void state_r_execute(struct iriap
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(skb != NULL, return;);
-
-	if (!self || self->magic != IAS_MAGIC) {
-		IRDA_DEBUG(0, "%s(), bad pointer self\n", __FUNCTION__);
-		return;
-	}
+	ASSERT(self != NULL, return;);
+	ASSERT(self->magic == IAS_MAGIC, return;);
 
 	switch (event) {
 	case IAP_CALL_RESPONSE:
@@ -478,6 +475,10 @@ static void state_r_execute(struct iriap
 		 *  to state Receiving instead, DB.
 		 */
 		iriap_next_r_connect_state(self, R_RECEIVING);
+
+		/* Don't forget to refcount it - see
+		 * iriap_getvaluebyclass_response(). */
+		skb_get(skb);
 
 		irlmp_data_request(self->lsap, skb);
 		break;
diff -u -p -r linux/net/irda.d9/irlan/irlan_eth.c linux/net/irda/irlan/irlan_eth.c
--- linux/net/irda.d9/irlan/irlan_eth.c	Mon Mar 24 14:00:10 2003
+++ linux/net/irda/irlan/irlan_eth.c	Mon May 12 16:53:17 2003
@@ -206,7 +206,7 @@ int irlan_eth_xmit(struct sk_buff *skb, 
 		 * confuse do_dev_queue_xmit() in dev.c! I have
 		 * tried :-) DB 
 		 */
-		dev_kfree_skb(skb);
+		/* irttp_data_request already free the packet */
 		self->stats.tx_dropped++;
 	} else {
 		self->stats.tx_packets++;
diff -u -p -r linux/net/irda.d9/irlap.c linux/net/irda/irlap.c
--- linux/net/irda.d9/irlap.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/irlap.c	Mon May 12 16:53:17 2003
@@ -10,7 +10,7 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  *
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
@@ -244,7 +244,6 @@ void irlap_connect_indication(struct irl
 
 	irlap_init_qos_capabilities(self, NULL); /* No user QoS! */
 
-	skb_get(skb); /*LEVEL4*/
 	irlmp_link_connect_indication(self->notify.instance, self->saddr,
 				      self->daddr, &self->qos_tx, skb);
 }
@@ -255,12 +254,11 @@ void irlap_connect_indication(struct irl
  *    Service user has accepted incoming connection
  *
  */
-void irlap_connect_response(struct irlap_cb *self, struct sk_buff *skb)
+void irlap_connect_response(struct irlap_cb *self, struct sk_buff *userdata)
 {
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
-	irlap_do_event(self, CONNECT_RESPONSE, skb, NULL);
-	kfree_skb(skb);
+	irlap_do_event(self, CONNECT_RESPONSE, userdata, NULL);
 }
 
 /*
@@ -305,7 +303,6 @@ void irlap_connect_confirm(struct irlap_
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
-	skb_get(skb); /*LEVEL4*/
 	irlmp_link_connect_confirm(self->notify.instance, &self->qos_tx, skb);
 }
 
@@ -322,7 +319,6 @@ void irlap_data_indication(struct irlap_
 	/* Hide LAP header from IrLMP layer */
 	skb_pull(skb, LAP_ADDR_HEADER+LAP_CTRL_HEADER);
 
-	skb_get(skb); /*LEVEL4*/
 	irlmp_link_data_indication(self->notify.instance, skb, unreliable);
 }
 
@@ -354,6 +350,9 @@ void irlap_data_request(struct irlap_cb 
 	else
 		skb->data[1] = I_FRAME;
 
+	/* Don't forget to refcount it - see irlmp_connect_request(). */
+	skb_get(skb);
+
 	/* Add at the end of the queue (keep ordering) - Jean II */
 	skb_queue_tail(&self->txq, skb);
 
@@ -392,6 +391,8 @@ void irlap_unitdata_request(struct irlap
 	skb->data[0] = CBROADCAST;
 	skb->data[1] = UI_FRAME;
 
+	/* Don't need to refcount, see irlmp_connless_data_request() */
+
 	skb_queue_tail(&self->txq_ultra, skb);
 
 	irlap_do_event(self, SEND_UI_FRAME, NULL, NULL);
@@ -416,7 +417,6 @@ void irlap_unitdata_indication(struct ir
 	/* Hide LAP header from IrLMP layer */
 	skb_pull(skb, LAP_ADDR_HEADER+LAP_CTRL_HEADER);
 
-	skb_get(skb); /*LEVEL4*/
 	irlmp_link_unitdata_indication(self->notify.instance, skb);
 }
 #endif /* CONFIG_IRDA_ULTRA */
diff -u -p -r linux/net/irda.d9/irlap_event.c linux/net/irda/irlap_event.c
--- linux/net/irda.d9/irlap_event.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/irlap_event.c	Mon May 12 16:53:17 2003
@@ -12,7 +12,7 @@
  *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>,
  *     Copyright (c) 1998      Thomas Davis <ratbert@radiks.net>
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
@@ -287,6 +287,9 @@ void irlap_do_event(struct irlap_cb *sel
 				/* Send one frame */
 				ret = (*state[self->state])(self, SEND_I_CMD,
 							    skb, NULL);
+				/* Drop reference count.
+				 * It will be increase as needed in
+				 * irlap_send_data_xxx() */
 				kfree_skb(skb);
 
 				/* Poll the higher layers for one more frame */
@@ -517,6 +520,8 @@ static int irlap_state_ndm(struct irlap_
 						    CMD_FRAME);
 			else
 				break;
+			/* irlap_send_ui_frame() won't increase skb reference
+			 * count, so no dev_kfree_skb() - Jean II */
 		}
 		if (i == 2) {
 			/* Force us to listen 500 ms again */
diff -u -p -r linux/net/irda.d9/irlap_frame.c linux/net/irda/irlap_frame.c
--- linux/net/irda.d9/irlap_frame.c	Mon May 12 10:40:35 2003
+++ linux/net/irda/irlap_frame.c	Mon May 12 16:53:17 2003
@@ -11,7 +11,7 @@
  *
  *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
@@ -106,7 +106,7 @@ void irlap_queue_xmit(struct irlap_cb *s
  */
 void irlap_send_snrm_frame(struct irlap_cb *self, struct qos_info *qos)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	struct snrm_frame *frame;
 	int ret;
 
@@ -114,11 +114,11 @@ void irlap_send_snrm_frame(struct irlap_
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
 	/* Allocate frame */
-	skb = dev_alloc_skb(64);
-	if (!skb)
+	tx_skb = dev_alloc_skb(64);
+	if (!tx_skb)
 		return;
 
-	frame = (struct snrm_frame *) skb_put(skb, 2);
+	frame = (struct snrm_frame *) skb_put(tx_skb, 2);
 
 	/* Insert connection address field */
 	if (qos)
@@ -133,19 +133,19 @@ void irlap_send_snrm_frame(struct irlap_
 	 *  If we are establishing a connection then insert QoS paramerters
 	 */
 	if (qos) {
-		skb_put(skb, 9); /* 21 left */
+		skb_put(tx_skb, 9); /* 21 left */
 		frame->saddr = cpu_to_le32(self->saddr);
 		frame->daddr = cpu_to_le32(self->daddr);
 
 		frame->ncaddr = self->caddr;
 
-		ret = irlap_insert_qos_negotiation_params(self, skb);
+		ret = irlap_insert_qos_negotiation_params(self, tx_skb);
 		if (ret < 0) {
-			dev_kfree_skb(skb);
+			dev_kfree_skb(tx_skb);
 			return;
 		}
 	}
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 /*
@@ -197,7 +197,7 @@ static void irlap_recv_snrm_cmd(struct i
  */
 void irlap_send_ua_response_frame(struct irlap_cb *self, struct qos_info *qos)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	struct ua_frame *frame;
 	int ret;
 
@@ -206,14 +206,12 @@ void irlap_send_ua_response_frame(struct
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
-	skb = NULL;
-
 	/* Allocate frame */
-	skb = dev_alloc_skb(64);
-	if (!skb)
+	tx_skb = dev_alloc_skb(64);
+	if (!tx_skb)
 		return;
 
-	frame = (struct ua_frame *) skb_put(skb, 10);
+	frame = (struct ua_frame *) skb_put(tx_skb, 10);
 
 	/* Build UA response */
 	frame->caddr = self->caddr;
@@ -224,14 +222,14 @@ void irlap_send_ua_response_frame(struct
 
 	/* Should we send QoS negotiation parameters? */
 	if (qos) {
-		ret = irlap_insert_qos_negotiation_params(self, skb);
+		ret = irlap_insert_qos_negotiation_params(self, tx_skb);
 		if (ret < 0) {
-			dev_kfree_skb(skb);
+			dev_kfree_skb(tx_skb);
 			return;
 		}
 	}
 
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 
@@ -243,17 +241,17 @@ void irlap_send_ua_response_frame(struct
  */
 void irlap_send_dm_frame( struct irlap_cb *self)
 {
-	struct sk_buff *skb = NULL;
+	struct sk_buff *tx_skb = NULL;
 	__u8 *frame;
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
-	skb = dev_alloc_skb(32);
-	if (!skb)
+	tx_skb = dev_alloc_skb(32);
+	if (!tx_skb)
 		return;
 
-	frame = skb_put( skb, 2);
+	frame = skb_put(tx_skb, 2);
 
 	if (self->state == LAP_NDM)
 		frame[0] = CBROADCAST;
@@ -262,7 +260,7 @@ void irlap_send_dm_frame( struct irlap_c
 
 	frame[1] = DM_RSP | PF_BIT;
 
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 /*
@@ -273,7 +271,7 @@ void irlap_send_dm_frame( struct irlap_c
  */
 void irlap_send_disc_frame(struct irlap_cb *self)
 {
-	struct sk_buff *skb = NULL;
+	struct sk_buff *tx_skb = NULL;
 	__u8 *frame;
 
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
@@ -281,16 +279,16 @@ void irlap_send_disc_frame(struct irlap_
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
-	skb = dev_alloc_skb(16);
-	if (!skb)
+	tx_skb = dev_alloc_skb(16);
+	if (!tx_skb)
 		return;
 
-	frame = skb_put(skb, 2);
+	frame = skb_put(tx_skb, 2);
 
 	frame[0] = self->caddr | CMD_FRAME;
 	frame[1] = DISC_CMD | PF_BIT;
 
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 /*
@@ -302,7 +300,7 @@ void irlap_send_disc_frame(struct irlap_
 void irlap_send_discovery_xid_frame(struct irlap_cb *self, int S, __u8 s,
 				    __u8 command, discovery_t *discovery)
 {
-	struct sk_buff *skb = NULL;
+	struct sk_buff *tx_skb = NULL;
 	struct xid_frame *frame;
 	__u32 bcast = BROADCAST;
 	__u8 *info;
@@ -314,12 +312,12 @@ void irlap_send_discovery_xid_frame(stru
 	ASSERT(self->magic == LAP_MAGIC, return;);
 	ASSERT(discovery != NULL, return;);
 
-	skb = dev_alloc_skb(64);
-	if (!skb)
+	tx_skb = dev_alloc_skb(64);
+	if (!tx_skb)
 		return;
 
-	skb_put(skb, 14);
-	frame = (struct xid_frame *) skb->data;
+	skb_put(tx_skb, 14);
+	frame = (struct xid_frame *) tx_skb->data;
 
 	if (command) {
 		frame->caddr = CBROADCAST | CMD_FRAME;
@@ -367,21 +365,21 @@ void irlap_send_discovery_xid_frame(stru
 		int len;
 
 		if (discovery->data.hints[0] & HINT_EXTENSION) {
-			info = skb_put(skb, 2);
+			info = skb_put(tx_skb, 2);
 			info[0] = discovery->data.hints[0];
 			info[1] = discovery->data.hints[1];
 		} else {
-			info = skb_put(skb, 1);
+			info = skb_put(tx_skb, 1);
 			info[0] = discovery->data.hints[0];
 		}
-		info = skb_put(skb, 1);
+		info = skb_put(tx_skb, 1);
 		info[0] = discovery->data.charset;
 
-		len = IRDA_MIN(discovery->name_len, skb_tailroom(skb));
-		info = skb_put(skb, len);
+		len = IRDA_MIN(discovery->name_len, skb_tailroom(tx_skb));
+		info = skb_put(tx_skb, len);
 		memcpy(info, discovery->data.info, len);
 	}
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 /*
@@ -498,7 +496,6 @@ static void irlap_recv_discovery_xid_cmd
 		break;
 	default:
 		/* Error!! */
-		dev_kfree_skb(skb);
 		return;
 	}
 	info->s = xid->slotnr;
@@ -561,21 +558,21 @@ static void irlap_recv_discovery_xid_cmd
  */
 void irlap_send_rr_frame(struct irlap_cb *self, int command)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	__u8 *frame;
 
-	skb = dev_alloc_skb(16);
-	if (!skb)
+	tx_skb = dev_alloc_skb(16);
+	if (!tx_skb)
 		return;
 
-	frame = skb_put(skb, 2);
+	frame = skb_put(tx_skb, 2);
 
 	frame[0] = self->caddr;
 	frame[0] |= (command) ? CMD_FRAME : 0;
 
 	frame[1] = RR | PF_BIT | (self->vr << 5);
 
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 /*
@@ -586,19 +583,19 @@ void irlap_send_rr_frame(struct irlap_cb
  */
 void irlap_send_rd_frame(struct irlap_cb *self)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	__u8 *frame;
 
-	skb = dev_alloc_skb(16);
-	if (!skb)
+	tx_skb = dev_alloc_skb(16);
+	if (!tx_skb)
 		return;
 
-	frame = skb_put(skb, 2);
+	frame = skb_put(tx_skb, 2);
 
 	frame[0] = self->caddr;
 	frame[1] = RD_RSP | PF_BIT;
 
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 /*
@@ -623,17 +620,17 @@ static inline void irlap_recv_rr_frame(s
 
 void irlap_send_frmr_frame( struct irlap_cb *self, int command)
 {
-	struct sk_buff *skb = NULL;
+	struct sk_buff *tx_skb = NULL;
 	__u8 *frame;
 
 	ASSERT( self != NULL, return;);
 	ASSERT( self->magic == LAP_MAGIC, return;);
 
-	skb = dev_alloc_skb( 32);
-	if (!skb)
+	tx_skb = dev_alloc_skb( 32);
+	if (!tx_skb)
 		return;
 
-	frame = skb_put( skb, 2);
+	frame = skb_put(tx_skb, 2);
 
 	frame[0] = self->caddr;
 	frame[0] |= (command) ? CMD_FRAME : 0;
@@ -646,7 +643,7 @@ void irlap_send_frmr_frame( struct irlap
 
 	IRDA_DEBUG(4, "%s(), vr=%d, %ld\n", __FUNCTION__, self->vr, jiffies);
 
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 /*
@@ -739,17 +736,19 @@ void irlap_send_data_primary(struct irla
 		 */
 		skb->data[1] = I_FRAME | (self->vs << 1);
 
+		/*
+		 *  Insert frame in store, in case of retransmissions
+		 *  Increase skb reference count, see irlap_do_event()
+		 */
+		skb_get(skb);
+		skb_queue_tail(&self->wx_list, skb);
+
 		/* Copy buffer */
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb == NULL) {
 			return;
 		}
 
-		/*
-		 *  Insert frame in store, in case of retransmissions
-		 */
-		skb_queue_tail(&self->wx_list, skb_get(skb));
-
 		self->vs = (self->vs + 1) % 8;
 		self->ack_required = FALSE;
 		self->window -= 1;
@@ -782,6 +781,13 @@ void irlap_send_data_primary_poll(struct
 		 */
 		skb->data[1] = I_FRAME | (self->vs << 1);
 
+		/*
+		 *  Insert frame in store, in case of retransmissions
+		 *  Increase skb reference count, see irlap_do_event()
+		 */
+		skb_get(skb);
+		skb_queue_tail(&self->wx_list, skb);
+
 		/* Copy buffer */
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb == NULL) {
@@ -789,11 +795,6 @@ void irlap_send_data_primary_poll(struct
 		}
 
 		/*
-		 *  Insert frame in store, in case of retransmissions
-		 */
-		skb_queue_tail(&self->wx_list, skb_get(skb));
-
-		/*
 		 *  Set poll bit if necessary. We do this to the copied
 		 *  skb, since retransmitted need to set or clear the poll
 		 *  bit depending on when they are sent.
@@ -850,14 +851,18 @@ void irlap_send_data_secondary_final(str
 		 */
 		skb->data[1] = I_FRAME | (self->vs << 1);
 
+		/*
+		 *  Insert frame in store, in case of retransmissions
+		 *  Increase skb reference count, see irlap_do_event()
+		 */
+		skb_get(skb);
+		skb_queue_tail(&self->wx_list, skb);
+
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb == NULL) {
 			return;
 		}
 
-		/* Insert frame in store */
-		skb_queue_tail(&self->wx_list, skb_get(skb));
-
 		tx_skb->data[1] |= PF_BIT;
 
 		self->vs = (self->vs + 1) % 8;
@@ -903,14 +908,18 @@ void irlap_send_data_secondary(struct ir
 		 */
 		skb->data[1] = I_FRAME | (self->vs << 1);
 
+		/*
+		 *  Insert frame in store, in case of retransmissions
+		 *  Increase skb reference count, see irlap_do_event()
+		 */
+		skb_get(skb);
+		skb_queue_tail(&self->wx_list, skb);
+
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb == NULL) {
 			return;
 		}
 
-		/* Insert frame in store */
-		skb_queue_tail(&self->wx_list, skb_get(skb));
-
 		self->vs = (self->vs + 1) % 8;
 		self->ack_required = FALSE;
 		self->window -= 1;
@@ -939,8 +948,6 @@ void irlap_resend_rejected_frames(struct
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
 	/* Initialize variables */
-	skb = tx_skb = NULL;
-
 	count = skb_queue_len(&self->wx_list);
 
 	/*  Resend unacknowledged frame(s) */
@@ -1020,9 +1027,6 @@ void irlap_resend_rejected_frame(struct 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
-	/* Initialize variables */
-	skb = tx_skb = NULL;
-
 	/*  Resend unacknowledged frame(s) */
 	skb = skb_peek(&self->wx_list);
 	if (skb != NULL) {
@@ -1186,35 +1190,35 @@ static void irlap_recv_frmr_frame(struct
 void irlap_send_test_frame(struct irlap_cb *self, __u8 caddr, __u32 daddr,
 			   struct sk_buff *cmd)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	struct test_frame *frame;
 	__u8 *info;
 
-	skb = dev_alloc_skb(cmd->len+sizeof(struct test_frame));
-	if (!skb)
+	tx_skb = dev_alloc_skb(cmd->len+sizeof(struct test_frame));
+	if (!tx_skb)
 		return;
 
 	/* Broadcast frames must include saddr and daddr fields */
 	if (caddr == CBROADCAST) {
 		frame = (struct test_frame *)
-			skb_put(skb, sizeof(struct test_frame));
+			skb_put(tx_skb, sizeof(struct test_frame));
 
 		/* Insert the swapped addresses */
 		frame->saddr = cpu_to_le32(self->saddr);
 		frame->daddr = cpu_to_le32(daddr);
 	} else
-		frame = (struct test_frame *) skb_put(skb, LAP_ADDR_HEADER + LAP_CTRL_HEADER);
+		frame = (struct test_frame *) skb_put(tx_skb, LAP_ADDR_HEADER + LAP_CTRL_HEADER);
 
 	frame->caddr = caddr;
 	frame->control = TEST_RSP | PF_BIT;
 
 	/* Copy info */
-	info = skb_put(skb, cmd->len);
+	info = skb_put(tx_skb, cmd->len);
 	memcpy(info, cmd->data, cmd->len);
 
 	/* Return to sender */
 	irlap_wait_min_turn_around(self, &self->qos_tx);
-	irlap_queue_xmit(self, skb);
+	irlap_queue_xmit(self, tx_skb);
 }
 
 /*
@@ -1263,6 +1267,15 @@ static void irlap_recv_test_frame(struct
  *    Called when a frame is received. Dispatches the right receive function
  *    for processing of the frame.
  *
+ * Note on skb management :
+ * After calling the higher layers of the IrDA stack, we always
+ * kfree() the skb, which drop the reference count (and potentially
+ * destroy it).
+ * If a higher layer of the stack want to keep the skb around (to put
+ * in a queue or pass it to the higher layer), it will need to use
+ * skb_get() to keep a reference on it. This is usually done at the
+ * LMP level in irlmp.c.
+ * Jean II
  */
 int irlap_driver_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *ptype)
@@ -1286,6 +1299,7 @@ int irlap_driver_rcv(struct sk_buff *skb
 	 * we don't need to be clever about it. Jean II */
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL) {
 		ERROR("%s: can't clone shared skb!\n", __FUNCTION__);
+		dev_kfree_skb(skb);
 		return -1;
 	}
 	if (skb_is_nonlinear(skb))
@@ -1390,6 +1404,7 @@ int irlap_driver_rcv(struct sk_buff *skb
 		break;
 	}
 out:
+	/* Always drop our reference on the skb */
 	dev_kfree_skb(skb);
 	return 0;
 }
diff -u -p -r linux/net/irda.d9/irlmp.c linux/net/irda/irlmp.c
--- linux/net/irda.d9/irlmp.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/irlmp.c	Mon May 12 16:53:17 2003
@@ -11,7 +11,7 @@
  *
  *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
@@ -345,9 +345,10 @@ int irlmp_connect_request(struct lsap_cb
 			  __u32 saddr, __u32 daddr,
 			  struct qos_info *qos, struct sk_buff *userdata)
 {
-	struct sk_buff *skb = NULL;
+	struct sk_buff *tx_skb = userdata;
 	struct lap_cb *lap;
 	struct lsap_cb *lsap;
+	int ret;
 
 	ASSERT(self != NULL, return -EBADR;);
 	ASSERT(self->magic == LMP_LSAP_MAGIC, return -EBADR;);
@@ -356,26 +357,29 @@ int irlmp_connect_request(struct lsap_cb
 	      "%s(), slsap_sel=%02x, dlsap_sel=%02x, saddr=%08x, daddr=%08x\n",
 	      __FUNCTION__, self->slsap_sel, dlsap_sel, saddr, daddr);
 
-	if (test_bit(0, &self->connected))
-		return -EISCONN;
+	if (test_bit(0, &self->connected)) {
+		ret = -EISCONN;
+		goto err;
+	}
 
 	/* Client must supply destination device address */
-	if (!daddr)
-		return -EINVAL;
+	if (!daddr) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	/* Any userdata? */
-	if (userdata == NULL) {
-		skb = dev_alloc_skb(64);
-		if (!skb)
+	if (tx_skb == NULL) {
+		tx_skb = dev_alloc_skb(64);
+		if (!tx_skb)
 			return -ENOMEM;
 
-		skb_reserve(skb, LMP_MAX_HEADER);
-	} else
-		skb = userdata;
+		skb_reserve(tx_skb, LMP_MAX_HEADER);
+	}
 
 	/* Make room for MUX control header (3 bytes) */
-	ASSERT(skb_headroom(skb) >= LMP_CONTROL_HEADER, return -1;);
-	skb_push(skb, LMP_CONTROL_HEADER);
+	ASSERT(skb_headroom(tx_skb) >= LMP_CONTROL_HEADER, return -1;);
+	skb_push(tx_skb, LMP_CONTROL_HEADER);
 
 	self->dlsap_sel = dlsap_sel;
 
@@ -409,7 +413,8 @@ int irlmp_connect_request(struct lsap_cb
 	lap = hashbin_lock_find(irlmp->links, saddr, NULL);
 	if (lap == NULL) {
 		IRDA_DEBUG(1, "%s(), Unable to find a usable link!\n", __FUNCTION__);
-		return -EHOSTUNREACH;
+		ret = -EHOSTUNREACH;
+		goto err;
 	}
 
 	/* Check if LAP is disconnected or already connected */
@@ -423,13 +428,15 @@ int irlmp_connect_request(struct lsap_cb
 			 * Maybe we could give LAP a bit of help in this case.
 			 */
 			IRDA_DEBUG(0, "%s(), sorry, but I'm waiting for LAP to timeout!\n", __FUNCTION__);
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto err;
 		}
 
 		/* LAP is already connected to a different node, and LAP
 		 * can only talk to one node at a time */
 		IRDA_DEBUG(0, "%s(), sorry, but link is busy!\n", __FUNCTION__);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	self->lap = lap;
@@ -456,9 +463,18 @@ int irlmp_connect_request(struct lsap_cb
 	if (qos)
 		self->qos = *qos;
 
-	irlmp_do_lsap_event(self, LM_CONNECT_REQUEST, skb);
+	irlmp_do_lsap_event(self, LM_CONNECT_REQUEST, tx_skb);
+
+	/* Drop reference count - see irlap_data_request(). */
+	dev_kfree_skb(tx_skb);
 
 	return 0;
+
+err:
+	/* Cleanup */
+	if(tx_skb)
+		dev_kfree_skb(tx_skb);
+	return ret;
 }
 
 /*
@@ -495,12 +511,13 @@ void irlmp_connect_indication(struct lsa
 	/* Hide LMP_CONTROL_HEADER header from layer above */
 	skb_pull(skb, LMP_CONTROL_HEADER);
 
-	if (self->notify.connect_indication)
+	if (self->notify.connect_indication) {
+		/* Don't forget to refcount it - see irlap_driver_rcv(). */
+		skb_get(skb);
 		self->notify.connect_indication(self->notify.instance, self,
 						&self->qos, max_seg_size,
 						max_header_size, skb);
-	else
-		dev_kfree_skb(skb);
+	}
 }
 
 /*
@@ -526,6 +543,9 @@ int irlmp_connect_response(struct lsap_c
 
 	irlmp_do_lsap_event(self, LM_CONNECT_RESPONSE, userdata);
 
+	/* Drop reference count - see irlap_data_request(). */
+	dev_kfree_skb(userdata);
+
 	return 0;
 }
 
@@ -560,11 +580,12 @@ void irlmp_connect_confirm(struct lsap_c
 	skb_pull(skb, LMP_CONTROL_HEADER);
 
 	if (self->notify.connect_confirm) {
+		/* Don't forget to refcount it - see irlap_driver_rcv() */
+		skb_get(skb);
 		self->notify.connect_confirm(self->notify.instance, self,
 					     &self->qos, max_seg_size,
 					     max_header_size, skb);
-	} else
-		dev_kfree_skb(skb);
+	}
 }
 
 /*
@@ -602,6 +623,7 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 	memcpy(new, orig, sizeof(struct lsap_cb));
 	/* new->lap = orig->lap; => done in the memcpy() */
 	/* new->slsap_sel = orig->slsap_sel; => done in the memcpy() */
+	new->conn_skb = NULL;
 
 	spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock, flags);
 
@@ -653,6 +675,9 @@ int irlmp_disconnect_request(struct lsap
 	 */
 	irlmp_do_lsap_event(self, LM_DISCONNECT_REQUEST, userdata);
 
+	/* Drop reference count - see irlap_data_request(). */
+	dev_kfree_skb(userdata);
+
 	/*
 	 *  Remove LSAP from list of connected LSAPs for the particular link
 	 *  and insert it into the list of unconnected LSAPs
@@ -686,7 +711,7 @@ int irlmp_disconnect_request(struct lsap
  *    LSAP is being closed!
  */
 void irlmp_disconnect_indication(struct lsap_cb *self, LM_REASON reason,
-				 struct sk_buff *userdata)
+				 struct sk_buff *skb)
 {
 	struct lsap_cb *lsap;
 
@@ -703,8 +728,6 @@ void irlmp_disconnect_indication(struct 
 	 * Jean II */
 	if (! test_and_clear_bit(0, &self->connected)) {
 		IRDA_DEBUG(0, "%s(), already disconnected!\n", __FUNCTION__);
-		if (userdata)
-			dev_kfree_skb(userdata);
 		return;
 	}
 
@@ -730,13 +753,14 @@ void irlmp_disconnect_indication(struct 
 	/*
 	 *  Inform service user
 	 */
-	if (self->notify.disconnect_indication)
+	if (self->notify.disconnect_indication) {
+		/* Don't forget to refcount it - see irlap_driver_rcv(). */
+		if(skb)
+			skb_get(skb);
 		self->notify.disconnect_indication(self->notify.instance,
-						   self, reason, userdata);
-	else {
+						   self, reason, skb);
+	} else {
 		IRDA_DEBUG(0, "%s(), no handler\n", __FUNCTION__);
-		if (userdata)
-			dev_kfree_skb(userdata);
 	}
 }
 
@@ -1047,17 +1071,31 @@ discovery_t *irlmp_get_discovery_respons
  *
  *    Send some data to peer device
  *
+ * Note on skb management :
+ * After calling the lower layers of the IrDA stack, we always
+ * kfree() the skb, which drop the reference count (and potentially
+ * destroy it).
+ * IrLMP and IrLAP may queue the packet, and in those cases will need
+ * to use skb_get() to keep it around.
+ * Jean II
  */
-int irlmp_data_request(struct lsap_cb *self, struct sk_buff *skb)
+int irlmp_data_request(struct lsap_cb *self, struct sk_buff *userdata)
 {
+	int	ret;
+
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LMP_LSAP_MAGIC, return -1;);
 
 	/* Make room for MUX header */
-	ASSERT(skb_headroom(skb) >= LMP_HEADER, return -1;);
-	skb_push(skb, LMP_HEADER);
+	ASSERT(skb_headroom(userdata) >= LMP_HEADER, return -1;);
+	skb_push(userdata, LMP_HEADER);
+
+	ret = irlmp_do_lsap_event(self, LM_DATA_REQUEST, userdata);
 
-	return irlmp_do_lsap_event(self, LM_DATA_REQUEST, skb);
+	/* Drop reference count - see irlap_data_request(). */
+	dev_kfree_skb(userdata);
+
+	return ret;
 }
 
 /*
@@ -1071,26 +1109,34 @@ void irlmp_data_indication(struct lsap_c
 	/* Hide LMP header from layer above */
 	skb_pull(skb, LMP_HEADER);
 
-	if (self->notify.data_indication)
+	if (self->notify.data_indication) {
+		/* Don't forget to refcount it - see irlap_driver_rcv(). */
+		skb_get(skb);
 		self->notify.data_indication(self->notify.instance, self, skb);
-	else
-		dev_kfree_skb(skb);
+	}
 }
 
 /*
  * Function irlmp_udata_request (self, skb)
  */
-int irlmp_udata_request(struct lsap_cb *self, struct sk_buff *skb)
+int irlmp_udata_request(struct lsap_cb *self, struct sk_buff *userdata)
 {
+	int	ret;
+
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
-	ASSERT(skb != NULL, return -1;);
+	ASSERT(userdata != NULL, return -1;);
 
 	/* Make room for MUX header */
-	ASSERT(skb_headroom(skb) >= LMP_HEADER, return -1;);
-	skb_push(skb, LMP_HEADER);
+	ASSERT(skb_headroom(userdata) >= LMP_HEADER, return -1;);
+	skb_push(userdata, LMP_HEADER);
+
+	ret = irlmp_do_lsap_event(self, LM_UDATA_REQUEST, userdata);
 
-	return irlmp_do_lsap_event(self, LM_UDATA_REQUEST, skb);
+	/* Drop reference count - see irlap_data_request(). */
+	dev_kfree_skb(userdata);
+
+	return ret;
 }
 
 /*
@@ -1110,51 +1156,57 @@ void irlmp_udata_indication(struct lsap_
 	/* Hide LMP header from layer above */
 	skb_pull(skb, LMP_HEADER);
 
-	if (self->notify.udata_indication)
+	if (self->notify.udata_indication) {
+		/* Don't forget to refcount it - see irlap_driver_rcv(). */
+		skb_get(skb);
 		self->notify.udata_indication(self->notify.instance, self,
 					      skb);
-	else
-		dev_kfree_skb(skb);
+	}
 }
 
 /*
  * Function irlmp_connless_data_request (self, skb)
  */
 #ifdef CONFIG_IRDA_ULTRA
-int irlmp_connless_data_request(struct lsap_cb *self, struct sk_buff *skb)
+int irlmp_connless_data_request(struct lsap_cb *self, struct sk_buff *userdata)
 {
 	struct sk_buff *clone_skb;
 	struct lap_cb *lap;
 
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
-	ASSERT(skb != NULL, return -1;);
+	ASSERT(userdata != NULL, return -1;);
 
 	/* Make room for MUX and PID header */
-	ASSERT(skb_headroom(skb) >= LMP_HEADER+LMP_PID_HEADER, return -1;);
+	ASSERT(skb_headroom(userdata) >= LMP_HEADER+LMP_PID_HEADER,
+	       return -1;);
 
 	/* Insert protocol identifier */
-	skb_push(skb, LMP_PID_HEADER);
-	skb->data[0] = self->pid;
+	skb_push(userdata, LMP_PID_HEADER);
+	userdata->data[0] = self->pid;
 
 	/* Connectionless sockets must use 0x70 */
-	skb_push(skb, LMP_HEADER);
-	skb->data[0] = skb->data[1] = LSAP_CONNLESS;
+	skb_push(userdata, LMP_HEADER);
+	userdata->data[0] = userdata->data[1] = LSAP_CONNLESS;
 
 	/* Try to send Connectionless  packets out on all links */
 	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap != NULL) {
 		ASSERT(lap->magic == LMP_LAP_MAGIC, return -1;);
 
-		clone_skb = skb_clone(skb, GFP_ATOMIC);
-		if (!clone_skb)
+		clone_skb = skb_clone(userdata, GFP_ATOMIC);
+		if (!clone_skb) {
+			dev_kfree_skb(userdata);
 			return -ENOMEM;
+		}
 
 		irlap_unitdata_request(lap->irlap, clone_skb);
+		/* irlap_unitdata_request() don't increase refcount,
+		 * so no dev_kfree_skb() - Jean II */
 
 		lap = (struct lap_cb *) hashbin_get_next(irlmp->links);
 	}
-	dev_kfree_skb(skb);
+	dev_kfree_skb(userdata);
 
 	return 0;
 }
@@ -1178,11 +1230,12 @@ void irlmp_connless_data_indication(stru
 	/* Hide LMP and PID header from layer above */
 	skb_pull(skb, LMP_HEADER+LMP_PID_HEADER);
 
-	if (self->notify.udata_indication)
+	if (self->notify.udata_indication) {
+		/* Don't forget to refcount it - see irlap_driver_rcv(). */
+		skb_get(skb);
 		self->notify.udata_indication(self->notify.instance, self,
 					      skb);
-	else
-		dev_kfree_skb(skb);
+	}
 }
 #endif /* CONFIG_IRDA_ULTRA */
 
diff -u -p -r linux/net/irda.d9/irlmp_event.c linux/net/irda/irlmp_event.c
--- linux/net/irda.d9/irlmp_event.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/irlmp_event.c	Mon May 12 16:53:17 2003
@@ -11,7 +11,7 @@
  *
  *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
@@ -295,8 +295,6 @@ static void irlmp_state_standby(struct l
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %s\n",
 			   __FUNCTION__, irlmp_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 }
@@ -373,8 +371,6 @@ static void irlmp_state_u_connect(struct
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %s\n",
 			 __FUNCTION__, irlmp_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 }
@@ -468,8 +464,6 @@ static void irlmp_state_active(struct la
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %s\n",
 			 __FUNCTION__, irlmp_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 }
@@ -499,6 +493,9 @@ static int irlmp_state_disconnected(stru
 	switch (event) {
 #ifdef CONFIG_IRDA_ULTRA
 	case LM_UDATA_INDICATION:
+		/* This is most bizzare. Those packets are  aka unreliable
+		 * connected, aka IrLPT or SOCK_DGRAM/IRDAPROTO_UNITDATA.
+		 * Why do we pass them as Ultra ??? Jean II */
 		irlmp_connless_data_indication(self, skb);
 		break;
 #endif /* CONFIG_IRDA_ULTRA */
@@ -510,6 +507,8 @@ static int irlmp_state_disconnected(stru
 					__FUNCTION__);
 			return -EBUSY;
 		}
+		/* Don't forget to refcount it (see irlmp_connect_request()) */
+		skb_get(skb);
 		self->conn_skb = skb;
 
 		irlmp_next_lsap_state(self, LSAP_SETUP_PEND);
@@ -525,6 +524,8 @@ static int irlmp_state_disconnected(stru
 					__FUNCTION__);
 			return -EBUSY;
 		}
+		/* Don't forget to refcount it (see irlap_driver_rcv()) */
+		skb_get(skb);
 		self->conn_skb = skb;
 
 		irlmp_next_lsap_state(self, LSAP_CONNECT_PEND);
@@ -547,8 +548,6 @@ static int irlmp_state_disconnected(stru
 	default:
 		IRDA_DEBUG(1, "%s(), Unknown event %s on LSAP %#02x\n",
 			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 	return ret;
@@ -606,8 +605,6 @@ static int irlmp_state_connect(struct ls
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n", 
 			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 	return ret;
@@ -622,6 +619,7 @@ static int irlmp_state_connect(struct ls
 static int irlmp_state_connect_pend(struct lsap_cb *self, IRLMP_EVENT event,
 				    struct sk_buff *skb)
 {
+	struct sk_buff *tx_skb;
 	int ret = 0;
 
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
@@ -647,10 +645,12 @@ static int irlmp_state_connect_pend(stru
 		IRDA_DEBUG(4, "%s(), LS_CONNECT_CONFIRM\n",  __FUNCTION__);
 		irlmp_next_lsap_state(self, LSAP_CONNECT);
 
-		skb = self->conn_skb;
+		tx_skb = self->conn_skb;
 		self->conn_skb = NULL;
 
-		irlmp_connect_indication(self, skb);
+		irlmp_connect_indication(self, tx_skb);
+		/* Drop reference count - see irlmp_connect_indication(). */
+		dev_kfree_skb(tx_skb);
 		break;
 	case LM_WATCHDOG_TIMEOUT:
 		/* Will happen in some rare cases because of a race condition.
@@ -668,8 +668,6 @@ static int irlmp_state_connect_pend(stru
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n",
 			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 	return ret;
@@ -759,8 +757,6 @@ static int irlmp_state_dtr(struct lsap_c
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n",
 			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 	return ret;
@@ -832,8 +828,6 @@ static int irlmp_state_setup(struct lsap
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n",
 			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 	return ret;
@@ -850,6 +844,7 @@ static int irlmp_state_setup(struct lsap
 static int irlmp_state_setup_pend(struct lsap_cb *self, IRLMP_EVENT event,
 				  struct sk_buff *skb)
 {
+	struct sk_buff *tx_skb;
 	LM_REASON reason;
 	int ret = 0;
 
@@ -862,11 +857,13 @@ static int irlmp_state_setup_pend(struct
 	case LM_LAP_CONNECT_CONFIRM:
 		ASSERT(self->conn_skb != NULL, return -1;);
 
-		skb = self->conn_skb;
+		tx_skb = self->conn_skb;
 		self->conn_skb = NULL;
 
 		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel,
-				   self->slsap_sel, CONNECT_CMD, skb);
+				   self->slsap_sel, CONNECT_CMD, tx_skb);
+		/* Drop reference count - see irlap_data_request(). */
+		dev_kfree_skb(tx_skb);
 
 		irlmp_next_lsap_state(self, LSAP_SETUP);
 		break;
@@ -891,8 +888,6 @@ static int irlmp_state_setup_pend(struct
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n",
 			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
 	return ret;
diff -u -p -r linux/net/irda.d9/irlmp_frame.c linux/net/irda/irlmp_frame.c
--- linux/net/irda.d9/irlmp_frame.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/irlmp_frame.c	Mon May 12 16:53:17 2003
@@ -11,7 +11,7 @@
  * 
  *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -144,7 +144,6 @@ void irlmp_link_data_indication(struct l
 		} else {
 			IRDA_DEBUG(2, "%s(), received data frame\n", __FUNCTION__);
 		}
-		dev_kfree_skb(skb);
 		return;
 	}
 
@@ -168,16 +167,13 @@ void irlmp_link_data_indication(struct l
 			break;
 		case ACCESSMODE_CMD:
 			IRDA_DEBUG(0, "Access mode cmd not implemented!\n");
-			dev_kfree_skb(skb);
 			break;
 		case ACCESSMODE_CNF:
 			IRDA_DEBUG(0, "Access mode cnf not implemented!\n");
-			dev_kfree_skb(skb);
 			break;
 		default:
 			IRDA_DEBUG(0, "%s(), Unknown control frame %02x\n",
 				   __FUNCTION__, fp[2]);
-			dev_kfree_skb(skb);
 			break;
 		}
 	} else if (unreliable) {
@@ -230,16 +226,12 @@ void irlmp_link_unitdata_indication(stru
 	if (pid & 0x80) {
 		IRDA_DEBUG(0, "%s(), extension in PID not supp!\n",
 			   __FUNCTION__);
-		dev_kfree_skb(skb);
-
 		return;
 	}
 
 	/* Check if frame is addressed to the connectionless LSAP */
 	if ((slsap_sel != LSAP_CONNLESS) || (dlsap_sel != LSAP_CONNLESS)) {
 		IRDA_DEBUG(0, "%s(), dropping frame!\n", __FUNCTION__);
-		dev_kfree_skb(skb);
-		
 		return;
 	}
 	
@@ -264,7 +256,6 @@ void irlmp_link_unitdata_indication(stru
 		irlmp_connless_data_indication(lsap, skb);
 	else {
 		IRDA_DEBUG(0, "%s(), found no matching LSAP!\n", __FUNCTION__);
-		dev_kfree_skb(skb);
 	}
 }
 #endif /* CONFIG_IRDA_ULTRA */
@@ -278,7 +269,7 @@ void irlmp_link_unitdata_indication(stru
 void irlmp_link_disconnect_indication(struct lap_cb *lap, 
 				      struct irlap_cb *irlap, 
 				      LAP_REASON reason, 
-				      struct sk_buff *userdata)
+				      struct sk_buff *skb)
 {
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
@@ -288,9 +279,7 @@ void irlmp_link_disconnect_indication(st
 	lap->reason = reason;
 	lap->daddr = DEV_ADDR_ANY;
 
-        /* FIXME: must do something with the userdata if any */
-	if (userdata)
-		dev_kfree_skb(userdata);
+        /* FIXME: must do something with the skb if any */
 	
 	/*
 	 *  Inform station state machine
@@ -327,7 +316,7 @@ void irlmp_link_connect_indication(struc
  *
  */
 void irlmp_link_connect_confirm(struct lap_cb *self, struct qos_info *qos, 
-				struct sk_buff *userdata)
+				struct sk_buff *skb)
 {
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
@@ -335,9 +324,7 @@ void irlmp_link_connect_confirm(struct l
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
 	ASSERT(qos != NULL, return;);
 
-	/* Don't need use the userdata for now */
-	if (userdata)
-		dev_kfree_skb(userdata);
+	/* Don't need use the skb for now */
 
 	/* Copy QoS settings for this session */
 	self->qos = qos;
diff -u -p -r linux/net/irda.d9/irnet/irnet_ppp.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda.d9/irnet/irnet_ppp.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/irnet/irnet_ppp.c	Mon May 12 16:53:17 2003
@@ -927,7 +927,7 @@ ppp_irnet_send(struct ppp_channel *	chan
        * Jean II
        */
       DERROR(PPP_ERROR, "IrTTP doesn't like this packet !!! (0x%X)\n", ret);
-      dev_kfree_skb(skb);
+      /* irttp_data_request already free the packet */
     }
 
   DEXIT(PPP_TRACE, "\n");
diff -u -p -r linux/net/irda.d9/irttp.c linux/net/irda/irttp.c
--- linux/net/irda.d9/irttp.c	Mon May 12 10:44:09 2003
+++ linux/net/irda/irttp.c	Mon May 12 17:16:55 2003
@@ -11,7 +11,7 @@
  * 
  *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -259,11 +259,17 @@ static struct sk_buff *irttp_reassemble_
 
 		dev_kfree_skb(frag);
 	}
-	IRDA_DEBUG(2, "%s(), frame len=%d\n",  __FUNCTION__, n);
 
-	IRDA_DEBUG(2, "%s(), rx_sdu_size=%d\n",  __FUNCTION__,
-		   self->rx_sdu_size);
-	ASSERT(n <= self->rx_sdu_size, return NULL;);
+	IRDA_DEBUG(2,
+		   "%s(), frame len=%d, rx_sdu_size=%d, rx_max_sdu_size=%d\n",
+		   __FUNCTION__, n, self->rx_sdu_size, self->rx_max_sdu_size);
+	/* Note : irttp_run_rx_queue() calculate self->rx_sdu_size
+	 * by summing the size of all fragments, so we should always
+	 * have n == self->rx_sdu_size, except in cases where we
+	 * droped the last fragment (when self->rx_sdu_size exceed
+	 * self->rx_max_sdu_size), where n < self->rx_sdu_size.
+	 * Jean II */
+	ASSERT(n <= self->rx_sdu_size, n = self->rx_sdu_size;);
 
 	/* Set the new length */
 	skb_trim(skb, n);
@@ -537,19 +543,23 @@ int irttp_udata_request(struct tsap_cb *
 	if ((skb->len == 0) || (!self->connected)) {
 		IRDA_DEBUG(1, "%s(), No data, or not connected\n",
 			   __FUNCTION__);
-		return -1;
+		goto err;
 	}
 
 	if (skb->len > self->max_seg_size) {
 		IRDA_DEBUG(1, "%s(), UData is to large for IrLAP!\n",
 			   __FUNCTION__);
-		return -1;
+		goto err;
 	}
 
 	irlmp_udata_request(self->lsap, skb);
 	self->stats.tx_packets++;
 
 	return 0;
+
+err:
+	dev_kfree_skb(skb);
+	return -1;
 }
 
 /*
@@ -561,6 +571,7 @@ int irttp_udata_request(struct tsap_cb *
 int irttp_data_request(struct tsap_cb *self, struct sk_buff *skb)
 {
 	__u8 *frame;
+	int ret;
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
@@ -572,7 +583,8 @@ int irttp_data_request(struct tsap_cb *s
 	/* Check that nothing bad happens */
 	if ((skb->len == 0) || (!self->connected)) {
 		WARNING("%s: No data, or not connected\n", __FUNCTION__);
-		return -ENOTCONN;
+		ret = -ENOTCONN;
+		goto err;
 	}
 
 	/*
@@ -582,7 +594,8 @@ int irttp_data_request(struct tsap_cb *s
 	if ((self->tx_max_sdu_size == 0) && (skb->len > self->max_seg_size)) {
 		ERROR("%s: SAR disabled, and data is to large for IrLAP!\n",
 				__FUNCTION__);
-		return -EMSGSIZE;
+		ret = -EMSGSIZE;
+		goto err;
 	}
 
 	/*
@@ -595,7 +608,8 @@ int irttp_data_request(struct tsap_cb *s
 	{
 		ERROR("%s: SAR enabled, but data is larger than TxMaxSduSize!\n",
 		      __FUNCTION__);
-		return -EMSGSIZE;
+		ret = -EMSGSIZE;
+		goto err;
 	}
 	/*
 	 *  Check if transmit queue is full
@@ -607,8 +621,9 @@ int irttp_data_request(struct tsap_cb *s
 		irttp_run_tx_queue(self);
 
 		/* Drop packet. This error code should trigger the caller
-		 * to requeue the packet in the client code - Jean II */
-		return -ENOBUFS;
+		 * to resend the data in the client code - Jean II */
+		ret = -ENOBUFS;
+		goto err;
 	}
 
 	/* Queue frame, or queue frame segments */
@@ -651,6 +666,10 @@ int irttp_data_request(struct tsap_cb *s
 	irttp_run_tx_queue(self);
 
 	return 0;
+
+err:
+	dev_kfree_skb(skb);
+	return ret;
 }
 
 /*
@@ -822,6 +841,7 @@ static int irttp_udata_indication(void *
 				  struct sk_buff *skb)
 {
 	struct tsap_cb *self;
+	int err;
 
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
@@ -831,14 +851,19 @@ static int irttp_udata_indication(void *
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
 	ASSERT(skb != NULL, return -1;);
 
-	/* Just pass data to layer above */
-	if (self->notify.udata_indication)
-		self->notify.udata_indication(self->notify.instance, self,skb);
-	else
-		dev_kfree_skb(skb);
-
 	self->stats.rx_packets++;
 
+	/* Just pass data to layer above */
+	if (self->notify.udata_indication) {
+		err = self->notify.udata_indication(self->notify.instance,
+						    self,skb);
+		/* Same comment as in irttp_do_data_indication() */
+		if (err != -ENOMEM) 
+			return 0;
+	}
+	/* Either no handler, or -ENOMEM */
+	dev_kfree_skb(skb);
+
 	return 0;
 }
 
@@ -1040,7 +1065,7 @@ int irttp_connect_request(struct tsap_cb
 			  struct qos_info *qos, __u32 max_sdu_size,
 			  struct sk_buff *userdata)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	__u8 *frame;
 	__u8 n;
 
@@ -1049,19 +1074,22 @@ int irttp_connect_request(struct tsap_cb
 	ASSERT(self != NULL, return -EBADR;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -EBADR;);
 
-	if (self->connected)
+	if (self->connected) {
+		if(userdata)
+			dev_kfree_skb(userdata);
 		return -EISCONN;
+	}
 
 	/* Any userdata supplied? */
 	if (userdata == NULL) {
-		skb = dev_alloc_skb(64);
-		if (!skb)
+		tx_skb = dev_alloc_skb(64);
+		if (!tx_skb)
 			return -ENOMEM;
 
 		/* Reserve space for MUX_CONTROL and LAP header */
-		skb_reserve(skb, TTP_MAX_HEADER);
+		skb_reserve(tx_skb, TTP_MAX_HEADER);
 	} else {
-		skb = userdata;
+		tx_skb = userdata;
 		/*
 		 *  Check that the client has reserved enough space for
 		 *  headers
@@ -1094,11 +1122,11 @@ int irttp_connect_request(struct tsap_cb
 
 	/* SAR enabled? */
 	if (max_sdu_size > 0) {
-		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER + TTP_SAR_HEADER),
+		ASSERT(skb_headroom(tx_skb) >= (TTP_MAX_HEADER + TTP_SAR_HEADER),
 		       return -1;);
 
 		/* Insert SAR parameters */
-		frame = skb_push(skb, TTP_HEADER+TTP_SAR_HEADER);
+		frame = skb_push(tx_skb, TTP_HEADER+TTP_SAR_HEADER);
 
 		frame[0] = TTP_PARAMETERS | n;
 		frame[1] = 0x04; /* Length */
@@ -1109,7 +1137,7 @@ int irttp_connect_request(struct tsap_cb
 			      (__u16 *)(frame+4));
 	} else {
 		/* Insert plain TTP header */
-		frame = skb_push(skb, TTP_HEADER);
+		frame = skb_push(tx_skb, TTP_HEADER);
 
 		/* Insert initial credit in frame */
 		frame[0] = n & 0x7f;
@@ -1117,7 +1145,7 @@ int irttp_connect_request(struct tsap_cb
 
 	/* Connect with IrLMP. No QoS parameters for now */
 	return irlmp_connect_request(self->lsap, dtsap_sel, saddr, daddr, qos,
-				     skb);
+				     tx_skb);
 }
 
 /*
@@ -1201,7 +1229,8 @@ static void irttp_connect_confirm(void *
 		self->notify.connect_confirm(self->notify.instance, self, qos,
 					     self->tx_max_sdu_size,
 					     self->max_header_size, skb);
-	}
+	} else
+		dev_kfree_skb(skb);
 }
 
 /*
@@ -1286,7 +1315,7 @@ void irttp_connect_indication(void *inst
 int irttp_connect_response(struct tsap_cb *self, __u32 max_sdu_size,
 			   struct sk_buff *userdata)
 {
-	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	__u8 *frame;
 	int ret;
 	__u8 n;
@@ -1299,19 +1328,19 @@ int irttp_connect_response(struct tsap_c
 
 	/* Any userdata supplied? */
 	if (userdata == NULL) {
-		skb = dev_alloc_skb(64);
-		if (!skb)
+		tx_skb = dev_alloc_skb(64);
+		if (!tx_skb)
 			return -ENOMEM;
 
 		/* Reserve space for MUX_CONTROL and LAP header */
-		skb_reserve(skb, TTP_MAX_HEADER);
+		skb_reserve(tx_skb, TTP_MAX_HEADER);
 	} else {
-		skb = userdata;
+		tx_skb = userdata;
 		/*
 		 *  Check that the client has reserved enough space for
 		 *  headers
 		 */
-		ASSERT(skb_headroom(skb) >= TTP_MAX_HEADER, return -1;);
+		ASSERT(skb_headroom(tx_skb) >= TTP_MAX_HEADER, return -1;);
 	}
 
 	self->avail_credit = 0;
@@ -1333,11 +1362,11 @@ int irttp_connect_response(struct tsap_c
 
 	/* SAR enabled? */
 	if (max_sdu_size > 0) {
-		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER+TTP_SAR_HEADER),
+		ASSERT(skb_headroom(tx_skb) >= (TTP_MAX_HEADER+TTP_SAR_HEADER),
 		       return -1;);
 
 		/* Insert TTP header with SAR parameters */
-		frame = skb_push(skb, TTP_HEADER+TTP_SAR_HEADER);
+		frame = skb_push(tx_skb, TTP_HEADER+TTP_SAR_HEADER);
 
 		frame[0] = TTP_PARAMETERS | n;
 		frame[1] = 0x04; /* Length */
@@ -1352,12 +1381,12 @@ int irttp_connect_response(struct tsap_c
 			      (__u16 *)(frame+4));
 	} else {
 		/* Insert TTP header */
-		frame = skb_push(skb, TTP_HEADER);
+		frame = skb_push(tx_skb, TTP_HEADER);
 
 		frame[0] = n & 0x7f;
 	}
 
-	ret = irlmp_connect_response(self->lsap, skb);
+	ret = irlmp_connect_response(self->lsap, tx_skb);
 
 	return ret;
 }
@@ -1423,7 +1452,6 @@ struct tsap_cb *irttp_dup(struct tsap_cb
 int irttp_disconnect_request(struct tsap_cb *self, struct sk_buff *userdata,
 			     int priority)
 {
-	struct sk_buff *skb;
 	int ret;
 
 	ASSERT(self != NULL, return -1;);
@@ -1488,16 +1516,17 @@ int irttp_disconnect_request(struct tsap
 	self->connected = FALSE;
 
 	if (!userdata) {
-		skb = dev_alloc_skb(64);
-		if (!skb)
+		struct sk_buff *tx_skb;
+		tx_skb = dev_alloc_skb(64);
+		if (!tx_skb)
 			return -ENOMEM;
 
 		/*
 		 *  Reserve space for MUX and LAP header
 		 */
-		skb_reserve(skb, TTP_MAX_HEADER);
+		skb_reserve(tx_skb, TTP_MAX_HEADER);
 
-		userdata = skb;
+		userdata = tx_skb;
 	}
 	ret = irlmp_disconnect_request(self->lsap, userdata);
 
@@ -1556,7 +1585,7 @@ void irttp_disconnect_indication(void *i
 /*
  * Function irttp_do_data_indication (self, skb)
  *
- *    Try to deliver reassebled skb to layer above, and requeue it if that
+ *    Try to deliver reassembled skb to layer above, and requeue it if that
  *    for some reason should fail. We mark rx sdu as busy to apply back
  *    pressure is necessary.
  */
