Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936960AbWLDO5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936960AbWLDO5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936964AbWLDO5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:57:32 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46616 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936971AbWLDO5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:57:10 -0500
Date: Mon, 4 Dec 2006 15:57:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: Use path verification for last path gone after vary off.
Message-ID: <20061204145703.GE32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: Use path verification for last path gone after vary off.

If the last path to a device is gone after a chpid has been varied
off, putting it on the slow queue doesn't prevent a device driver
from still attempting to use it (it may stay on the slow queue for a
long time). Instead, trigger a verify event which will prevent I/O
attempts from the device driver immediately.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c       |   22 ++++++++++++----------
 drivers/s390/cio/css.h        |    1 +
 drivers/s390/cio/device_fsm.c |   11 +++++++++++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-12-04 14:50:48.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-12-04 14:51:04.000000000 +0100
@@ -744,20 +744,22 @@ __s390_subchannel_vary_chpid(struct subc
 				device_trigger_reprobe(sch);
 			else if (sch->driver && sch->driver->verify)
 				sch->driver->verify(&sch->dev);
-		} else {
-			sch->opm &= ~(0x80 >> chp);
-			sch->lpm &= ~(0x80 >> chp);
-			if (check_for_io_on_path(sch, chp))
-				/* Path verification is done after killing. */
-				device_kill_io(sch);
-			else if (!sch->lpm) {
+			break;
+		}
+		sch->opm &= ~(0x80 >> chp);
+		sch->lpm &= ~(0x80 >> chp);
+		if (check_for_io_on_path(sch, chp))
+			/* Path verification is done after killing. */
+			device_kill_io(sch);
+		else if (!sch->lpm) {
+			if (device_trigger_verify(sch) != 0) {
 				if (css_enqueue_subchannel_slow(sch->schid)) {
 					css_clear_subchannel_slow_list();
 					need_rescan = 1;
 				}
-			} else if (sch->driver && sch->driver->verify)
-				sch->driver->verify(&sch->dev);
-		}
+			}
+		} else if (sch->driver && sch->driver->verify)
+			sch->driver->verify(&sch->dev);
 		break;
 	}
 	spin_unlock_irqrestore(&sch->lock, flags);
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-12-04 14:51:04.000000000 +0100
@@ -171,6 +171,7 @@ void device_trigger_reprobe(struct subch
 /* Helper functions for vary on/off. */
 int device_is_online(struct subchannel *);
 void device_kill_io(struct subchannel *);
+int device_trigger_verify(struct subchannel *sch);
 
 /* Machine check helper function. */
 void device_kill_pending_timer(struct subchannel *);
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-12-04 14:51:04.000000000 +0100
@@ -59,6 +59,17 @@ device_set_disconnected(struct subchanne
 	cdev->private->state = DEV_STATE_DISCONNECTED;
 }
 
+int device_trigger_verify(struct subchannel *sch)
+{
+	struct ccw_device *cdev;
+
+	cdev = sch->dev.driver_data;
+	if (!cdev || !cdev->online)
+		return -EINVAL;
+	dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+	return 0;
+}
+
 /*
  * Timeout function. It just triggers a DEV_EVENT_TIMEOUT.
  */
