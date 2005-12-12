Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVLLOW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVLLOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVLLOW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:22:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33692 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751203AbVLLOWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:22:25 -0500
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       rth@twiddle.net, davej@redhat.com, zwane@arm.linux.org.uk, ak@suse.de,
       ashok.raj@intel.com
Subject: Re: [PATCH] move pm_power_off and pm_idle declaration to common
 code
References: <E1EloGS-0005gf-00@dorka.pomaz.szeredi.hu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 12 Dec 2005 07:20:12 -0700
In-Reply-To: <E1EloGS-0005gf-00@dorka.pomaz.szeredi.hu> (Miklos Szeredi's
 message of "Mon, 12 Dec 2005 15:02:52 +0100")
Message-ID: <m1pso29z37.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> This patch broke UML build (and approx 15 other archs):
>
>   dont-attempt-to-power-off-if-power-off-is-not-implemented.patch
>
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x148e1): In function `sys_reboot':
> kernel/sys.c:535: undefined reference to `pm_power_off'
>
> So move declaration of pm_power_off (and with it pm_idle) from the
> archs that do define it to kernel/sys.c.  This should fix the link
> problem, and at the same time remove some duplication.

Sounds sane.  

Does powerpc still build?  A key question is how do we handle architectures
that always want to want to call machine_power_off.

If they can declare a static initializer like powerpc does that problem
is largely solved.  If we can't do something simple like that we
still need to solve that case.

Eric
>
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> ---
>
> Index: linux/kernel/sys.c
> ===================================================================
> --- linux.orig/kernel/sys.c	2005-12-12 12:04:21.000000000 +0100
> +++ linux/kernel/sys.c	2005-12-12 13:54:31.000000000 +0100
> @@ -97,6 +97,18 @@ int cad_pid = 1;
>  static struct notifier_block *reboot_notifier_list;
>  static DEFINE_RWLOCK(notifier_lock);
>  
> +/*
> + * Powermanagement idle function, if any..
> + */
> +void (*pm_idle)(void);
> +EXPORT_SYMBOL(pm_idle);
> +
> +/*
> + * Power off function, if any
> + */
> +void (*pm_power_off)(void);
> +EXPORT_SYMBOL(pm_power_off);
> +
>  /**
>   *	notifier_chain_register	- Add notifier to a notifier chain
>   *	@list: Pointer to root list pointer
> Index: linux/arch/frv/kernel/pm.c
> ===================================================================
> --- linux.orig/arch/frv/kernel/pm.c	2005-12-06 14:08:49.000000000 +0100
> +++ linux/arch/frv/kernel/pm.c	2005-12-12 13:50:46.000000000 +0100
> @@ -26,8 +26,6 @@
>  
>  #include "local.h"
>  
> -void (*pm_power_off)(void);
> -
>  extern void frv_change_cmode(int);
>  
>  /*
> Index: linux/arch/i386/kernel/reboot.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/reboot.c 2005-12-12 12:04:05.000000000 +0100
> +++ linux/arch/i386/kernel/reboot.c	2005-12-12 13:51:34.000000000 +0100
> @@ -19,12 +19,6 @@
>  #include "mach_reboot.h"
>  #include <linux/reboot_fixups.h>
>  
> -/*
> - * Power off function, if any
> - */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  static int reboot_mode;
>  static int reboot_thru_bios;
>  
> Index: linux/arch/powerpc/kernel/setup-common.c
> ===================================================================
> --- linux.orig/arch/powerpc/kernel/setup-common.c 2005-12-12 12:04:07.000000000
> +0100
> +++ linux/arch/powerpc/kernel/setup-common.c 2005-12-12 14:30:54.000000000 +0100
> @@ -30,6 +30,7 @@
>  #include <linux/unistd.h>
>  #include <linux/serial.h>
>  #include <linux/serial_8250.h>
> +#include <linux/pm.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/processor.h>
> @@ -124,7 +125,6 @@ void machine_power_off(void)
>  EXPORT_SYMBOL_GPL(machine_power_off);
>  
>  void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL_GPL(pm_power_off);
>  
>  void machine_halt(void)
>  {
> Index: linux/arch/sparc/kernel/sparc_ksyms.c
> ===================================================================
> --- linux.orig/arch/sparc/kernel/sparc_ksyms.c 2005-10-28 02:02:08.000000000
> +0200
> +++ linux/arch/sparc/kernel/sparc_ksyms.c 2005-12-12 14:09:25.000000000 +0100
> @@ -324,8 +324,5 @@ EXPORT_SYMBOL(_Udiv);
>  EXPORT_SYMBOL(do_BUG);
>  #endif
>  
> -/* Sun Power Management Idle Handler */
> -EXPORT_SYMBOL(pm_idle);
> -
>  /* Binfmt_misc needs this */
>  EXPORT_SYMBOL(sys_close);
> Index: linux/arch/x86_64/kernel/process.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/process.c 2005-12-12 12:04:08.000000000 +0100
> +++ linux/arch/x86_64/kernel/process.c	2005-12-12 14:11:05.000000000 +0100
> @@ -58,10 +58,6 @@ unsigned long kernel_thread_flags = CLON
>  unsigned long boot_option_idle_override = 0;
>  EXPORT_SYMBOL(boot_option_idle_override);
>  
> -/*
> - * Powermanagement idle function, if any..
> - */
> -void (*pm_idle)(void);
>  static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
>  
>  /*
> Index: linux/arch/x86_64/kernel/reboot.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/reboot.c 2005-12-12 12:04:08.000000000 +0100
> +++ linux/arch/x86_64/kernel/reboot.c	2005-12-12 14:10:41.000000000 +0100
> @@ -16,11 +16,6 @@
>  #include <asm/tlbflush.h>
>  #include <asm/apic.h>
>  
> -/*
> - * Power off function, if any
> - */
> -void (*pm_power_off)(void);
> -
>  static long no_idt[3];
>  static enum { 
>  	BOOT_TRIPLE = 't',
> Index: linux/arch/parisc/kernel/parisc_ksyms.c
> ===================================================================
> --- linux.orig/arch/parisc/kernel/parisc_ksyms.c 2005-10-28 02:02:08.000000000
> +0200
> +++ linux/arch/parisc/kernel/parisc_ksyms.c 2005-12-12 14:07:36.000000000 +0100
> @@ -48,9 +48,6 @@ EXPORT_SYMBOL(strrchr);
>  EXPORT_SYMBOL(strstr);
>  EXPORT_SYMBOL(strpbrk);
>  
> -#include <linux/pm.h>
> -EXPORT_SYMBOL(pm_power_off);
> -
>  #include <asm/atomic.h>
>  EXPORT_SYMBOL(__xchg8);
>  EXPORT_SYMBOL(__xchg32);
> Index: linux/arch/x86_64/kernel/x8664_ksyms.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/x8664_ksyms.c 2005-12-06 14:08:50.000000000
> +0100
> +++ linux/arch/x86_64/kernel/x8664_ksyms.c 2005-12-12 14:20:43.000000000 +0100
> @@ -58,8 +58,6 @@ EXPORT_SYMBOL(disable_irq);
>  EXPORT_SYMBOL(disable_irq_nosync);
>  EXPORT_SYMBOL(probe_irq_mask);
>  EXPORT_SYMBOL(kernel_thread);
> -EXPORT_SYMBOL(pm_idle);
> -EXPORT_SYMBOL(pm_power_off);
>  EXPORT_SYMBOL(get_cmos_time);
>  
>  EXPORT_SYMBOL(__down_failed);
> Index: linux/arch/i386/mach-visws/reboot.c
> ===================================================================
> --- linux.orig/arch/i386/mach-visws/reboot.c 2005-10-28 02:02:08.000000000 +0200
> +++ linux/arch/i386/mach-visws/reboot.c	2005-12-12 13:56:27.000000000 +0100
> @@ -6,9 +6,6 @@
>  #include <asm/io.h>
>  #include "piix4.h"
>  
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void machine_shutdown(void)
>  {
>  #ifdef CONFIG_SMP
> Index: linux/arch/ppc/kernel/setup.c
> ===================================================================
> --- linux.orig/arch/ppc/kernel/setup.c	2005-12-12 12:04:07.000000000 +0100
> +++ linux/arch/ppc/kernel/setup.c	2005-12-12 14:27:42.000000000 +0100
> @@ -18,6 +18,7 @@
>  #include <linux/root_dev.h>
>  #include <linux/cpu.h>
>  #include <linux/console.h>
> +#include <linux/pm.h>
>  
>  #include <asm/residual.h>
>  #include <asm/io.h>
> Index: linux/arch/sparc/kernel/process.c
> ===================================================================
> --- linux.orig/arch/sparc/kernel/process.c 2005-12-06 14:08:50.000000000 +0100
> +++ linux/arch/sparc/kernel/process.c	2005-12-12 14:09:43.000000000 +0100
> @@ -43,19 +43,6 @@
>  #include <asm/elf.h>
>  #include <asm/unistd.h>
>  
> -/* 
> - * Power management idle function 
> - * Set in pm platform drivers (apc.c and pmc.c)
> - */
> -void (*pm_idle)(void);
> -
> -/* 
> - * Power-off handler instantiation for pm.h compliance
> - * This is done via auxio, but could be used as a fallback
> - * handler when auxio is not present-- unused for now...
> - */
> -void (*pm_power_off)(void);
> -
>  /*
>   * sysctl - toggle power-off restriction for serial console 
>   * systems in machine_power_off()
> Index: linux/arch/arm/kernel/process.c
> ===================================================================
> --- linux.orig/arch/arm/kernel/process.c 2005-12-12 13:30:33.000000000 +0100
> +++ linux/arch/arm/kernel/process.c	2005-12-12 13:32:14.000000000 +0100
> @@ -27,6 +27,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
> +#include <linux/pm.h>
>  
>  #include <asm/system.h>
>  #include <asm/io.h>
> @@ -72,15 +73,6 @@ __setup("nohlt", nohlt_setup);
>  __setup("hlt", hlt_setup);
>  
>  /*
> - * The following aren't currently used.
> - */
> -void (*pm_idle)(void);
> -EXPORT_SYMBOL(pm_idle);
> -
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
> -/*
>   * This is our default idle handler.  We need to disable
>   * interrupts here to ensure we don't miss a wakeup call.
>   */
> Index: linux/arch/ia64/kernel/acpi.c
> ===================================================================
> --- linux.orig/arch/ia64/kernel/acpi.c	2005-12-06 14:08:49.000000000 +0100
> +++ linux/arch/ia64/kernel/acpi.c	2005-12-12 14:04:09.000000000 +0100
> @@ -60,11 +60,6 @@
>  
>  #define PREFIX			"ACPI: "
>  
> -void (*pm_idle) (void);
> -EXPORT_SYMBOL(pm_idle);
> -void (*pm_power_off) (void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  unsigned char acpi_kbd_controller_present = 1;
>  unsigned char acpi_legacy_devices;
>  
> Index: linux/arch/ppc/kernel/ppc_ksyms.c
> ===================================================================
> --- linux.orig/arch/ppc/kernel/ppc_ksyms.c 2005-12-12 12:04:07.000000000 +0100
> +++ linux/arch/ppc/kernel/ppc_ksyms.c	2005-12-12 14:02:30.000000000 +0100
> @@ -249,8 +249,6 @@ EXPORT_SYMBOL(kd_mksound);
>  #endif
>  EXPORT_SYMBOL(to_tm);
>  
> -EXPORT_SYMBOL(pm_power_off);
> -
>  EXPORT_SYMBOL(__ashrdi3);
>  EXPORT_SYMBOL(__ashldi3);
>  EXPORT_SYMBOL(__lshrdi3);
> Index: linux/arch/i386/kernel/process.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/process.c 2005-12-12 12:04:05.000000000 +0100
> +++ linux/arch/i386/kernel/process.c	2005-12-12 13:56:05.000000000 +0100
> @@ -39,6 +39,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/random.h>
>  #include <linux/kprobes.h>
> +#include <linux/pm.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
> @@ -72,11 +73,6 @@ unsigned long thread_saved_pc(struct tas
>  	return ((unsigned long *)tsk->thread.esp)[3];
>  }
>  
> -/*
> - * Powermanagement idle function, if any..
> - */
> -void (*pm_idle)(void);
> -EXPORT_SYMBOL(pm_idle);
>  static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
>  
>  void disable_hlt(void)
> Index: linux/arch/parisc/kernel/process.c
> ===================================================================
> --- linux.orig/arch/parisc/kernel/process.c 2005-12-06 14:08:50.000000000 +0100
> +++ linux/arch/parisc/kernel/process.c	2005-12-12 14:06:52.000000000 +0100
> @@ -45,6 +45,7 @@
>  #include <linux/stddef.h>
>  #include <linux/unistd.h>
>  #include <linux/kallsyms.h>
> +#include <linux/pm.h>
>  
>  #include <asm/io.h>
>  #include <asm/asm-offsets.h>
> @@ -56,11 +57,6 @@
>  
>  static int hlt_counter;
>  
> -/*
> - * Power off function, if any
> - */ 
> -void (*pm_power_off)(void);
> -
>  void disable_hlt(void)
>  {
>  	hlt_counter++;
> Index: linux/arch/i386/mach-voyager/voyager_basic.c
> ===================================================================
> --- linux.orig/arch/i386/mach-voyager/voyager_basic.c 2005-10-28
> 02:02:08.000000000 +0200
> +++ linux/arch/i386/mach-voyager/voyager_basic.c 2005-12-12 13:56:52.000000000
> +0100
> @@ -31,12 +31,6 @@
>  #include <asm/arch_hooks.h>
>  #include <asm/i8253.h>
>  
> -/*
> - * Power off function, if any
> - */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  int voyager_level = 0;
>  
>  struct voyager_SUS *voyager_SUS = NULL;
