Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTELFjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 01:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTELFjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 01:39:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43600 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261932AbTELFjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 01:39:32 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] always shutdown on the bootstrap processor
References: <20030510025634.GA31713@averell>
	<20030510033504.GA1789@zip.com.au>
	<1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk>
	<m1bry9746i.fsf@frodo.biederman.org>
	<1052673863.29921.17.camel@dhcp22.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 23:48:54 -0600
In-Reply-To: <1052673863.29921.17.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <m165og67g9.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sul, 2003-05-11 at 19:01, Eric W. Biederman wrote:
> > > At least some SMP boxes freak if you do a poweroff request on CPU != 0
> > 
> > As per the MP spec.  The system should reboot on the bootstrap cpu.
> > smp_processor_id() == 0 on x86.  apicid??
> 
> APM now makes its calls on CPU#0 which was the trigger for these
> problems

We have the APM case, we have the reboot case, we have the specifications
that say you should use the bootstrap processor, and I have problems
with kexec if we do anything different.

And looking at other architectures this problem also happens on the alpha,
and I don't know how many others.

reboot/shutdown/halt/kexec all of these are a slow path so is there
any good reason not to unify all of these and always switch back to the
bootstrap processor on shutdown?  Just to avoid this kinds of problems?

Things I have taken into consideration.
1) Running multiple processors on x86 is intricately tied to apics so
   they both need to be shutdown together.  And apic shutdown needs to
   happen last because devices potentially need interrupts (at least
   timer interrupts for timeouts) to shutdown properly.  So I cannot
   use the device mode to perform the shutdown.

2) The reboot case needs to be callable from an irq handler.

3) We may have off lined the bootstrap cpu for some reason.

4) The user may have specified an override cpu to shut down on.

With a net of 2 additional lines of code I am able to do what
the current code does today, in one central location, and much
more consistency.

For the author the code compiles and runs, and looks obviously
correct.  So obviously it is perfect and ready to go in the kernel :)

This patch also makes machine_restart, machine_halt, and
machine_power_off, all no return functions, so the core kernel does
not have to figure out how to deal with a kernel that is half
shutdown.  Turning off a cpu and then calling flush_tlbs can be
entertaining.

Eric

 arch/i386/kernel/apic.c                     |   60 +++++++++++++++++++++
 arch/i386/kernel/apm.c                      |    9 ---
 arch/i386/kernel/dmi_scan.c                 |   27 ---------
 arch/i386/kernel/io_apic.c                  |    2 
 arch/i386/kernel/reboot.c                   |   78 ++++++++++++----------------
 arch/i386/kernel/smp.c                      |   26 ---------
 include/asm-i386/apic.h                     |   13 ++++
 include/asm-i386/mach-default/mach_reboot.h |    2 
 include/linux/reboot.h                      |    7 +-
 kernel/panic.c                              |    2 
 kernel/sys.c                                |    4 -
 11 files changed, 116 insertions, 114 deletions


diff -uNr linux-2.5.69/arch/i386/kernel/apic.c linux-2.5.69.reboot_on_bsp/arch/i386/kernel/apic.c
--- linux-2.5.69/arch/i386/kernel/apic.c	Sun May 11 09:08:57 2003
+++ linux-2.5.69.reboot_on_bsp/arch/i386/kernel/apic.c	Sun May 11 14:38:36 2003
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/reboot.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -37,6 +38,7 @@
 #include <mach_apic.h>
 
 #include "io_ports.h"
+#include "mach_reboot.h"
 
 void __init apic_intr_init(void)
 {
@@ -1114,6 +1116,64 @@
 	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+}
