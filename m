Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUKXILL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUKXILL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUKXILL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:11:11 -0500
Received: from [220.248.27.114] ([220.248.27.114]:52402 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261237AbUKXIIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:08:20 -0500
Date: Wed, 24 Nov 2004 16:02:57 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATH] 11-24 swsusp update 1/3
Message-ID: <20041124080256.GA3455@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <20041122165823.GA10609@hugang.soulinfo.com> <20041123221430.GF25926@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123221430.GF25926@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 11:14:30PM +0100, Pavel Machek wrote:
> > @@ -48,14 +51,16 @@
> >  	unsigned long flags;
> >  	int error = 0;
> >  
> > -	local_irq_save(flags);
> >  	switch(mode) {
> >  	case PM_DISK_PLATFORM:
> > - 		device_power_down(PMSG_SUSPEND);
> > + 		/* device_power_down(PMSG_SUSPEND); */
> > +		local_irq_save(flags);
> >  		error = pm_ops->enter(PM_SUSPEND_DISK);
> > +		local_irq_restore(flags);
> >  		break;
> >  	case PM_DISK_SHUTDOWN:
> >  		printk("Powering off system\n");
> > +		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
> >  		device_shutdown();
> >  		machine_power_off();
> >  		break;
> 
> Either drop this one or explain why it is good idea. It seems to be
> independend on the rest.
This code I just copy from old ppc swsusp port, I don't why, :).

> 
> > @@ -144,9 +151,13 @@
> >  	}
> >  
> >  	/* Free memory before shutting down devices. */
> > -	free_some_memory();
> > +	/* free_some_memory(); */
> 
> Needs to be if (!swsusp_pagecache), right?
I think we can drop this one, In write_page_caches has same code, and do
the best.

 > +			if (swsusp_pbe_pgdir->orig_address == 0) return;
> > +			for (i = 0; i < PAGE_SIZE / (sizeof(unsigned long)); i+=4) {
> > +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i)) = 
> > +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i));
> > +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+1)) = 
> > +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+1));
> > +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+2)) = 
> > +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+2));
> > +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+3)) = 
> > +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+3));
> 
> Do you really have to do manual loop unrolling? Why can't C code be
> same for i386 and ppc?
here is stupid code, update in my new patch, I using memcopy in i386, it 
create small assemble code.

> >  
> >  	if (!enough_swap())
> >  		return -ENOSPC;
> > -
> > -	if ((error = alloc_pagedir())) {
> > -		pr_debug("suspend: Allocating pagedir failed.\n");
> > -		return error;
> > +	error = alloc_pagedir(&pagedir_save, nr_copy_pages, NULL);
> > +	if (error < 0) {
> > +		printk("suspend: Allocating pagedir failed.\n");
> > +		return -ENOMEM;
> 
> Hmm, I liked previous code better. Plus you throw out error
> information and just return -ENOMEM, always. 
Ok, It backed.

> 
> > @@ -854,11 +1321,11 @@
> >  
> >  asmlinkage int swsusp_restore(void)
> >  {
> > -	BUG_ON (pagedir_order_check != pagedir_order);
> > -	
> >  	/* Even mappings of "global" things (vmalloc) need to be fixed */
> > +#if defined(CONFIG_X86) && defined(CONFIG_X86_64)
> >  	__flush_tlb_global();
> >  	wbinvd();	/* Nigel says wbinvd here is good idea... */
> > +#endif
> 
> This is needed on i386, too... Okay, wbinvd probably can go... or do
> we have some good arch-neutral wbinvd-like thing?
> > @@ -993,7 +1367,7 @@
> >  	return 0;
> >  }
> >  
> > -static struct block_device * resume_bdev;
> > +static struct block_device * resume_bdev __nosavedata;
> >  
I'll re think.

> 
> Why?
> 
> > +	return (0);
> 
> Please avoid "return (0);". Using "return 0;" will do just fine.
fixed.

here is my patch relative with your big diff, hope can merge. 

- correct relocating pages, that's every important, now new swsusp seem 
  stable for me.
- corrent calc_num.
- adding some comments, sorry for my stupid english.
- improvment i386 copy back code.

---core.diff--
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
+++ linux-2.6.9-ppc-g4-peval-hg/include/linux/suspend.h	2004-11-24 15:48:05.000000000 +0800
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#ifdef CONFIG_X86
+#if (definedCONFIG_X86) || (defined CONFIG_PPC32)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
--- linux-2.6.9-ppc-g4-peval/kernel/power/disk.c	2004-11-22 17:11:35.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/disk.c	2004-11-24 14:33:26.000000000 +0800
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
@@ -117,6 +123,7 @@
 static void finish(void)
 {
 	device_resume();
+	read_page_caches();
 	platform_finish();
 	enable_nonboot_cpus();
 	thaw_processes();
@@ -124,7 +131,7 @@
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
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/swsusp.c	2004-11-24 15:49:51.000000000 +0800
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
 
@@ -223,7 +219,146 @@
 	swap_list_unlock();
 }
 
+#define ONE_PAGE_PBE_NUM	(PAGE_SIZE/sizeof(struct pbe))
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
+		/* pr_debug("for_each_pgdir: cur %p next %p\n", pgdir, next); */
+		error = fun(pgdir, subfun, arg);
+		if (error) return error;
+		pgdir = next;
+	}
+
+	return error;
+}
 
