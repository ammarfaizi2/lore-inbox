Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbULEVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbULEVSr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbULEVSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:18:47 -0500
Received: from gprs215-105.eurotel.cz ([160.218.215.105]:28032 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261396AbULEVSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:18:39 -0500
Date: Sun, 5 Dec 2004 22:18:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Message-ID: <20041205211823.GD1012@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102279686.9384.22.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> These two patches do two things:

(ahha, you attached instead of inlining, that's why it is hard to
quote it...)

> 1) The first removes __init declarations from swsusp code

That one looks okay.

> 2) The second allows for the resume device to be set from userspace (ie,
> without having to use name_to_dev_t) and also allows for resumes to be
> triggered from userspace.

Ouch, as for "loose your data". Properly stopping drivers before final
data are copied has just become way more critical. You may want to
check that the code does the right thing...

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

Can't you just store resume_device into the global variable and be
done with that?


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
 

I'd do software_resume_from(resume_device), meaning less ugly ifs, but
just writing is probably even easier...


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

Error should be -EINVAL.

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

Please just export it.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
