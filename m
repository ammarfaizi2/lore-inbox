Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSFCUQb>; Mon, 3 Jun 2002 16:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSFCUQV>; Mon, 3 Jun 2002 16:16:21 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13215 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315483AbSFCUO3>;
	Mon, 3 Jun 2002 16:14:29 -0400
Date: Mon, 3 Jun 2002 22:13:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Cleanup swsusp in 2.5.20
Message-ID: <20020603201353.GA31818@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up swsusp in 2.5.20. Killed sysrq-D support (it is too
much trouble to support suspending from interrupt), kill unused
define, fix compile-time warnings (thanks to Adam). Please apply,

							Pavel

--- clean/include/linux/sched.h	Mon Jun  3 11:43:38 2002
+++ linux-swsusp/include/linux/sched.h	Mon Jun  3 19:15:51 2002
@@ -392,8 +392,7 @@
 
 #define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
-#define PF_KERNTHREAD	0x00040000	/* this thread is a kernel thread that cannot be sent signals to */
-#define PF_FROZEN	0x00080000	/* frozen for system suspend */
+#define PF_FROZEN	0x00040000	/* frozen for system suspend */
 
 /*
  * Ptrace flags
--- clean/include/linux/suspend.h	Thu May 30 12:21:15 2002
+++ linux-swsusp/include/linux/suspend.h	Mon Jun  3 19:15:52 2002
@@ -33,7 +33,7 @@
 	char version[20];
 	int num_cpus;
 	int page_size;
-	unsigned long suspend_pagedir;
+	suspend_pagedir_t *suspend_pagedir;
 	unsigned int num_pbes;
 	struct swap_location {
 		char filename[SWAP_FILENAME_MAXLENGTH];
@@ -50,7 +50,6 @@
 /* kernel/suspend.c */
 extern void software_suspend(void);
 extern void software_resume(void);
-extern int resume_setup(char *str);
 
 extern int register_suspend_notifier(struct notifier_block *);
 extern int unregister_suspend_notifier(struct notifier_block *);
--- clean/kernel/suspend.c	Mon Jun  3 11:43:38 2002
+++ linux-swsusp/kernel/suspend.c	Mon Jun  3 18:41:41 2002
@@ -66,6 +66,8 @@
 #include <asm/io.h>
 #include <linux/swapops.h>
 
+extern void signal_wake_up(struct task_struct *t);
+
 unsigned char software_suspend_enabled = 0;
 
 /* #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1) */
@@ -118,7 +120,7 @@
    collide with anything.
  */
 static suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-static unsigned long pagedir_save;
+static suspend_pagedir_t *pagedir_save;
 static int pagedir_order __nosavedata = 0;
 
 struct link {
@@ -282,7 +284,7 @@
 	strncpy(sh->version, system_utsname.version, 20);
 	sh->num_cpus = smp_num_cpus;
 	sh->page_size = PAGE_SIZE;
-	sh->suspend_pagedir = (unsigned long)pagedir_nosave;
+	sh->suspend_pagedir = pagedir_nosave;
 	if (pagedir_save != pagedir_nosave)
 		panic("Must not happen");
 	sh->num_pbes = nr_copy_pages;
@@ -298,15 +300,10 @@
  * but that should not be a problem since tasks are stopped..
  */
 
-static void do_suspend_sync(void)
+static inline void do_suspend_sync(void)
 {
-	while (1) {
-		blk_run_queues();
-#error this is broken, FIXME
-		if (!TQ_ACTIVE(tq_disk))
-			break;
-		printk(KERN_ERR "Hm, tq_disk is not empty after run_task_queue\n");
-	}
+	blk_run_queues();
+#warning This might be broken. We need to somehow wait for data to reach the disk
 }
 
 /* We memorize in swapfile_used what swap devices are used for suspension */
@@ -412,7 +409,6 @@
 	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
 	union diskpage *cur,  *buffer = (union diskpage *)get_free_page(GFP_ATOMIC);
 	unsigned long address;
-	kdev_t suspend_device;
 
 	PRINTS( "Writing data to swap (%d pages): ", nr_copy_pages );
 	for (i=0; i<nr_copy_pages; i++) {
@@ -427,8 +423,9 @@
 		address = (pagedir_nosave+i)->address;
 		lock_page(virt_to_page(address));
 		{
-			long dummy1, dummy2;
-			get_swaphandle_info(entry, &dummy1, &suspend_device);
+			long dummy1;
+			struct inode *suspend_file;
+			get_swaphandle_info(entry, &dummy1, &suspend_file);
 		}
 		rw_swap_page_nolock(WRITE, entry, (char *) address);
 		(pagedir_nosave+i)->swap_address = entry;
@@ -806,7 +803,7 @@
 		panic("pagedir_order changed?!");
 
 	PRINTR( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir(pagedir_save);
+	free_suspend_pagedir((unsigned long) pagedir_save);
 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
@@ -1047,7 +1044,7 @@
 	return 0;
 } 
 
-extern kdev_t __init name_to_kdev_t(char *line);
+extern kdev_t __init name_to_kdev_t(const char *line);
 
 static int resume_try_to_read(const char * specialfile, int noresume)
 {
@@ -1064,7 +1061,7 @@
 		goto resume_read_error;
 	}
 
-	printk("Resuming from device %x\n", resume_device);
+	printk("Resuming from device %x\n", kdev_t_to_nr(resume_device));
 
 #define READTO(pos, ptr) \
 	if (bdev_read_page(resume_device, pos, ptr)) { error = -EIO; goto resume_read_error; }

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
