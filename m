Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266791AbUAWXjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266789AbUAWXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:39:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:6642 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266788AbUAWXjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:39:10 -0500
Message-ID: <4011B07F.5060409@mvista.com>
Date: Fri, 23 Jan 2004 15:38:39 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: PPC KGDB changes and some help?
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040121192230.GW13454@stop.crashing.org> <20040122174416.GJ15271@stop.crashing.org> <20040122180555.GK15271@stop.crashing.org> <20040123224605.GC15271@stop.crashing.org>
In-Reply-To: <20040123224605.GC15271@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Jan 22, 2004 at 11:05:55AM -0700, Tom Rini wrote:
> [snip]
> 
>>First up:
>>We need to call flush_instruction_cache() on a 'c' or 's' command.
>> arch/ppc/kernel/ppc-stub.c |   19 ++++++-------------
>> 1 files changed, 6 insertions(+), 13 deletions(-)
> 
> 
> On tpo of this patch, there's the following:
> Put back some code to figure out what signal we're dealing with.
> 
>  arch/ppc/kernel/ppc-stub.c |   63 ++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 60 insertions(+), 3 deletions(-)
> --- 1.15/arch/ppc/kernel/ppc-stub.c	Thu Jan 22 10:53:06 2004
> +++ edited/arch/ppc/kernel/ppc-stub.c	Fri Jan 23 15:43:10 2004
> @@ -3,6 +3,7 @@
>   *
>   * PowerPC-specific bits to work with the common KGDB stub.
>   *
> + * 1998 (c) Michael AK Tesch (tesch@cs.wisc.edu)
>   * 2003 (c) TimeSys Corporation
>   * 2004 (c) MontaVista Software, Inc.
>   * This file is licensed under the terms of the GNU General Public License
> @@ -19,13 +20,69 @@
>  #include <asm/processor.h>
>  #include <asm/machdep.h>
>  
> +/* Convert the hardware trap type code to a unix signal number. */
> +/*
> + * This table contains the mapping between PowerPC hardware trap types, and
> + * signals, which are primarily what GDB understands.
> + */
> +static struct hard_trap_info
> +{
> +	unsigned int tt;		/* Trap type code for powerpc */
> +	unsigned char signo;		/* Signal that we map this trap into */
> +} hard_trap_info[] = {
> +#if defined(CONFIG_40x)
> +	{ 0x100, SIGINT  },		/* critical input interrupt */
> +	{ 0x200, SIGSEGV },		/* machine check */
> +	{ 0x300, SIGSEGV },		/* data storage */
> +	{ 0x400, SIGBUS  },		/* instruction storage */
> +	{ 0x500, SIGINT  },		/* interrupt */
> +	{ 0x600, SIGBUS  },		/* alignment */
> +	{ 0x700, SIGILL  },		/* program */
> +	{ 0x800, SIGILL  },		/* reserved */
> +	{ 0x900, SIGILL  },		/* reserved */
> +	{ 0xa00, SIGILL  },		/* reserved */
> +	{ 0xb00, SIGILL  },		/* reserved */
> +	{ 0xc00, SIGCHLD },		/* syscall */
> +	{ 0xd00, SIGILL  },		/* reserved */
> +	{ 0xe00, SIGILL  },		/* reserved */
> +	{ 0xf00, SIGILL  },		/* reserved */
> +	{ 0x2000, SIGTRAP},		/* debug */
> +#else
> +	{ 0x200, SIGSEGV },		/* machine check */
> +	{ 0x300, SIGSEGV },		/* address error (store) */
> +	{ 0x400, SIGBUS },		/* instruction bus error */
> +	{ 0x500, SIGINT },		/* interrupt */
> +	{ 0x600, SIGBUS },		/* alingment */
> +	{ 0x700, SIGTRAP },		/* breakpoint trap */
> +	{ 0x800, SIGFPE },		/* fpu unavail */
> +	{ 0x900, SIGALRM },		/* decrementer */
> +	{ 0xa00, SIGILL },		/* reserved */
> +	{ 0xb00, SIGILL },		/* reserved */
> +	{ 0xc00, SIGCHLD },		/* syscall */
> +	{ 0xd00, SIGTRAP },		/* single-step/watch */
> +	{ 0xe00, SIGFPE },		/* fp assist */
> +#endif
> +	{ 0, 0}				/* Must be last */
> +};
> +
> +static int computeSignal(unsigned int tt)
> +{
> +	struct hard_trap_info *ht;
> +
> +	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
> +		if (ht->tt == tt)
> +			return ht->signo;
> +
> +	return SIGHUP; /* default for things we don't know about */
> +}
> +
>  /*
>   * Routines
>   */
>  static void
>  kgdb_debugger(struct pt_regs *regs)
>  {
> -	(*linux_debug_hook) (0, 0, 0, regs);
> +	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
>  	return;
>  }
>  
> @@ -52,14 +109,14 @@
>  int
>  kgdb_iabr_match(struct pt_regs *regs)
>  {
> -	(*linux_debug_hook) (0, 0, 0, regs);
> +	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
>  	return 1;
>  }
>  
>  int
>  kgdb_dabr_match(struct pt_regs *regs)
>  {
> -	(*linux_debug_hook) (0, 0, 0, regs);
> +	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
>  	return 1;
>  }
>  
> 
> Now, not being as well versed in all of the debugging infos that can be
> passed around, it sounds like this patch could be dropped in the future
> for a cleaner method using some of the dwarf2 bits being talked about.
> But I don't know, and clarification and pointers (if so) to how to do
> this would be appreciated.

I am not sure what this buys you.  I don't think dwarf2 will help here.

There is a real danger of passing signal info back to gdb as it will want to try 
to deliver the signal which is a non-compute in most kgdbs in the field.  I did 
put code in the mm-kgdb to do just this, but usually the arrival of such a 
signal (other than SIGTRAP) is the end of the kernel.  All that is left is to 
read the tea leaves.

On occasion, because there are traps in a lot of places, one gets to kgdb and 
wants to know just how it happened.  The way I like to do this is with the "l" 
command on the call to the kgdb handler.  In the above case, it would be on the 
return address of the appropiate one of the three functions.  To make this 
information available I defined a global structure (kdgd_info) which the stub 
updates on entry.  From this point of view and looking at the above code, I 
wonder a) why you need three functions, and b) why not just use what ever 
linux_debug_hook points to and let it do the signal decoding.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

