Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314469AbSDSC3g>; Thu, 18 Apr 2002 22:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314473AbSDSC3e>; Thu, 18 Apr 2002 22:29:34 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:6885 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314469AbSDSC3b>;
	Thu, 18 Apr 2002 22:29:31 -0400
Date: Thu, 18 Apr 2002 19:28:00 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        irda-users@lists.sourceforge.net
Subject: [PATCH] : ir258_flow_sched_lap_lmp-6.diff
Message-ID: <20020418192800.B988@bougret.hpl.hp.com>
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

ir258_flow_sched_lap_lmp-6.diff :
-------------------------------
		<Won't compile without ir258_flow_sched_ttp-6.diff>
	o [FEATURE] Reduce LAP Tx queue to 2 packets (from 10)
		Improve latency, reduce buffer usage
	o [FEATURE] LAP Tx queue not full notification (flow start)
		Poll higher layer to fill synchronously LAP window (7 packets)
	o [FEATURE] LMP LSAP scheduler
		Ensure Tx fairness between LSAPs (sockets, IrCOMM, IrNET...)

------------------------------------

diff -u -p -r linux/include/net/irda/irlap.d6.h linux/include/net/irda/irlap.h
--- linux/include/net/irda/irlap.d6.h	Wed Apr 10 14:04:21 2002
+++ linux/include/net/irda/irlap.h	Wed Apr 10 16:31:38 2002
@@ -52,8 +52,32 @@
 #define CBROADCAST 0xfe       /* Connection broadcast address */
 #define XID_FORMAT 0x01       /* Discovery XID format */
 
+/* Nobody seems to use this constant. */
 #define LAP_WINDOW_SIZE 8
-#define LAP_MAX_QUEUE  10
+/* We keep the LAP queue very small to minimise the amount of buffering.
+ * this improve latency and reduce resource consumption.
+ * This work only because we have synchronous refilling of IrLAP through
+ * the flow control mechanism (via scheduler and IrTTP).
+ * 2 buffers is the minimum we can work with, one that we send while polling
+ * IrTTP, and another to know that we should not send the pf bit.
+ * Jean II */
+#define LAP_HIGH_THRESHOLD     2
+/* Some rare non TTP clients don't implement flow control, and
+ * so don't comply with the above limit (and neither with this one).
+ * For IAP and management, it doesn't matter, because they never transmit much.
+ *.For IrLPT, this should be fixed.
+ * - Jean II */
+#define LAP_MAX_QUEUE 10
+/* Please note that all IrDA management frames (LMP/TTP conn req/disc and
+ * IAS queries) fall in the second category and are sent to LAP even if TTP
+ * is stopped. This means that those frames will wait only a maximum of
+ * two (2) data frames before beeing sent on the "wire", which speed up
+ * new socket setup when the link is saturated.
+ * Same story for two sockets competing for the medium : if one saturates
+ * the LAP, when the other want to transmit it only has to wait for
+ * maximum three (3) packets (2 + one scheduling), which improve performance
+ * of delay sensitive applications.
+ * Jean II */
 
 #define NR_EXPECTED     1
 #define NR_UNEXPECTED   0
