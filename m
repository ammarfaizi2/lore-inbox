Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVA1RZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVA1RZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVA1RZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:25:32 -0500
Received: from gprs213-105.eurotel.cz ([160.218.213.105]:3714 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261192AbVA1RZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:25:13 -0500
Date: Fri, 28 Jan 2005 18:24:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, hugang@soulinfo.com,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order memory allocations on suspend
Message-ID: <20050128172451.GD7551@elf.ucw.cz>
References: <200501281454.23167.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501281454.23167.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch is (yet) an(other) attempt to eliminate the need for using higher
> order memory allocations on suspend.  It accomplishes this by replacing the array
> of page backup entries with a list, so it is only necessary to allocate individual
> memory pages.
> 
> I have noticed that the suspend code in swsusp is actually independent of the
> resume code and vice versa, so it is not necessary to change them
> both at once.

:-) Heh, nice idea, but it is going to be really confusing to anyone
reading the code in between.

> Therefore I have decided, for now, to only modify the suspend part which is more
> straightforward.  The resume code is almost unaffected by this patch (the only
> thing changed in this code is a BUG_ON() that is removed).
> 
> The patch is against 2.6.11-rc2.  It has been tested and quite thoroughly debugged
> on x86-64.  Still, if anyone could test it on another architecture, I'd be grateful.
> Of course comments, suggestions etc. are welcome.

I'll do some testing later.

> diff -Nru linux-2.6.11-rc2-orig/include/linux/suspend.h linux-2.6.11-rc2/include/linux/suspend.h
> --- linux-2.6.11-rc2-orig/include/linux/suspend.h	2005-01-28 14:23:42.000000000 +0100
> +++ linux-2.6.11-rc2/include/linux/suspend.h	2005-01-28 13:53:36.000000000 +0100
> @@ -16,11 +16,20 @@
>  	unsigned long address;		/* address of the copy */
>  	unsigned long orig_address;	/* original address of page */
>  	swp_entry_t swap_address;	
> -	swp_entry_t dummy;		/* we need scratch space at 
> -					 * end of page (see link, diskpage)
> -					 */
> +
> +	struct pbe *next;

It is still used as a scratch space at end of page, please leave the
comment.

>  	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
> -	for (i = 0; i < nr_copy_pages && !error; i++) {
> +	for_each_pbe(p, pagedir_nosave) {
>  		if (!(i%mod))
>  			printk( "\b\b\b\b%3d%%", i / mod );
> -		error = write_page((pagedir_nosave+i)->address,
> -					  &((pagedir_nosave+i)->swap_address));
> +		error = write_page(p->address, &(p->swap_address));
> +		if (error)
> +			goto Exit;

Can you do return error instead? Goto is ugly. Or just break. Same in
next chunks.

>  
> -
> -static void calc_order(void)
> +static int calc_nr(int nr_copy)
>  {
> -	int diff = 0;
> -	int order = 0;
> +	int extra = 0;
> +	int mod = (nr_copy % PBES_PER_PAGE) ? 1 : 0;

!!( ) is usually used for this.

> +	int diff = (nr_copy / PBES_PER_PAGE) + mod;

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
