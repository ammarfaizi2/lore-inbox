Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVAaOL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVAaOL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVAaOL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:11:29 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:64925 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261211AbVAaOJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:09:58 -0500
Message-ID: <41FE3C34.4000200@suse.de>
Date: Mon, 31 Jan 2005 15:09:56 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mjg59@srcf.ucam.org
Subject: Re: [PATCH] Resume from initramfs
References: <41FE24F5.5070906@suse.de> <20050131125110.GD6279@elf.ucw.cz>
In-Reply-To: <20050131125110.GD6279@elf.ucw.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
[ .. ]
> 
> In priciple it looks okay, but minor details still need to be ironed
> out.
> 
> 
Cool. THX.

> At one point you did something like
> 
> 	read_data()
> 	blk_device_put()
> 
> If read_data does blk_device_get(), it should also do the put()
> itself. Otherwise some caller will forget it.
> 
Not so easy. blkdev_put() is done implicitely by open_by_devnum().
So if that fails we have to do it by hand (cf. swsusp_check()).
And I'll keep the reference to the block device open to avoid duplicate 
checking in swsusp_read(). So I'll have to close it there as the block 
device is local to swsusp.c.

But you are correct in another point, in that there is an error path 
when prepare_processes fails we have to drop the reference again.

>>--- linux-2.6.10/init/do_mounts.c.orig	2005-01-28 10:25:35.000000000 +0100
>>+++ linux-2.6.10/init/do_mounts.c	2005-01-28 10:30:43.000000000 +0100
>>@@ -135,7 +135,7 @@ fail:
>>  *	is mounted on rootfs /sys.
>>  */
>> 
>>-dev_t __init name_to_dev_t(char *name)
>>+dev_t name_to_dev_t(char *name)
>> {
>> 	char s[32];
>> 	char *p;
> 
> 
> Why do you need this one? /sys/power/resume accepts numeric values, it
> should not need to translate...
> 
swsusp_check is used by both entry points, and is itself not a init 
function.
I simply found it bad style to reference a __init function from there.
And name_to_dev_t is evil in itself. I'd gladly be rid of it if possible.

> 
>>@@ -144,7 +144,8 @@ dev_t __init name_to_dev_t(char *name)
>> 
>> #ifdef CONFIG_SYSFS
>> 	int mkdir_err = sys_mkdir("/sys", 0700);
>>-	if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
>>+	int mount_err = sys_mount("sysfs", "/sys", "sysfs", 0, NULL);
>>+	if (mount_err < 0 && mount_err != -EBUSY)
>> 		goto out;
>> #endif
>> 
> 
> 
> This is probably not acceptable. Why do you need it? It should be
> easily doable from initrd.
> 
If /sys is mounted the device lookup will fail. How sane is that?
But yes, it doesn't belong to this patch, so I'll be sending a separate 
one for it.

> 
[ .. ]
> 
> What does freeze_processes() == 1 mean and why is it suddenly ok?
> 
> 
Sorry, leftover. Cleaned up.

>>+	if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
>>+		res = MKDEV(maj,min);
>>+		if (maj == MAJOR(res) && min == MINOR(res)) {
>>+			swsusp_resume_device = res;
>>+			printk("Attempting manual resume\n");
>>+			noresume = 0;
>>+			set_current_state(TASK_STOPPED);
>>+			software_resume();
>>+			set_current_state(TASK_RUNNING);
> 
> 
> Ugh, now that is "interesting" hack. You set yourself as stopped to
> avoid refrigerator.... Is it really needed?
> 
No, again a leftover.

How about this version? Better?

Cheers,

Hannes
--
Subject: activate resume from initramfs
From: mjg59@scrf.ucam.org

When using a fully modularized kernel it is necessary to activate
resume manually as the device node might not be available during
kernel init.

This patch implements a new sysfs attribute '/sys/power/resume' which
allows for manual activation of software resume.
When read from it prints the configured resume device in 'major:minor'
format.
When written to it expects a device in 'major:minor' format.
This device is then checked for a suspended image and resume is started
if a valid image is found.
The original functionality is left in place.

It should only be used from initramfs; other usage will most likely not
work.

Signed-off-by: Hannes Reinecke <hare@suse.de>

--- linux-2.6.10/init/do_mounts.c.orig	2005-01-31 13:54:17.000000000 +0100
+++ linux-2.6.10/init/do_mounts.c	2005-01-31 14:46:08.000000000 +0100
@@ -53,7 +53,7 @@ static int __init readwrite(char *str)
  __setup("ro", readonly);
  __setup("rw", readwrite);

-static dev_t __init try_name(char *name, int part)
+static dev_t try_name(char *name, int part)
  {
  	char path[64];
  	char buf[32];
@@ -135,7 +135,7 @@ fail:
   *	is mounted on rootfs /sys.
   */

-dev_t __init name_to_dev_t(char *name)
+dev_t name_to_dev_t(char *name)
  {
  	char s[32];
  	char *p;
--- linux-2.6.10/kernel/power/disk.c.orig	2005-01-31 13:54:17.000000000 
+0100
+++ linux-2.6.10/kernel/power/disk.c	2005-01-31 14:55:14.000000000 +0100
@@ -9,6 +9,8 @@
   *
   */

+#define DEBUG
+
  #include <linux/suspend.h>
  #include <linux/syscalls.h>
  #include <linux/reboot.h>
@@ -25,13 +27,16 @@ extern struct pm_ops * pm_ops;

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
@@ -121,45 +126,54 @@ static void finish(void)
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
@@ -173,8 +187,15 @@ int pm_suspend_disk(void)
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
@@ -223,14 +244,26 @@ static int software_resume(void)
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
@@ -242,6 +275,8 @@ static int software_resume(void)
  	finish();
   Free:
  	swsusp_free();
+ Cleanup:
+	unprepare_processes();
   Done:
  	pr_debug("PM: Resume from disk failed.\n");
  	return 0;
@@ -329,8 +364,41 @@ static ssize_t disk_store(struct subsyst

  power_attr(disk);

+static ssize_t resume_show(struct subsystem * subsys, char *buf)
+{
+	return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
+		       MINOR(swsusp_resume_device));
+}
+
+static ssize_t resume_store(struct subsystem * subsys, const char * 
buf, size_t n)
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

--- linux-2.6.10/kernel/power/swsusp.c.orig	2005-01-31 
13:54:17.000000000 +0100
+++ linux-2.6.10/kernel/power/swsusp.c	2005-01-31 14:53:36.000000000 +0100
@@ -36,6 +36,8 @@
   * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
   */

+#define DEBUG
+
  #include <linux/module.h>
  #include <linux/mm.h>
  #include <linux/suspend.h>
@@ -80,7 +82,7 @@ static int pagedir_order_check;
  static int nr_copy_pages_check;

  extern char resume_file[];
-static dev_t resume_device;
+
  /* Local variables that should not be affected by save */
  unsigned int nr_copy_pages __nosavedata = 0;

@@ -170,7 +172,7 @@ static int is_resume_device(const struct
  	struct inode *inode = file->f_dentry->d_inode;

  	return S_ISBLK(inode->i_mode) &&
-		resume_device == MKDEV(imajor(inode), iminor(inode));
+		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
  }

  static int swsusp_swap_check(void) /* This is called before saving 
image */
@@ -898,7 +900,7 @@ int swsusp_resume(void)
  /*
   * Returns true if given address/order collides with any orig_address
   */
-static int __init does_collide_order(unsigned long addr, int order)
+static int does_collide_order(unsigned long addr, int order)
  {
  	int i;
  	
@@ -912,7 +914,7 @@ static int __init does_collide_order(uns
   * We check here that pagedir & pages it points to won't collide with 
pages
   * where we're going to restore from the loaded pages later
   */
-static int __init check_pagedir(void)
+static int check_pagedir(void)
  {
  	int i;

@@ -930,7 +932,7 @@ static int __init check_pagedir(void)
  	return 0;
  }

-static int __init swsusp_pagedir_relocate(void)
+static int swsusp_pagedir_relocate(void)
  {
  	/*
  	 * We have to avoid recursion (not to overflow kernel stack),
@@ -1075,7 +1077,7 @@ static int bio_write_page(pgoff_t page_o
   * I really don't think that it's foolproof but more than nothing..
   */

-static const char * __init sanity_check(void)
+static const char * sanity_check(void)
  {
  	dump_info();
  	if(swsusp_info.version_code != LINUX_VERSION_CODE)
@@ -1096,7 +1098,7 @@ static const char * __init sanity_check(
  }


-static int __init check_header(void)
+static int check_header(void)
  {
  	const char * reason = NULL;
  	int error;
@@ -1114,7 +1116,7 @@ static int __init check_header(void)
  	return error;
  }

-static int __init check_sig(void)
+static int check_sig(void)
  {
  	int error;

@@ -1144,7 +1146,7 @@ static int __init check_sig(void)
   *	already did that.
   */

-static int __init data_read(void)
+static int data_read(void)
  {
  	struct pbe * p;
  	int error;
@@ -1169,9 +1171,9 @@ static int __init data_read(void)

  }

-extern dev_t __init name_to_dev_t(const char *line);
+extern dev_t name_to_dev_t(const char *line);

-static int __init read_pagedir(void)
+static int read_pagedir(void)
  {
  	unsigned long addr;
  	int i, n = swsusp_info.pagedir_pages;
@@ -1196,7 +1198,7 @@ static int __init read_pagedir(void)
  	return error;
  }

-static int __init read_suspend_image(void)
+static int check_suspend_image(void)
  {
  	int error = 0;

@@ -1204,6 +1206,13 @@ static int __init read_suspend_image(voi
  		return error;
  	if ((error = check_header()))
  		return error;
+	return error;
+}
+
+static int read_suspend_image(void)
+{
+	int error = 0;
+
  	if ((error = read_pagedir()))
  		return error;
  	if ((error = data_read()))
@@ -1212,30 +1221,74 @@ static int __init read_suspend_image(voi
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
+int swsusp_close(void)
+{
+	int error;
+
+	if (IS_ERR(resume_bdev)) {
+		pr_debug("swsusp: block device not initialised\n");
+		return;
+	}
+
+	blkdev_put(resume_bdev);
+}
--- linux-2.6.10/include/linux/suspend.h.orig	2005-01-31 
13:54:17.000000000 +0100
+++ linux-2.6.10/include/linux/suspend.h	2005-01-31 13:54:33.000000000 +0100
@@ -25,6 +25,8 @@ typedef struct pbe {


  #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+
+extern dev_t swsusp_resume_device;

  /* mm/vmscan.c */
  extern int shrink_mem(void);
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
