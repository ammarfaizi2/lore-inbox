Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTBTX5p>; Thu, 20 Feb 2003 18:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbTBTX5p>; Thu, 20 Feb 2003 18:57:45 -0500
Received: from palrel13.hp.com ([156.153.255.238]:37262 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id <S267285AbTBTX5g>;
	Thu, 20 Feb 2003 18:57:36 -0500
Date: Thu, 20 Feb 2003 16:07:41 -0800
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : IrLAP dynamic window code fix
Message-ID: <20030221000741.GC26770@bougret.hpl.hp.com>
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

ir253_dynamic_fix-2.diff :
------------------------
	o [FEATURE] Fix the dynamic window code to properly send the pf bit.
		Increase perf by 40% for large packets at SIR.


diff -u -p linux/net/irda/irlap_event.d6.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d6.c	Fri Nov  1 17:40:28 2002
+++ linux/net/irda/irlap_event.c	Mon Nov  4 14:54:45 2002
@@ -982,15 +982,48 @@ static int irlap_state_xmit_p(struct irl
 		 *  Only send frame if send-window > 0.
 		 */
 		if ((self->window > 0) && (!self->remote_busy)) {
+			int nextfit;
 #ifdef CONFIG_IRDA_DYNAMIC_WINDOW
+			struct sk_buff *skb_next;
+
+			/* With DYNAMIC_WINDOW, we keep the window size
+			 * maximum, and adapt on the packets we are sending.
+			 * At 115k, we can send only 2 packets of 2048 bytes
+			 * in a 500 ms turnaround. Without this option, we
+			 * would always limit the window to 2. With this
+			 * option, if we send smaller packets, we can send
+			 * up to 7 of them (always depending on QoS).
+			 * Jean II */
+
+			/* Look at the next skb. This is safe, as we are
+			 * the only consumer of the Tx queue (if we are not,
+			 * we have other problems) - Jean II */
+			skb_next = skb_peek(&self->txq);
+
+			/* Check if a subsequent skb exist and would fit in
+			 * the current window (with respect to turnaround
+			 * time).
+			 * This allow us to properly mark the current packet
+			 * with the pf bit, to avoid falling back on the
+			 * second test below, and avoid waiting the
+			 * end of the window and sending a extra RR.
+			 * Note : (skb_next != NULL) <=> (skb_queue_len() > 0)
+			 * Jean II */
+			nextfit = ((skb_next != NULL) &&
+				   ((skb_next->len + skb->len) <=
+				    self->bytes_left));
+
 			/*
+			 * The current packet may not fit ! Because of test
+			 * above, this should not happen any more !!!
 			 *  Test if we have transmitted more bytes over the
 			 *  link than its possible to do with the current
 			 *  speed and turn-around-time.
 			 */
-			if (skb->len > self->bytes_left) {
-				IRDA_DEBUG(4, "%s(), Not allowed to transmit"
+			if((!nextfit) && (skb->len > self->bytes_left)) {
+				IRDA_DEBUG(0, "%s(), Not allowed to transmit"
 					   " more bytes!\n", __FUNCTION__);
+				/* Requeue the skb */
 				skb_queue_head(&self->txq, skb_get(skb));
 				/*
 				 *  We should switch state to LAP_NRM_P, but
@@ -1000,20 +1033,33 @@ static int irlap_state_xmit_p(struct irl
 				 *  trigger anyway now, so we just wait for it
 				 *  DB
 				 */
+				/*
+				 * Sorry, but that's not totally true. If
+				 * we send 2000B packets, we may wait another
+				 * 1000B until our turnaround expire. That's
+				 * why we need to be proactive in avoiding
+				 * comming here. - Jean II
+				 */
 				return -EPROTO;
 			}
+
+			/* Substract space used by this skb */
 			self->bytes_left -= skb->len;
-#endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
+#else	/* CONFIG_IRDA_DYNAMIC_WINDOW */
+			/* Window has been adjusted for the max packet
+			 * size, so much simpler... - Jean II */
+			nextfit = (skb_queue_len(&self->txq) > 0);
+#endif	/* CONFIG_IRDA_DYNAMIC_WINDOW */
 			/*
 			 *  Send data with poll bit cleared only if window > 1
 			 *  and there is more frames after this one to be sent
 			 */
-			if ((self->window > 1) &&
-			    skb_queue_len( &self->txq) > 0)
-			{
+			if ((self->window > 1) && (nextfit)) {
+				/* More packet to send in current window */
 				irlap_send_data_primary(self, skb);
 				irlap_next_state(self, LAP_XMIT_P);
 			} else {
+				/* Final packet of window */
 				irlap_send_data_primary_poll(self, skb);
 				irlap_next_state(self, LAP_NRM_P);
 
@@ -1683,16 +1729,37 @@ static int irlap_state_xmit_s(struct irl
 	switch (event) {
 	case SEND_I_CMD:
 		/*
-		 *  Send frame only if send window > 1
+		 *  Send frame only if send window > 0
 		 */
 		if ((self->window > 0) && (!self->remote_busy)) {
+			int nextfit;
 #ifdef CONFIG_IRDA_DYNAMIC_WINDOW
+			struct sk_buff *skb_next;
+
+			/*
+			 * Same deal as in irlap_state_xmit_p(), so see
+			 * the comments at that point.
+			 * We are the secondary, so there are only subtle
+			 * differences. - Jean II
+			 */
+
+			/* Check if a subsequent skb exist and would fit in
+			 * the current window (with respect to turnaround
+			 * time). - Jean II */
+			skb_next = skb_peek(&self->txq);
+			nextfit = ((skb_next != NULL) &&
+				   ((skb_next->len + skb->len) <=
+				    self->bytes_left));
+
 			/*
 			 *  Test if we have transmitted more bytes over the
 			 *  link than its possible to do with the current
 			 *  speed and turn-around-time.
 			 */
-			if (skb->len > self->bytes_left) {
+			if((!nextfit) && (skb->len > self->bytes_left)) {
+				IRDA_DEBUG(0, "%s(), Not allowed to transmit"
+					   " more bytes!\n", __FUNCTION__);
+				/* Requeue the skb */
 				skb_queue_head(&self->txq, skb_get(skb));
 
 				/*
@@ -1706,18 +1773,24 @@ static int irlap_state_xmit_s(struct irl
 				irlap_start_wd_timer(self, self->wd_timeout);
 
 				irlap_next_state(self, LAP_NRM_S);
+				/* Slight difference with primary :
+				 * here we would wait for the other side to
+				 * expire the turnaround. - Jean II */
 
 				return -EPROTO; /* Try again later */
 			}
+			/* Substract space used by this skb */
 			self->bytes_left -= skb->len;
+#else	/* CONFIG_IRDA_DYNAMIC_WINDOW */
+			/* Window has been adjusted for the max packet
+			 * size, so much simpler... - Jean II */
+			nextfit = (skb_queue_len(&self->txq) > 0);
 #endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
 			/*
 			 *  Send data with final bit cleared only if window > 1
 			 *  and there is more frames to be sent
 			 */
-			if ((self->window > 1) &&
-			    skb_queue_len(&self->txq) > 0)
-			{
+			if ((self->window > 1) && (nextfit)) {
 				irlap_send_data_secondary(self, skb);
 				irlap_next_state(self, LAP_XMIT_S);
 			} else {
