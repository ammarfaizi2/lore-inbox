Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292680AbSCEWhz>; Tue, 5 Mar 2002 17:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSCEWhe>; Tue, 5 Mar 2002 17:37:34 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:22478 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292536AbSCEWgF>;
	Tue, 5 Mar 2002 17:36:05 -0500
Date: Tue, 5 Mar 2002 14:36:03 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir256_lap_icmd_fix-4.diff
Message-ID: <20020305143603.E1254@bougret.hpl.hp.com>
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

ir256_lap_icmd_fix-4.diff :
-------------------------
	o [CORRECT] Fix Tx queue handling (remove race, keep packets in order)
	o [CORRECT] Synchronise window_size & line_capacity and make sure
	  we never forget to increase them (would stall Tx queue)
	o [FEATURE] Group common code out of if-then-else
	o [FEATURE] Don't harcode LAP header size, use proper constant
	o [FEATURE] Inline irlap_next_state() to decrease bloat


diff -u -p linux/include/net/irda/irlap.d4.h linux/include/net/irda/irlap.h
--- linux/include/net/irda/irlap.d4.h	Tue Feb 26 09:49:07 2002
+++ linux/include/net/irda/irlap.h	Mon Mar  4 14:46:16 2002
@@ -11,6 +11,7 @@
  * 
  *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
+ *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -44,6 +45,7 @@
 #define LAP_ADDR_HEADER 1  /* IrLAP Address Header */
 #define LAP_CTRL_HEADER 1  /* IrLAP Control Header */
 
+/* May be different when we get VFIR */
 #define LAP_MAX_HEADER (LAP_ADDR_HEADER + LAP_CTRL_HEADER)
 
 #define BROADCAST  0xffffffff /* Broadcast device address */
