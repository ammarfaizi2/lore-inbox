Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVASIGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVASIGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVASIGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:06:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54463 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261639AbVASHdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:45 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 15/29] x86-machine_shutdown
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out the apic and smp shutdown code from machine_restart so it can be
called by in the kexec reboot path as well.

By switching to the bootstrap cpu by default on reboot I can delete/simplify
some motherboard fixups well.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 reboot.c |   82 +++++++++++++++++++--------------------------------------------
 1 files changed, 26 insertions(+), 56 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-kexec-kexec-generic/arch/i386/kernel/reboot.c linux-2.6.11-rc1-mm1-nokexec-x86-machine_shutdown/arch/i386/kernel/reboot.c
--- linux-2.6.11-rc1-mm1-nokexec-kexec-kexec-generic/arch/i386/kernel/reboot.c	Fri Jan  7 12:53:43 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-machine_shutdown/arch/i386/kernel/reboot.c	Tue Jan 18 22:58:00 2005
@@ -23,7 +23,6 @@
 int reboot_thru_bios;
 
 #ifdef CONFIG_SMP
-int reboot_smp = 0;
 static int reboot_cpu = -1;
 /* shamelessly grabbed from lib/vsprintf.c for readability */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
@@ -46,7 +45,6 @@
 			break;
 #ifdef CONFIG_SMP
 		case 's': /* "smp" reboot by executing reset on BSP or other CPU*/
-			reboot_smp = 1;
 			if (is_digit(*(str+1))) {
 				reboot_cpu = (int) (*(str+1) - '0');
 				if (is_digit(*(str+2))) 
@@ -85,33 +83,9 @@
 	return 0;
 }
 
-/*
- * Some machines require the "reboot=s"  commandline option, this quirk makes that automatic.
- */
-static int __init set_smp_reboot(struct dmi_system_id *d)
-{
-#ifdef CONFIG_SMP
-	if (!reboot_smp) {
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
-static int __init set_smp_bios_reboot(struct dmi_system_id *d)
-{
-	set_smp_reboot(d);
-	set_bios_reboot(d);
-	return 0;
-}
-
 static struct dmi_system_id __initdata reboot_dmi_table[] = {
 	{	/* Handle problems with rebooting on Dell 1300's */
-		.callback = set_smp_bios_reboot,
+		.callback = set_bios_reboot,
 		.ident = "Dell PowerEdge 1300",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
@@ -295,41 +269,32 @@
 				: "i" ((void *) (0x1000 - sizeof (real_mode_switch) - 100)));
 }
 
-void machine_restart(char * __unused)
+void machine_shutdown(void)
 {
 #ifdef CONFIG_SMP
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
-		      !physid_isset(cpuid, phys_cpu_present_map))
-			reboot_cpu = boot_cpu_physical_apicid;
-
-		reboot_smp = 0;  /* use this as a flag to only go through this once*/
-		/* re-run this function on the other CPUs
-		   it will fall though this section since we have 
-		   cleared reboot_smp, and do the reboot if it is the
-		   correct CPU, otherwise it halts. */
-		if (reboot_cpu != cpuid)
-			smp_call_function((void *)machine_restart , NULL, 1, 0);
+	int reboot_cpu_id;
+
+	/* The boot cpu is always logical cpu 0 */
+	reboot_cpu_id = 0;
+
+	/* See if there has been given a command line override */
+	if ((reboot_cpu_id != -1) && (reboot_cpu < NR_CPUS) &&
+		cpu_isset(reboot_cpu, cpu_online_map)) {
+		reboot_cpu_id = reboot_cpu;
 	}
 
-	/* if reboot_cpu is still -1, then we want a tradional reboot, 
-	   and if we are not running on the reboot_cpu,, halt */
-	if ((reboot_cpu != -1) && (cpuid != reboot_cpu)) {
-		for (;;)
-		__asm__ __volatile__ ("hlt");
+	/* Make certain the cpu I'm rebooting on is online */
+	if (!cpu_isset(reboot_cpu_id, cpu_online_map)) {
+		reboot_cpu_id = smp_processor_id();
 	}
-	/*
-	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
-	 * other OSs see a clean IRQ state.
+
+	/* Make certain I only run on the appropriate processor */
+	set_cpus_allowed(current, cpumask_of_cpu(reboot_cpu_id));
+
+	/* O.K. Now that I'm on the appropriate processor, stop
+	 * all of the others, and disable their local APICs.
 	 */
+
 	smp_send_stop();
 #endif /* CONFIG_SMP */
 
@@ -338,6 +303,11 @@
 #ifdef CONFIG_X86_IO_APIC
 	disable_IO_APIC();
 #endif
+}
+
+void machine_restart(char * __unused)
+{
+	machine_shutdown();
 
 	if (!reboot_thru_bios) {
 		if (efi_enabled) {
