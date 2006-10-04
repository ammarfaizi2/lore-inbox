Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWJDSBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWJDSBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWJDSBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:01:15 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:57333 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422667AbWJDSAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:00:44 -0400
Date: Wed, 4 Oct 2006 20:00:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] cio: improve unit check handling for internal operations
Message-ID: <20061004180046.GK26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: improve unit check handling for internal operations

Retry internal operation after unit check instead of aborting them.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_ops.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-10-04 19:53:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-10-04 19:53:54.000000000 +0200
@@ -288,10 +288,10 @@ ccw_device_wake_up(struct ccw_device *cd
 		 if (cdev->private->flags.doverify ||
 			 cdev->private->state == DEV_STATE_VERIFY)
 			 cdev->private->intparm = -EAGAIN;
-		 if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
-		     !(irb->ecw[0] &
-		       (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)))
-			 cdev->private->intparm = -EAGAIN;
+		else if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
+			 !(irb->ecw[0] &
+			   (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)))
+			cdev->private->intparm = -EAGAIN;
 		else if ((irb->scsw.dstat & DEV_STAT_ATTENTION) &&
 			 (irb->scsw.dstat & DEV_STAT_DEV_END) &&
 			 (irb->scsw.dstat & DEV_STAT_UNIT_EXCEP))
