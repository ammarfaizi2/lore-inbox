Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTDURL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDURL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:11:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261760AbTDURLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:11:53 -0400
Date: Mon, 21 Apr 2003 10:24:04 -0700
From: Dave Olien <dmo@osdl.org>
To: marcelo@conectiva.com.br, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960 open with O_NONBLOCK
Message-ID: <20030421172402.GA26863@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a problem with the DAC960 driver that occurs when the
block special file for controller 0, disk 0 is opened with the O_NONBLOCK
flag.

The DAC960 is a RAID controller, and under startup or error conditions,
it's possible for all devices under DAC960 control to be "offline".  
The driver supports "pass through" commands to the controller that can be
used to diagnose and modify the state of disk devices. A RAID management
tool uses ioctl() on a "special" file descriptor to send these "pass through"
commands to a controller. The first argument of these ioctls is the
controller number that is the target of the pass through command. So, this
one special file descriptor can operate on any DAC960 controller.

This "special" file descriptor is created when the driver's open method
is called with for block special file for controller 0, disk 0,
with the O_NONBLOCK flag set.  In thsi case, the driver's open method
bypasses all checks for a disk associated with that file, and doesn't
increment any reference counts.

The problem comes at close() time.  This driver code apparently originated
with linux 2.2, where driver operations were all "file operations".
In linux 2.2, the driver release method was passed the file descriptor
that has the O_NONBLOCK flag set.  The release method knows then to not
decrement reference counts, etc.

In linux 2.4, driver release methods still have a file descriptor argument.
But, the kernel NEVER passes a non-NULL file argument to the release method.
So, the DAC960 driver doesn't know that the release method is being called
for this "special" file descriptor, and improperly decrements reference
counts.  This makes subsequent opens now work right.

I don't like this "special file descriptor" method.  I would have much
rather created an entry in /proc or something to support these pass through
commands.  But I imagine there are applications out there that expect
these special file descriptors.  On the other hand, this HAS been
broken throught the life on linux 2.4.

The patch below does a "best try" fix to this problem.  It's not
a 100% reliable fix.

I'll be submitting a similar patch to linux 2.5 shortly.

Comments?



-----------------------------------------------------------------------------

diff -ur linux-2.4.18_original/drivers/block/DAC960.c linux-2.4.18_DAC/drivers/block/DAC960.c
--- linux-2.4.18_original/drivers/block/DAC960.c	2001-10-25 13:58:35.000000000 -0700
+++ linux-2.4.18_DAC/drivers/block/DAC960.c	2003-04-17 13:11:15.000000000 -0700
@@ -48,6 +48,31 @@
 #include <asm/uaccess.h>
 #include "DAC960.h"
 
+/*
+ * DAC960_SpecialInode is used to indicate that the DAC960_Open
+ * method was called with the file descriptor that has its O_NONBLOCK
+ * flag set, and was with an inode for controller 0, logical device 0.
+ *
+ * Under this case, DAC960_Open enables a "special" file descriptor that
+ * does not reference a real disk device.  This file descriptor can
+ * be used ONLY for calls to DAC960_UserIOCTL(), which is able to
+ * operate on DAC960 controllers to do "pass through" commands.  These
+ * "pass through" commands can be used to query the state of the devices
+ * on the controller, and modify the state of those devices.
+ *
+ * This "special" file descriptor implementation is a bad idea.  But,
+ * we're stuck with it because there applications that rely on it.
+ * (although this has been broken throughout the entire linux 2.4
+ * release.  So, maybe this could in fact be removed.)
+ *
+ * This fix isn't completely reliable.  But, it should handle  the
+ * common cases.  Almost certainly, there is only one inode for
+ * the (controller 0, disk 0) device in any system.  So, the
+ * SpecialInode pointer is really just a flag in this case.  But,
+ * we'll save the inode pointer as well, just in case.
+ */
+static Inode_T		*DAC960_SpecialInode = NULL;
+static spinlock_t	DAC960_SpecialInodeLock;
 
 /*
   DAC960_ControllerCount is the number of DAC960 Controllers detected.
@@ -5340,9 +5365,29 @@
   int ControllerNumber = DAC960_ControllerNumber(Inode->i_rdev);
   int LogicalDriveNumber = DAC960_LogicalDriveNumber(Inode->i_rdev);
   DAC960_Controller_T *Controller;
+
+  /*
+   * Open a "Special" file descriptor that can be used
+   * to operate on any DAC960 controller, even if there are
+   * no logical devices online.  This hooks into code
+   * in DAC960_IOCTL and DAC960_Close.
+   *
+   * This "Special" file descriptor is a bad idea, but
+   * we're probably stuck with it because of existing 
+   * applications that use it.
+   */
   if (ControllerNumber == 0 && LogicalDriveNumber == 0 &&
-      (File->f_flags & O_NONBLOCK))
-    goto ModuleOnly;
+		(File->f_flags & O_NONBLOCK) && capable(CAP_SYS_ADMIN)) {
+      spin_lock_irq(&DAC960_SpecialInodeLock);
+      if (DAC960_SpecialInode != NULL) {
+      	spin_unlock_irq(&DAC960_SpecialInodeLock);
+	return -ENXIO;
+      }
+      DAC960_SpecialInode = Inode;
+      spin_unlock_irq(&DAC960_SpecialInodeLock);
+      goto ModuleOnly;
+  }
+
   if (ControllerNumber < 0 || ControllerNumber > DAC960_ControllerCount - 1)
     return -ENXIO;
   Controller = DAC960_Controllers[ControllerNumber];
@@ -5376,7 +5421,6 @@
   /*
     Increment Controller and Logical Drive Usage Counts.
   */
-  Controller->ControllerUsageCount++;
   Controller->LogicalDriveUsageCount[LogicalDriveNumber]++;
  ModuleOnly:
   return 0;
@@ -5392,15 +5436,12 @@
   int ControllerNumber = DAC960_ControllerNumber(Inode->i_rdev);
   int LogicalDriveNumber = DAC960_LogicalDriveNumber(Inode->i_rdev);
   DAC960_Controller_T *Controller = DAC960_Controllers[ControllerNumber];
-  if (ControllerNumber == 0 && LogicalDriveNumber == 0 &&
-      File != NULL && (File->f_flags & O_NONBLOCK))
-    goto ModuleOnly;
-  /*
-    Decrement the Logical Drive and Controller Usage Counts.
-  */
-  Controller->LogicalDriveUsageCount[LogicalDriveNumber]--;
-  Controller->ControllerUsageCount--;
- ModuleOnly:
+
+  if ((Inode == DAC960_SpecialInode) && capable(CAP_SYS_ADMIN))
+    DAC960_SpecialInode = NULL;
+  else
+     Controller->LogicalDriveUsageCount[LogicalDriveNumber]--;
+
   return 0;
 }
 
diff -ur linux-2.4.18_original/drivers/block/DAC960.h linux-2.4.18_DAC/drivers/block/DAC960.h
--- linux-2.4.18_original/drivers/block/DAC960.h	2001-10-17 14:46:29.000000000 -0700
+++ linux-2.4.18_DAC/drivers/block/DAC960.h	2003-04-17 11:17:45.000000000 -0700
@@ -2341,7 +2341,6 @@
   unsigned short MaxBlocksPerCommand;
   unsigned short ControllerScatterGatherLimit;
   unsigned short DriverScatterGatherLimit;
-  unsigned int ControllerUsageCount;
   unsigned int CombinedStatusBufferLength;
   unsigned int InitialStatusLength;
   unsigned int CurrentStatusLength;