+/* free one pagedir */
+static int free_one_pagedir(suspend_pagedir_t *pgdir, void *fun, void *arg)
+{
+	free_page((unsigned long)pgdir);
+	return 0;
+}
+
+/* 
+ * swsup_pbe_t
+ *
+ * a callback funtion in foreach pbe loop.
+ *
+ * @param pbe  pointer of current pbe
+ * @param p    private data 
+ * @param cur  current index
+ *
+ * @return  0 is ok, otherwise 
+ */
+ 
+typedef int (*swsup_pbe_t)(struct pbe *bpe, void *p, int cur);
+
+/*
+ * for_each_pbe 
+ *
+ * @param pbe pointer of the pbe head 
+ * @param fun callback function
+ * @param p   private data 
+ * @param max max the the pbe numbers
+ *
+ * @return 0 is ok, otherwise
+ */
+static int for_each_pbe(struct pbe *pbe, swsup_pbe_t fun, void *p, int max)
+{
+	struct pbe *pgdir = pbe, *next = NULL;
+	unsigned long i = 0;
+	int error = 0;
+
+	while (pgdir != NULL) {
+		unsigned long nums;
+		next = (struct pbe*)pgdir->dummy.val;
+		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++, pgdir++, i ++) {
+			if (i == max) { /* end */
+				return 0;
+			}
+			if((error = fun(pgdir, p, i))) { /* got error */
+				return error;
+			}
+		}
+		pgdir = next;
+	}
+	return (error);
+}
+/* for_each_pbe_copy_back 
+ *
+ * That usefuly for  writing the code in assemble code.
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
+
+static int find_bpe_index(struct pbe *p, void *tmp, int cur)
+{
+	if (*(int *)tmp == cur) {
+		*(struct pbe **)tmp = p;
+		return (1);
+	}
+	return 0;
+}
+
+static struct pbe *find_pbe_by_index(struct pbe *pgdir, int index, int max)
+{
+	unsigned long p = index;
+
+	/* pr_debug("find_pbe_by_index: %p, %d, %d ", pgdir, index, max); */
+	if (for_each_pbe(pgdir, find_bpe_index, &p, max) == 1) {
+		/* pr_debug("%p\n", (void*)p); */
+		return ((struct pbe *)p);
+	} 
+	return (NULL);
+}
 
 /**
  *	write_swap_page - Write one page to a fresh swap location.
@@ -257,6 +392,17 @@
 	return error;
 }
 
+static int data_free_pbe(struct pbe *p, void *tmp, int cur)
+{
+	swp_entry_t entry;
+
+	entry = p->swap_address;
+	if (entry.val)
+		swap_free(entry);
+	p->swap_address = (swp_entry_t){0};
+
+	return 0;
+}
 
 /**
  *	data_free - Free the swap entries used by the saved image.
@@ -267,43 +413,50 @@
 
 static void data_free(void)
 {
-	swp_entry_t entry;
-	int i;
+	for_each_pbe(pagedir_nosave, data_free_pbe, NULL, nr_copy_pages);
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
 
+static int write_one_pbe(struct pbe *p, void *tmp, int cur)
+{
+	int error = 0;
+
+	BUG_ON(p->address == 0);
+	BUG_ON(p->orig_address == 0);
+	if ((error = write_page(p->address, &p->swap_address))) {
+		return error;
+	}
+	mod_printk_progress(cur);
+	pr_debug("write_one_pbe: %p, o{%p} c{%p} %lu %d\n", p, 
+			(void *)p->orig_address, (void *)p->address,
+			p->swap_address.val, cur); 
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
+	int error;
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
+	error = for_each_pbe(pagedir_nosave, write_one_pbe, NULL, nr_copy_pages);
 	printk("\b\b\b\bdone\n");
+
 	return error;
 }
 
@@ -363,6 +516,18 @@
 		swap_free(swsusp_info.pagedir[i]);
 }
 
+static int write_one_pagedir(suspend_pagedir_t *pgdir, void *fun, void *arg)
+{
+	int i = *(int *)arg;
+	int error;
+
+	if ((error = write_page((unsigned long)pgdir, &swsusp_info.pagedir[i]))) {
+		return (error);
+	} 
+	(*(int *)arg) ++;
+
+	return 0;
+}
 
 /**
  *	write_pagedir - Write the array of pages holding the page directory.
@@ -371,15 +536,12 @@
 
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
 
@@ -504,6 +666,417 @@
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
+int swsusp_pagecache = 0;
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
+static void lock_pagecaches(void)
+{
+	struct zone *zone;
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			spin_lock_irq(&zone->lru_lock);
+		}
+	}
+}
+
+static void unlock_pagecaches(void)
+{
+	struct zone *zone;
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			spin_unlock_irq(&zone->lru_lock);
+		}
+	}
+}
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
+		return 0;
+	}
+	if (setup) {
+		struct pbe *p = find_pbe_by_index(pagedir_cache, nr_copy_pcs, -1);
+		BUG_ON(p == NULL);
+		p->address = (long)page_address(page);
+		BUG_ON(p->address == 0);
+		/*pr_debug("setup_pcs: cur %p, o{%p}, d{%p}, nr %u\n",
+				(void*)p, (void*)p->orig_address,
+				(void*)p->address, nr_copy_pcs);*/
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
+	return 0;
+}
+
+/* 
+ * check the address in pbe list
+ */
+static int check_pbe_addr(struct pbe *p, void *addr, int cur)
+{
+	unsigned long addre = (unsigned long)addr + PAGE_SIZE;
+	BUG_ON(p->orig_address == 0);
+	if (p->orig_address >= (unsigned long)addr && p->orig_address < addre)
+		return 1;
+	return 0;
+}
+
+static int check_collide(struct pbe *old, int max, void *addr)
+{
+	return (for_each_pbe(old, check_pbe_addr, addr, max));
+}
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
+		while (check_collide((struct pbe *)collide, nr_copy_pages, pgdir)) {
+			/* free_page((unsigned long)pgdir); */
+			pgdir = (suspend_pagedir_t *)
+				__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+			if (!pgdir) {
+				return NULL;
+			}
+		}
+	}
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
+		struct pbe *collide, int page_nums)
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
+	for_each_pgdir(*pbe, free_one_pagedir, NULL, NULL);
+	*pbe = NULL;
+
+	return (-ENOMEM);
+}
+
+static int bio_read_page(pgoff_t page_off, void * page);
+
+static int pagecache_read_pbe(struct pbe *p, void *tmp, int cur)
+{
+	int error = 0;
+	swp_entry_t entry;
+
+	mod_printk_progress(cur);
+
+	pr_debug("pagecache_read_pbe: %p, o{%p} c{%p} %lu\n",
+			p, (void *)p->orig_address, (void *)p->address, 
+			swp_offset(p->swap_address));
+
+	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	if (error) return error;
+
+	entry = p->swap_address;
+	if (entry.val)
+		swap_free(entry);
+
+	return 0;
+}
+
+int read_page_caches(void)
+{
+	int error = 0;
+
+	if (swsusp_pagecache == 0) return 0;
+
+	mod_progress = nr_copy_pcs / 100;
+
+	printk( "Reading PageCaches from swap (%d pages)...     ", nr_copy_pcs);
+	error = for_each_pbe(pagedir_cache, pagecache_read_pbe, NULL,
+			nr_copy_pcs);
+	printk("\b\b\b\bdone\n");
+
+	unlock_pagecaches();
+	for_each_pgdir(pagedir_cache, free_one_pagedir, NULL, NULL);
+
+	return error;
+}
+
+static int pagecache_write_pbe(struct pbe *p, void *tmp, int cur)
+{
+	int error = 0;
+
+	mod_printk_progress(cur);
+
+	pr_debug("pagecache_write_pbe: %p, o{%p} c{%p} %d ",
+			p, (void *)p->orig_address, (void *)p->address, cur);
+	BUG_ON(p->address == 0);
+	error = write_page(p->address, &p->swap_address);
+	if (error) return error;
+
+	pr_debug("%lu\n", swp_offset(p->swap_address));
+
+	return 0;
+}
+
+static int page_caches_write(void)
+{
+	int error;
+	
+	mod_progress = nr_copy_pcs / 100;
+
+	lock_pagecaches();
+	printk( "Writing PageCaches to swap (%d pages)...     ", nr_copy_pcs);
+	error = for_each_pbe(pagedir_cache, pagecache_write_pbe, NULL, 
+			nr_copy_pcs);
+	printk("\b\b\b\bdone\n");
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
+	return 0;
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
+	if ((error = swsusp_swap_check())) {
+		/* FIXME free pagedir_cache */
+		return error;
+	}
+
+	if (swsusp_pagecache) {
+		page_caches_recal();
+
+		if (nr_copy_pcs == 0) {
+			return 0;
+		}
+		printk("swsusp: Need to copy %u pcs\n", nr_copy_pcs);
+		if (alloc_pagedir(&pagedir_cache, nr_copy_pcs, NULL, 0) < 0) {
+			return -ENOMEM;
+		}
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
+		error = page_caches_write();
+		if (error) 
+			return error;
+	}
+
+	return 0;
+}
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -539,7 +1112,10 @@
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
 
