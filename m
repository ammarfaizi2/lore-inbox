Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWI1WTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWI1WTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWI1WSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:18:43 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:37004 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030386AbWI1WSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:18:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 2/3] swsusp: Update userland interface documentation
Date: Fri, 29 Sep 2006 00:17:50 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200609290005.17616.rjw@sisk.pl>
In-Reply-To: <200609290005.17616.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609290017.51335.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The swsusp userland interface has recently changed for a couple of times, but
the changes have not been documented.  Fix this, and document the
SNAPSHOT_SET_SWAP_AREA ioctl().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/swsusp-and-swap-files.txt |   18 +++++--
 Documentation/power/userland-swsusp.txt       |   62 ++++++++++++++++++++------
 2 files changed, 62 insertions(+), 18 deletions(-)

Index: linux-2.6.18-mm2/Documentation/power/userland-swsusp.txt
===================================================================
--- linux-2.6.18-mm2.orig/Documentation/power/userland-swsusp.txt	2006-09-28 22:06:39.000000000 +0200
+++ linux-2.6.18-mm2/Documentation/power/userland-swsusp.txt	2006-09-28 23:02:14.000000000 +0200
@@ -9,9 +9,8 @@ done it already.
 Now, to use the userland interface for software suspend you need special
 utilities that will read/write the system memory snapshot from/to the
 kernel.  Such utilities are available, for example, from
-<http://www.sisk.pl/kernel/utilities/suspend>.  You may want to have
-a look at them if you are going to develop your own suspend/resume
-utilities.
+<http://suspend.sourceforge.net>.  You may want to have a look at them if you
+are going to develop your own suspend/resume utilities.
 
 The interface consists of a character device providing the open(),
 release(), read(), and write() operations as well as several ioctl()
@@ -21,9 +20,9 @@ be read from /sys/class/misc/snapshot/de
 
 The device can be open either for reading or for writing.  If open for
 reading, it is considered to be in the suspend mode.  Otherwise it is
-assumed to be in the resume mode.  The device cannot be open for reading
-and writing.  It is also impossible to have the device open more than once
-at a time.
+assumed to be in the resume mode.  The device cannot be open for simultaneous
+reading and writing.  It is also impossible to have the device open more than
+once at a time.
 
 The ioctl() commands recognized by the device are:
 
