Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVAHILf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVAHILf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVAHIKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:10:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:22917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261814AbVAHFsB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:01 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632673469@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:47 -0800
Message-Id: <11051632672835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.33, 2004/12/17 11:45:25-08:00, david-b@pacbell.net

[PATCH] USB: EHCI periodic schedule tree

This implements an interrupt schedule tree for EHCI; the bug's listed
in bugzilla (http://bugme.osdl.org/show_bug.cgi?id=3374) and affects
the ability to handle certain devices and configurations.

Now multiple interrupt transfers are supported per microframe.  Scheduling
prevents overcommit for reserved bandwidth and, for full/low speed devices,
the relevant transaction translator's buffer.  (TT-per-port hubs are already
initialized into the multi-TT mode.)

The interrupt transfer schedule is arranged in a sparse tree, just like OHCI.
A key difference is that OHCI implements a "best fit" scheduling policy,
while this implements "first fit" for EHCI.  (There's no load balancing;
it's not really needed in most users' configurations.)

There's also logic here to handle "high bandwidth" transfers, guaranteed
streaming of from 8-24 KB of data per millisecond.

Also includes some related cleanups for descheduling interrupt transfers.
Those will probably be split into a separate patch.

Against 2.6.10-rc3-bk5 ... this hasn't recently been tested much, but the
main old bug seems to be gone so it shouldn't make too much trouble.


From: David Brownell <david-b@pacbell.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ehci-hcd.c   |   19 +-
 drivers/usb/host/ehci-q.c     |   12 -
 drivers/usb/host/ehci-sched.c |  354 ++++++++++++++++++++++++------------------
 3 files changed, 227 insertions(+), 158 deletions(-)


diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	2005-01-07 15:46:14 -08:00
+++ b/drivers/usb/host/ehci-hcd.c	2005-01-07 15:46:14 -08:00
@@ -97,7 +97,7 @@
  * 2001-June	Works with usb-storage and NEC EHCI on 2.4
  */
 
-#define DRIVER_VERSION "26 Oct 2004"
+#define DRIVER_VERSION "10 Dec 2004"
 #define DRIVER_AUTHOR "David Brownell"
 #define DRIVER_DESC "USB 2.0 'Enhanced' Host Controller (EHCI) Driver"
 
@@ -991,12 +991,18 @@
 		qh = (struct ehci_qh *) urb->hcpriv;
 		if (!qh)
 			break;
-		if (qh->qh_state == QH_STATE_LINKED) {
-			/* messy, can spin or block a microframe ... */
-			intr_deschedule (ehci, qh, 1);
-			/* qh_state == IDLE */
+		switch (qh->qh_state) {
+		case QH_STATE_LINKED:
+			intr_deschedule (ehci, qh);
+			/* FALL THROUGH */
+		case QH_STATE_IDLE:
+			qh_completions (ehci, qh, NULL);
+			break;
+		default:
+			ehci_dbg (ehci, "bogus qh %p state %d\n",
+					qh, qh->qh_state);
+			goto done;
 		}
-		qh_completions (ehci, qh, NULL);
 
 		/* reschedule QH iff another request is queued */
 		if (!list_empty (&qh->qtd_list)
@@ -1023,6 +1029,7 @@
 		// completion irqs can wait up to 1024 msec,
 		break;
 	}
+done:
 	spin_unlock_irqrestore (&ehci->lock, flags);
 	return 0;
 }
diff -Nru a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
--- a/drivers/usb/host/ehci-q.c	2005-01-07 15:46:14 -08:00
+++ b/drivers/usb/host/ehci-q.c	2005-01-07 15:46:14 -08:00
@@ -268,8 +268,7 @@
 
 static void start_unlink_async (struct ehci_hcd *ehci, struct ehci_qh *qh);
 
-static void intr_deschedule (struct ehci_hcd *ehci,
-				struct ehci_qh *qh, int wait);
+static void intr_deschedule (struct ehci_hcd *ehci, struct ehci_qh *qh);
 static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh);
 
 /*
@@ -428,7 +427,7 @@
 			 * except maybe high bandwidth ...
 			 */
 			if (qh->period) {
-				intr_deschedule (ehci, qh, 1);
+				intr_deschedule (ehci, qh);
 				(void) qh_schedule (ehci, qh);
 			} else
 				start_unlink_async (ehci, qh);
@@ -664,9 +663,12 @@
 			qh->c_usecs = 0;
 			qh->gap_uf = 0;
 
-			/* FIXME handle HS periods of less than 1 frame. */
 			qh->period = urb->interval >> 3;
-			if (qh->period < 1) {
+			if (qh->period == 0 && urb->interval != 1) {
+				/* NOTE interval 2 or 4 uframes could work.
+				 * But interval 1 scheduling is simpler, and
+				 * includes high bandwidth.
+				 */
 				dbg ("intr period %d uframes, NYET!",
 						urb->interval);
 				goto done;
diff -Nru a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
--- a/drivers/usb/host/ehci-sched.c	2005-01-07 15:46:14 -08:00
+++ b/drivers/usb/host/ehci-sched.c	2005-01-07 15:46:14 -08:00
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2001-2003 by David Brownell
+ * Copyright (c) 2001-2004 by David Brownell
  * Copyright (c) 2003 Michal Sojka, for high-speed iso transfers
  * 
  * This program is free software; you can redistribute it and/or modify it
@@ -59,39 +59,28 @@
 	}
 }
 
-/* returns true after successful unlink */
 /* caller must hold ehci->lock */
-static int periodic_unlink (struct ehci_hcd *ehci, unsigned frame, void *ptr)
+static void periodic_unlink (struct ehci_hcd *ehci, unsigned frame, void *ptr)
 {
 	union ehci_shadow	*prev_p = &ehci->pshadow [frame];
 	__le32			*hw_p = &ehci->periodic [frame];
 	union ehci_shadow	here = *prev_p;
-	union ehci_shadow	*next_p;
 
 	/* find predecessor of "ptr"; hw and shadow lists are in sync */
 	while (here.ptr && here.ptr != ptr) {
 		prev_p = periodic_next_shadow (prev_p, Q_NEXT_TYPE (*hw_p));
-		hw_p = &here.qh->hw_next;
+		hw_p = here.hw_next;
 		here = *prev_p;
 	}
 	/* an interrupt entry (at list end) could have been shared */
-	if (!here.ptr) {
-		dbg ("entry %p no longer on frame [%d]", ptr, frame);
-		return 0;
-	}
-	// vdbg ("periodic unlink %p from frame %d", ptr, frame);
+	if (!here.ptr)
+		return;
 
-	/* update hardware list ... HC may still know the old structure, so
-	 * don't change hw_next until it'll have purged its cache
+	/* update shadow and hardware lists ... the old "next" pointers
+	 * from ptr may still be in use, the caller updates them.
 	 */
-	next_p = periodic_next_shadow (&here, Q_NEXT_TYPE (*hw_p));
-	*hw_p = here.qh->hw_next;
-
-	/* unlink from shadow list; HCD won't see old structure again */
-	*prev_p = *next_p;
-	next_p->ptr = NULL;
-
-	return 1;
+	*prev_p = *periodic_next_shadow (&here, Q_NEXT_TYPE (*hw_p));
+	*hw_p = *here.hw_next;
 }
 
 /* how many of the uframe's 125 usecs are allocated? */
@@ -114,7 +103,8 @@
 			hw_p = &q->qh->hw_next;
 			q = &q->qh->qh_next;
 			break;
-		case Q_TYPE_FSTN:
+		// case Q_TYPE_FSTN:
+		default:
 			/* for "save place" FSTNs, count the relevant INTR
 			 * bandwidth from the previous frame
 			 */
@@ -149,13 +139,11 @@
 			hw_p = &q->sitd->hw_next;
 			q = &q->sitd->sitd_next;
 			break;
-		default:
-			BUG ();
 		}
 	}
 #ifdef	DEBUG
 	if (usecs > 100)
-		err ("overallocated uframe %d, periodic is %d usecs",
+		ehci_err (ehci, "uframe %d sched overrun: %d usecs\n",
 			frame * 8 + uframe, usecs);
 #endif
 	return usecs;
@@ -300,64 +288,143 @@
 
 /*-------------------------------------------------------------------------*/
 
-// FIXME microframe periods not yet handled
+/* periodic schedule slots have iso tds (normal or split) first, then a
+ * sparse tree for active interrupt transfers.
+ *
+ * this just links in a qh; caller guarantees uframe masks are set right.
+ * no FSTN support (yet; ehci 0.96+)
+ */
+static int qh_link_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
+{
+	unsigned	i;
+	unsigned	period = qh->period;
 
-static void intr_deschedule (
-	struct ehci_hcd	*ehci,
-	struct ehci_qh	*qh,
-	int		wait
-) {
-	int		status;
-	unsigned	frame = qh->start;
+	dev_dbg (&qh->dev->dev,
+		"link qh%d-%04x/%p start %d [%d/%d us]\n",
+		period, le32_to_cpup (&qh->hw_info2) & 0xffff,
+		qh, qh->start, qh->usecs, qh->c_usecs);
+
+	/* high bandwidth, or otherwise every microframe */
+	if (period == 0)
+		period = 1;
+
+	for (i = qh->start; i < ehci->periodic_size; i += period) {
+		union ehci_shadow	*prev = &ehci->pshadow [i];
+		u32			*hw_p = &ehci->periodic [i];
+		union ehci_shadow	here = *prev;
+		u32			type = 0;
 
-	do {
-		periodic_unlink (ehci, frame, qh);
-		qh_put (qh);
-		frame += qh->period;
-	} while (frame < ehci->periodic_size);
+		/* skip the iso nodes at list head */
+		while (here.ptr) {
+			type = Q_NEXT_TYPE (*hw_p);
+			if (type == Q_TYPE_QH)
+				break;
+			prev = periodic_next_shadow (prev, type);
+			hw_p = &here.qh->hw_next;
+			here = *prev;
+		}
+
+		/* sorting each branch by period (slow-->fast)
+		 * enables sharing interior tree nodes
+		 */
+		while (here.ptr && qh != here.qh) {
+			if (qh->period > here.qh->period)
+				break;
+			prev = &here.qh->qh_next;
+			hw_p = &here.qh->hw_next;
+			here = *prev;
+		}
+		/* link in this qh, unless some earlier pass did that */
+		if (qh != here.qh) {
+			qh->qh_next = here;
+			if (here.qh)
+				qh->hw_next = *hw_p;
+			wmb ();
+			prev->qh = qh;
+			*hw_p = QH_NEXT (qh->qh_dma);
+		}
+	}
+	qh->qh_state = QH_STATE_LINKED;
+	qh_get (qh);
+
+	/* update per-qh bandwidth for usbfs */
+	hcd_to_bus (&ehci->hcd)->bandwidth_allocated += qh->period
+		? ((qh->usecs + qh->c_usecs) / qh->period)
+		: (qh->usecs * 8);
 
+	/* maybe enable periodic schedule processing */
+	if (!ehci->periodic_sched++)
+		return enable_periodic (ehci);
+
+	return 0;
+}
+
+static void qh_unlink_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
+{
+	unsigned	i;
+	unsigned	period;
+
+	// FIXME:
+	// IF this isn't high speed
+	//   and this qh is active in the current uframe
+	//   (and overlay token SplitXstate is false?)
+	// THEN
+	//   qh->hw_info1 |= __constant_cpu_to_le32 (1 << 7 /* "ignore" */);
+
+	/* high bandwidth, or otherwise part of every microframe */
+	if ((period = qh->period) == 0)
+		period = 1;
+
+	for (i = qh->start; i < ehci->periodic_size; i += period)
+		periodic_unlink (ehci, i, qh);
+
+	/* update per-qh bandwidth for usbfs */
+	hcd_to_bus (&ehci->hcd)->bandwidth_allocated -= qh->period
+		? ((qh->usecs + qh->c_usecs) / qh->period)
+		: (qh->usecs * 8);
+
+	dev_dbg (&qh->dev->dev,
+		"unlink qh%d-%04x/%p start %d [%d/%d us]\n",
+		qh->period, le32_to_cpup (&qh->hw_info2) & 0xffff,
+		qh, qh->start, qh->usecs, qh->c_usecs);
+
+	/* qh->qh_next still "live" to HC */
 	qh->qh_state = QH_STATE_UNLINK;
 	qh->qh_next.ptr = NULL;
-	ehci->periodic_sched--;
+	qh_put (qh);
 
 	/* maybe turn off periodic schedule */
+	ehci->periodic_sched--;
 	if (!ehci->periodic_sched)
-		status = disable_periodic (ehci);
-	else {
-		status = 0;
-		ehci_vdbg (ehci, "periodic schedule still enabled\n");
-	}
+		(void) disable_periodic (ehci);
+}
 
-	/*
-	 * If the hc may be looking at this qh, then delay a uframe
-	 * (yeech!) to be sure it's done.
-	 * No other threads may be mucking with this qh.
+static void intr_deschedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
+{
+	unsigned	wait;
+
+	qh_unlink_periodic (ehci, qh);
+
+	/* simple/paranoid:  always delay, expecting the HC needs to read
+	 * qh->hw_next or finish a writeback after SPLIT/CSPLIT ... and
+	 * expect khubd to clean up after any CSPLITs we won't issue.
+	 * active high speed queues may need bigger delays...
 	 */
-	if (((ehci_get_frame (&ehci->hcd) - frame) % qh->period) == 0) {
-		if (wait) {
-			udelay (125);
-			qh->hw_next = EHCI_LIST_END;
-		} else {
-			/* we may not be IDLE yet, but if the qh is empty
-			 * the race is very short.  then if qh also isn't
-			 * rescheduled soon, it won't matter.  otherwise...
-			 */
-			ehci_vdbg (ehci, "intr_deschedule...\n");
-		}
-	} else
-		qh->hw_next = EHCI_LIST_END;
+	if (list_empty (&qh->qtd_list)
+			|| (__constant_cpu_to_le32 (0x0ff << 8)
+					& qh->hw_info2) != 0)
+		wait = 2;
+	else
+		wait = 55;	/* worst case: 3 * 1024 */
 
+	udelay (wait);
 	qh->qh_state = QH_STATE_IDLE;
-
-	/* update per-qh bandwidth utilization (for usbfs) */
-	hcd_to_bus (&ehci->hcd)->bandwidth_allocated -= 
-		(qh->usecs + qh->c_usecs) / qh->period;
-
-	ehci_dbg (ehci, "descheduled qh%d/%p frame=%d count=%d, urbs=%d\n",
-		qh->period, qh, frame,
-		atomic_read (&qh->kref.refcount), ehci->periodic_sched);
+	qh->hw_next = EHCI_LIST_END;
+	wmb ();
 }
 
+/*-------------------------------------------------------------------------*/
+
 static int check_period (
 	struct ehci_hcd *ehci, 
 	unsigned	frame,
@@ -365,6 +432,8 @@
 	unsigned	period,
 	unsigned	usecs
 ) {
+	int		claimed;
+
 	/* complete split running into next frame?
 	 * given FSTN support, we could sometimes check...
 	 */
@@ -377,22 +446,26 @@
 	 */
 	usecs = 100 - usecs;
 
-	do {
-		int	claimed;
-
-// FIXME delete when intr_submit handles non-empty queues
-// this gives us a one intr/frame limit (vs N/uframe)
-// ... and also lets us avoid tracking split transactions
-// that might collide at a given TT/hub.
-		if (ehci->pshadow [frame].ptr)
-			return 0;
-
-		claimed = periodic_usecs (ehci, frame, uframe);
-		if (claimed > usecs)
-			return 0;
+	/* we "know" 2 and 4 uframe intervals were rejected; so
+	 * for period 0, check _every_ microframe in the schedule.
+	 */
+	if (unlikely (period == 0)) {
+		do {
+			for (uframe = 0; uframe < 7; uframe++) {
+				claimed = periodic_usecs (ehci, frame, uframe);
+				if (claimed > usecs)
+					return 0;
+			}
+		} while ((frame += 1) < ehci->periodic_size);
 
-// FIXME update to handle sub-frame periods
-	} while ((frame += period) < ehci->periodic_size);
+	/* just check the specified uframe, at that period */
+	} else {
+		do {
+			claimed = periodic_usecs (ehci, frame, uframe);
+			if (claimed > usecs)
+				return 0;
+		} while ((frame += period) < ehci->periodic_size);
+	}
 
 	// success!
 	return 1;
@@ -407,6 +480,10 @@
 )
 {
     	int		retval = -ENOSPC;
+	u8		mask;
+
+	if (qh->c_usecs && uframe >= 6)		/* FSTN territory? */
+		goto done;
 
 	if (!check_period (ehci, frame, uframe, qh->period, qh->usecs))
 		goto done;
@@ -416,33 +493,33 @@
 		goto done;
 	}
 
-	/* This is a split transaction; check the bandwidth available for
-	 * the completion too.  Check both worst and best case gaps: worst
-	 * case is SPLIT near uframe end, and CSPLIT near start ... best is
-	 * vice versa.  Difference can be almost two uframe times, but we
-	 * reserve unnecessary bandwidth (waste it) this way.  (Actually
-	 * even better cases exist, like immediate device NAK.)
-	 *
-	 * FIXME don't even bother unless we know this TT is idle in that
-	 * range of uframes ... for now, check_period() allows only one
-	 * interrupt transfer per frame, so needn't check "TT busy" status
-	 * when scheduling a split (QH, SITD, or FSTN).
-	 *
-	 * FIXME ehci 0.96 and above can use FSTNs
+	/* Make sure this tt's buffer is also available for CSPLITs.
+	 * We pessimize a bit; probably the typical full speed case
+	 * doesn't need the second CSPLIT.
+	 * 
+	 * NOTE:  both SPLIT and CSPLIT could be checked in just
+	 * one smart pass...
 	 */
-	if (!check_period (ehci, frame, uframe + qh->gap_uf + 1,
-				qh->period, qh->c_usecs))
-		goto done;
-	if (!check_period (ehci, frame, uframe + qh->gap_uf,
-				qh->period, qh->c_usecs))
-		goto done;
+	mask = 0x03 << (uframe + qh->gap_uf);
+	*c_maskp = cpu_to_le32 (mask << 8);
 
-	*c_maskp = cpu_to_le32 (0x03 << (8 + uframe + qh->gap_uf));
-	retval = 0;
+	mask |= 1 << uframe;
+	if (tt_no_collision (ehci, qh->period, qh->dev, frame, mask)) {
+		if (!check_period (ehci, frame, uframe + qh->gap_uf + 1,
+					qh->period, qh->c_usecs))
+			goto done;
+		if (!check_period (ehci, frame, uframe + qh->gap_uf,
+					qh->period, qh->c_usecs))
+			goto done;
+		retval = 0;
+	}
 done:
 	return retval;
 }
 
+/* "first fit" scheduling policy used the first time through,
+ * or when the previous schedule slot can't be re-used.
+ */
 static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
 	int 		status;
@@ -469,56 +546,39 @@
 	 * uframes have enough periodic bandwidth available.
 	 */
 	if (status) {
-		frame = qh->period - 1;
-		do {
-			for (uframe = 0; uframe < 8; uframe++) {
-				status = check_intr_schedule (ehci,
-						frame, uframe, qh,
-						&c_mask);
-				if (status == 0)
-					break;
-			}
-		} while (status && frame--);
+		/* "normal" case, uframing flexible except with splits */
+		if (qh->period) {
+			frame = qh->period - 1;
+			do {
+				for (uframe = 0; uframe < 8; uframe++) {
+					status = check_intr_schedule (ehci,
+							frame, uframe, qh,
+							&c_mask);
+					if (status == 0)
+						break;
+				}
+			} while (status && frame--);
+
+		/* qh->period == 0 means every uframe */
+		} else {
+			frame = 0;
+			status = check_intr_schedule (ehci, 0, 0, qh, &c_mask);
+		}
 		if (status)
 			goto done;
 		qh->start = frame;
 
 		/* reset S-frame and (maybe) C-frame masks */
-		qh->hw_info2 &= ~__constant_cpu_to_le32(0xffff);
-		qh->hw_info2 |= cpu_to_le32 (1 << uframe) | c_mask;
+		qh->hw_info2 &= __constant_cpu_to_le32 (~0xffff);
+		qh->hw_info2 |= qh->period
+			? cpu_to_le32 (1 << uframe)
+			: __constant_cpu_to_le32 (0xff);
+		qh->hw_info2 |= c_mask;
 	} else
 		ehci_dbg (ehci, "reused qh %p schedule\n", qh);
 
 	/* stuff into the periodic schedule */
-	qh->qh_state = QH_STATE_LINKED;
-	ehci_dbg(ehci,
-		"scheduled qh%d/%p usecs %d/%d starting %d.%d (gap %d)\n",
-		qh->period, qh, qh->usecs, qh->c_usecs,
-		frame, uframe, qh->gap_uf);
-	do {
-		if (unlikely (ehci->pshadow [frame].ptr != 0)) {
-
-// FIXME -- just link toward the end, before any qh with a shorter period,
-// AND accommodate it already having been linked here (after some other qh)
-// AS WELL AS updating the schedule checking logic
-
-			BUG ();
-		} else {
-			ehci->pshadow [frame].qh = qh_get (qh);
-			ehci->periodic [frame] =
-				QH_NEXT (qh->qh_dma);
-		}
-		wmb ();
-		frame += qh->period;
-	} while (frame < ehci->periodic_size);
-
-	/* update per-qh bandwidth for usbfs */
-	hcd_to_bus (&ehci->hcd)->bandwidth_allocated += 
-		(qh->usecs + qh->c_usecs) / qh->period;
-
-	/* maybe enable periodic schedule processing */
-	if (!ehci->periodic_sched++)
-		status = enable_periodic (ehci);
+ 	status = qh_link_periodic (ehci, qh);
 done:
 	return status;
 }
@@ -780,7 +840,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* ehci_iso_sched ops can be shared, ITD-only, or SITD-only */
+/* ehci_iso_sched ops can be ITD-only or SITD-only */
 
 static struct ehci_iso_sched *
 iso_sched_alloc (unsigned packets, int mem_flags)
@@ -1843,7 +1903,7 @@
 				q = q.qh->qh_next;
 				modified = qh_completions (ehci, temp.qh, regs);
 				if (unlikely (list_empty (&temp.qh->qtd_list)))
-					intr_deschedule (ehci, temp.qh, 0);
+					intr_deschedule (ehci, temp.qh);
 				qh_put (temp.qh);
 				break;
 			case Q_TYPE_FSTN:

