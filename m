Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbUBLGwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 01:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUBLGwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 01:52:33 -0500
Received: from ns.suse.de ([195.135.220.2]:21417 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265754AbUBLGwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 01:52:30 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][6/6] A different KGDB stub
References: <20040212000408.GG19676@smtp.west.cox.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Feb 2004 07:43:04 +0100
In-Reply-To: <20040212000408.GG19676@smtp.west.cox.net.suse.lists.linux.kernel>
Message-ID: <p73wu6syf0n.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> writes:

Andrew, please don't add this broken version.

> @@ -219,7 +219,7 @@
>  	jnc sysret_signal
>  	sti
>  	pushq %rdi
> -	call schedule
> +	call user_schedule

I really don't like this change. It is completely useless because you
can get the pt_regs as well from the stack.  Please don't add it.
George's stub also didn't need it.

> +#ifdef CONFIG_KGDB_THREAD
> +ENTRY(kern_schedule)

Similar. No such crap please.

> @@ -317,13 +318,26 @@
>  		return;
>  
>  	sum = read_pda(apic_timer_irqs);
> -	if (last_irq_sums[cpu] == sum) {
> +	if (atomic_read(&debugger_active)) {
> +
> +		/*
> +		 * The machine is in debugger, hold this cpu if already
> +		 * not held.
> +		 */
> +		debugger_nmihook(cpu, regs);
> +		alert_counter[cpu] = 0;

This should be a notify_die.

> +	} else if (last_irq_sums[cpu] == sum) {
> +
>  		/*
>  		 * Ayiee, looks like this CPU is stuck ...
>  		 * wait a few IRQs (5 seconds) before doing the oops ...
>  		 */
>  		alert_counter[cpu]++;
>  		if (alert_counter[cpu] == 5*nmi_hz) {
> +
> +			CHK_DEBUGGER(2,SIGSEGV,0,regs,)
> +
>  			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_BAD) { 

That's complete crap. You have a debugger hook and you add your own
hook one line before it. Please fix that.

I note that the old stub in -mm* didn't need such wards.


>  
>  void die(const char * str, struct pt_regs * regs, long err)
>  {
> +	CHK_DEBUGGER(1,SIGTRAP,err,regs,)

Same issue here. All the CHK_DEBUGGER are redundant with notify_die. 

> --- a/include/asm-x86_64/processor.h	Wed Feb 11 15:42:06 2004
> +++ b/include/asm-x86_64/processor.h	Wed Feb 11 15:42:06 2004
> @@ -252,6 +252,7 @@
>  	unsigned long	*io_bitmap_ptr;
>  /* cached TLS descriptors. */
>  	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
> +	void		*debuggerinfo;
>  };

This should not be needed
  
>  #define INIT_THREAD  {}
> --- a/include/asm-x86_64/system.h	Wed Feb 11 15:42:06 2004
> +++ b/include/asm-x86_64/system.h	Wed Feb 11 15:42:06 2004
> @@ -19,6 +19,56 @@
>  #define __SAVE(reg,offset) "movq %%" #reg ",(14-" #offset ")*8(%%rsp)\n\t"
>  #define __RESTORE(reg,offset) "movq (14-" #offset ")*8(%%rsp),%%" #reg "\n\t"
>  
> +/* #ifdef CONFIG_KGDB */
> +
> +/* full frame for the debug stub */
> +/* Should be replaced with a dwarf2 cie/fde description, then gdb could
> +   figure it out all by itself. */
> +struct save_context_frame { 

That's completely broken too. We have a full CFI description in the kernel
now, so this isn't needed anymore.

-Andi
