Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUBLPvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUBLPvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:51:01 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:22514 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S266492AbUBLPu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:50:57 -0500
Date: Thu, 12 Feb 2004 08:50:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [PATCH][6/6] A different KGDB stub
Message-ID: <20040212155055.GN19676@smtp.west.cox.net>
References: <20040212000408.GG19676@smtp.west.cox.net.suse.lists.linux.kernel> <p73wu6syf0n.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wu6syf0n.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 07:43:04AM +0100, Andi Kleen wrote:

> Tom Rini <trini@kernel.crashing.org> writes:
> 
> Andrew, please don't add this broken version.
> 
> > @@ -219,7 +219,7 @@
> >  	jnc sysret_signal
> >  	sti
> >  	pushq %rdi
> > -	call schedule
> > +	call user_schedule
> 
> I really don't like this change. It is completely useless because you
> can get the pt_regs as well from the stack.  Please don't add it.
> George's stub also didn't need it.
> 
> > +#ifdef CONFIG_KGDB_THREAD
> > +ENTRY(kern_schedule)
> 
> Similar. No such crap please.

Amit?  I seem to recall you and George (and Andi?) talking about how to
get rid of these bits, did you ever write any of it up?

> > @@ -317,13 +318,26 @@
> >  		return;
> >  
> >  	sum = read_pda(apic_timer_irqs);
> > -	if (last_irq_sums[cpu] == sum) {
> > +	if (atomic_read(&debugger_active)) {
> > +
> > +		/*
> > +		 * The machine is in debugger, hold this cpu if already
> > +		 * not held.
> > +		 */
> > +		debugger_nmihook(cpu, regs);
> > +		alert_counter[cpu] = 0;
> 
> This should be a notify_die.

Not being firmiliar with x86_64, do you mean:
		/*
		 * The machine is in debugger, hold this cpu if already
		 * not held.
		 */
		 notify_die(cpu, regs);
? Or so?

> > +	} else if (last_irq_sums[cpu] == sum) {
> > +
> >  		/*
> >  		 * Ayiee, looks like this CPU is stuck ...
> >  		 * wait a few IRQs (5 seconds) before doing the oops ...
> >  		 */
> >  		alert_counter[cpu]++;
> >  		if (alert_counter[cpu] == 5*nmi_hz) {
> > +
> > +			CHK_DEBUGGER(2,SIGSEGV,0,regs,)
> > +
> >  			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_BAD) { 
> 
> That's complete crap. You have a debugger hook and you add your own
> hook one line before it. Please fix that.

Yes, Amit's version does this on PPC32 as well, and I'd like to change
it, but I've been cleaning up other things.

> > --- a/include/asm-x86_64/processor.h	Wed Feb 11 15:42:06 2004
> > +++ b/include/asm-x86_64/processor.h	Wed Feb 11 15:42:06 2004
> > @@ -252,6 +252,7 @@
> >  	unsigned long	*io_bitmap_ptr;
> >  /* cached TLS descriptors. */
> >  	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
> > +	void		*debuggerinfo;
> >  };
> 
> This should not be needed

What would be used instead to pass around the pt_regs?

> > --- a/include/asm-x86_64/system.h	Wed Feb 11 15:42:06 2004
> > +++ b/include/asm-x86_64/system.h	Wed Feb 11 15:42:06 2004
> > @@ -19,6 +19,56 @@
> >  #define __SAVE(reg,offset) "movq %%" #reg ",(14-" #offset ")*8(%%rsp)\n\t"
> >  #define __RESTORE(reg,offset) "movq (14-" #offset ")*8(%%rsp),%%" #reg "\n\t"
> >  
> > +/* #ifdef CONFIG_KGDB */
> > +
> > +/* full frame for the debug stub */
> > +/* Should be replaced with a dwarf2 cie/fde description, then gdb could
> > +   figure it out all by itself. */
> > +struct save_context_frame { 
> 
> That's completely broken too. We have a full CFI description in the kernel
> now, so this isn't needed anymore.

Part of why I'm trying to get this into -mm is so that someone who has
the hw and knowledge can try and merge some of the things that the other
stubs got right into the stub that every arch can use.

-- 
Tom Rini
http://gate.crashing.org/~trini/