+
+
+struct stop_apics {
+	NORET_TYPE void (*rest)(void *info) ATTRIB_NORET;
+	void *info;
+	int reboot_cpu_id;
+};
+
+static void cpu_stop_apics(void *ptr)
+{
+	struct stop_apics *arg = ptr;
+	if (smp_processor_id() != arg->reboot_cpu_id) {
+		local_irq_disable();
+		disable_local_APIC();
+		stop_this_cpu();
+	}
+	local_irq_disable();
+	disable_local_APIC();
+	local_irq_enable();
+
+#if defined(CONFIG_X86_IO_APIC)
+	if (smp_found_config) {
+		disable_IO_APIC();
+	}
+#endif
+	disconnect_bsp_APIC();
+	arg->rest(arg->info);
+}
+
+void stop_apics(NORET_TYPE void(*rest)(void *)ATTRIB_NORET, void *info)
+{
+	/* By resetting the APIC's we disable the nmi watchdog */
+	extern int reboot_cpu;
+	struct stop_apics arg;
+	
+ 	/* The boot cpu is always logical cpu 0 */
+	arg.rest = rest;
+	arg.info = info;
+	arg.reboot_cpu_id = 0;
+	
+	/* See if there has been give a command line override .
+	 */
+	if ((reboot_cpu != -1) && cpu_possible(reboot_cpu)) {
+		arg.reboot_cpu_id = reboot_cpu;
+	}
+
+	/* Make certain the the cpu I'm rebooting on is online */
+	if (!cpu_online(arg.reboot_cpu_id)) {
+		arg.reboot_cpu_id = smp_processor_id();
+	}
+	/* If we aren't in interrupt context use the scheduler,
+	 * so rest will not be called in an interrupt context either.
+	 */
+	if (!in_interrupt()) {
+		set_cpus_allowed(current, 1 << arg.reboot_cpu_id);
+	}
+	on_each_cpu(cpu_stop_apics, &arg, 1, 0);
 }
 
 /*
diff -uNr linux-2.5.69/arch/i386/kernel/apm.c linux-2.5.69.reboot_on_bsp/arch/i386/kernel/apm.c
--- linux-2.5.69/arch/i386/kernel/apm.c	Sun May 11 09:09:25 2003
+++ linux-2.5.69.reboot_on_bsp/arch/i386/kernel/apm.c	Sun May 11 14:39:11 2003
@@ -911,17 +911,8 @@
 	/*
 	 * This may be called on an SMP machine.
 	 */
-#ifdef CONFIG_SMP
-	/* Some bioses don't like being called from CPU != 0 */
-	if (smp_processor_id() != 0) {
-		set_cpus_allowed(current, 1 << 0);
-		if (unlikely(smp_processor_id() != 0))
-			BUG();
-	}
-#endif
 	if (apm_info.realmode_power_off)
 	{
-		(void)apm_save_cpus();
 		machine_real_restart(po_bios_call, sizeof(po_bios_call));
 	}
 	else
diff -uNr linux-2.5.69/arch/i386/kernel/dmi_scan.c linux-2.5.69.reboot_on_bsp/arch/i386/kernel/dmi_scan.c
--- linux-2.5.69/arch/i386/kernel/dmi_scan.c	Sun May 11 09:08:57 2003
+++ linux-2.5.69.reboot_on_bsp/arch/i386/kernel/dmi_scan.c	Sun May 11 14:40:10 2003
@@ -220,31 +220,6 @@
 	return 0;
 }
 
