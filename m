Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUCNPTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 10:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbUCNPTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 10:19:52 -0500
Received: from main.gmane.org ([80.91.224.249]:59580 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261984AbUCNPTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 10:19:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: pmdisk suspend patch
Date: Sun, 14 Mar 2004 10:19:23 -0500
Message-ID: <c31t68$f99$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2504207.ngu68RG2br"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18bac38d.dyn.optonline.net
User-Agent: KNode/0.7.7
Cc: swsusp-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2504207.ngu68RG2br
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit

Hello

I have been trying to get a reliable way to suspend-to-disk. For me
swsusp was taking more than a few minutes and swsusp2 was not
reliable. So I decided to give pmdisk a chance. Since my laptop
supported S4bios, pmdisk wouldn't let me change it to S4 platform
based suspend. Even after fixing it, I didn't have much luck. I dug
deeper and found another problem. pmdisk resumes all devices while
suspending. So I patched the pmdisk to resume only the device on which
suspend image is to be stored. With these patches, I have been able to
use pmdisk reliably (tested with two laptops over 100 times).

I am not subscribed to the mailing list, so if you have problems or
feedback, CC to me.

diff -Nur linux-2.6.4.orig/kernel/power/disk.c
linux-2.6.4/kernel/power/disk.c
--- linux-2.6.4.orig/kernel/power/disk.c        2004-03-13 10:38:32.000000000 -0500
+++ linux-2.6.4/kernel/power/disk.c     2004-03-14 01:27:33.000000000 -0500
@@ -280,14 +280,13 @@
        return sprintf(buf,"%s\n",pm_disk_modes[pm_disk_mode]);
 }
 
-
+extern int acpi_pm_disk_mode(int);
 static ssize_t disk_store(struct subsystem * s, const char * buf, size_t n)
 {
        int error = 0;
        int i;
        u32 mode = 0;
 
-       down(&pm_sem);
        for (i = PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
                if (!strcmp(buf,pm_disk_modes[i])) {
                        mode = i;
@@ -295,21 +294,18 @@
                }
        }
        if (mode) {
-               if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT)
+               if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT ||
+                               !acpi_pm_disk_mode(mode)) {
+                       down(&pm_sem);
                        pm_disk_mode = mode;
-               else {
-                       if (pm_ops && pm_ops->enter &&
-                           (mode == pm_ops->pm_disk_mode))
-                               pm_disk_mode = mode;
-                       else
-                               error = -EINVAL;
-               }
+                       up(&pm_sem);
+               } else
+                       error = -EINVAL;
        } else
                error = -EINVAL;
 
        pr_debug("PM: suspend-to-disk mode set to '%s'\n",
                 pm_disk_modes[mode]);
-       up(&pm_sem);
        return error ? error : n;
 }
 
diff -Nur linux-2.6.4.orig/kernel/power/pmdisk.c
linux-2.6.4/kernel/power/pmdisk.c
--- linux-2.6.4.orig/kernel/power/pmdisk.c      2004-03-13 10:38:32.000000000
-0500
+++ linux-2.6.4/kernel/power/pmdisk.c   2004-03-14 01:34:07.000000000 -0500
@@ -20,6 +20,7 @@
 
 #undef DEBUG
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/bio.h>
 #include <linux/suspend.h>
@@ -29,6 +30,7 @@
 #include <linux/swapops.h>
 #include <linux/bootmem.h>
 #include <linux/utsname.h>
+#include <linux/ide.h>
 
 #include <asm/mmu_context.h>
 
@@ -53,7 +55,7 @@
 /* For resume= kernel option */
 static char resume_file[256] = CONFIG_PM_DISK_PARTITION;
 
-static dev_t resume_device;
+static dev_t resume_dev;
 /* Local variables that should not be affected by save */
 unsigned int pmdisk_pages __nosavedata = 0;
 
@@ -158,7 +160,7 @@
                        } else {
                                /* we ignore all swap devices that are not the resume_file */
                                if (1) {
-// FIXME                               if(resume_device == swap_info[i].swap_device) {
+// FIXME                               if(resume_dev == swap_info[i].swap_device) {
                                        swapfile_used[i] = SWAPFILE_SUSPEND;
                                        root_swap = i;
                                } else
@@ -578,8 +580,8 @@
 static int enough_free_mem(void)
 {
        if(nr_free_pages() < (pmdisk_pages + PAGES_FOR_IO)) {
-               pr_debug("pmdisk: Not enough free pages: Have %d\n",
-                        nr_free_pages());
+               pr_debug("Not enough free pages: need %d, have %d\n",
+                        pmdisk_pages + PAGES_FOR_IO, nr_free_pages());
                return 0;
        }
        return 1;
@@ -593,7 +595,7 @@
  *     space avaiable.
  *
  *     FIXME: si_swapinfo(&i) returns all swap devices information.
- *     We should only consider resume_device. 
+ *     We should only consider resume_dev. 
  */
 
 static int enough_swap(void)
@@ -689,10 +691,24 @@
  *     correctly, we'll mark system clean, anyway.)
  */
 
+extern int resume_device(struct device *);
 static int suspend_save_image(void)
 {
        int error;
-       device_resume();
+       struct block_device *bdev;
+       struct device *dev;
+
+       /* resume the device on which suspend image is stored */
+       bdev = lookup_bdev(resume_file);
+       if (!bdev)
+               return -EINVAL;
+       dev = bdev->bd_disk->driverfs_dev;
+       if (!dev)
+               return -EINVAL;
+
+       error = resume_device(dev);
+       if (error)
+               return -EINVAL;
        lock_swapdevices();
        error = write_suspend_image();
        lock_swapdevices();
@@ -1118,10 +1134,10 @@
        if (!strlen(resume_file))
                return -ENOENT;
 
-       resume_device = name_to_dev_t(resume_file);
+       resume_dev = name_to_dev_t(resume_file);
        pr_debug("pmdisk: Resume From Partition: %s\n", resume_file);
 
-       resume_bdev = open_by_devnum(resume_device, FMODE_READ);
+       resume_bdev = open_by_devnum(resume_dev, FMODE_READ);
        if (!IS_ERR(resume_bdev)) {
                set_blocksize(resume_bdev, PAGE_SIZE);
                error = read_suspend_image();
diff -Nur linux-2.6.4.orig/drivers/acpi/sleep/main.c
linux-2.6.4/drivers/acpi/sleep/main.c
--- linux-2.6.4.orig/drivers/acpi/sleep/main.c  2004-01-09 01:59:04.000000000
-0500
+++ linux-2.6.4/drivers/acpi/sleep/main.c       2004-03-14 01:46:42.000000000
-0500
@@ -166,6 +166,22 @@
        .finish         = acpi_pm_finish,
 };
 
+int acpi_pm_disk_mode(int mode)
+{
+
+       if (sleep_states[ACPI_STATE_S4])
+               if (mode == PM_DISK_PLATFORM ||
+                       (mode == PM_DISK_FIRMWARE && acpi_gbl_FACS->S4bios_f)) {
+                       acpi_pm_ops.pm_disk_mode = mode;
+                       pm_set_ops(&acpi_pm_ops);
+                       return 0;
+               }
+               else
+                       return -EINVAL;
+       else
+               return -EINVAL;
+}
+
 static int __init acpi_sleep_init(void)
 {
        int                     i = 0;


--nextPart2504207.ngu68RG2br
Content-Type: text/x-diff; name="pmdisk_patch"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="pmdisk_patch"

diff -Nur linux-2.6.4.orig/kernel/power/disk.c linux-2.6.4/kernel/power/disk.c
--- linux-2.6.4.orig/kernel/power/disk.c	2004-03-13 10:38:32.000000000 -0500
+++ linux-2.6.4/kernel/power/disk.c	2004-03-14 01:27:33.000000000 -0500
@@ -280,14 +280,13 @@
 	return sprintf(buf,"%s\n",pm_disk_modes[pm_disk_mode]);
 }
 
-
+extern int acpi_pm_disk_mode(int);
 static ssize_t disk_store(struct subsystem * s, const char * buf, size_t n)
 {
 	int error = 0;
 	int i;
 	u32 mode = 0;
 
-	down(&pm_sem);
 	for (i = PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
 		if (!strcmp(buf,pm_disk_modes[i])) {
 			mode = i;
@@ -295,21 +294,18 @@
 		}
 	}
 	if (mode) {
-		if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT)
+		if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT ||
+				!acpi_pm_disk_mode(mode)) {
+			down(&pm_sem);
 			pm_disk_mode = mode;
-		else {
-			if (pm_ops && pm_ops->enter &&
-			    (mode == pm_ops->pm_disk_mode))
-				pm_disk_mode = mode;
-			else
-				error = -EINVAL;
-		}
+			up(&pm_sem);
+		} else
+			error = -EINVAL;
 	} else
 		error = -EINVAL;
 
 	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
 		 pm_disk_modes[mode]);
-	up(&pm_sem);
 	return error ? error : n;
 }
 
