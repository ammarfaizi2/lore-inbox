Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbUKVRXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUKVRXZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUKVRXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:23:24 -0500
Received: from [220.248.27.114] ([220.248.27.114]:41857 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262192AbUKVRFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:05:42 -0500
Date: Tue, 23 Nov 2004 00:58:24 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATH] swsusp update 1/3
Message-ID: <20041122165823.GA10609@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122110247.GB1063@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 12:02:47PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Yes, I'd like to get rid of "too many continuous pages" problem
> > > before. Small problem is that it needs to update x86-64 too, but I
> > I have not x86-64, so I have no chance to do it.
> 
> I have access to x86-64, so I can do it...
> 								Pavel

Ok, Now I finised ppc part, it works. :) 

Here is all of the patch relative with your big diff.
 core.diff - swsusp core part.
 i386.diff - i386 part.
 ppc.diff  - PowerPC part.

Now we have a option in /proc/sys/kernel/swsusp_pagecache, if that is
sure using swsusp pagecache, otherwise.

Please test and comments. thanks.


--- linux-2.6.9-ppc-g4-peval/include/linux/reboot.h	2004-06-16 13:20:26.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/include/linux/reboot.h	2004-11-22 17:16:58.000000000 +0800
@@ -42,6 +42,8 @@
 extern int register_reboot_notifier(struct notifier_block *);
 extern int unregister_reboot_notifier(struct notifier_block *);
 
+/* For use by swsusp only */
+extern struct notifier_block *reboot_notifier_list;
 
 /*
  * Architecture-specific implementations of sys_reboot commands.
--- linux-2.6.9-ppc-g4-peval/include/linux/suspend.h	2004-11-22 17:11:35.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/include/linux/suspend.h	2004-11-22 17:16:58.000000000 +0800
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#ifdef CONFIG_X86
+#if (defined  CONFIG_X86) || (defined CONFIG_PPC32)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
--- linux-2.6.9-ppc-g4-peval/kernel/power/disk.c	2004-11-22 17:11:35.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/disk.c	2004-11-22 17:17:19.000000000 +0800
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/reboot.h>
 #include <linux/device.h>
 #include "power.h"
 
@@ -29,6 +30,8 @@
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
 
+extern int write_page_caches(void);
+extern int read_page_caches(void);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -48,14 +51,16 @@
 	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_power_down(PMSG_SUSPEND);
+ 		/* device_power_down(PMSG_SUSPEND); */
+		local_irq_save(flags);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
+		local_irq_restore(flags);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
+		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		device_shutdown();
 		machine_power_off();
 		break;
@@ -106,6 +111,7 @@
 	}
 }
 
+
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -118,13 +124,14 @@
 {
 	device_resume();
 	platform_finish();
+	read_page_caches();
 	enable_nonboot_cpus();
 	thaw_processes();
 	pm_restore_console();
 }
 
 
-static int prepare(void)
+static int prepare(int resume)
 {
 	int error;
 
@@ -144,9 +151,13 @@
 	}
 
 	/* Free memory before shutting down devices. */
-	free_some_memory();
+	/* free_some_memory(); */
 
 	disable_nonboot_cpus();
+	if (!resume) 
+		if ((error = write_page_caches())) {
+			goto Finish;
+		}
 	if ((error = device_suspend(PMSG_FREEZE))) {
 		printk("Some devices failed to suspend\n");
 		goto Finish;
@@ -176,7 +187,7 @@
 {
 	int error;
 
-	if ((error = prepare()))
+	if ((error = prepare(0)))
 		return error;
 
 	pr_debug("PM: Attempting to suspend to disk.\n");
@@ -233,7 +244,7 @@
 
 	pr_debug("PM: Preparing system for restore.\n");
 
-	if ((error = prepare()))
+	if ((error = prepare(1)))
 		goto Free;
 
 	barrier();
--- linux-2.6.9-ppc-g4-peval/kernel/power/main.c	2004-11-22 17:11:35.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/main.c	2004-11-22 17:16:58.000000000 +0800
@@ -4,7 +4,7 @@
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  * 
- * This file is release under the GPLv2
+ * This file is released under the GPLv2
  *
  */
 
--- linux-2.6.9-ppc-g4-peval/kernel/power/swsusp.c	2004-11-22 17:11:35.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/swsusp.c	2004-11-23 00:44:27.000000000 +0800
@@ -74,9 +74,6 @@
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;
 
-/* Variables to be preserved over suspend */
-static int pagedir_order_check;
-
 extern char resume_file[];
 static dev_t resume_device;
 /* Local variables that should not be affected by save */
@@ -97,7 +94,6 @@
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -223,7 +219,148 @@
 	swap_list_unlock();
 }
 
+#define ONE_PAGE_PBE_NUM	( PAGE_SIZE / sizeof(struct pbe) - 1)
+
+/* for each pagdir */
+typedef int (*susp_pgdir_t)(suspend_pagedir_t *cur, void *fun, void *arg);
+
+static int inline for_each_pgdir(struct pbe *pbe, susp_pgdir_t fun,
+		void *subfun, void *arg)
+{
+	suspend_pagedir_t *pgdir = pbe;
+	int error = 0;
+
+	while (pgdir != NULL) {
+		suspend_pagedir_t *next = (suspend_pagedir_t *)pgdir->dummy.val;
+		pr_debug("next %p, cur %p\n", next, pgdir);
+		error = fun(pgdir, subfun, arg);
+		if (error) return error;
+		pgdir = next;
+	}
+
+	return (0);
+}
+
+/* free one pagedir */
+static int free_one_pagedir(suspend_pagedir_t *pgdir, void *fun, void *arg)
+{
+	free_page((unsigned long)pgdir);
+	return (0);
+}
+
+typedef int (*swsup_pbe_t)(struct pbe *bpe, void *p);
+
+static int for_pbe_one_pgdir(suspend_pagedir_t *pgdir, void *_fun, 
+		void *arg)
+{
+	unsigned int nums;
+	swsup_pbe_t fun = _fun;
+	int error = 0;
+
+	pr_debug("for_pbe_one_pgdir: %p, %p, %p\n", pgdir, _fun, arg);
+	for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++) {
+		error = fun(pgdir, arg);
+		pgdir ++;
+		if (error) return error;
+	}
+
+	return (0);
+}
+
+static int for_each_pbe(struct pbe *pbe, swsup_pbe_t fun, void *p)
+{
+	return for_each_pgdir(pbe, for_pbe_one_pgdir, fun, p);
+}
+
+unsigned long swsusp_pbe_nums __nosavedata;
+suspend_pagedir_t *swsusp_pbe_pgdir __nosavedata, *swsusp_pbe_next __nosavedata;
+
+/* 
+ * for_each_pbe_copy_back 
+ *
+ * That usefuly for  writing the code in assemble code.
+ *
+ */
+/* #define CREATE_ASM_CODE */
+#ifdef CREATE_ASM_CODE
+asmlinkage void for_each_pbe_copy_back_i386(void)
+{
+	swsusp_pbe_pgdir = pagedir_nosave;
+	while (swsusp_pbe_pgdir != NULL) {
+		swsusp_pbe_next = (suspend_pagedir_t *)swsusp_pbe_pgdir->dummy.val;
+		for (swsusp_pbe_nums = 0; 
+				swsusp_pbe_nums < ONE_PAGE_PBE_NUM; 
+				swsusp_pbe_nums++) {
+			register unsigned long i;
+			if (swsusp_pbe_pgdir->orig_address == 0) return;
+			for (i = 0; i < PAGE_SIZE / (sizeof(unsigned long)); i+=4) {
+				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i)) = 
+					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i));
+				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+1)) = 
+					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+1));
+				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+2)) = 
+					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+2));
+				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+3)) = 
+					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+3));
+			}
+			swsusp_pbe_pgdir ++;
+		}
+		swsusp_pbe_pgdir = swsusp_pbe_next;
+	}
+}
+/*
+ * PowerPC version 
+ * that work in in real mode and have a lots register 
+ */
+asmlinkage void for_each_pbe_copy_back_ppc(void)
+{
+	struct pbe *pgdir = pagedir_nosave, *next;
+	
+	while (pgdir != NULL) {
+		unsigned int nums;
+		pgdir = (struct pbe *)__pa(pgdir);
+		next = (suspend_pagedir_t *)pgdir->dummy.val;
+		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++) {
+			register unsigned long i;
+			unsigned long *orig, *copy;
+			copy = pgdir->address;
+			if (copy == 0) goto end;
+			copy = __pa(copy);
+			orig  = __pa(pgdir->orig_address);
+			for (i = 0; i < PAGE_SIZE / (sizeof(unsigned long)); i += 4) {
+				*(orig + i) = *(copy + i);
+				*(orig + i+1) = *(copy + i+1);
+				*(orig + i+2) = *(copy + i+2);
+				*(orig + i+3) = *(copy + i+3);
+			}
+			pgdir ++;
+		}
+		pgdir = next;
+	}
+end:
+	panic("");
+}
+#endif
+
+static struct pbe *find_pbe_by_index(int index, struct pbe *pgdir)
+{
+	unsigned int nums = ONE_PAGE_PBE_NUM;
+	suspend_pagedir_t *next, *ret = NULL;
+
+	pr_debug("find_pbe_by_index %d, %p\n", index, pgdir);
+	while (pgdir != NULL) {
+		if (index < nums) {
+			ret = pgdir + (index % ONE_PAGE_PBE_NUM);
+			break;
+		}
+		next = (suspend_pagedir_t *)pgdir->dummy.val;
+		nums += ONE_PAGE_PBE_NUM;
+		pgdir = next;
+	}
+	pr_debug("find_pbe index %d -> %p\n", index, ret);
 
+	return (ret);
+}
 
 /**
  *	write_swap_page - Write one page to a fresh swap location.
@@ -257,6 +394,20 @@
 	return error;
 }
 
+static int data_free_pbe(struct pbe *p, void *tmp)
+{
+	swp_entry_t entry;
+
+	if (swp_offset(p->swap_address)== 0) return -1;
+
+	(*(int*)tmp) ++;
+	entry = p->swap_address;
+	if (entry.val)
+		swap_free(entry);
+	p->swap_address = (swp_entry_t){0};
+
+	return (0);
+}
 
 /**
  *	data_free - Free the swap entries used by the saved image.
@@ -267,43 +418,56 @@
 
 static void data_free(void)
 {
-	swp_entry_t entry;
-	int i;
+	int i = 0;
+	for_each_pbe(pagedir_nosave, data_free_pbe, &i);
+	BUG_ON( i != nr_copy_pages);
+}
 
-	for (i = 0; i < nr_copy_pages; i++) {
-		entry = (pagedir_nosave + i)->swap_address;
-		if (entry.val)
-			swap_free(entry);
-		else
-			break;
-		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
-	}
+static int mod_progress = 1;
+
+static void inline mod_printk_progress(int i)
+{
+	if (mod_progress == 0) mod_progress = 1;
+	if (!(i%100))
+		printk( "\b\b\b\b%3d%%", i / mod_progress );
 }
 
+static int write_one_pbe(struct pbe *p, void *tmp)
+{
+	int error = 0, i = *(int*)tmp;
+
+	mod_printk_progress(i);
+
+	pr_debug("write_one_pbe: %p, %p %p ",
+			p, (void *)p->address, (void *)p->orig_address);
+	if (p->orig_address == 0) return -1;
+
+	(*(int*)tmp) ++;
+	error = write_page(p->address, &p->swap_address);
+	if (error) return error;
+
+	pr_debug("%lu\n", swp_offset(p->swap_address));
+
+	return (0);
+}
 
 /**
  *	data_write - Write saved image to swap.
  *
  *	Walk the list of pages in the image and sync each one to swap.
  */