@@ -549,10 +1125,12 @@
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
@@ -564,7 +1142,6 @@
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe * pbe = pagedir_nosave;
 	int pages_copied = 0;
 	
 	for_each_zone(zone) {
@@ -574,11 +1151,14 @@
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page * page;
+				struct pbe * pbe = find_pbe_by_index(pagedir_nosave, 
+						pages_copied, nr_copy_pages);
+				BUG_ON(pbe == NULL);
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				pbe->orig_address = (long) page_address(page);
+				BUG_ON(pbe->orig_address == 0);
 				/* copy_page is not usable for copying task structs. */
 				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-				pbe++;
 				pages_copied++;
 			}
 		}
@@ -587,105 +1167,38 @@
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
+static int free_one_snapshot_pbe(struct pbe *p, void *tmp, int cur)
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
+	ClearPageNosave(virt_to_page(p->address));
+	free_page(p->address);
+	p->address = 0;
 	return 0;
 }
 
 /**
  *	free_image_pages - Free pages allocated for snapshot
  */
-
 static void free_image_pages(void)
 {
-	struct pbe * p;
-	int i;
-
-	p = pagedir_save;
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
-		if (p->address) {
-			ClearPageNosave(virt_to_page(p->address));
-			free_page(p->address);
-			p->address = 0;
-		}
-	}
+	for_each_pbe(pagedir_save, free_one_snapshot_pbe, NULL, nr_copy_pages);
 }
 
