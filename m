Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVBGQYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVBGQYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVBGQYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:24:15 -0500
Received: from gprs215-44.eurotel.cz ([160.218.215.44]:34784 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261177AbVBGQX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:23:59 -0500
Date: Mon, 7 Feb 2005 17:23:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Hu Gang <hugang@soulinfo.com>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Message-ID: <20050207162316.GA8299@elf.ucw.cz>
References: <200501310019.39526.rjw@sisk.pl> <200502071208.50001.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502071208.50001.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The (updated) patch follows.

Okay, few comments...


> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> diff -Nru linux-2.6.11-rc3-mm1-orig/arch/i386/power/swsusp.S linux-2.6.11-rc3-mm1/arch/i386/power/swsusp.S
> --- linux-2.6.11-rc3-mm1-orig/arch/i386/power/swsusp.S	2004-12-24 22:34:31.000000000 +0100
> +++ linux-2.6.11-rc3-mm1/arch/i386/power/swsusp.S	2005-02-05 20:57:03.000000000 +0100
> @@ -28,28 +28,28 @@
>  	ret
>  
>  ENTRY(swsusp_arch_resume)
> -	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
> -	movl %ecx,%cr3
> +	movl	$swsusp_pg_dir-__PAGE_OFFSET,%ecx
> +	movl	%ecx,%cr3
>  
> -	movl	pagedir_nosave, %ebx
> -	xorl	%eax, %eax
> -	xorl	%edx, %edx
> +	movl	pagedir_nosave, %edx

move copy_loop: here

> +	testl	%edx, %edx
> +	jz	done
>  	.p2align 4,,7
>  
>  copy_loop:
> -	movl	4(%ebx,%edx),%edi
> -	movl	(%ebx,%edx),%esi
> +	movl	(%edx), %esi
> +	movl	4(%edx), %edi
>  
>  	movl	$1024, %ecx
>  	rep
>  	movsl
>  
> -	incl	%eax
> -	addl	$16, %edx
> -	cmpl	nr_copy_pages,%eax
> -	jb copy_loop
> +	movl	12(%edx), %edx
> +	testl	%edx, %edx
> +	jnz	copy_loop

And do unconditional jump here? Also, 12(%edx)... Could it be handled
using asm-offsets, like on x86-64?

> +static void __init free_eaten_memory(void) {

Please put { at new line.

> +	for_each_pbe(p, pblist)
> +		p->address = 0UL;
> +
> +	for_each_pbe(p, pblist) {
> +		p->address = get_usable_page(GFP_ATOMIC);
> +		if(!p->address)

I'd put space between if and (. And probably do the same for
for_each_pbe... it behaves like a while.

> @@ -966,45 +1018,52 @@
>  					zone->zone_start_pfn));
>  	}
>  
> -	/* Clear orig address */
> +	/* Clear orig addresses */
>  
> -	for(i = 0, p = pagedir_nosave; i < nr_copy_pages; i++, p++) {
> +	for_each_pbe(p, pblist)
>  		ClearPageNosaveFree(virt_to_page(p->orig_address));
> -	}
>  
> -	if (!does_collide_order((unsigned long)old_pagedir, pagedir_order)) {
> -		printk("not necessary\n");
> -		return check_pagedir();
> -	}
> +	tail = pblist + PB_PAGE_SKIP;
>  
> -	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
> -		if (!does_collide_order((unsigned long)m, pagedir_order))
> -			break;
> -		eaten_memory = m;
> -		printk( "." ); 
> -		*eaten_memory = c;
> -		c = eaten_memory;
> -	}
> +	/* Relocate colliding pages */
>  
> -	if (!m) {
> -		printk("out of memory\n");
> -		ret = -ENOMEM;
> -	} else {
> -		pagedir_nosave =
> -			memcpy(m, old_pagedir, PAGE_SIZE << pagedir_order);
> +	for_each_pb_page(pbpage, pblist) {
> +		if (does_collide_order((unsigned long)pbpage, 0)) {
> +			m = (void *)get_usable_page(GFP_ATOMIC | __GFP_COLD);
> +			if (!m) {
> +				error = -ENOMEM;
> +				break;
> +			}
> +			memcpy(m, (void *)pbpage, PAGE_SIZE);
> +			if (pbpage == pblist)
> +				pblist = (struct pbe *)m;
> +			else
> +				tail->next = (struct pbe *)m;
> +
> +			free_page((unsigned long)pbpage);

Uh, you free it so that you can allocate it again, and again find out
that it is unusable? It will probably end up on list of unusable
pages, so it is okay, but...

> +			pbpage = (struct pbe *)m;
> +
> +			/* We have to link the PBEs again */
> +
> +			for (p = pbpage ; p < pbpage + PB_PAGE_SKIP ; p++)

I'd avoid " " before ;. 

> +		p = pbe;
> +		pbe += PB_PAGE_SKIP;
> +		do
> +			p->next = p + 1;
> +		while (p++ < pbe);

I've already seen this code somewhere around in different
variant... Perhaps you want to make it inline function?

> +		p->next = NULL;
> +		pr_debug("swsusp: Read %d pages, allocated %d PBEs\n", i, num);
> +		error = (i != swsusp_info.pagedir_pages); /* a sanity check */

If it is sanity check, do BUG_ON().
									

> +	if(!(p = read_pagedir()))
> +		return -EFAULT;

Is the value used? By using pointers instead of normal ints, you kill
possibility of meaningfull error reporting...

> +	if(!(pagedir_nosave = swsusp_pagedir_relocate(p)))
> +		return -ENOMEM;

Same here.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