-
 static int data_write(void)
 {
-	int error = 0;
-	int i;
-	unsigned int mod = nr_copy_pages / 100;
-
-	if (!mod)
-		mod = 1;
+	int i = 0, error;
+	
+	mod_progress = nr_copy_pages / 100;
 
-	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		error = write_page((pagedir_nosave+i)->address,
-					  &((pagedir_nosave+i)->swap_address));
-	}
+	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages);
+	error = for_each_pbe(pagedir_nosave, write_one_pbe, &i);
 	printk("\b\b\b\bdone\n");
+
+	if (i == nr_copy_pages)  return (0);
+
 	return error;
 }
 
@@ -363,6 +527,15 @@
 		swap_free(swsusp_info.pagedir[i]);
 }
 
+static int write_one_pagedir(suspend_pagedir_t *pgdir, 
+		void *fun, void *arg)
+{
+	int i = *(int *)arg;
+
+	(*(int *)arg) ++;
+
+	return write_page((unsigned long)pgdir, &swsusp_info.pagedir[i]);
+}
 
 /**
  *	write_pagedir - Write the array of pages holding the page directory.
@@ -371,15 +544,12 @@
 
 static int write_pagedir(void)
 {
-	unsigned long addr = (unsigned long)pagedir_nosave;
-	int error = 0;
-	int n = SUSPEND_PD_PAGES(nr_copy_pages);
-	int i;
+	int error = 0, n = 0;
 
-	swsusp_info.pagedir_pages = n;
+	error = for_each_pgdir(pagedir_nosave, write_one_pagedir, NULL, &n);
 	printk( "Writing pagedir (%d pages)\n", n);
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = write_page(addr, &swsusp_info.pagedir[i]);
+	swsusp_info.pagedir_pages = n;
+
 	return error;
 }
 
@@ -504,6 +674,366 @@
 	return 0;
 }
 
+typedef int (*do_page_t)(struct page *page, int p);
+
+static int foreach_zone_page(struct zone *zone, do_page_t fun, int p)
+{
+	int inactive = 0, active = 0;
+
+	spin_lock_irq(&zone->lru_lock);
+	if (zone->nr_inactive) {
+		struct list_head * entry = zone->inactive_list.prev;
+		while (entry != &zone->inactive_list) {
+			if (fun) {
+				struct page * page = list_entry(entry, struct page, lru);
+				inactive += fun(page, p);
+			} else { 
+				inactive ++;
+			}
+			entry = entry->prev;
+		}
+	}
+	if (zone->nr_active) {
+		struct list_head * entry = zone->active_list.prev;
+		while (entry != &zone->active_list) {
+			if (fun) {
+				struct page * page = list_entry(entry, struct page, lru);
+				active += fun(page, p);
+			} else {
+				active ++;
+			}
+			entry = entry->prev;
+		}
+	}
+	spin_unlock_irq(&zone->lru_lock); 
+
+	return (active + inactive);
+}
+
+/* enable/disable pagecache suspend */
+int swsusp_pagecache = 1;
+
+/* I'll move this to include/linux/page-flags.h */
+#define PG_pcs (PG_nosave_free + 1)
+
+#define SetPagePcs(page)    set_bit(PG_pcs, &(page)->flags)
+#define ClearPagePcs(page)  clear_bit(PG_pcs, &(page)->flags)
+#define PagePcs(page)   test_bit(PG_pcs, &(page)->flags)
+
+static suspend_pagedir_t *pagedir_cache = NULL;
+static int nr_copy_pcs = 0;
+
+static int setup_pcs_pe(struct page *page, int setup)
+{
+	unsigned long pfn = page_to_pfn(page);
+
+	BUG_ON(PageReserved(page) && PageNosave(page));
+	if (!pfn_valid(pfn)) {
+		printk("not valid page\n");
+		return 0;
+	}
+	if (PageNosave(page)) {
+		printk("nosave\n");
+		return 0;
+	}
+	if (PageReserved(page) /*&& pfn_is_nosave(pfn)*/) {
+		printk("[nosave]\n");
+		return 0;
+	}
+	if (PageSlab(page)) {
+		printk("slab\n");
+		return (0);
+	}
+	if (setup) {
+		struct pbe *p = find_pbe_by_index(nr_copy_pcs, pagedir_cache);
+		p->address = (long)page_address(page);
+		pr_debug("setup_pcs: cur %p, addr %p, next %p, nr %u\n",
+				(void*)p, (void*)p->address, 
+				(void*)p->orig_address, nr_copy_pcs);
+		nr_copy_pcs ++;
+	}
+	SetPagePcs(page);
+
+	return (1);
+}
+
+static int count_pcs(struct zone *zone, int p)
+{
+	if (swsusp_pagecache)
+		return foreach_zone_page(zone, setup_pcs_pe, p);	
+	return (0);
+}
+
+static int check_pbe_addr(struct pbe *p, void *addr)
+{
+	unsigned long addre = (unsigned long)addr + PAGE_SIZE;
+
+	if (p->orig_address == (unsigned long)0) return 0;
+	if (p->orig_address >= (unsigned long)addr && p->orig_address < addre)
+		return 1;
+	return 0;
+}
+
+
+/*
+ * redefine in PageCahe pagdir.
+ *
+ * struct pbe {
+ * unsigned long address;
+ * unsigned long orig_address; pointer of next struct pbe
+ * swp_entry_t swap_address;
+ * swp_entry_t dummy;          current index
+ * }
+ *
+ */
+static suspend_pagedir_t * alloc_one_pagedir(suspend_pagedir_t *prev, 
+		suspend_pagedir_t *collide)
+{
+	suspend_pagedir_t *pgdir = NULL;
+	int i;
+
+	pgdir = (suspend_pagedir_t *)
+		__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+	if (!pgdir) {
+		return NULL;
+	}
+
+	if (collide) {
+		while (for_each_pbe((struct pbe *)collide, check_pbe_addr, pgdir)) {
+			free_page((unsigned long)pgdir);
+			pgdir = (suspend_pagedir_t *)
+				__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+			if (!pgdir) {
+				return NULL;
+			}
+		}
+	}
+
+	pr_debug("pgdir: %p, %p, %d\n", pgdir, prev, sizeof(suspend_pagedir_t));
+	memset(pgdir, 0, PAGE_SIZE);
+	for (i = 0; i < ONE_PAGE_PBE_NUM ; i++) {
+		pgdir[i].dummy.val = (unsigned long)NULL;
+		pgdir[i].address = 0;
+		pgdir[i].orig_address = 0;
+		if (prev == NULL) continue;
+		prev[i].dummy.val= (unsigned long)pgdir;
+	}
+
+	return (pgdir);
+}
+
+static int alloc_pagedir(struct pbe **pbe, int pbe_nums, struct pbe *collide)
+{
+	unsigned int nums = 0, alloc_nums = 1;
+	suspend_pagedir_t *prev, *cur = NULL;
+
+	/* alloc pagedir head */
+	prev = alloc_one_pagedir(NULL, collide);
+	if (!prev) {
+		return -ENOMEM;
+	}
+	*pbe = prev;
+
+	for (nums = ONE_PAGE_PBE_NUM; nums < pbe_nums; nums += ONE_PAGE_PBE_NUM) {
+		cur = alloc_one_pagedir(prev, collide);
+		if (!cur) {
+			goto no_mem;
+		}
+		prev = cur;
+		alloc_nums ++;
+	}
+	return alloc_nums;
+
+no_mem:
+	for_each_pgdir(*pbe, free_one_pagedir, NULL, NULL);
+	*pbe = NULL;
+
+	return (-ENOMEM);
+}
+
+int bio_read_page(pgoff_t page_off, void * page);
+
+static int pagecache_read_pbe(struct pbe *p, void *tmp)
+{
+	int error = 0, i = *(int*)tmp;
+	swp_entry_t entry;
+
+	mod_printk_progress(i);
+
+	if (swp_offset(p->swap_address)== 0) return -1;
+
+	(*(int*)tmp) ++;
+	pr_debug("pagecache_read_pbe: %p %p %lu\n", 
+			(void *)p->address, (void *)p->orig_address, 
+			swp_offset(p->swap_address));
+
+	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	if (error) return error;
+
+	entry = p->swap_address;
+	if (entry.val)
+		swap_free(entry);
+
+	return (0);
+}
+
+int read_page_caches(void)
+{
+	int error = 0, i = 0;
+
+	if (swsusp_pagecache == 0) return (0);
+
+	mod_progress = nr_copy_pcs / 100;
+
+	printk( "Reading PageCaches from swap (%d pages)...     ", nr_copy_pcs);
+	error = for_each_pbe(pagedir_cache, pagecache_read_pbe, &i);
+	printk("\b\b\b\bdone\n");
+
+	for_each_pgdir(pagedir_cache, free_one_pagedir, NULL, NULL);
+
+	if (i == nr_copy_pcs)  return (0);
+
+	return error;
+}
+
+static int pagecache_write_pbe(struct pbe *p, void *tmp)
+{
+	int error = 0, i = *(int*)tmp;
+
+	mod_printk_progress(i);
+
+	pr_debug("pagecache_write_pbe: %p, %p %p ",
+			p, (void *)p->address, (void *)p->orig_address);
+	if (p->address == 0) return -1;
+
+	(*(int*)tmp) ++;
+	error = write_page(p->address, &p->swap_address);
+	if (error) return error;
+
+	pr_debug("%lu\n", swp_offset(p->swap_address));
+
+	return (0);
+}
+
+static int pcs_write(void)
+{
+	int i = 0, error;
+	
+	mod_progress = nr_copy_pcs / 100;
+
+	printk( "Writing PageCaches to swap (%d pages)...     ", nr_copy_pcs);
+	error = for_each_pbe(pagedir_cache, pagecache_write_pbe, &i);
+	printk("\b\b\b\bdone\n");
+
+	if (i == nr_copy_pcs)  return (0);
+
+	return error;
+}
+
+static int setup_pagedir_pbe(void)
+{
+	struct zone *zone;
+
+	nr_copy_pcs = 0;
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			count_pcs(zone, 1);
+		}
+	}
+
+	return (0);
+}
+
+static void count_data_pages(void);
+static int swsusp_alloc(void);
+
+static void page_caches_recal(void)
+{
+	struct zone *zone;
+	int i;
+
+	for (i = 0; i < max_mapnr; i++)
+		ClearPagePcs(mem_map+i);
+
+	nr_copy_pcs = 0;
+	drain_local_pages();
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			nr_copy_pcs += count_pcs(zone, 0);
+		}
+	}
+}
+
+int write_page_caches(void)
+{
+	int error;
+	int recal = 0;
+
+	if (swsusp_pagecache) {
+		page_caches_recal();
+
+		if (nr_copy_pcs == 0) {
+			return (0);
+		}
+		printk("swsusp: Need to copy %u pcs\n", nr_copy_pcs);
+		if (alloc_pagedir(&pagedir_cache, nr_copy_pcs, NULL) < 0) {
+			return -ENOMEM;
+		}
+	}
+
+	if ((error = swsusp_swap_check())) {
+		return error;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	while (nr_free_pages() < nr_copy_pages + PAGES_FOR_IO) {
+		if (recal == 0) {
+			printk("swsusp: try shrink memory ");
+		}
+		shrink_all_memory(nr_copy_pages + PAGES_FOR_IO + recal);
+		recal += PAGES_FOR_IO;
+	}
+
+	if (recal) {
+		printk("done\n");
+		page_caches_recal();
+		drain_local_pages();
+		count_data_pages();
+		printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
+				nr_copy_pages, nr_copy_pcs);
+	}
+	
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(2/2): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	error = swsusp_alloc();
+	if (error) {
+		printk("swsusp_alloc failed, %d\n", error);
+		return error;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(final): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	if (swsusp_pagecache) {
+		setup_pagedir_pbe();
+		pr_debug("after setup_pagedir_pbe \n");
+
+		error = pcs_write();
+		if (error) 
+			return error;
+	}
+
+	return (0);
+}
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -539,7 +1069,10 @@
 	}
 	if (PageNosaveFree(page))
 		return 0;
