Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVLGBS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVLGBS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVLGBS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:18:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60110 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932590AbVLGBS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:18:27 -0500
Date: Wed, 7 Dec 2005 02:17:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: [RFC/RFT] suspend from userland
Message-ID: <20051207011753.GA2526@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to get some testing and comments on this. I know that
userland part is messy and will not work on x86-64 etc, and I should
obviously remove some extra printk's... but otherwise it should be okay.

Testing would be nice, too, but be a bit careful. It should not be
more dangerous than /sys/power/resume, but... If you suspect something
unusual, be sure to force fsck.

								Pavel

diff --git a/Documentation/power/uswsusp.txt b/Documentation/power/uswsusp.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/power/uswsusp.txt
@@ -0,0 +1,43 @@
+
+	u-swsusp: do software suspend from userland
+	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+	Copyright 2005 Pavel Machek <pavel@suse.cz>
+		(distribute under GPLv2)
+
+u-swsusp is next generation of swsusp -- it enables userland to do
+most of the work. That way graphical progress bar can be added, and
+you can have encryption, compression, suspend to regular files,
+suspend over network etc. More exotic stuff is possible, too: given
+enough memory and some device mapper magic, you could snapshot system
+every 5 minutes, and then provided unlimited, cross-application
+"undo".
+
+Notice that all warnings in swsusp.txt still apply. If you change your
+filesystem between suspend and resume, that's bye-bye-filesystem. Only
+shooting yourself into the foot has now became simpler, because you'll
+want to run userspace application to do the resume. Remember that even
+read-only mount of journalled filesystem changes it. That means that
+either you'll have to use ext2 for resume application, or put it into
+initrd. (initrd is certainly right solution, long term).
+
+Current userland support is _very_ limited, and provides very little
+safety measures. Be careful. It can only suspend to empty partition,
+and will happily overwrite anything there.
+
+Installation: place swsusp binary into /tmp/, along with
+swsusp-init. Add init=/tmp/swsusp-init to your kernel
+commandline. Modify swsusp-init with right device. To suspend, do
+something like:
+
+swapoff /dev/hda1; cat /dev/zero | head -c 4096 > /dev/hda1
+/tmp/swsusp /dev/hda1 -s -b
+
+. Good luck!
+
+Q: I hate /dev/kmem, it enables crackers to install rootkits.
+
+A: There are 1000 other ways to install rootkit if you have all the
+priviledges these days. Anyway, if you want to make hijacking
+/dev/kmem little harder, you can modify it to only work with pages
+that have "PageNosave | PageNosaveFree" set. swsusp application only
+needs to manipulate those.
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -27,6 +27,7 @@
 #include <linux/crash_dump.h>
 #include <linux/backing-dev.h>
 #include <linux/bootmem.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -559,6 +561,45 @@ static ssize_t write_port(struct file * 
 }
 #endif
 
