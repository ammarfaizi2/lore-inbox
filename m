Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbUKWWSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUKWWSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKWWRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:17:55 -0500
Received: from gprs214-143.eurotel.cz ([160.218.214.143]:6282 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261561AbUKWWOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:14:45 -0500
Date: Tue, 23 Nov 2004 23:14:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATH] swsusp update 1/3
Message-ID: <20041123221430.GF25926@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <20041122165823.GA10609@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122165823.GA10609@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Yes, I'd like to get rid of "too many continuous pages" problem
> > > > before. Small problem is that it needs to update x86-64 too, but I
> > > I have not x86-64, so I have no chance to do it.
> > 
> > I have access to x86-64, so I can do it...
> > 								Pavel
> 
> Ok, Now I finised ppc part, it works. :) 
> 
> Here is all of the patch relative with your big diff.
>  core.diff - swsusp core part.
>  i386.diff - i386 part.
>  ppc.diff  - PowerPC part.
> 
> Now we have a option in /proc/sys/kernel/swsusp_pagecache, if that is
> sure using swsusp pagecache, otherwise.

Hmm, okay, I guess temporary sysctl is okay. [I'd probably just put
there variable, and not export it to anyone. That way people will not
want us to retain that in future.]

> --- linux-2.6.9-ppc-g4-peval/include/linux/suspend.h	2004-11-22 17:11:35.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/include/linux/suspend.h	2004-11-22 17:16:58.000000000 +0800
> @@ -1,7 +1,7 @@
>  #ifndef _LINUX_SWSUSP_H
>  #define _LINUX_SWSUSP_H
>  
> -#ifdef CONFIG_X86
> +#if (defined  CONFIG_X86) || (defined CONFIG_PPC32)
               ~
		extra space.


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

Either drop this one or explain why it is good idea. It seems to be
independend on the rest.

> @@ -144,9 +151,13 @@
>  	}
>  
>  	/* Free memory before shutting down devices. */
> -	free_some_memory();
> +	/* free_some_memory(); */

Needs to be if (!swsusp_pagecache), right?

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

Applied.

> @@ -223,7 +219,148 @@
>  	swap_list_unlock();
>  }
>  
> +#define ONE_PAGE_PBE_NUM	( PAGE_SIZE / sizeof(struct pbe) - 1)
> +
> +/* for each pagdir */
                  ~ missing e

> +typedef int (*susp_pgdir_t)(suspend_pagedir_t *cur, void *fun, void *arg);
> +
> +static int inline for_each_pgdir(struct pbe *pbe, susp_pgdir_t fun,
> +		void *subfun, void *arg)
> +{
> +	suspend_pagedir_t *pgdir = pbe;
> +	int error = 0;
> +
> +	while (pgdir != NULL) {
> +		suspend_pagedir_t *next = (suspend_pagedir_t *)pgdir->dummy.val;
> +		pr_debug("next %p, cur %p\n", next, pgdir);
> +		error = fun(pgdir, subfun, arg);
> +		if (error) return error;
> +		pgdir = next;
> +	}
> +
> +	return (0);
> +}

Perhaps this should be done as a macro to avoid casting fun forward
and back? See list_for_each for inspiration.

Also it would be nice to have this part of patch split out... I'd like
to merge it sooner than pagecache_write() and friends.

> +/* 
> + * for_each_pbe_copy_back 
> + *
> + * That usefuly for  writing the code in assemble code.
> + *
> + */
> +/* #define CREATE_ASM_CODE */
> +#ifdef CREATE_ASM_CODE
> +asmlinkage void for_each_pbe_copy_back_i386(void)
> +{
> +	swsusp_pbe_pgdir = pagedir_nosave;
> +	while (swsusp_pbe_pgdir != NULL) {
> +		swsusp_pbe_next = (suspend_pagedir_t *)swsusp_pbe_pgdir->dummy.val;
> +		for (swsusp_pbe_nums = 0; 
> +				swsusp_pbe_nums < ONE_PAGE_PBE_NUM; 
> +				swsusp_pbe_nums++) {
> +			register unsigned long i;
> +			if (swsusp_pbe_pgdir->orig_address == 0) return;
> +			for (i = 0; i < PAGE_SIZE / (sizeof(unsigned long)); i+=4) {
> +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i)) = 
> +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i));
> +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+1)) = 
> +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+1));
> +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+2)) = 
> +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+2));
> +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+3)) = 
> +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+3));

Do you really have to do manual loop unrolling? Why can't C code be
same for i386 and ppc?

> +static int mod_progress = 1;
> +
> +static void inline mod_printk_progress(int i)
> +{
> +	if (mod_progress == 0) mod_progress = 1;
> +	if (!(i%100))
> +		printk( "\b\b\b\b%3d%%", i / mod_progress );
>  }
>  

Hmm, so you did cleanup to progress printing... Good, but it would be
nice to get it separately, too.

> @@ -730,7 +1205,7 @@
>  	struct sysinfo i;
>  
>  	si_swapinfo(&i);
> -	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
> +	if (i.freeswap < (nr_copy_pages + nr_copy_pcs + PAGES_FOR_IO))  {
>  		pr_debug("swsusp: Not enough swap. Need %ld\n",i.freeswap);
>  		return 0;
>  	}
> @@ -750,25 +1225,24 @@
>  
>  	if (!enough_swap())
>  		return -ENOSPC;
> -
> -	if ((error = alloc_pagedir())) {
> -		pr_debug("suspend: Allocating pagedir failed.\n");
> -		return error;
> +	error = alloc_pagedir(&pagedir_save, nr_copy_pages, NULL);
> +	if (error < 0) {
> +		printk("suspend: Allocating pagedir failed.\n");
> +		return -ENOMEM;

Hmm, I liked previous code better. Plus you throw out error
information and just return -ENOMEM, always. 

>  	if ((error = alloc_image_pages())) {
> -		pr_debug("suspend: Allocating image pages failed.\n");
> +		printk("suspend: Allocating image pages failed.\n");
>  		swsusp_free();
>  		return error;
>  	}

Applied.

> @@ -854,11 +1321,11 @@
>  
>  asmlinkage int swsusp_restore(void)
>  {
> -	BUG_ON (pagedir_order_check != pagedir_order);
> -	
>  	/* Even mappings of "global" things (vmalloc) need to be fixed */
> +#if defined(CONFIG_X86) && defined(CONFIG_X86_64)
>  	__flush_tlb_global();
>  	wbinvd();	/* Nigel says wbinvd here is good idea... */
> +#endif

This is needed on i386, too... Okay, wbinvd probably can go... or do
we have some good arch-neutral wbinvd-like thing?
> @@ -993,7 +1367,7 @@
>  	return 0;
>  }
>  
> -static struct block_device * resume_bdev;
> +static struct block_device * resume_bdev __nosavedata;
>  

Why?

> +	return (0);

Please avoid "return (0);". Using "return 0;" will do just fine.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
