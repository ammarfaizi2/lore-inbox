Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbQKKVm2>; Sat, 11 Nov 2000 16:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129553AbQKKVmJ>; Sat, 11 Nov 2000 16:42:09 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:64265 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129551AbQKKVmC>; Sat, 11 Nov 2000 16:42:02 -0500
Date: Sat, 11 Nov 2000 21:43:00 GMT
Message-Id: <200011112143.VAA32892@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda23 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda23 (was: Re: The IrDA patches)
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

The name of this patch is irda23.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda23.diff :
-----------------
	o [CRITICA] Don't crash on malformed discovery frames
	o [CORRECT] Don't divide self->N1, because -1/2 = 0
	o [CORRECT] Correctly transmit Ultra frames sent while doing discovery

diff -urpN old-linux/include/net/irda/timer.h linux/include/net/irda/timer.h
--- old-linux/include/net/irda/timer.h	Thu Nov  9 13:36:27 2000
+++ linux/include/net/irda/timer.h	Thu Nov  9 18:26:03 2000
@@ -76,6 +76,7 @@ inline void irlap_start_wd_timer(struct 
 inline void irlap_start_backoff_timer(struct irlap_cb *self, int timeout);
 
 void irlap_start_mbusy_timer(struct irlap_cb *);
+void irlap_stop_mbusy_timer(struct irlap_cb *);
 
 struct lsap_cb;
 struct lap_cb;
diff -urpN old-linux/net/irda/irda_device.c linux/net/irda/irda_device.c
--- old-linux/net/irda/irda_device.c	Thu Nov  9 17:09:30 2000
+++ linux/net/irda/irda_device.c	Thu Nov  9 18:26:03 2000
@@ -185,7 +185,7 @@ void irda_device_set_media_busy(struct n
 		IRDA_DEBUG( 4, "Media busy!\n");
 	} else {
 		self->media_busy = FALSE;
-		del_timer(&self->media_busy_timer);
+		irlap_stop_mbusy_timer(self);
 	}
 }
 
diff -urpN old-linux/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- old-linux/net/irda/irlap_event.c	Thu Nov  9 18:16:46 2000
+++ linux/net/irda/irlap_event.c	Thu Nov  9 18:26:03 2000
@@ -305,6 +305,17 @@ void irlap_next_state(struct irlap_cb *s
 	if ((state != LAP_XMIT_P) && (state != LAP_XMIT_S))
 		self->bytes_left = self->line_capacity;
 #endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
+#ifdef CONFIG_IRDA_ULTRA
+	/* Send any pending Ultra frames if any */
+	/* The higher layers may have sent a few Ultra frames while we
+	 * were doing discovery (either query or reply). Those frames
+	 * have been queued, but were never sent. It is now time to
+	 * send them...
+	 * Jean II */
+	if ((state == LAP_NDM) && (!skb_queue_empty(&self->txq_ultra)))
+		/* Force us to listen 500 ms before sending Ultra */
+		irda_device_set_media_busy(self->netdev, TRUE);
+#endif /* CONFIG_IRDA_ULTRA */
 }
 
 /*
@@ -1903,20 +1914,25 @@ static int irlap_state_nrm_s(struct irla
 		/*
 		 *  Wait until retry_count * n matches negotiated threshold/
 		 *  disconnect time (note 2 in IrLAP p. 82)
+		 *
+		 * Note : self->wd_timeout = (self->poll_timeout * 2),
+		 *   and self->final_timeout == self->poll_timeout,
+		 *   which explain why we use (self->retry_count * 2) here !!!
+		 * Jean II
 		 */
 		IRDA_DEBUG(1, __FUNCTION__ "(), retry_count = %d\n", 
 			   self->retry_count);
 
-		if ((self->retry_count < (self->N2/2))  && 
-		    (self->retry_count != self->N1/2)) {
+		if (((self->retry_count * 2) < self->N2)  && 
+		    ((self->retry_count * 2) != self->N1)) {
 			
 			irlap_start_wd_timer(self, self->wd_timeout);
-			self->retry_count++;		
-		} else if (self->retry_count == (self->N1/2)) {
+			self->retry_count++;
+		} else if ((self->retry_count * 2) == self->N1) {
 			irlap_status_indication(self, STATUS_NO_ACTIVITY);
 			irlap_start_wd_timer(self, self->wd_timeout);
 			self->retry_count++;
-		} else if (self->retry_count >= self->N2/2) {
+		} else if ((self->retry_count * 2) >= self->N2) {
 			irlap_apply_default_connection_parameters(self);
 			
 			/* Always switch state before calling upper layers */
diff -urpN old-linux/net/irda/irlap_frame.c linux/net/irda/irlap_frame.c
--- old-linux/net/irda/irlap_frame.c	Thu Nov  9 18:16:46 2000
+++ linux/net/irda/irlap_frame.c	Thu Nov  9 18:26:03 2000
@@ -503,6 +503,12 @@ static void irlap_recv_discovery_xid_cmd
 	 *  Check if last frame 
 	 */
 	if (info->s == 0xff) {
+		/* Check if things are sane at this point... */
+		if((discovery_info == NULL) || (skb->len < 3)) {
+			ERROR(__FUNCTION__ "(), discovery frame to short!\n");
+			return;
+		}
+
 		/*
 		 *  We now have some discovery info to deliver!
 		 */
diff -urpN old-linux/net/irda/timer.c linux/net/irda/timer.c
--- old-linux/net/irda/timer.c	Thu Nov  9 13:48:34 2000
+++ linux/net/irda/timer.c	Thu Nov  9 18:26:03 2000
@@ -99,6 +99,25 @@ void irlap_start_mbusy_timer(struct irla
 			 (void *) self, irlap_media_busy_expired);
 }
 
+void irlap_stop_mbusy_timer(struct irlap_cb *self)
+{
+	/* If timer is activated, kill it! */
+	if(timer_pending(&self->media_busy_timer))
+		del_timer(&self->media_busy_timer);
+
+#ifdef CONFIG_IRDA_ULTRA
+	/* Send any pending Ultra frames if any */
+	if (!skb_queue_empty(&self->txq_ultra))
+		/* Note : we don't send the frame, just post an event.
+		 * Frames will be sent only if we are in NDM mode (see
+		 * irlap_event.c).
+		 * Also, moved this code from irlap_media_busy_expired()
+		 * to here to catch properly all cases...
+		 * Jean II */
+		irlap_do_event(self, SEND_UI_FRAME, NULL, NULL);
+#endif /* CONFIG_IRDA_ULTRA */
+}
+
 void irlmp_start_watchdog_timer(struct lsap_cb *self, int timeout) 
 {
 	irda_start_timer(&self->watchdog_timer, timeout, (void *) self,
@@ -217,8 +236,5 @@ void irlap_media_busy_expired(void* data
 	ASSERT(self != NULL, return;);
 
 	irda_device_set_media_busy(self->netdev, FALSE);
-
-	/* Send any pending Ultra frames if any */
-	if (!skb_queue_empty(&self->txq_ultra))
-		irlap_do_event(self, SEND_UI_FRAME, NULL, NULL);
+	/* Note : will deal with Ultra frames */
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
