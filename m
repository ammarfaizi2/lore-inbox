Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTELAR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbTELAR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:17:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64079 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261561AbTELAR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:17:28 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: Andy Pfiffer <andyp@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Updated kexec diffs...
References: <3EBA626E.6040205@cyberone.com.au>
	<20030508121211.532dcbcf.akpm@digeo.com>
	<3EBC37C4.9090602@cyberone.com.au>
	<20030509162911.2cd5321e.akpm@digeo.com>
	<m1u1c37d2o.fsf@frodo.biederman.org>
	<20030509201327.734caf9e.akpm@digeo.com>
	<m1of2978ao.fsf@frodo.biederman.org>
	<20030511121753.7a883afb.akpm@digeo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 18:26:43 -0600
In-Reply-To: <20030511121753.7a883afb.akpm@digeo.com>
Message-ID: <m1fznl57ss.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


This is my next round of kexec inspired kernel patches.

kexec seems good at reproducing what are otherwise almost
inaccessible corner cases in the kernel reboot/initialization code paths.

Also available at:
http://www.xmission.com/~ebiederm/files/kexec/

reboot_on_bsp consolidates all of the places x86 attempts to reboot on
the bootstrap processor and fixes it so the code will also work when
called from interrupt context.

apic_shutdown returns the local apics to virtual wire mode.
   This may need some extending at some point but it seems to be enough.

i8259_shutdown disables all interrupts through the legacy pic.

hwfixes-x86kexec is kexec built on top of the previous patches.  It
should stand independent of apic_shtudown and i8259_shutdown, but
there is a dependency on reboot_on_bsp.

So far everything is just compile tested, and split apart for better
maintenance.  I am starting on real world tests shortly.

Eric


--=-=-=
Content-Disposition: attachment;
  filename=linux-2.5.69.reboot_on_bsp.diff

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

--=-=-=
Content-Disposition: attachment;
  filename=linux-2.5.69.apic_shutdown.diff

diff -uNr linux-2.5.69/arch/i386/kernel/apic.c linux-2.5.69.apic_shutdown/arch/i386/kernel/apic.c
--- linux-2.5.69/arch/i386/kernel/apic.c	Sun May 11 09:08:57 2003
+++ linux-2.5.69.apic_shutdown/arch/i386/kernel/apic.c	Sun May 11 17:22:19 2003
@@ -171,6 +171,36 @@
 		outb(0x70, 0x22);
 		outb(0x00, 0x23);
 	}
+	else {
+		/* Go back to Virtual Wire compatibility mode */
+		unsigned long value;
+
+		/* For the spurious interrupt use vector F, and enable it */
+		value = apic_read(APIC_SPIV);
+		value &= ~APIC_VECTOR_MASK; 
+		value |= APIC_SPIV_APIC_ENABLED;
+		value |= 0xf;
+		apic_write_around(APIC_SPIV, value);
+
+		/* For LVT0 make it edge triggered, active high, external and enabled */
+		value = apic_read(APIC_LVT0);
+		value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING | 
+			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR | 
+			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXINT);
+		apic_write_around(APIC_LVT0, value);
+		
+		/* For LVT1 make it edge triggered, active high, nmi and enabled */
+		value = apic_read(APIC_LVT1);
+		value &= ~(
+			APIC_MODE_MASK | APIC_SEND_PENDING | 
+			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR | 
+			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
+		apic_write_around(APIC_LVT1, value);
+	}
 }
 
 void disable_local_APIC(void)
diff -uNr linux-2.5.69/include/asm-i386/apicdef.h linux-2.5.69.apic_shutdown/include/asm-i386/apicdef.h
--- linux-2.5.69/include/asm-i386/apicdef.h	Mon Feb 17 18:57:47 2003
+++ linux-2.5.69.apic_shutdown/include/asm-i386/apicdef.h	Sun May 11 17:21:56 2003
@@ -93,6 +93,7 @@
 #define			APIC_LVT_REMOTE_IRR		(1<<14)
 #define			APIC_INPUT_POLARITY		(1<<13)
 #define			APIC_SEND_PENDING		(1<<12)
+#define			APIC_MODE_MASK			0x700
 #define			GET_APIC_DELIVERY_MODE(x)	(((x)>>8)&0x7)
 #define			SET_APIC_DELIVERY_MODE(x,y)	(((x)&~0x700)|((y)<<8))
 #define				APIC_MODE_FIXED		0x0

--=-=-=
Content-Disposition: attachment;
  filename=linux-2.5.69.i8259_shutdown.diff

diff -uNr linux-2.5.69/arch/i386/kernel/i8259.c linux-2.5.69.i8259_shutdown/arch/i386/kernel/i8259.c
--- linux-2.5.69/arch/i386/kernel/i8259.c	Sun May 11 09:09:25 2003
+++ linux-2.5.69.i8259_shutdown/arch/i386/kernel/i8259.c	Sun May 11 17:26:20 2003
@@ -245,10 +245,21 @@
 	return 0;
 }
 
