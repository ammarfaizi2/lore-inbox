Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUCAMd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 07:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUCAMd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 07:33:26 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:45701 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261238AbUCAMdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 07:33:19 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][4/7] Fix x86_64 hooks
Date: Mon, 1 Mar 2004 18:03:05 +0530
User-Agent: KMail/1.5
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227213254.GE1052@smtp.west.cox.net> <20040227214031.GF1052@smtp.west.cox.net>
In-Reply-To: <20040227214031.GF1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011803.05687.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess you haven't tested this on an x86_64 machine. Please checkin. I'll 
test once you do that. If there is something incorrect (unlikely), I'll fix 
it.

-Amit


On Saturday 28 Feb 2004 3:10 am, Tom Rini wrote:
> Hello.  The following is more complicated than it looks.  This makes the
> x86_64 stub add kgdb to the die_chain, and then remove all of the now
> unneeded CHK_DEBUGGER statements, and other whitespace changes.  In the
> end, the x86_64 patch looks like:
>  arch/x86_64/Kconfig            |    4
>  arch/x86_64/kernel/Makefile    |    1
>  arch/x86_64/kernel/entry.S     |   41 +++
>  arch/x86_64/kernel/irq.c       |    2
>  arch/x86_64/kernel/kgdb.c      |  478
> +++++++++++++++++++++++++++++++++++++++++ arch/x86_64/kernel/traps.c     | 
>   3
>  include/asm-x86_64/kgdb.h      |   54 ++++
>  include/asm-x86_64/processor.h |    1
>  8 files changed, 577 insertions(+), 7 deletions(-)
>
> As an aside, I now know how to kill off user_schedule bits on i386/x86_64,
> so with more thought on how to do it cleanly for everyone, the entry.S
> changes can die.
>
> diff -zrupN linux-2.6.3+config+serial/arch/x86_64/kernel/kgdb.c
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/x86_64/kernel/kgdb.c ---
> linux-2.6.3+config+serial/arch/x86_64/kernel/kgdb.c	2004-02-27
> 12:16:13.000000000 -0700 +++
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/x86_64/kernel/kgdb.c	2004-0
>2-27 12:16:14.000000000 -0700 @@ -41,6 +41,7 @@
>  #endif
>  #include <linux/init.h>
>  #include <linux/debugger.h>
> +#include <asm/kdebug.h>
>
>  /* Put the error code here just in case the user cares.  */
>  int gdb_x86_64errcode;
> @@ -443,6 +444,33 @@ struct pt_regs *kgdb_shadow_regs(struct
>  	return NULL;
>  }
>
> +/* Register KGDB with the die_chain so that we hook into all of the right
> + * spots. */
> +static int kgdb_notify(struct notifier_block *self, unsigned long cmd,
> +		void *ptr)
> +{
> +        struct die_args *d = ptr;
> +
> +        if (!kgdb_connected || (cmd == DIE_DEBUG && user_mode(d->regs)))
> +                return NOTIFY_DONE;
> +        if (cmd == DIE_NMI_IPI) {
> +                if (atomic_read(debugger_active))
> +                        return NOTIFY_BAD;
> +        } else if ((*linux_debug_hook)(d->trapnr, d->signr, d->err,
> d->regs)) +                return NOTIFY_BAD; /* skip */
> +
> +        return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block kgdb_notifier = {
> +        .notifier_call = kgdb_notify,
> +};
> +
> +int kgdb_arch_init(void)
> +{
> +	notifier_chain_register(&die_chain, &kgdb_notifier);
> +}
> +
>  struct kgdb_arch arch_kgdb_ops = {
>  	.gdb_bpt_instr = {0xcc},
>  	.flags = KGDB_HW_BREAKPOINT,
> diff -zrupN linux-2.6.3+config+serial/arch/x86_64/kernel/nmi.c
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/x86_64/kernel/nmi.c ---
> linux-2.6.3+config+serial/arch/x86_64/kernel/nmi.c	2004-02-27
> 12:16:13.000000000 -0700 +++
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/x86_64/kernel/nmi.c	2004-02
>-27 12:11:20.000000000 -0700 @@ -24,7 +24,6 @@
>  #include <linux/module.h>
>  #include <linux/sysdev.h>
>  #include <linux/nmi.h>
> -#include <linux/debugger.h>
>
>  #include <asm/smp.h>
>  #include <asm/mtrr.h>
> @@ -318,26 +317,13 @@ void nmi_watchdog_tick (struct pt_regs *
>  		return;
>
>  	sum = read_pda(apic_timer_irqs);
> -	if (atomic_read(&debugger_active)) {
> -
> -		/*
> -		 * The machine is in debugger, hold this cpu if already
> -		 * not held.
> -		 */
> -		debugger_nmihook(cpu, regs);
> -		alert_counter[cpu] = 0;
> -
> -	} else if (last_irq_sums[cpu] == sum) {
> -
> +	if (last_irq_sums[cpu] == sum) {
>  		/*
>  		 * Ayiee, looks like this CPU is stuck ...
>  		 * wait a few IRQs (5 seconds) before doing the oops ...
>  		 */
>  		alert_counter[cpu]++;
>  		if (alert_counter[cpu] == 5*nmi_hz) {
> -
> -			CHK_DEBUGGER(2,SIGSEGV,0,regs,)
> -
>  			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_BAD)
> { alert_counter[cpu] = 0;
>  				return;
> diff -zrupN linux-2.6.3+config+serial/arch/x86_64/kernel/traps.c
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/x86_64/kernel/traps.c ---
> linux-2.6.3+config+serial/arch/x86_64/kernel/traps.c	2004-02-27
> 12:16:13.000000000 -0700 +++
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/x86_64/kernel/traps.c	2004-
>02-27 12:16:14.000000000 -0700 @@ -364,7 +364,6 @@ void __die(const char *
> str, struct pt_r
>
>  void die(const char * str, struct pt_regs * regs, long err)
>  {
> -	CHK_DEBUGGER(1,SIGTRAP,err,regs,)
>  	oops_begin();
>  	handle_BUG(regs);
>  	__die(str, regs, err);
> @@ -438,7 +437,6 @@ static void do_trap(int trapnr, int sign
>  #define DO_ERROR(trapnr, signr, str, name) \
>  asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
>  { \
> -	CHK_DEBUGGER(1,SIGTRAP,error_code,regs,return) \
>  	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) ==
> NOTIFY_BAD) \ return; \
>  	do_trap(trapnr, signr, str, regs, error_code, NULL); \
> @@ -646,7 +644,6 @@ asmlinkage void do_debug(struct pt_regs
>  	force_sig_info(SIGTRAP, &info, tsk);
>  clear_dr7:
>  	asm volatile("movq %0,%%db7"::"r"(0UL));
> -	CHK_DEBUGGER(1,SIGTRAP,error_code,regs,return)
>  	notify_die(DIE_DEBUG, "debug", regs, error_code, 1, SIGTRAP);
>  	return;
>
> diff -zrupN linux-2.6.3+config+serial/arch/x86_64/mm/fault.c
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/x86_64/mm/fault.c ---
> linux-2.6.3+config+serial/arch/x86_64/mm/fault.c	2004-02-27
> 12:16:13.000000000 -0700 +++
> linux-2.6.3+config+serial+sysrq+arch_hooks/arch/x86_64/mm/fault.c	2004-02-2
>7 12:10:49.000000000 -0700 @@ -23,7 +23,6 @@
>  #include <linux/vt_kern.h>		/* For unblank_screen() */
>  #include <linux/compiler.h>
>  #include <linux/module.h>
> -#include <linux/debugger.h>
>
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> @@ -408,7 +407,6 @@ no_context:
>
>   	if (is_prefetch(regs, address))
>   		return;
> -	CHK_DEBUGGER(14, SIGSEGV,error_code, regs,)
>
>  	if (is_errata93(regs, address))
>  		return;
> diff -zrupN linux-2.6.3+config+serial/include/asm-x86_64/calling.h
> linux-2.6.3+config+serial+sysrq+arch_hooks/include/asm-x86_64/calling.h ---
> linux-2.6.3+config+serial/include/asm-x86_64/calling.h	2004-02-27
> 12:16:13.000000000 -0700 +++
> linux-2.6.3+config+serial+sysrq+arch_hooks/include/asm-x86_64/calling.h	200
>4-02-27 12:12:03.000000000 -0700 @@ -12,7 +12,7 @@
>  #define RBX 40
>  /* arguments: interrupts/non tracing syscalls only save upto here*/
>  #define R11 48
> -#define R10 56
> +#define R10 56
>  #define R9 64
>  #define R8 72
>  #define RAX 80

