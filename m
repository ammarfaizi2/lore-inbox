Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVCOXlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVCOXlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVCOXlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:41:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13990 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262127AbVCOXj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:39:59 -0500
Date: Wed, 16 Mar 2005 00:39:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp_restore crap
Message-ID: <20050315233945.GF21292@elf.ucw.cz>
References: <1110857069.29123.5.camel@gaston> <200503151555.44523.rjw@sisk.pl> <20050315204652.GA20521@elf.ucw.cz> <200503152323.27793.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503152323.27793.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > > diff -Nrup linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S
> > > --- linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S	2005-03-15 09:20:53.000000000 +0100
> > > +++ linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S	2005-03-15 15:36:29.000000000 +0100
> > > @@ -69,6 +69,14 @@ loop:
> > >  	movq	pbe_next(%rdx), %rdx
> > >  	jmp	loop
> > >  done:
> > > +	/* Flush TLB, including "global" things (vmalloc) */
> > > +	movq	%rax, %rdx;  # mmu_cr4_features(%rip)
> > 
> > I somehow don't think %rax contains mmu_cr4_features at this
> > point. Otherwise it seems to look ok.
> 
> Yes, it does, because on x86-64 the TLBs are flushed before the loop,
> right after %cr3 is loaded with init_level4_pgt.  %rax is not touched
> afterwards, so it contains the right value.  Here's the relevant code
> from suspend_asm.S (with the patch applied):

Well, it is mmu_cr4_features from "old" kernel, while you are flushing
tlb in "new" kernel. It is probably same anyway, but.... %rax is
commonly-used scratch register, and memory load is not that
expensive. Can you just load it from memory?
								Pavel

> ENTRY(swsusp_arch_resume)
> 	/* set up cr3 */	
> 	leaq	init_level4_pgt(%rip),%rax
> 	subq	$__START_KERNEL_map,%rax
> 	movq	%rax,%cr3
> 
> 	movq	mmu_cr4_features(%rip), %rax
> 	movq	%rax, %rdx
> 	andq	$~(1<<7), %rdx	# PGE
> 	movq	%rdx, %cr4;  # turn off PGE
> 	movq	%cr3, %rcx;  # flush TLB
> 	movq	%rcx, %cr3;
> 	movq	%rax, %cr4;  # turn PGE back on
> 
> 	movq	pagedir_nosave(%rip), %rdx
> loop:
> 	testq	%rdx, %rdx
> 	jz	done
> 
> 	/* get addresses from the pbe and copy the page */
> 	movq	pbe_address(%rdx), %rsi
> 	movq	pbe_orig_address(%rdx), %rdi
> 	movq	$512, %rcx
> 	rep
> 	movsq
> 
> 	/* progress to the next pbe */
> 	movq	pbe_next(%rdx), %rdx
> 	jmp	loop
> done:
> 	/* Flush TLB, including "global" things (vmalloc) */
> 	movq	%rax, %rdx;  # mmu_cr4_features(%rip)
> 	andq	$~(1<<7), %rdx;  # PGE
> 	movq	%rdx, %cr4;  # turn off PGE
> 	movq	%cr3, %rcx;  # flush TLB
> 	movq	%rcx, %cr3
> 	movq	%rax, %cr4;  # turn PGE back on
> 
> 
> Greets,
> Rafael
> 
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
