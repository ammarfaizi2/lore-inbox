Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVCIXK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVCIXK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVCIXHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:07:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13014 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261390AbVCIW0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:26:32 -0500
Date: Wed, 9 Mar 2005 23:25:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, hare@suse.de
Subject: 3/3 swsusp: enable resume from initrd
Message-ID: <20050309222507.GJ17034@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

From: mjg59@scrf.ucam.org

When using a fully modularized kernel it is necessary to activate
resume manually as the device node might not be available during
kernel init.

This patch implements a new sysfs attribute '/sys/power/resume' which
allows for manual activation of software resume.  When read from it
prints the configured resume device in 'major:minor' format.  When
written to it expects a device in 'major:minor' format.  This device
is then checked for a suspended image and resume is started if a valid
image is found.  The original functionality is left in place.

It should be used from initramfs, or with care.

Please apply,
								Pavel
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux.middle/include/linux/suspend.h	2005-02-14 14:14:21.000000000 +0100
+++ linux/include/linux/suspend.h	2005-03-03 13:23:17.000000000 +0100
@@ -35,6 +35,8 @@
 
 
 #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+
+extern dev_t swsusp_resume_device;
    
 /* mm/vmscan.c */
 extern int shrink_mem(void);
--- linux.middle/init/do_mounts.c	2005-02-03 22:28:15.000000000 +0100
+++ linux/init/do_mounts.c	2005-03-03 13:23:17.000000000 +0100
@@ -53,7 +53,7 @@
 __setup("ro", readonly);
 __setup("rw", readwrite);
 
