Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268592AbUHTS2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268592AbUHTS2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUHTS2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:28:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64417 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268592AbUHTSNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:13:50 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/14] kexec: machine_shutdown.x86_64
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:12:35 -0600
Message-ID: <m1657d65m4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out the apic and smp shutdown code from machine_restart
so it can be called by in the kexec reboot path as well.

diff -uNr linux-2.6.8.1-mm2-kexec-generic/arch/x86_64/kernel/reboot.c linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/kernel/reboot.c
--- linux-2.6.8.1-mm2-kexec-generic/arch/x86_64/kernel/reboot.c	Thu Jul 15 07:27:09 2004
+++ linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/kernel/reboot.c	Fri Aug 20 10:15:07 2004
@@ -91,31 +91,6 @@
 		      [target] "b" (WARMBOOT_TRAMP));
 }
 
-#ifdef CONFIG_SMP
-static void smp_halt(void)
-{
-	int cpuid = safe_smp_processor_id(); 
-		static int first_entry = 1;
-
-		if (first_entry) { 
-			first_entry = 0;
-			smp_call_function((void *)machine_restart, NULL, 1, 0);
-		} 
-			
-	smp_stop_cpu(); 
-
-	/* AP calling this. Just halt */
-	if (cpuid != boot_cpu_id) { 
-		for (;;) 
-			asm("hlt");
-	}
-
-	/* Wait for all other CPUs to have run smp_stop_cpu */
-	while (!cpus_empty(cpu_online_map))
-		rep_nop(); 
-}
-#endif
-
 static inline void kb_wait(void)
 {
 	int i;
@@ -125,23 +100,45 @@
 			break;
 }
 
-void machine_restart(char * __unused)
+void machine_shutdown(void)
 {
-	int i;
-
+	/* Stop the cpus and apics */
 #ifdef CONFIG_SMP
-	smp_halt(); 
-#endif
+	int reboot_cpu_id;
+
+	/* The boot cpu is always logical cpu 0 */
+	reboot_cpu_id = 0;
 
+	/* Make certain the cpu I'm about to reboot on is online */
+	if (!cpu_isset(reboot_cpu_id, cpu_online_map)) {
+		reboot_cpu_id = smp_processor_id();
+	}
+
+	/* Make certain I only run on the appropriate processor */
+	set_cpus_allowed(current, cpumask_of_cpu(reboot_cpu_id));
+
+	/* O.K Now that I'm on the appropriate processor, 
+	 * stop all of the others.
+	 */
+	smp_send_stop();
+#endif
+	
 	local_irq_disable();
-       
+
 #ifndef CONFIG_SMP
 	disable_local_APIC();
 #endif
 
 	disable_IO_APIC();
-	
+
 	local_irq_enable();
+}
+
+void machine_restart(char * __unused)
+{
+	int i;
+
+	machine_shutdown();
 	
 	/* Tell the BIOS if we want cold or warm reboot */
 	*((unsigned short *)__va(0x472)) = reboot_mode;
