Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVGQG03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVGQG03 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 02:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVGQG03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 02:26:29 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:59794 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S261950AbVGQG00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 02:26:26 -0400
Message-ID: <42D9FA0C.3060609@sm.sony.co.jp>
Date: Sun, 17 Jul 2005 15:26:20 +0900
From: Hiroyuki Machida <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Preserve hibenate-system-image on startup
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are now investigating fast startup/shutdown using
2.6 kernel PM functions.

An attached patch enables kernel to preserve system image
on startup, to implement "Snapshot boot".Majordomo@vger.kernel.org wrote:
Conventionally system image will be broken after startup.

Snapshot boot uses un-hibernate from a permanent system image for
startup. During shutdown, does a conventional shutdown without
saving a system image.

We'll explain concept and initial work at OLS. So if you have
interest, we can talk with you at Ottawa.

Thanks,
Hiroyuki Machida

---

This patch enables preserving swsuspend system image over boot cycle, 
against 2.6.12

Signed-off-by: Hiroyui Machida <machida@sony.co.jp> for CELF

-----------------
Index: alp-linux--dev-2-6-12--1.7/kernel/power/Kconfig
===================================================================
--- alp-linux--dev-2-6-12--1.7.orig/kernel/power/Kconfig	2005-07-15 14:59:20.000000000 -0400
+++ alp-linux--dev-2-6-12--1.7/kernel/power/Kconfig	2005-07-16 00:43:31.420000000 -0400
@@ -84,6 +84,20 @@
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+config PRESERVE_SWSUSP_IMAGE
+	bool "Preserve swsuspend image"
+	depends on SOFTWARE_SUSPEND
+	default n
+	---help---
+	  Useally boot with swsup destories the swsusp image.
+	  This function enables to preserve swsup image over boot cycle. 
+	  Default behavior is not chaged even this configuration turned on.
+
+	  To preseve swsusp image, specify following option to command line;
+
+		prsv-img
+
+
 config DEFERRED_RESUME
 	bool "Deferred resume"
 	depends on PM
Index: alp-linux--dev-2-6-12--1.7/kernel/power/disk.c
===================================================================
--- alp-linux--dev-2-6-12--1.7.orig/kernel/power/disk.c	2005-07-16 00:43:02.990000000 -0400
+++ alp-linux--dev-2-6-12--1.7/kernel/power/disk.c	2005-07-16 01:01:42.220000000 -0400
@@ -29,10 +29,29 @@
 extern void swsusp_close(void);
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
+extern void dump_pagedir_nosave(void);
 #ifdef	CONFIG_SAFE_SUSPEND
 extern int suspend_remount(void);
 extern int resume_remount(void);
 #endif
+#ifdef CONFIG_PRESERVE_SWSUSP_IMAGE
+extern int preserve_swsusp_image;
+extern dev_t swsusp_resume_device_nosave __nosavedata;
+extern int swsusp_swap_rdonly(dev_t);
+extern int swsusp_swap_off(dev_t);
+#else
+#define preserve_swsusp_image 0
+#define swsusp_resume_device_nosave 0
+static inline int swsusp_swap_rdonly(dev_t dev)
+{
+	return 0;
+}
+static inline int swsusp_swap_off(dev_t dev)
+{
+	return 0;
+}
+#endif
+
 
 
 static int noresume = 0;
@@ -135,6 +154,26 @@
 	pm_restore_console();
 }
 
+#ifdef CONFIG_PRESERVE_SWSUSP_IMAGE
+void finish_in_resume(void)
+{
+	device_resume();
+	platform_finish();
+	enable_nonboot_cpus();
+	thaw_processes();
+	if (preserve_swsusp_image) {
+		swsusp_swap_off(swsusp_resume_device_nosave);
+	}
+	pm_restore_console();
+}
+#else
+void finish_in_resume(void)
+{
+	finish();
+}
+#endif
+
+
 extern atomic_t on_suspend;   /* See refrigerator() */
 
 static int prepare_processes(void)
@@ -234,8 +273,15 @@
 		error = swsusp_write();
 		if (!error)
 			power_down(pm_disk_mode);
-	} else
+	} else  {
 		pr_debug("PM: Image restored successfully.\n");
+		if (preserve_swsusp_image) {
+			swsusp_swap_rdonly(swsusp_resume_device_nosave);
+		}
+		swsusp_free();
+		finish_in_resume();
+		return 0;
+	}
 	swsusp_free();
  Done:
 	finish();