-
+	if (PagePcs(page) && swsusp_pagecache) {
+		BUG_ON(zone->nr_inactive == 0 && zone->nr_active == 0);
+		return 0;
+	}
 	return 1;
 }
 
@@ -549,10 +1082,12 @@
 	unsigned long zone_pfn;
 
 	nr_copy_pages = 0;
+	nr_copy_pcs = 0;
 
 	for_each_zone(zone) {
 		if (is_highmem(zone))
 			continue;
+		nr_copy_pcs += count_pcs(zone, 0);
 		mark_free_pages(zone);
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 			nr_copy_pages += saveable(zone, &zone_pfn);
@@ -564,7 +1099,6 @@
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe * pbe = pagedir_nosave;
 	int pages_copied = 0;
 	
 	for_each_zone(zone) {
@@ -574,11 +1108,12 @@
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page * page;
+				struct pbe * pbe = find_pbe_by_index(pages_copied, pagedir_nosave);
+				BUG_ON(pbe == NULL);
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				pbe->orig_address = (long) page_address(page);
 				/* copy_page is not usable for copying task structs. */
 				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-				pbe++;
 				pages_copied++;
 			}
 		}
@@ -587,104 +1122,44 @@
 	nr_copy_pages = pages_copied;
 }
 
-
-/**
- *	calc_order - Determine the order of allocation needed for pagedir_save.
- *
- *	This looks tricky, but is just subtle. Please fix it some time.
- *	Since there are %nr_copy_pages worth of pages in the snapshot, we need
- *	to allocate enough contiguous space to hold 
- *		(%nr_copy_pages * sizeof(struct pbe)), 
- *	which has the saved/orig locations of the page.. 
- *
- *	SUSPEND_PD_PAGES() tells us how many pages we need to hold those 
- *	structures, then we call get_bitmask_order(), which will tell us the
- *	last bit set in the number, starting with 1. (If we need 30 pages, that
- *	is 0x0000001e in hex. The last bit is the 5th, which is the order we 
- *	would use to allocate 32 contiguous pages).
- *
- *	Since we also need to save those pages, we add the number of pages that
- *	we need to nr_copy_pages, and in case of an overflow, do the 
- *	calculation again to update the number of pages needed. 
- *
- *	With this model, we will tend to waste a lot of memory if we just cross
- *	an order boundary. Plus, the higher the order of allocation that we try
- *	to do, the more likely we are to fail in a low-memory situtation 
- *	(though	we're unlikely to get this far in such a case, since swsusp 
- *	requires half of memory to be free anyway).
- */
-
-
-static void calc_order(void)
+static int free_one_snapshot_pbe(struct pbe *p, void *tmp)
 {
-	int diff = 0;
-	int order = 0;
-
-	do {
-		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
-		if (diff) {
-			order += diff;
-			nr_copy_pages += 1 << diff;
-		}
-	} while(diff);
-	pagedir_order = order;
+	if (p->address) {
+			ClearPageNosave(virt_to_page(p->address));
+			free_page(p->address);
+			p->address = 0;
+	}
+	return (0);
 }
 