+static void i8259A_shutdown(struct device *dev)
+{   
+	/* Put the i8259A into a quiescent state that
+	 * the kernel initialization code can get it
+	 * out of.
+	 */
+	outb(0xff, 0x21);	/* mask all of 8259A-1 */
+	outb(0xff, 0xA1);	/* mask all of 8259A-1 */
+}
+
 static struct device_driver i8259A_driver = {
 	.name		= "pic",
 	.bus		= &system_bus_type,
 	.resume		= i8259A_resume,
+	.shutdown	= i8259A_shutdown,
 };
 
 static struct sys_device device_i8259A = {

--=-=-=
Content-Disposition: attachment;
  filename=linux-2.5.69.hwfixes-x86kexec.diff

diff -uNr linux-2.5.69.hwfixes/MAINTAINERS linux-2.5.69.hwfixes-x86kexec/MAINTAINERS
--- linux-2.5.69.hwfixes/MAINTAINERS	Sun May 11 09:09:24 2003
+++ linux-2.5.69.hwfixes-x86kexec/MAINTAINERS	Sun May 11 17:33:45 2003
@@ -1062,6 +1062,14 @@
 W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
 S:	Maintained
 
+KEXEC
+P:	Eric Biederman
+M:	ebiederm@xmission.com
+M:	ebiederman@lnxi.com
+W:	http://www.xmission.com/~ebiederm/files/kexec/
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 LANMEDIA WAN CARD DRIVER
 P:	Andrew Stanley-Jones
 M:	asj@lanmedia.com
diff -uNr linux-2.5.69.hwfixes/arch/i386/Kconfig linux-2.5.69.hwfixes-x86kexec/arch/i386/Kconfig
--- linux-2.5.69.hwfixes/arch/i386/Kconfig	Sun May 11 09:09:25 2003
+++ linux-2.5.69.hwfixes-x86kexec/arch/i386/Kconfig	Sun May 11 17:33:45 2003
@@ -767,6 +767,23 @@
 	depends on (X86_SUMMIT && NUMA)
 	default y
 
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  kexec is a system call that implements the ability to  shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.   And like a reboot
+	  you can start any kernel with it not just Linux.  
+	
+	  The name comes from the similiarity to the exec system call. 
+	
+	  It is on an going process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+
 endmenu
 
 
diff -uNr linux-2.5.69.hwfixes/arch/i386/kernel/Makefile linux-2.5.69.hwfixes-x86kexec/arch/i386/kernel/Makefile
--- linux-2.5.69.hwfixes/arch/i386/kernel/Makefile	Sun May 11 09:09:25 2003
+++ linux-2.5.69.hwfixes-x86kexec/arch/i386/kernel/Makefile	Sun May 11 17:33:45 2003
@@ -23,6 +23,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_EDD)             	+= edd.o
diff -uNr linux-2.5.69.hwfixes/arch/i386/kernel/entry.S linux-2.5.69.hwfixes-x86kexec/arch/i386/kernel/entry.S
--- linux-2.5.69.hwfixes/arch/i386/kernel/entry.S	Sun May 11 09:09:25 2003
+++ linux-2.5.69.hwfixes-x86kexec/arch/i386/kernel/entry.S	Sun May 11 17:33:45 2003
@@ -852,6 +852,7 @@
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
+	.long sys_kexec_load
  
  
 nr_syscalls=(.-sys_call_table)/4