Index: alp-linux--dev-2-6-12--1.7/kernel/power/swsusp.c
===================================================================
--- alp-linux--dev-2-6-12--1.7.orig/kernel/power/swsusp.c	2005-07-16 00:43:03.000000000 -0400
+++ alp-linux--dev-2-6-12--1.7/kernel/power/swsusp.c	2005-07-16 00:56:22.170000000 -0400
@@ -128,6 +128,11 @@
 
 static struct swsusp_info swsusp_info;
 
+#ifdef CONFIG_PRESERVE_SWSUSP_IMAGE
+dev_t swsusp_resume_device_nosave __nosavedata;
+struct swsusp_header swsusp_header_nosave __nosavedata ;
+#endif
+
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
@@ -139,6 +144,24 @@
 #define PAGES_FOR_IO	512
 #endif
 
+#ifdef CONFIG_PRESERVE_SWSUSP_IMAGE
+int preserve_swsusp_image=0;
+static  int __init preserve_swsusp_image_setup(char *str)
+{
+	if (*str)
+		return 0;
+	preserve_swsusp_image = 1;
+	return 1;
+}
+#else
+static  int __init preserve_swsusp_image_setup(char *str)
+{
+	return 0;
+}
+#endif
+
+__setup("prsv-img", preserve_swsusp_image_setup);
+
 /*
  * Saving part...
  */
@@ -1250,6 +1273,53 @@
 	return error;
 }
 