@@ -69,9 +68,46 @@ SNAPSHOT_FREE_SWAP_PAGES - free all swap
 SNAPSHOT_SET_SWAP_FILE - set the resume partition (the last ioctl() argument
 	should specify the device's major and minor numbers in the old
 	two-byte format, as returned by the stat() function in the .st_rdev
-	member of the stat structure); it is recommended to always use this
-	call, because the code to set the resume partition could be removed from
-	future kernels
+	member of the stat structure)
+
+SNAPSHOT_SET_SWAP_AREA - set the resume partition and the offset (in <PAGE_SIZE>
+	units) from the beginning of the partition at which the swap header is
+	located (the last ioctl() argument should point to a struct
+	resume_swap_area, as defined in kernel/power/power.h, containing the
+	resume device specification, as for the SNAPSHOT_SET_SWAP_FILE ioctl(),
+	and the offset); for swap partitions the offset is always 0, but it is
+	different to zero for swap files (please see
+	Documentation/swsusp-and-swap-files.txt for details).
+	The SNAPSHOT_SET_SWAP_AREA ioctl() is considered as a replacement for
+	SNAPSHOT_SET_SWAP_FILE which is regarded as obsolete.   It is
+	recommended to always use this call, because the code to set the resume
+	partition may be removed from future kernels
+
+SNAPSHOT_S2RAM - suspend to RAM; using this call causes the kernel to
+	immediately enter the suspend-to-RAM state, so this call must always
+	be preceded by the SNAPSHOT_FREEZE call and it is also necessary
+	to use the SNAPSHOT_UNFREEZE call after the system wakes up.  This call
+	is needed to implement the suspend-to-both mechanism in which the
+	suspend image is first created, as though the system had been suspended
+	to disk, and then the system is suspended to RAM (this makes it possible
+	to resume the system from RAM if there's enough battery power or restore
+	its state on the basis of the saved suspend image otherwise)
+
+SNAPSHOT_PMOPS - enable the usage of the pmops->prepare, pmops->enter and
+	pmops->finish methods (the in-kernel swsusp knows these as the "platform
+	method") which are needed on many machines to (among others) speed up
+	the resume by letting the BIOS skip some steps or to let the system
+	recognise the correct state of the hardware after the resume (in
+	particular on many machines this ensures that unplugged AC
+	adapters get correctly detected and that kacpid does not run wild after
+	the resume).  The last ioctl() argument can take one of the three
+	values, defined in kernel/power/power.h:
+	PMOPS_PREPARE - make the kernel carry out the
+		pm_ops->prepare(PM_SUSPEND_DISK) operation
+	PMOPS_ENTER - make the kernel power off the system by calling
+		pm_ops->enter(PM_SUSPEND_DISK)
+	PMOPS_FINISH - make the kernel carry out the
+		pm_ops->finish(PM_SUSPEND_DISK) operation
 
 The device's read() operation can be used to transfer the snapshot image from
 the kernel.  It has the following limitations:
@@ -92,9 +128,11 @@ still frozen when the device is being cl
 
 Currently it is assumed that the userland utilities reading/writing the
 snapshot image from/to the kernel will use a swap parition, called the resume
-partition, as storage space.  However, this is not really required, as they
-can use, for example, a special (blank) suspend partition or a file on a partition
-that is unmounted before SNAPSHOT_ATOMIC_SNAPSHOT and mounted afterwards.
+partition, or a swap file as storage space (if a swap file is used, the resume
+partition is the partition that holds this file).  However, this is not really
+required, as they can use, for example, a special (blank) suspend partition or
+a file on a partition that is unmounted before SNAPSHOT_ATOMIC_SNAPSHOT and
+mounted afterwards.
 
 These utilities SHOULD NOT make any assumptions regarding the ordering of
 data within the snapshot image, except for the image header that MAY be
Index: linux-2.6.18-mm2/Documentation/power/swsusp-and-swap-files.txt
===================================================================
--- linux-2.6.18-mm2.orig/Documentation/power/swsusp-and-swap-files.txt	2006-09-28 21:53:01.000000000 +0200
+++ linux-2.6.18-mm2/Documentation/power/swsusp-and-swap-files.txt	2006-09-28 23:09:25.000000000 +0200
@@ -38,15 +38,21 @@ resume=<swap_file_partition> resume_offs
 
 where <swap_file_partition> is the partition on which the swap file is located
 and <swap_file_offset> is the offset of the swap header determined by the
-application in 2).  [Of course, this step may be carried out automatically
+application in 2) (of course, this step may be carried out automatically
 by the same application that determies the swap file's header offset using the
-FIBMAP ioctl.]
+FIBMAP ioctl)
+
+OR
+
+Use a userland suspend application that will set the partition and offset
+with the help of the SNAPSHOT_SET_SWAP_AREA ioctl described in
+Documentation/power/userland-swsusp.txt (this is the only method to suspend
+to a swap file allowing the resume to be initiated from an initrd or initramfs
+image).
 
 Now, swsusp will use the swap file in the same way in which it would use a swap
-partition.  [Of course this means that the resume from a swap file cannot be
-initiated from whithin an initrd of initramfs image.]  In particular, the
-swap file has to be active (ie. be present in /proc/swaps) so that it can be
-used for suspending.
+partition.  In particular, the swap file has to be active (ie. be present in
+/proc/swaps) so that it can be used for suspending.
 
 Note that if the swap file used for suspending is deleted and recreated,
 the location of its header need not be the same as before.  Thus every time

