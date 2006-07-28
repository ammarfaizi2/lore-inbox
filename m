Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWG1I5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWG1I5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWG1I5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:57:52 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:8424 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932592AbWG1I5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:57:51 -0400
Date: Fri, 28 Jul 2006 10:58:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [patch] s390: permanent subchannel busy conditions may cause I/O stall
Message-ID: <20060728085801.GA19478@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] permanent subchannel busy conditions may cause I/O stall

In special conditions where a subchannel rejects the HALT I/O-
instruction with a busy indication (cc 2), I/O may stall.
I/O request termination logic retries HALT I/O indefinitely
because it expects HALT I/O to alter the subchannel status which
is not true when cc 2 is returned.
In case of a busy indication, try CLEAR I/O instruction immediately.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-07-27 13:52:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-07-27 13:52:39.000000000 +0200
@@ -152,7 +152,8 @@ ccw_device_cancel_halt_clear(struct ccw_
 		if (cdev->private->iretry) {
 			cdev->private->iretry--;
 			ret = cio_halt(sch);
-			return (ret == 0) ? -EBUSY : ret;
+			if (ret != -EBUSY)
+				return (ret == 0) ? -EBUSY : ret;
 		}
 		/* halt io unsuccessful. */
 		cdev->private->iretry = 255;	/* 255 clear retries. */
