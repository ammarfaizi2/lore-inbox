Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbULTWnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbULTWnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbULTWnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:43:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:26002 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261674AbULTWgd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:36:33 -0500
Date: Mon, 20 Dec 2004 13:45:17 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: hugang@soulinfo.com
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATH] swsusp update 1/3
Message-ID: <20041220214517.GD13972@us.ibm.com>
References: <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <20041122165823.GA10609@hugang.soulinfo.com> <20041123221430.GF25926@elf.ucw.cz> <20041124112834.GA1128@elf.ucw.cz> <20041124183031.GA6457@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124183031.GA6457@hugang.soulinfo.com>
X-Operating-System: Linux 2.6.10-rc3 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 02:30:31AM +0800, hugang@soulinfo.com wrote:
> On Wed, Nov 24, 2004 at 12:28:34PM +0100, Pavel Machek wrote:
> > > Hmm, okay, I guess temporary sysctl is okay. [I'd probably just put
> > > there variable, and not export it to anyone. That way people will not
> > > want us to retain that in future.]
> > 
> > I've tried 11-24 version here, and it killed my machine during
> > suspend. (While radeonfb was suspended -> no usefull output). Can you
> > enable CONFIG_PREEMPT and CONFIG_HIGHMEM and get it to work?
> > 
> Yes, It passed in my two computers, a pc and a PowerBook G4, enable
> CONFIG_HIGMEM and CONFIG_PREEMPT.
> 
> Here is a new patch relative with your big diff.
> 
> - using a bitmap do collidate check, faster than before.
>   I can't sure using four pages do bitmap that's enough.
> - changing pgdir_for_each to list_for.. style.
> 
> - I'm using qemu as i386 suspend testing platform, tha't perfect to do
>   kernel level debug. If someone wanny using qemu as linux suspend
>   testing platform, please apply this patch to let qemu support ide idle
>   command. http://soulinfo.com/~hugang/swsusp/qemu/ide.patch
> 
> only core.diff attached, other parts nothing changed.
> 
> --- linux-2.6.9-ppc-g4-peval/include/linux/reboot.h	2004-06-16 13:20:26.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/include/linux/reboot.h	2004-11-22 17:16:58.000000000 +0800
> @@ -42,6 +42,8 @@
>  extern int register_reboot_notifier(struct notifier_block *);
>  extern int unregister_reboot_notifier(struct notifier_block *);
>  
> +/* For use by swsusp only */
> +extern struct notifier_block *reboot_notifier_list;
>  
>  /*
>   * Architecture-specific implementations of sys_reboot commands.
> --- linux-2.6.9-ppc-g4-peval/include/linux/suspend.h	2004-11-22 17:11:35.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/include/linux/suspend.h	2004-11-24 16:51:48.000000000 +0800
> @@ -1,7 +1,7 @@
>  #ifndef _LINUX_SWSUSP_H
>  #define _LINUX_SWSUSP_H
>  
> -#ifdef CONFIG_X86
> +#if (defined(CONFIG_X86)) || (defined (CONFIG_PPC32))
>  #include <asm/suspend.h>
>  #endif
>  #include <linux/swap.h>
> --- linux-2.6.9-ppc-g4-peval/kernel/power/disk.c	2004-11-22 17:11:35.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/disk.c	2004-11-24 15:59:56.000000000 +0800
> @@ -16,6 +16,7 @@
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
> +#include <linux/reboot.h>
>  #include <linux/device.h>
>  #include "power.h"
>  
> @@ -29,6 +30,8 @@
>  extern int swsusp_resume(void);
>  extern int swsusp_free(void);
>  
> +extern int write_page_caches(void);
> +extern int read_page_caches(void);
>  
>  static int noresume = 0;
>  char resume_file[256] = CONFIG_PM_STD_PARTITION;
> @@ -48,14 +51,16 @@
>  	unsigned long flags;
>  	int error = 0;
>  
> -	local_irq_save(flags);
>  	switch(mode) {
>  	case PM_DISK_PLATFORM:
> - 		device_power_down(PMSG_SUSPEND);
> + 		/* device_power_down(PMSG_SUSPEND); */
> +		local_irq_save(flags);
>  		error = pm_ops->enter(PM_SUSPEND_DISK);
> +		local_irq_restore(flags);
>  		break;
>  	case PM_DISK_SHUTDOWN:
>  		printk("Powering off system\n");
> +		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
>  		device_shutdown();
>  		machine_power_off();
>  		break;
> @@ -106,6 +111,7 @@
>  	}
>  }
>  
> +
>  static inline void platform_finish(void)
>  {
>  	if (pm_disk_mode == PM_DISK_PLATFORM) {
> @@ -118,13 +124,14 @@
>  {
>  	device_resume();
>  	platform_finish();
> +	read_page_caches();
>  	enable_nonboot_cpus();
>  	thaw_processes();
>  	pm_restore_console();
>  }
>  
>  
> -static int prepare(void)
> +static int prepare(int resume)
>  {
>  	int error;
>  
> @@ -144,9 +151,13 @@
>  	}
>  
>  	/* Free memory before shutting down devices. */
> -	free_some_memory();
> +	/* free_some_memory(); */
>  
>  	disable_nonboot_cpus();
> +	if (!resume) 
> +		if ((error = write_page_caches())) {
> +			goto Finish;
> +		}
>  	if ((error = device_suspend(PMSG_FREEZE))) {
>  		printk("Some devices failed to suspend\n");
>  		goto Finish;
> @@ -176,7 +187,7 @@
>  {
>  	int error;
>  
> -	if ((error = prepare()))
> +	if ((error = prepare(0)))
>  		return error;
>  
>  	pr_debug("PM: Attempting to suspend to disk.\n");
> @@ -233,7 +244,7 @@
>  
>  	pr_debug("PM: Preparing system for restore.\n");
>  
> -	if ((error = prepare()))
> +	if ((error = prepare(1)))
>  		goto Free;
>  
>  	barrier();
> --- linux-2.6.9-ppc-g4-peval/kernel/power/main.c	2004-11-22 17:11:35.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/main.c	2004-11-22 17:16:58.000000000 +0800
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2003 Patrick Mochel
>   * Copyright (c) 2003 Open Source Development Lab
>   * 
> - * This file is release under the GPLv2
> + * This file is released under the GPLv2
>   *
>   */
>  
> --- linux-2.6.9-ppc-g4-peval/kernel/power/swsusp.c	2004-11-22 17:11:35.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/swsusp.c	2004-11-25 01:46:52.000000000 +0800
> @@ -74,9 +74,6 @@
>  /* References to section boundaries */
>  extern char __nosave_begin, __nosave_end;
>  
> -/* Variables to be preserved over suspend */
> -static int pagedir_order_check;
> -
>  extern char resume_file[];
>  static dev_t resume_device;
>  /* Local variables that should not be affected by save */
> @@ -97,7 +94,6 @@
>   */
>  suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
>  static suspend_pagedir_t *pagedir_save;
> -static int pagedir_order __nosavedata = 0;
>  
>  #define SWSUSP_SIG	"S1SUSPEND"
>  
> @@ -222,8 +218,137 @@
>  		}
>  	swap_list_unlock();
>  }
> +	
> +#define ONE_PAGE_PBE_NUM	(PAGE_SIZE/sizeof(struct pbe))
> +
> +/* for each pagedir */
> +typedef int (*susp_pgdir_t)(suspend_pagedir_t *cur, void *fun, void *arg);
> +
> +#define pgdir_for_each_safe(pos, n, head) \
> +	for(pos = head, n = pos ? (suspend_pagedir_t*)pos->dummy.val : NULL; \
> +		pos != NULL; \
> +		pos = n, n = pos ? (suspend_pagedir_t *)pos->dummy.val : NULL)
> +
> +/* free pagedir */
> +static void pagedir_free(suspend_pagedir_t *head)
> +{
> +	suspend_pagedir_t *next, *cur;
> +	pgdir_for_each_safe(cur, next, head) {
> +		free_page((unsigned long)cur);
> +	}
> +}
> +
> +/* 
> + * swsup_pbe_t
> + *
> + * a callback funtion in foreach pbe loop.
> + *
> + * @param pbe  pointer of current pbe
> + * @param p    private data 
> + * @param cur  current index
> + *
> + * @return  0 is ok, otherwise 
> + */
> + 
> +typedef int (*swsup_pbe_t)(struct pbe *pbe, void *p, int cur);
> +
> +/*
> + * for_each_pbe 
> + *
> + * @param pbe pointer of the pbe head 
> + * @param fun callback function
> + * @param p   private data 
> + * @param max max the the pbe numbers
> + *
> + * @return 0 is ok, otherwise
> + */
> +static int for_each_pbe(struct pbe *pbe, swsup_pbe_t fun, void *p, int max)
> +{
> +	struct pbe *pgdir = pbe, *next = NULL;
> +	unsigned long i = 0;
> +	int error = 0;
> +
> +	while (pgdir != NULL) {
> +		unsigned long nums;
> +		next = (struct pbe*)pgdir->dummy.val;
> +		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++, pgdir++, i ++) {
> +			if (i == max) { /* end */
> +				return 0;
> +			}
> +			if((error = fun(pgdir, p, i))) { /* got error */
> +				return error;
> +			}
> +		}
> +		pgdir = next;
> +	}
> +	return (error);
> +}
> +/* for_each_pbe_copy_back 
> + *
> + * That usefuly for  writing the code in assemble code.
> + *
> + */
> +/*#define CREATE_ASM_CODE */
> +#ifdef CREATE_ASM_CODE
> +#if 0
> +#define GET_ADDRESS(x) __pa(x) 
> +#else
> +#define GET_ADDRESS(x) (x)
> +#endif
> +asmlinkage void for_each_pbe_copy_back(void)
> +{
> +	struct pbe *pgdir, *next;
> +
> +	pgdir = pagedir_nosave;
> +	while (pgdir != NULL) {
> +		unsigned long nums, i;
> +		pgdir = (struct pbe *)GET_ADDRESS(pgdir);
> +		next = (struct pbe*)pgdir->dummy.val;
> +		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++) {
> +			register unsigned long *orig, *copy;
> +			orig = (unsigned long *)pgdir->orig_address;
> +			if (orig == 0) goto end;
> +			orig = (unsigned long *)GET_ADDRESS(orig);
> +			copy = (unsigned long *)GET_ADDRESS(pgdir->address);
> +#if 0
> +			memcpy(orig, copy, PAGE_SIZE);
> +#else
> +			for (i = 0; i < PAGE_SIZE / sizeof(unsigned long); i+=4) {
> +				*(orig + i) = *(copy + i);
> +				*(orig + i+1) = *(copy + i+1);
> +				*(orig + i+2) = *(copy + i+2);
> +				*(orig + i+3) = *(copy + i+3);
> +			}
> +#endif
> +			pgdir ++;
> +		}
> +		pgdir = next;
> +	}
> +end:
> +	panic("just asm code");
> +}
> +#endif
> +
> +static int find_bpe_index(struct pbe *p, void *tmp, int cur)
> +{
> +	if (*(int *)tmp == cur) {
> +		*(struct pbe **)tmp = p;
> +		return (1);
> +	}
> +	return 0;
> +}
>  
> +static struct pbe *find_pbe_by_index(struct pbe *pgdir, int index, int max)
> +{
> +	unsigned long p = index;
>  
> +	/* pr_debug("find_pbe_by_index: %p, %d, %d ", pgdir, index, max); */
> +	if (for_each_pbe(pgdir, find_bpe_index, &p, max) == 1) {
> +		/* pr_debug("%p\n", (void*)p); */
> +		return ((struct pbe *)p);
> +	} 
> +	return (NULL);
> +}
>  
>  /**
>   *	write_swap_page - Write one page to a fresh swap location.
> @@ -257,6 +382,17 @@
>  	return error;
>  }
>  
> +static int data_free_pbe(struct pbe *p, void *tmp, int cur)
> +{
> +	swp_entry_t entry;
> +
> +	entry = p->swap_address;
> +	if (entry.val)
> +		swap_free(entry);
> +	p->swap_address = (swp_entry_t){0};
> +
> +	return 0;
> +}
>  
>  /**
>   *	data_free - Free the swap entries used by the saved image.
> @@ -267,43 +403,49 @@
>  
>  static void data_free(void)
>  {
> -	swp_entry_t entry;
> -	int i;
> +	for_each_pbe(pagedir_nosave, data_free_pbe, NULL, nr_copy_pages);
> +}
>  
> -	for (i = 0; i < nr_copy_pages; i++) {
> -		entry = (pagedir_nosave + i)->swap_address;
> -		if (entry.val)
> -			swap_free(entry);
> -		else
> -			break;
> -		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
> -	}
> +static int mod_progress = 1;
> +
> +static void inline mod_printk_progress(int i)
> +{
> +	if (mod_progress == 0) mod_progress = 1;
> +	if (!(i%100))
> +		printk( "\b\b\b\b%3d%%", i / mod_progress );
>  }
>  
> +static int write_one_pbe(struct pbe *p, void *tmp, int cur)
> +{
> +	int error = 0;
> +
> +	BUG_ON(p->address == 0);
> +	BUG_ON(p->orig_address == 0);
> +	if ((error = write_page(p->address, &p->swap_address))) {
> +		return error;
> +	}
> +	mod_printk_progress(cur);
> +	pr_debug("write_one_pbe: %p, o{%p} c{%p} %lu %d\n", p, 
> +			(void *)p->orig_address, (void *)p->address,
> +			p->swap_address.val, cur); 
> +	return 0;
> +}
>  
>  /**
>   *	data_write - Write saved image to swap.
>   *
>   *	Walk the list of pages in the image and sync each one to swap.
>   */
> -
>  static int data_write(void)
>  {
> -	int error = 0;
> -	int i;
> -	unsigned int mod = nr_copy_pages / 100;
> -
> -	if (!mod)
> -		mod = 1;
> +	int error;
> +	
> +	mod_progress = nr_copy_pages / 100;
>  
> -	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
> -	for (i = 0; i < nr_copy_pages && !error; i++) {
> -		if (!(i%mod))
> -			printk( "\b\b\b\b%3d%%", i / mod );
> -		error = write_page((pagedir_nosave+i)->address,
> -					  &((pagedir_nosave+i)->swap_address));
> -	}
> +	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages);
> +	error = for_each_pbe(pagedir_nosave, write_one_pbe, NULL, nr_copy_pages);
>  	printk("\b\b\b\bdone\n");
> +
>  	return error;
>  }
>  
> @@ -363,7 +505,6 @@
>  		swap_free(swsusp_info.pagedir[i]);
>  }
>  
> -
>  /**
>   *	write_pagedir - Write the array of pages holding the page directory.
>   *	@last:	Last swap entry we write (needed for header).
> @@ -371,15 +512,19 @@
>  
>  static int write_pagedir(void)
>  {
> -	unsigned long addr = (unsigned long)pagedir_nosave;
> -	int error = 0;
> -	int n = SUSPEND_PD_PAGES(nr_copy_pages);
> -	int i;
> +	int error = 0, n = 0;
> +	suspend_pagedir_t *pgdir, *next;
>  
> -	swsusp_info.pagedir_pages = n;
> +	pgdir_for_each_safe(pgdir, next, pagedir_nosave) {
> +		error = write_page((unsigned long)pgdir, &swsusp_info.pagedir[n]);
> +		if (error) { 
> +			break;
> +		}
> +		n++;
> +	} 
>  	printk( "Writing pagedir (%d pages)\n", n);
> -	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
> -		error = write_page(addr, &swsusp_info.pagedir[i]);
> +	swsusp_info.pagedir_pages = n;
> +
>  	return error;
>  }
>  
> @@ -504,6 +649,464 @@
>  	return 0;
>  }
>  
> +typedef int (*do_page_t)(struct page *page, int p);
> +
> +static int foreach_zone_page(struct zone *zone, do_page_t fun, int p)
> +{
> +	int inactive = 0, active = 0;
> +
> +	spin_lock_irq(&zone->lru_lock); 
> +	if (zone->nr_inactive) {
> +		struct list_head * entry = zone->inactive_list.prev;
> +		while (entry != &zone->inactive_list) {
> +			if (fun) {
> +				struct page * page = list_entry(entry, struct page, lru);
> +				inactive += fun(page, p);
> +			} else { 
> +				inactive ++;
> +			}
> +			entry = entry->prev;
> +		}
> +	}
> +	if (zone->nr_active) {
> +		struct list_head * entry = zone->active_list.prev;
> +		while (entry != &zone->active_list) {
> +			if (fun) {
> +				struct page * page = list_entry(entry, struct page, lru);
> +				active += fun(page, p);
> +			} else {
> +				active ++;
> +			}
> +			entry = entry->prev;
> +		}
> +	}
> +	spin_unlock_irq(&zone->lru_lock);
> +
> +	return (active + inactive);
> +}
> +
> +/* enable/disable pagecache suspend */
> +int swsusp_pagecache = 0;
> +
> +/* I'll move this to include/linux/page-flags.h */
> +#define PG_page_caches (PG_nosave_free + 1)
> +
> +#define SetPagePcs(page)    set_bit(PG_page_caches, &(page)->flags)
> +#define ClearPagePcs(page)  clear_bit(PG_page_caches, &(page)->flags)
> +#define PagePcs(page)   test_bit(PG_page_caches, &(page)->flags)
> +
> +static suspend_pagedir_t *pagedir_cache = NULL;
> +static int nr_copy_page_caches = 0;
> +
> +static void lock_pagecaches(void)
> +{
> +	struct zone *zone;
> +	for_each_zone(zone) {
> +		if (!is_highmem(zone)) {
> +			spin_lock_irq(&zone->lru_lock);
> +		}
> +	}
> +}
> +
> +static void unlock_pagecaches(void)
> +{
> +	struct zone *zone;
> +	for_each_zone(zone) {
> +		if (!is_highmem(zone)) {
> +			spin_unlock_irq(&zone->lru_lock);
> +		}
> +	}
> +}
> +
> +static int setup_page_caches_pe(struct page *page, int setup)
> +{
> +	unsigned long pfn = page_to_pfn(page);
> +
> +	BUG_ON(PageReserved(page) && PageNosave(page));
> +	if (!pfn_valid(pfn)) {
> +		printk("not valid page\n");
> +		return 0;
> +	}
> +	if (PageNosave(page)) {
> +		printk("nosave\n");
> +		return 0;
> +	}
> +	if (PageReserved(page) /*&& pfn_is_nosave(pfn)*/) {
> +		printk("[nosave]\n");
> +		return 0;
> +	}
> +	if (PageSlab(page)) {
> +		printk("slab\n");
> +		return 0;
> +	}
> +	if (setup) {
> +		struct pbe *p = find_pbe_by_index(pagedir_cache, nr_copy_page_caches, -1);
> +		BUG_ON(p == NULL);
> +		p->address = (long)page_address(page);
> +		BUG_ON(p->address == 0);
> +		/*pr_debug("setup_page_caches: cur %p, o{%p}, d{%p}, nr %u\n",
> +				(void*)p, (void*)p->orig_address,
> +				(void*)p->address, nr_copy_page_caches);*/
> +		nr_copy_page_caches ++;
> +	}
> +	SetPagePcs(page);
> +
> +	return (1);
> +}
> +
> +static int count_page_caches(struct zone *zone, int p)
> +{
> +	if (swsusp_pagecache)
> +		return foreach_zone_page(zone, setup_page_caches_pe, p);
> +	return 0;
> +}
> +
> + /* a bitmap base collide check */
> +static inline void collide_set_bit(unsigned char *bitmap, 
> +		unsigned long bitnum)
> +{
> +	bitnum -= 0xc0000000;
> +	bitnum = bitnum >> 12;
> +	bitmap[bitnum / 8] |= (1 << (bitnum%8));
> +}
> +
> +static inline int collide_is_bit_set(unsigned char *bitmap, 
> +		unsigned long bitnum)
> +{               
> +	bitnum -= 0xc0000000;
> +	bitnum = bitnum >> 12;
> +	return !!(bitmap[bitnum / 8] & (1 << (bitnum%8)));
> +}
> +
> +static void collide_bitmap_free(unsigned char *bitmap)
> +{
> +	free_pages((unsigned long)bitmap, 2);
> +}
> +
> +/* 
> + * four pages are enough for bitmap 
> + *
> + */
> +static unsigned char *collide_bitmap_init(struct pbe *pgdir)
> +{
> +	unsigned char *bitmap = 
> +		(unsigned char *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 2);
> +	struct pbe *next;
> +
> +	if (bitmap == NULL) {
> +		return NULL;
> +	}
> +	memset(bitmap, 0, 4 * PAGE_SIZE);
> +
> +	/* do base check */
> +	BUG_ON(collide_is_bit_set(bitmap, (unsigned long)bitmap) == 1);
> +	collide_set_bit(bitmap, (unsigned long)bitmap);
> +	BUG_ON(collide_is_bit_set(bitmap, (unsigned long)bitmap) == 0);
> +	
> +	while (pgdir != NULL) {
> +		unsigned long nums;
> +		next = (struct pbe*)pgdir->dummy.val;
> +		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++) {
> +			collide_set_bit(bitmap, (unsigned long)pgdir);
> +			collide_set_bit(bitmap, (unsigned long)pgdir->orig_address);
> +			pgdir ++;
> +		}
> +		pgdir = next;
> +	}
> +
> +	return bitmap;
> +}
> +
> +/*
> + * redefine in PageCahe pagdir.
> + *
> + * struct pbe {
> + * unsigned long address;
> + * unsigned long orig_address; pointer of next struct pbe
> + * swp_entry_t swap_address;
> + * swp_entry_t dummy;          current index
> + * }
> + *
> + */
> +static suspend_pagedir_t * alloc_one_pagedir(suspend_pagedir_t *prev, 
> +		unsigned char *collide)
> +{
> +	suspend_pagedir_t *pgdir = NULL;
> +	int i;
> +
> +	pgdir = (suspend_pagedir_t *)
> +		__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
> +	if (!pgdir) {
> +		return NULL;
> +	}
> +
> +	if (collide) {
> +		while (collide_is_bit_set(collide, (unsigned long)pgdir)) {
> +			pgdir = (suspend_pagedir_t *)
> +				__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
> +			if (!pgdir) {
> +				return NULL;
> +			}
> +		}
> +	}
> +
> +	/*pr_debug("pgdir: %p, %p, %d\n", 
> +			pgdir, prev, sizeof(suspend_pagedir_t)); */
> +	for (i = 0; i < ONE_PAGE_PBE_NUM; i++) {
> +		pgdir[i].dummy.val = 0;
> +		pgdir[i].address = 0;
> +		pgdir[i].orig_address = 0;
> +		if (prev)
> +			prev[i].dummy.val= (unsigned long)pgdir;
> +	}
> +
> +	return (pgdir);
> +}
> +
> +/* calc_nums - Determine the nums of allocation needed for pagedir_save. */
> +static int calc_nums(int nr_copy)
> +{
> +	int diff = 0, ret = 0;
> +	do {
> +		diff = (nr_copy / ONE_PAGE_PBE_NUM) - ret + 1;
> +		if (diff) {
> +			ret += diff;
> +			nr_copy += diff;
> +		}
> +	} while (diff);
> +	return nr_copy;
> +}
> +
> +
> +/* 
> + * alloc_pagedir 
> + *
> + * @param pbe
> + * @param pbe_nums
> + * @param collide
> + * @param page_nums
> + *
> + */
> +static int alloc_pagedir(struct pbe **pbe, int pbe_nums, 
> +		unsigned char *collide, int page_nums)
> +{
> +	unsigned int nums = 0;
> +	unsigned int after_alloc = pbe_nums;
> +	suspend_pagedir_t *prev = NULL, *cur = NULL;
> +
> +	if (page_nums)
> +		after_alloc = ONE_PAGE_PBE_NUM * page_nums;
> +	else 
> +		after_alloc = calc_nums(after_alloc);
> +
> +	pr_debug("alloc_pagedir: %d, %d\n", pbe_nums, after_alloc);
> +	for (nums = 0 ; nums < after_alloc ; nums += ONE_PAGE_PBE_NUM) {
> +		cur = alloc_one_pagedir(prev, collide);
> +		pr_debug("alloc_one_pagedir: %p\n", cur);
> +		if (!cur) { /* get page failed */
> +			goto no_mem;
> +		}
> +		if (nums == 0) { /* setup the head */
> +			*pbe = cur;
> +		}
> +		prev = cur;
> +	}
> +	return after_alloc - pbe_nums;
> +
> +no_mem:
> +	pagedir_free(*pbe);
> +	*pbe = NULL;
> +
> +	return (-ENOMEM);
> +}
> +
> +static char *page_cache_buf = NULL;
> +
> +static int bio_read_page(pgoff_t page_off, void * page);
> +
> +static int pagecache_read_pbe(struct pbe *p, void *tmp, int cur)
> +{
> +	int error = 0;
> +	swp_entry_t entry;
> +
> +	mod_printk_progress(cur);
> +
> +	pr_debug("pagecache_read_pbe: %p, o{%p} c{%p} %lu\n",
> +			p, (void *)p->orig_address, (void *)p->address, 
> +			swp_offset(p->swap_address));
> +
> +	error = bio_read_page(swp_offset(p->swap_address), page_cache_buf);
> +	if (error) return error;
> +	memcpy((void*)p->address, (void*)page_cache_buf, PAGE_SIZE);
> +
> +	entry = p->swap_address;
> +	if (entry.val)
> +		swap_free(entry);
> +
> +	return 0;
> +}
> +
> +int read_page_caches(void)
> +{
> +	int error = 0;
> +	
> +	if (swsusp_pagecache == 0) return 0;
> +
> +	mod_progress = nr_copy_page_caches / 100;
> +
> +	printk( "Reading PageCaches from swap (%d pages)...     ", nr_copy_page_caches);
> +	error = for_each_pbe(pagedir_cache, pagecache_read_pbe, NULL,
> +			nr_copy_page_caches);
> +	printk("\b\b\b\bdone\n");
> +
> +	unlock_pagecaches();
> +	pagedir_free(pagedir_cache);
> +	free_page((unsigned long)page_cache_buf);
> +
> +	return error;
> +}
> +
> +static int pagecache_write_pbe(struct pbe *p, void *tmp, int cur)
> +{
> +	int error = 0;
> +
> +	mod_printk_progress(cur);
> +
> +	pr_debug("pagecache_write_pbe: %p, o{%p} c{%p} %d ",
> +			p, (void *)p->orig_address, (void *)p->address, cur);
> +	BUG_ON(p->address == 0);
> +	memcpy((void *)page_cache_buf, (void*)p->address, PAGE_SIZE);
> +	error = write_page((unsigned long)page_cache_buf, &p->swap_address);
> +	if (error) return error;
> +
> +	pr_debug("%lu\n", swp_offset(p->swap_address));
> +
> +	return 0;
> +}
> +
> +static int page_caches_write(void)
> +{
> +	int error;
> +	
> +	mod_progress = nr_copy_page_caches / 100;
> +
> +	lock_pagecaches();
> +	printk( "Writing PageCaches to swap (%d pages)...     ", 
> +			nr_copy_page_caches);
> +	error = for_each_pbe(pagedir_cache, pagecache_write_pbe, NULL, 
> +			nr_copy_page_caches);
> +	printk("\b\b\b\bdone\n");
> +
> +	return error;
> +}
> +
> +static int setup_pagedir_pbe(void)
> +{
> +	struct zone *zone;
> +
> +	nr_copy_page_caches = 0;
> +	for_each_zone(zone) {
> +		if (!is_highmem(zone)) {
> +			count_page_caches(zone, 1);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void count_data_pages(void);
> +static int swsusp_alloc(void);
> +
> +static void page_caches_recal(void)
> +{
> +	struct zone *zone;
> +	int i;
> +
> +	for (i = 0; i < max_mapnr; i++)
> +		ClearPagePcs(mem_map+i);
> +
> +	nr_copy_page_caches = 0;
> +	drain_local_pages();
> +	for_each_zone(zone) {
> +		if (!is_highmem(zone)) {
> +			nr_copy_page_caches += count_page_caches(zone, 0);
> +		}
> +	}
> +}
> +
> +int write_page_caches(void)
> +{
> +	int error;
> +	int recal = 0;
> +
> +	if ((error = swsusp_swap_check())) {
> +		/* FIXME free pagedir_cache */
> +		return error;
> +	}
> +
> +	if (swsusp_pagecache) {
> +		page_cache_buf = (char *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
> +		if (!page_cache_buf) {
> +			/* FIXME try shrink memory */
> +			return -ENOMEM;
> +		}
> +
> +		page_caches_recal();
> +
> +		if (nr_copy_page_caches == 0) {
> +			return 0;
> +		}
> +		if (alloc_pagedir(&pagedir_cache, nr_copy_page_caches, NULL, 0) < 0) {
> +			/* FIXME try shrink memory */
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	drain_local_pages();
> +	count_data_pages();
> +
> +	if (nr_free_pages() < nr_copy_pages + PAGES_FOR_IO) {
> +		printk("swsusp: need %d pages, free %d pages\n", 
> +				nr_copy_pages, nr_free_pages());
> +		printk("swsusp: Freeing memory:...     ");
> +		while (shrink_all_memory(nr_copy_pages * 2)) {
> +			current->state = TASK_INTERRUPTIBLE;
> +			schedule_timeout(HZ/5);

This should be msleep_interruptible() [I do not see any wait-queue events around
this code].

Thanks,
Nish