+static int alloc_one_snapshot_pbe(struct pbe *p, void *tmp, int cur)
+{
+	p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	if (!p->address)
+		return -ENOMEM;
+	SetPageNosave(virt_to_page(p->address));
+	return 0;
+}
 /**
  *	alloc_image_pages - Allocate pages for the snapshot.
  *
  */
-
 static int alloc_image_pages(void)
 {
-	struct pbe * p;
-	int i;
-
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if (!p->address)
-			return -ENOMEM;
-		SetPageNosave(virt_to_page(p->address));
-	}
-	return 0;
+	return for_each_pbe(pagedir_save, alloc_one_snapshot_pbe, NULL,
+			nr_copy_pages);
 }
 
 void swsusp_free(void)
@@ -693,7 +1206,7 @@
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
-	free_pages((unsigned long) pagedir_save, pagedir_order);
+	for_each_pgdir(pagedir_save, free_one_pagedir, NULL, NULL);
 }
 
 
@@ -730,7 +1243,7 @@
 	struct sysinfo i;
 
 	si_swapinfo(&i);
-	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
+	if (i.freeswap < (nr_copy_pages + nr_copy_pcs + PAGES_FOR_IO))  {
 		pr_debug("swsusp: Not enough swap. Need %ld\n",i.freeswap);
 		return 0;
 	}