+#ifdef CONFIG_PRESERVE_SWSUSP_IMAGE
+/**
+ *	mark_swapfiles - Revert swap signature
+ *	
+ *	Assumed that swsusp_header holds correct data 
+ *	and rw_swap_page_sync() works
+ */
+int mark_swsusp(dev_t dev)
+{
+	int	error;
+
+	resume_bdev = open_by_devnum(dev, FMODE_WRITE);
+	if (!IS_ERR(resume_bdev)) {
+		set_blocksize(resume_bdev, PAGE_SIZE);
+		error = bio_write_page(0, &swsusp_header_nosave);
+		blkdev_put(resume_bdev);
+	} else
+		error = PTR_ERR(resume_bdev);
+
+	if (!error)
+		pr_debug("swsusp: Mark swsusp again\n");
+	else
+		pr_debug("swsusp: Error %d marking swsusp\n", error);
+	return error;
+}
+
+inline static void update_swsusp_header(void)
+{
+	swsusp_header_nosave=swsusp_header;
+}
+
+inline static void update_swsusp_device(void)
+{
+	swsusp_resume_device_nosave = swsusp_resume_device;
+}
+#else
+inline static void update_swsusp_header(void)
+{
+	;
+}
+
+inline static void update_swsusp_device(void)
+{
+	;
+}
+#endif
+
 static int check_sig(void)
 {
 	int error;
@@ -1258,6 +1328,7 @@
 	if ((error = bio_read_page(0, &swsusp_header)))
 		return error;
 	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
+		update_swsusp_header();
 		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
 
 		/*
@@ -1412,6 +1483,7 @@
 		pr_debug("swsusp: Resume From Partition %d:%d\n",
 			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 	}
+	update_swsusp_device();
 
 	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
Index: alp-linux--dev-2-6-12--1.7/mm/swapfile.c
===================================================================
--- alp-linux--dev-2-6-12--1.7.orig/mm/swapfile.c	2005-07-15 10:34:54.000000000 -0400
+++ alp-linux--dev-2-6-12--1.7/mm/swapfile.c	2005-07-16 00:43:31.000000000 -0400
@@ -1065,6 +1065,186 @@
 }
 #endif
 
+#ifdef CONFIG_PRESERVE_SWSUSP_IMAGE
+extern int mark_swsusp(dev_t);
+
+#ifdef DEBUG
+extern void cons_write(char *);
+
+#undef pr_debug
+#define pr_debug(fmt,arg...) \
+        do {    \
+		char __cw_buf[64]; \
+		__cw_buf[63]='\0'; \
+                snprintf(__cw_buf, 63, fmt,##arg);   \
+                cons_write(__cw_buf);   \
+        } while (0)
+#endif	/*DEBUG*/
+
+/**
+ *  find_swapdev_info - Find swap block device info, currently used
+ *
+ */
+
+static struct swap_info_struct *find_swapdev_info(dev_t dev,
+					int *p_prev, int *p_type)
+{
+	int prev, type;
+	struct inode *inode;
+	struct swap_info_struct * si = NULL;
+
+	prev = -1;
+	for (type = swap_list.head; type >= 0; type = swap_info[type].next) {
+		si = swap_info + type;
+		pr_debug("P:0x%8.8x, TYPE:0x%8.8x\n", (int)si, type);
+		if (si->flags & SWP_USED) {
+			inode = si->swap_file->f_mapping->host;
+			if (S_ISBLK(inode->i_mode)) {
+				pr_debug("INODE: 0x%8.8x:0x%8.8x\n", 
+					dev, 
+					MKDEV(imajor(inode), iminor(inode)));
+				if (dev == MKDEV(imajor(inode), iminor(inode)))
+					break;
+			}
+		}
+		prev = type;
+	}
+
+	if (type<0) {
+		si = 0;
+	}
+	*p_type = type;
+	*p_prev = prev;
+	return si;
+}
+
+/**
+ * swsusp_swap_rdonly - Find Swap device for swsusp and mark ReadOnly
+ *
+ */
+int swsusp_swap_rdonly(dev_t resume_dev)
+{
+	struct swap_info_struct * si = NULL;
+	int prev;
+	int type;
+	int found=0;
+
+	swap_list_lock();
+
+	si = find_swapdev_info(resume_dev, &prev, &type);
+	if (si) {
+		si->flags &= ~SWP_WRITEOK;
+		found = 1;
+	}
+	swap_list_unlock();
+	return found;
+
+}
+
+/**
+ * swsusp_swpoff -  Turn off swap and set signature for swsusp image
+ *
+ */
+int swsusp_swap_off(dev_t resume_dev)
+{
+	struct swap_info_struct * si = NULL;
+	unsigned short *swap_map;
+	int i;
+	int type, prev;
+	struct block_device *bdev;
+	int err = 0;
+
+	swap_list_lock();
+
+	si = find_swapdev_info(resume_dev, &prev, &type);
+
+	/* swap area for swsusp image is not writable */
+	if ((!si) || (si->flags & SWP_WRITEOK)) {
+		err = -EINVAL;
+		swap_list_unlock();
+		goto out;
+	}
+
+	if (!security_vm_enough_memory(si->pages)) {
+		vm_unacct_memory(si->pages);
+	} else {
+		err = -ENOMEM;
+		si->flags |= SWP_WRITEOK;
+		swap_list_unlock();
+		goto out;
+	}
+
+	pr_debug("swsusp_swapoff:inuse_pages:%ld\n", si->inuse_pages);
+	pr_debug("swsusp_swapoff:pages:%d\n", si->pages);
+	if (prev < 0) {
+		swap_list.head = si->next;
+	} else {
+		swap_info[prev].next = si->next;
+	}
+	if (type == swap_list.next) {
+		/* just pick something that's safe... */
+		swap_list.next = swap_list.head;
+	}
+	nr_swap_pages -= si->pages;
+	total_swap_pages -= si->pages;
+	bdev = I_BDEV(si->swap_file->f_mapping->host);
+	swap_list_unlock();
+
+	current->flags |= PF_SWAPOFF;
+	err = try_to_unuse(type);
+	current->flags &= ~PF_SWAPOFF;
+
+	/* wait for any unplug function to finish */
+	down_write(&swap_unplug_sem);
+	up_write(&swap_unplug_sem);
+
+	if (err) {
+		pr_debug("swsusp_swapoff:err:%d\n", err);
+		/* re-insert swap space back into swap_list */
+		swap_list_lock();
+		for (prev = -1, i = swap_list.head; i >= 0; prev = i, i = swap_info[i].next)
+			if (si->prio >= swap_info[i].prio)
+				break;
+		si->next = i;
+		if (prev < 0)
+			swap_list.head = swap_list.next = si - swap_info;
+		else
+			swap_info[prev].next = si - swap_info;
+		nr_swap_pages += si->pages;
+		total_swap_pages += si->pages;
+		si->flags |= SWP_WRITEOK;
+		swap_list_unlock();
+		goto out;
+	}
+
+	down(&swapon_sem);
+	swap_list_lock();
+	drain_mmlist();
+	swap_device_lock(si);
+	si->swap_file = NULL;
+	si->max = 0;
+	swap_map = si->swap_map;
+	si->swap_map = NULL;
+	si->flags = 0;
+	destroy_swap_extents(si);
+	swap_device_unlock(si);
+	swap_list_unlock();
+	up(&swapon_sem);
+	vfree(swap_map);
+
+	/* set SWSUSP signature, again */
+	mark_swsusp(resume_dev);
+
+	/* release device */
+	set_blocksize(bdev, si->old_block_size);
+	bd_release(bdev);
+	err = 0;
+
+out:
+	return err;
+}
+#endif /*CONFIG_PRESERVE_SWSUSP_IMAGE*/
+
 asmlinkage long sys_swapoff(const char __user * specialfile)
 {
 	struct swap_info_struct * p = NULL;
---