-/*
- * Some machines require the "reboot=s"  commandline option, this quirk makes that automatic.
- */
-static __init int set_smp_reboot(struct dmi_blacklist *d)
-{
-#ifdef CONFIG_SMP
-	extern int reboot_smp;
-	if (reboot_smp == 0)
-	{
-		reboot_smp = 1;
-		printk(KERN_INFO "%s series board detected. Selecting SMP-method for reboots.\n", d->ident);
-	}
-#endif
-	return 0;
-}
-
-/*
- * Some machines require the "reboot=b,s"  commandline option, this quirk makes that automatic.
- */
-static __init int set_smp_bios_reboot(struct dmi_blacklist *d)
-{
-	set_smp_reboot(d);
-	set_bios_reboot(d);
-	return 0;
-}
 
 /*
  * Some bioses have a broken protected mode poweroff and need to use realmode
@@ -554,7 +529,7 @@
 			MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
 			MATCH(DMI_BIOS_DATE, "134526184"), NO_MATCH
 			} },
-	{ set_smp_bios_reboot, "Dell PowerEdge 1300", {	/* Handle problems with rebooting on Dell 1300's */
+	{ set_bios_reboot, "Dell PowerEdge 1300", {	/* Handle problems with rebooting on Dell 1300's */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
 			NO_MATCH, NO_MATCH
diff -uNr linux-2.5.69/arch/i386/kernel/io_apic.c linux-2.5.69.reboot_on_bsp/arch/i386/kernel/io_apic.c
--- linux-2.5.69/arch/i386/kernel/io_apic.c	Sun May 11 09:09:25 2003
+++ linux-2.5.69.reboot_on_bsp/arch/i386/kernel/io_apic.c	Sun May 11 14:41:26 2003
@@ -1545,8 +1545,6 @@
 	 * Clear the IO-APIC before rebooting:
 	 */
 	clear_IO_APIC();
-
-	disconnect_bsp_APIC();
 }
 
 /*
diff -uNr linux-2.5.69/arch/i386/kernel/reboot.c linux-2.5.69.reboot_on_bsp/arch/i386/kernel/reboot.c
--- linux-2.5.69/arch/i386/kernel/reboot.c	Sun May 11 09:08:13 2003
+++ linux-2.5.69.reboot_on_bsp/arch/i386/kernel/reboot.c	Sun May 11 17:53:34 2003
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include <asm/apic.h>
 #include "mach_reboot.h"
 
 /*
@@ -19,9 +20,8 @@
 static int reboot_mode;
 int reboot_thru_bios;
 
+int reboot_cpu = -1;	  /* specifies the internal linux cpu id, not the apicid */
 #ifdef CONFIG_SMP
-int reboot_smp = 0;
-static int reboot_cpu = -1;
 /* shamelessly grabbed from lib/vsprintf.c for readability */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
 #endif
@@ -43,12 +43,14 @@
 			break;
 #ifdef CONFIG_SMP
 		case 's': /* "smp" reboot by executing reset on BSP or other CPU*/
-			reboot_smp = 1;
 			if (is_digit(*(str+1))) {
 				reboot_cpu = (int) (*(str+1) - '0');
 				if (is_digit(*(str+2))) 
 					reboot_cpu = reboot_cpu*10 + (int)(*(str+2) - '0');
 			}
+			if ((reboot_cpu < -1) || (reboot_cpu >= NR_CPUS)) {
+				reboot_cpu = -1;
+			}
 				/* we will leave sorting out the final value 
 				when we are ready to reboot, since we might not
  				have set up boot_cpu_id or smp_num_cpu */
@@ -65,6 +67,20 @@
 
 __setup("reboot=", reboot_setup);
 
+
+void stop_this_cpu(void)
+{
+	/*
+	 * Remove this CPU:
+	 */
+#if CONFIG_SMP
+	clear_bit(smp_processor_id(), &cpu_online_map);
+#endif
+	if (cpu_data[smp_processor_id()].hlt_works_ok)
+		for(;;) __asm__("hlt");
+	for (;;);
+}
+
 /* The following code and data reboots the machine by switching to real
    mode and jumping to the BIOS reset entry point, as if the CPU has
    really been reset.  The previous version asked the keyboard
@@ -213,45 +229,8 @@
 				: "i" ((void *) (0x1000 - sizeof (real_mode_switch) - 100)));
 }
 
-void machine_restart(char * __unused)
+static void machine_restart_1(void * __unused)
 {
-#if CONFIG_SMP
-	int cpuid;
-	
-	cpuid = GET_APIC_ID(apic_read(APIC_ID));
-
-	if (reboot_smp) {
-
-		/* check to see if reboot_cpu is valid 
-		   if its not, default to the BSP */
-		if ((reboot_cpu == -1) ||  
-		      (reboot_cpu > (NR_CPUS -1))  || 
-		      !(phys_cpu_present_map & (1<<cpuid))) 
-			reboot_cpu = boot_cpu_physical_apicid;
-
-		reboot_smp = 0;  /* use this as a flag to only go through this once*/
-		/* re-run this function on the other CPUs
-		   it will fall though this section since we have 
-		   cleared reboot_smp, and do the reboot if it is the
-		   correct CPU, otherwise it halts. */
-		if (reboot_cpu != cpuid)
-			smp_call_function((void *)machine_restart , NULL, 1, 0);
-	}
-
-	/* if reboot_cpu is still -1, then we want a tradional reboot, 
-	   and if we are not running on the reboot_cpu,, halt */
-	if ((reboot_cpu != -1) && (cpuid != reboot_cpu)) {
-		for (;;)
-		__asm__ __volatile__ ("hlt");
-	}
-	/*
-	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
-	 * other OSs see a clean IRQ state.
-	 */
-	smp_send_stop();
-	disable_IO_APIC();
-#endif
-
 	if(!reboot_thru_bios) {
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
@@ -265,14 +244,27 @@
 
 	machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
 }
+void machine_restart(char * __unused)
+{
+	stop_apics(machine_restart_1, 0);
+}
 
+static void machine_halt_1(void * __unused)
+{
+	stop_this_cpu();
+}
 void machine_halt(void)
 {
+	stop_apics(machine_halt_1, 0);
 }
 
-void machine_power_off(void)
+static void machine_power_off_1(void * __unused)
 {
 	if (pm_power_off)
 		pm_power_off();
+	stop_this_cpu();
+}
+void machine_power_off(void)
+{
+	stop_apics(machine_power_off_1, 0);
 }
-
diff -uNr linux-2.5.69/arch/i386/kernel/smp.c linux-2.5.69.reboot_on_bsp/arch/i386/kernel/smp.c
--- linux-2.5.69/arch/i386/kernel/smp.c	Sun May 11 09:08:43 2003
+++ linux-2.5.69.reboot_on_bsp/arch/i386/kernel/smp.c	Sun May 11 17:54:13 2003
@@ -539,32 +539,6 @@
 	return 0;
 }
 
-static void stop_this_cpu (void * dummy)
-{
-	/*
-	 * Remove this CPU:
-	 */
-	clear_bit(smp_processor_id(), &cpu_online_map);
-	local_irq_disable();
-	disable_local_APIC();
-	if (cpu_data[smp_processor_id()].hlt_works_ok)
-		for(;;) __asm__("hlt");
-	for (;;);
-}
-
-/*
- * this function calls the 'stop' function on all other CPUs in the system.
- */
-
-void smp_send_stop(void)
-{
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
-
-	local_irq_disable();
-	disable_local_APIC();
-	local_irq_enable();
-}
-
 /*
  * Reschedule call back. Nothing to do,
  * all the work is done automatically when
diff -uNr linux-2.5.69/include/asm-i386/apic.h linux-2.5.69.reboot_on_bsp/include/asm-i386/apic.h
--- linux-2.5.69/include/asm-i386/apic.h	Sun May 11 09:08:53 2003
+++ linux-2.5.69.reboot_on_bsp/include/asm-i386/apic.h	Sun May 11 17:11:16 2003
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/pm.h>
+#include <linux/linkage.h>
 #include <asm/fixmap.h>
 #include <asm/apicdef.h>
 #include <asm/system.h>
@@ -99,6 +100,18 @@
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
+extern NORET_TYPE void 
+stop_apics(NORET_TYPE void (*rest)(void *info) ATTRIB_NORET, void *info) 
+ATTRIB_NORET;
+#else
+static inline NORET_TYPE void 
+stop_apics(NORET_TYPE void (*rest)(void *info) ATTRIB_NORET, void *info)
+ATTRIB_NORET;
+static inline void 
+stop_apics(NORET_TYPE void (*rest)(void *info) ATTRIB_NORET, void *info)
+{
+	rest(info); 
+}
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #endif /* __ASM_APIC_H */
diff -uNr linux-2.5.69/include/asm-i386/mach-default/mach_reboot.h linux-2.5.69.reboot_on_bsp/include/asm-i386/mach-default/mach_reboot.h
--- linux-2.5.69/include/asm-i386/mach-default/mach_reboot.h	Sun May 11 09:08:36 2003
+++ linux-2.5.69.reboot_on_bsp/include/asm-i386/mach-default/mach_reboot.h	Sun May 11 17:12:02 2003
@@ -27,4 +27,6 @@
 	}
 }
 
+void stop_this_cpu(void);
+
 #endif /* !_MACH_REBOOT_H */
diff -uNr linux-2.5.69/include/linux/reboot.h linux-2.5.69.reboot_on_bsp/include/linux/reboot.h
--- linux-2.5.69/include/linux/reboot.h	Thu Dec 12 07:41:37 2002
+++ linux-2.5.69.reboot_on_bsp/include/linux/reboot.h	Sun May 11 17:12:29 2003
@@ -35,6 +35,7 @@
 #ifdef __KERNEL__
 
 #include <linux/notifier.h>
+#include <linux/linkage.h>
 
 extern int register_reboot_notifier(struct notifier_block *);
 extern int unregister_reboot_notifier(struct notifier_block *);
@@ -44,9 +45,9 @@
  * Architecture-specific implementations of sys_reboot commands.
  */
 
-extern void machine_restart(char *cmd);
-extern void machine_halt(void);
-extern void machine_power_off(void);
+NORET_TYPE void machine_restart(char *cmd) ATTRIB_NORET;
+NORET_TYPE void machine_halt(void) ATTRIB_NORET;
+NORET_TYPE void machine_power_off(void) ATTRIB_NORET;
 
 #endif
 
diff -uNr linux-2.5.69/kernel/panic.c linux-2.5.69.reboot_on_bsp/kernel/panic.c
--- linux-2.5.69/kernel/panic.c	Sun May 11 09:09:21 2003
+++ linux-2.5.69.reboot_on_bsp/kernel/panic.c	Sun May 11 17:13:01 2003
@@ -63,7 +63,7 @@
 		sys_sync();
 	bust_spinlocks(0);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(__i386__)
 	smp_send_stop();
 #endif
 
diff -uNr linux-2.5.69/kernel/sys.c linux-2.5.69.reboot_on_bsp/kernel/sys.c
--- linux-2.5.69/kernel/sys.c	Sun May 11 09:09:21 2003
+++ linux-2.5.69.reboot_on_bsp/kernel/sys.c	Sun May 11 17:13:24 2003
@@ -415,8 +415,6 @@
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
-		unlock_kernel();
-		do_exit(0);
 		break;
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
@@ -425,8 +423,6 @@
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
-		unlock_kernel();
-		do_exit(0);
 		break;
 
 	case LINUX_REBOOT_CMD_RESTART2:

