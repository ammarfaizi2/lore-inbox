Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbULEUsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbULEUsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbULEUsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:48:47 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:41416 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261386AbULEUsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:48:24 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, pavel@suse.cz
Date: Sun, 05 Dec 2004 20:48:06 +0000
Message-Id: <1102279686.9384.22.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: [PATCH/RFC] Add support to resume swsusp from initrd
Content-Type: multipart/mixed; boundary="=-03G3FPxDNQS9uGkM72ds"
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-03G3FPxDNQS9uGkM72ds
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

These two patches do two things:

1) The first removes __init declarations from swsusp code
2) The second allows for the resume device to be set from userspace (ie,
without having to use name_to_dev_t) and also allows for resumes to be
triggered from userspace.

A /sys/power/resume file is added. Doing

echo -n "set 03:02" >/sys/power/resume

will set /dev/hda2 as the resume device. 

echo -n "resume 03:02" >/sys/power/resume

will attempt a resume from /dev/hda2. Patches are against 2.6.10-rc3.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

--=-03G3FPxDNQS9uGkM72ds
Content-Disposition: attachment; filename=__init.diff
Content-Type: text/x-patch; name=__init.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ur ../../../kernel/power/swsusp.c kernel/power/swsusp.c
--- ../../../kernel/power/swsusp.c	2004-12-05 16:11:19.000000000 +0000
+++ kernel/power/swsusp.c	2004-12-05 18:31:40.000000000 +0000
@@ -907,7 +907,7 @@
 /*
  * Returns true if given address/order collides with any orig_address 
  */
