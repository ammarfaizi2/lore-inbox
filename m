Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbUK0QQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUK0QQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 11:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUK0QQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:16:50 -0500
Received: from [220.248.27.114] ([220.248.27.114]:38365 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261250AbUK0QOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:14:20 -0500
Date: Sun, 28 Nov 2004 00:12:51 +0800
From: hugang@soulinfo.com
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge: 1/51: Device trees
Message-ID: <20041127161251.GA2472@hugang.soulinfo.com>
References: <20041125165413.GB476@openzaurus.ucw.cz> <20041125185304.GA1260@elf.ucw.cz> <1101421336.27250.80.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101421336.27250.80.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 09:22:16AM +1100, Nigel Cunningham wrote:
> Hi.
> 
.......
> 
> There's obviously a misunderstanding here. What I do is:
> 
> SUSPEND all but swap device and parents
> WRITE LRU pages
> SUSPEND swap device and parents (+sysdev)
> Snapshot
> RESUME swap device and parents (+sysdev)
> WRITE snapshot
> SUSPEND swap device and parents
> POWERDOWN everything
> 
> I thought I wrote - perhaps I'm wrong here - that I understand that your
> new work in this area might make this unnecessary. I really only want to
> do it this way because I don't know what other drivers might be doing
> while we're writing the LRU pages. I'm not worried about them touching
> LRU. What I am worried about is them allocating memory and starving
> suspend so that we get hangs due to being oom. If they're suspended, we
> have more certainty as to how memory is being used. I don't remember
> what prompted me to do this in the first place, but I'm pretty sure it
> would have been a real observed issue.
> 

Here is a patch make swsusp1 follow above safe LRU saving, :), Most code merge from 
suspend2, still relative with pavel's big patch.

-core.diff-
diff -urp 2.6.9-lzf/kernel/power/disk.c 2.6.9/kernel/power/disk.c
--- 2.6.9-lzf/kernel/power/disk.c	2004-11-27 17:33:12.000000000 +0800
+++ 2.6.9/kernel/power/disk.c	2004-11-28 00:11:30.000000000 +0800
@@ -16,10 +16,11 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/reboot.h>
 #include <linux/device.h>
 #include "power.h"
 
-
+extern struct partial_device_tree *swsusp_dev_tree;
 extern suspend_disk_method_t pm_disk_mode;
 extern struct pm_ops * pm_ops;
 
@@ -29,6 +30,8 @@ extern int swsusp_read(void);
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
 
+extern int swsusp_prepare_suspend(void);
+extern int swsusp_post_resume(void);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -48,19 +51,20 @@ static void power_down(suspend_disk_meth
 	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_power_down(PMSG_SUSPEND);
+		local_irq_save(flags);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
+		local_irq_restore(flags);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
-		device_shutdown();
+		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
+		device_suspend_tree(PMSG_FREEZE, swsusp_dev_tree);
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
-		device_shutdown();
+		device_suspend_tree(PMSG_FREEZE, swsusp_dev_tree);
 		machine_restart(NULL);
 		break;
 	}
@@ -74,38 +78,6 @@ static void power_down(suspend_disk_meth
 
 static int in_suspend __nosavedata = 0;
 
-
-/**
- *	free_some_memory -  Try to free as much memory as possible
- *
- *	... but do not OOM-kill anyone
- *
- *	Notice: all userland should be stopped at this point, or
- *	livelock is possible.
- */
-
-static void free_some_memory(void)
-{
-	int i;
-	for (i=0; i<5; i++) {
-		int i = 0, tmp;
-		long pages = 0;
-		char *p = "-\\|/";
-
-		printk("Freeing memory...  ");
-		while ((tmp = shrink_all_memory(10000))) {
-			pages += tmp;
-			printk("\b%c", p[i]);
-			i++;
-			if (i > 3)
-				i = 0;
-		}
-		printk("\bdone (%li pages freed)\n", pages);
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ/5);
-	}
-}
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -116,7 +88,7 @@ static inline void platform_finish(void)
 
 static void finish(void)
 {
-	device_resume();
+	swsusp_post_resume();
 	platform_finish();
 	enable_nonboot_cpus();
 	thaw_processes();
@@ -124,7 +96,7 @@ static void finish(void)
 }
 
 
-static int prepare(void)
+static int prepare(int resume)
 {
 	int error;
 
@@ -143,14 +115,11 @@ static int prepare(void)
 		}
 	}
 
-	/* Free memory before shutting down devices. */
-	free_some_memory();
-
 	disable_nonboot_cpus();
-	if ((error = device_suspend(PMSG_FREEZE))) {
-		printk("Some devices failed to suspend\n");
-		goto Finish;
-	}
+	if (!resume)
+		if ((error = swsusp_prepare_suspend())) {
+			goto Finish;
+		}
 
 	return 0;
  Finish:
@@ -176,7 +145,7 @@ int pm_suspend_disk(void)
 {
 	int error;
 
-	if ((error = prepare()))
+	if ((error = prepare(0)))
 		return error;
 
 	pr_debug("PM: Attempting to suspend to disk.\n");
@@ -233,7 +202,7 @@ static int software_resume(void)
 
 	pr_debug("PM: Preparing system for restore.\n");
 
-	if ((error = prepare()))
+	if ((error = prepare(1)))
 		goto Free;
 
 	barrier();
@@ -241,7 +210,7 @@ static int software_resume(void)
 
 	pr_debug("PM: Restoring saved image.\n");
 	swsusp_resume();
-	pr_debug("PM: Restore failed, recovering.n");
+	pr_debug("PM: Restore failed, recovering.\n");
 	finish();
  Free:
 	swsusp_free();
diff -urp 2.6.9-lzf/kernel/power/main.c 2.6.9/kernel/power/main.c
--- 2.6.9-lzf/kernel/power/main.c	2004-11-27 17:33:12.000000000 +0800
+++ 2.6.9/kernel/power/main.c	2004-11-26 00:26:22.000000000 +0800
@@ -4,7 +4,7 @@
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  * 
- * This file is release under the GPLv2
+ * This file is released under the GPLv2
  *
  */
 
diff -urp 2.6.9-lzf/kernel/power/swsusp.c 2.6.9/kernel/power/swsusp.c
--- 2.6.9-lzf/kernel/power/swsusp.c	2004-11-27 17:33:12.000000000 +0800
+++ 2.6.9/kernel/power/swsusp.c	2004-11-28 00:02:05.000000000 +0800
@@ -63,6 +63,7 @@
 #include <linux/console.h>
 #include <linux/highmem.h>
 #include <linux/bio.h>
+#include <linux/preempt.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -74,11 +75,8 @@
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;
 
-/* Variables to be preserved over suspend */
-static int pagedir_order_check;
-
 extern char resume_file[];
-static dev_t resume_device;
+static dev_t swsusp_resume_device;
 /* Local variables that should not be affected by save */
 unsigned int nr_copy_pages __nosavedata = 0;
 
@@ -97,7 +95,6 @@ unsigned int nr_copy_pages __nosavedata 
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -168,10 +165,11 @@ static int is_resume_device(const struct
 	struct inode *inode = file->f_dentry->d_inode;
 
 	return S_ISBLK(inode->i_mode) &&
-		resume_device == MKDEV(imajor(inode), iminor(inode));
+		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
 }
 
-int swsusp_swap_check(void) /* This is called before saving image */
+/* This is called before saving image */
+int swsusp_swap_check(struct partial_device_tree *suspend_device_tree) 
 {
 	int i, len;
 	
@@ -195,6 +193,7 @@ int swsusp_swap_check(void) /* This is c
 				if (is_resume_device(&swap_info[i])) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
+					device_switch_trees((swap_info[i].bdev)->bd_disk->driverfs_dev, suspend_device_tree);
 				} else {
 				  	swapfile_used[i] = SWAPFILE_IGNORED;
 				}
@@ -222,8 +221,105 @@ static void lock_swapdevices(void)
 		}
 	swap_list_unlock();
 }
+	
+#define ONE_PAGE_PBE_NUM	(PAGE_SIZE/sizeof(struct pbe))
+#define PBE_IS_PAGE_END(x)  \
+	( PAGE_SIZE - sizeof(struct pbe) == ((x) - ((~(PAGE_SIZE - 1)) & (x))) )
+
+#define pgdir_for_each_safe(pos, n, head) \
+	for(pos = head, n = pos ? (suspend_pagedir_t*)pos->dummy.val : NULL; \
+		pos != NULL; \
+		pos = n, n = pos ? (suspend_pagedir_t *)pos->dummy.val : NULL)
+
+#define pbe_for_each_safe(pos, n, index, max, head) \
+	for(pos = head, index = 0, \
+			n = pos ? (struct pbe *)pos->dummy.val : NULL; \
+		(pos != NULL) && (index < max); \
+		pos = (PBE_IS_PAGE_END((unsigned long)pos)) ? n : \
+			((struct pbe *)((unsigned long)pos + sizeof(struct pbe))), \
+			index ++, \
+			n = pos ? (struct pbe*)pos->dummy.val : NULL)
+
+/* free pagedir */
+static void pagedir_free(suspend_pagedir_t *head)
+{
+	suspend_pagedir_t *next, *cur;
+	pgdir_for_each_safe(cur, next, head) {
+		free_page((unsigned long)cur);
+	}
+}
+
+/* for_each_pbe_copy_back 
+ *
+ * That usefuly for help us writing the code in assemble code.
+ *
+ */
+/*#define CREATE_ASM_CODE */
+#ifdef CREATE_ASM_CODE
+#if 0
+#define GET_ADDRESS(x) __pa(x) 
+#else
+#define GET_ADDRESS(x) (x)
+#endif
+asmlinkage void for_each_pbe_copy_back(void)
+{
+	struct pbe *pgdir, *next;
+
+	pgdir = pagedir_nosave;
+	while (pgdir != NULL) {
+		unsigned long nums, i;
+		pgdir = (struct pbe *)GET_ADDRESS(pgdir);
+		next = (struct pbe*)pgdir->dummy.val;
+		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++) {
+			register unsigned long *orig, *copy;
+			orig = (unsigned long *)pgdir->orig_address;
+			if (orig == 0) goto end;
+			orig = (unsigned long *)GET_ADDRESS(orig);
+			copy = (unsigned long *)GET_ADDRESS(pgdir->address);
+#if 0
+			memcpy(orig, copy, PAGE_SIZE);
+#else
+			for (i = 0; i < PAGE_SIZE / sizeof(unsigned long); i+=4) {
+				*(orig + i) = *(copy + i);
+				*(orig + i+1) = *(copy + i+1);
+				*(orig + i+2) = *(copy + i+2);
+				*(orig + i+3) = *(copy + i+3);
+			}
+#endif
+			pgdir ++;
+		}
+		pgdir = next;
+	}
+end:
+	panic("just asm code");
+}
+#endif
 
+/*
+ * find_pbe_by_index - 
+ * @pgdir: the pgdir head 
+ * @index: 
+ *
+ * @return: 
+ */
+static struct pbe *find_pbe_by_index(struct pbe *pgdir, int index)
+{
+	unsigned long p = 0;
+	struct pbe *pbe, *next;
 
+	pr_debug("find_pbe_by_index: %p, 0x%03x", pgdir, index); 
+	pgdir_for_each_safe(pbe, next, pgdir) {
+		if (p == index / ONE_PAGE_PBE_NUM) {
+			pbe = (struct pbe *)((unsigned long)pbe + 
+					(index % ONE_PAGE_PBE_NUM) * sizeof(struct pbe));
+			pr_debug(" %p, o{%p} c{%p}\n",
+					pbe, (void*)pbe->orig_address, (void*)pbe->address);
+			return pbe;
+		}
+		p ++;
+	}
+	return (NULL);
+}
 
 /**
  *	write_swap_page - Write one page to a fresh swap location.
@@ -257,7 +353,6 @@ static int write_page(unsigned long addr
 	return error;
 }
 
-
 /**
  *	data_free - Free the swap entries used by the saved image.
  *
@@ -267,43 +362,82 @@ static int write_page(unsigned long addr
 
 static void data_free(void)
 {
-	swp_entry_t entry;
-	int i;
+	int index;
+	struct pbe *pos, *next;
 
-	for (i = 0; i < nr_copy_pages; i++) {
-		entry = (pagedir_nosave + i)->swap_address;
+	pbe_for_each_safe(pos, next, index, nr_copy_pages, pagedir_nosave) {
+		swp_entry_t entry;
+
+		entry = pos->swap_address;
 		if (entry.val)
 			swap_free(entry);
-		else
-			break;
-		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
+		pos->swap_address = (swp_entry_t){0};
 	}
 }
 
+static int mod_progress = 1;
+
+static void inline mod_printk_progress(int i)
+{
+	if (mod_progress == 0) mod_progress = 1;
+	if (!(i%100))
+		printk( "\b\b\b\b%3d%%", i / mod_progress );
+}
+
+static int write_one_pbe(struct pbe *p, void *data, int cur)
+{
+	int error = 0;
+
+	mod_printk_progress(cur);
+
+	pr_debug("write_one_pbe: %p, o{%p} c{%p} %d ",
+			p, (void *)p->orig_address, (void *)p->address, cur);
+	error = write_page((unsigned long)data, &p->swap_address);
+	if (error) return error;
+
+	pr_debug("%lu\n", swp_offset(p->swap_address));
+
+	return 0;
+}
+
+static int bio_read_page(pgoff_t page_off, void * page);
+
+static int read_one_pbe(struct pbe *p, void *data, int cur)
+{
+	int error = 0;
+
+	mod_printk_progress(cur);
+
+	pr_debug("read_one_pbe: %p, o{%p} c{%p} %lu\n",
+			p, (void *)p->orig_address, data, 
+			swp_offset(p->swap_address));
+
+	error = bio_read_page(swp_offset(p->swap_address), data);
+	if (error) return error;
+
+	return 0;
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
+	int error = 0, index;
+	struct pbe *pos, *next;
+	
+	mod_progress = nr_copy_pages / 100;
 
-	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		error = write_page((pagedir_nosave+i)->address,
-					  &((pagedir_nosave+i)->swap_address));
+	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages);
+	pbe_for_each_safe(pos, next, index, nr_copy_pages, pagedir_nosave) {
+		BUG_ON(pos->orig_address == 0);
+		error = write_one_pbe(pos, (void*)pos->address, index);
+		if (error) break;
 	}
 	printk("\b\b\b\bdone\n");
+
 	return error;
 }
 
@@ -363,7 +497,6 @@ static void free_pagedir_entries(void)
 		swap_free(swsusp_info.pagedir[i]);
 }
 
-
 /**
  *	write_pagedir - Write the array of pages holding the page directory.
  *	@last:	Last swap entry we write (needed for header).
@@ -371,15 +504,19 @@ static void free_pagedir_entries(void)
 
 static int write_pagedir(void)
 {
-	unsigned long addr = (unsigned long)pagedir_nosave;
-	int error = 0;
-	int n = SUSPEND_PD_PAGES(nr_copy_pages);
-	int i;
+	int error = 0, n = 0;
+	suspend_pagedir_t *pgdir, *next;
 
-	swsusp_info.pagedir_pages = n;
+	pgdir_for_each_safe(pgdir, next, pagedir_nosave) {
+		error = write_page((unsigned long)pgdir, &swsusp_info.pagedir[n]);
+		if (error) { 
+			break;
+		}
+		n++;
+	} 
 	printk( "Writing pagedir (%d pages)\n", n);
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = write_page(addr, &swsusp_info.pagedir[i]);
+	swsusp_info.pagedir_pages = n;
+
 	return error;
 }
 
@@ -410,7 +547,6 @@ static int write_suspend_image(void)
 	goto Done;
 }
 
-
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
@@ -503,7 +639,526 @@ static int restore_highmem(void)
 #endif
 	return 0;
 }
+struct partial_device_tree *swsusp_dev_tree = NULL;
+
+static int free_suspend_device_tree(void)
+{
+	if (swsusp_dev_tree) {
+		device_merge_tree(swsusp_dev_tree, &default_device_tree);
+		device_destroy_tree(swsusp_dev_tree);
+	}
+	swsusp_dev_tree = NULL;
+	return 0;
+}
+
+static int setup_suspend_device_tree(void)
+{
+	struct class * class = NULL;
+
+	swsusp_dev_tree = device_create_tree();
+	if (IS_ERR(swsusp_dev_tree)) {
+		swsusp_dev_tree = NULL;
+		return -ENOMEM;
+	}
+	/* Now check for graphics class devices, so we can 
+	 * keep the display on while suspending */
+	class = class_find("graphics");
+	if (class) {
+		struct class_device * class_dev;
+		list_for_each_entry(class_dev, &class->children, node)
+			device_switch_trees(class_dev->dev, swsusp_dev_tree);
+		class_put(class);
+	}
+
+	return (0);
+}
+
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
+int swsusp_pagecache = 0;
+
+/* I'll move this to include/linux/page-flags.h */
+#define PG_page_caches (PG_nosave_free + 1)
 
