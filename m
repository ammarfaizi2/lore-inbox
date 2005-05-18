Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVERMgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVERMgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVERMgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:36:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17109 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261509AbVERMfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:35:02 -0400
Date: Wed, 18 May 2005 18:05:00 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: fastboot@lists.osdl.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] [1/2] kdump: Use real pt_regs from exception
Message-ID: <20050518123500.GA3657@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1116103798.6153.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116103798.6153.30.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 10:49:58PM +0200, Alexander Nyberg wrote:
> Makes kexec_crashdump() take a pt_regs * as an argument. This allows to
> get exact register state at the point of the crash. If we come from
> direct panic assertion NULL will be passed and the current registers
> saved before crashdump.
> 
> This hooks into two places:
> die(): check the conditions under which we will panic when calling
> do_exit and go there directly with the pt_regs that caused the fatal
> fault.
> 
> die_nmi(): If we receive an NMI lockup while in the kernel use the
> pt_regs and go directly to crash_kexec(). We're probably nested up badly
> at this point so this might be the only chance to escape with proper
> information.
> 
> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 


Largely looks ok except few comments . Copying to LKML for more eyes.

I am tempted to think that if panic had been passed pt_regs, then 
crash_kexec() call could have been placed at a single place that too in 
architecture independent manner. But panic is called at too many a places 
to change the function signature. Just a passing thought. 