+static int
+ioctl_kmem(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+        int retval = 0;
+
+        switch (cmd) {
+	case IOCTL_FREEZE:
+		retval = sys_freeze();
+		break;
+	case IOCTL_UNFREEZE:
+		retval = sys_unfreeze();
+		break;
+	case IOCTL_ATOMIC_SNAPSHOT:
+		retval = sys_atomic_snapshot(arg);
+		break;
+	case IOCTL_ATOMIC_RESTORE:
+		{
+			int pages;
+			void *pgdir;
+			get_user(pages, (long *) arg);
+			get_user(pgdir, (void **) (arg + 4));
+			retval = sys_atomic_restore(pgdir, pages);
+		}
+		break;
+	case IOCTL_KMALLOC:
+		retval = get_zeroed_page(GFP_KERNEL);
+		break;
+	case IOCTL_KFREE:
+		free_page(arg);
+		break;
+        default:
+                retval = -ENOTTY;
+                break;
+        }
+
+        return retval;
+}
+
+
 static ssize_t read_null(struct file * file, char __user * buf,
 			 size_t count, loff_t *ppos)
 {
@@ -769,6 +810,7 @@ static struct file_operations mem_fops =
 static struct file_operations kmem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_kmem,
+	.ioctl		= ioctl_kmem,
 	.write		= write_kmem,
 	.mmap		= mmap_kmem,
 	.open		= open_kmem,
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
+#ifdef __KERNEL__
 #if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
 #include <asm/suspend.h>
 #endif
@@ -9,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#endif
 
 /* page backup entry */
 typedef struct pbe {
@@ -30,6 +32,7 @@ typedef struct pbe {
 #define for_each_pb_page(pbe, pblist) \
 	for (pbe = pblist ; pbe ; pbe = (pbe+PB_PAGE_SKIP)->next)
 
+#ifdef __KERNEL__
 
 #define SWAP_FILENAME_MAXLENGTH	32
 
@@ -79,4 +82,24 @@ unsigned long get_safe_page(gfp_t gfp_ma
  */
 #define PAGES_FOR_IO	512
 
+#endif
+
+struct restore_ioctl {
+	void *pgdir;
+	int nr_pages;
+};
+
+#define IOCTL_FREEZE _IO('3', 1)
+#define IOCTL_UNFREEZE _IO('3', 2)
+#define IOCTL_ATOMIC_SNAPSHOT _IOW('3', 3, void **)
+#define IOCTL_ATOMIC_RESTORE _IOR('3', 4, struct restore_ioctl)
+#define IOCTL_KMALLOC _IO('3', 5)
+#define IOCTL_KFREE _IOR('3', 6, void *)
+
+extern int sys_freeze(void);
+extern int sys_unfreeze(void);
+extern int sys_atomic_snapshot(void **pgdir);
+extern int sys_atomic_restore(void *pgdir, int pages);
+
+
 #endif /* _LINUX_SWSUSP_H */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -82,18 +82,6 @@ config PM_STD_PARTITION
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
-config SWSUSP_ENCRYPT
-	bool "Encrypt suspend image"
-	depends on SOFTWARE_SUSPEND && CRYPTO=y && (CRYPTO_AES=y || CRYPTO_AES_586=y || CRYPTO_AES_X86_64=y)
-	default ""
-	---help---
-	  To prevent data gathering from swap after resume you can encrypt
-	  the suspend image with a temporary key that is deleted on
-	  resume.
-
-	  Note that the temporary key is stored unencrypted on disk while the
-	  system is suspended.
-
 config SUSPEND_SMP
 	bool
 	depends on HOTPLUG_CPU && X86 && PM
diff --git a/kernel/power/console.c b/kernel/power/console.c
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -9,6 +9,7 @@
 #include <linux/console.h>
 #include "power.h"
 
+#undef SUSPEND_CONSOLE
 static int new_loglevel = 10;
 static int orig_loglevel;
 #ifdef SUSPEND_CONSOLE
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -84,20 +84,26 @@ static int in_suspend __nosavedata = 0;
 
 static void free_some_memory(void)
 {
-	unsigned int i = 0;
-	unsigned int tmp;
-	unsigned long pages = 0;
-	char *p = "-\\|/";
-
-	printk("Freeing memory...  ");
-	while ((tmp = shrink_all_memory(10000))) {
-		pages += tmp;
-		printk("\b%c", p[i++ % 4]);
+	int i;
+	for (i=0; i<5; i++) {
+		int i = 0, tmp;
+		long pages = 0;
+		char *p = "-\\|/";
+
+		printk("Freeing memory...  ");
+		while ((tmp = shrink_all_memory(10000))) {
+			pages += tmp;
+			printk("\b%c", p[i]);
+			i++;
+			if (i > 3)
+				i = 0;
+		}
+		printk("\bdone (%li pages freed)\n", pages);
+		msleep_interruptible(200);
 	}
-	printk("\bdone (%li pages freed)\n", pages);
 }
 
-
+/* FIXME: Call it when appropriate */
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -138,12 +144,25 @@ thaw:
 
 static void unprepare_processes(void)
 {
-	platform_finish();
 	thaw_processes();
 	enable_nonboot_cpus();
 	pm_restore_console();
 }
 
+
+int sys_freeze(void)
+{
+	return prepare_processes();
+}
+
+int sys_unfreeze(void)
+{
+	thaw_processes();
+	enable_nonboot_cpus();
+	pm_restore_console();
+	return 0;
+}
+
 /**
  *	pm_suspend_disk - The granpappy of power management.
  *
@@ -238,6 +257,9 @@ static int software_resume(void)
 	if ((error = swsusp_check()))
 		goto Done;
 
+	/* Prepare processes only after swsusp_check; we could do it before,
+	   but it would mean an ugly console switch even in case of normal boot.
+	 */
 	pr_debug("PM: Preparing processes for restore.\n");
 
 	if ((error = prepare_processes())) {
diff --git a/kernel/power/power.h b/kernel/power/power.h
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -48,9 +48,6 @@ static struct subsys_attribute _name##_a
 
 extern struct subsystem power_subsys;
 
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
 
diff --git a/kernel/power/process.c b/kernel/power/process.c
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -83,7 +83,7 @@ int freeze_processes(void)
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
 			break;
 		}
 	} while(todo);
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -394,6 +394,7 @@ static void data_free(void)
 			break;
 	}
 }
+/* FIXME: we have data_write but write_pgdir */
 
 /**
  *	data_write - Write saved image to swap.
@@ -498,6 +499,8 @@ static int write_pagedir(void)
 
 	printk( "Writing pagedir...");
 	for_each_pb_page (pbe, pagedir_nosave) {
+		/* FIXME: pagedir only has 768 entries. We may overflow it,
+		   if we write around 768000 pages, thats ~4GB. */
 		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
 			return error;
 	}
@@ -537,7 +540,10 @@ static int write_suspend_image(void)
 
 	if (!enough_swap(nr_copy_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free swap\n");
+#if 0
+		/* FIXME: should be done earlier */
 		return -ENOSPC;
+#endif
 	}
 
 	init_header();
@@ -579,8 +588,6 @@ int swsusp_write(void)
 	return error;
 }
 
-
-
 int swsusp_suspend(void)
 {
 	int error;
@@ -608,6 +615,7 @@ int swsusp_suspend(void)
 	if ((error = swsusp_arch_suspend()))
 		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
+	printk("back in swsusp_suspend\n");
 	restore_processor_state();
 Restore_highmem:
 	restore_highmem();
@@ -620,11 +628,24 @@ Enable_irqs:
 int swsusp_resume(void)
 {
 	int error;
+
+	printk("swsusp_resume: stop devices ");
 	local_irq_disable();
 	if (device_power_down(PMSG_FREEZE))
 		printk(KERN_ERR "Some devices failed to power down, very bad\n");
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
+	/* swsusp_arch_resume takes pagedir_nosave as the only parameter */ 
+	printk("ok");
+
+	/* Takes pagedir_nosave as an argument. Does not need nr_copy_pages */ 
+	{
+		struct pbe *p = pagedir_nosave;
+		int i = 0;
+		for_each_pbe (p, pagedir_nosave)
+			i++;
+		printk("[%d pages]", i);
+	}
 	error = swsusp_arch_resume();
 	/* Code below is only ever reached in case of failure. Otherwise
 	 * execution continues at place where swsusp_arch_suspend was called
@@ -998,7 +1019,6 @@ int swsusp_read(void)
 /**
  *	swsusp_close - close swap device.
  */
-
 void swsusp_close(void)
 {
 	if (IS_ERR(resume_bdev)) {
@@ -1008,3 +1028,55 @@ void swsusp_close(void)
 
 	blkdev_put(resume_bdev);
 }
+
+static int in_suspend __nosavedata = 0;
+
+int sys_atomic_snapshot(void **pgdir)
+{
+	int err;
+
+	err = device_suspend(PMSG_FREEZE);
+	if (err)
+		return err;
+
+	in_suspend = 1;
+	err = swsusp_suspend();
+
+	*pgdir = pagedir_nosave; /* FIXME: put_user */
+
+	{
+		struct pbe *p = pagedir_nosave;
+		int i = 0;
+		for_each_pbe (p, pagedir_nosave)
+			i++;
+	}
+
+	if (!err)
+		err = nr_copy_pages;
+	if (in_suspend == 2) {
+		err = -ENOANO;
+	}
+
+	device_resume();
+	return err;
+}
+
+int sys_atomic_restore(void *pgdir, int pages)
+{
+	int err;
+	/* FIXME: we'll probably overwrite pagedir with itself in inconsistent state...
+	 ...no, pagedir is NOSAVE.
+	*/
+
+	err = device_suspend(PMSG_FREEZE);
+	if (err)
+		return err;
+
+	in_suspend = 2;
+	pagedir_nosave = pgdir;
+	nr_copy_pages = pages;
+
+	err = swsusp_resume();
+	printk(KERN_CRIT "This should never return\n");
+	return err;
+}
diff --git a/usr/swsusp-init b/usr/swsusp-init
new file mode 100755
--- /dev/null
+++ b/usr/swsusp-init
@@ -0,0 +1,9 @@
+#!/bin/bash
+#
+# swapoff /dev/hda1; cat /dev/zero | head -c 4096 > /dev/hda1
+# /tmp/swsusp /dev/hda1 -s -b
+/tmp/swsusp /dev/hda1 -r 
+exec /sbin/init
+exit
+
+
diff --git a/usr/swsusp.c b/usr/swsusp.c
new file mode 100755
--- /dev/null
+++ b/usr/swsusp.c
@@ -0,0 +1,529 @@
+#if 0
+#
+# Swsusp3 control program
+#
+# Copyright 2005 Pavel Machek <pavel@suse.cz>
+#
+# Distribute under GPLv2
+#
+gcc -g -Wall usr/swsusp.c -o /tmp/swsusp; cp -a usr/swsusp-init /tmp
+exit
+#
+#endif
+
+#define PAGE_SIZE 4096
+
+#include <unistd.h>
+#include <syscall.h>
+//#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <asm/fcntl.h>
+#include <string.h>
+
+extern __off64_t lseek64 (int __fd, __off64_t __offset, int __whence) __THROW;
+
+typedef long swp_entry_t;
+
+#include "/data/l/linux-sw3/include/linux/suspend.h"
+#include "/data/l/linux-sw3/include/linux/reboot.h"
+
+char forbidden_pages[(0xffffffff / PAGE_SIZE)+1];
+
+struct resume {
+	int nr_copy_pages;
+	void *pagedir;
+} resume;
+
+struct pbe_page {
+	unsigned long address;		/* address of the copy */
+	unsigned long orig_address;	/* original address of page */
+	swp_entry_t swap_address;	
+
+	struct pbe *next;	/* also used as scratch space at
+				 * end of page (see link, diskpage)
+				 */
+	char data[4096-16];
+};
+
+int kmem;
+
+void
+seek(unsigned long dest)
+{
+	if (lseek64(kmem, dest, SEEK_SET) != dest) {
+		fprintf(stderr, "Could not do intial seek to %lx: %m\n", dest);
+		fprintf(stderr, "lseek64(%d) returned: %lx\n", kmem, (long) lseek64(kmem, dest, SEEK_SET));
+		exit(1);
+	}
+}
+
+typedef int (*walker_t)(struct pbe *p, int i);
+typedef int (*walker2_t)(struct pbe_page *p, int i);
+
+int
+walk_chain(struct resume *r, walker_t w)
+{
+	struct pbe p;
+	int i = 0;
+	long pos;
+
+	seek(pos = (long) r->pagedir);
+	while (1) {
+		if (read(kmem, &p, sizeof(p)) != sizeof(p)) {
+			fprintf(stderr, "Could not read pbe #%d: %m\n", i);
+			exit(1);
+		}
+		if (w != NULL) {
+			w(&p, i);
+			seek(pos);
+			if (write(kmem, &p, sizeof(p)) != sizeof(p)) {
+				fprintf(stderr, "Could not write back pbe #%d: %m\n", i);
+				exit(1);
+			}
+		}
+		i++;
+		if (!p.next)
+			break;
+		seek(pos = (long) p.next);
+	}
+	return i;
+}
+
+void
+walk_pages_chain(struct resume *r, walker2_t w)
+{
+	struct pbe_page p;
+	int i = 0;
+	long pos;
+
+	seek(pos = (long) r->pagedir);
+	while (1) {
+		if (read(kmem, &p, sizeof(p)) != sizeof(p)) {
+			fprintf(stderr, "Could not read pbe #%d: %m\n", i);
+			exit(1);
+		}
+		if ((w != NULL) && !(pos & 0xfff)) {
+			w(&p, i);
+			seek(pos);
+			if (write(kmem, &p, sizeof(p)) != sizeof(p))
+				fprintf(stderr, "Could not write back pbe #%d: %m\n", i);
+		}
+		i++;
+		if (!p.next)
+			break;
+		seek(pos = (long) p.next);
+	}
+}
+
+
+int image_fd, image_pos = 4096;
+
+static int write_page(unsigned long addr, swp_entry_t * loc)
+{
+	swp_entry_t entry;
+
+	entry = image_pos;
+	image_pos += 4096;
+
+	{
+		char buf[4096];
+		seek(addr);
+		if (read(kmem, buf, 4096) != 4096) {
+			fprintf(stderr, "Could not read page #%lx: %m\n", addr);
+			exit(1);
+		}
+		*loc = image_pos;
+		if (lseek(image_fd, image_pos, SEEK_SET) != image_pos) {
+			fprintf(stderr, "Could not seek in image to #%d: %m\n", image_pos);
+			exit(1);
+		}
+		if (write(image_fd, buf, 4096) != 4096) {
+			fprintf(stderr, "Could not write to image at #%d: %m\n", image_pos);
+			exit(1);
+		}
+	}
+	return 0;
+}
+
+unsigned int mod;
+
+static int data_write_one(struct pbe *p, int i)
+{
+	int error;
+	if (!(i%mod))
+		printf( "\b\b\b\b%3d%%", i / mod );
+	if ((error = write_page(p->address, &(p->swap_address))))
+		return error;
+	return 0;
+}
+
+
+struct swsusp_info {
+	int			nr_copy_pages;
+	int			version_code;
+	char			signature[10];
+	swp_entry_t		pagedir[768];
+} __attribute__((aligned(4096)));
+
+struct swsusp_info swsusp_info, zeros;
+
+/**
+ *	data_write - Write saved image to swap.
+ */
+static int data_write(void)
+{
+	int error = 0;
+	mod = resume.nr_copy_pages / 100;
+
+	if (!mod)
+		mod = 1;
+
+	printf( "Writing data to swap (%d pages)...     ", resume.nr_copy_pages );
+	walk_chain(&resume, data_write_one);
+	printf("\b\b\b\bdone\n");
+	return error;
+}
+
+unsigned n = 0;
+
+static int pgdir_write_one(struct pbe_page *pbe, int i)
+{
+	int error;
+	if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
+		return error;
+	return 0;
+}
+
+/**
+ *	write_pagedir - Write the array of nr_copy_pages holding the page directory.
+ *	@last:	Last swap entry we write (needed for header).
+ */
+
+static int write_pagedir(void)
+{
+	int error = 0;
+
+	printf( "Writing pagedir...");
+	walk_pages_chain(&resume, pgdir_write_one);
+
+	swsusp_info.nr_copy_pages = n;
+	printf("done (%u pages)\n", n);
+	return error;
+}
+
+
+/**
+ *	write_suspend_image - Write entire image and metadata.
+ *
+ */
+static int write_suspend_image(void)
+{
+	int error;
+
+	if ((error = data_write()))
+		goto Done;
+
+	if ((error = write_pagedir()))
+		goto Done;
+
+	swsusp_info.nr_copy_pages = resume.nr_copy_pages;
+	swsusp_info.version_code = 1;
+	strcpy(swsusp_info.signature, "swsusp3");
+	lseek(image_fd, 0, SEEK_SET);
+	write(image_fd, &swsusp_info, 4096);
+ Done:
+	return error;
+}
+
+char *image;
+
+int
+do_suspend(void)
+{
+	kmem = open("/dev/kmem", O_RDWR | O_LARGEFILE);
+	image_fd = open(image, O_RDWR | O_CREAT, 0600);
+	resume.nr_copy_pages = -1;
+	resume.pagedir = NULL;
+
+	if (kmem < 0) {
+		fprintf(stderr, "Could not open /dev/kmem: %m\n");
+		exit(1);
+	}
+
+	if (ioctl(kmem, IOCTL_FREEZE, 0)) {
+		fprintf(stderr, "Could not freeze system: %m\n");
+		exit(1);	/* We do not want to reboot in case of failure */
+	}
+
+	resume.nr_copy_pages = ioctl(kmem, IOCTL_ATOMIC_SNAPSHOT, &resume.pagedir);
+	if (resume.nr_copy_pages < 0) {
+		fprintf(stderr, "Could not snapshot system: %m\n");
+
+		if (ioctl(kmem, IOCTL_UNFREEZE, 0)) {
+			fprintf(stderr, "Could not unfreeze system: %m\n");
+			return 1;
+		}
+		exit(1);	/* Stop infinite loop of reboots */
+	}
+
+	walk_chain(&resume, NULL);
+	/* Ouch, at this point we'll appear in ATOMIC_SNAPSHOT syscall, with no way to tell... */
+
+	printf("Snapshotted, have %d pages, pagedir at %lx\n", resume.nr_copy_pages, (long) resume.pagedir);
+	walk_chain(&resume, NULL);
+	write_suspend_image();
+	fsync(image_fd);
+
+	return 0;
+
+}
+
+
+
+/**
+ *	fill_pb_page - Create a list of PBEs on a given memory page
+ */
+
+static inline void fill_pb_page(struct pbe *pbpage)
+{
+	struct pbe *p;
+
+	p = pbpage;
+	pbpage += PB_PAGE_SKIP;
+	do
+		p->next = p + 1;
+	while (++p < pbpage);
+}
+
+unsigned long get_page(void)
+{
+	unsigned long ret;
+
+	do {
+		ret = ioctl(kmem, IOCTL_KMALLOC, 1);
+	} while(forbidden_pages[ret/PAGE_SIZE]);	
+
+	return ret;
+}
+
+/**
+ *	alloc_pagedir - Allocate the page directory.
+ *
+ *	First, determine exactly how many pages we need and
+ *	allocate them.
+ *
+ *	We arrange the pages in a chain: each page is an array of PBES_PER_PAGE
+ *	struct pbe elements (pbes) and the last element in the page points
+ *	to the next page.
+ *
+ *	On each page we set up a list of struct_pbe elements.
+ */
+
+static struct pbe * alloc_pagedir(unsigned nr_pages)
+{
+	unsigned num;
+	struct pbe *pblist;
+	struct pbe buf[PBES_PER_PAGE];
+	int i;
+
+	printf("alloc_pagedir(): nr_pages = %d\n", nr_pages);
+	resume.pagedir = pblist = (struct pbe *) get_page();
+	for (num = PBES_PER_PAGE; num < nr_pages;
+        		nr_pages -= PBES_PER_PAGE) {
+
+		for (i=0; i<PBES_PER_PAGE-1; i++)
+			buf[i].next = &pblist[i+1];
+		buf[PBES_PER_PAGE-1].next = (struct pbe *) get_page();
+
+		seek((long) pblist);
+		write(kmem, buf, PAGE_SIZE);
+		pblist = buf[PBES_PER_PAGE-1].next;
+	}
+
+	for (i=0; i<nr_pages-1; i++)
+		buf[i].next = &pblist[i+1];
+	buf[nr_pages-1].next = 0;
+
+	seek((long) pblist);
+	write(kmem, buf, PAGE_SIZE);
+	return NULL;
+}
+
+
+
+
+/**
+ *	read_pagedir - Read page backup list pages from swap
+ */
+
+static int read_pagedir_one(struct pbe *pbpage, int pos)
+{
+	struct pbe buf[PBES_PER_PAGE];
+	int error;
+	int i;
+	unsigned long offset = swsusp_info.pagedir[pos/PBES_PER_PAGE];
+
+	error = -1;
+	if (!offset)
+		printf("Something went very wrong at pagedir #%d\n", pos);
+
+	lseek(image_fd, offset, SEEK_SET);
+	error = (read(image_fd, (void *)buf, PAGE_SIZE) != PAGE_SIZE);
+
+	for (i=0; i<PBES_PER_PAGE; i++) {
+		pbpage[i].orig_address = buf[i].orig_address;
+		forbidden_pages[pbpage[i].orig_address / PAGE_SIZE] = 1;
+		pbpage[i].swap_address = buf[i].swap_address;
+		pbpage[i].address = buf[i].address;
+	}
+
+	return error;
+}
+
+
+
+/**
+ *	data_read - Read image pages from swap.
+ */
+static int data_read_one(struct pbe *p, int i)
+{
+	int error = 0;
+	char buf[PAGE_SIZE];
+
+	if (!(i % mod))
+		printf("\b\b\b\b%3d%%", i / mod);
+
+	lseek(image_fd, p->swap_address, SEEK_SET);
+
+	p->address = get_page();
+	error = (read(image_fd, buf, PAGE_SIZE) != PAGE_SIZE);
+	seek(p->address);
+	error = (write(kmem, buf, PAGE_SIZE) != PAGE_SIZE);
+
+	return error;
+}
+
+int
+do_resume(void)
+{
+	kmem = open("/dev/kmem", O_RDWR | O_LARGEFILE);
+	image_fd = open(image, O_RDWR);
+
+	if (kmem < 0) {
+		fprintf(stderr, "Could not open /dev/kmem: %m\n");
+		return 1;
+	}
+
+	memset(&swsusp_info, 0, sizeof(swsusp_info));
+	read(image_fd, &swsusp_info, sizeof(swsusp_info));
+	resume.nr_copy_pages = swsusp_info.nr_copy_pages;
+
+	if (strcmp("swsusp3", swsusp_info.signature))
+		exit(0);
+	if (lseek(image_fd, 0, SEEK_SET) != 0) {
+		printf("Could not seek to kill sig: %m\n");
+		exit(1);
+	}
+	if (write(image_fd, &zeros, sizeof(swsusp_info)) != sizeof(swsusp_info)) {
+		printf("Could not write to kill sig: %m\n");
+		exit(1);
+	}
+	if (fsync(image_fd)) {
+		printf("Could not fsync to kill sig: %m\n");
+		exit(1);
+	}
+	printf("Got image, %d pages, signature [%s]\n", resume.nr_copy_pages, swsusp_info.signature);
+
+	alloc_pagedir(resume.nr_copy_pages);
+	printf("Verifying allocated pagedir: %d pages\n", walk_chain(&resume, NULL));
+	printf("swsusp: Reading pagedir ");
+	walk_pages_chain(&resume, (void *) read_pagedir_one);
+	printf("ok\n");
+
+	/* Need to be done twice; so that forbidden_pages comes into effect */
+	alloc_pagedir(resume.nr_copy_pages);
+	printf("Verifying allocated pagedir: %d pages\n", walk_chain(&resume, NULL));
+	printf("swsusp: Reading pagedir ");
+	walk_pages_chain(&resume, (void *) read_pagedir_one);
+	printf("ok\n");
+
+	printf("Verifying allocated pagedir: %d pages\n", walk_chain(&resume, NULL));
+
+	/* FIXME: Need to relocate pages */
+	mod = swsusp_info.nr_copy_pages / 100;
+	if (!mod)
+		mod = 1;
+	printf("swsusp: Reading image data (%d pages):     ",
+			swsusp_info.nr_copy_pages);
+	walk_chain(&resume, data_read_one);
+	printf("\b\b\b\bdone\n");
+
+	if (ioctl(kmem, IOCTL_FREEZE, 0)) {
+		fprintf(stderr, "Could not freeze system: %m\n");
+		return 1;
+	}
+
+	if (ioctl(kmem, IOCTL_ATOMIC_RESTORE, &resume)) {
+		fprintf(stderr, "Could not restore system: %m\n");
+	}
+	/* Ouch, at this point we'll appear in ATOMIC_SNAPSHOT syscall, if
+	   things went ok... */
+
+	return 0;
+}
+
+/*
+#define  LINUX_REBOOT_CMD_RESTART        0x01234567
+#define  LINUX_REBOOT_CMD_HALT           0xCDEF0123
+#define  LINUX_REBOOT_CMD_POWER_OFF      0x4321FEDC
+#define  LINUX_REBOOT_CMD_RESTART2       0xA1B2C3D4
+#define  LINUX_REBOOT_CMD_SW_SUSPEND     0xD000FCE2
+*/
+
+int reboot(unsigned long todo)
+{
+	syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, todo, 0);
+	return 0;
+}
+
+int
+main(int argc, char *argv[])
+{
+	int error;
+
+	sync();
+	setvbuf(stdout, NULL, _IONBF, 0);
+	setvbuf(stderr, NULL, _IONBF, 0);
+
+	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
+		fprintf(stderr, "Could not lock myself: %m\n");
+		return 1;
+	}
+
+	image = argv[1];
+
+	while (argv[2]) {
+
+		if (!strcmp(argv[2], "-s"))
+			error = do_suspend();
+
+		if (!strcmp(argv[2], "-b"))
+			reboot(LINUX_REBOOT_CMD_RESTART);
+
+		if (!strcmp(argv[2], "-h"))
+			reboot(LINUX_REBOOT_CMD_HALT);
+
+		if (!strcmp(argv[2], "-o"))
+			reboot(LINUX_REBOOT_CMD_POWER_OFF);
+
+		if (!strcmp(argv[2], "-r"))
+			error = do_resume();
+
+		argv++;
+	}
+	return error;
+}
+

-- 
Thanks, Sharp!
