Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVGHPGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVGHPGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 11:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVGHPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 11:06:00 -0400
Received: from host-84-9-201-131.bulldogdsl.com ([84.9.201.131]:53123 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S262684AbVGHPF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 11:05:56 -0400
Date: Fri, 8 Jul 2005 16:03:37 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] swsusp for OSK
Message-ID: <20050708150337.GB16299@home.fluff.org>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp> <20050708.212501.58462280.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708.212501.58462280.kaminaga@sm.sony.co.jp>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 09:25:01PM +0900, Hiroki Kaminaga wrote:
> # Original is at linux-pm ML. Cross posting...
> 
> Here is swsusp for ARM architecture. It is still target specific.
> Anyone doing similar work?

What are you suspending to? If this is an external device, how is 
your bootloader resuming the kernel? does it have a reserved
area of memory to use for it's working data?
 
> I managed to hibernate/wakeup on OSK on simple case, but when running
> mplayer or when mmap'ed and image got bigger, kernel panic'ed on
> wakeup, possibly due to pagedir table miss.
> 
> Here is log:
> >>>
> Unable to handle kernel paging request at virtual address 80000000
> pgd = c1054000
> [80000000] *pgd=00000000
> <<<
> 
> c1054000 was just after c03ff000. Until up to c03ff000,
> pagedir_nosave.orig_address was a constant increase from c0000000 by
> 0x00001000.
> This is at arch/arm/power/swsusp.S:swsusp_arch_resume()
> 
> Below are my trial & errors.
> 
> 
> * increase entries of pagedir table
> 
> I increased entry in arch/arm/kernel/head.S:__create_page_tables() from
> 4MB to 8MB. This didn't fix the problem.
> 
> * copy swapper_pg_dir and use at resume

Hmm, I have no idea if this is correct... I assume it is not saving
the page tables over suspend/resume, and that is why you are having
trouble restoring the page table? 

> arch/i386/power/swsusp.S:swsusp_arch_resume() set pagedir table base at
> inst: movl %ecx,%cr3. So I attempted similar process, memcpy swapper_pg_dir
> to swsusp_pg_dir, and issued: mcr p15, 0, r0, c2, c0, 0, invalidating
> cache, drain buffer before & invalidate TLB after this inst.
> 
> This caused a crach at mcr inst. After translating from VA to PA, it
> was still the same.
> 
> Next, I overwrote swapper_pg_dir with swsusp_pg_dir. It didn't crash, 
> but result was still the same. 
> (works on simple case, fails with mplayer/mmap)
> 
> * applying to 2.6.12
> 
> I got bigger image (about 2600 pages), and failed hibernate/wakeup
> even on simple case. It was about 1350 pages on simple case, and about
> 2400 page with mplayer running. The fail status was the same.
> 
> 
> Any advice?
> 
> I'm confused with the page table usase. On wakeup, kernel create table
> (call it A). This table is used when copying swsusp image to mem.
> However, there was also table before hibernate (call it B). To some
> point, they are similar, so wakeup works. But at some point, wrong
> table is used, or table gets corrupted, and result in above kernel
> panic. This is my assumption.
> 
> Perhaps I have to turn off MMU while copying pagedir_nosave, and turn
> on later?
> 
> Regards,
> 
> HK.
> --
> diff -uNrp linux-2.6.11.12-orig/arch/arm/Kconfig linux-2.6.11.12/arch/arm/Kconfig
> --- linux-2.6.11.12-orig/arch/arm/Kconfig	2005-07-05 14:09:26.000000000 +0900
> +++ linux-2.6.11.12/arch/arm/Kconfig	2005-07-05 14:50:37.000000000 +0900
> @@ -504,25 +504,7 @@ source "fs/Kconfig.binfmt"
>  
>  source "drivers/base/Kconfig"
>  
> -config PM
> -	bool "Power Management support"
> -	---help---
> -	  "Power Management" means that parts of your computer are shut
> -	  off or put into a power conserving "sleep" mode if they are not
> -	  being used.  There are two competing standards for doing this: APM
> -	  and ACPI.  If you want to use either one, say Y here and then also
> -	  to the requisite support below.
> -
> -	  Power Management is most important for battery powered laptop
> -	  computers; if you have a laptop, check out the Linux Laptop home
> -	  page on the WWW at <http://www.linux-on-laptops.com/> or
> -	  Tuxmobil - Linux on Mobile Computers at <http://www.tuxmobil.org/>
> -	  and the Battery Powered Linux mini-HOWTO, available from
> -	  <http://www.tldp.org/docs.html#howto>.
> -
> -	  Note that, even if you say N here, Linux on the x86 architecture
> -	  will issue the hlt instruction if nothing is to be done, thereby
> -	  sending the processor to sleep and saving power.
> +source "kernel/power/Kconfig"
>  
>  config PREEMPT
>  	bool "Preemptible Kernel (EXPERIMENTAL)"
> diff -uNrp linux-2.6.11.12-orig/arch/arm/Makefile linux-2.6.11.12/arch/arm/Makefile
> --- linux-2.6.11.12-orig/arch/arm/Makefile	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/arch/arm/Makefile	2005-07-05 14:50:51.000000000 +0900
> @@ -146,6 +146,7 @@ core-$(CONFIG_VFP)		+= arch/arm/vfp/
>  drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
>  drivers-$(CONFIG_ARCH_CLPS7500)	+= drivers/acorn/char/
>  drivers-$(CONFIG_ARCH_L7200)	+= drivers/acorn/char/
> +drivers-$(CONFIG_PM)		+= arch/arm/power/
>  
>  libs-y				+= arch/arm/lib/
>  
> diff -uNrp linux-2.6.11.12-orig/arch/arm/kernel/vmlinux.lds.S linux-2.6.11.12/arch/arm/kernel/vmlinux.lds.S
> --- linux-2.6.11.12-orig/arch/arm/kernel/vmlinux.lds.S	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/arch/arm/kernel/vmlinux.lds.S	2005-07-05 14:50:51.000000000 +0900
> @@ -75,6 +75,7 @@ SECTIONS
>  	}
>  
>  	.text : {			/* Real text segment		*/
> +	_kern_text_start = .;
>  		_text = .;		/* Text and read-only data	*/
>  			*(.text)
>  			SCHED_TEXT
> @@ -98,6 +99,7 @@ SECTIONS
>  	RODATA
>  
>  	_etext = .;			/* End of text and rodata section */
> +	_kern_text_end = .;
>  
>  #ifdef CONFIG_XIP_KERNEL
>  	__data_loc = ALIGN(4);		/* location in binary */
> @@ -124,12 +126,6 @@ SECTIONS
>  		__init_end = .;
>  #endif
>  
> -		. = ALIGN(4096);
> -		__nosave_begin = .;
> -		*(.data.nosave)
> -		. = ALIGN(4096);
> -		__nosave_end = .;
> -
>  		/*
>  		 * then the cacheline aligned data
>  		 */
> @@ -145,6 +141,12 @@ SECTIONS
>  		_edata = .;
>  	}
>  
> +	. = ALIGN(4096);
> +	__nosave_begin = .;
> +	.data.nosave : { *(.data.nosave) }
> +	. = ALIGN(4096);
> +	__nosave_end = .;
> +
>  	.bss : {
>  		__bss_start = .;	/* BSS				*/
>  		*(.bss)
> diff -uNrp linux-2.6.11.12-orig/arch/arm/mm/init.c linux-2.6.11.12/arch/arm/mm/init.c
> --- linux-2.6.11.12-orig/arch/arm/mm/init.c	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/arch/arm/mm/init.c	2005-07-05 15:16:52.000000000 +0900
> @@ -530,6 +530,20 @@ static inline void free_area(unsigned lo
>  		printk(KERN_INFO "Freeing %s memory: %dK\n", s, size);
>  }
>  
> +#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
> +/*
> + * Swap suspend & friends need this for resume.
> + */
> +/* pgd_t is unsigned long [2], so 2 * 4 (byte/word) */
> +char __nosavedata swsusp_pg_dir[PTRS_PER_PGD * 2 * 4]
> +/* Translation Table Base must be on 16KB boundary. */
> +__attribute__ ((aligned (1UL << 14))); 
> +void swsusp_save_pg_dir(void)
> +{
> +	memcpy(swsusp_pg_dir, swapper_pg_dir, PTRS_PER_PGD * 2 * 4);
> +}
> +#endif
> +
>  /*
>   * mem_init() marks the free areas in the mem_map and tells us how much
>   * memory is free.  This is done after various parts of the system have
> diff -uNrp linux-2.6.11.12-orig/arch/arm/power/Makefile linux-2.6.11.12/arch/arm/power/Makefile
> --- linux-2.6.11.12-orig/arch/arm/power/Makefile	1970-01-01 09:00:00.000000000 +0900
> +++ linux-2.6.11.12/arch/arm/power/Makefile	2005-07-05 14:50:51.000000000 +0900
> @@ -0,0 +1 @@
> +obj-$(CONFIG_SOFTWARE_SUSPEND)  += cpu.o swsusp.o
> diff -uNrp linux-2.6.11.12-orig/arch/arm/power/cpu.c linux-2.6.11.12/arch/arm/power/cpu.c
> --- linux-2.6.11.12-orig/arch/arm/power/cpu.c	1970-01-01 09:00:00.000000000 +0900
> +++ linux-2.6.11.12/arch/arm/power/cpu.c	2005-07-05 19:59:58.000000000 +0900
> @@ -0,0 +1,100 @@
> +/*
> + * cpu.c  - Suspend support specific for ARM.
> + *		based on arch/i386/power/cpu.c
> + *
> + * Distribute under GPLv2
> + *
> + * Copyright (c) 2002 Pavel Machek <pavel@suse.cz>
> + * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/poll.h>
> +#include <linux/delay.h>
> +#include <linux/sysrq.h>
> +#include <linux/proc_fs.h>
> +#include <linux/pm.h>
> +#include <linux/device.h>
> +#include <linux/suspend.h>
> +#include <asm/irq.h>
> +#include <asm/uaccess.h>
> +#include <asm/tlbflush.h>
> +
> +static struct saved_context saved_context;
> +
> +extern void enable_sep_cpu(void *);
> +
> +void __save_processor_state(struct saved_context *ctxt)
> +{
> +	/* save preempt state and disable it */
> +	preempt_disable();
> +
> +	/* save coprocessor 15 registers */
> +	asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r" (ctxt->CR));

Dangerous, you could be restoring items like FastBus select without
checking what state the system is left in on return

> +	asm volatile ("mrc p15, 0, %0, c3, c0, 0" : "=r" (ctxt->DACR));
> +	asm volatile ("mrc p15, 0, %0, c5, c0, 0" : "=r" (ctxt->D_FSR));
> +	asm volatile ("mrc p15, 0, %0, c5, c0, 1" : "=r" (ctxt->I_FSR));
> +	asm volatile ("mrc p15, 0, %0, c6, c0, 0" : "=r" (ctxt->FAR));
> +	asm volatile ("mrc p15, 0, %0, c9, c0, 0" : "=r" (ctxt->D_CLR));
> +	asm volatile ("mrc p15, 0, %0, c9, c0, 1" : "=r" (ctxt->I_CLR));
> +	asm volatile ("mrc p15, 0, %0, c9, c1, 0" : "=r" (ctxt->D_TCMRR));
> +	asm volatile ("mrc p15, 0, %0, c9, c1, 1" : "=r" (ctxt->I_TCMRR));
> +	asm volatile ("mrc p15, 0, %0, c10, c0, 0" : "=r" (ctxt->TLBLR));
> +	asm volatile ("mrc p15, 0, %0, c13, c0, 0" : "=r" (ctxt->FCSE));
> +	asm volatile ("mrc p15, 0, %0, c13, c0, 1" : "=r" (ctxt->CID));
> +	asm volatile ("mrc p15, 0, %0, c2, c0, 0" : "=r" (ctxt->TTBR));

I think half of these are items that do not need saving (write-only
control registers)

> +
> +extern void swsusp_save_pg_dir(void);
> +void save_processor_state(void)
> +{
> +	__save_processor_state(&saved_context);
> +}
> +
> +void __restore_processor_state(struct saved_context *ctxt)
> +{
> +	/* restore coprocessor 15 registers */
> +	asm volatile ("mcr p15, 0, %0, c2, c0, 0" : : "r" (ctxt->TTBR));
> +	asm volatile ("mcr p15, 0, %0, c13, c0, 1" : : "r" (ctxt->CID));
> +	asm volatile ("mcr p15, 0, %0, c13, c0, 0" : : "r" (ctxt->FCSE));
> +	asm volatile ("mcr p15, 0, %0, c10, c0, 0" : : "r" (ctxt->TLBLR));
> +	asm volatile ("mcr p15, 0, %0, c9, c1, 1" : : "r" (ctxt->I_TCMRR));
> +	asm volatile ("mcr p15, 0, %0, c9, c1, 0" : : "r" (ctxt->D_TCMRR));
> +	asm volatile ("mcr p15, 0, %0, c9, c0, 1" : : "r" (ctxt->I_CLR));
> +	asm volatile ("mcr p15, 0, %0, c9, c0, 0" : : "r" (ctxt->D_CLR));
> +	asm volatile ("mcr p15, 0, %0, c6, c0, 0" : : "r" (ctxt->FAR));
> +	asm volatile ("mcr p15, 0, %0, c5, c0, 1" : : "r" (ctxt->I_FSR));
> +	asm volatile ("mcr p15, 0, %0, c5, c0, 0" : : "r" (ctxt->D_FSR));
> +	asm volatile ("mcr p15, 0, %0, c3, c0, 0" : : "r" (ctxt->DACR));
> +	asm volatile ("mcr p15, 0, %0, c1, c0, 0" : : "r" (ctxt->CR));
> +
> +	/* restore preempt state */
> +	preempt_enable();
> +}
> +
> +void restore_processor_state(void)
> +{
> +	__restore_processor_state(&saved_context);
> +}
> +
> +
> +EXPORT_SYMBOL(save_processor_state);
> +EXPORT_SYMBOL(restore_processor_state);
> diff -uNrp linux-2.6.11.12-orig/arch/arm/power/swsusp.S linux-2.6.11.12/arch/arm/power/swsusp.S
> --- linux-2.6.11.12-orig/arch/arm/power/swsusp.S	1970-01-01 09:00:00.000000000 +0900
> +++ linux-2.6.11.12/arch/arm/power/swsusp.S	2005-07-05 19:52:48.000000000 +0900
> @@ -0,0 +1,321 @@
> +/*
> + * swsusp.S - This file is based on arch/i386/power/swsusp.S;
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +/*
> + * This may not use any stack, nor any variable that is not "NoSave":
> + *
> + * Its rewriting one kernel image with another. What is stack in "old"
> + * image could very well be data page in "new" image, and overwriting
> + * your own stack under you is bad idea.
> + */
> +
> +/*
> + * FIXME: Work needs to be done for core with fp.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/segment.h>
> +#include <asm/page.h>
> +
> +	.text
> +
> +#define	LOCAL_WORD(x) \
> +	.data			; \
> +	.p2align 2		; \
> +	.type   x, #object	; \
> +	.size   x, 4		; \
> +x:				; \
> +	.long 1
> +
> +#define WORD_ADDR(x) \
> +	.align 2		; \
> +.L##x:				; \
> +	.word x
> +
> +#define	FUNC(x) \
> +        .text			; \
> +	.p2align 2		; \
> +	.globl x		; \
> +	.type   x, #function	; \
> +x:
> +
> +#define	FUNC_END(x) \
> +	.size	x, .-x
> +
> +#define CHANGE_MODE(x) \
> +	mov	r1, r0		; \
> +	bic	r1, r1, #0x1f	; \
> +	orr	r1, r1, #0x##x	; \
> +	msr	cpsr_c, r1
> +
> +/* nonvolatile int registers */
> +#ifdef DEBUG
> +	.globl	saved_context_r0	// for debug
> +#endif
> +	LOCAL_WORD(saved_context_r0)
> +	LOCAL_WORD(saved_context_r1)
> +	LOCAL_WORD(saved_context_r2)
> +	LOCAL_WORD(saved_context_r3)
> +	LOCAL_WORD(saved_context_r4)
> +	LOCAL_WORD(saved_context_r5)
> +	LOCAL_WORD(saved_context_r6)
> +	LOCAL_WORD(saved_context_r7)
> +	LOCAL_WORD(saved_context_r8)
> +	LOCAL_WORD(saved_context_r9)
> +	LOCAL_WORD(saved_context_r10)
> +	LOCAL_WORD(saved_context_r11)
> +	LOCAL_WORD(saved_context_r12)
> +	LOCAL_WORD(saved_context_r13)
> +	LOCAL_WORD(saved_context_r14)
> +	LOCAL_WORD(saved_cpsr)
> +
> +	LOCAL_WORD(saved_context_r8_fiq)
> +	LOCAL_WORD(saved_context_r9_fiq)
> +	LOCAL_WORD(saved_context_r10_fiq)
> +	LOCAL_WORD(saved_context_r11_fiq)
> +	LOCAL_WORD(saved_context_r12_fiq)
> +	LOCAL_WORD(saved_context_r13_fiq)
> +	LOCAL_WORD(saved_context_r14_fiq)
> +	LOCAL_WORD(saved_spsr_fiq)
> +
> +	LOCAL_WORD(saved_context_r13_irq)
> +	LOCAL_WORD(saved_context_r14_irq)
> +	LOCAL_WORD(saved_spsr_irq)
> +
> +	LOCAL_WORD(saved_context_r13_svc)
> +	LOCAL_WORD(saved_context_r14_svc)
> +	LOCAL_WORD(saved_spsr_svc)
> +
> +	LOCAL_WORD(saved_context_r13_abt)
> +	LOCAL_WORD(saved_context_r14_abt)
> +	LOCAL_WORD(saved_spsr_abt)
> +
> +	LOCAL_WORD(saved_context_r13_und)
> +	LOCAL_WORD(saved_context_r14_und)
> +	LOCAL_WORD(saved_spsr_und)
> +
> +/*
> + * non volatile fpu registers 
> + * s16 - s31
> + */
> +	/* XXX:TBD */
> +
> +FUNC(swsusp_arch_suspend)
> +
> +	/* save current program status register */
> +	ldr	r3, .Lsaved_cpsr
> +	mrs	r1, cpsr
> +	str	r1, [r3]
> +
> +	/* hold current mode */
> +	mrs	r0, cpsr
> +
> +	CHANGE_MODE(1f)	/* change to system(user) mode */
> +	/* save nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r0
> +	stmia	r3, {r0-r14}
> +
> +	CHANGE_MODE(11) /* change to fiq mode */
> +	/* save nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r8_fiq
> +	stmia	r3, {r8-r14}
> +	/* save spsr_fiq register */
> +	ldr	r3, .Lsaved_spsr_fiq
> +	mrs	r1, spsr
> +	str	r1, [r3]
> +
> +	CHANGE_MODE(12) /* change to irq mode */
> +	/* save nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r13_irq
> +	stmia	r3, {r13-r14}
> +	/* save spsr_irq register */
> +	ldr	r3, .Lsaved_spsr_irq
> +	mrs	r1, spsr
> +	str	r1, [r3]
> +
> +	CHANGE_MODE(13) /* change to svc mode */
> +	/* save nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r13_svc
> +	stmia	r3, {r13-r14}
> +	/* save spsr_svc register */
> +	ldr	r3, .Lsaved_spsr_svc
> +	mrs	r1, spsr
> +	str	r1, [r3]
> +
> +	CHANGE_MODE(17) /* change to abt mode */
> +	/* save nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r13_abt
> +	stmia	r3, {r13-r14}
> +	/* save spsr_abt register */
> +	ldr	r3, .Lsaved_spsr_abt
> +	mrs	r1, spsr
> +	str	r1, [r3]
> +
> +	CHANGE_MODE(1b) /* change to und mode */
> +	/* save nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r13_und
> +	stmia	r3, {r13-r14}
> +	/* save spsr_und register */
> +	ldr	r3, .Lsaved_spsr_und
> +	mrs	r1, spsr
> +	str	r1, [r3]
> +
> +	/* go back to original mode */
> +	msr	cpsr_c, r0
> +
> +	/*
> +	 * save nonvolatile fp registers
> +	 * and fp status/system registers, if needed
> +	 */
> +	/* XXX:TBD */
> +
> +	/* call swsusp_save */
> +	bl	swsusp_save
> +
> +	/* restore return address */
> +	ldr	r3, .Lsaved_context_r14_svc
> +	ldr	lr, [r3]
> +	mov	pc, lr
> +
> +	WORD_ADDR(saved_context_r0)
> +	WORD_ADDR(saved_cpsr)
> +	WORD_ADDR(saved_context_r8_fiq)
> +	WORD_ADDR(saved_spsr_fiq)
> +	WORD_ADDR(saved_context_r13_irq)
> +	WORD_ADDR(saved_spsr_irq)
> +	WORD_ADDR(saved_context_r13_svc)
> +	WORD_ADDR(saved_context_r14_svc)
> +	WORD_ADDR(saved_spsr_svc)
> +	WORD_ADDR(saved_context_r13_abt)
> +	WORD_ADDR(saved_spsr_abt)
> +	WORD_ADDR(saved_context_r13_und)
> +	WORD_ADDR(saved_spsr_und)
> +
> +FUNC_END(swsusp_arch_suspend)
> +
> +FUNC(swsusp_arch_resume)
> +	/* set page table if needed */
> +
> +	/*
> +	 * retore "nr_copy_pages" pages which are saved and specified
> +	 * at "pagedir_nosave"
> +	 */
> +
> +	ldr	r0, .Lpagedir_nosave
> +	ldr	r6, [r0]
> +	ldr	r0, .Lnr_copy_pages
> +	ldr	r7, [r0]
> +
> +.Lcopy_loop:
> +	ldr	r4, [r6]     /* src */
> +	ldr	r5, [r6, #4] /* dst */
> +	mov	r9, #1024
> +
> +	/* this loop could be optimized by using stm and ldm. */
> +.Lcopy_one_page:
> +	ldr	r8, [r4]
> +	str	r8, [r5]
> +
> +	add	r4, r4, #4
> +	add	r5, r5, #4
> +	sub	r9, r9, #1
> +	cmp	r9, #0
> +	bne	.Lcopy_one_page
> +
> +	add	r6, r6, #16 /* 16 means sizeof(suspend_pagedir_t) */
> +	sub	r7, r7, #1
> +	cmp	r7, #0
> +	bne	.Lcopy_loop
> +
> +	/* hold current mode */
> +	mrs	r0, cpsr
> +
> +	CHANGE_MODE(1f) /* change to system(user) mode */
> +	/* restore nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r0
> +	ldmia	r3, {r0-r14}
> +	/* restore current program status register */
> +	ldr	r3, .Lsaved_cpsr
> +	ldr	r1, [r3]
> +	msr	cpsr_cxsf, r1
> +
> +	CHANGE_MODE(11) /* change to fiq mode */
> +	/* restore nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r8_fiq
> +	ldmia	r3, {r8-r14}
> +	/* restore spsr_fiq register */
> +	ldr	r3, .Lsaved_spsr_fiq
> +	ldr	r1, [r3]
> +	msr	spsr_cxsf, r1
> +
> +	CHANGE_MODE(12) /* change to irq mode */
> +	/* restore nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r13_irq
> +	ldmia	r3, {r13-r14}
> +	/* restore spsr_irq register */
> +	ldr	r3, .Lsaved_spsr_irq
> +	ldr	r1, [r3]
> +	msr	spsr_cxsf, r1
> +
> +	CHANGE_MODE(13) /* change to svc mode */
> +	/* restore nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r13_svc
> +	ldmia	r3, {r13-r14}
> +	/* restore spsr_svc register */
> +	ldr	r3, .Lsaved_spsr_svc
> +	ldr	r1, [r3]
> +	msr	spsr_cxsf, r1
> +
> +	CHANGE_MODE(17) /* change to abt mode */
> +	/* restore nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r13_abt
> +	ldmia	r3, {r13-r14}
> +	/* restore spsr_abt register */
> +	ldr	r3, .Lsaved_spsr_abt
> +	ldr	r1, [r3]
> +	msr	spsr_cxsf, r1
> +
> +	CHANGE_MODE(1b) /* change to und mode */
> +	/* restore nonvolatile int register */
> +	ldr	r3, .Lsaved_context_r13_und
> +	ldmia	r3, {r13-r14}
> +	/* restore spsr_und register */
> +	ldr	r3, .Lsaved_spsr_und
> +	ldr	r1, [r3]
> +	msr	spsr_cxsf, r1
> +
> +	/* go back to original mode */
> +	msr	cpsr_c, r0
> +
> +	/*
> +	 * restore nonvolatile fp registers
> +	 *  and fp status/system registers, if needed
> +	 */
> +	/* XXX:TBD */
> +
> +	/* call swsusp_restore */
> +	bl	swsusp_restore
> +
> +	/* restore return address */
> +	ldr	r3, .Lsaved_context_r14_svc
> +	ldr	lr, [r3]
> +	mov	pc, lr
> +
> +	WORD_ADDR(nr_copy_pages)
> +	WORD_ADDR(pagedir_nosave)
> +
> +FUNC_END(swsusp_arch_resume)
> diff -uNrp linux-2.6.11.12-orig/include/asm-arm/suspend.h linux-2.6.11.12/include/asm-arm/suspend.h
> --- linux-2.6.11.12-orig/include/asm-arm/suspend.h	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/include/asm-arm/suspend.h	2005-07-05 14:52:20.000000000 +0900
> @@ -1,4 +1,45 @@
>  #ifndef _ASMARM_SUSPEND_H
>  #define _ASMARM_SUSPEND_H
>  
> +/*
> + * Based on code include/asm-i386/suspend.h
> + * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
> + * Copyright 2001 Patrick Mochel <mochel@osdl.org>
> + */
> +
> +
> +static inline int
> +arch_prepare_suspend(void)
> +{
> +	return 0;
> +}
> +
> +/* image of the saved processor state */
> +struct saved_context {
> +	/*
> +	 * Structure saved_context would be used to hold processor state
> +	 * except caller and callee registers, just before suspending.
> +	 */
> +
> +	/* coprocessor 15 registers */
> +//	__u32 ID_code;    /* read only reg */
> +//	__u32 cache_type; /* read only reg */
> +//	__u32 TCM_stat;   /* read only reg */
> +	__u32 CR;
> +	__u32 TTBR;
> +	__u32 DACR;
> +	__u32 D_FSR;
> +	__u32 I_FSR;
> +	__u32 FAR;
> +//	__u32 COR;    /*write only reg */
> +//	__u32 TLBOR;  /*write only reg */
> +	__u32 D_CLR;
> +	__u32 I_CLR;
> +	__u32 D_TCMRR;
> +	__u32 I_TCMRR;
> +	__u32 TLBLR;
> +	__u32 FCSE;
> +	__u32 CID;
> +};
> +
>  #endif
> diff -uNrp linux-2.6.11.12-orig/include/asm-arm/tlbflush.h linux-2.6.11.12/include/asm-arm/tlbflush.h
> --- linux-2.6.11.12-orig/include/asm-arm/tlbflush.h	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/include/asm-arm/tlbflush.h	2005-07-05 14:50:51.000000000 +0900
> @@ -253,6 +253,9 @@ static inline void flush_tlb_all(void)
>  		asm("mcr%? p15, 0, %0, c8, c5, 0" : : "r" (zero));
>  }
>  
> +#define __flush_tlb_all    flush_tlb_all
> +#define __flush_tlb_global flush_tlb_all
> +
>  static inline void flush_tlb_mm(struct mm_struct *mm)
>  {
>  	const int zero = 0;
> diff -uNrp linux-2.6.11.12-orig/include/linux/suspend.h linux-2.6.11.12/include/linux/suspend.h
> --- linux-2.6.11.12-orig/include/linux/suspend.h	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/include/linux/suspend.h	2005-07-05 15:04:10.000000000 +0900
> @@ -1,7 +1,7 @@
>  #ifndef _LINUX_SWSUSP_H
>  #define _LINUX_SWSUSP_H
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_FRV)
> +#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
>  #include <asm/suspend.h>
>  #endif
>  #include <linux/swap.h>

> diff -uNrp linux-2.6.11.12-orig/arch/arm/mach-omap/common.c linux-2.6.11.12/arch/arm/mach-omap/common.c
> --- linux-2.6.11.12-orig/arch/arm/mach-omap/common.c	2005-07-05 14:09:26.000000000 +0900
> +++ linux-2.6.11.12/arch/arm/mach-omap/common.c	2005-07-05 14:50:37.000000000 +0900
> @@ -442,8 +442,16 @@ void __init omap_serial_init(int ports[O
>  	}
>  }
>  
> +static void omap_power_off(void)
> +{
> +	printk("System Halted\n");
> +	local_irq_disable();
> +	while (1) ;
> +}
> +
>  static int __init omap_init(void)
>  {
> +	pm_power_off = omap_power_off;
>  	return platform_device_register(&serial_device);
>  }
>  arch_initcall(omap_init);
> diff -uNrp linux-2.6.11.12-orig/drivers/mtd/mtdblock.c linux-2.6.11.12/drivers/mtd/mtdblock.c
> --- linux-2.6.11.12-orig/drivers/mtd/mtdblock.c	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/drivers/mtd/mtdblock.c	2005-07-05 14:49:01.000000000 +0900
> @@ -321,6 +321,24 @@ static int mtdblock_release(struct mtd_b
>  	return 0;
>  }  
>  
> +#if defined(CONFIG_SWSUSP_MTDBLOCK_FLUSH)
> +/* XXXX: quick hack, need to be rewrite later */
> +int swsusp_mtdblock_flush(void)
> +{
> +#if defined CONFIG_MACH_OMAP_OSK
> +	struct mtdblk_dev *mtdblk = mtdblks[3];
> +#endif
> +
> +	down(&mtdblk->cache_sem);
> +	write_cached_data(mtdblk);
> +	up(&mtdblk->cache_sem);
> +
> +	if (mtdblk->mtd->sync)
> +		mtdblk->mtd->sync(mtdblk->mtd);
> +	return 0;
> +}
> +#endif
> +
>  static int mtdblock_flush(struct mtd_blktrans_dev *dev)
>  {
>  	struct mtdblk_dev *mtdblk = mtdblks[dev->devnum];
> + * Based on code
> diff -uNrp linux-2.6.11.12-orig/kernel/power/Kconfig linux-2.6.11.12/kernel/power/Kconfig
> --- linux-2.6.11.12-orig/kernel/power/Kconfig	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/kernel/power/Kconfig	2005-07-05 14:49:01.000000000 +0900
> @@ -72,3 +72,10 @@ config PM_STD_PARTITION
>  	  suspended image to. It will simply pick the first available swap 
>  	  device.
>  
> +config SWSUSP_MTDBLOCK_FLUSH
> +	bool "Flush MTD block"
> +	depends on SOFTWARE_SUSPEND
> +	default "y"
> +	---help---
> +	  When suspend to disk (software suspend), flush the MTD block.
> +
> diff -uNrp linux-2.6.11.12-orig/kernel/power/disk.c linux-2.6.11.12/kernel/power/disk.c
> --- linux-2.6.11.12-orig/kernel/power/disk.c	2005-06-12 11:45:37.000000000 +0900
> +++ linux-2.6.11.12/kernel/power/disk.c	2005-07-05 14:49:01.000000000 +0900
> @@ -48,6 +48,11 @@ static void power_down(suspend_disk_meth
>  	unsigned long flags;
>  	int error = 0;
>  
> +#if defined(CONFIG_SWSUSP_MTDBLOCK_FLUSH)
> +/* XXXX: quick hack, need to be rewrite later */
> +	printk(KERN_CRIT "flush MTD\n");
> +	swsusp_mtdblock_flush();
> +#endif
>  	local_irq_save(flags);
>  	switch(mode) {
>  	case PM_DISK_PLATFORM:


-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