> Index: mm/include/linux/reboot.h
> ===================================================================
> --- mm.orig/include/linux/reboot.h	2005-05-14 22:29:16.000000000 +0200
> +++ mm/include/linux/reboot.h	2005-05-14 22:29:29.000000000 +0200
> @@ -50,9 +50,10 @@
>  extern void machine_restart(char *cmd);
>  extern void machine_halt(void);
>  extern void machine_power_off(void);
> -
>  extern void machine_shutdown(void);
> -extern void machine_crash_shutdown(void);
> +
> +struct pt_regs;
> +extern void machine_crash_shutdown(struct pt_regs *);
>  
>  #endif
>  
> Index: mm/arch/i386/kernel/traps.c
> ===================================================================
> --- mm.orig/arch/i386/kernel/traps.c	2005-05-14 22:29:16.000000000 +0200
> +++ mm/arch/i386/kernel/traps.c	2005-05-14 22:48:14.000000000 +0200
> @@ -27,6 +27,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/utsname.h>
>  #include <linux/kprobes.h>
> +#include <linux/kexec.h>
>  
>  #ifdef CONFIG_EISA
>  #include <linux/ioport.h>
> @@ -326,6 +327,9 @@
>  	printk("Kernel BUG\n");
>  }
>  
> +/* This is gone through when something in the kernel
> + * has done something bad and is about to be terminated.
> +*/
>  void die(const char * str, struct pt_regs * regs, long err)
>  {
>  	static struct {
> @@ -382,6 +386,10 @@
>  	bust_spinlocks(0);
>  	die.lock_owner = -1;
>  	spin_unlock_irq(&die.lock);
> +	
> +	if (in_interrupt() || !current->pid || current->pid == 1)
> +		crash_kexec(regs);
> +	


Would be nice if panic_on_oops case also can be covered. There also we want 
to capture actual pt_regs register state.


>  	if (in_interrupt())
>  		panic("Fatal exception in interrupt");
>  
> @@ -616,6 +624,15 @@
>  	console_silent();
>  	spin_unlock(&nmi_print_lock);
>  	bust_spinlocks(0);
> +
> +	/* If we are in kernel we are probably nested up pretty bad
> +	 * and might aswell get out now while we still can.
> +	*/
> +	if (!user_mode(regs)) {
> +		current->thread.trap_no = 2;
> +		crash_kexec(regs);
> +	}
> +	
>  	do_exit(SIGSEGV);
>  }
>  
> Index: mm/arch/i386/kernel/crash.c
> ===================================================================
> --- mm.orig/arch/i386/kernel/crash.c	2005-05-14 22:29:16.000000000 +0200
> +++ mm/arch/i386/kernel/crash.c	2005-05-14 22:48:53.000000000 +0200
> @@ -98,12 +98,19 @@
>  	regs->eip = (unsigned long)current_text_addr();
>  }
>  
> -static void crash_save_self(void)
> +/* We may have saved_regs from where the error came from
> + * or it is NULL if via a direct panic(). 
> + */
> +static void crash_save_self(struct pt_regs *saved_regs)
>  {
>  	struct pt_regs regs;
>  	int cpu;
>  	cpu = smp_processor_id();
> -	crash_get_current_regs(&regs);
> +	
> +	if (saved_regs)
> +		memcpy(&regs, saved_regs, sizeof(regs));


saved_regs will not have proper value of ss and esp if exception occurred
which thread was running in kernel mode as cpu has not pushed these on stack
A fix something like following also might go here.

if (saved_regs) {
	memcpy(&regs, saved_regs, sizeof(regs));
	if (!user_mode(saved_regs)) {
		regs.esp = (unsigned long)&(saved_regs->esp);
		__asm__ __volatile__("xorl %eax, %eax;");
		__asm__ __volatile__ ("movw %%ss, %%ax;"
                                        :"=a"(regs.xss));
	}
}


> +	else
> +		crash_get_current_regs(&regs);
>  	crash_save_this_cpu(&regs, cpu);
>  }
>  
> @@ -175,7 +182,7 @@
>  }
>  #endif
>  
> -void machine_crash_shutdown(void)
> +void machine_crash_shutdown(struct pt_regs *regs)
>  {
>  	/* This function is only called after the system
>  	 * has paniced or is otherwise in a critical state.
> @@ -192,5 +199,5 @@
>  #if defined(CONFIG_X86_IO_APIC)
>  	disable_IO_APIC();
>  #endif
> -	crash_save_self();
> +	crash_save_self(regs);
>  }
> Index: mm/kernel/panic.c
> ===================================================================
> --- mm.orig/kernel/panic.c	2005-05-14 22:29:16.000000000 +0200
> +++ mm/kernel/panic.c	2005-05-14 22:29:29.000000000 +0200
> @@ -83,7 +83,7 @@
>  	 * everything else.
>  	 * Do we want to call this before we try to display a message?
>  	 */
> -	crash_kexec();
> +	crash_kexec(NULL);
>  
>  #ifdef CONFIG_SMP
>  	/*
> Index: mm/kernel/kexec.c
> ===================================================================
> --- mm.orig/kernel/kexec.c	2005-05-14 22:29:16.000000000 +0200
> +++ mm/kernel/kexec.c	2005-05-14 22:29:29.000000000 +0200
> @@ -1010,7 +1010,7 @@
>  }
>  #endif
>  
> -void crash_kexec(void)
> +void crash_kexec(struct pt_regs *regs)
>  {
>  	struct kimage *image;
>  	int locked;
> @@ -1028,7 +1028,7 @@
>  	if (!locked) {
>  		image = xchg(&kexec_crash_image, NULL);
>  		if (image) {
> -			machine_crash_shutdown();
> +			machine_crash_shutdown(regs);
>  			machine_kexec(image);
>  		}
>  		xchg(&kexec_lock, 0);
> Index: mm/include/linux/kexec.h
> ===================================================================
> --- mm.orig/include/linux/kexec.h	2005-05-14 22:29:16.000000000 +0200
> +++ mm/include/linux/kexec.h	2005-05-14 22:29:29.000000000 +0200
> @@ -99,7 +99,7 @@
>  	unsigned long flags);
>  #endif
>  extern struct page *kimage_alloc_control_pages(struct kimage *image, unsigned int order);
> -extern void crash_kexec(void);
> +extern void crash_kexec(struct pt_regs *);
>  extern struct kimage *kexec_image;
>  
>  #define KEXEC_ON_CRASH  0x00000001
> @@ -123,6 +123,6 @@
>  extern struct resource crashk_res;
>  
>  #else /* !CONFIG_KEXEC */
> -static inline void crash_kexec(void) { }
> +static inline void crash_kexec(struct pt_regs *regs) { }
>  #endif /* CONFIG_KEXEC */
>  #endif /* LINUX_KEXEC_H */
> Index: mm/drivers/char/sysrq.c
> ===================================================================
> --- mm.orig/drivers/char/sysrq.c	2005-05-14 22:29:16.000000000 +0200
> +++ mm/drivers/char/sysrq.c	2005-05-14 22:29:29.000000000 +0200
> @@ -119,7 +119,7 @@
>  static void sysrq_handle_crashdump(int key, struct pt_regs *pt_regs,
>  				struct tty_struct *tty)
>  {
> -	crash_kexec();
> +	crash_kexec(pt_regs);
>  }
>  static struct sysrq_key_op sysrq_crashdump_op = {
>  	.handler	= sysrq_handle_crashdump,
> 
> 

> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/fastboot

