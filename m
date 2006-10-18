Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWJRQ1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWJRQ1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWJRQ1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:27:20 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49022 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422651AbWJRQ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:27:17 -0400
Date: Wed, 18 Oct 2006 18:27:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: update documentation.
Message-ID: <20061018162724.GG7158@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: update documentation.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/CommonIO         |    2 -
 Documentation/s390/cds.txt          |   52 ++++++++++++++++--------------------
 Documentation/s390/driver-model.txt |    3 ++
 3 files changed, 28 insertions(+), 29 deletions(-)

diff -urpN linux-2.6/Documentation/s390/cds.txt linux-2.6-patched/Documentation/s390/cds.txt
--- linux-2.6/Documentation/s390/cds.txt	2006-10-18 17:12:31.000000000 +0200
+++ linux-2.6-patched/Documentation/s390/cds.txt	2006-10-18 17:12:58.000000000 +0200
@@ -174,14 +174,10 @@ read_dev_chars() - Read Device Character
 
 This routine returns the characteristics for the device specified.
 
-The function is meant to be called with an irq handler in place; that is,
+The function is meant to be called with the device already enabled; that is,
 at earliest during set_online() processing.
 
-While the request is processed synchronously, the device interrupt
-handler is called for final ending status. In case of error situations the
-interrupt handler may recover appropriately. The device irq handler can
-recognize the corresponding interrupts by the interruption parameter be
-0x00524443. The ccw_device must not be locked prior to calling read_dev_chars().
+The ccw_device must not be locked prior to calling read_dev_chars().
 
 The function may be called enabled or disabled.
 
@@ -410,26 +406,7 @@ individual flag meanings.
 
 Usage Notes :
 
-Prior to call ccw_device_start() the device driver must assure disabled state,
-i.e. the I/O mask value in the PSW must be disabled. This can be accomplished
-by calling local_save_flags( flags). The current PSW flags are preserved and
-can be restored by local_irq_restore( flags) at a later time.
-
-If the device driver violates this rule while running in a uni-processor
-environment an interrupt might be presented prior to the ccw_device_start()
-routine returning to the device driver main path. In this case we will end in a
-deadlock situation as the interrupt handler will try to obtain the irq
-lock the device driver still owns (see below) !
-
-The driver must assure to hold the device specific lock. This can be
-accomplished by
-
-(i)  spin_lock(get_ccwdev_lock(cdev)), or
-(ii) spin_lock_irqsave(get_ccwdev_lock(cdev), flags)
-
-Option (i) should be used if the calling routine is running disabled for
-I/O interrupts (see above) already. Option (ii) obtains the device gate und
-puts the CPU into I/O disabled state by preserving the current PSW flags.
+ccw_device_start() must be called disabled and with the ccw device lock held.
 
 The device driver is allowed to issue the next ccw_device_start() call from
 within its interrupt handler already. It is not required to schedule a
@@ -488,7 +465,7 @@ int ccw_device_resume(struct ccw_device 
 
 cdev - ccw_device the resume operation is requested for
 
-The resume_IO() function returns:
+The ccw_device_resume() function returns:
 
         0  - suspended channel program is resumed
 -EBUSY     - status pending
@@ -507,6 +484,8 @@ a long-running channel program or the de
 a halt subchannel (HSCH) I/O command. For those purposes the ccw_device_halt()
 command is provided.
 
+ccw_device_halt() must be called disabled and with the ccw device lock held.
+
 int ccw_device_halt(struct ccw_device *cdev,
                     unsigned long intparm);
 
@@ -517,7 +496,7 @@ intparm : interruption parameter; value 
 
 The ccw_device_halt() function returns :
 
-      0 - successful completion or request successfully initiated
+      0 - request successfully initiated
 -EBUSY  - the device is currently busy, or status pending.
 -ENODEV - cdev invalid.
 -EINVAL - The device is not operational or the ccw device is not online.
@@ -533,6 +512,23 @@ can then perform an appropriate action. 
 read to a network device (with or without PCI flag) a ccw_device_halt()
 is required to end the pending operation.
 
+ccw_device_clear() - Terminage I/O Request Processing
+
+In order to terminate all I/O processing at the subchannel, the clear subchannel
+(CSCH) command is used. It can be issued via ccw_device_clear().
+
+ccw_device_clear() must be called disabled and with the ccw device lock held.
+
+int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm);
+
+cdev:	 ccw_device the clear operation is requested for
+intparm: interruption parameter (see ccw_device_halt())
+
+The ccw_device_clear() function returns:
+
+      0 - request successfully initiated
+-ENODEV - cdev invalid
+-EINVAL - The device is not operational or the ccw device is not online.
 
 Miscellaneous Support Routines
 
diff -urpN linux-2.6/Documentation/s390/CommonIO linux-2.6-patched/Documentation/s390/CommonIO
--- linux-2.6/Documentation/s390/CommonIO	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/Documentation/s390/CommonIO	2006-10-18 17:12:58.000000000 +0200
@@ -66,7 +66,7 @@ Command line parameters
 
   When a device is un-ignored, device recognition and sensing is performed and 
   the device driver will be notified if possible, so the device will become
-  available to the system.
+  available to the system. Note that un-ignoring is performed asynchronously.
 
   You can also add ranges of devices to be ignored by piping to 
   /proc/cio_ignore; "add <device range>, <device range>, ..." will ignore the
diff -urpN linux-2.6/Documentation/s390/driver-model.txt linux-2.6-patched/Documentation/s390/driver-model.txt
--- linux-2.6/Documentation/s390/driver-model.txt	2006-10-18 17:12:31.000000000 +0200
+++ linux-2.6-patched/Documentation/s390/driver-model.txt	2006-10-18 17:12:58.000000000 +0200
@@ -239,6 +239,9 @@ status - Can be 'online' or 'offline'.
 
 type - The physical type of the channel path.
 
+shared - Whether the channel path is shared.
+
+cmg - The channel measurement group.
 
 3. System devices
 -----------------