@@ -750,25 +1263,26 @@
 
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
 	unsigned int nr_needed_pages;
-	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -777,15 +1291,8 @@
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
@@ -827,10 +1334,10 @@
 
 asmlinkage int swsusp_save(void)
 {
-	int error = 0;
+/*	int error = 0;
 
 	if ((error = swsusp_swap_check()))
-		return error;
+		return error; */
 	return suspend_prepare_image();
 }
 
@@ -854,11 +1361,11 @@
 
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
 
@@ -881,99 +1388,6 @@
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
@@ -993,7 +1407,7 @@
 	return 0;
 }
 
-static struct block_device * resume_bdev;
+static struct block_device * resume_bdev __nosavedata;
 
 /**
  *	submit - submit BIO request.
@@ -1038,12 +1452,12 @@
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
@@ -1088,7 +1502,6 @@
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1115,62 +1528,141 @@
 	return error;
 }
 
+static int __init check_one_pbe(struct pbe *p, void *collide, int cur)
+{
+	unsigned long addr = 0;
+
+	pr_debug("check_one_pbe: %p %p o{%p} ", 
+			p, (void*)addr, (void*)p->orig_address);
+	do {
+		if (addr) {
+			/*free_page(addr);*/
+			addr = 0;
+		}
+		addr = get_zeroed_page(GFP_ATOMIC);
+		if(!addr)
+			return -ENOMEM;
+	} while(check_collide((struct pbe *)collide, nr_copy_pages, (void*)addr));
+	pr_debug("c{%p} done\n", (void*)addr);
+	p->address = addr;
+
+	return 0;
+}
+
+/*
+ * We check here that pagedir & pages it points to won't collide with pages
+ * where we're going to restore from the loaded pages later
+ */
+static int __init check_pagedir(struct pbe *pbe)
+{
+	return for_each_pbe(pbe, check_one_pbe, pagedir_nosave, nr_copy_pages);
+}
+
+static int __init read_one_pbe(struct pbe *p, void *tmp, int cur)
+{
+	int error = 0;
+
+	mod_printk_progress(cur);
+
+	pr_debug("read_one_pbe: %p o{%p} c{%p} %lu, %d\n", 
+			p, (void *)p->orig_address, (void *)p->address, 
+			swp_offset(p->swap_address), cur);
+	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+
+	return error;
+}
+
 /**
  *	swsusp_read_data - Read image pages from swap.
  *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
  */
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
 
 static int __init data_read(void)
 {
-	struct pbe * p;
 	int error;
-	int i;
-	int mod = nr_copy_pages / 100;
+	suspend_pagedir_t * addr = NULL;
 
-	if (!mod)
-		mod = 1;
-
-	if ((error = swsusp_pagedir_relocate()))
+	printk("Relocating pagedir ");
+	error = alloc_pagedir(&addr, nr_copy_pages, pagedir_nosave, 
+			swsusp_info.pagedir_pages);
+	if (error < 0) {
 		return error;
+	}
+	swsusp_copy_pagedir(addr, pagedir_nosave);
+	if (check_pagedir(addr)) {
+		return -ENOMEM;
+	}
+	for_each_pgdir(pagedir_nosave, free_one_pagedir, NULL, NULL);
+	printk("done\n");
+
+	pagedir_nosave = addr;
+
+	mod_progress = nr_copy_pages / 100;
 
 	printk( "Reading image data (%d pages):     ", nr_copy_pages );
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		error = bio_read_page(swp_offset(p->swap_address),
-				  (void *)p->address);
-	}
-	printk(" %d done.\n",i);
-	return error;
+	error = for_each_pbe(pagedir_nosave, read_one_pbe, NULL, nr_copy_pages);
+	printk(" %d done.\n", nr_copy_pages);
 