diff -Nur linux-2.6.4.orig/kernel/power/pmdisk.c linux-2.6.4/kernel/power/pmdisk.c
--- linux-2.6.4.orig/kernel/power/pmdisk.c	2004-03-13 10:38:32.000000000 -0500
+++ linux-2.6.4/kernel/power/pmdisk.c	2004-03-14 01:34:07.000000000 -0500
@@ -20,6 +20,7 @@
 
 #undef DEBUG
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/bio.h>
 #include <linux/suspend.h>
@@ -29,6 +30,7 @@
 #include <linux/swapops.h>
 #include <linux/bootmem.h>
 #include <linux/utsname.h>
+#include <linux/ide.h>
 
 #include <asm/mmu_context.h>
 
@@ -53,7 +55,7 @@
 /* For resume= kernel option */
 static char resume_file[256] = CONFIG_PM_DISK_PARTITION;
 
-static dev_t resume_device;
+static dev_t resume_dev;
 /* Local variables that should not be affected by save */
 unsigned int pmdisk_pages __nosavedata = 0;
 
@@ -158,7 +160,7 @@
 			} else {
 	  			/* we ignore all swap devices that are not the resume_file */
 				if (1) {
-// FIXME				if(resume_device == swap_info[i].swap_device) {
+// FIXME				if(resume_dev == swap_info[i].swap_device) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
 				} else
@@ -578,8 +580,8 @@
 static int enough_free_mem(void)
 {
 	if(nr_free_pages() < (pmdisk_pages + PAGES_FOR_IO)) {
-		pr_debug("pmdisk: Not enough free pages: Have %d\n",
-			 nr_free_pages());
+		pr_debug("Not enough free pages: need %d, have %d\n",
+			 pmdisk_pages + PAGES_FOR_IO, nr_free_pages());
 		return 0;
 	}
 	return 1;
@@ -593,7 +595,7 @@
  *	space avaiable.
  *
  *	FIXME: si_swapinfo(&i) returns all swap devices information.
- *	We should only consider resume_device. 
+ *	We should only consider resume_dev. 
  */
 
 static int enough_swap(void)
@@ -689,10 +691,24 @@
  *	correctly, we'll mark system clean, anyway.)
  */
 
+extern int resume_device(struct device *);
 static int suspend_save_image(void)
 {
 	int error;
-	device_resume();
+	struct block_device *bdev;
+	struct device *dev;
+
+	/* resume the device on which suspend image is stored */
+	bdev = lookup_bdev(resume_file);
+	if (!bdev)
+		return -EINVAL;
+	dev = bdev->bd_disk->driverfs_dev;
+	if (!dev)
+		return -EINVAL;
+
+	error = resume_device(dev);
+	if (error)
+		return -EINVAL;
 	lock_swapdevices();
 	error = write_suspend_image();
 	lock_swapdevices();
@@ -1118,10 +1134,10 @@
 	if (!strlen(resume_file))
 		return -ENOENT;
 
-	resume_device = name_to_dev_t(resume_file);
+	resume_dev = name_to_dev_t(resume_file);
 	pr_debug("pmdisk: Resume From Partition: %s\n", resume_file);
 
-	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
+	resume_bdev = open_by_devnum(resume_dev, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		error = read_suspend_image();
diff -Nur linux-2.6.4.orig/drivers/acpi/sleep/main.c linux-2.6.4/drivers/acpi/sleep/main.c
--- linux-2.6.4.orig/drivers/acpi/sleep/main.c	2004-01-09 01:59:04.000000000 -0500
+++ linux-2.6.4/drivers/acpi/sleep/main.c	2004-03-14 01:46:42.000000000 -0500
@@ -166,6 +166,22 @@
 	.finish		= acpi_pm_finish,
 };
 
+int acpi_pm_disk_mode(int mode)
+{
+
+	if (sleep_states[ACPI_STATE_S4])
+		if (mode == PM_DISK_PLATFORM ||
+			(mode == PM_DISK_FIRMWARE && acpi_gbl_FACS->S4bios_f)) {
+			acpi_pm_ops.pm_disk_mode = mode;
+			pm_set_ops(&acpi_pm_ops);
+			return 0;
+		}
+		else
+			return -EINVAL;
+	else
+		return -EINVAL;
+}
+
 static int __init acpi_sleep_init(void)
 {
 	int			i = 0;

--nextPart2504207.ngu68RG2br--

