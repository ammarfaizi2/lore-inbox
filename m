Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423339AbWF1ONF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423339AbWF1ONF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423344AbWF1ONF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:13:05 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:53787 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423343AbWF1ONB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:13:01 -0400
Date: Wed, 28 Jun 2006 16:13:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch] s390: cio chpid offline
Message-ID: <20060628141311.GB14375@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio chpid offline.

After setting a path to a dasd offline at the SE, I/O hangs on that
dasd for 5 minutes, then continues.
I/O for which an interrupt will not be reported after the channel
path has been disabled was not terminated by the common I/O layer,
causing the dasd MIH to hit after 5 minutes.

Be more aggressive in terminating I/O after setting a channel path
offline. Also make sure to generate a fake irb if the device
driver issues an I/O request after being notified of the killed
I/O and clear residual information from the irb before trying to
start the delayed verification.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c       |    3 +--
 drivers/s390/cio/device_fsm.c |    2 ++
 drivers/s390/cio/device_ops.c |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-06-28 14:43:27.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-06-28 14:43:48.000000000 +0200
@@ -244,8 +244,7 @@ s390_subchannel_remove_chpid(struct devi
 
 	if ((sch->schib.scsw.actl & SCSW_ACTL_DEVACT) &&
 	    (sch->schib.scsw.actl & SCSW_ACTL_SCHACT) &&
-	    (sch->schib.pmcw.lpum == mask) &&
-	    (sch->vpm == 0)) {
+	    (sch->schib.pmcw.lpum == mask)) {
 		int cc;
 
 		cc = cio_clear(sch);
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-06-28 14:43:46.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-06-28 14:43:48.000000000 +0200
@@ -864,6 +864,8 @@ ccw_device_clear_verify(struct ccw_devic
 	irb = (struct irb *) __LC_IRB;
 	/* Accumulate status. We don't do basic sense. */
 	ccw_device_accumulate_irb(cdev, irb);
+	/* Remember to clear irb to avoid residuals. */
+	memset(&cdev->private->irb, 0, sizeof(struct irb));
 	/* Try to start delayed device verification. */
 	ccw_device_online_verify(cdev, 0);
 	/* Note: Don't call handler for cio initiated clear! */
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-06-28 14:43:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-06-28 14:43:48.000000000 +0200
@@ -78,7 +78,8 @@ ccw_device_start_key(struct ccw_device *
 		return -ENODEV;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
-	if (cdev->private->state == DEV_STATE_VERIFY) {
+	if (cdev->private->state == DEV_STATE_VERIFY ||
+	    cdev->private->state == DEV_STATE_CLEAR_VERIFY) {
 		/* Remember to fake irb when finished. */
 		if (!cdev->private->flags.fake_irb) {
 			cdev->private->flags.fake_irb = 1;