+	return error;
 }
 
 extern dev_t __init name_to_dev_t(const char *line);
 
+static int __init read_one_pagedir(suspend_pagedir_t *pgdir, 
+		void *fun, void *arg)
+{
+	int i = *(int *)arg;
+	unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
+	unsigned long next;
+	int error = 0;
+
+	next = pgdir->dummy.val;
+	pr_debug("read_one_pagedir: %p, %d, %lu, %p\n", 
+			pgdir, i, offset, (void*)next);
+	if ((error = bio_read_page(offset, (void *)pgdir))) {
+		return error;
+	}
+	(*(int *)arg) ++;
+	pgdir->dummy.val = next;
+
+	return error;
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
+	error = alloc_pagedir(&pagedir_nosave, nr_copy_pages, NULL, n);
+	if (error < 0)
 		return -ENOMEM;
-	pagedir_nosave = (struct pbe *)addr;
 
-	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);
+	printk("pmdisk: Reading pagedir (%d Pages)\n",n);
+
+	error = for_each_pgdir(pagedir_nosave, read_one_pagedir, NULL, &i);
+	BUG_ON(i != n);
 
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
-		if (offset)
-			error = bio_read_page(offset, (void *)addr);
-		else
-			error = -EFAULT;
-	}
 	if (error)
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		for_each_pgdir(pagedir_nosave, free_one_pagedir, NULL, NULL);
+
 	return error;
 }
 
@@ -1185,7 +1677,7 @@
 	if ((error = read_pagedir()))
 		return error;
 	if ((error = data_read()))
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		for_each_pgdir(pagedir_nosave, free_one_pagedir, NULL, NULL);
 	return error;
 }
 
@@ -1207,7 +1699,7 @@
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
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/sysctl.c	2004-11-24 14:12:57.000000000 +0800
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
+		.ctl_name	= VM_SWSUSP_PAGECACHE,
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
+++ linux-2.6.9-ppc-g4-peval-hg/include/linux/sysctl.h	2004-11-24 14:13:08.000000000 +0800
@@ -170,6 +170,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_HARDMAPLIMIT=28,	/* Make mapped a hard limit */
+	VM_SWSUSP_PAGECACHE=29,	/* Enable/Disable Suspend PageCaches */
 };
 
 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