-static dev_t __init try_name(char *name, int part)
+static dev_t try_name(char *name, int part)
 {
 	char path[64];
 	char buf[32];
@@ -135,7 +135,7 @@
  *	is mounted on rootfs /sys.
  */
 
-dev_t __init name_to_dev_t(char *name)
+dev_t name_to_dev_t(char *name)
 {
 	char s[32];
 	char *p;
--- linux.middle/kernel/power/disk.c	2005-03-02 00:22:49.000000000 +0100
+++ linux/kernel/power/disk.c	2005-03-04 10:15:46.000000000 +0100
@@ -16,7 +18,6 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
-#include <linux/device.h>
 #include "power.h"
 
 
@@ -25,13 +26,16 @@
 
 extern int swsusp_suspend(void);
 extern int swsusp_write(void);
+extern int swsusp_check(void);
 extern int swsusp_read(void);
+extern void swsusp_close(void);
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
 
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
+dev_t swsusp_resume_device;
 
 /**
  *	power_down - Shut machine down for hibernate.
@@ -123,45 +127,54 @@
 }
 
 
-static int prepare(void)
+static int prepare_processes(void)
 {
 	int error;
 
 	pm_prepare_console();
 
 	sys_sync();
+
 	if (freeze_processes()) {
 		error = -EBUSY;
-		goto Thaw;
+		return error;
 	}
 
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
 		if (pm_ops && pm_ops->prepare) {
 			if ((error = pm_ops->prepare(PM_SUSPEND_DISK)))
-				goto Thaw;
+				return error;
 		}
 	}
 
 	/* Free memory before shutting down devices. */
 	free_some_memory();
 
+	return 0;
+}
+
+static void unprepare_processes(void)
+{
+	enable_nonboot_cpus();
+	thaw_processes();
+	pm_restore_console();
+}
+
+static int prepare_devices(void)
+{
+	int error;
+
 	disable_nonboot_cpus();
 	if ((error = device_suspend(PMSG_FREEZE))) {
 		printk("Some devices failed to suspend\n");
-		goto Finish;
+		platform_finish();
+		enable_nonboot_cpus();
+		return error;
 	}
 
 	return 0;
- Finish:
-	platform_finish();
- Thaw:
-	enable_nonboot_cpus();
-	thaw_processes();
-	pm_restore_console();
-	return error;
 }
 
-
 /**
  *	pm_suspend_disk - The granpappy of power management.
  *
@@ -175,8 +188,15 @@
 {
 	int error;
 
-	if ((error = prepare()))
+	error = prepare_processes();
+	if (!error) {
+		error = prepare_devices();
+	}
+
+	if (error) {
+		unprepare_processes();
 		return error;
+	}
 
 	pr_debug("PM: Attempting to suspend to disk.\n");
 	if (pm_disk_mode == PM_DISK_FIRMWARE)
@@ -225,14 +245,26 @@
 		return 0;
 	}
 
+	pr_debug("PM: Checking swsusp image.\n");
+
+	if ((error = swsusp_check()))
+		goto Done;
+
+	pr_debug("PM: Preparing processes for restore.\n");
+
+	if ((error = prepare_processes())) {
+		swsusp_close();
+		goto Cleanup;
+	}
+
 	pr_debug("PM: Reading swsusp image.\n");
 
 	if ((error = swsusp_read()))
-		goto Done;
+		goto Cleanup;
 
-	pr_debug("PM: Preparing system for restore.\n");
+	pr_debug("PM: Preparing devices for restore.\n");
 
-	if ((error = prepare()))
+	if ((error = prepare_devices()))
 		goto Free;
 
 	barrier();
@@ -244,6 +276,8 @@
 	finish();
  Free:
 	swsusp_free();
+ Cleanup:
+	unprepare_processes();
  Done:
 	pr_debug("PM: Resume from disk failed.\n");
 	return 0;
@@ -331,8 +365,41 @@
 
 power_attr(disk);
 
+static ssize_t resume_show(struct subsystem * subsys, char *buf)
+{
+	return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
+		       MINOR(swsusp_resume_device));
+}
+
+static ssize_t resume_store(struct subsystem * subsys, const char * buf, size_t n)
+{
+	int len;
+	char *p;
+	unsigned int maj, min;
+	int error = -EINVAL;
+	dev_t res;
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf : n;
+
+	if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
+		res = MKDEV(maj,min);
+		if (maj == MAJOR(res) && min == MINOR(res)) {
+			swsusp_resume_device = res;
+			printk("Attempting manual resume\n");
+			noresume = 0;
+			software_resume();
+		}
+	}
+
+	return error >= 0 ? n : error;
+}
+
+power_attr(resume);
+
 static struct attribute * g[] = {
 	&disk_attr.attr,
+	&resume_attr.attr,
 	NULL,
 };
 
--- linux.middle/kernel/power/swsusp.c	2005-02-28 21:29:06.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-03-03 13:35:52.000000000 +0100
@@ -79,7 +79,7 @@
 static int nr_copy_pages_check;
 
 extern char resume_file[];
-static dev_t resume_device;
+
 /* Local variables that should not be affected by save */
 unsigned int nr_copy_pages __nosavedata = 0;
 
@@ -169,7 +169,7 @@
 	struct inode *inode = file->f_dentry->d_inode;
 
 	return S_ISBLK(inode->i_mode) &&
-		resume_device == MKDEV(imajor(inode), iminor(inode));
+		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
 }
 
 static int swsusp_swap_check(void) /* This is called before saving image */
@@ -942,7 +942,7 @@
 /*
  * Returns true if given address/order collides with any orig_address 
  */
-static int __init does_collide_order(unsigned long addr, int order)
+static int does_collide_order(unsigned long addr, int order)
 {
 	int i;
 	
@@ -975,7 +975,7 @@
 	*eaten_memory = c;
 }
 
-static unsigned long __init get_usable_page(unsigned gfp_mask)
+static unsigned long get_usable_page(unsigned gfp_mask)
 {
 	unsigned long m;
 
@@ -989,7 +989,7 @@
 	return m;
 }
 
