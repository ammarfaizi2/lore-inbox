Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTDQUPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTDQUPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:15:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25557 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262526AbTDQUPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:15:06 -0400
Date: Thu, 17 Apr 2003 13:27:14 -0700
From: Dave Olien <dmo@osdl.org>
To: John v/d Kamp <john@connectux.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DAC960_Release bug (2.4.x)
Message-ID: <20030417202714.GA30622@osdl.org>
References: <Pine.LNX.4.53.0304161136270.18523@fratser> <20030416224013.GA11514@osdl.org> <Pine.LNX.4.53.0304171004160.10181@fratser>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0304171004160.10181@fratser>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been looking over the kernel's code paths that call a block driver's
release method.  In linux 2.4 and 2.5, it looks like nowhere does the
kernel EVER call the release method with a non-NULL file descriptor.
The file pointer argument to the release method seems to be a left-over
from linux 2.2.

I think the DAC960_Open and DAC960_Release methods in 2.4 and 2.5
are more broken than it first appears.  

The SPECIAL file descriptor that you get with O_NONBLOCK
is a BAD idea.  But we're probably stuck because applications use it.
Could you pass me a URL to the libhd library you're using?  I'd like
to look it over.  What behavior does it expect with the O_NBLOCK flag?

I think what I'll do is assert that there can be ONLY ONE such SPECIAL
file descriptor open at a time.  At Open time, we'll save a pointer to
the inode for this special file descriptor in a module-local variable.
If at open time, we discover there is already such an open file descriptor,
we'll refuse to open another one.

In the release function, we'll compare the inode pointer passed in with
the saved inode pointer, and do the SPECIAL close case, and then zero
out the saved inode pointer.  This isn't a completely reliable solution.
But, it's the best I think of for now.

A patch for 2.4 is attached at the end of this mail.  I'd appreciate it if
you could give it a try and let me know how it works.

On Thu, Apr 17, 2003 at 10:48:51AM +0200, John v/d Kamp wrote:
> We have an application that detects hardware using the libhd from SuSE.
> This lib loads the driver with the NONBLOCK flag, because it doesn't want
> to use the drive, but only detect it. When it releases, the File parameter
> is NULL, so the counters get decremented, but were never incremented.
> 
> When we try to partition the drive, the BLKRRPART ioctl fails because the
> counter is 4294967295. (-1)
> I don't think any program relies on this counter being < "0".
> 
> The whole point on the file descriptor is beyond me, but I think it's a
> good thing to address.
> 

------------------------------------------------------------------------------

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