diff -uNr linux-2.5.69.hwfixes/arch/i386/kernel/machine_kexec.c linux-2.5.69.hwfixes-x86kexec/arch/i386/kernel/machine_kexec.c
--- linux-2.5.69.hwfixes/arch/i386/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.69.hwfixes-x86kexec/arch/i386/kernel/machine_kexec.c	Sun May 11 17:35:00 2003
@@ -0,0 +1,129 @@
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/kexec.h>
+#include <linux/delay.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
+#include <asm/io.h>
+#include <asm/apic.h>
+
+
+/*
+ * machine_kexec
+ * =======================
+ */
+
+
+static void set_idt(void *newidt, __u16 limit)
+{
+	unsigned char curidt[6];
+
+	/* ia32 supports unaliged loads & stores */
+	(*(__u16 *)(curidt)) = limit;
+	(*(__u32 *)(curidt +2)) = (unsigned long)(newidt);
+
+	__asm__ __volatile__ (
+		"lidt %0\n" 
+		: "=m" (curidt)
+		);
+};
+
+
+static void set_gdt(void *newgdt, __u16 limit)
+{
+	unsigned char curgdt[6];
+
+	/* ia32 supports unaliged loads & stores */
+	(*(__u16 *)(curgdt)) = limit;
+	(*(__u32 *)(curgdt +2)) = (unsigned long)(newgdt);
+
+	__asm__ __volatile__ (
+		"lgdt %0\n" 
+		: "=m" (curgdt)
+		);
+};
+
+static void load_segments(void)
+{
+#define __STR(X) #X
+#define STR(X) __STR(X)
+
+	__asm__ __volatile__ (
+		"\tljmp $"STR(__KERNEL_CS)",$1f\n"
+		"\t1:\n"
+		"\tmovl $"STR(__KERNEL_DS)",%eax\n"
+		"\tmovl %eax,%ds\n"
+		"\tmovl %eax,%es\n"
+		"\tmovl %eax,%fs\n"
+		"\tmovl %eax,%gs\n"
+		"\tmovl %eax,%ss\n"
+		);
+#undef STR
+#undef __STR
+}
+
+typedef void (*relocate_new_kernel_t)(
+	unsigned long indirection_page, unsigned long reboot_code_buffer,
+	unsigned long start_address);
+
+const extern unsigned char relocate_new_kernel[];
+extern void relocate_new_kernel_end(void);
+const extern unsigned int relocate_new_kernel_size;
+
+void machine_kexec_1(void *ptr)
+{
+	struct kimage *image = ptr;
+	unsigned long indirection_page;
+	unsigned long reboot_code_buffer;
+	relocate_new_kernel_t rnk;
+	struct mm_struct *active_mm, *mm;
+
+	/* switch to an mm where the reboot_code_buffer is identity mapped */
+	active_mm = current->active_mm;
+	mm = &init_mm;
+	atomic_inc(&mm->mm_count);
+	current->mm = mm;
+	if (mm != active_mm) {
+		current->active_mm = mm;
+		activate_mm(active_mm, mm);
+	}
+	mmdrop(active_mm);
+
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+	reboot_code_buffer = page_to_pfn(image->reboot_code_pages) << PAGE_SHIFT;
+	indirection_page = image->head & PAGE_MASK;
+
+	/* copy it out */
+	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
+
+	/* The segment registers are funny things, they are
+	 * automatically loaded from a table, in memory wherever you
+	 * set them to a specific selector, but this table is never
+	 * accessed again you set the segment to a different selector.
+	 *
+	 * The more common model is are caches where the behide
+	 * the scenes work is done, but is also dropped at arbitrary
+	 * times.
+	 *
+	 * I take advantage of this here by force loading the
+	 * segments, before I zap the gdt with an invalid value.
+	 */
+	load_segments();
+	/* The gdt & idt are now invalid.
+	 * If you want to load them you must set up your own idt & gdt.
+	 */
+	set_gdt(phys_to_virt(0),0);
+	set_idt(phys_to_virt(0),0);
+
+	/* now call it */
+	rnk = (relocate_new_kernel_t) reboot_code_buffer;
+	(*rnk)(indirection_page, reboot_code_buffer, image->start);
+}
+
+void machine_kexec(struct kimage *image)
+{
+	stop_apics(machine_kexec_1, image);
+}
diff -uNr linux-2.5.69.hwfixes/arch/i386/kernel/relocate_kernel.S linux-2.5.69.hwfixes-x86kexec/arch/i386/kernel/relocate_kernel.S
--- linux-2.5.69.hwfixes/arch/i386/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.5.69.hwfixes-x86kexec/arch/i386/kernel/relocate_kernel.S	Sun May 11 17:33:45 2003
@@ -0,0 +1,107 @@
+#include <linux/config.h>
+#include <linux/linkage.h>
+
+	/* Must be relocatable PIC code callable as a C function, that once
+	 * it starts can not use the previous processes stack.
+	 *
+	 */
+	.globl relocate_new_kernel
+relocate_new_kernel:
+	/* read the arguments and say goodbye to the stack */
+	movl  4(%esp), %ebx /* indirection_page */
+	movl  8(%esp), %ebp /* reboot_code_buffer */
+	movl  12(%esp), %edx /* start address */
+
+	/* zero out flags, and disable interrupts */
+	pushl $0
+	popfl
+
+	/* set a new stack at the bottom of our page... */
+	lea   4096(%ebp), %esp
+
+	/* store the parameters back on the stack */
+	pushl   %edx /* store the start address */
+
+	/* Set cr0 to a known state:
+	 * 31 0 == Paging disabled
+	 * 18 0 == Alignment check disabled
+	 * 16 0 == Write protect disabled
+	 * 3  0 == No task switch
+	 * 2  0 == Don't do FP software emulation.
+	 * 0  1 == Proctected mode enabled
+	 */
+	movl	%cr0, %eax
+	andl	$~((1<<31)|(1<<18)|(1<<16)|(1<<3)|(1<<2)), %eax
+	orl	$(1<<0), %eax
+	movl	%eax, %cr0
+	
+	/* Set cr4 to a known state:
+	 * Setting everything to zero seems safe.
+	 */
+	movl	%cr4, %eax
+	andl	$0, %eax
+	movl	%eax, %cr4
+	
+	jmp 1f
+1:	
+
+	/* Flush the TLB (needed?) */
+	xorl	%eax, %eax
+	movl	%eax, %cr3
+
+	/* Do the copies */
+	cld
+0:	/* top, read another word for the indirection page */
+	movl    %ebx, %ecx
+	movl	(%ebx), %ecx
+	addl	$4, %ebx
+	testl	$0x1,   %ecx  /* is it a destination page */
+	jz	1f
+	movl	%ecx,	%edi
+	andl	$0xfffff000, %edi
+	jmp     0b
+1:
+	testl	$0x2,	%ecx  /* is it an indirection page */
+	jz	1f
+	movl	%ecx,	%ebx
+	andl	$0xfffff000, %ebx
+	jmp     0b
+1:
+	testl   $0x4,   %ecx /* is it the done indicator */
+	jz      1f
+	jmp     2f
+1:
+	testl   $0x8,   %ecx /* is it the source indicator */
+	jz      0b	     /* Ignore it otherwise */
+	movl    %ecx,   %esi /* For every source page do a copy */
+	andl    $0xfffff000, %esi
+
+	movl    $1024, %ecx
+	rep ; movsl
+	jmp     0b
+
+2:
+
+	/* To be certain of avoiding problems with self modifying code
+	 * I need to execute a serializing instruction here.
+	 * So I flush the TLB, it's handy, and not processor dependent.
+	 */
+	xorl	%eax, %eax
+	movl	%eax, %cr3
+	
+	/* set all of the registers to known values */
+	/* leave %esp alone */
+	
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl    %ecx, %ecx
+	xorl    %edx, %edx
+	xorl    %esi, %esi
+	xorl    %edi, %edi
+	xorl    %ebp, %ebp
+	ret
+relocate_new_kernel_end:
+
+	.globl relocate_new_kernel_size
+relocate_new_kernel_size:	
+	.long relocate_new_kernel_end - relocate_new_kernel
diff -uNr linux-2.5.69.hwfixes/include/asm-i386/kexec.h linux-2.5.69.hwfixes-x86kexec/include/asm-i386/kexec.h
--- linux-2.5.69.hwfixes/include/asm-i386/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.69.hwfixes-x86kexec/include/asm-i386/kexec.h	Sun May 11 17:33:45 2003
@@ -0,0 +1,23 @@
+#ifndef _I386_KEXEC_H
+#define _I386_KEXEC_H
+
+#include <asm/fixmap.h>
+
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ *
+ * Someone correct me if FIXADDR_START - PAGEOFFSET is not the correct
+ * calculation for the amount of memory directly mappable into the
+ * kernel memory space.
+ */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+#define KEXEC_REBOOT_CODE_SIZE	4096
+
+#endif /* _I386_KEXEC_H */
diff -uNr linux-2.5.69.hwfixes/include/asm-i386/unistd.h linux-2.5.69.hwfixes-x86kexec/include/asm-i386/unistd.h
--- linux-2.5.69.hwfixes/include/asm-i386/unistd.h	Sun May 11 09:07:36 2003
+++ linux-2.5.69.hwfixes-x86kexec/include/asm-i386/unistd.h	Sun May 11 17:33:45 2003
@@ -273,8 +273,9 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_sys_kexec_load	268
 
