Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUAHCc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUAHCcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:32:46 -0500
Received: from palrel12.hp.com ([156.153.255.237]:14772 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263491AbUAHCcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:32:35 -0500
Date: Wed, 7 Jan 2004 18:32:34 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] F-timer fix
Message-ID: <20040108023234.GB13620@bougret.hpl.hp.com>
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

ir2609_irlap_final_timer-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Proper calculation for F-timer. Improve interoperability.


diff -u -p linux/include/net/irda/timer.d4.h linux/include/net/irda/timer.h
--- linux/include/net/irda/timer.d4.h	Mon Nov 17 15:39:13 2003
+++ linux/include/net/irda/timer.h	Mon Nov 17 16:34:59 2003
@@ -40,14 +40,14 @@ struct lsap_cb;
 struct lap_cb;
 
 /* 
- *  Timeout definitions, some defined in IrLAP p. 92
+ *  Timeout definitions, some defined in IrLAP 6.13.5 - p. 92
  */
 #define POLL_TIMEOUT        (450*HZ/1000)    /* Must never exceed 500 ms */
 #define FINAL_TIMEOUT       (500*HZ/1000)    /* Must never exceed 500 ms */
 
 /* 
- *  Normally twice of p-timer. Note 3, IrLAP p. 60 suggests at least twice 
- *  duration of the P-timer.
+ *  Normally twice of p-timer. Note 3, IrLAP 6.3.11.2 - p. 60 suggests
+ *  at least twice duration of the P-timer.
  */
 #define WD_TIMEOUT          (POLL_TIMEOUT*2)
 
 diff -u -p linux/net/irda/irlap_event.d4.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d4.c	Mon Nov 17 15:37:57 2003
