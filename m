Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVINWc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVINWc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVINWc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:32:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65460 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965071AbVINWc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:32:26 -0400
Date: Thu, 15 Sep 2005 00:32:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: swsusp3: push image reading/writing into userspace
Message-ID: <20050914223206.GA2376@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's prototype code for swsusp3. It seems to work for me, but don't
try it... yet. Code is very ugly at places, sorry, I know and will fix
it. This is just proof that it can be done, and that it can be done
without excessive ammount of code.

								Pavel

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
@@ -466,6 +467,7 @@ do_write_kmem(void *p, unsigned long rea
 }
 
 
+
 /*
  * This function writes to the *virtual* memory as seen by the kernel.
  */
@@ -565,6 +567,45 @@ static ssize_t write_port(struct file * 
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
+			get_user(pgdir, (long *) (arg + 4));
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
@@ -775,6 +816,7 @@ static struct file_operations mem_fops =
 static struct file_operations kmem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_kmem,
+	.ioctl		= ioctl_kmem,
 	.write		= write_kmem,
 	.mmap		= mmap_kmem,
 	.open		= open_kmem,
diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -360,7 +360,7 @@ tipar_ioctl(struct inode *inode, struct 
 
 	switch (cmd) {
 	case IOCTL_TIPAR_DELAY:
-		delay = (int)arg;    //get_user(delay, &arg);
+		delay = (int)arg;
 		break;
 	case IOCTL_TIPAR_TIMEOUT:
 		if (arg != 0)
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
 
@@ -72,4 +75,14 @@ struct saved_context;
 void __save_processor_state(struct saved_context *ctxt);
 void __restore_processor_state(struct saved_context *ctxt);
 
+#endif
+
+#define IOCTL_FREEZE 0xeee
+#define IOCTL_UNFREEZE 0x70eee
+#define IOCTL_ATOMIC_SNAPSHOT 0x5a5707
+#define IOCTL_ATOMIC_RESTORE 0x8e5708e
+#define IOCTL_KMALLOC 0xa770c
+#define IOCTL_KFREE 0xfee
+
+
 #endif /* _LINUX_SWSUSP_H */
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
@@ -106,6 +106,7 @@ static void free_some_memory(void)
 	}
 }
 
+/* FIXME: Call it when appropriate */
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -146,12 +147,25 @@ thaw:
 
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
@@ -247,6 +261,9 @@ static int software_resume(void)
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
@@ -1,7 +1,7 @@
 #include <linux/suspend.h>
 #include <linux/utsname.h>
 
-/* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
+/* With SUSPEND_CONSOLE defined suspend looks *really* cool, but
    we probably do not take enough locks for switching consoles, etc,
    so bad things might happen.
 */
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -225,7 +225,7 @@ static void lock_swapdevices(void)
 }
 
 /**
- *	write_swap_page - Write one page to a fresh swap location.
+ *	write_page - Write one page to a fresh swap location.
  *	@addr:	Address we're writing.
  *	@loc:	Place to store the entry we used.
  *
@@ -275,6 +275,7 @@ static void data_free(void)
 		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
 	}
 }
+/* FIXME: we have data_write but write_pgdir */
 
 /**
  *	data_write - Write saved image to swap.
@@ -372,6 +373,8 @@ static int write_pagedir(void)
 
 	printk( "Writing pagedir...");
 	for_each_pb_page (pbe, pagedir_nosave) {
+		/* FIXME: pagedir only has 768 entries. We may overflow it,
+		   if we write around 768000 pages, thats ~4GB. */
 		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
 			return error;
 	}
@@ -405,6 +408,8 @@ static int write_suspend_image(void)
  FreeData:
 	data_free();
 	goto Done;
+	/* FIXME: proc se tady uvolnuje?! Aha, ono neni potreba
+	   uvolnovat pri uspesnym resume, takze se uvolnuje tady. */
 }
 
 
@@ -580,6 +585,8 @@ static void copy_data_pages(void)
 			}
 		}
 	}
+	if (pbe)
+		printk(KERN_CRIT "Too many free slots prepared\n");
 	BUG_ON(pbe);
 }
 
@@ -590,7 +597,7 @@ static void copy_data_pages(void)
 
 static int calc_nr(int nr_copy)
 {
-	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
+	return nr_copy;
 }
 
 /**
@@ -601,6 +608,7 @@ static inline void free_pagedir(struct p
 {
 	struct pbe *pbe;
 
+	BUG();
 	while (pblist) {
 		pbe = (pblist + PB_PAGE_SKIP)->next;
 		free_page((unsigned long)pblist);
@@ -671,10 +679,12 @@ static struct pbe * alloc_pagedir(unsign
 
 	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
 	pblist = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	SetPageNosave(virt_to_page(pblist));
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
 		pbe += PB_PAGE_SKIP;
 		pbe->next = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		SetPageNosave(virt_to_page(pbe->next)); 
 	}
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
@@ -717,6 +727,9 @@ static int alloc_image_pages(void)
 	return 0;
 }
 
+/* Free pages we allocated for suspend. Suspend pages are alocated
+ * before atomic copy, so we need to free them after resume.
+ */
 void swsusp_free(void)
 {
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
@@ -779,8 +792,11 @@ static int swsusp_alloc(void)
 	if (!enough_free_mem())
 		return -ENOMEM;
 
+#if 0
+	/* FIXME: belongs elsewhere */
 	if (!enough_swap())
 		return -ENOSPC;
+#endif
 
 	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
@@ -861,6 +877,8 @@ asmlinkage int swsusp_save(void)
 	return suspend_prepare_image();
 }
 
+static int suspend_count __nosavedata = 0;
+
 int swsusp_suspend(void)
 {
 	int error;
@@ -881,31 +899,54 @@ int swsusp_suspend(void)
 
 	if ((error = swsusp_swap_check())) {
 		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
+#if 0
 		device_power_up();
 		local_irq_enable();
 		return error;
+#endif
 	}
 
+
 	save_processor_state();
 	if ((error = swsusp_arch_suspend()))
 		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
+	printk("back in swsusp_suspend\n");
 	restore_processor_state();
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+	WARN_ON (nr_copy_pages_check != nr_copy_pages);
 	restore_highmem();
 	device_power_up();
 	local_irq_enable();
+#if 0
+	if (suspend_count++ < 5)
+		swsusp_resume();
+#endif
 	return error;
 }
 
 int swsusp_resume(void)
 {
 	int error;
+	printk("swsusp_resume: kill devices ");
 	local_irq_disable();
 	if (device_power_down(PMSG_FREEZE))
 		printk(KERN_ERR "Some devices failed to power down, very bad\n");
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
+	printk("ignore processor: ");
+	/* swsusp_arch_resume takes pagedir_nosave as the only parameter */ 
+	mdelay(1000);
+	printk("hope for the best: ");
+
+	/* Takes pagedir_nosave as an argument. Does not need nr_copy_pages */ 
+	{
+		struct pbe *p = pagedir_nosave;
+		int i = 0;
+		for_each_pbe (p, pagedir_nosave)
+			i++;
+		printk("[%d pages]", i);
+	}
+	mdelay(1000);
 	error = swsusp_arch_resume();
 	/* Code below is only ever reached in case of failure. Otherwise
 	 * execution continues at place where swsusp_arch_suspend was called
@@ -1066,8 +1107,9 @@ static struct pbe * swsusp_pagedir_reloc
 		free_pagedir(pblist);
 		free_eaten_memory();
 		pblist = NULL;
-	}
-	else
+		/* Is this even worth handling? It should never ever happen, and we 
+		   have just lost user's state, anyway... */
+	} else
 		printk("swsusp: Relocated %d pages\n", rel);
 
 	return pblist;