-#define NR_syscalls 268
+#define NR_syscalls 269
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -uNr linux-2.5.69.hwfixes/include/linux/kexec.h linux-2.5.69.hwfixes-x86kexec/include/linux/kexec.h
--- linux-2.5.69.hwfixes/include/linux/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.69.hwfixes-x86kexec/include/linux/kexec.h	Sun May 11 17:33:45 2003
@@ -0,0 +1,54 @@
+#ifndef LINUX_KEXEC_H
+#define LINUX_KEXEC_H
+
+#if CONFIG_KEXEC
+#include <linux/types.h>
+#include <linux/list.h>
+#include <asm/kexec.h>
+
+/* 
+ * This structure is used to hold the arguments that are used when loading
+ * kernel binaries.
+ */
+
+typedef unsigned long kimage_entry_t;
+#define IND_DESTINATION  0x1
+#define IND_INDIRECTION  0x2
+#define IND_DONE         0x4
+#define IND_SOURCE       0x8
+
+#define KEXEC_SEGMENT_MAX 8
+struct kexec_segment {
+	void *buf;
+	size_t bufsz;
+	void *mem;
+	size_t memsz;
+};
+
+struct kimage {
+	kimage_entry_t head;
+	kimage_entry_t *entry;
+	kimage_entry_t *last_entry;
+
+	unsigned long destination;
+	unsigned long offset;
+
+	unsigned long start;
+	struct page *reboot_code_pages;
+
+	unsigned long nr_segments;
+	struct kexec_segment segment[KEXEC_SEGMENT_MAX+1];
+
+	struct list_head dest_pages;
+	struct list_head unuseable_pages;
+};
+
+
+/* kexec interface functions */
+extern void machine_kexec(struct kimage *image);
+extern asmlinkage long sys_kexec(unsigned long entry, long nr_segments, 
+	struct kexec_segment *segments);
+extern struct kimage *kexec_image;
+#endif
+#endif /* LINUX_KEXEC_H */
+
diff -uNr linux-2.5.69.hwfixes/include/linux/reboot.h linux-2.5.69.hwfixes-x86kexec/include/linux/reboot.h
--- linux-2.5.69.hwfixes/include/linux/reboot.h	Sun May 11 17:31:15 2003
+++ linux-2.5.69.hwfixes-x86kexec/include/linux/reboot.h	Sun May 11 17:33:45 2003
@@ -21,6 +21,7 @@
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
  * SW_SUSPEND  Suspend system using Software Suspend if compiled in
+ * KEXEC       Restart the system using a different kernel.
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
@@ -30,6 +31,7 @@
 #define	LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
 #define	LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
 #define	LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2
+#define LINUX_REBOOT_CMD_KEXEC		0x45584543
 
 
 #ifdef __KERNEL__
diff -uNr linux-2.5.69.hwfixes/kernel/Makefile linux-2.5.69.hwfixes-x86kexec/kernel/Makefile
--- linux-2.5.69.hwfixes/kernel/Makefile	Sun May 11 09:07:37 2003
+++ linux-2.5.69.hwfixes-x86kexec/kernel/Makefile	Sun May 11 17:33:45 2003
@@ -17,6 +17,7 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 
 ifneq ($(CONFIG_IA64),y)