+++ linux/net/irda/irlap_event.c	Mon Nov 17 17:03:12 2003
@@ -932,6 +932,12 @@ static int irlap_state_setup(struct irla
 		/* This frame will actually be sent at the new speed */
 		irlap_send_rr_frame(self, CMD_FRAME);
 
+		/* The timer is set to half the normal timer to quickly
+		 * detect a failure to negociate the new connection
+		 * parameters. IrLAP 6.11.3.2, note 3.
+		 * Note that currently we don't process this failure
+		 * properly, as we should do a quick disconnect.
+		 * Jean II */
 		irlap_start_final_timer(self, self->final_timeout/2);
 		irlap_next_state(self, LAP_NRM_P);
 
@@ -1312,7 +1318,12 @@ static int irlap_state_nrm_p(struct irla
 				irlap_resend_rejected_frames(self, CMD_FRAME);
 
 				self->ack_required = FALSE;
-				irlap_start_final_timer(self, self->final_timeout);
+
+				/* Make sure we account for the time
+				 * to transmit our frames. See comemnts
+				 * in irlap_send_data_primary_poll().
+				 * Jean II */
+				irlap_start_final_timer(self, 2 * self->final_timeout);
 
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_P);
@@ -1352,8 +1363,9 @@ static int irlap_state_nrm_p(struct irla
 				/* Resend rejected frames */
 				irlap_resend_rejected_frames(self, CMD_FRAME);
 
-				/* Give peer some time to retransmit! */
-				irlap_start_final_timer(self, self->final_timeout);
+				/* Give peer some time to retransmit! 
+				 * But account for our own Tx. */
+				irlap_start_final_timer(self, 2 * self->final_timeout);
 
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_P);
@@ -1450,6 +1462,8 @@ static int irlap_state_nrm_p(struct irla
 			/* Resend rejected frames */
 			irlap_resend_rejected_frames(self, CMD_FRAME);
 
+			/* Final timer ??? Jean II */
+
 			irlap_next_state(self, LAP_NRM_P);
 		} else if (ret == NR_INVALID) {
 			IRDA_DEBUG(1, "%s(), Received RR with "
@@ -1541,7 +1555,7 @@ static int irlap_state_nrm_p(struct irla
 			irlap_send_rr_frame(self, CMD_FRAME);
 		} else
 			irlap_resend_rejected_frames(self, CMD_FRAME);
-		irlap_start_final_timer(self, self->final_timeout);
+		irlap_start_final_timer(self, 2 * self->final_timeout);
 		break;
 	case RECV_SREJ_RSP:
 		irlap_update_nr_received(self, info->nr);
@@ -1550,7 +1564,7 @@ static int irlap_state_nrm_p(struct irla
 			irlap_send_rr_frame(self, CMD_FRAME);
 		} else
 			irlap_resend_rejected_frame(self, CMD_FRAME);
-		irlap_start_final_timer(self, self->final_timeout);
+		irlap_start_final_timer(self, 2 * self->final_timeout);
 		break;
 	case RECV_RD_RSP:
 		IRDA_DEBUG(1, "%s(), RECV_RD_RSP\n", __FUNCTION__);
diff -u -p linux/net/irda/irlap_frame.d4.c linux/net/irda/irlap_frame.c
--- linux/net/irda/irlap_frame.d4.c	Mon Nov 17 16:09:09 2003
+++ linux/net/irda/irlap_frame.c	Mon Nov 17 17:09:07 2003
@@ -779,6 +779,7 @@ void irlap_send_data_primary(struct irla
 void irlap_send_data_primary_poll(struct irlap_cb *self, struct sk_buff *skb)
 {
 	struct sk_buff *tx_skb;
+	int transmission_time;
 
 	/* Stop P timer */
 	del_timer(&self->poll_timer);
@@ -829,13 +830,49 @@ void irlap_send_data_primary_poll(struct
 		}
 	}
 
+	/* How much time we took for transmission of all frames.
+	 * We don't know, so let assume we used the full window. Jean II */
+	transmission_time = self->final_timeout;
+
+	/* Reset parameter so that we can fill next window */
 	self->window = self->window_size;
+
 #ifdef CONFIG_IRDA_DYNAMIC_WINDOW
+	/* Remove what we have not used. Just do a prorata of the
+	 * bytes left in window to window capacity.
+	 * See max_line_capacities[][] in qos.c for details. Jean II */
+	transmission_time -= (self->final_timeout * self->bytes_left
+			      / self->line_capacity);
+	IRDA_DEBUG(4, "%s() adjusting transmission_time : ft=%d, bl=%d, lc=%d -> tt=%d\n", __FUNCTION__, self->final_timeout, self->bytes_left, self->line_capacity, transmission_time);
+
 	/* We are allowed to transmit a maximum number of bytes again. */
 	self->bytes_left = self->line_capacity;
 #endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
 
-	irlap_start_final_timer(self, self->final_timeout);
+	/*
+	 * The network layer has a intermediate buffer between IrLAP
+	 * and the IrDA driver which can contain 8 frames. So, even
+	 * though IrLAP is currently sending the *last* frame of the
+	 * tx-window, the driver most likely has only just started
+	 * sending the *first* frame of the same tx-window.
+	 * I.e. we are always at the very begining of or Tx window.
+	 * Now, we are supposed to set the final timer from the end
+	 * of our tx-window to let the other peer reply. So, we need
+	 * to add extra time to compensate for the fact that we
+	 * are really at the start of tx-window, otherwise the final timer
+	 * might expire before he can answer...
+	 * Jean II
+	 */
+	irlap_start_final_timer(self, self->final_timeout + transmission_time);
+
+	/*
+	 * The clever amongst you might ask why we do this adjustement
+	 * only here, and not in all the other cases in irlap_event.c.
+	 * In all those other case, we only send a very short management
+	 * frame (few bytes), so the adjustement would be lost in the
+	 * noise...
+	 * The exception of course is irlap_resend_rejected_frame().
+	 * Jean II */
 }
 
 /*
@@ -1003,7 +1040,7 @@ void irlap_resend_rejected_frames(struct
 	}
 #if 0 /* Not yet */
 	/*
-	 *  We can now fill the window with additinal data frames
+	 *  We can now fill the window with additional data frames
 	 */
 	while (skb_queue_len( &self->txq) > 0) {
 