+#define SetPagePcs(page)    set_bit(PG_page_caches, &(page)->flags)
+#define ClearPagePcs(page)  clear_bit(PG_page_caches, &(page)->flags)
+#define PagePcs(page)   test_bit(PG_page_caches, &(page)->flags)
+
+static suspend_pagedir_t *pagedir_cache = NULL;
+static int nr_copy_page_caches = 0;
+
+static int setup_page_caches_pe(struct page *page, int setup)
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
+		return 0;
+	}
+	if (setup) {
+		struct pbe *p = find_pbe_by_index(pagedir_cache, nr_copy_page_caches);
+		BUG_ON(p == NULL);
+		p->address = (long)page_address(page);
+		BUG_ON(p->address == 0);
+		/*pr_debug("setup_page_caches: cur %p, o{%p}, d{%p}, nr %u\n",
+				(void*)p, (void*)p->orig_address,
+				(void*)p->address, nr_copy_page_caches);*/
+		nr_copy_page_caches ++;
+	}
+	SetPagePcs(page);
+
+	return (1);
+}
+
+static int count_page_caches(struct zone *zone, int p)
+{
+	if (swsusp_pagecache)
+		return foreach_zone_page(zone, setup_page_caches_pe, p);
+	return 0;
+}
+
+#define pointer2num(x)  ((x - 0xc0000000) >> 12)
+#define num2pointer(x)  ((x << 12) + 0xc0000000)
+
+static inline void collide_set_bit(unsigned char *bitmap, 
+		unsigned long bitnum)
+{
+	bitnum = pointer2num(bitnum); 
+	bitmap[bitnum / 8] |= (1 << (bitnum%8));
+}
+
+static inline int collide_is_bit_set(unsigned char *bitmap, 
+		unsigned long bitnum)
+{               
+	bitnum = pointer2num(bitnum); 
+	return !!(bitmap[bitnum / 8] & (1 << (bitnum%8)));
+}
+
+static void collide_bitmap_free(unsigned char *bitmap)
+{
+	free_pages((unsigned long)bitmap, 2);
+}
+
+/* 
+ * four pages are enough for bitmap 
+ *
+ */
+static unsigned char *collide_bitmap_init(struct pbe *pgdir)
+{
+	unsigned char *bitmap = 
+		(unsigned char *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 2);
+	struct pbe *next;
+
+	if (bitmap == NULL) {
+		return NULL;
+	}
+	memset(bitmap, 0, 4 * PAGE_SIZE);
+
+	/* do base check */
+	BUG_ON(collide_is_bit_set(bitmap, (unsigned long)bitmap) == 1);
+	collide_set_bit(bitmap, (unsigned long)bitmap);
+	BUG_ON(collide_is_bit_set(bitmap, (unsigned long)bitmap) == 0);
+	
+	while (pgdir != NULL) {
+		unsigned long nums;
+		next = (struct pbe*)pgdir->dummy.val;
+		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++) {
+			collide_set_bit(bitmap, (unsigned long)pgdir);
+			collide_set_bit(bitmap, (unsigned long)pgdir->orig_address);
+			pgdir ++;
+		}
+		pgdir = next;
+	}
+
+	return bitmap;
+}
+static void **eaten_memory = NULL;
+
+static void *swsusp_get_safe_free_page(unsigned char *collide)
+{
+	void *addr = NULL;
+	void **c = eaten_memory;
+
+	do {
+		if (addr) {
+			eaten_memory = (void**)addr;
+			*eaten_memory = c;
+			c = eaten_memory;
+		}
+		addr = (void*)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+		if (!addr) 
+			return NULL;
+	} while (collide && collide_is_bit_set(collide, (unsigned long)addr));
+
+	return addr;
+}
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
+		unsigned char *collide)
+{
+	suspend_pagedir_t *pgdir = NULL;
+	int i;
+
+	pgdir = (suspend_pagedir_t *)swsusp_get_safe_free_page(collide);
+
+	/*pr_debug("pgdir: %p, %p, %d\n", 
+			pgdir, prev, sizeof(suspend_pagedir_t)); */
+	for (i = 0; i < ONE_PAGE_PBE_NUM; i++) {
+		pgdir[i].dummy.val = 0;
+		pgdir[i].address = 0;
+		pgdir[i].orig_address = 0;
+		if (prev)
+			prev[i].dummy.val= (unsigned long)pgdir;
+	}
+
+	return (pgdir);
+}
+
+/* calc_nums - Determine the nums of allocation needed for pagedir_save. */
+static int calc_nums(int nr_copy)
+{
+	int diff = 0, ret = 0;
+	do {
+		diff = (nr_copy / ONE_PAGE_PBE_NUM) - ret + 1;
+		if (diff) {
+			ret += diff;
+			nr_copy += diff;
+		}
+	} while (diff);
+	return nr_copy;
+}
+
+
+/* 
+ * alloc_pagedir 
+ *
+ * @param pbe
+ * @param pbe_nums
+ * @param collide
+ * @param page_nums
+ *
+ */
+static int alloc_pagedir(struct pbe **pbe, int pbe_nums, 
+		unsigned char *collide, int page_nums)
+{
+	unsigned int nums = 0;
+	unsigned int after_alloc = pbe_nums;
+	suspend_pagedir_t *prev = NULL, *cur = NULL;
+
+	if (page_nums)
+		after_alloc = ONE_PAGE_PBE_NUM * page_nums;
+	else 
+		after_alloc = calc_nums(after_alloc);
+
+	pr_debug("alloc_pagedir: %d, %d\n", pbe_nums, after_alloc);
+	for (nums = 0 ; nums < after_alloc ; nums += ONE_PAGE_PBE_NUM) {
+		cur = alloc_one_pagedir(prev, collide);
+		pr_debug("alloc_one_pagedir: %p\n", cur);
+		if (!cur) { /* get page failed */
+			goto no_mem;
+		}
+		if (nums == 0) { /* setup the head */
+			*pbe = cur;
+		}
+		prev = cur;
+	}
+	return after_alloc - pbe_nums;
+
+no_mem:
+	pagedir_free(*pbe);
+	*pbe = NULL;
+
+	return (-ENOMEM);
+}
+
+static char *page_cache_buf = NULL;
+static int alloc_pagecache_buf(void)
+{
+	page_cache_buf = (char *)__get_free_pages(GFP_ATOMIC /*| __GFP_NOWARN*/, 0);
+	if (!page_cache_buf) {
+		/* FIXME try shrink memory */
+		return -ENOMEM;
+	}
+	return 0;
+}
+static int free_pagecache_buf(void)
+{
+	free_page((unsigned long)page_cache_buf);
+	return 0;
+}
+
+int swsusp_post_resume(void)
+{
+	int error = 0, index;
+	struct pbe *pos, *next;
+
+#ifdef CONFIG_PREEMPT
+	preempt_enable();
+#endif
+	if (swsusp_pagecache == 0) {
+		goto end;
+	}
+	
+	local_irq_disable();
+	dpm_power_up_tree(swsusp_dev_tree);
+	local_irq_enable();
+	device_resume_tree(swsusp_dev_tree);
+
+	mod_progress = nr_copy_page_caches / 100;
+
+	printk( "Reading PageCaches from swap (%d pages)...     ", 
+			nr_copy_page_caches);
+	pbe_for_each_safe(pos, next, index, nr_copy_page_caches, 
+			pagedir_cache) {
+		swp_entry_t entry;
+
+		error = read_one_pbe(pos, page_cache_buf, index);
+		if (error) break;
+		memcpy((void*)pos->address, page_cache_buf, PAGE_SIZE);
+		entry = pos->swap_address;
+		if (entry.val)
+			swap_free(entry);
+	}
+	printk("\b\b\b\bdone\n");
+
+	free_pagecache_buf();
+end:
+	local_irq_disable();
+	dpm_power_up_tree(&default_device_tree);
+	local_irq_enable();
+	device_resume_tree(&default_device_tree);
+	device_resume_tree(&default_device_tree);
+	free_suspend_device_tree();
+
+	return error;
+}
+
+static int page_caches_write(void)
+{
+	int error = 0, index;
+	struct pbe *pos, *next;
+	
+	mod_progress = nr_copy_page_caches / 100;
+
+	printk( "Writing PageCaches to swap (%d pages)...     ", 
+			nr_copy_page_caches);
+	pbe_for_each_safe(pos, next, index, nr_copy_page_caches,
+			pagedir_cache) {
+		memcpy(page_cache_buf, (void*)pos->address, PAGE_SIZE);
+		error = write_one_pbe(pos, page_cache_buf, index);
+		if (error) break;
+	}
+	printk("\b\b\b\bdone\n");
+
+	return error;
+}
+
+static int setup_pagedir_pbe(void)
+{
+	struct zone *zone;
+
+	nr_copy_page_caches = 0;
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			count_page_caches(zone, 1);
+		}
+	}
+
+	return 0;
+}
+
+static void count_data_pages(void);
+static int swsusp_alloc(void);
+
+static int page_caches_recal(int resume)
+{
+	struct zone *zone;
+	int i;
+
+	if (swsusp_pagecache == 0 || resume == 1) return 0;
+
+	for (i = 0; i < max_mapnr; i++)
+		ClearPagePcs(mem_map+i);
+
+	nr_copy_page_caches = 0;
+	drain_local_pages();
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			nr_copy_page_caches += count_page_caches(zone, 0);
+		}
+	}
+	i = calc_nums(nr_copy_page_caches);
+
+	return (i / ONE_PAGE_PBE_NUM + 1);
+}
+
+static int inline swsusp_need_pages(int resume)
+{
+	return nr_copy_pages + page_caches_recal(resume) + PAGES_FOR_IO;
+}
+
+static int swsusp_check_memory(int resume)
+{
+	int retry = 10 * 5; /* wait no memory can swap for 20 sec */
+
+	if (!resume) {
+		count_data_pages();
+	}
+
+	printk("swsusp: need %d pages, freed %d pages, shrinking         ", 
+			swsusp_need_pages(resume), nr_free_pages());
+	if (nr_free_pages() > swsusp_need_pages(resume)) {
+		printk(" done\n");
+		return 0;
+	}
+
+	do {
+		int diff = swsusp_need_pages(resume) - nr_free_pages();
+		
+		if (diff < 0) break;
+		if (shrink_all_memory(diff * 2) == 0) {
+			retry --;
+		}
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ/5);
+		if (!resume) {
+			drain_local_pages();
+			count_data_pages();
+		}
+		printk("\b\b\b\b\b%5d", diff);
+	} while (retry);
+
+	printk("\nswsusp: need %d pages, freed %d pages ... ", 
+			swsusp_need_pages(resume), nr_free_pages());
+
+	if (nr_free_pages() < swsusp_need_pages(resume)) {
+		printk("  failed\n");
+		return -ENOMEM;
+	} 
+	printk("   done\n");
+
+	return 0;
+}
+
+int swsusp_prepare_suspend(void)
+{
+	int error = 0;
+
+	if ((error = setup_suspend_device_tree())) {
+		return error;
+	}
+	if (swsusp_check_memory(0)) {
+		free_suspend_device_tree();
+		return -ENOMEM;
+	}
+	/* exept swap device and parent from the tree */
+	if ((error = swsusp_swap_check(swsusp_dev_tree))) {
+		free_suspend_device_tree();
+		return error;
+	}
+
+	/* power all device execpt swap device and the parent */
+	BUG_ON(irqs_disabled());
+	device_suspend_tree(PMSG_FREEZE, &default_device_tree);
+	local_irq_disable();
+	device_power_down_tree(PMSG_FREEZE, &default_device_tree);
+	local_irq_enable();
+
+	if (swsusp_pagecache) {
+		if ((error = alloc_pagecache_buf())) {
+			swsusp_pagecache = 0;
+		}
+	}
+	if (swsusp_pagecache) {
+		if (alloc_pagedir(&pagedir_cache, nr_copy_page_caches, NULL, 0) < 0)
+			swsusp_pagecache = 0;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	error = swsusp_alloc();
+	if (error) {
+		printk("swsusp_alloc failed, %d\n", error);
+		free_suspend_device_tree();
+		return error;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp: need to copy %u pages, %u page_caches\n",
+			nr_copy_pages, nr_copy_page_caches);
+
+	if (swsusp_pagecache) {
+		setup_pagedir_pbe();
+		pr_debug("after setup_pagedir_pbe \n");
+
+		error = page_caches_write();
+		if (error)  {
+			free_suspend_device_tree();
+			return error;
+		}
+	}
+
+	return 0;
+}
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -539,7 +1194,10 @@ static int saveable(struct zone * zone, 
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
 
@@ -559,12 +1217,10 @@ static void count_data_pages(void)
 	}
 }
 
