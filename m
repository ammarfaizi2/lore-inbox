Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267977AbTCCAIh>; Sun, 2 Mar 2003 19:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbTCCAIh>; Sun, 2 Mar 2003 19:08:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:672 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267977AbTCCAIe>;
	Sun, 2 Mar 2003 19:08:34 -0500
Date: Sun, 2 Mar 2003 17:55:16 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-Reply-To: <1046487717.4616.22.camel@laptop-linux.cunninghams>
Message-ID: <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there.

> Thus, I still think we can go with the patch I submitted before. I've
> rediffed it against 2.5.63 (less the bits already applied).

I've spent the last week reading, reviewing, and rewriting major portions 
of swsusp. I've actually been reasonably impressed, once I was able to get 
the code into a much more readable state. 

All in all, I think the idea of saving state to swap is dangerous for 
various reasons. However, I like some of the other concepts of the code, 
and will use them in developing a more palatable mechanism of doing STDs 
(hehe, I love saying that). Once I've successfully broken out the pieces I 
want to reuse, I'll post the cumulative patch. In the meantime, the 
incremental diffs can be viewed here: 

http://ldm.bkbits.net:8080/linux-2.5-power

In the meantime, I do have some comments on your patch..

> diff -ruN linux-2.5.63/arch/i386/kernel/suspend.c linux-2.5.63-01/arch/i386/kernel/suspend.c
> --- linux-2.5.63/arch/i386/kernel/suspend.c	2003-02-20 08:25:26.000000000 +1300
> +++ linux-2.5.63-01/arch/i386/kernel/suspend.c	2003-02-20 08:27:36.000000000 +1300

Thank you for putting this back in C, it's much appreciated. 

> +void do_magic(int resume)
> +{
> +	if (!resume) {
> +		do_magic_suspend_1();
> +		save_processor_state();	/* We need to capture registers and memory at "same time" */
> +		asm (	"movl %esp, saved_context_esp\n\t"
> +			"movl %eax, saved_context_eax\n\t"
> +			"movl %ebx, saved_context_ebx\n\t"
> +			"movl %ecx, saved_context_ecx\n\t"
> +			"movl %edx, saved_context_edx\n\t"
> +			"movl %ebp, saved_context_ebp\n\t"
> +			"movl %esi, saved_context_esi\n\t"
> +			"movl %edi, saved_context_edi\n\t"

On x86, %eax, %ecx, and %edx are local scratch registers, and don't need 
to be saved. Note that gcc may use them, so check the assembly output. 

> +/*
> + * Final function for resuming: after copying the pages to their original
> + * position, it restores the register state.
> + *
> + * What about page tables? Writing data pages may toggle
> + * accessed/dirty bits in our page tables. That should be no problems
> + * with 4MB page tables. That's why we require have_pse.  
> + *
> + * This loops destroys stack from under itself, so it better should
> + * not use any stack space, itself. When this function is entered at
> + * resume time, we move stack to _old_ place.  This is means that this
> + * function must use no stack and no local variables in registers,
> + * until calling restore_processor_context();
> + *
> + * Critical section here: noone should touch saved memory after
> + * do_magic_resume_1; copying works, because nr_copy_pages,
> + * pagedir_nosave, loop and loop2 are nosavedata.
> + */

Do you have something against indenting comments? ;)

> +	for (loop=0; loop < nr_copy_pages; loop++) {
> +		/* You may not call something (like copy_page) here: see above */
> +		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
> +			*(((char *)(PAGEDIR_ENTRY(pagedir_nosave,loop)->orig_address))+loop2) =
> +				*(((char *)(PAGEDIR_ENTRY(pagedir_nosave,loop)->address))+loop2);
> +			__flush_tlb();
> +		}
> +	}

This is better done as 

	for (loop = 0; loop < nr_copy_pagse; loop++) {
		memcpy((char *)pagedir_nosave[loop].orig_address,
		       (char *)pagedir_nosave[loop].address,
		       PAGE_SIZE);
		__flush_tlb();
	}

Is __flush_tlb() really necessary? 


> diff -ruN linux-2.5.63/include/linux/page-flags.h linux-2.5.63-01/include/linux/page-flags.h
> --- linux-2.5.63/include/linux/page-flags.h	2003-02-20 07:59:33.000000000 +1300
> +++ linux-2.5.63-01/include/linux/page-flags.h	2003-02-20 08:28:31.000000000 +1300
> @@ -74,6 +74,7 @@
>  #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
>  #define PG_reclaim		18	/* To be reclaimed asap */
>  #define PG_compound		19	/* Part of a compound page */
> +#define PG_collides		20	/* swsusp - page used in save image */
>  
>  /*
>   * Global page accounting.  One instance per CPU.  Only unsigned longs are
> @@ -256,6 +257,9 @@
>  #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
>  #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
>  
> +#define PageCollides(page)	test_bit(PG_collides, &(page)->flags)
> +#define SetPageCollides(page)	set_bit(PG_collides, &(page)->flags)
> +#define ClearPageCollides(page)	clear_bit(PG_collides, &(page)->flags)
>  /*
>   * The PageSwapCache predicate doesn't use a PG_flag at this time,
>   * but it may again do so one day.
> diff -ruN linux-2.5.63/include/linux/suspend.h linux-2.5.63-01/include/linux/suspend.h
> --- linux-2.5.63/include/linux/suspend.h	2003-01-15 17:00:58.000000000 +1300
> +++ linux-2.5.63-01/include/linux/suspend.h	2003-02-20 08:27:36.000000000 +1300
> @@ -34,7 +34,7 @@
>  	char version[20];
>  	int num_cpus;
>  	int page_size;
> -	suspend_pagedir_t *suspend_pagedir;
> +	suspend_pagedir_t **suspend_pagedir;
>  	unsigned int num_pbes;
>  	struct swap_location {
>  		char filename[SWAP_FILENAME_MAXLENGTH];
> @@ -42,6 +42,8 @@
>  };
>  
>  #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
> +#define PAGEDIR_CAPACITY(x)     (((x)*PAGE_SIZE/sizeof(struct pbe)))
> +#define PAGEDIR_ENTRY(pagedir, i) (pagedir[i/PAGEDIR_CAPACITY(1)] + (i%PAGEDIR_CAPACITY(1)))
>     
>  /* mm/vmscan.c */
>  extern int shrink_mem(void);
> @@ -61,7 +63,7 @@
>  extern void thaw_processes(void);
>  
>  extern unsigned int nr_copy_pages __nosavedata;
> -extern suspend_pagedir_t *pagedir_nosave __nosavedata;
> +extern suspend_pagedir_t **pagedir_nosave __nosavedata;
>  
>  /* Communication between kernel/suspend.c and arch/i386/suspend.c */
>  

This, and the rest of the deleted patch, are dubious. Once you start
adding 

- more page flag bits
- functions that use double pointers

big warning alarms start going off I haven't looked that far into it yet,
but I suspect there are some design issues there that should get resolved.


	-pat


