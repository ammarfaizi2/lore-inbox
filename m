Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWIROOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWIROOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWIROOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:14:50 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:43014 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965092AbWIROOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:14:49 -0400
Date: Mon, 18 Sep 2006 16:14:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] cio: update path groups on logical CHPID changes.
Message-ID: <20060918141446.GB5612@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: update path groups on logical CHPID changes.

CHPIDs that are logically varied off will not be removed from
a CCW device's path group because resign-from-pathgroup command is
issued with invalid path mask of 0 because internal CCW operations
are masked by the logical path mask after the relevant bits are
cleared by the vary operation.
Do not apply logical path mask to internal operations.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c        |    2 +-
 drivers/s390/cio/device_ops.c |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-09-18 14:11:42.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-09-18 14:12:00.000000000 +0200
@@ -191,7 +191,7 @@ cio_start_key (struct subchannel *sch,	/
 	sch->orb.pfch = sch->options.prefetch == 0;
 	sch->orb.spnd = sch->options.suspend;
 	sch->orb.ssic = sch->options.suspend && sch->options.inter;
-	sch->orb.lpm = (lpm != 0) ? (lpm & sch->opm) : sch->lpm;
+	sch->orb.lpm = (lpm != 0) ? lpm : sch->lpm;
 #ifdef CONFIG_64BIT
 	/*
 	 * for 64 bit we always support 64 bit IDAWs with 4k page size only
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-09-18 14:11:04.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-09-18 14:12:00.000000000 +0200
@@ -96,6 +96,12 @@ ccw_device_start_key(struct ccw_device *
 	ret = cio_set_options (sch, flags);
 	if (ret)
 		return ret;
+	/* Adjust requested path mask to excluded varied off paths. */
+	if (lpm) {
+		lpm &= sch->opm;
+		if (lpm == 0)
+			return -EACCES;
+	}
 	ret = cio_start_key (sch, cpa, lpm, key);
 	if (ret == 0)
 		cdev->private->intparm = intparm;
@@ -304,7 +310,7 @@ __ccw_device_retry_loop(struct ccw_devic
 	sch = to_subchannel(cdev->dev.parent);
 	do {
 		ret = cio_start (sch, ccw, lpm);
-		if ((ret == -EBUSY) || (ret == -EACCES)) {
+		if (ret == -EBUSY) {
 			/* Try again later. */
 			spin_unlock_irq(&sch->lock);
 			msleep(10);
@@ -433,6 +439,13 @@ read_conf_data_lpm (struct ccw_device *c
 	if (!ciw || ciw->cmd == 0)
 		return -EOPNOTSUPP;
 
+	/* Adjust requested path mask to excluded varied off paths. */
+	if (lpm) {
+		lpm &= sch->opm;
+		if (lpm == 0)
+			return -EACCES;
+	}
+
 	rcd_ccw = kzalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
 	if (!rcd_ccw)
 		return -ENOMEM;
