Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVCOWYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVCOWYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVCOWYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:24:09 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:8836 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261925AbVCOWUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:20:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp_restore crap
Date: Tue, 15 Mar 2005 23:23:27 +0100
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1110857069.29123.5.camel@gaston> <200503151555.44523.rjw@sisk.pl> <20050315204652.GA20521@elf.ucw.cz>
In-Reply-To: <20050315204652.GA20521@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503152323.27793.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 15 of March 2005 21:46, Pavel Machek wrote:
> Hi!
> 
> > > > > x86-64 needs this, too.... Otherwise it looks okay.
> > > > 
> > > > It breaks compilation on i386 either, because nr_copy_pages_check
> > > > is static in swsusp.c.  May I propose the following patch instead (tested on
> > > > x86-64 and i386)?
> > > 
> > > 
> > > > +asmlinkage int __swsusp_flush_tlb(void)
> > > > +{
> > > > +	swsusp_restore_check();
> > > 
> > > Someone will certainly forget this one, and it is probably
> > > nicer/easier to just move BUG_ON into swsusp_suspend(), just after
> > > restore_processor_state() or something like that...
> > 
> > ... in which case __swsusp_flush_tlb() would only contain a "call" to
> > __flush_tlb_global(), but this is a macro on both x86-64 and i386, so we can
> > drop the __swsusp_flush_tlb() altogether and do it in assembly (before the
> > GPRs are restored, perhaps).  Patch follows.
> > 
> > Greets,
> > Rafael
> > 
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > diff -Nrup linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S
> > --- linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S	2005-03-15 09:20:53.000000000 +0100
> > +++ linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S	2005-03-15 15:36:29.000000000 +0100
> > @@ -69,6 +69,14 @@ loop:
> >  	movq	pbe_next(%rdx), %rdx
> >  	jmp	loop
> >  done:
> > +	/* Flush TLB, including "global" things (vmalloc) */
> > +	movq	%rax, %rdx;  # mmu_cr4_features(%rip)
> 
> I somehow don't think %rax contains mmu_cr4_features at this
> point. Otherwise it seems to look ok.

Yes, it does, because on x86-64 the TLBs are flushed before the loop,
right after %cr3 is loaded with init_level4_pgt.  %rax is not touched
afterwards, so it contains the right value.  Here's the relevant code
from suspend_asm.S (with the patch applied):

ENTRY(swsusp_arch_resume)
	/* set up cr3 */	
	leaq	init_level4_pgt(%rip),%rax
	subq	$__START_KERNEL_map,%rax
	movq	%rax,%cr3

	movq	mmu_cr4_features(%rip), %rax
	movq	%rax, %rdx
	andq	$~(1<<7), %rdx	# PGE
	movq	%rdx, %cr4;  # turn off PGE
	movq	%cr3, %rcx;  # flush TLB
	movq	%rcx, %cr3;
	movq	%rax, %cr4;  # turn PGE back on

	movq	pagedir_nosave(%rip), %rdx
loop:
	testq	%rdx, %rdx
	jz	done

	/* get addresses from the pbe and copy the page */
	movq	pbe_address(%rdx), %rsi
	movq	pbe_orig_address(%rdx), %rdi
	movq	$512, %rcx
	rep
	movsq

	/* progress to the next pbe */
	movq	pbe_next(%rdx), %rdx
	jmp	loop
done:
	/* Flush TLB, including "global" things (vmalloc) */
	movq	%rax, %rdx;  # mmu_cr4_features(%rip)
	andq	$~(1<<7), %rdx;  # PGE
	movq	%rdx, %cr4;  # turn off PGE
	movq	%cr3, %rcx;  # flush TLB
	movq	%rcx, %cr3
	movq	%rax, %cr4;  # turn PGE back on


Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