-static int __init does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
+static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
 		int order)
 {
 	int i;
@@ -925,7 +925,7 @@
  * We check here that pagedir & pages it points to won't collide with pages
  * where we're going to restore from the loaded pages later
  */
-static int __init check_pagedir(void)
+static int check_pagedir(void)
 {
 	int i;
 
@@ -943,7 +943,7 @@
 	return 0;
 }
 
-static int __init swsusp_pagedir_relocate(void)
+static int swsusp_pagedir_relocate(void)
 {
 	/*
 	 * We have to avoid recursion (not to overflow kernel stack),
@@ -1075,7 +1075,7 @@
  * I really don't think that it's foolproof but more than nothing..
  */
 
-static const char * __init sanity_check(void)
+static const char * sanity_check(void)
 {
 	dump_info();
 	if(swsusp_info.version_code != LINUX_VERSION_CODE)
@@ -1096,7 +1096,7 @@
 }
 
 
-static int __init check_header(void)
+static int check_header(void)
 {
 	const char * reason = NULL;
 	int error;
@@ -1113,7 +1113,7 @@
 	return error;
 }
 
-static int __init check_sig(void)
+static int check_sig(void)
 {
 	int error;
 
@@ -1143,7 +1143,7 @@
  *	already did that.
  */
 
-static int __init data_read(void)
+static int data_read(void)
 {
 	struct pbe * p;
 	int error;
@@ -1170,7 +1170,7 @@
 
 extern dev_t __init name_to_dev_t(const char *line);
 
-static int __init read_pagedir(void)
+static int read_pagedir(void)
 {
 	unsigned long addr;
 	int i, n = swsusp_info.pagedir_pages;
@@ -1197,7 +1197,7 @@
 	return error;
 }
 
-static int __init read_suspend_image(void)
+static int read_suspend_image(void)
 {
 	int error = 0;
 
@@ -1216,7 +1216,7 @@
  *	pmdisk_read - Read saved image from swap.
  */
 
-int __init swsusp_read(void)
+int swsusp_read(void)
 {
 	int error;
 

--=-03G3FPxDNQS9uGkM72ds
Content-Disposition: attachment; filename=swsusp_initrd.diff
Content-Type: text/x-patch; name=swsusp_initrd.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ur kernel.bak/power/disk.c kernel/power/disk.c
--- kernel.bak/power/disk.c	2004-12-05 16:11:19.000000000 +0000
+++ kernel/power/disk.c	2004-12-05 20:28:32.000000000 +0000
@@ -26,9 +26,10 @@
 extern int swsusp_suspend(void);
 extern int swsusp_write(void);
 extern int swsusp_read(void);
+extern int swsusp_read_from(dev_t resume_device);
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
-
+extern void swsusp_set_resume_device(dev_t resume_device);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -198,18 +199,15 @@
 
 
 /**
- *	software_resume - Resume from a saved image.
+ *	software_resume_from - Do the actual grunt work of resume
  *
- *	Called as a late_initcall (so all devices are discovered and
- *	initialized), we call pmdisk to see if we have a saved image or not.
+ *      We call pmdisk to see if we have a saved image or not.
  *	If so, we quiesce devices, the restore the saved image. We will
  *	return above (in pm_suspend_disk() ) if everything goes well.
- *	Otherwise, we fail gracefully and return to the normally
- *	scheduled program.
  *
  */
 
-static int software_resume(void)
+static int software_resume_from(dev_t resume_device)
 {
 	int error;
 
@@ -223,9 +221,13 @@
 
 	pr_debug("PM: Reading pmdisk image.\n");
 
-	if ((error = swsusp_read()))
-		goto Done;
-
+	if (resume_device) {
+		if ((error = swsusp_read_from(resume_device)))
+			goto Done;
+	} else {
+		if ((error = swsusp_read()))
+			goto Done;
+	}
 	pr_debug("PM: Preparing system for restore.\n");
 
 	if ((error = prepare()))
@@ -245,6 +247,23 @@
 	return 0;
 }
 
+/**
+ *	software_resume - Resume from a saved image.
+ *
+ *	Called as a late_initcall (so all devices are discovered and
+ *	initialized), we simply trigger software_resume_from without
+ *      giving it an explicit resume device. This will then allow
+ *      swsusp to parse the resume argument passed to the kernel. With
+ *      luck, we end up in pm_suspend_disk(). Otherwise, we fail gracefully 
+ *      and return to the normally scheduled program.
+ *
+ */
+
+static int software_resume(void)
+{
+	return software_resume_from(0);
+}
+
 late_initcall(software_resume);
 
 
@@ -327,17 +346,54 @@
 
 power_attr(disk);
 
+static ssize_t resume_show(struct subsystem * subsys, char * buf) {
+	return sprintf(buf,"set resume\n");
+}
+
+static ssize_t resume_store(struct subsystem * s, const char * buf, size_t n)
+{
+	int error = 0;
+	int len;
+	char *p;
+	unsigned maj, min;
+	dev_t (res);
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf : n;
+
+	if (sscanf(buf, "resume %u:%u", &maj, &min) == 2) {          
+		res = MKDEV(maj, min);
+		if (maj == MAJOR(res) && min == MINOR(res)) {
+			error = software_resume_from(res);
+		} else {
+			error = EINVAL;
+		}
+	} else if (sscanf(buf, "set %u:%u", &maj, &min) == 2) {
+		res = MKDEV(maj, min);
+		if (maj == MAJOR(res) && min == MINOR(res)) {
+			swsusp_set_resume_device(res);
+		} else {
+			error = EINVAL;
+		}
+	} else {
+		error = EINVAL;
+	}
+	
+	return error ? error : n;
+}
+
+power_attr(resume);
+
 static struct attribute * g[] = {
 	&disk_attr.attr,
+	&resume_attr.attr,
 	NULL,
 };
 
-
 static struct attribute_group attr_group = {
-	.attrs = g,
+        .attrs = g,
 };
 
-
 static int __init pm_disk_init(void)
 {
 	return sysfs_create_group(&power_subsys.kset.kobj,&attr_group);
diff -ur kernel.bak/power/swsusp.c kernel/power/swsusp.c
--- kernel.bak/power/swsusp.c	2004-12-05 18:31:40.000000000 +0000
+++ kernel/power/swsusp.c	2004-12-05 20:30:02.000000000 +0000
@@ -174,6 +174,11 @@
 		resume_device == MKDEV(imajor(inode), iminor(inode));
 }
 
+void swsusp_set_resume_device(dev_t device)
+{
+	resume_device = device;
+}
+
 int swsusp_swap_check(void) /* This is called before saving image */
 {
 	int i, len;
@@ -1216,16 +1221,10 @@
  *	pmdisk_read - Read saved image from swap.
  */
 
-int swsusp_read(void)
+int swsusp_read_from(dev_t resume_device)
 {
 	int error;
 
-	if (!strlen(resume_file))
-		return -ENOENT;
-
-	resume_device = name_to_dev_t(resume_file);
-	pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
-
 	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
@@ -1240,3 +1239,14 @@
 		pr_debug("pmdisk: Error %d resuming\n", error);
 	return error;
 }
+
+int swsusp_read(void)
+{
+	if (!strlen(resume_file))
+		return -ENOENT;
+
+	resume_device = name_to_dev_t(resume_file);
+	pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
+	return swsusp_read_from(resume_device);
+}
+

--=-03G3FPxDNQS9uGkM72ds--

