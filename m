Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUIPL25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUIPL25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUIPL25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:28:57 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:14303 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267961AbUIPL14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:27:56 -0400
Date: Thu, 16 Sep 2004 12:27:52 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK pull] [DRM] latest DRM patches..
Message-ID: <Pine.LNX.4.58.0409161226180.17566@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drm_drv.h      |   11 +++++++----
 drivers/char/drm/drm_os_linux.h |    4 ++--
 drivers/char/drm/drm_scatter.h  |    2 +-
 drivers/char/drm/i830_irq.c     |    4 ++--
 4 files changed, 12 insertions(+), 9 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/09/16 1.1904)
   drm: use set_current_state instead of direct assignment

   Suggested-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/16 1.1903)
   drm: add pci_enable_device

   Add pci_enable_device for any PCI device we want to use.

   From: Bjorn Helgaas <bjorn.helgaas@hp.com>
   Approved-by: David Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/16 1.1902)
   drm: fix bug introduced in the macro removal

   This caused issues with a PCI radeon card.

   From: Jon Smirl
   Approved-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Thu Sep 16 21:24:25 2004
+++ b/drivers/char/drm/drm_drv.h	Thu Sep 16 21:24:25 2004
@@ -480,6 +480,9 @@
 	if (DRM(numdevs) >= MAX_DEVICES)
 		return -ENODEV;

+	if ((retcode=pci_enable_device(pdev)))
+		return retcode;
+
 	dev = &(DRM(device)[DRM(numdevs)]);

 	memset( (void *)dev, 0, sizeof(*dev) );
@@ -785,7 +788,7 @@

 		add_wait_queue( &dev->lock.lock_queue, &entry );
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if ( !dev->lock.hw_lock ) {
 				/* Device has been unregistered */
 				retcode = -EINTR;
@@ -805,7 +808,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue( &dev->lock.lock_queue, &entry );
 		if( !retcode ) {
 			if (dev->fn_tbl.release)
@@ -985,7 +988,7 @@

 	add_wait_queue( &dev->lock.lock_queue, &entry );
 	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		if ( !dev->lock.hw_lock ) {
 			/* Device has been unregistered */
 			ret = -EINTR;
@@ -1006,7 +1009,7 @@
 			break;
 		}
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue( &dev->lock.lock_queue, &entry );

 	sigemptyset( &dev->sigmask );
diff -Nru a/drivers/char/drm/drm_os_linux.h b/drivers/char/drm/drm_os_linux.h
--- a/drivers/char/drm/drm_os_linux.h	Thu Sep 16 21:24:25 2004
+++ b/drivers/char/drm/drm_os_linux.h	Thu Sep 16 21:24:25 2004
@@ -134,7 +134,7 @@
 	add_wait_queue(&(queue), &entry);			\
 								\
 	for (;;) {						\
-		current->state = TASK_INTERRUPTIBLE;		\
+		set_current_state(TASK_INTERRUPTIBLE);		\
 		if (condition)					\
 			break;					\
 		if (time_after_eq(jiffies, end)) {		\
@@ -147,7 +147,7 @@
 			break;					\
 		}						\
 	}							\
-	current->state = TASK_RUNNING;				\
+	set_current_state(TASK_RUNNING);				\
 	remove_wait_queue(&(queue), &entry);			\
 } while (0)

diff -Nru a/drivers/char/drm/drm_scatter.h b/drivers/char/drm/drm_scatter.h
--- a/drivers/char/drm/drm_scatter.h	Thu Sep 16 21:24:25 2004
+++ b/drivers/char/drm/drm_scatter.h	Thu Sep 16 21:24:25 2004
@@ -73,7 +73,7 @@

 	DRM_DEBUG( "%s\n", __FUNCTION__ );

-	if (drm_core_check_feature(dev, DRIVER_SG))
+	if (!drm_core_check_feature(dev, DRIVER_SG))
 		return -EINVAL;

 	if ( dev->sg )
diff -Nru a/drivers/char/drm/i830_irq.c b/drivers/char/drm/i830_irq.c
--- a/drivers/char/drm/i830_irq.c	Thu Sep 16 21:24:25 2004
+++ b/drivers/char/drm/i830_irq.c	Thu Sep 16 21:24:25 2004
@@ -92,7 +92,7 @@
 	add_wait_queue(&dev_priv->irq_queue, &entry);

 	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 	   	if (atomic_read(&dev_priv->irq_received) >= irq_nr)
 		   break;
 		if((signed)(end - jiffies) <= 0) {
@@ -112,7 +112,7 @@
 		}
 	}

-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dev_priv->irq_queue, &entry);
 	return ret;
 }
