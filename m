Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWIWASd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWIWASd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWIWASd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:18:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:49613 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932204AbWIWASb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:18:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Luke Yang" <luke.adi@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Sat, 23 Sep 2006 02:18:36 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
In-Reply-To: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609230218.36894.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday 21 September 2006 05:32 schrieb Luke Yang:
>   This is the blackfin architecture for 2.6.18, again. As we promised,
> we fixed some issues in our old patches as following.
>
> - use serial core in that driver
>
> - Fix up that ioctl so it a) doesn't sleep in spinlock and b) compiles
>
> - Use generic IRQ framework
>
> - Review all the volatiles, consolidate them in some helper-in-header-file.
>
>   And we also fixed a lot of other issues and ported it to 2.6.18 now.
> As usual, this architecture patch is too big so I just give a link
> here. Please review it and give you comments, we really appreciate.

I've done a brief review. Overall, it looks fine, but you have lots of
code duplication between your specific machines. It would be good
to generalize that further.

There are a few device drivers in there that should probably be
separate patches.

Most of my review is about your syscall interface, which looks like
you blindly copied many of the warts of other platforms, including
the comments telling you not to do it that way.

It would be good if you can get your code to build cleanly when using
C=1 with sparse, right now that clearly won't work.

In a lot of places your whitespace seems broken. Make sure you don't have
whitespace at the end of a line or spaces instead of tabs for indentation.

Detailed comments follow

> +/*#define IRQ_DEBUG*/
> +#undef IRQ_DEBUG
> +
> +#ifdef IRQ_DEBUG
> +#define IRQ_DPRINTK(x...)	printk(x)
> +#else
> +#define IRQ_DPRINTK(x...)	do { } while (0)
> +#endif

Use pr_debug here instead of making up your own macros

> +
> +static volatile unsigned long irq_err_count;

volatile doesn't help here. either make it atomic_t if you want it
to be safe or don't bother

> +
> +#define DEBUGP(fmt...)
> +

pr_debug

> +static uint32_t reloc_stack_operate(unsigned int oper, struct module *mod)
> +{
> +	uint32_t value;
> +	switch (oper) {
> +	case R_add:
> +		{
> +			value =
> +			    reloc_stack[reloc_stack_tos - 2] +
> +			    reloc_stack[reloc_stack_tos - 1];
> +			reloc_stack_tos -= 2;
> +			break;
> +		}

no need for the curly braces here and below

> +inline void static leds_switch(int flag);

static inline void

Note that marking the function inline doesn't help if the definition comes
after the first use.

> +inline static void default_idle(void)

static inline void default_idle(void)

> +{
> +	while (!need_resched()) {
> +		leds_switch(LED_OFF);
> +	      __asm__("nop;\n\t \
> +                         nop;\n\t \
> +                         nop;\n\t \
> +                         idle;\n\t": : :"cc");
> +		leds_switch(LED_ON);
> +	}
> +}
> +

This looks racy. What if you get an interrupt after testing need_resched()
but before the idle instruction?

Normally, this should look like

	while(!need_resched()) {
		local_irq_disable();
		if (!need_resched())
			asm volatile("idle");
		local_irq_enable();
	}

Of course that only works if your idle instruction wakes up on pending 
interrupts.

> +/*
> + * sys_execve() executes a new program.
> + */
> +
> +asmlinkage int sys_execve(char *name, char **argv, char **envp)
> +{
> +	int error;
> +	char *filename;
> +	struct pt_regs *regs = (struct pt_regs *)((&name) + 6);
> +
> +	lock_kernel();
> +	filename = getname(name);
> +	error = PTR_ERR(filename);
> +	if (IS_ERR(filename))
> +		goto out;
> +	error = do_execve(filename, argv, envp, regs);
> +	putname(filename);
> +      out:
> +	unlock_kernel();
> +	return error;
> +}

You also need a kernel_execve() function because of changes in -mm.

> +
> +	switch (request) {
> +		/* when I and D space are separate, these will need to be fixed. */
> +	case PTRACE_PEEKDATA:
> +#ifdef DEBUG
> +		printk("PTRACE_PEEKDATA\n");
> +#endif

pr_debug again, here and elsewhere in ptrace.c

> +			if (is_user_addr_valid(child, addr + add, sizeof(tmp)) <
> +			    0)
> +				break;
> +
> +			copied =
> +			    access_process_vm(child, addr + add, &tmp,
> +					      sizeof(tmp), 0);

interesting indentation ;-). Maybe you should move some of these into separate
functions if you run out of horizontal space.

 +
> +/*
> + * Atomically swap in the new signal mask, and wait for a signal.
> + *
> + */
> +asmlinkage int sys_sigsuspend(old_sigset_t mask)
> +{

> +
> +asmlinkage int
> +sys_sigaction(int sig, const struct old_sigaction *act,
> +	      struct old_sigaction *oact)
> +{

> +
> +asmlinkage int sys_sigaltstack(const stack_t * uss, stack_t * uoss)
> +{

> +static inline int
> +restore_sigcontext(struct pt_regs *regs, struct sigcontext *usc, int *pr0)
> +{

Do yourself a favour and kill the old-style signal infrastructure. You only 
need
the sys_rt_* variant of these, and they are provided in common code.

> +asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
> +			  unsigned long prot, unsigned long flags,
> +			  unsigned long fd, unsigned long pgoff)
> +{
> +	return do_mmap2(addr, len, prot, flags, fd, pgoff);
> +}
> +
> +asmlinkage int sys_mmap(unsigned long addr, unsigned long len,
> +			unsigned long prot, unsigned long flags,
> +			unsigned long fd, unsigned long pgoff)
> +{

No need for sys_mmap _and sys_mmap2, better handle this in libc.

> + * Perform the select(nd, in, out, ex, tv) and mmap() system
> + * calls. Linux/bfin cloned Linux/i386, which didn't use to be able to
> + * handle more than 4 system call parameters, so these system calls
> + * used a memory block for parameter passing..
> + */
> +
> +struct sel_arg_struct {
> +	unsigned long n;
> +	fd_set *inp, *outp, *exp;
> +	struct timeval *tvp;
> +};
> +
> +asmlinkage int old_select(struct sel_arg_struct *arg)
> +{

This sounds like a weird argumentation. Since you're defining a syscall
ABI, just make it use six argument registers instead of copying a
hack that was a bad idea to start with.


> + *
> + * This is really horribly ugly.
> + */
> +asmlinkage int
> +sys_ipc(uint call, int first, int second, int third, void *ptr, long fifth)

If it's so ugly then don't copy it!

sys_ipc is not needed at all, just add sys_semop/sys_semget/... to your
sys_call_table directly.

> +{
> +	int version, ret;
> +
> +	version = call >> 16;	/* hack for backward compatibility */
> +	call &= 0xffff;

Especially since I hope you don't need compatibility to XENIX binaries ;-)

 +
> +#ifndef TRAPS_DEBUG
> +# define TRAPS_DEBUG 0
> +#endif
> +
> +#if (TRAPS_DEBUG > 2 )
> +# define DPRINTK3(args...) printk(KERN_DEBUG args)
> +#else
> +# define DPRINTK3(args...)
> +#endif
> +
> +#if (TRAPS_DEBUG > 1)
> +# define DPRINTK2(args...) printk(KERN_DEBUG args)
> +#else
> +# define DPRINTK2(args...)
> +#endif
> +
> +#ifdef TRAPS_DEBUG
> +# define DPRINTK1(args...) printk(KERN_DEBUG args)
> +#else
> +# define DPRINTK1(args...)
> +#endif
> +

And yet another set of macros you don't need.

> +#if defined(CONFIG_SPI_BFIN) || defined(CONFIG_SPI_BFIN_MODULE)
> +/* all SPI perpherals info goes here */
> +
> +static struct mtd_partition bfin_spi_flash_partitions[] = {
> +	{
> +	      name:"bootloader",
> +	      size:0x00040000,
> +	      offset:0,
> +      mask_flags:MTD_CAP_ROM}, {
> +	      name:	"kernel",
> +	      size:	0xc0000,
> +      offset:		0x40000}, {
> +	      name:		   "file system",
> +	      size:		   0x300000,
> +	      offset:		   0x00100000,
> +				   }
> +};

It would be nice if you could use a generic way to pass this partition data
to the kernel from the mtd medium, instead of hardcoding it here.

> +/*
> + * When we call pm_suspend, that code  enters into idle state.
> + * When there is any interrupt,the core will resume
> + */
> +void bf533_pm_suspend(void)
> +{
> +	unsigned long flags;
> +
> +	/*FIXME: Add a useful Power Saving Mode Here ... */
> +
> +	local_irq_save(flags);
> +	bfin_write_SIC_IWR(IWR_ENABLE_ALL);
> +	__builtin_bfin_ssync();
> +	asm("IDLE;");
> +	local_irq_restore(flags);
> +
> +}

I guess you should check for need_resched() here, before calling IDLE.

> +		enable_dma(CH_MEM_STREAM2_SRC);
> +		enable_dma(CH_MEM_STREAM2_DEST);
> +
> +		interruptible_sleep_on(&coreb_dma_wait);
> +
> +		disable_dma(CH_MEM_STREAM2_SRC);
> +		disable_dma(CH_MEM_STREAM2_DEST);

never ever use sleep_on() in new code. wait_event_interruptible is what you
want instead.

> +
> +static struct file_operations coreb_fops = {
> +      owner:THIS_MODULE,
> +      llseek:coreb_lseek,
> +      read:coreb_read,
> +      write:coreb_write,
> +      ioctl:coreb_ioctl,
> +      open:coreb_open,
> +      release:coreb_release
> +};

Use C99 initializers here, like

	.owner = THIS_MODULE,

Actually, since you did not fix this already, I assume you haven't run all of
your code through sparse yet. It's a good idea to run sparse on anthing you
intend for inclusion and then fix the warnings you get.

> +	printk(KERN_INFO "Core B: Initializing /proc\n");
> +	coreb_proc_entry = create_proc_entry("coreb", 0, NULL);
> +	if (coreb_proc_entry) {
> +		coreb_proc_entry->owner = THIS_MODULE;
> +		coreb_proc_entry->read_proc = coreb_read_status;
> +	} else {
> +		printk(KERN_ERR "Core B: Unable to register /proc/coreb\n");
> +		goto release_dma_src;
> +	}

Errm, no.

You should not add random files to procfs. Since you already register a misc
device for this, you have a node in /sys where you can add attributes for
the various data you want to export

> +static char *cplb_print_entry(char *buf, int type)
> +{
> +	unsigned long *p_addr = dpdt_table;
> +	unsigned long *p_data = dpdt_table + 1;
> +	unsigned long *p_icount = dpdt_swapcount_table;
> +	unsigned long *p_ocount = dpdt_swapcount_table + 1;
> +	unsigned long *cplb_addr = (unsigned long *)DCPLB_ADDR0;
> +	unsigned long *cplb_data = (unsigned long *)DCPLB_DATA0;
> +	int entry, used_cplb = 0;
> +
> +	if (type == CPLB_I) {
> +		buf += sprintf(buf, "Instrction CPLB entry:\n");
> +		p_addr = ipdt_table;
> +		p_data = ipdt_table + 1;
> +		p_icount = ipdt_swapcount_table;
> +		p_ocount = ipdt_swapcount_table + 1;
> +		cplb_addr = (unsigned long *)ICPLB_ADDR0;
> +		cplb_data = (unsigned long *)ICPLB_DATA0;
> +	} else
> +		buf += sprintf(buf, "Data CPLB entry:\n");
> +
> +	buf += sprintf(buf, "Address\t\tData\tSize\tValid\tLocked\tSwapin\
> +\tiCount\toCount\n");
> +
> +	while (*p_addr != 0xffffffff) {
> +		entry = cplb_find_entry(cplb_addr, cplb_data, *p_addr);
> +		if (entry >= 0 && *p_data == cplb_data[entry])
> +			used_cplb |= 1 << entry;
> +
> +		buf +=
> +		    sprintf(buf,
> +			    "0x%08lx\t0x%05lx\t%s\t%c\t%c\t%2d\t%ld\t%ld\n",
> +			    *p_addr, *p_data,
> +			    page_size_string_table[(*p_data & 0x30000) >> 16],
> +			    (*p_data & CPLB_VALID) ? 'Y' : 'N',
> +			    (*p_data & CPLB_LOCK) ? 'Y' : 'N', entry, *p_icount,
> +			    *p_ocount);
> +
> +		p_addr += 2;
> +		p_data += 2;
> +		p_icount += 2;
> +		p_ocount += 2;
> +	}
> +
> +	if (used_cplb != 0xffff) {
> +		buf += sprintf(buf, "Unused/mismatched CPLBs:\n");
> +
> +		for (entry = 0; entry < 16; entry++)
> +			if (0 == ((1 << entry) & used_cplb)) {
> +				int flags = cplb_data[entry];
> +				buf +=
> +				    sprintf(buf,
> +					    "%2d: 0x%08lx\t0x%05x\t%s\t%c\t%c\n",
> +					    entry, cplb_addr[entry], flags,
> +					    page_size_string_table[(flags &
> +								    0x30000) >>
> +								   16],
> +					    (flags & CPLB_VALID) ? 'Y' : 'N',
> +					    (flags & CPLB_LOCK) ? 'Y' : 'N');
> +			}
> +	}
> +
> +	buf += sprintf(buf, "\n");
> +
> +	return buf;
> +}

Another one of those files that just don't belong in procfs. Find some other
interface for this.

> +
> +ALIGN
> +ENTRY(_sys_call_table)
> +	.long _sys_ni_syscall	/* 0  -  old "setup()" system call*/
> +	.long _sys_exit

There is not much point in trying to use the same numbers as an existing
architecture if that means that you have to leave holes like setup().
I don't know if you still have the choice of completely changing the
syscall numbers, but it would make it nicer in the future.

> +	.long _sys_waitpid

kill, just use wait4

> +	.long _sys_chown16

kill all 16 bit uid syscalls

> +	.long _sys_stat

use stat64 instead

> +	.long _sys_lseek

use llseek instead

> +	.long _sys_mount
> +	.long _sys_oldumount

sys_mount is enough

> +	.long _sys_setuid16
> +	.long _sys_getuid16

no uid16 syscalls please, uid_t is __u32

> +	.long _sys_utime		/* 30 */

sys_utimes

> +	.long _sys_setgid16
> +	.long _sys_getgid16
> +	.long _sys_geteuid16
> +	.long _sys_getegid16	/* 50 */

uit32

> +	.long _sys_sigaction

use rt signals

> +	.long _sys_setreuid16	/* 70 */
> +	.long _sys_setregid16

uid32

> +	.long _sys_sigsuspend
> +	.long _sys_sigpending

rt signals

> +	.long _sys_setrlimit	/* 75 */
> +	.long _sys_old_getrlimit

sys_getrlimit

> +	.long _sys_getgroups16	/* 80 */
> +	.long _sys_setgroups16

uid32

> +	.long _old_select

kill

> +	.long _sys_lstat

lstat64

> +	.long _sys_uselib

kill
> +	.long _old_readdir

kill

> +	.long _sys_mmap		/* 90 */

mmap2

> +	.long _sys_truncate
> +	.long _sys_ftruncate

{f,}truncate64

> +	.long _sys_fchown16	/* 95 */

uid32

> +	.long _sys_socketcall

Replace this with the actual socket syscalls. sys_socketcall must
go the way of sys_ipc

> +	.long _sys_newstat
> +	.long _sys_newlstat
> +	.long _sys_newfstat

see above. No need for three versions of stat.

> +	.long _sys_ipc

as mentioned

> +	.long _sys_sigreturn

rt signals

> +	.long _sys_sysfs		/* 135 */

just kill this

> +	.long _sys_setfsuid16
> +	.long _sys_setfsgid16

uid32

> +	.long _sys_setresuid16
> +	.long _sys_getresuid16	/* 165 */

uid32

> +	.long _sys_poll

I guess we can now replace select and poll with pselect and ppoll
in new architectures.

> +	.long _sys_setresgid16	/* 170 */
> +	.long _sys_getresgid16

uid32

> +static __inline__ void atomic_add(int i, atomic_t * v)
> +{
> +	int __temp = 0;
> +	__asm__ __volatile__(
> +		"cli R3;\n\t"
> +			     "%0 = %1;\n\t"
> +			     "%0 = %0 + %2;\n\t"
> +			     "%1 = %0;\n\t"
> +		"sti R3;\n\t"
> +		: "=d" (__temp), "=m" (v->counter)
> +			     :"d"(i), "m"(v->counter), "0"(__temp)
> +			     :"R3");
> +}

Can't you let the compile choose a register instead of forcing it to
use R3?

>From what I can tell, doing this in C as

	long flags;
	local_irq_save(flags);
	v->val += i;
	local_irq_restore(flags);

should result in better code than this

> diff -urN linux-2.6.18/include/asm-blackfin/blackfin.h 
linux-2.6.18.patch1/include/asm-blackfin/blackfin.h
> --- linux-2.6.18/include/asm-blackfin/blackfin.h	1970-01-01 
08:00:00.000000000 +0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/blackfin.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,13 @@
> +/*
> + * Common header file for blackfin family of processors.
> + *
> + */
> +
> +#ifndef _BLACKFIN_H_
> +#define _BLACKFIN_H_
> +
> +#include <asm/macros.h>
> +#include <asm/mach/blackfin.h>
> +#include <asm/bfin-global.h>
> +
> +#endif				/* _BLACKFIN_H_ */
> diff -urN linux-2.6.18/include/asm-blackfin/board/eagle.h 
linux-2.6.18.patch1/include/asm-blackfin/board/eagle.h
> --- linux-2.6.18/include/asm-blackfin/board/eagle.h	1970-01-01 
08:00:00.000000000 +0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/board/eagle.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,4 @@
> +#ifndef _EAGLE_H_
> +#define _EAGLE_H_
> +
> +#endif				/* _EAGLE_H_ */
> diff -urN linux-2.6.18/include/asm-blackfin/board/ezkit.h 
linux-2.6.18.patch1/include/asm-blackfin/board/ezkit.h
> --- linux-2.6.18/include/asm-blackfin/board/ezkit.h	1970-01-01 
08:00:00.000000000 +0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/board/ezkit.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,4 @@
> +#ifndef _EZKIT_H_
> +#define _EZKIT_H_
> +
> +#endif				/* _EZKIT_H_ */
> diff -urN linux-2.6.18/include/asm-blackfin/board/hawk.h 
linux-2.6.18.patch1/include/asm-blackfin/board/hawk.h
> --- linux-2.6.18/include/asm-blackfin/board/hawk.h	1970-01-01 
08:00:00.000000000 +0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/board/hawk.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,4 @@
> +#ifndef _HAWK_H_
> +#define _HAWK_H_
> +
> +#endif				/* _HAWK_H_ */

What's th point of these files, can't you just remove them all?

> diff -urN linux-2.6.18/include/asm-blackfin/bug.h 
linux-2.6.18.patch1/include/asm-blackfin/bug.h
> --- linux-2.6.18/include/asm-blackfin/bug.h	1970-01-01 08:00:00.000000000 
+0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/bug.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,14 @@
> +#ifndef _BLACKFIN_BUG_H
> +#define _BLACKFIN_BUG_H
> +
> +#ifdef CONFIG_BUG
> +#define HAVE_ARCH_BUG
> +#define BUG() do { \
> +	dump_stack(); \
> +	printk("\nkernel BUG at %s:%d!\n", __FILE__, __LINE__); \
> +	panic("BUG!"); \
> +} while (0)
> +#endif
> +

This is probably better done as an external function:

extern void __BUG(const char *file, int line) __attribute__((noreturn));
#define BUG() __BUG(__FILE__, __LINE__)

> diff -urN linux-2.6.18/include/asm-blackfin/cplbtab.h 
linux-2.6.18.patch1/include/asm-blackfin/cplbtab.h
> --- linux-2.6.18/include/asm-blackfin/cplbtab.h	1970-01-01 
08:00:00.000000000 +0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/cplbtab.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,572 @@
> +/*This file is subject to the terms and conditions of the GNU General 
Public
> + * License.
> + *
> + * Blackfin BF533/2.6 support : LG Soft India
> + * Updated : Ashutosh Singh / Jahid Khan : Rrap Software Pvt Ltd
> + * Updated : 1. SDRAM_KERNEL, SDRAM_DKENEL are added as initial cplb's
> + *	        shouldn't be victimized. cplbmgr.S search logic is corrected
> + *	        to findout the appropriate victim.
> + *	     2. SDRAM_IGENERIC in dpdt_table is replaced with SDRAM_DGENERIC
> + *	     : LG Soft India
> + */
> +
> +#ifndef __ARCH_BLACKFIN_CPLBTAB_H
> +#define __ARCH_BLACKFIN_CPLBTAB_H
> +
> +/*************************************************************************
> + *  			ICPLB TABLE
> + *************************************************************************/
> +
> +.data
> +/* This table is configurable */
> +    .align 4;
> +
> +.global _icplb_table
> +_icplb_table:
> +.byte4 0x00000000;
> +.byte4 0x00000000;
> +.byte4 0x00000000;
> +.byte4 0x00000000;

This does not look like it belongs into a header file.

> diff -urN linux-2.6.18/include/asm-blackfin/entry.h 
linux-2.6.18.patch1/include/asm-blackfin/entry.h
> --- linux-2.6.18/include/asm-blackfin/entry.h	1970-01-01 08:00:00.000000000 
+0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/entry.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,367 @@
> +#ifndef __BFIN_ENTRY_H
> +#define __BFIN_ENTRY_H
> +
> +#include <asm/setup.h>
> +#include <asm/page.h>
> +
> +#ifdef __ASSEMBLY__
> +
> +#define	LFLUSH_I_AND_D	0x00000808
> +#define	LSIGTRAP	5
> +
> +/* process bits for task_struct.flags */
> +#define	PF_TRACESYS_OFF	3
> +#define	PF_TRACESYS_BIT	5
> +#define	PF_PTRACED_OFF	3
> +#define	PF_PTRACED_BIT	4
> +#define	PF_DTRACE_OFF	1
> +#define	PF_DTRACE_BIT	5
> +
> +/* This one is used for exceptions, emulation, and NMI.  It doesn't push
> +   RETI and doesn't do cli.  */
> +#define SAVE_ALL_SYS		save_context_no_interrupts
> +/* This is used for all normal interrupts.  It saves a minimum of registers
> +   to the stack, loads the IRQ number, and jumps to common code.  */
> +#define INTERRUPT_ENTRY(N)						\
> +    [--sp] = SYSCFG;							\
> +									\
> +    [--sp] = P0;	/*orig_p0*/					\
> +    [--sp] = R0;	/*orig_r0*/					\
> +    [--sp] = (R7:0,P5:0);						\
> +    R0 = (N);								\
> +    jump __common_int_entry;
> +
> +/* For timer interrupts, we need to save IPEND, since the user_mode
> +	   macro accesses it to determine where to account time.  */
> +#define TIMER_INTERRUPT_ENTRY(N)					\
> +    [--sp] = SYSCFG;							\
> +									\
> +    [--sp] = P0;	/*orig_p0*/					\
> +    [--sp] = R0;	/*orig_r0*/					\
> +    [--sp] = (R7:0,P5:0);						\
> +    p0.l = lo(IPEND);							\
> +    p0.h = hi(IPEND);							\
> +    r1 = [p0];								\
> +    R0 = (N);								\
> +    jump __common_int_entry;
> +
> +/* This one pushes RETI without using CLI.  Interrupts are enabled.  */
> +#define SAVE_CONTEXT_SYSCALL	save_context_syscall
> +#define SAVE_CONTEXT		save_context_with_interrupts
> +
> +#define RESTORE_ALL_SYS		restore_context_no_interrupts
> +#define RESTORE_CONTEXT		restore_context_with_interrupts
> +
> +/*
> + * Code to save processor context.
> + *  We even save the register which are preserved by a function call
> + *	 - r4, r5, r6, r7, p3, p4, p5
> + */
> +.macro save_context_with_interrupts
> +	[--sp] = SYSCFG;
> +
> +	[--sp] = P0;	/*orig_p0*/
> +	[--sp] = R0;	/*orig_r0*/

same here


> diff -urN linux-2.6.18/include/asm-blackfin/fcntl.h 
linux-2.6.18.patch1/include/asm-blackfin/fcntl.h
> --- linux-2.6.18/include/asm-blackfin/fcntl.h	1970-01-01 08:00:00.000000000 
+0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/fcntl.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,87 @@
> +#ifndef _BFIN_FCNTL_H
> +#define _BFIN_FCNTL_H
> +
> +/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
> +   located on an ext2 file system */
> +#define O_ACCMODE	  0003
> +#define O_RDONLY	    00
> +#define O_WRONLY	    01

Please use asm-generic/fcntl.h

> diff -urN linux-2.6.18/include/asm-blackfin/ioctls.h 
linux-2.6.18.patch1/include/asm-blackfin/ioctls.h
> --- linux-2.6.18/include/asm-blackfin/ioctls.h	1970-01-01 08:00:00.000000000 
+0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/ioctls.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,82 @@
> +#ifndef __ARCH_BFIN_IOCTLS_H__
> +#define __ARCH_BFIN_IOCTLS_H__
> +
> +#include <asm/ioctl.h>
> +
> +/* 0x54 is just a magic number to make these relatively unique ('T') */
> +
> +#define TCGETS		0x5401
> +#define TCSETS		0x5402
> +#define TCSETSW		0x5403
> +#define TCSETSF		0x5404
> +#define TCGETA		0x5405
> +#define TCSETA		0x5406
> +#define TCSETAW		0x5407
> +#define TCSETAF		0x5408
> +#define TCSBRK		0x5409
> +#define TCXONC		0x540A
> +#define TCFLSH		0x540B
> +#define TIOCEXCL	0x540C
> +#define TIOCNXCL	0x540D
> +#define TIOCSCTTY	0x540E
> +#define TIOCGPGRP	0x540F
> +#define TIOCSPGRP	0x5410
> +#define TIOCOUTQ	0x5411
> +#define TIOCSTI		0x5412
> +#define TIOCGWINSZ	0x5413
> +#define TIOCSWINSZ	0x5414
> +#define TIOCMGET	0x5415
> +#define TIOCMBIS	0x5416
> +#define TIOCMBIC	0x5417
> +#define TIOCMSET	0x5418
> +#define TIOCGSOFTCAR	0x5419
> +#define TIOCSSOFTCAR	0x541A
> +#define FIONREAD	0x541B
> +#define TIOCINQ		FIONREAD
> +#define TIOCLINUX	0x541C
> +#define TIOCCONS	0x541D
> +#define TIOCGSERIAL	0x541E
> +#define TIOCSSERIAL	0x541F
> +#define TIOCPKT		0x5420
> +#define FIONBIO		0x5421
> +#define TIOCNOTTY	0x5422
> +#define TIOCSETD	0x5423
> +#define TIOCGETD	0x5424
> +#define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
> +#define TIOCTTYGSTRUCT	0x5426	/* For debugging only */
> +#define TIOCSBRK	0x5427	/* BSD compatibility */
> +#define TIOCCBRK	0x5428	/* BSD compatibility */
> +#define TIOCGSID	0x5429	/* Return the session ID of FD */
> +#define TIOCGPTN	_IOR('T',0x30, unsigned int)	/* Get Pty Number (of pty-mux 
device) */
> +#define TIOCSPTLCK	_IOW('T',0x31, int)	/* Lock/unlock Pty */
> +
> +#define FIONCLEX	0x5450	/* these numbers need to be adjusted. */
> +#define FIOCLEX		0x5451
> +#define FIOASYNC	0x5452
> +#define TIOCSERCONFIG	0x5453
> +#define TIOCSERGWILD	0x5454
> +#define TIOCSERSWILD	0x5455
> +#define TIOCGLCKTRMIOS	0x5456
> +#define TIOCSLCKTRMIOS	0x5457
> +#define TIOCSERGSTRUCT	0x5458	/* For debugging only */
> +#define TIOCSERGETLSR   0x5459	/* Get line status register */
> +#define TIOCSERGETMULTI 0x545A	/* Get multiport config  */
> +#define TIOCSERSETMULTI 0x545B	/* Set multiport config */
> +
> +#define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
> +#define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
> +
> +#define FIOQSIZE	0x545E
> +
> +/* Used for packet mode */
> +#define TIOCPKT_DATA		 0
> +#define TIOCPKT_FLUSHREAD	 1
> +#define TIOCPKT_FLUSHWRITE	 2
> +#define TIOCPKT_STOP		 4
> +#define TIOCPKT_START		 8
> +#define TIOCPKT_NOSTOP		16
> +#define TIOCPKT_DOSTOP		32
> +
> +#define TIOCSER_TEMT    0x01	/* Transmitter physically empty */

Can't we ever get a proper generic file for these?

> + * These are used to wrap system calls on bfin.
> + *
> + * See arch/blackfin/kernel/sys_bfin.c for ugly details..
> + */
> +struct ipc_kludge {
> +	struct msgbuf *msgp;
> +	long msgtyp;
> +};
> +
> +#define SEMOP		 1
> +#define SEMGET		 2
> +#define SEMCTL		 3
> +#define MSGSND		11
> +#define MSGRCV		12
> +#define MSGGET		13
> +#define MSGCTL		14
> +#define SHMAT		21
> +#define SHMDT		22
> +#define SHMGET		23
> +#define SHMCTL		24
> +
> +/* Used by the DIPC package, try and avoid reusing it */
> +#define DIPC		25
> +
> +#define IPCCALL(version,op)	((version)<<16 | (op))
> +
> +#endif

As mentioned, kill these comletely

> diff -urN linux-2.6.18/include/asm-blackfin/mach-bf533/anomaly.h 
linux-2.6.18.patch1/include/asm-blackfin/mach-bf533/anomaly.h
> --- linux-2.6.18/include/asm-blackfin/mach-bf533/anomaly.h	1970-01-01 
08:00:00.000000000 +0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/mach-bf533/anomaly.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,172 @@
> +/*
> + * File:         include/asm-blackfin/mach-bf533/anomaly.h

You seem to have lots of these machine specfic header files in include/asm.
Please move them to the respective machine implementation directory
if they are only used from there

> +/* Clock and System Control (0xFFC0 0400-0xFFC0 07FF) */
> +#define bfin_read_PLL_CTL()                  bfin_read16(PLL_CTL)
> +#define bfin_write_PLL_CTL(val)              bfin_write16(PLL_CTL,val)
> +#define bfin_read_PLL_STAT()                 bfin_read16(PLL_STAT)
(and 700 more of these)

What's the point, are you getting paid by lines of code? Just use
the registers directly!

> +/* Clock and System Control	(0xFFC00000 - 0xFFC000FF)								*/
> +#define bfin_read_PLL_CTL()                  bfin_read16(PLL_CTL)
> +#define bfin_write_PLL_CTL(val)              bfin_write16(PLL_CTL,val)
> +#define bfin_read_PLL_DIV()                  bfin_read16(PLL_DIV)
> +#define bfin_write_PLL_DIV(val)              bfin_write16(PLL_DIV,val)

Here we go again. You have a serious copy-paste problem. If the machines
need the same code, just make that common to them

> +typedef unsigned short __kernel_ipc_pid_t;
> +typedef unsigned short __kernel_uid_t;
> +typedef unsigned short __kernel_gid_t;

Why that? Please make these int

> +typedef unsigned short __kernel_uid16_t;
> +typedef unsigned short __kernel_gid16_t;

and kill these

> diff -urN linux-2.6.18/include/asm-blackfin/stat.h 
linux-2.6.18.patch1/include/asm-blackfin/stat.h
> --- linux-2.6.18/include/asm-blackfin/stat.h	1970-01-01 08:00:00.000000000 
+0800
> +++ linux-2.6.18.patch1/include/asm-blackfin/stat.h	2006-09-21 
09:29:49.000000000 +0800
> @@ -0,0 +1,77 @@
> +#ifndef _BFIN_STAT_H
> +#define _BFIN_STAT_H
> +
> +struct __old_kernel_stat {
> +	unsigned short st_dev;
> +	unsigned short st_ino;
> +	unsigned short st_mode;
> +	unsigned short st_nlink;
> +	unsigned short st_uid;
> +	unsigned short st_gid;
> +	unsigned short st_rdev;
> +	unsigned long st_size;
> +	unsigned long st_atime;
> +	unsigned long st_mtime;
> +	unsigned long st_ctime;
> +};
> +
> +struct stat {
> +	unsigned short st_dev;
> +	unsigned short __pad1;
> +	unsigned long st_ino;
> +	unsigned short st_mode;
> +	unsigned short st_nlink;
> +	unsigned short st_uid;
> +	unsigned short st_gid;
> +	unsigned short st_rdev;
> +	unsigned short __pad2;
> +	unsigned long st_size;
> +	unsigned long st_blksize;
> +	unsigned long st_blocks;
> +	unsigned long st_atime;
> +	unsigned long __unused1;
> +	unsigned long st_mtime;
> +	unsigned long __unused2;
> +	unsigned long st_ctime;
> +	unsigned long __unused3;
> +	unsigned long __unused4;
> +	unsigned long __unused5;
> +};
> +
> +/* This matches struct stat64 in glibc2.1, hence the absolutely
> + * insane amounts of padding around dev_t's.
> + */
> +struct stat64 {
> +	unsigned long long st_dev;
> +	unsigned char __pad1[4];

One of these three should really be enough for a new architecture, as 
mentioned
before.

> +
> +#define STAT64_HAS_BROKEN_ST_INO	1
> +	unsigned long __st_ino;

Then why didn't you fix it?

> +/* Dma addresses are 32-bits wide.  */
> +
> +typedef u32 dma_addr_t;
> +typedef u32 dma64_addr_t;

Shouldn't the dma64_addr_t be u64?

 +
> +#define __syscall_return(type, res)					\
> +do {									\
> +	if ((unsigned long)(res) >= (unsigned long)(-125)) 		\
> +	{	errno = -(res);						\
> +		res = -1;						\
> +	}								\
> +	return (type) (res);						\
> +} while (0)
> +
> +#define _syscall0(type,name)						\
> +type name(void) {							\
> +	long __res;							\
> +	__asm__ __volatile__ (						\
> +		"p0 = %1;\n\t"						\
> +		"excpt 0;\n\t"						\
> +		"%0=r0;\n\t"						\
> +		: "=da" (__res)						\
> +		: "i" (__NR_##name)					\
> +		: "memory","CC","R0","P0");				\
> +	__syscall_return(type,__res);					\
> +}

You can prepare to kill these macros again in 2.6.19

> +
> +#ifdef __KERNEL__
> +#define __ARCH_WANT_IPC_PARSE_VERSION
> +#define __ARCH_WANT_OLD_READDIR
> +#define __ARCH_WANT_OLD_STAT
> +#define __ARCH_WANT_STAT64
> +#define __ARCH_WANT_SYS_ALARM
> +#define __ARCH_WANT_SYS_GETHOSTNAME
> +#define __ARCH_WANT_SYS_PAUSE
> +#define __ARCH_WANT_SYS_SGETMASK
> +#define __ARCH_WANT_SYS_SIGNAL
> +#define __ARCH_WANT_SYS_TIME
> +#define __ARCH_WANT_SYS_UTIME
> +#define __ARCH_WANT_SYS_WAITPID
> +#define __ARCH_WANT_SYS_SOCKETCALL
> +#define __ARCH_WANT_SYS_FADVISE64
> +#define __ARCH_WANT_SYS_GETPGRP
> +#define __ARCH_WANT_SYS_LLSEEK
> +#define __ARCH_WANT_SYS_NICE
> +#define __ARCH_WANT_SYS_OLD_GETRLIMIT
> +#define __ARCH_WANT_SYS_OLDUMOUNT
> +#define __ARCH_WANT_SYS_SIGPENDING
> +#define __ARCH_WANT_SYS_SIGPROCMASK
> +#define __ARCH_WANT_SYS_RT_SIGACTION
> +#define __ARCH_WANT_SYS_RT_SIGSUSPEND
> +#endif

You should not need to define most of these

> +
> +#ifdef __KERNEL_SYSCALLS__
> +
> +#include <linux/interrupt.h>
> +
> +#define __NR__exit __NR_exit
> +#if 0
> +static inline _syscall0(int, pause)
> +static inline _syscall0(int, sync)
> +static inline _syscall0(pid_t, setsid)
> +static inline _syscall3(int, write, int, fd, const char *, buf, off_t, 
count)
> +static inline _syscall3(int, read, int, fd, char *, buf, off_t, count)
> +static inline _syscall3(off_t, lseek, int, fd, off_t, offset, int, count)
> +static inline _syscall1(int, dup, int, fd)
> +//static inline _syscall3(int,execve,const char *,file,char **,argv,char 
**,envp)
> +static inline _syscall3(int, open, const char *, file, int, flag, int, 
mode)
> +static inline _syscall1(int, close, int, fd)
> +static inline _syscall1(int, _exit, int, exitcode)
> +static inline _syscall3(pid_t, waitpid, pid_t, pid, int *, wait_stat, int,
> +			options)
> +static inline _syscall1(int, delete_module, const char *, name)
> +
> +static inline pid_t wait(int *wait_stat)
> +{
> +	return waitpid(-1, wait_stat, 0);
> +}
> +#endif
> +
> +asmlinkage long execve(char *, char **, char **);
> +
> +asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
> +			  unsigned long prot, unsigned long flags,
> +			  unsigned long fd, unsigned long pgoff);
> +asmlinkage int sys_execve(char *name, char **argv, char **envp);
> +asmlinkage int sys_pipe(unsigned long *fildes);
> +struct pt_regs;
> +int sys_request_irq(unsigned int,
> +		    irqreturn_t(*)(int, void *, struct pt_regs *),
> +		    unsigned long, const char *, void *);
> +void sys_free_irq(unsigned int, void *);
> +struct sigaction;
> +asmlinkage long sys_rt_sigaction(int sig,
> +				 const struct sigaction __user * act,
> +				 struct sigaction __user * oact,
> +				 size_t sigsetsize);
> +
> +asmlinkage void *sys_sram_alloc(size_t size, unsigned long flags);
> +asmlinkage int sys_sram_free(const void *addr);
> +asmlinkage void *sys_dma_memcpy(void *dest, const void *src, size_t len);
> +
> +#endif				/* __KERNEL_SYSCALLS__ */

And these should definitely go away. execve is the only one that has been
required for ages and that gets removed now.

One more thing about the headers: please add a Kbuild file in there so
'make headers_install' works



> diff -urN linux-2.6.18/init/Kconfig linux-2.6.18.patch1/init/Kconfig
> --- linux-2.6.18/init/Kconfig	2006-09-20 11:42:06.000000000 +0800
> +++ linux-2.6.18.patch1/init/Kconfig	2006-09-21 09:31:35.000000000 +0800
> @@ -267,7 +267,7 @@
>  
>  config UID16
>  	bool "Enable 16-bit UID system calls" if EMBEDDED
> -	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 
&& !64BIT) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || 
(X86_64 && IA32_EMULATION)
> +	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 
&& !64BIT) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || 
(X86_64 && IA32_EMULATION) || BFIN
>  	default y
>  	help
>  	  This enables the legacy 16-bit UID syscall wrappers.

No!

> @@ -375,6 +375,7 @@
>  config EPOLL
>  	bool "Enable eventpoll support" if EMBEDDED
>  	default y
> +	depends on MMU
>  	help
>  	  Disabling this option will cause the kernel to be built without
>  	  support for epoll family of system calls.

Why that? If you have a good reason for it, please submit this as a
separate patch, as this has nothing to do with blackfin.

> diff -urN linux-2.6.18/init/Kconfig.orig 
linux-2.6.18.patch1/init/Kconfig.orig
> --- linux-2.6.18/init/Kconfig.orig	1970-01-01 08:00:00.000000000 +0800
> +++ linux-2.6.18.patch1/init/Kconfig.orig	2006-09-21 09:14:55.000000000 
+0800


This should not be in your patch

	Arnd <><
