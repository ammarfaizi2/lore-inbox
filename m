Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVASIJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVASIJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVASIH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:07:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55487 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261642AbVASHdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:49 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 18/29] x86_64-machine_shutdown
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
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
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out the apic and smp shutdown code from machine_restart so it can be
called by in the kexec reboot path as well.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 reboot.c |   62 +++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 33 insertions(+), 29 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-crashkernel/arch/x86_64/kernel/reboot.c linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/reboot.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-crashkernel/arch/x86_64/kernel/reboot.c	Fri Jan 14 04:28:33 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/reboot.c	Tue Jan 18 23:13:50 2005
@@ -66,41 +66,47 @@
 
 __setup("reboot=", reboot_setup);
 
-#ifdef CONFIG_SMP
-static void smp_halt(void)
+static inline void kb_wait(void)
 {
-	int cpuid = safe_smp_processor_id(); 
-	static int first_entry = 1;
+	int i;
+
+	for (i=0; i<0x10000; i++)
+		if ((inb_p(0x64) & 0x02) == 0)
+			break;
+}
 
-	if (reboot_force)
-		return;
+void machine_shutdown(void)
+{
+	/* Stop the cpus and apics */
+#ifdef CONFIG_SMP
+	int reboot_cpu_id;
 
-	if (first_entry) {
-		first_entry = 0;
-		smp_call_function((void *)machine_restart, NULL, 1, 0);
-	}
-			
-	smp_stop_cpu(); 
+	/* The boot cpu is always logical cpu 0 */
+	reboot_cpu_id = 0;
 
-	/* AP calling this. Just halt */
-	if (cpuid != boot_cpu_id) { 
-		for (;;) 
-			asm("hlt");
+	/* Make certain the cpu I'm about to reboot on is online */
+	if (!cpu_isset(reboot_cpu_id, cpu_online_map)) {
+		reboot_cpu_id = smp_processor_id();
 	}
 
-	/* Wait for all other CPUs to have run smp_stop_cpu */
-	while (!cpus_empty(cpu_online_map))
-		rep_nop(); 
-}
+	/* Make certain I only run on the appropriate processor */
+	set_cpus_allowed(current, cpumask_of_cpu(reboot_cpu_id));
+
+	/* O.K Now that I'm on the appropriate processor,
+	 * stop all of the others.
+	 */
+	smp_send_stop();
 #endif
 
-static inline void kb_wait(void)
-{
-	int i;
+	local_irq_disable();
 
-	for (i=0; i<0x10000; i++)
-		if ((inb_p(0x64) & 0x02) == 0)
-			break;
+#ifndef CONFIG_SMP
+	disable_local_APIC();
+#endif
+
+	disable_IO_APIC();
+
+	local_irq_enable();
 }
 
 void machine_restart(char * __unused)
@@ -109,9 +115,7 @@
 
 	printk("machine restart\n");
 
-#ifdef CONFIG_SMP
-	smp_halt(); 
-#endif
+	machine_shutdown();
 
 	if (!reboot_force) {
 		local_irq_disable();