diff -uNr linux-2.5.69.hwfixes/kernel/kexec.c linux-2.5.69.hwfixes-x86kexec/kernel/kexec.c
--- linux-2.5.69.hwfixes/kernel/kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.69.hwfixes-x86kexec/kernel/kexec.c	Sun May 11 17:35:38 2003
@@ -0,0 +1,629 @@
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/version.h>
+#include <linux/compile.h>
+#include <linux/kexec.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/highmem.h>
+#include <net/checksum.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/system.h>
+
+/* When kexec transitions to the new kernel there is a one to one
+ * mapping between physical and virtual addresses.  On processors
+ * where you can disable the MMU this is trivial, and easy.  For
+ * others it is still a simple predictable page table to setup.
+ *
+ * In that environment kexec copies the new kernel to it's final
+ * resting place.  This means I can only support memory whose
+ * physical address can fit in an unsigned long.  In particular
+ * addresses where (pfn << PAGE_SHIFT) > ULONG_MAX cannot be handled.
+ * If the assembly stub has more restrictive requirements
+ * KEXEC_SOURCE_MEMORY_LIMIT and KEXEC_DEST_MEMORY_LIMIT can be
+ * defined more restrictively in <asm/kexec.h>.
+ *
+ * The code for the transition from the current kernel to the 
+ * the new kernel is placed in the reboot_code_buffer, whose size
+ * is given by KEXEC_REBOOT_CODE_SIZE.  In the best case only a single
+ * page of memory is necessary, but some architectures require more.
+ * Because this memory must be identity mapped in the transition from
+ * virtual to physical addresses it must live in the range
+ * 0 - TASK_SIZE, as only the user space mappings are arbitrarily
+ * modifyable.
+ *
+ * The assembly stub in the reboot code buffer is passed a linked list
+ * of descriptor pages detailing the source pages of the new kernel,
+ * and the destination addresses of those source pages.  As this data
+ * structure is not used in the context of the current OS, it must
+ * be self contained.
+ *
+ * The code has been made to work with highmem pages and will use a
+ * destination page in it's final resting place (if it happens 
+ * to allocate it).  The end product of this is that most of the
+ * physical address space, and most of ram can be used.
+ *
+ * Future directions include:
+ *  - allocating a page table with the reboot code buffer identity
+ *    mapped, to simplify machine_kexec and make kexec_on_panic, more
+ *    reliable.  
+ *  - allocating the pages for a page table for machines that cannot
+ *    disable their MMUs.  (Hammer, Alpha...)
+ */
+
+/* KIMAGE_NO_DEST is an impossible destination address..., for
+ * allocating pages whose destination address we do not care about.
+ */
+#define KIMAGE_NO_DEST (-1UL)
+
+static int kimage_is_destination_range(
+	struct kimage *image, unsigned long start, unsigned long end);
+static struct page *kimage_alloc_reboot_code_pages(struct kimage *image);
+static struct page *kimage_alloc_page(struct kimage *image, unsigned int gfp_mask, unsigned long dest);
+
+
+static int kimage_alloc(struct kimage **rimage, 
+	unsigned long nr_segments, struct kexec_segment *segments)
+{
+	int result;
+	struct kimage *image;
+	size_t segment_bytes;
+	struct page *reboot_pages;
+	unsigned long i;
+
+	/* Allocate a controlling structure */
+	result = -ENOMEM;
+	image = kmalloc(sizeof(*image), GFP_KERNEL);
+	if (!image) {
+		goto out;
+	}
+	memset(image, 0, sizeof(*image));
+	image->head = 0;
+	image->entry = &image->head;
+	image->last_entry = &image->head;
+
+	/* Initialize the list of destination pages */
+	INIT_LIST_HEAD(&image->dest_pages);
+
+	/* Initialize the list of unuseable pages */
+	INIT_LIST_HEAD(&image->unuseable_pages);
+
+	/* Read in the segments */
+	image->nr_segments = nr_segments;
+	segment_bytes = nr_segments * sizeof*segments;
+	result = copy_from_user(image->segment, segments, segment_bytes);
+	if (result) 
+		goto out;
+
+	/* Verify we have good destination addresses.  The caller is
+	 * responsible for making certain we don't attempt to load
+	 * the new image into invalid or reserved areas of RAM.  This
+	 * just verifies it is an address we can use. 
+	 */
+	result = -EADDRNOTAVAIL;
+	for(i = 0; i < nr_segments; i++) {
+		unsigned long mend;
+		mend = ((unsigned long)(image->segment[i].mem)) + 
+			image->segment[i].memsz;
+		if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
+			goto out;
+	}
+
+	/* Find a location for the reboot code buffer, and add it
+	 * the vector of segments so that it's pages will also be
+	 * counted as destination pages.  
+	 */
+	result = -ENOMEM;
+	reboot_pages = kimage_alloc_reboot_code_pages(image);
+	if (!reboot_pages) {
+		printk(KERN_ERR "Could not allocate reboot_code_buffer\n");
+		goto out;
+	}
+	image->reboot_code_pages = reboot_pages;
+	image->segment[nr_segments].buf = 0;
+	image->segment[nr_segments].bufsz = 0;
+	image->segment[nr_segments].mem = (void *)(page_to_pfn(reboot_pages) << PAGE_SHIFT);
+	image->segment[nr_segments].memsz = KEXEC_REBOOT_CODE_SIZE;
+	image->nr_segments++;
+
+	result = 0;
+ out:
+	if (result == 0) {
+		*rimage = image;
+	} else {
+		kfree(image);
+	}
+	return result;
+}
+
+static int kimage_is_destination_range(
+	struct kimage *image, unsigned long start, unsigned long end)
+{
+	unsigned long i;
+	for(i = 0; i < image->nr_segments; i++) {
+		unsigned long mstart, mend;
+		mstart = (unsigned long)image->segment[i].mem;
+		mend   = mstart + image->segment[i].memsz;
+		if ((end > mstart) && (start < mend)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_MMU
+static int identity_map_pages(struct page *pages, int order)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	int error;
+	mm = &init_mm;
+	vma = 0;
+
+	down_write(&mm->mmap_sem);
+	error = -ENOMEM;
+	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	if (!vma) {
+		goto out;
+	}
+
+	memset(vma, 0, sizeof(vma));
+	vma->vm_mm = mm;
+	vma->vm_start = page_to_pfn(pages) << PAGE_SHIFT;
+	vma->vm_end = vma->vm_start + (1 << (order + PAGE_SHIFT));
+	vma->vm_ops = 0;
+	vma->vm_flags = VM_SHARED \
+		| VM_READ | VM_WRITE | VM_EXEC \
+		| VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC \
+		| VM_DONTCOPY | VM_RESERVED;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 0xf];
+	vma->vm_file = NULL;
+	vma->vm_private_data = NULL;
+	INIT_LIST_HEAD(&vma->shared);
+	insert_vm_struct(mm, vma);
+	
+	error = remap_page_range(vma, vma->vm_start, vma->vm_start,
+		vma->vm_end - vma->vm_start, vma->vm_page_prot);
+	if (error) {
+		goto out;
+	}
+
+	error = 0;
+ out:
+	if (error && vma) {
+		kmem_cache_free(vm_area_cachep, vma);
+		vma = 0;
+	}
+	up_write(&mm->mmap_sem);
+
+	return error;
+}
+#else
+#define identity_map_pages(pages, order) 0
+#endif
+
+struct page *kimage_alloc_reboot_code_pages(struct kimage *image)
+{
+	/* The reboot code buffer is special.  It is the only set of
+	 * pages that must be allocated in their final resting place,
+	 * and the only set of pages whose final resting place we can
+	 * pick. 
+	 *
+	 * At worst this runs in O(N) of the image size.
+	 */
+	struct list_head extra_pages, *pos, *next;
+	struct page *pages;
+	unsigned long addr;
+	int order, count;
+	order = get_order(KEXEC_REBOOT_CODE_SIZE);
+	count = 1 << order;
+	INIT_LIST_HEAD(&extra_pages);
+	do {
+		int i;
+		pages = alloc_pages(GFP_HIGHUSER, order);
+		if (!pages)
+			break;
+		for(i = 0; i < count; i++) {
+			SetPageReserved(pages +i);
+		}
+		addr = page_to_pfn(pages) << PAGE_SHIFT;
+		if ((page_to_pfn(pages) >= (TASK_SIZE >> PAGE_SHIFT)) ||
+			kimage_is_destination_range(image, addr, addr + KEXEC_REBOOT_CODE_SIZE)) {
+			list_add(&pages->list, &extra_pages);
+			pages = 0;
+		}
+	} while(!pages);
+	if (pages) {
+		int result;
+		result = identity_map_pages(pages, order);
+		if (result < 0) {
+			list_add(&pages->list, &extra_pages);
+			pages = 0;
+		}
+	}
+	/* If I could convert a multi page allocation into a buch of
+	 * single page allocations I could add these pages to
+	 * image->dest_pages.  For now it is simpler to just free the
+	 * pages again.
+	 */
+	list_for_each_safe(pos, next, &extra_pages) {
+		struct page *page;
+		int i;
+		page = list_entry(pos, struct page, list);
+		for(i = 0; i < count; i++) {
+			ClearPageReserved(pages +i);
+		}
+		list_del(&extra_pages);
+		__free_pages(page, order);
+	}
+	return pages;
+}
+
+static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
+{
+	if (image->offset != 0) {
+		image->entry++;
+	}
+	if (image->entry == image->last_entry) {
+		kimage_entry_t *ind_page;
+		struct page *page;
+		page = kimage_alloc_page(image, GFP_KERNEL, KIMAGE_NO_DEST);
+		if (!page) {
+			return -ENOMEM;
+		}
+		ind_page = page_address(page);
+		*image->entry = virt_to_phys(ind_page) | IND_INDIRECTION;
+		image->entry = ind_page;
+		image->last_entry = 
+			ind_page + ((PAGE_SIZE/sizeof(kimage_entry_t)) - 1);
+	}
+	*image->entry = entry;
+	image->entry++;
+	image->offset = 0;
+	return 0;
+}
+
+static int kimage_set_destination(
+	struct kimage *image, unsigned long destination) 
+{
+	int result;
+	destination &= PAGE_MASK;
+	result = kimage_add_entry(image, destination | IND_DESTINATION);
+	if (result == 0) {
+		image->destination = destination;
+	}
+	return result;
+}
+
+
+static int kimage_add_page(struct kimage *image, unsigned long page)
+{
+	int result;
+	page &= PAGE_MASK;
+	result = kimage_add_entry(image, page | IND_SOURCE);
+	if (result == 0) {
+		image->destination += PAGE_SIZE;
+	}
+	return result;
+}
+
+
+static void kimage_free_extra_pages(struct kimage *image)
+{
+	/* Walk through and free any extra destination pages I may have */
+	struct list_head *pos, *next;
+	list_for_each_safe(pos, next, &image->dest_pages) {
+		struct page *page;
+		page = list_entry(pos, struct page, list);
+		list_del(&page->list);
+		ClearPageReserved(page);
+		__free_page(page);
+	}
+	/* Walk through and free any unuseable pages I have cached */
+	list_for_each_safe(pos, next, &image->unuseable_pages) {
+		struct page *page;
+		page = list_entry(pos, struct page, list);
+		list_del(&page->list);
+		ClearPageReserved(page);
+		__free_page(page);
+	}
+
+}
+static int kimage_terminate(struct kimage *image)
+{
+	int result;
+	result = kimage_add_entry(image, IND_DONE);
+	if (result == 0) {
+		/* Point at the terminating element */
+		image->entry--;
+		kimage_free_extra_pages(image);
+	}
+	return result;
+}
+
+#define for_each_kimage_entry(image, ptr, entry) \
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
+		ptr = (entry & IND_INDIRECTION)? \
+			phys_to_virt((entry & PAGE_MASK)): ptr +1)
+
+static void kimage_free(struct kimage *image)
+{
+	kimage_entry_t *ptr, entry;
+	kimage_entry_t ind = 0;
+	int i, count, order;
+	if (!image)
+		return;
+	kimage_free_extra_pages(image);
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_INDIRECTION) {
+			/* Free the previous indirection page */
+			if (ind & IND_INDIRECTION) {
+				free_page((unsigned long)phys_to_virt(ind & PAGE_MASK));
+			}
+			/* Save this indirection page until we are
+			 * done with it.
+			 */
+			ind = entry;
+		}
+		else if (entry & IND_SOURCE) {
+			free_page((unsigned long)phys_to_virt(entry & PAGE_MASK));
+		}
+	}
+	order = get_order(KEXEC_REBOOT_CODE_SIZE);
+	count = 1 << order;
+	do_munmap(&init_mm, 
+		page_to_pfn(image->reboot_code_pages) << PAGE_SHIFT, 
+		count << PAGE_SHIFT);
+	for(i = 0; i < count; i++) {
+		ClearPageReserved(image->reboot_code_pages + i);
+	}
+	__free_pages(image->reboot_code_pages, order);
+	kfree(image);
+}
+
+static kimage_entry_t *kimage_dst_used(struct kimage *image, unsigned long page)
+{
+	kimage_entry_t *ptr, entry;
+	unsigned long destination = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION) {
+			destination = entry & PAGE_MASK;
+		}
+		else if (entry & IND_SOURCE) {
+			if (page == destination) {
+				return ptr;
+			}
+			destination += PAGE_SIZE;
+		}
+	}
+	return 0;
+}
+
+static struct page *kimage_alloc_page(struct kimage *image, unsigned int gfp_mask, unsigned long destination)
+{
+	/* Here we implment safe guards to ensure that a source page
+	 * is not copied to it's destination page before the data on
+	 * the destination page is no longer useful.
+	 *
+	 * To do this we maintain the invariant that a source page is
+	 * either it's own destination page, or it is not a
+	 * destination page at all.  
+	 *
+	 * That is slightly stronger than required, but the proof
+	 * that no problems will not occur is trivial, and the
+	 * implemenation is simply to verify.
+	 *
+	 * When allocating all pages normally this algorithm will run
+	 * in O(N) time, but in the worst case it will run in O(N^2)
+	 * time.   If the runtime is a problem the data structures can
+	 * be fixed.
+	 */
+	struct page *page;
+	unsigned long addr;
+
+	/* Walk through the list of destination pages, and see if I
+	 * have a match.
+	 */
+	list_for_each_entry(page, &image->dest_pages, list) {
+		addr = page_to_pfn(page) << PAGE_SHIFT;
+		if (addr == destination) {
+			list_del(&page->list);
+			return page;
+		}
+	}
+	page = 0;
+	while(1) {
+		kimage_entry_t *old;
+		/* Allocate a page, if we run out of memory give up */
+		page = alloc_page(gfp_mask);
+		if (!page) {
+			return 0;
+		}
+		SetPageReserved(page);
+		/* If the page cannot be used file it away */
+		if (page_to_pfn(page) > (KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
+			list_add(&page->list, &image->unuseable_pages);
+			continue;
+		}
+		addr = page_to_pfn(page) << PAGE_SHIFT;
+
+		/* If it is the destination page we want use it */
+		if (addr == destination)
+			break;
+
+		/* If the page is not a destination page use it */
+		if (!kimage_is_destination_range(image, addr, addr + PAGE_SIZE))
+			break;
+
+		/* I know that the page is someones destination page.
+		 * See if there is already a source page for this
+		 * destination page.  And if so swap the source pages.
+		 */
+		old = kimage_dst_used(image, addr);
+		if (old) {
+			/* If so move it */
+			unsigned long old_addr;
+			struct page *old_page;
+			
+			old_addr = *old & PAGE_MASK;
+			old_page = pfn_to_page(old_addr >> PAGE_SHIFT);
+			copy_highpage(page, old_page);
+			*old = addr | (*old & ~PAGE_MASK);
+
+			/* The old page I have found cannot be a
+			 * destination page, so return it.
+			 */
+			addr = old_addr;
+			page = old_page;
+			break;
+		}
+		else {
+			/* Place the page on the destination list I
+			 * will use it later.
+			 */
+			list_add(&page->list, &image->dest_pages);
+		}
+	}
+	return page;
+}
+
+static int kimage_load_segment(struct kimage *image,
+	struct kexec_segment *segment)
+{	
+	unsigned long mstart;
+	int result;
+	unsigned long offset;
+	unsigned long offset_end;
+	unsigned char *buf;
+
+	result = 0;
+	buf = segment->buf;
+	mstart = (unsigned long)segment->mem;
+
+	offset_end = segment->memsz;
+
+	result = kimage_set_destination(image, mstart);
+	if (result < 0) {
+		goto out;
+	}
+	for(offset = 0;  offset < segment->memsz; offset += PAGE_SIZE) {
+		struct page *page;
+		char *ptr;
+		size_t size, leader;
+		page = kimage_alloc_page(image, GFP_HIGHUSER, mstart + offset);
+		if (page == 0) {
+			result  = -ENOMEM;
+			goto out;
+		}
+		result = kimage_add_page(image, page_to_pfn(page) << PAGE_SHIFT);
+		if (result < 0) {
+			goto out;
+		}
+		ptr = kmap(page);
+		if (segment->bufsz < offset) {
+			/* We are past the end zero the whole page */
+			memset(ptr, 0, PAGE_SIZE);
+			kunmap(page);
+			continue;
+		}
+		size = PAGE_SIZE;
+		leader = 0;
+		if ((offset == 0)) {
+			leader = mstart & ~PAGE_MASK;
+		}
+		if (leader) {
+			/* We are on the first page zero the unused portion */
+			memset(ptr, 0, leader);
+			size -= leader;
+			ptr += leader;
+		}
+		if (size > (segment->bufsz - offset)) {
+			size = segment->bufsz - offset;
+		}
+		if (size < (PAGE_SIZE - leader)) {
+			/* zero the trailing part of the page */
+			memset(ptr + size, 0, (PAGE_SIZE - leader) - size);
+		}
+		result = copy_from_user(ptr, buf + offset, size);
+		kunmap(page);
+		if (result) {
+			result = (result < 0)?result : -EIO;
+			goto out;
+		}
+	}
+ out:
+	return result;
+}
+
+/*
+ * Exec Kernel system call: for obvious reasons only root may call it.
+ * 
+ * This call breaks up into three pieces.  
+ * - A generic part which loads the new kernel from the current
+ *   address space, and very carefully places the data in the
+ *   allocated pages.
+ *
+ * - A generic part that interacts with the kernel and tells all of
+ *   the devices to shut down.  Preventing on-going dmas, and placing
+ *   the devices in a consistent state so a later kernel can
+ *   reinitialize them.
+ *
+ * - A machine specific part that includes the syscall number
+ *   and the copies the image to it's final destination.  And
+ *   jumps into the image at entry.
+ *
+ * kexec does not sync, or unmount filesystems so if you need
+ * that to happen you need to do that yourself.
+ */
+struct kimage *kexec_image = 0;
+
+asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments, 
+	struct kexec_segment *segments, unsigned long flags)
+{
+	struct kimage *image;
+	int result;
+		
+	/* We only trust the superuser with rebooting the system. */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* In case we need just a little bit of special behavior for
+	 * reboot on panic 
+	 */
+	if (flags != 0)
+		return -EINVAL;
+
+	if (nr_segments > KEXEC_SEGMENT_MAX)
+		return -EINVAL;
+	image = 0;
+
+	result = 0;
+	if (nr_segments > 0) {
+		unsigned long i;
+		result = kimage_alloc(&image, nr_segments, segments);
+		if (result) {
+			goto out;
+		}
+		image->start = entry;
+		for(i = 0; i < nr_segments; i++) {
+			result = kimage_load_segment(image, &segments[i]);
+			if (result) {
+				goto out;
+			}
+		}
+		result = kimage_terminate(image);
+		if (result) {
+			goto out;
+		}
+	}
+
+	image = xchg(&kexec_image, image);
+
+ out:
+	kimage_free(image);
+	return result;
+}
diff -uNr linux-2.5.69.hwfixes/kernel/sys.c linux-2.5.69.hwfixes-x86kexec/kernel/sys.c
--- linux-2.5.69.hwfixes/kernel/sys.c	Sun May 11 17:31:15 2003
+++ linux-2.5.69.hwfixes-x86kexec/kernel/sys.c	Sun May 11 17:33:45 2003
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
+#include <linux/kexec.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
@@ -207,6 +208,7 @@
 cond_syscall(sys_lookup_dcookie)
 cond_syscall(sys_swapon)
 cond_syscall(sys_swapoff)
+cond_syscall(sys_kexec_load)
 cond_syscall(sys_init_module)
 cond_syscall(sys_delete_module)
 cond_syscall(sys_socketpair)
@@ -439,6 +441,27 @@
 		machine_restart(buffer);
 		break;
 
+#ifdef CONFIG_KEXEC
+	case LINUX_REBOOT_CMD_KEXEC:
+	{
+		struct kimage *image;
+		if (arg) {
+			unlock_kernel();
+			return -EINVAL;
+		}
+		image = xchg(&kexec_image, 0);
+		if (!image) {
+			unlock_kernel();
+			return -EINVAL;
+		}
+		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
+		system_running = 0;
+		device_shutdown();
+		printk(KERN_EMERG "Starting new kernel\n");
+		machine_kexec(image);
+		break;
+	}
+#endif
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		if (!software_suspend_enabled) {

--=-=-=--