-static void __init free_eaten_memory(void)
+static void free_eaten_memory(void)
 {
 	unsigned long m;
 	void **c;
@@ -1012,7 +1012,7 @@
  *	pages later
  */
 
-static int __init check_pagedir(struct pbe *pblist)
+static int check_pagedir(struct pbe *pblist)
 {
 	struct pbe *p;
 
@@ -1036,7 +1036,7 @@
  *	restore from the loaded pages later.  We relocate them here.
  */
 
-static struct pbe * __init swsusp_pagedir_relocate(struct pbe *pblist)
+static struct pbe * swsusp_pagedir_relocate(struct pbe *pblist)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
@@ -1185,7 +1185,7 @@
  * I really don't think that it's foolproof but more than nothing..
  */
 
-static const char * __init sanity_check(void)
+static const char * sanity_check(void)
 {
 	dump_info();
 	if(swsusp_info.version_code != LINUX_VERSION_CODE)
@@ -1206,7 +1206,7 @@
 }
 
 
-static int __init check_header(void)
+static int check_header(void)
 {
 	const char * reason = NULL;
 	int error;
@@ -1224,7 +1224,7 @@
 	return error;
 }
 
-static int __init check_sig(void)
+static int check_sig(void)
 {
 	int error;
 
@@ -1254,7 +1254,7 @@
  *	already did that.
  */
 
-static int __init data_read(struct pbe *pblist)
+static int data_read(struct pbe *pblist)
 {
 	struct pbe * p;
 	int error = 0;
@@ -1282,13 +1282,13 @@
 	return error;
 }
 
-extern dev_t __init name_to_dev_t(const char *line);
+extern dev_t name_to_dev_t(const char *line);
 
 /**
  *	read_pagedir - Read page backup list pages from swap
  */
 
-static int __init read_pagedir(struct pbe *pblist)
+static int read_pagedir(struct pbe *pblist)
 {
 	struct pbe *pbpage, *p;
 	unsigned i = 0;
@@ -1322,10 +1322,9 @@
 }
 
 
-static int __init read_suspend_image(void)
+static int check_suspend_image(void)
 {
 	int error = 0;
-	struct pbe *p;
 
 	if ((error = check_sig()))
 		return error;
@@ -1333,6 +1332,14 @@
 	if ((error = check_header()))
 		return error;
 
+	return 0;
+}
+
+static int read_suspend_image(void)
+{
+	int error = 0;
+	struct pbe *p;
+
 	if (!(p = alloc_pagedir(nr_copy_pages)))
 		return -ENOMEM;
 
@@ -1363,30 +1370,72 @@
 }
 
 /**
- *	swsusp_read - Read saved image from swap.
+ *      swsusp_check - Check for saved image in swap
  */
 
-int __init swsusp_read(void)
+int swsusp_check(void)
 {
 	int error;
 
-	if (!strlen(resume_file))
-		return -ENOENT;
-
-	resume_device = name_to_dev_t(resume_file);
-	pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
+	if (!swsusp_resume_device) {
+		if (!strlen(resume_file))
+			return -ENOENT;
+		swsusp_resume_device = name_to_dev_t(resume_file);
+		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
+	} else {
+		pr_debug("swsusp: Resume From Partition %d:%d\n",
+			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
+	}
 
-	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
+	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
-		error = read_suspend_image();
-		blkdev_put(resume_bdev);
+		error = check_suspend_image();
+		if (error)
+		    blkdev_put(resume_bdev);
 	} else
 		error = PTR_ERR(resume_bdev);
 
 	if (!error)
-		pr_debug("Reading resume file was successful\n");
+		pr_debug("swsusp: resume file found\n");
+	else
+		pr_debug("swsusp: Error %d check for resume file\n", error);
+	return error;
+}
+
+/**
+ *	swsusp_read - Read saved image from swap.
+ */
+
+int swsusp_read(void)
+{
+	int error;
+
+	if (IS_ERR(resume_bdev)) {
+		pr_debug("swsusp: block device not initialised\n");
+		return PTR_ERR(resume_bdev);
+	}
+
+	error = read_suspend_image();
+	blkdev_put(resume_bdev);
+
+	if (!error)
+		pr_debug("swsusp: Reading resume file was successful\n");
 	else
 		pr_debug("swsusp: Error %d resuming\n", error);
 	return error;
 }
+
+/**
+ *	swsusp_close - close swap device.
+ */
+
+void swsusp_close(void)
+{
+	if (IS_ERR(resume_bdev)) {
+		pr_debug("swsusp: block device not initialised\n");
+		return;
+	}
+
+	blkdev_put(resume_bdev);
+}

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