diff -u -p -r linux/include/net/irda/irlmp.d6.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d6.h	Wed Apr 10 16:30:08 2002
+++ linux/include/net/irda/irlmp.h	Wed Apr 10 16:31:38 2002
@@ -132,6 +132,7 @@ struct lap_cb {
 
 	struct irlap_cb *irlap;   /* Instance of IrLAP layer */
 	hashbin_t *lsaps;         /* LSAP associated with this link */
+	struct lsap_cb *flow_next;	/* Next lsap to be polled for Tx */
 
 	__u8  caddr;  /* Connection address */
  	__u32 saddr;  /* Source device address */
@@ -235,6 +236,7 @@ void irlmp_connless_data_indication(stru
 
 void irlmp_status_request(void);
 void irlmp_status_indication(struct lap_cb *, LINK_STATUS link, LOCK_STATUS lock);
+void irlmp_flow_indication(struct lap_cb *self, LOCAL_FLOW flow);
 
 int  irlmp_slsap_inuse(__u8 slsap);
 __u8 irlmp_find_free_slsap(void);
@@ -252,7 +254,9 @@ extern struct irlmp_cb *irlmp;
 
 static inline hashbin_t *irlmp_get_cachelog(void) { return irlmp->cachelog; }
 
-static inline int irlmp_get_lap_tx_queue_len(struct lsap_cb *self)
+/* Check if LAP queue is full.
+ * Used by IrTTP for low control, see comments in irlap.h - Jean II */
+static inline int irlmp_lap_tx_queue_full(struct lsap_cb *self)
 {
 	if (self == NULL)
 		return 0;
@@ -261,7 +265,7 @@ static inline int irlmp_get_lap_tx_queue
 	if (self->lap->irlap == NULL)
 		return 0;
 
-	return IRLAP_GET_TX_QUEUE_LEN(self->lap->irlap);
+	return(IRLAP_GET_TX_QUEUE_LEN(self->lap->irlap) >= LAP_HIGH_THRESHOLD);
 }
 
 /* After doing a irlmp_dup(), this get one of the two socket back into
diff -u -p -r linux/net/irda/irlap_event.d6.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d6.c	Wed Apr 10 16:30:34 2002
+++ linux/net/irda/irlap_event.c	Wed Apr 10 16:31:38 2002
@@ -253,19 +253,45 @@ void irlap_do_event(struct irlap_cb *sel
 	case LAP_XMIT_P: /* FALLTHROUGH */
 	case LAP_XMIT_S:
 		/* 
+		 * We just received the pf bit and are at the beginning
+		 * of a new LAP transmit window.
 		 * Check if there are any queued data frames, and do not
 		 * try to disconnect link if we send any data frames, since
 		 * that will change the state away form XMIT
 		 */
+		IRDA_DEBUG(2, __FUNCTION__ "() : queue len = %d\n",
+			   skb_queue_len(&self->txq));
+
 		if (skb_queue_len(&self->txq)) {
 			/* Prevent race conditions with irlap_data_request() */
 			self->local_busy = TRUE;
 
+			/* Theory of operation.
+			 * We send frames up to when we fill the window or
+			 * reach line capacity. Those frames will queue up
+			 * in the device queue, and the driver will slowly
+			 * send them.
+			 * After each frame that we send, we poll the higher
+			 * layer for more data. It's the right time to do
+			 * that because the link layer need to perform the mtt
+			 * and then send the first frame, so we can afford
+			 * to send a bit of time in kernel space.
+			 * The explicit flow indication allow to minimise
+			 * buffers (== lower latency), to avoid higher layer
+			 * polling via timers (== less context switches) and
+			 * to implement a crude scheduler - Jean II */
+
 			/* Try to send away all queued data frames */
 			while ((skb = skb_dequeue(&self->txq)) != NULL) {
+				/* Send one frame */
 				ret = (*state[self->state])(self, SEND_I_CMD,
 							    skb, NULL);
 				kfree_skb(skb);
+
+				/* Poll the higher layers for one more frame */
+				irlmp_flow_indication(self->notify.instance,
+						      FLOW_START);
+
 				if (ret == -EPROTO)
 					break; /* Try again later! */
 			}
diff -u -p -r linux/net/irda/irlmp.d6.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d6.c	Wed Apr 10 16:30:51 2002
+++ linux/net/irda/irlmp.c	Wed Apr 10 16:31:38 2002
@@ -1213,6 +1213,72 @@ void irlmp_status_indication(struct lap_
 }
 
 /*
+ * Receive flow control indication from LAP.
+ * LAP want us to send it one more frame. We implement a simple round
+ * robin scheduler between the active sockets so that we get a bit of
+ * fairness. Note that the round robin is far from perfect, but it's
+ * better than nothing.
+ * We then poll the selected socket so that we can do synchronous
+ * refilling of IrLAP (which allow to minimise the number of buffers).
+ * Jean II
+ */
+void irlmp_flow_indication(struct lap_cb *self, LOCAL_FLOW flow)
+{
+	struct lsap_cb *next;
+	struct lsap_cb *curr;
+	int	lsap_todo;
+
+	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
+	ASSERT(flow == FLOW_START, return;);
+
+	/* Get the number of lsap. That's the only safe way to know
+	 * that we have looped around... - Jean II */
+	lsap_todo = HASHBIN_GET_SIZE(self->lsaps);
+	IRDA_DEBUG(4, __FUNCTION__ "() : %d lsaps to scan\n", lsap_todo);
+
+	/* Poll lsap in order until the queue is full or until we
+	 * tried them all.
+	 * Most often, the current LSAP will have something to send,
+	 * so we will go through this loop only once. - Jean II */
+	while((lsap_todo--) &&
+	      (IRLAP_GET_TX_QUEUE_LEN(self->irlap) < LAP_HIGH_THRESHOLD)) {
+		/* Try to find the next lsap we should poll. */
+		next = self->flow_next;
+		if(next != NULL) {
+			/* Note that if there is only one LSAP on the LAP
+			 * (most common case), self->flow_next is always NULL,
+			 * so we always avoid this loop. - Jean II */
+			IRDA_DEBUG(4, __FUNCTION__ "() : searching my LSAP\n");
+
+			/* We look again in hashbins, because the lsap
+			 * might have gone away... - Jean II */
+			curr = (struct lsap_cb *) hashbin_get_first(self->lsaps);
+			while((curr != NULL ) && (curr != next))
+				curr = (struct lsap_cb *) hashbin_get_next(self->lsaps);
+		} else
+			curr = NULL;
+
+		/* If we have no lsap, restart from first one */
+		if(curr == NULL)
+			curr = (struct lsap_cb *) hashbin_get_first(self->lsaps);
+		/* Uh-oh... Paranoia */
+		if(curr == NULL)
+			break;
+
+		/* Next time, we will get the next one (or the first one) */
+		self->flow_next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
+		IRDA_DEBUG(4, __FUNCTION__ "() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
+
+		/* Inform lsap user that it can send one more packet. */
+		if (curr->notify.flow_indication != NULL)
+			curr->notify.flow_indication(curr->notify.instance, 
+						     curr, flow);
+		else
+			IRDA_DEBUG(1, __FUNCTION__ "(), no handler\n");
+	}
+}
+
+/*
  * Function irlmp_hint_to_service (hint)
  *
  *    Returns a list of all servics contained in the given hint bits. This