-
 static void copy_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe * pbe = pagedir_nosave;
 	int pages_copied = 0;
 	
 	for_each_zone(zone) {
@@ -574,11 +1230,16 @@ static void copy_data_pages(void)
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page * page;
+				struct pbe * pbe = find_pbe_by_index(pagedir_nosave, 
+						pages_copied);
+				BUG_ON(pbe == NULL);
+				if (pbe->address == 0) 
+					panic("copy_data_pages: %d copied\n", pages_copied);
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				pbe->orig_address = (long) page_address(page);
+				BUG_ON(pbe->orig_address == 0);
 				/* copy_page is not usable for copying task structs. */
 				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-				pbe++;
 				pages_copied++;
 			}
 		}
@@ -587,85 +1248,18 @@ static void copy_data_pages(void)
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
-{
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
-}
-
-
-/**
- *	alloc_pagedir - Allocate the page directory.
- *
- *	First, determine exactly how many contiguous pages we need and
- *	allocate them.
- */
-
-static int alloc_pagedir(void)
-{
-	calc_order();
-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
-							     pagedir_order);
-	if (!pagedir_save)
-		return -ENOMEM;
-	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
-	pagedir_nosave = pagedir_save;
-	return 0;
-}
-
 /**
  *	free_image_pages - Free pages allocated for snapshot
  */