@@ -1373,7 +1415,7 @@ int swsusp_read(void)
 	}
 
 	error = read_suspend_image();
-	blkdev_put(resume_bdev);
+	swsusp_close();
 
 	if (!error)
 		pr_debug("swsusp: Reading resume file was successful\n");
@@ -1385,7 +1427,6 @@ int swsusp_read(void)
 /**
  *	swsusp_close - close swap device.
  */
-
 void swsusp_close(void)
 {
 	if (IS_ERR(resume_bdev)) {
@@ -1395,3 +1436,60 @@ void swsusp_close(void)
 
 	blkdev_put(resume_bdev);
 }
+
+static int in_suspend __nosavedata = 0;
+
+int sys_atomic_snapshot(void **pgdir)
+{
+	int err;
+
+	printk(KERN_CRIT "Freezing devices\n");
+	err = device_suspend(PMSG_FREEZE);
+	if (err)
+		return err;
+
+	printk(KERN_CRIT "Devices frozen\n");
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
+		printk("Got image: [%d pages, pgdir at %lx]", i, pagedir_nosave);
+	}
+
+	if (!err)
+		err = nr_copy_pages;
+	if (in_suspend == 2) {
+		printk("This was actually an resume!\n");
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
+	printk("Should restore from: [%d pages, pgdir at %lx]", pages, pgdir);
+	pagedir_nosave = pgdir;
+	nr_copy_pages = pages;
+
+	int error = swsusp_resume();
+	printk(KERN_CRIT "This should never return\n");
+	return error;
+}
diff --git a/usr/swsusp.c b/usr/swsusp.c
new file mode 100644
--- /dev/null
+++ b/usr/swsusp.c
@@ -0,0 +1,487 @@
+/*
+ * Swsusp3 control program
+ *
+ * Copyright 2005 Pavel Machek <pavel@suse.cz>
+ *
+ * Distribute under GPLv2
+ *
+gcc -g -Wall usr/swsusp.c -o /tmp/swsusp
+ */
+
+#define PAGE_SIZE 4096
+
+#include <unistd.h>
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
+struct swsusp_info swsusp_info;
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
+#define IMAGE "/tmp/swsusp.image"
+int
+do_suspend(void)
+{
+	kmem = open("/dev/kmem", O_RDWR | O_LARGEFILE);
+	image_fd = open(IMAGE, O_RDWR | O_CREAT, 0600);
+	resume.nr_copy_pages = -1;
+	resume.pagedir = NULL;
+
+	if (kmem < 0) {
+		fprintf(stderr, "Could not open /dev/kmem: %m\n");
+		return 1;
+	}
+
+	if (ioctl(kmem, IOCTL_FREEZE, 0)) {
+		fprintf(stderr, "Could not freeze system: %m\n");
+		return 1;
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
+		return 1;
+	}
+
+	walk_chain(&resume, NULL);
+	/* Ouch, at this point we'll appear in ATOMIC_SNAPSHOT syscall, with no way to tell... */
+
+	printf("Snapshotted, have %d pages, pagedir at %lx\n", resume.nr_copy_pages, (long) resume.pagedir);
+	walk_chain(&resume, NULL);
+	write_suspend_image();
+
+	if (ioctl(kmem, IOCTL_UNFREEZE, 0)) {
+		fprintf(stderr, "Could not unfreeze system: %m\n");
+		return 1;
+	}
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
+	image_fd = open(IMAGE, O_RDONLY);
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
+	/* Ouch, at this point we'll appear in ATOMIC_SNAPSHOT syscall, with no way to tell... */
+
+	/* We should unfreeze the system -- to recover if something goes wrong */
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
+	error = do_suspend();
+
+	if (!error)
+		printf("Image should be on the disk, resuming\n");
+	else
+		printf("Error during suspend, or perhaps this is resume\n");
+	sleep(2);
+
+	if (!error)
+		error = do_resume();
+	return error;
+}

-- 
if you have sharp zaurus hardware you don't need... you know my address
