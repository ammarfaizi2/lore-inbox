Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUHTS1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUHTS1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268541AbUHTSZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:25:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:930 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268595AbUHTSTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:19:18 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/14]: kexec: machine_shutdown.i386
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:18:03 -0600
Message-ID: <m1wtzt4qsk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out the apic and smp shutdown code from machine_restart
so it can be called by in the kexec reboot path as well.

By switching to the bootstrap cpu by default on reboot I can
delete/simplify some motherboard fixups well.

diff -uNr linux-2.6.8.1-mm2-kexec.x86_64/arch/i386/kernel/reboot.c linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/reboot.c
--- linux-2.6.8.1-mm2-kexec.x86_64/arch/i386/kernel/reboot.c	Sat Aug 14 11:54:53 2004
+++ linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/reboot.c	Fri Aug 20 11:12:18 2004
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
+	int reboot_cpu_id;
 
-	if (reboot_smp) {
+	/* The boot cpu is always logical cpu 0 */
+	reboot_cpu_id = 0;
 
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
+	/* See if there has been given a command line override */
+	if ((reboot_cpu_id != -1) && (reboot_cpu < NR_CPUS) &&
+		cpu_isset(reboot_cpu, cpu_online_map)) {
+		reboot_cpu_id = reboot_cpu;
 	}
-
-	/* if reboot_cpu is still -1, then we want a tradional reboot, 
-	   and if we are not running on the reboot_cpu,, halt */
-	if ((reboot_cpu != -1) && (cpuid != reboot_cpu)) {
-		for (;;)
-		__asm__ __volatile__ ("hlt");
+	
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
 #elif defined(CONFIG_X86_LOCAL_APIC)
 	if (cpu_has_apic) {
@@ -341,6 +306,11 @@
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