-
 static void free_image_pages(void)
 {
-	struct pbe * p;
-	int i;
+	struct pbe *pos, *next;
+	int index;
 
-	p = pagedir_save;
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
-		if (p->address) {
-			ClearPageNosave(virt_to_page(p->address));
-			free_page(p->address);
-			p->address = 0;
-		}
+	pbe_for_each_safe(pos, next, index, nr_copy_pages, pagedir_save) {
+		ClearPageNosave(virt_to_page(pos->address));
+		free_page(pos->address);
+		pos->address = 0;
 	}
 }
 
@@ -673,17 +1267,16 @@ static void free_image_pages(void)
  *	alloc_image_pages - Allocate pages for the snapshot.
  *
  */
-
 static int alloc_image_pages(void)
 {
-	struct pbe * p;
-	int i;
+	struct pbe *pos, *next;
+	int index;
 
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if (!p->address)
+	pbe_for_each_safe(pos, next, index, nr_copy_pages, pagedir_save) {
+		pos->address = (unsigned long)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		if (!pos->address)
 			return -ENOMEM;
-		SetPageNosave(virt_to_page(p->address));
+		SetPageNosave(virt_to_page(pos->address));
 	}
 	return 0;
 }
@@ -693,28 +1286,9 @@ void swsusp_free(void)
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
-	free_pages((unsigned long) pagedir_save, pagedir_order);
+	pagedir_free(pagedir_save);
 }
 
