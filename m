Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWFNN64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWFNN64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWFNN64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:58:56 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:53618 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964942AbWFNN6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:58:55 -0400
Date: Wed, 14 Jun 2006 15:58:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [patch 4/24] s390: cio long busy in read configuration data.
Message-ID: <20060614135857.GE9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio long busy in read configuration data.

Trying to set a DASD root device online can fail under some circumstances
with the message "Read configuration data returned error -5". The cause
is that read configuration data incorrectly aborts with -EIO when it
encounters a temporary busy condition at a storage server.
Perform retry when encountering temporary busy conditions.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_ops.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-06-14 14:29:35.000000000 +0200
@@ -270,7 +270,8 @@ ccw_device_wake_up(struct ccw_device *cd
 		 * We didn't get channel end / device end. Check if path
 		 * verification has been started; we can retry after it has
 		 * finished. We also retry unit checks except for command reject
-		 * or intervention required.
+		 * or intervention required. Also check for long busy
+		 * conditions.
 		 */
 		 if (cdev->private->flags.doverify ||
 			 cdev->private->state == DEV_STATE_VERIFY)
@@ -279,6 +280,10 @@ ccw_device_wake_up(struct ccw_device *cd
 		     !(irb->ecw[0] &
 		       (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)))
 			 cdev->private->intparm = -EAGAIN;
+		else if ((irb->scsw.dstat & DEV_STAT_ATTENTION) &&
+			 (irb->scsw.dstat & DEV_STAT_DEV_END) &&
+			 (irb->scsw.dstat & DEV_STAT_UNIT_EXCEP))
+			cdev->private->intparm = -EAGAIN;
 		 else
 			 cdev->private->intparm = -EIO;
 			 
