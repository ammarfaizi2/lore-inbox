Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVDJXPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVDJXPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVDJXPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:15:50 -0400
Received: from harlech.math.ucla.edu ([128.97.4.250]:1153 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261636AbVDJXO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:14:57 -0400
Date: Sun, 10 Apr 2005 16:14:52 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <Pine.LNX.4.61.0504101612240.10130@xena.cft.ca.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Pavel Machek wrote: 
> You do not want to mount journaling filesystems; they tend to write to
> disks even during read-only mounts... But doing it from initrd should
> be okay. ext2 and init=/bin/bash should do the trick, too.

I did give it a try -- successfully.  

For reference I recite the original issue: the driver for my primary
disc is in the initrd, not hardwired.  (It's ata_piix and friends, but
the same issue happens if you boot from RAID or other weird devices.  As
modern systems tend to have a SATA disc, more and more people are
complaining on the web that software suspend has stopped working after
they upgraded their machines.)  software_suspend would suspend all the
way, then immediately wake up having accomplished nothing (but broken
nothing either).  In kernel 2.6.12-rc1 but not 2.6.8 it complains "can't
find swap device".  If this safety check is unwisely overriden so a
suspend image is written, and you then resume (providing the device by
number), it fails to read the image using the driver which it hasn't
loaded yet.

This patch makes software_resume not a late_initcall but rather an
external subroutine similar to software_suspend, and calls it at the
beginning of mount_root (in init/do_mounts.c), just _after_ the initrd
(if any) and its driver have been seen.  This buried placement is needed
because there are several flow paths that call mount_root, and otherwise
each path would need to be monkeyed with.

The initrd contents at the time of resuming are lost, but the initrd
contents at initial boot, if mounted at that time on /initrd, are still
there.

I have been running with this patch for over a week, with several
suspends per day (and much more than the usual number of reboots, due to
driver debugging).  I have had only two system crashes in that time.  In
one, I was trying code in ata_piix connected with ATAPI DMA that was
wrong for my kernel version, and it hung in driver initialization before
software_resume was even called.  In the other, I was trying the CVS
version of X-Windows, specifically DRI.  The rough edges showed clearly,
and I suspect it stored corrupt data somewhere.  After reverting to the
production X-Windows I suspended, and I got a null pointer dereference
upon resuming.  I suspect (but can't prove) that module reinit would
have failed exactly the same way with the original or patched calls to
software_resume.  In other words, I think the patched version is doing
its part of the job perfectly.

So, what do you think?  Can we bring the benefit of software suspend to
systems with SATA or RAID boot discs?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)


Patch relative to 2.6.12-rc1

--- init/do_mounts.c.orig	2005-03-17 17:34:09.000000000 -0800
+++ init/do_mounts.c	2005-04-01 19:29:23.000000000 -0800
@@ -362,6 +362,16 @@
 
 void __init mount_root(void)
 {
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	/*
+	 * Must resume after initrd has loaded the device for the root filesys,
+	 * presumed same as the one with the swap partition with the resume
+	 * image, but before mounting anything, which resuming would smear.
+	 */
+	software_resume();
+#endif
 #ifdef CONFIG_ROOT_NFS
 	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
 		if (mount_nfs_root())
--- include/linux/suspend.h.orig	2005-03-17 17:34:07.000000000 -0800
+++ include/linux/suspend.h	2005-04-01 19:39:35.000000000 -0800
@@ -48,6 +48,7 @@
 #ifdef CONFIG_PM
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
+extern int software_resume(void);
 
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
@@ -58,6 +59,10 @@
 	printk("Warning: fake suspend called\n");
 	return -EPERM;
 }
+static inline int software_resume(void)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SMP
--- kernel/power/disk.c.orig	2005-03-26 14:16:25.000000000 -0800
+++ kernel/power/disk.c	2005-04-01 21:14:01.029535791 -0800
@@ -229,7 +229,7 @@
  *
  */
 
-static int software_resume(void)
+int software_resume(void)
 {
 	int error;
 
@@ -243,12 +243,15 @@
 
 	pr_debug("PM: Checking swsusp image.\n");
 
-	if ((error = swsusp_check()))
+	if ((error = swsusp_check())) {
+		pr_debug("PM: No swsusp image, skipping.\n");
 		goto Done;
+	}
 
 	pr_debug("PM: Preparing processes for restore.\n");
 
 	if ((error = prepare_processes())) {
+		pr_debug("PM: Problem preparing processes, not restoring.\n");
 		swsusp_close();
 		goto Cleanup;
 	}
@@ -278,8 +281,6 @@
 	return 0;
 }
 
-late_initcall(software_resume);
-
 
 static char * pm_disk_modes[] = {
 	[PM_DISK_FIRMWARE]	= "firmware",
