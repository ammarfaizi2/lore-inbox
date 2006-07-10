Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWGJJ1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWGJJ1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWGJJ1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:27:44 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:64309 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932491AbWGJJ1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:27:43 -0400
Date: Mon, 10 Jul 2006 11:27:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch] s390: subchannel register/unregister mutex.
Message-ID: <20060710092750.GA30303@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] subchannel register/unregister mutex.

Add a reg_mutex to prevent unregistering a subchannel before it has been
registered. Since 2.6.17, we've seen oopses in kslowcrw when a device is
found to be not operational during sense id when doing initial device
recognition; it is not clear yet why that particular problem was not (yet)
observed with earlier kernels...

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c    |    1 +
 drivers/s390/cio/cio.h    |    3 ++-
 drivers/s390/cio/css.c    |   24 +++++++++++++++++++++---
 drivers/s390/cio/css.h    |    2 ++
 drivers/s390/cio/device.c |    6 +++---
 5 files changed, 29 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-07-10 10:33:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-07-10 10:33:41.000000000 +0200
@@ -519,6 +519,7 @@ cio_validate_subchannel (struct subchann
 	memset(sch, 0, sizeof(struct subchannel));
 
 	spin_lock_init(&sch->lock);
+	mutex_init(&sch->reg_mutex);
 
 	/* Set a name for the subchannel */
 	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
diff -urpN linux-2.6/drivers/s390/cio/cio.h linux-2.6-patched/drivers/s390/cio/cio.h
--- linux-2.6/drivers/s390/cio/cio.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.h	2006-07-10 10:33:41.000000000 +0200
@@ -2,6 +2,7 @@
 #define S390_CIO_H
 
 #include "schid.h"
+#include <linux/mutex.h>
 
 /*
  * where we put the ssd info
@@ -87,7 +88,7 @@ struct orb {
 struct subchannel {
 	struct subchannel_id schid;
 	spinlock_t lock;	/* subchannel lock */
-
+	struct mutex reg_mutex;
 	enum {
 		SUBCHANNEL_TYPE_IO = 0,
 		SUBCHANNEL_TYPE_CHSC = 1,
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-07-10 10:33:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-07-10 10:33:41.000000000 +0200
@@ -108,6 +108,24 @@ css_subchannel_release(struct device *de
 
 extern int css_get_ssd_info(struct subchannel *sch);
 
+
+int css_sch_device_register(struct subchannel *sch)
+{
+	int ret;
+
+	mutex_lock(&sch->reg_mutex);
+	ret = device_register(&sch->dev);
+	mutex_unlock(&sch->reg_mutex);
+	return ret;
+}
+
+void css_sch_device_unregister(struct subchannel *sch)
+{
+	mutex_lock(&sch->reg_mutex);
+	device_unregister(&sch->dev);
+	mutex_unlock(&sch->reg_mutex);
+}
+
 static int
 css_register_subchannel(struct subchannel *sch)
 {
@@ -119,7 +137,7 @@ css_register_subchannel(struct subchanne
 	sch->dev.release = &css_subchannel_release;
 	
 	/* make it known to the system */
-	ret = device_register(&sch->dev);
+	ret = css_sch_device_register(sch);
 	if (ret)
 		printk (KERN_WARNING "%s: could not register %s\n",
 			__func__, sch->dev.bus_id);
@@ -250,7 +268,7 @@ css_evaluate_subchannel(struct subchanne
 		 * The device will be killed automatically.
 		 */
 		cio_disable_subchannel(sch);
-		device_unregister(&sch->dev);
+		css_sch_device_unregister(sch);
 		/* Reset intparm to zeroes. */
 		sch->schib.pmcw.intparm = 0;
 		cio_modify(sch);
@@ -264,7 +282,7 @@ css_evaluate_subchannel(struct subchanne
 		 * away in any case.
 		 */
 		if (!disc) {
-			device_unregister(&sch->dev);
+			css_sch_device_unregister(sch);
 			/* Reset intparm to zeroes. */
 			sch->schib.pmcw.intparm = 0;
 			cio_modify(sch);
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-07-10 10:33:41.000000000 +0200
@@ -136,6 +136,8 @@ extern struct bus_type css_bus_type;
 extern struct css_driver io_subchannel_driver;
 
 extern int css_probe_device(struct subchannel_id);
+extern int css_sch_device_register(struct subchannel *);
+extern void css_sch_device_unregister(struct subchannel *);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-07-10 10:33:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-07-10 10:33:41.000000000 +0200
@@ -280,7 +280,7 @@ ccw_device_remove_disconnected(struct cc
 	 * 'throw away device'.
 	 */
 	sch = to_subchannel(cdev->dev.parent);
-	device_unregister(&sch->dev);
+	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
@@ -625,7 +625,7 @@ ccw_device_do_unreg_rereg(void *data)
 					other_sch->schib.pmcw.intparm = 0;
 					cio_modify(other_sch);
 				}
-				device_unregister(&other_sch->dev);
+				css_sch_device_unregister(other_sch);
 			}
 		}
 		/* Update ssd info here. */
@@ -709,7 +709,7 @@ ccw_device_call_sch_unregister(void *dat
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	device_unregister(&sch->dev);
+	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