-
-/**
- *	enough_free_mem - Make sure we enough free memory to snapshot.
- *
- *	Returns TRUE or FALSE after checking the number of available 
- *	free pages.
- */
-
-static int enough_free_mem(void)
-{
-	if (nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
-		pr_debug("swsusp: Not enough free pages: Have %d\n",
-			 nr_free_pages());
-		return 0;
-	}
-	return 1;
-}
-
-
 /**
  *	enough_swap - Make sure we have enough swap to save the image.
  *
@@ -730,7 +1304,7 @@ static int enough_swap(void)
 	struct sysinfo i;
 
 	si_swapinfo(&i);
-	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
+	if (i.freeswap < (nr_copy_pages + nr_copy_page_caches + PAGES_FOR_IO))  {
 		pr_debug("swsusp: Not enough swap. Need %ld\n",i.freeswap);
 		return 0;
 	}
@@ -741,34 +1315,30 @@ static int swsusp_alloc(void)
 {
 	int error;
 
-	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
-		 nr_copy_pages, PAGES_FOR_IO, nr_free_pages());
-
 	pagedir_nosave = NULL;
-	if (!enough_free_mem())
-		return -ENOMEM;
 
 	if (!enough_swap())
 		return -ENOSPC;
-
-	if ((error = alloc_pagedir())) {
-		pr_debug("suspend: Allocating pagedir failed.\n");
-		return error;
+	error = alloc_pagedir(&pagedir_save, nr_copy_pages, NULL, 0);
+	if (error < 0) {
+		printk("suspend: Allocating pagedir failed.\n");
+		return -ENOMEM;
 	}
+	pr_debug("alloc_pagedir: addon %d\n", error);
+	nr_copy_pages += error;
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
-	unsigned int nr_needed_pages;
-	int error;
+	BUG_ON(!irqs_disabled());
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -777,15 +1347,6 @@ int suspend_prepare_image(void)
 		return -ENOMEM;
 	}
 
-	drain_local_pages();
-	count_data_pages();
-	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
-	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
-
-	error = swsusp_alloc();
-	if (error)
-		return error;
-	
 	/* During allocating of suspend pagedir, new cold pages may appear. 
 	 * Kill them.
 	 */
