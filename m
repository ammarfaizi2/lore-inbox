Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUDBAfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbUDBAfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:35:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40338
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263032AbUDBAfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:35:20 -0500
Date: Fri, 2 Apr 2004 02:35:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: Properly stop kernel threads on aic7xxx
Message-ID: <20040402003520.GH18585@dualathlon.random>
References: <20040401170808.GA696@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401170808.GA696@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 07:08:08PM +0200, Pavel Machek wrote:
> Hi!
> 
> This is totally untested patch that should make aic7xxx one step
> closer to working with software suspend... Plus it kills ugly #if in
> the process.
> 								Pavel 
> 
> --- tmp/linux/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-03-11 18:11:12.000000000 +0100
> +++ linux/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-04-01 19:01:29.000000000 +0200
> @@ -2581,17 +2581,8 @@
>  	 * Complete thread creation.
>  	 */
>  	lock_kernel();
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,60)
> -	/*
> -	 * Don't care about any signals.
> -	 */
> -	siginitsetinv(&current->blocked, 0);
> -
> -	daemonize();
> -	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
> -#else
>  	daemonize("ahd_dv_%d", ahd->unit);
> -#endif
> +	current->flags |= PF_IOTHREAD;
>  	unlock_kernel();
>  
>  	while (1) {
> --- tmp/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-03-11 18:11:12.000000000 +0100
> +++ linux/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-04-01 19:01:08.000000000 +0200
> @@ -2286,17 +2286,8 @@
>  	 * Complete thread creation.
>  	 */
>  	lock_kernel();
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> -	/*
> -	 * Don't care about any signals.
> -	 */
> -	siginitsetinv(&current->blocked, 0);
> -
> -	daemonize();
> -	sprintf(current->comm, "ahc_dv_%d", ahc->unit);
> -#else
>  	daemonize("ahc_dv_%d", ahc->unit);
> -#endif
> +	current->flags |= PF_IOTHREAD;
>  	unlock_kernel();
>  
>  	while (1) {

This fixed the hang, I can reproduce the oops now.

Pavel the current CVS would work fine if only you wouldn't try to do I/O
on compound pages via rw_page_swap_sync. That thing now collides with
anon-vma (though it should work fine if you would backout anon-vma since
the rw_page_swap_sync wouldn't touch page->private anymore).

I'm not exactly sure how to fix this collision right now. there are
various ways, probably something that will work perfectly is to just clear
PG_compound in rw_swap_page_sync and to set it back before returning (if
it was set at the entry point), though I'd take it as last resort...
thinking about it. Comments welcome.

I'm also unsure why _all_ multipage allocations really need this
compound thing setup and why can't the owner of the page take care of
the refcounting itself by always using the head page. I may actually
add a GFP bitflag asking for a multipage but w/o a compound setup. There
are million ways to fix this, none of which is obvious.
