Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSE3DSj>; Wed, 29 May 2002 23:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSE3DSi>; Wed, 29 May 2002 23:18:38 -0400
Received: from h-64-105-136-78.SNVACAID.covad.net ([64.105.136.78]:40071 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316221AbSE3DSh>; Wed, 29 May 2002 23:18:37 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 29 May 2002 20:18:24 -0700
Message-Id: <200205300318.UAA00301@baldur.yggdrasil.com>
To: pavel@suse.cz
Subject: Patch(?): linux-2.5.19 suspend.c compilation fixes, one iffy change
Cc: linux-kernel@vger.kernel.org, seasons@fornox.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

	kernel/suspend.c no longer compiles in linux-2.5.19, due to
the elimination of tq_disk.  I infer from the comments on the
new routine blk_run_queues() and from similar changes elsewhere in
2.5.19 that I should probably replace run_task_queue(&tq_disk) with
blk_run_queues().  I also had to elimiante your sanity check which
referenced tq_disk.  I will cc this to linux-kernel in case anyone
else knows the answer and to prevent duplication of effort.

	The rest of the changes just address compiler warnings,
but you might want to look at them anyhow, especially my changing
the types of suspend_pagedir and pagedir_save from unsigned long
to suspend_pagedir_t*.

	Please let me know if you see a problem with this patch, and
if you are going to shepherd it to Linus or if you me to submit it
directly or process it some other way.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."




--- linux-2.5.19/include/linux/suspend.h	2002-05-29 11:42:49.000000000 -0700
+++ linux/include/linux/suspend.h	2002-05-29 18:26:31.000000000 -0700
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
--- linux-2.5.19/kernel/suspend.c	2002-05-29 11:42:49.000000000 -0700
+++ linux/kernel/suspend.c	2002-05-29 18:32:18.000000000 -0700
@@ -65,6 +65,8 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+extern void signal_wake_up(struct task_struct *t);
+
 unsigned char software_suspend_enabled = 0;
 
 /* #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1) */
@@ -117,7 +119,7 @@
    collide with anything.
  */
 static suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-static unsigned long pagedir_save;
+static suspend_pagedir_t *pagedir_save;
 static int pagedir_order __nosavedata = 0;
 
 struct link {
@@ -281,7 +283,7 @@
 	strncpy(sh->version, system_utsname.version, 20);
 	sh->num_cpus = smp_num_cpus;
 	sh->page_size = PAGE_SIZE;
-	sh->suspend_pagedir = (unsigned long)pagedir_nosave;
+	sh->suspend_pagedir = pagedir_nosave;
 	if (pagedir_save != pagedir_nosave)
 		panic("Must not happen");
 	sh->num_pbes = nr_copy_pages;
@@ -297,14 +299,9 @@
  * but that should not be a problem since tasks are stopped..
  */
 
-static void do_suspend_sync(void)
+static inline void do_suspend_sync(void)
 {
-	while (1) {
-		run_task_queue(&tq_disk);
-		if (!TQ_ACTIVE(tq_disk))
-			break;
-		printk(KERN_ERR "Hm, tq_disk is not empty after run_task_queue\n");
-	}
+	blk_run_queues();
 }
 
 /* We memorize in swapfile_used what swap devices are used for suspension */
@@ -410,7 +407,6 @@
 	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
 	union diskpage *cur,  *buffer = (union diskpage *)get_free_page(GFP_ATOMIC);
 	unsigned long address;
-	kdev_t suspend_device;
 
 	PRINTS( "Writing data to swap (%d pages): ", nr_copy_pages );
 	for (i=0; i<nr_copy_pages; i++) {
@@ -425,8 +421,9 @@
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
@@ -804,7 +801,7 @@
 		panic("pagedir_order changed?!");
 
 	PRINTR( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir(pagedir_save);
+	free_suspend_pagedir((unsigned long) pagedir_save);
 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
@@ -1045,7 +1042,7 @@
 	return 0;
 } 
 
-extern kdev_t __init name_to_kdev_t(char *line);
+extern kdev_t __init name_to_kdev_t(const char *line);
 
 static int resume_try_to_read(const char * specialfile, int noresume)
 {
@@ -1062,7 +1059,7 @@
 		goto resume_read_error;
 	}
 
-	printk("Resuming from device %x\n", resume_device);
+	printk("Resuming from device %x\n", kdev_t_to_nr(resume_device));
 
 #define READTO(pos, ptr) \
 	if (bdev_read_page(resume_device, pos, ptr)) { error = -EIO; goto resume_read_error; }