@@ -210,9 +212,8 @@ void irlap_wait_min_turn_around(struct i
 void irlap_init_qos_capabilities(struct irlap_cb *, struct qos_info *);
 void irlap_apply_default_connection_parameters(struct irlap_cb *self);
 void irlap_apply_connection_parameters(struct irlap_cb *self, int now);
-void irlap_set_local_busy(struct irlap_cb *self, int status);
 
-#define IRLAP_GET_HEADER_SIZE(self) 2 /* Will be different when we get VFIR */
+#define IRLAP_GET_HEADER_SIZE(self) (LAP_MAX_HEADER)
 #define IRLAP_GET_TX_QUEUE_LEN(self) skb_queue_len(&self->txq)
 
 #endif
diff -u -p linux/include/net/irda/irlap_event.d4.h linux/include/net/irda/irlap_event.h
--- linux/include/net/irda/irlap_event.d4.h	Tue Feb 26 09:49:16 2002
+++ linux/include/net/irda/irlap_event.h	Mon Mar  4 14:46:16 2002
@@ -134,7 +134,6 @@ extern const char *irlap_state[];
 
 void irlap_do_event(struct irlap_cb *self, IRLAP_EVENT event, 
 		    struct sk_buff *skb, struct irlap_info *info);
-void irlap_next_state(struct irlap_cb *self, IRLAP_STATE state);
 void irlap_print_event(IRLAP_EVENT event);
 
 extern int irlap_qos_negotiate(struct irlap_cb *self, struct sk_buff *skb);
diff -u -p linux/net/irda/irlap.d4.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d4.c	Tue Feb 26 09:49:38 2002
+++ linux/net/irda/irlap.c	Tue Feb 26 09:51:26 2002
@@ -131,7 +131,7 @@ struct irlap_cb *irlap_open(struct net_d
 	/* FIXME: should we get our own field? */
 	dev->atalk_ptr = self;
 
-	irlap_next_state(self, LAP_OFFLINE);
+	self->state = LAP_OFFLINE;
 
 	/* Initialize transmit queue */
 	skb_queue_head_init(&self->txq);
@@ -155,7 +155,7 @@ struct irlap_cb *irlap_open(struct net_d
 
 	self->N3 = 3; /* # connections attemts to try before giving up */
 	
-	irlap_next_state(self, LAP_NDM);
+	self->state = LAP_NDM;
 
 	hashbin_insert(irlap, (irda_queue_t *) self, self->saddr, NULL);
 
@@ -346,25 +346,21 @@ void irlap_data_request(struct irlap_cb 
 	else
 		skb->data[1] = I_FRAME;
 
+	/* Add at the end of the queue (keep ordering) - Jean II */
+	skb_queue_tail(&self->txq, skb);
+
 	/* 
 	 *  Send event if this frame only if we are in the right state 
 	 *  FIXME: udata should be sent first! (skb_queue_head?)
 	 */
   	if ((self->state == LAP_XMIT_P) || (self->state == LAP_XMIT_S)) {
-		/*
-		 *  Check if the transmit queue contains some unsent frames,
-		 *  and if so, make sure they are sent first
-		 */
-		if (!skb_queue_empty(&self->txq)) {
-			skb_queue_tail(&self->txq, skb);
-			skb = skb_dequeue(&self->txq);
-			
-			ASSERT(skb != NULL, return;);
-		}
-		irlap_do_event(self, SEND_I_CMD, skb, NULL);
-		kfree_skb(skb);
-	} else
-		skb_queue_tail(&self->txq, skb);
+		/* If we are not already processing the Tx queue, trigger
+		 * transmission immediately - Jean II */
+		if((skb_queue_len(&self->txq) <= 1) && (!self->local_busy))
+			irlap_do_event(self, DATA_REQUEST, skb, NULL);
+		/* Otherwise, the packets will be sent normally at the
+		 * next pf-poll - Jean II */
+	}
 }
 
 /*
@@ -1013,6 +1009,7 @@ void irlap_apply_connection_parameters(s
 	self->window_size = self->qos_tx.window_size.value;
 	self->window      = self->qos_tx.window_size.value;
 
+#ifdef CONFIG_IRDA_DYNAMIC_WINDOW
 	/*
 	 *  Calculate how many bytes it is possible to transmit before the
 	 *  link must be turned around
@@ -1020,6 +1017,8 @@ void irlap_apply_connection_parameters(s
 	self->line_capacity = 
 		irlap_max_line_capacity(self->qos_tx.baud_rate.value,
 					self->qos_tx.max_turn_time.value);
+	self->bytes_left = self->line_capacity;
+#endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
 
 	
 	/* 
@@ -1080,24 +1079,6 @@ void irlap_apply_connection_parameters(s
 	self->N2 = self->qos_tx.link_disc_time.value * 1000 / 
 		self->qos_rx.max_turn_time.value;
 	IRDA_DEBUG(4, "Setting N2 = %d\n", self->N2);
-}
-
-/*
- * Function irlap_set_local_busy (self, status)
- *
- *    
- *
- */
-void irlap_set_local_busy(struct irlap_cb *self, int status)
-{
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
-	self->local_busy = status;
-	
-	if (status)
-		IRDA_DEBUG(0, __FUNCTION__ "(), local busy ON\n");
-	else
-		IRDA_DEBUG(0, __FUNCTION__ "(), local busy OFF\n");
 }
 
 #ifdef CONFIG_PROC_FS
diff -u -p linux/net/irda/irlap_event.d4.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d4.c	Tue Feb 26 09:49:55 2002
+++ linux/net/irda/irlap_event.c	Tue Feb 26 09:51:26 2002
@@ -252,6 +252,9 @@ void irlap_do_event(struct irlap_cb *sel
 		 * that will change the state away form XMIT
 		 */
 		if (skb_queue_len(&self->txq)) {
+			/* Prevent race conditions with irlap_data_request() */
+			self->local_busy = TRUE;
+
 			/* Try to send away all queued data frames */
 			while ((skb = skb_dequeue(&self->txq)) != NULL) {
 				ret = (*state[self->state])(self, SEND_I_CMD,
@@ -260,6 +263,8 @@ void irlap_do_event(struct irlap_cb *sel
 				if (ret == -EPROTO)
 					break; /* Try again later! */
 			}
+			/* Finished transmitting */
+			self->local_busy = FALSE;
 		} else if (self->disconnect_pending) {
 			self->disconnect_pending = FALSE;
 			
@@ -282,25 +287,15 @@ void irlap_do_event(struct irlap_cb *sel
  *    Switches state and provides debug information
  *
  */
-void irlap_next_state(struct irlap_cb *self, IRLAP_STATE state) 
+static inline void irlap_next_state(struct irlap_cb *self, IRLAP_STATE state) 
 {	
+	/*
 	if (!self || self->magic != LAP_MAGIC)
 		return;
 	
 	IRDA_DEBUG(4, "next LAP state = %s\n", irlap_state[state]);
-
+	*/
 	self->state = state;
-
-#ifdef CONFIG_IRDA_DYNAMIC_WINDOW
-	/*
-	 *  If we are swithing away from a XMIT state then we are allowed to 
-	 *  transmit a maximum number of bytes again when we enter the XMIT 
-	 *  state again. Since its possible to "switch" from XMIT to XMIT,
-	 *  we cannot do this when swithing into the XMIT state :-)
-	 */
-	if ((state != LAP_XMIT_P) && (state != LAP_XMIT_S))
-		self->bytes_left = self->line_capacity;
-#endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
 }
 
 /*
@@ -1017,6 +1012,12 @@ static int irlap_state_xmit_p(struct irl
 		IRDA_DEBUG(3, __FUNCTION__ "(), POLL_TIMER_EXPIRED (%ld)\n",
 			   jiffies);
 		irlap_send_rr_frame(self, CMD_FRAME);
+		/* Return to NRM properly - Jean II  */
+		self->window = self->window_size;
+#ifdef CONFIG_IRDA_DYNAMIC_WINDOW
+		/* Allowed to transmit a maximum number of bytes again. */
+		self->bytes_left = self->line_capacity;
+#endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
 		irlap_start_final_timer(self, self->final_timeout);
 		irlap_next_state(self, LAP_NRM_P);
 		break;
@@ -1029,6 +1030,10 @@ static int irlap_state_xmit_p(struct irl
 		self->retry_count = 0;
 		irlap_next_state(self, LAP_PCLOSE);
 		break;
+	case DATA_REQUEST:
+		/* Nothing to do, irlap_do_event() will send the packet
+		 * when we return... - Jean II */
+		break;
 	default:
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);
@@ -1645,12 +1650,17 @@ static int irlap_state_xmit_s(struct irl
 			 */
 			if (skb->len > self->bytes_left) {
 				skb_queue_head(&self->txq, skb_get(skb));
+
 				/*
 				 *  Switch to NRM_S, this is only possible
 				 *  when we are in secondary mode, since we 
 				 *  must be sure that we don't miss any RR
 				 *  frames
 				 */
+				self->window = self->window_size;
+				self->bytes_left = self->line_capacity;
+				irlap_start_wd_timer(self, self->wd_timeout);
+
 				irlap_next_state(self, LAP_NRM_S);
 
 				return -EPROTO; /* Try again later */
@@ -1687,6 +1697,10 @@ static int irlap_state_xmit_s(struct irl
 		irlap_flush_all_queues(self);
 		irlap_start_wd_timer(self, self->wd_timeout);
 		irlap_next_state(self, LAP_SCLOSE);
+		break;
+	case DATA_REQUEST:
+		/* Nothing to do, irlap_do_event() will send the packet
+		 * when we return... - Jean II */
 		break;
 	default:
 		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
diff -u -p linux/net/irda/irlap_frame.d4.c linux/net/irda/irlap_frame.c
--- linux/net/irda/irlap_frame.d4.c	Tue Feb 26 09:50:14 2002
+++ linux/net/irda/irlap_frame.c	Tue Feb 26 09:51:26 2002
@@ -768,6 +768,9 @@ void irlap_send_data_primary_poll(struct
 {
 	struct sk_buff *tx_skb;
 
+	/* Stop P timer */
+	del_timer(&self->poll_timer);
+		
 	/* Is this reliable or unreliable data? */
 	if (skb->data[1] == I_FRAME) {
 		
@@ -793,23 +796,15 @@ void irlap_send_data_primary_poll(struct
 		 *  skb, since retransmitted need to set or clear the poll
 		 *  bit depending on when they are sent.  
 		 */
-		/* Stop P timer */
-		del_timer(&self->poll_timer);
-		
 		tx_skb->data[1] |= PF_BIT;
 		
 		self->vs = (self->vs + 1) % 8;
 		self->ack_required = FALSE;
-		self->window = self->window_size;
-
-		irlap_start_final_timer(self, self->final_timeout);
 
 		irlap_send_i_frame(self, tx_skb, CMD_FRAME);
 	} else {
 		IRDA_DEBUG(4, __FUNCTION__ "(), sending unreliable frame\n");
 
-		del_timer(&self->poll_timer);
-
 		if (self->ack_required) {
 			irlap_send_ui_frame(self, skb_get(skb), self->caddr, CMD_FRAME);
 			irlap_send_rr_frame(self, CMD_FRAME);
@@ -818,9 +813,15 @@ void irlap_send_data_primary_poll(struct
 			skb->data[1] |= PF_BIT;
 			irlap_send_ui_frame(self, skb_get(skb), self->caddr, CMD_FRAME);
 		}
-		self->window = self->window_size;
-		irlap_start_final_timer(self, self->final_timeout);
 	}
+
+	self->window = self->window_size;
+#ifdef CONFIG_IRDA_DYNAMIC_WINDOW
+	/* We are allowed to transmit a maximum number of bytes again. */
+	self->bytes_left = self->line_capacity;
+#endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
+
+	irlap_start_final_timer(self, self->final_timeout);
 }
 
 /*
@@ -858,11 +859,8 @@ void irlap_send_data_secondary_final(str
 		tx_skb->data[1] |= PF_BIT;
 		
 		self->vs = (self->vs + 1) % 8; 
-		self->window = self->window_size;
 		self->ack_required = FALSE;
 		
-		irlap_start_wd_timer(self, self->wd_timeout);
-
 		irlap_send_i_frame(self, tx_skb, RSP_FRAME); 
 	} else {
 		if (self->ack_required) {
@@ -873,10 +871,15 @@ void irlap_send_data_secondary_final(str
 			skb->data[1] |= PF_BIT;
 			irlap_send_ui_frame(self, skb_get(skb), self->caddr, RSP_FRAME);
 		}
-		self->window = self->window_size;
-
-		irlap_start_wd_timer(self, self->wd_timeout);
 	}
+
+	self->window = self->window_size;
+#ifdef CONFIG_IRDA_DYNAMIC_WINDOW
+	/* We are allowed to transmit a maximum number of bytes again. */
+	self->bytes_left = self->line_capacity;
+#endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
+
+	irlap_start_wd_timer(self, self->wd_timeout);
 }
 
 /*
