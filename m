Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270265AbUJTBX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270265AbUJTBX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270253AbUJTBWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:22:51 -0400
Received: from palrel10.hp.com ([156.153.255.245]:5789 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S270265AbUJTBEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:04:35 -0400
Date: Tue, 19 Oct 2004 18:04:32 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Adaptive discovery query timer
Message-ID: <20041020010431.GF12932@bougret.hpl.hp.com>
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

ir269_adaptive_query_timer-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Adapt to the rate of the peer discovery (passive discovery)
	o [FEATURE] Add extra safety margin in passive discovery
	Allow to interoperate properly with device performing slow discovery
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/include/net/irda/timer.d0.h linux/include/net/irda/timer.h
--- linux/include/net/irda/timer.d0.h	Wed Sep 22 11:49:53 2004
+++ linux/include/net/irda/timer.h	Wed Sep 22 11:57:56 2004
@@ -58,14 +58,16 @@ struct lap_cb;
  *  Slot timer must never exceed 85 ms, and must always be at least 25 ms, 
  *  suggested to  75-85 msec by IrDA lite. This doesn't work with a lot of
  *  devices, and other stackes uses a lot more, so it's best we do it as well
+ *  (Note : this is the default value and sysctl overides it - Jean II)
  */
 #define SLOT_TIMEOUT            (90*HZ/1000)
 
 /* 
- *  We set the query timeout to 100 ms and then expect the value to be 
- *  multiplied with the number of slots to product the actual timeout value
+ *  The latest discovery frame (XID) is longer due to the extra discovery
+ *  information (hints, device name...). This is its extra length.
+ *  We use that when setting the query timeout. Jean II
  */
-#define QUERY_TIMEOUT           (HZ/10)       
+#define XIDEXTRA_TIMEOUT        (34*HZ/1000)  /* 34 msec */
 
 #define WATCHDOG_TIMEOUT        (20*HZ)       /* 20 sec */
 
@@ -85,7 +87,7 @@ static inline void irda_start_timer(stru
 
 
 void irlap_start_slot_timer(struct irlap_cb *self, int timeout);
-void irlap_start_query_timer(struct irlap_cb *self, int timeout);
+void irlap_start_query_timer(struct irlap_cb *self, int S, int s);
 void irlap_start_final_timer(struct irlap_cb *self, int timeout);
 void irlap_start_wd_timer(struct irlap_cb *self, int timeout);
 void irlap_start_backoff_timer(struct irlap_cb *self, int timeout);
diff -u -p linux/net/irda/timer.d0.c linux/net/irda/timer.c
--- linux/net/irda/timer.d0.c	Wed Sep 22 11:50:06 2004
+++ linux/net/irda/timer.c	Wed Sep 22 12:02:20 2004
@@ -34,6 +34,8 @@
 #include <net/irda/irlap.h>
 #include <net/irda/irlmp.h>
 
+extern int  sysctl_slot_timeout;
+
 static void irlap_slot_timer_expired(void* data);
 static void irlap_query_timer_expired(void* data);
 static void irlap_final_timer_expired(void* data);
@@ -47,8 +49,25 @@ void irlap_start_slot_timer(struct irlap
 			 irlap_slot_timer_expired);
 }
 
-void irlap_start_query_timer(struct irlap_cb *self, int timeout)
+void irlap_start_query_timer(struct irlap_cb *self, int S, int s)
 {
+	int timeout;
+
+	/* Calculate when the peer discovery should end. Normally, we
+	 * get the end-of-discovery frame, so this is just in case
+	 * we miss it.
+	 * Basically, we multiply the number of remaining slots by our
+	 * slot time, plus add some extra time to properly receive the last
+	 * discovery packet (which is longer due to extra discovery info),
+	 * to avoid messing with for incomming connections requests and
+	 * to accomodate devices that perform discovery slower than us.
+	 * Jean II */
+	timeout = ((sysctl_slot_timeout * HZ / 1000) * (S - s)
+		   + XIDEXTRA_TIMEOUT + SMALLBUSY_TIMEOUT);
+
+	/* Set or re-set the timer. We reset the timer for each received
+	 * discovery query, which allow us to automatically adjust to
+	 * the speed of the peer discovery (faster or slower). Jean II */
 	irda_start_timer( &self->query_timer, timeout, (void *) self, 
 			  irlap_query_timer_expired);
 }
diff -u -p linux/net/irda/irlap_event.d0.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d0.c	Tue Sep 21 15:51:01 2004
+++ linux/net/irda/irlap_event.c	Wed Sep 22 12:00:41 2004
@@ -433,10 +433,11 @@ static int irlap_state_ndm(struct irlap_
 				self->frame_sent = FALSE;
 
 			/*
-			 * Remember to multiply the query timeout value with
-			 * the number of slots used
+			 * Go to reply state until end of discovery to
+			 * inhibit our own transmissions. Set the timer
+			 * to not stay forever there... Jean II
 			 */
-			irlap_start_query_timer(self, QUERY_TIMEOUT*info->S);
+			irlap_start_query_timer(self, info->S, info->s);
 			irlap_next_state(self, LAP_REPLY);
 		} else {
 		/* This is the final slot. How is it possible ?
@@ -452,6 +453,9 @@ static int irlap_state_ndm(struct irlap_
 		 * Not much. It's too late to answer those discovery frames,
 		 * so we just pass the info to IrLMP who will put it in the
 		 * log (and post an event).
+		 * Another cause would be devices that do discovery much
+		 * slower than us, however the latest fixes should minimise
+		 * those cases...
 		 * Jean II
 		 */
 			IRDA_DEBUG(1, "%s(), Receiving final discovery request, missed the discovery slots :-(\n", __FUNCTION__);
@@ -691,7 +695,7 @@ static int irlap_state_reply(struct irla
 
 	switch (event) {
 	case QUERY_TIMER_EXPIRED:
-		IRDA_DEBUG(2, "%s(), QUERY_TIMER_EXPIRED <%ld>\n",
+		IRDA_DEBUG(0, "%s(), QUERY_TIMER_EXPIRED <%ld>\n",
 			   __FUNCTION__, jiffies);
 		irlap_next_state(self, LAP_NDM);
 		break;
@@ -707,16 +711,26 @@ static int irlap_state_reply(struct irla
 			irlap_next_state(self, LAP_NDM);
 
 			irlap_discovery_indication(self, info->discovery);
-		} else if ((info->s >= self->slot) && (!self->frame_sent)) {
-			discovery_rsp = irlmp_get_discovery_response();
-			discovery_rsp->data.daddr = info->daddr;
-
-			irlap_send_discovery_xid_frame(self, info->S,
-						       self->slot, FALSE,
-						       discovery_rsp);
+		} else {
+			/* If it's our slot, send our reply */
+			if ((info->s >= self->slot) && (!self->frame_sent)) {
+				discovery_rsp = irlmp_get_discovery_response();
+				discovery_rsp->data.daddr = info->daddr;
+
+				irlap_send_discovery_xid_frame(self, info->S,
+							       self->slot,
+							       FALSE,
+							       discovery_rsp);
+
+				self->frame_sent = TRUE;
+			}
+			/* Readjust our timer to accomodate devices
+			 * doing faster or slower discovery than us...
+			 * Jean II */
+			irlap_start_query_timer(self, info->S, info->s);
 
-			self->frame_sent = TRUE;
-			irlap_next_state(self, LAP_REPLY);
+			/* Keep state */
+			//irlap_next_state(self, LAP_REPLY);
 		}
 		break;
 	default:
