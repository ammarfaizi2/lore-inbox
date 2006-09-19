Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWISLQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWISLQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 07:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWISLQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 07:16:35 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:25883 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751298AbWISLQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 07:16:34 -0400
Date: Tue, 19 Sep 2006 13:16:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] cio: subchannel evaluation function operates without lock
Message-ID: <20060919111631.GA21713@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: subchannel evaluation function operates without lock

css_evaluate_subchannel() operates subchannel without lock which can
lead to erratic behavior caused by concurrent device access. Also
split evaluation function to make it more readable.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |  203 +++++++++++++++++++++++++------------------------
 1 files changed, 104 insertions(+), 99 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-09-19 12:58:32.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-09-19 12:59:33.000000000 +0200
@@ -182,136 +182,141 @@ get_subchannel_by_schid(struct subchanne
 	return dev ? to_subchannel(dev) : NULL;
 }
 
-
-static inline int
-css_get_subchannel_status(struct subchannel *sch, struct subchannel_id schid)
+static inline int css_get_subchannel_status(struct subchannel *sch)
 {
 	struct schib schib;
-	int cc;
 
-	cc = stsch(schid, &schib);
-	if (cc)
-		return CIO_GONE;
-	if (!schib.pmcw.dnv)
+	if (stsch(sch->schid, &schib) || !schib.pmcw.dnv)
 		return CIO_GONE;
-	if (sch && sch->schib.pmcw.dnv &&
-	    (schib.pmcw.dev != sch->schib.pmcw.dev))
+	if (sch->schib.pmcw.dnv && (schib.pmcw.dev != sch->schib.pmcw.dev))
 		return CIO_REVALIDATE;
-	if (sch && !sch->lpm)
+	if (!sch->lpm)
 		return CIO_NO_PATH;
 	return CIO_OPER;
 }
-	
-static int
-css_evaluate_subchannel(struct subchannel_id schid, int slow)
+
+static int css_evaluate_known_subchannel(struct subchannel *sch, int slow)
 {
 	int event, ret, disc;
-	struct subchannel *sch;
 	unsigned long flags;
+	enum { NONE, UNREGISTER, UNREGISTER_PROBE, REPROBE } action;
 
-	sch = get_subchannel_by_schid(schid);
-	disc = sch ? device_is_disconnected(sch) : 0;
+	spin_lock_irqsave(&sch->lock, flags);
+	disc = device_is_disconnected(sch);
 	if (disc && slow) {
-		if (sch)
-			put_device(&sch->dev);
-		return 0; /* Already processed. */
+		/* Disconnected devices are evaluated directly only.*/
+		spin_unlock_irqrestore(&sch->lock, flags);
+		return 0;
 	}
-	/*
-	 * We've got a machine check, so running I/O won't get an interrupt.
-	 * Kill any pending timers.
-	 */
-	if (sch)
-		device_kill_pending_timer(sch);
+	/* No interrupt after machine check - kill pending timers. */
+	device_kill_pending_timer(sch);
 	if (!disc && !slow) {
-		if (sch)
-			put_device(&sch->dev);
-		return -EAGAIN; /* Will be done on the slow path. */
+		/* Non-disconnected devices are evaluated on the slow path. */
+		spin_unlock_irqrestore(&sch->lock, flags);
+		return -EAGAIN;
 	}
-	event = css_get_subchannel_status(sch, schid);
+	event = css_get_subchannel_status(sch);
 	CIO_MSG_EVENT(4, "Evaluating schid 0.%x.%04x, event %d, %s, %s path.\n",
-		      schid.ssid, schid.sch_no, event,
-		      sch?(disc?"disconnected":"normal"):"unknown",
-		      slow?"slow":"fast");
+		      sch->schid.ssid, sch->schid.sch_no, event,
+		      disc ? "disconnected" : "normal",
+		      slow ? "slow" : "fast");
+	/* Analyze subchannel status. */
+	action = NONE;
 	switch (event) {
 	case CIO_NO_PATH:
-	case CIO_GONE:
-		if (!sch) {
-			/* Never used this subchannel. Ignore. */
-			ret = 0;
+		if (disc) {
+			/* Check if paths have become available. */
+			action = REPROBE;
 			break;
 		}
-		if (disc && (event == CIO_NO_PATH)) {
-			/*
-			 * Uargh, hack again. Because we don't get a machine
-			 * check on configure on, our path bookkeeping can
-			 * be out of date here (it's fine while we only do
-			 * logical varying or get chsc machine checks). We
-			 * need to force reprobing or we might miss devices
-			 * coming operational again. It won't do harm in real
-			 * no path situations.
-			 */
-			spin_lock_irqsave(&sch->lock, flags);
-			device_trigger_reprobe(sch);
+		/* fall through */
+	case CIO_GONE:
+		/* Prevent unwanted effects when opening lock. */
+		cio_disable_subchannel(sch);
+		device_set_disconnected(sch);
+		/* Ask driver what to do with device. */
+		action = UNREGISTER;
+		if (sch->driver && sch->driver->notify) {
 			spin_unlock_irqrestore(&sch->lock, flags);
-			ret = 0;
-			break;
-		}
-		if (sch->driver && sch->driver->notify &&
-		    sch->driver->notify(&sch->dev, event)) {
-			cio_disable_subchannel(sch);
-			device_set_disconnected(sch);
-			ret = 0;
-			break;
+			ret = sch->driver->notify(&sch->dev, event);
+			spin_lock_irqsave(&sch->lock, flags);
+			if (ret)
+				action = NONE;
 		}
-		/*
-		 * Unregister subchannel.
-		 * The device will be killed automatically.
-		 */
-		cio_disable_subchannel(sch);
-		css_sch_device_unregister(sch);
-		/* Reset intparm to zeroes. */
-		sch->schib.pmcw.intparm = 0;
-		cio_modify(sch);
-		put_device(&sch->dev);
-		ret = 0;
 		break;
 	case CIO_REVALIDATE:
-		/* 
-		 * Revalidation machine check. Sick.
-		 * We don't notify the driver since we have to throw the device
-		 * away in any case.
-		 */
-		if (!disc) {
-			css_sch_device_unregister(sch);
-			/* Reset intparm to zeroes. */
-			sch->schib.pmcw.intparm = 0;
-			cio_modify(sch);
-			put_device(&sch->dev);
-			ret = css_probe_device(schid);
-		} else {
-			/*
-			 * We can't immediately deregister the disconnected
-			 * device since it might block.
-			 */
-			spin_lock_irqsave(&sch->lock, flags);
-			device_trigger_reprobe(sch);
-			spin_unlock_irqrestore(&sch->lock, flags);
-			ret = 0;
-		}
+		/* Device will be removed, so no notify necessary. */
+		if (disc)
+			/* Reprobe because immediate unregister might block. */
+			action = REPROBE;
+		else
+			action = UNREGISTER_PROBE;
 		break;
 	case CIO_OPER:
-		if (disc) {
-			spin_lock_irqsave(&sch->lock, flags);
+		if (disc)
 			/* Get device operational again. */
-			device_trigger_reprobe(sch);
-			spin_unlock_irqrestore(&sch->lock, flags);
-		}
-		ret = sch ? 0 : css_probe_device(schid);
+			action = REPROBE;
+		break;
+	}
+	/* Perform action. */
+	ret = 0;
+	switch (action) {
+	case UNREGISTER:
+	case UNREGISTER_PROBE:
+		/* Unregister device (will use subchannel lock). */
+		spin_unlock_irqrestore(&sch->lock, flags);
+		css_sch_device_unregister(sch);
+		spin_lock_irqsave(&sch->lock, flags);
+
+		/* Reset intparm to zeroes. */
+		sch->schib.pmcw.intparm = 0;
+		cio_modify(sch);
+
+		/* Probe if necessary. */
+		if (action == UNREGISTER_PROBE)
+			ret = css_probe_device(sch->schid);
+		break;
+	case REPROBE:
+		device_trigger_reprobe(sch);
 		break;
 	default:
-		BUG();
-		ret = 0;
+		break;
+	}
+	spin_unlock_irqrestore(&sch->lock, flags);
+
+	return ret;
+}
+
+static int css_evaluate_new_subchannel(struct subchannel_id schid, int slow)
+{
+	struct schib schib;
+
+	if (!slow) {
+		/* Will be done on the slow path. */
+		return -EAGAIN;
 	}
+	if (stsch(schid, &schib) || !schib.pmcw.dnv) {
+		/* Unusable - ignore. */
+		return 0;
+	}
+	CIO_MSG_EVENT(4, "Evaluating schid 0.%x.%04x, event %d, unknown, "
+			 "slow path.\n", schid.ssid, schid.sch_no, CIO_OPER);
+
+	return css_probe_device(schid);
+}
+
+static int css_evaluate_subchannel(struct subchannel_id schid, int slow)
+{
+	struct subchannel *sch;
+	int ret;
+
+	sch = get_subchannel_by_schid(schid);
+	if (sch) {
+		ret = css_evaluate_known_subchannel(sch, slow);
+		put_device(&sch->dev);
+	} else
+		ret = css_evaluate_new_subchannel(schid, slow);
+
 	return ret;
 }
 