@@ -811,7 +1372,6 @@ int suspend_prepare_image(void)
 int swsusp_write(void)
 {
 	int error;
-	device_resume();
 	lock_swapdevices();
 	error = write_suspend_image();
 	/* This will unlock ignored swap devices since writing is finished */
@@ -820,17 +1380,11 @@ int swsusp_write(void)
 
 }
 
-
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
-
 asmlinkage int swsusp_save(void)
 {
-	int error = 0;
-
-	if ((error = swsusp_swap_check()))
-		return error;
 	return suspend_prepare_image();
 }
 
@@ -839,34 +1393,66 @@ int swsusp_suspend(void)
 	int error;
 	if ((error = arch_prepare_suspend()))
 		return error;
+
+	BUG_ON(irqs_disabled());
+	/* suspend swap device */
+	device_suspend_tree(PMSG_FREEZE, swsusp_dev_tree);
+
+	mb();
+	barrier();
+
+#ifdef CONFIG_PREEMPT
+	preempt_disable();
+#endif
 	local_irq_disable();
+	device_power_down_tree(PMSG_FREEZE, swsusp_dev_tree);
 	sysdev_suspend(PMSG_FREEZE);
+
 	save_processor_state();
 	error = swsusp_arch_suspend();
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	restore_highmem();
+
+	BUG_ON(!irqs_disabled());
 	sysdev_resume();
+	
+	dpm_power_up_tree(swsusp_dev_tree);
 	local_irq_enable();
+	device_resume_tree(swsusp_dev_tree);
+
 	return error;
 }
 
 
 asmlinkage int swsusp_restore(void)
 {
-	BUG_ON (pagedir_order_check != pagedir_order);
-	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
 	__flush_tlb_global();
 	wbinvd();	/* Nigel says wbinvd here is good idea... */
+#endif
 	return 0;
 }
 
 int swsusp_resume(void)
 {
 	int error;
+
+	/* power all device execpt swap device and the parent */
+	BUG_ON(irqs_disabled());
+	device_suspend_tree(PMSG_FREEZE, &default_device_tree);
+	local_irq_disable();
+	device_power_down_tree(PMSG_FREEZE, &default_device_tree);
+	local_irq_enable();
+
+#ifdef CONFIG_PREEMPT
+	preempt_disable();
+#endif
+	
 	local_irq_disable();
 	sysdev_suspend(PMSG_FREEZE);
+
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
@@ -881,99 +1467,6 @@ int swsusp_resume(void)
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
@@ -1038,12 +1531,12 @@ static int submit(int rw, pgoff_t page_o
 	return error;
 }
 
-int bio_read_page(pgoff_t page_off, void * page)
+static int bio_read_page(pgoff_t page_off, void * page)
 {
 	return submit(READ, page_off, page);
 }
 
-int bio_write_page(pgoff_t page_off, void * page)
+static int bio_write_page(pgoff_t page_off, void * page)
 {
 	return submit(WRITE, page_off, page);
 }
@@ -1088,7 +1581,6 @@ static int __init check_header(void)
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1115,62 +1607,167 @@ static int __init check_sig(void)
 	return error;
 }
 
+
+static void __init eat_progress(void)
+{
+	char *eaten_progess = "-\\|/";
+	static int eaten_i = 0;
+
+	printk("\b%c", eaten_progess[eaten_i]);
+	eaten_i ++;
+	if (eaten_i > 3) eaten_i = 0;
+}
+
+static int __init check_one_pbe(struct pbe *p, void *collide, int cur)
+{
+	unsigned long addr = 0;
+
+	pr_debug("check_one_pbe: %p %lu o{%p} ", 
+			p, p->swap_address.val, (void*)p->orig_address);
+	addr = (unsigned long)swsusp_get_safe_free_page(collide);
+	if(!addr)
+		return -ENOMEM;
+	pr_debug("c{%p} done\n", (void*)addr);
+	p->address = addr;
+
+	return 0;
+}
+
+static void __init swsusp_copy_pagedir(suspend_pagedir_t *d_pgdir, 
+		suspend_pagedir_t *s_pgdir)
+{
+	int i = 0;
+
+	while (s_pgdir != NULL) {
+		suspend_pagedir_t *s_next = (suspend_pagedir_t *)s_pgdir->dummy.val;
+		suspend_pagedir_t *d_next = (suspend_pagedir_t *)d_pgdir->dummy.val;
+		for (i = 0; i < ONE_PAGE_PBE_NUM; i++) {
+			d_pgdir->address = s_pgdir->address;
+			d_pgdir->orig_address = s_pgdir->orig_address;
+			d_pgdir->swap_address = s_pgdir->swap_address;
+			s_pgdir ++; d_pgdir ++;
+		}
+		d_pgdir = d_next;
+		s_pgdir = s_next;
+	};
+}
+/*
+ * We check here that pagedir & pages it points to won't collide with pages
+ * where we're going to restore from the loaded pages later
+ */
+static int __init check_pagedir(void)
+{
+	void **c, *f;
+	struct pbe *next, *pos;
+	int error, index;
+	suspend_pagedir_t *addr = NULL;
+	unsigned char *bitmap = collide_bitmap_init(pagedir_nosave);
+	
+	BUG_ON(bitmap == NULL);
+
+	printk("Relocating pagedir ... ");
+	error = alloc_pagedir(&addr, nr_copy_pages, bitmap, 
+			swsusp_info.pagedir_pages);
+	if (error < 0) {
+		return error;
+	}
+	swsusp_copy_pagedir(addr, pagedir_nosave);
+	pagedir_free(pagedir_nosave);
+
+	/* check copy address */
+	pbe_for_each_safe(pos, next, index, nr_copy_pages, addr) {
+		error = check_one_pbe(pos, bitmap, index);
+		BUG_ON(error);
+	}
+
+	/* free eaten memory */
+	c = eaten_memory;
+	while (c) {
+		eat_progress();
+		f = c;
+		c = *c;
+		free_pages((unsigned long)f, 0);
+	}
+	/* free unused memory */
+	collide_bitmap_free(bitmap);
+	printk("     done\n");
+		
+	pagedir_nosave = addr;
+
+	return 0;
+}
+
 /**
  *	swsusp_read_data - Read image pages from swap.
  *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
  */
-
 static int __init data_read(void)
 {
-	struct pbe * p;
-	int error;
-	int i;
-	int mod = nr_copy_pages / 100;
-
-	if (!mod)
-		mod = 1;
+	int error = 0, index;
+	struct pbe *pos, *next;
 
-	if ((error = swsusp_pagedir_relocate()))
+	if ((error = swsusp_check_memory(1))) {
 		return error;
+	}
+
+	if ((error = check_pagedir())) {
+		return -ENOMEM;
+	}
+
+	mod_progress = nr_copy_pages / 100;
 
 	printk( "Reading image data (%d pages):     ", nr_copy_pages );
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		error = bio_read_page(swp_offset(p->swap_address),
-				  (void *)p->address);
+	pbe_for_each_safe(pos, next, index, nr_copy_pages, pagedir_nosave) {
+		error = read_one_pbe(pos, (void*)pos->address, index);
+		if (error) break;
 	}
-	printk(" %d done.\n",i);
-	return error;
+	printk(" %d done.\n", index);
 
+	return error;
 }
 
 extern dev_t __init name_to_dev_t(const char *line);
 
-static int __init read_pagedir(void)
+static int __init read_one_pagedir(suspend_pagedir_t *pgdir, int i)
 {
-	unsigned long addr;
-	int i, n = swsusp_info.pagedir_pages;
+	unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
+	unsigned long next;
 	int error = 0;
 
-	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
-	if (!addr)
-		return -ENOMEM;
-	pagedir_nosave = (struct pbe *)addr;
+	next = pgdir->dummy.val;
+	pr_debug("read_one_pagedir: %p, %d, %lu, %p\n", 
+			pgdir, i, offset, (void*)next);
+	if ((error = bio_read_page(offset, (void *)pgdir))) {
+		return error;
+	}
+	pgdir->dummy.val = next;
 
-	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);
+	return error;
+}
 
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
-		if (offset)
-			error = bio_read_page(offset, (void *)addr);
-		else
-			error = -EFAULT;
-	}
-	if (error)
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+/*
+ * reading pagedir from swap device 
+ */
+static int __init read_pagedir(void)
+{
+	int i = 0, n = swsusp_info.pagedir_pages;
+	int error = 0;
+	suspend_pagedir_t *pgdir, *next;
+	
+	error = alloc_pagedir(&pagedir_nosave, nr_copy_pages, NULL, n);
+	if (error < 0)
+		return -ENOMEM;
+
+	printk("pmdisk: Reading pagedir (%d Pages)\n",n);
+	pgdir_for_each_safe(pgdir, next, pagedir_nosave) {
+		error = read_one_pagedir(pgdir, i);
+		if (error) break;
+		i++;
+	}
+	BUG_ON(i != n);
+	if (error)	
+		pagedir_free(pagedir_nosave);
+	
 	return error;
 }
 
@@ -1185,7 +1782,7 @@ static int __init read_suspend_image(voi
 	if ((error = read_pagedir()))
 		return error;
 	if ((error = data_read()))
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		pagedir_free(pagedir_nosave);
 	return error;
 }
 
@@ -1200,14 +1797,14 @@ int __init swsusp_read(void)
 	if (!strlen(resume_file))
 		return -ENOENT;
 
-	resume_device = name_to_dev_t(resume_file);
+	swsusp_resume_device = name_to_dev_t(resume_file);
 	pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
 
-	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
+	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		error = read_suspend_image();
-		blkdev_put(resume_bdev);
+		/* blkdev_put(resume_bdev); */
 	} else
 		error = PTR_ERR(resume_bdev);
 

--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