-
 /**
- *	alloc_pagedir - Allocate the page directory.
- *
- *	First, determine exactly how many contiguous pages we need and
- *	allocate them.
+ *	free_image_pages - Free pages allocated for snapshot
  */
-
-static int alloc_pagedir(void)
+static void free_image_pages(void)
 {
-	calc_order();
-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
-							     pagedir_order);
-	if (!pagedir_save)
-		return -ENOMEM;
-	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
-	pagedir_nosave = pagedir_save;
-	return 0;
+	for_each_pbe(pagedir_save, free_one_snapshot_pbe, NULL);
 }
 
-/**
- *	free_image_pages - Free pages allocated for snapshot
- */
-
-static void free_image_pages(void)
+static int alloc_one_snapshot_pbe(struct pbe *p, void *tmp)
 {
-	struct pbe * p;
-	int i;
+	(*(int *)tmp) ++;
+	p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	if (!p->address)
+		return -ENOMEM;
+	SetPageNosave(virt_to_page(p->address));
 
-	p = pagedir_save;
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
-		if (p->address) {
-			ClearPageNosave(virt_to_page(p->address));
-			free_page(p->address);
-			p->address = 0;
-		}
-	}
+	return (0);
 }
-
 /**
  *	alloc_image_pages - Allocate pages for the snapshot.
  *
  */
-
 static int alloc_image_pages(void)
 {
-	struct pbe * p;
-	int i;
+	int i = 0;
+
+	for_each_pbe(pagedir_save, alloc_one_snapshot_pbe, &i);
 
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if (!p->address)
-			return -ENOMEM;
-		SetPageNosave(virt_to_page(p->address));
-	}
 	return 0;
 }
 
@@ -693,7 +1168,7 @@
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
-	free_pages((unsigned long) pagedir_save, pagedir_order);
+	for_each_pgdir(pagedir_save, free_one_pagedir, NULL, NULL);
 }
 
 
@@ -730,7 +1205,7 @@
 	struct sysinfo i;
 
 	si_swapinfo(&i);
-	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
+	if (i.freeswap < (nr_copy_pages + nr_copy_pcs + PAGES_FOR_IO))  {
 		pr_debug("swsusp: Not enough swap. Need %ld\n",i.freeswap);
 		return 0;
 	}
@@ -750,25 +1225,24 @@
 
 	if (!enough_swap())
 		return -ENOSPC;
-
-	if ((error = alloc_pagedir())) {
-		pr_debug("suspend: Allocating pagedir failed.\n");
-		return error;
+	error = alloc_pagedir(&pagedir_save, nr_copy_pages, NULL);
+	if (error < 0) {
+		printk("suspend: Allocating pagedir failed.\n");
+		return -ENOMEM;
 	}
 	if ((error = alloc_image_pages())) {
-		pr_debug("suspend: Allocating image pages failed.\n");
+		printk("suspend: Allocating image pages failed.\n");
 		swsusp_free();
 		return error;
 	}
+	pagedir_nosave = pagedir_save;
 
-	pagedir_order_check = pagedir_order;
 	return 0;
 }
 
 int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages;
