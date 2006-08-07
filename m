Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWHGPQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWHGPQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWHGPQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:16:40 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44828 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932135AbWHGPQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:16:39 -0400
Date: Mon, 7 Aug 2006 17:16:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20060807151638.GA14761@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 drivers/s390/char/tape_class.c |    2 +-
 drivers/s390/cio/device_fsm.c  |    1 +
 drivers/s390/cio/device_ops.c  |    3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

Cornelia Huck:
      [S390] retry after deferred condition code.

Heiko Carstens:
      [S390] tape class return value handling.

Peter Oberparleiter:
      [S390] lost interrupt after chpid vary off/on cycle.

diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index 643b6d0..56b8761 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -76,7 +76,7 @@ struct tape_class_device *register_tape_
 				device,
 				"%s", tcd->device_name
 			);
-	rc = PTR_ERR(tcd->class_device);
+	rc = IS_ERR(tcd->class_device) ? PTR_ERR(tcd->class_device) : 0;
 	if (rc)
 		goto fail_with_cdev;
 	rc = sysfs_create_link(
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 7a39e0b..6d91c2e 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -772,6 +772,7 @@ ccw_device_online_verify(struct ccw_devi
 	stsch(sch->schid, &sch->schib);
 
 	if (sch->schib.scsw.actl != 0 ||
+	    (sch->schib.scsw.stctl & SCSW_STCTL_STATUS_PEND) ||
 	    (cdev->private->irb.scsw.stctl & SCSW_STCTL_STATUS_PEND)) {
 		/*
 		 * No final status yet or final status not yet delivered
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index a601242..9e3de0b 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
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
