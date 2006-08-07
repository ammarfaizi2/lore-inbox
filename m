Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWHGPFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWHGPFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWHGPFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:05:49 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:26970 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932124AbWHGPFs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:05:48 -0400
Date: Mon, 7 Aug 2006 17:05:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch] s390: retry after deferred condition code.
Message-ID: <20060807150547.GB10416@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] retry after deferred condition code.

Do a retry of read device characteristics / read configuration
data when a deferred condition code 1 is encountered in
ccw_device_wake_up().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_ops.c |    3 +++
 1 files changed, 3 insertions(+)

diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-08-07 14:14:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-08-07 14:14:43.000000000 +0200
@@ -263,6 +263,9 @@ ccw_device_wake_up(struct ccw_device *cd
 	/* Abuse intparm for error reporting. */
 	if (IS_ERR(irb))
 		cdev->private->intparm = -EIO;
+	else if (irb->scsw.cc == 1)
+		/* Retry for deferred condition code. */
+		cdev->private->intparm = -EAGAIN;
 	else if ((irb->scsw.dstat !=
 		  (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
 		 (irb->scsw.cstat != 0)) {