-	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -777,15 +1251,8 @@
 		return -ENOMEM;
 	}
 
-	drain_local_pages();
-	count_data_pages();
-	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 
-	error = swsusp_alloc();
-	if (error)
-		return error;
-	
 	/* During allocating of suspend pagedir, new cold pages may appear. 
 	 * Kill them.
 	 */
@@ -854,11 +1321,11 @@
 
 asmlinkage int swsusp_restore(void)
 {
-	BUG_ON (pagedir_order_check != pagedir_order);
-	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
+#if defined(CONFIG_X86) && defined(CONFIG_X86_64)
 	__flush_tlb_global();
 	wbinvd();	/* Nigel says wbinvd here is good idea... */
+#endif
 	return 0;
 }
 
@@ -881,99 +1348,6 @@
 	return error;
 }
 
-
-
-/* More restore stuff */
-
-#define does_collide(addr) does_collide_order(pagedir_nosave, addr, 0)
-
-/*
- * Returns true if given address/order collides with any orig_address 
- */
-static int __init does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
-		int order)
-{
-	int i;
-	unsigned long addre = addr + (PAGE_SIZE<<order);
-	
-	for (i=0; i < nr_copy_pages; i++)
-		if ((pagedir+i)->orig_address >= addr &&
-			(pagedir+i)->orig_address < addre)
-			return 1;
-
-	return 0;
-}
-
-/*
- * We check here that pagedir & pages it points to won't collide with pages
- * where we're going to restore from the loaded pages later
- */
-static int __init check_pagedir(void)
-{
-	int i;
-
-	for(i=0; i < nr_copy_pages; i++) {
-		unsigned long addr;
-
-		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if(!addr)
-				return -ENOMEM;
-		} while (does_collide(addr));
-
-		(pagedir_nosave+i)->address = addr;
-	}
-	return 0;
-}
-
-static int __init swsusp_pagedir_relocate(void)
-{
-	/*
-	 * We have to avoid recursion (not to overflow kernel stack),
-	 * and that's why code looks pretty cryptic 
-	 */
-	suspend_pagedir_t *old_pagedir = pagedir_nosave;
-	void **eaten_memory = NULL;
-	void **c = eaten_memory, *m, *f;
-	int ret = 0;
-
-	printk("Relocating pagedir ");
-
-	if (!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
-		printk("not necessary\n");
-		return check_pagedir();
-	}
-
-	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
-		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
-			break;
-		eaten_memory = m;
-		printk( "." ); 
-		*eaten_memory = c;
-		c = eaten_memory;
-	}
-
-	if (!m) {
-		printk("out of memory\n");
-		ret = -ENOMEM;
-	} else {
-		pagedir_nosave =
-			memcpy(m, old_pagedir, PAGE_SIZE << pagedir_order);
-	}
-
-	c = eaten_memory;
-	while (c) {
-		printk(":");
-		f = c;
-		c = *c;
-		free_pages((unsigned long)f, pagedir_order);
-	}
-	if (ret)
-		return ret;
-	printk("|\n");
-	return check_pagedir();
-}
-
 /**
  *	Using bio to read from swap.
  *	This code requires a bit more work than just using buffer heads
@@ -993,7 +1367,7 @@
 	return 0;
 }
 
-static struct block_device * resume_bdev;
+static struct block_device * resume_bdev __nosavedata;
 
 /**
  *	submit - submit BIO request.
@@ -1088,7 +1462,6 @@
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1115,62 +1488,124 @@
 	return error;
 }
 
+static int __init check_one_pbe(struct pbe *p, void *collide)
+{
+	unsigned long addr = 0;
+	static int checked = 0;
+
+	if (p->orig_address == 0) return (checked);
+
+	do {
+		addr = get_zeroed_page(GFP_ATOMIC);
+		if(!addr)
+			return -ENOMEM;
+	pr_debug("check_one_pbe: %p %p %p ", p, (void*)addr, (void*)p->orig_address);
+	} while(for_each_pbe((struct pbe *)collide, check_pbe_addr, (void*)addr));
+	pr_debug("done\n");
+	p->address = addr;
+	checked ++;
+
+	return (0);
+}
+
+/*
+ * We check here that pagedir & pages it points to won't collide with pages
+ * where we're going to restore from the loaded pages later
+ */
+static int __init check_pagedir(void)
+{
+	int i;
+
+	i = for_each_pbe(pagedir_nosave, check_one_pbe, pagedir_nosave);
+	BUG_ON(i != nr_copy_pages);
+
+	return (0);
+}
+
+static int __init read_one_pbe(struct pbe *p, void *tmp)
+{
+	int error = 0, i = *(int*)tmp;
+
+	mod_printk_progress(i);
+
+	pr_debug("read_one_pbe: %p %p %p %lu, %d\n", 
+			p, (void *)p->address, (void *)p->orig_address, 
+			swp_offset(p->swap_address), i);
+	if (p->orig_address == 0) return -1;
+	(*(int*)tmp) ++;
+
+	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	if (error) return error;
+
+	return (0);
+}
+
 /**
  *	swsusp_read_data - Read image pages from swap.
  *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
  */
 
 static int __init data_read(void)
 {
-	struct pbe * p;
 	int error;
-	int i;
-	int mod = nr_copy_pages / 100;
-
-	if (!mod)
-		mod = 1;
+	int i = 0;
 
-	if ((error = swsusp_pagedir_relocate()))
-		return error;
+	if (check_pagedir()) {
+		return -ENOMEM;
+	}
+	mod_progress = nr_copy_pages / 100;
 
 	printk( "Reading image data (%d pages):     ", nr_copy_pages );
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		error = bio_read_page(swp_offset(p->swap_address),
-				  (void *)p->address);
-	}
+	error = for_each_pbe(pagedir_nosave, read_one_pbe, &i);
 	printk(" %d done.\n",i);
