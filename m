Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbULFXUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbULFXUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbULFXTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:19:34 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:51926 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261494AbULFXPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:15:37 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041205211823.GD1012@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine>
	 <20041205211823.GD1012@elf.ucw.cz>
Date: Mon, 06 Dec 2004 23:15:24 +0000
Message-Id: <1102374924.13483.9.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, how does this one look? (applies on top of the __init patch from
last time)

resume_device has been renamed to swsusp_resume_device to avoid
confusion with the resume_device function in drivers/power. If a resume
device has been set, it's assumed that userspace has been started. If
not, it behaves as before. name_to_dev_t is only called if userspace
hasn't been started - otherwise, we depend on the values provided by
userspace being correct. If userspace has been started, we freeze tasks
and free memory before starting the resume. If this looks ok, I'll merge
it to your changes after 2.6.10.


diff -ur kernel.bak/power/disk.c kernel/power/disk.c
--- kernel.bak/power/disk.c	2004-12-05 16:11:19.000000000 +0000
+++ kernel/power/disk.c	2004-12-06 22:29:34.000000000 +0000
@@ -1,3 +1,4 @@
+
 /*
  * kernel/power/disk.c - Suspend-to-disk support.
  *
@@ -28,7 +29,7 @@
 extern int swsusp_read(void);
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
-
+extern dev_t swsusp_resume_device;
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -223,6 +224,18 @@
 
 	pr_debug("PM: Reading pmdisk image.\n");
 
+	if (swsusp_resume_device) {
+		/* We want to be really sure that userspace isn't touching
+		   anything at this point... */
+		if (freeze_processes()) {
+			goto Done;
+		}
+		
+		/* And then make sure that we have enough memory to do the
+		   resume */
+		free_some_memory();
+	}
+
 	if ((error = swsusp_read()))
 		goto Done;
 
@@ -327,8 +340,42 @@
 
 power_attr(disk);
 
+static ssize_t resume_show(struct subsystem * subsys, char * buf) {
+        return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
+                       MINOR(swsusp_resume_device));
+}
+
+static ssize_t resume_store(struct subsystem * s, const char * buf, size_t n)
+{
+        int error = 0;
+        int len;
+        char *p;
+        unsigned maj, min;
+        dev_t (res);
+
+        p = memchr(buf, '\n', n);
+        len = p ? p - buf : n;
+
+        if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
+                res = MKDEV(maj, min);
+                if (maj == MAJOR(res) && min == MINOR(res)) {
+                        swsusp_resume_device = res;
+                        error = software_resume();
+                } else {
+                        error = -EINVAL;
+                }
+        } else {
+                error = -EINVAL;
+        }
+
+        return error ? error : n;
+}
+
+power_attr(resume);
+
 static struct attribute * g[] = {
 	&disk_attr.attr,
+	&resume_attr.attr,
 	NULL,
 };
 
diff -ur kernel.bak/power/swsusp.c kernel/power/swsusp.c
--- kernel.bak/power/swsusp.c	2004-12-05 18:31:40.000000000 +0000
+++ kernel/power/swsusp.c	2004-12-06 23:02:21.000000000 +0000
@@ -81,7 +81,7 @@
 int nr_copy_pages_check;
 
 extern char resume_file[];
-static dev_t resume_device;
+dev_t swsusp_resume_device = 0;
 /* Local variables that should not be affected by save */
 unsigned int nr_copy_pages __nosavedata = 0;
 
@@ -171,7 +171,7 @@
 	struct inode *inode = file->f_dentry->d_inode;
 
 	return S_ISBLK(inode->i_mode) &&
-		resume_device == MKDEV(imajor(inode), iminor(inode));
+		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
 }
 
 int swsusp_swap_check(void) /* This is called before saving image */
@@ -740,7 +740,7 @@
  *	space avaiable.
  *
  *	FIXME: si_swapinfo(&i) returns all swap devices information.
- *	We should only consider resume_device. 
+ *	We should only consider swsusp_resume_device. 
  */
 
 static int enough_swap(void)
@@ -1220,13 +1220,16 @@
 {
 	int error;
 
-	if (!strlen(resume_file))
-		return -ENOENT;
+	if (!swsusp_resume_device) {
+		if (!strlen(resume_file))
+			return -ENOENT;
 
-	resume_device = name_to_dev_t(resume_file);
-	pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
+		swsusp_resume_device = name_to_dev_t(resume_file);
+		pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
+	}
+	
+	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 
-	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		error = read_suspend_image();

-- 
Matthew Garrett | mjg59@srcf.ucam.org

