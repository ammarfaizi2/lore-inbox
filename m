Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVCOUwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVCOUwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVCOUtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:49:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261850AbVCOUrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:47:11 -0500
Date: Tue, 15 Mar 2005 21:46:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp_restore crap
Message-ID: <20050315204652.GA20521@elf.ucw.cz>
References: <1110857069.29123.5.camel@gaston> <200503151251.01109.rjw@sisk.pl> <20050315120217.GE1344@elf.ucw.cz> <200503151555.44523.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503151555.44523.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > x86-64 needs this, too.... Otherwise it looks okay.
> > > 
> > > It breaks compilation on i386 either, because nr_copy_pages_check
> > > is static in swsusp.c.  May I propose the following patch instead (tested on
> > > x86-64 and i386)?
> > 
> > 
> > > +asmlinkage int __swsusp_flush_tlb(void)
> > > +{
> > > +	swsusp_restore_check();
> > 
> > Someone will certainly forget this one, and it is probably
> > nicer/easier to just move BUG_ON into swsusp_suspend(), just after
> > restore_processor_state() or something like that...
> 
> ... in which case __swsusp_flush_tlb() would only contain a "call" to
> __flush_tlb_global(), but this is a macro on both x86-64 and i386, so we can
> drop the __swsusp_flush_tlb() altogether and do it in assembly (before the
> GPRs are restored, perhaps).  Patch follows.
> 
> Greets,
> Rafael
> 
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

> diff -Nrup linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S
> --- linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S	2005-03-15 09:20:53.000000000 +0100
> +++ linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S	2005-03-15 15:36:29.000000000 +0100
> @@ -69,6 +69,14 @@ loop:
>  	movq	pbe_next(%rdx), %rdx
>  	jmp	loop
>  done:
> +	/* Flush TLB, including "global" things (vmalloc) */
> +	movq	%rax, %rdx;  # mmu_cr4_features(%rip)

I somehow don't think %rax contains mmu_cr4_features at this
point. Otherwise it seems to look ok.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