-	return error;
 
+	BUG_ON( i != nr_copy_pages );
+
+	return 0;
 }
 
 extern dev_t __init name_to_dev_t(const char *line);
 
+static int __init read_one_pagedir(suspend_pagedir_t *pgdir, 
+		void *fun, void *arg)
+{
+	int i = *(int *)arg;
+	int max = (int)fun;
+	unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
+	unsigned long next;
+	int error = 0;
+
+	(*(int *)arg) ++;
+	next = pgdir->dummy.val;
+	pr_debug("read_one_pagedir: %p, %d, %lu, %lu\n", pgdir, i, offset, next);
+	if (i == max) return 0;
+	if (offset) 
+		error = bio_read_page(offset, (void *)pgdir);
+	else
+		error = -EFAULT;
+	pgdir->dummy.val = next;
+
+	return (error);
+}
+
 static int __init read_pagedir(void)
 {
-	unsigned long addr;
-	int i, n = swsusp_info.pagedir_pages;
+	int i = 0, n = swsusp_info.pagedir_pages;
 	int error = 0;
 
-	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
-	if (!addr)
+	error = alloc_pagedir(&pagedir_nosave, nr_copy_pages, NULL);
+	if (error < 0)
 		return -ENOMEM;
-	pagedir_nosave = (struct pbe *)addr;
 
 	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);
 
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
-		if (offset)
-			error = bio_read_page(offset, (void *)addr);
-		else
-			error = -EFAULT;
-	}
+	error = for_each_pgdir(pagedir_nosave, read_one_pagedir, (void*)n, &i);
+
+	BUG_ON(i != n);
+
 	if (error)
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		for_each_pgdir(pagedir_nosave, free_one_pagedir, NULL, NULL);
+
 	return error;
 }
 
@@ -1185,7 +1620,7 @@
 	if ((error = read_pagedir()))
 		return error;
 	if ((error = data_read()))
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		for_each_pgdir(pagedir_nosave, free_one_pagedir, NULL, NULL);
 	return error;
 }
 
@@ -1207,7 +1642,7 @@
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		error = read_suspend_image();
-		blkdev_put(resume_bdev);
+		/* blkdev_put(resume_bdev); */
 	} else
 		error = PTR_ERR(resume_bdev);
 
--- linux-2.6.9-ppc-g4-peval/kernel/sys.c	2004-11-22 17:11:35.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/sys.c	2004-11-22 17:16:58.000000000 +0800
@@ -84,7 +84,7 @@
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
+struct notifier_block *reboot_notifier_list;
 rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**
--- linux-2.6.9-ppc-g4-peval/kernel/sysctl.c	2004-11-22 17:08:10.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/sysctl.c	2004-11-23 00:50:29.000000000 +0800
@@ -66,6 +66,10 @@
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 
+#if defined(CONFIG_SOFTWARE_SUSPEND)
+extern int swsusp_pagecache;
+#endif
+
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(__i386__)
 int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
@@ -792,6 +796,18 @@
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
+#if defined(CONFIG_SOFTWARE_SUSPEND)
+	{
+		.ctl_name	= VM_SWSUP_PAGECACHE,
+		.procname	= "swsusp_pagecache",
+		.data		= &swsusp_pagecache,
+		.maxlen		= sizeof(swsusp_pagecache),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+#endif
 	{
 		.ctl_name	= VM_BLOCK_DUMP,
 		.procname	= "block_dump",
--- linux-2.6.9-ppc-g4-peval/include/linux/sysctl.h	2004-11-22 17:08:10.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/include/linux/sysctl.h	2004-11-23 00:48:54.000000000 +0800
@@ -170,6 +170,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_HARDMAPLIMIT=28,	/* Make mapped a hard limit */
+	VM_SWSUP_PAGECACHE=29,	/* Enable/Disable Suspend PageCaches */
 };
 
 

--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
