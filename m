Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVDZCXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVDZCXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 22:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVDZCXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 22:23:46 -0400
Received: from fmr18.intel.com ([134.134.136.17]:15050 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261282AbVDZCXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 22:23:40 -0400
Subject: [PATCH]broadcast IPI race condition on CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Content-Type: text/plain
Message-Id: <1114482044.7068.17.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 26 Apr 2005 10:20:44 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
After a CPU is booted but before it's officially up (set online map, and
enable interrupt), the CPU possibly will receive a broadcast IPI. After
it's up, it will handle the stale interrupt soon and maybe cause oops if
it's a smp-call-function-interrupt. This is quite possible in CPU
hotplug case, but nearly can't occur at boot time. Below patch replaces
broadcast IPI with send_ipi_mask just like the cluster mode.

Thanks,
Shaohua

Signed-off-by: Li Shaohua<shaohua.li@intel.com>

--- a/include/asm-i386/mach-default/mach_ipi.h	2005-04-26 09:07:51.695390216 +0800
+++ b/include/asm-i386/mach-default/mach_ipi.h	2005-04-26 09:26:59.235937536 +0800
@@ -11,20 +11,16 @@ static inline void send_IPI_mask(cpumask
 
 static inline void send_IPI_allbutself(int vector)
 {
-	/*
-	 * if there are no other CPUs in the system then we get an APIC send 
-	 * error if we try to broadcast, thus avoid sending IPIs in this case.
-	 */
-	if (!(num_online_cpus() > 1))
-		return;
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
 
-	__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-	return;
+	if (likely(!cpus_empty(mask)))
+		send_IPI_mask(mask, vector);
 }
 
 static inline void send_IPI_all(int vector)
 {
-	__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+	send_IPI_mask(cpu_online_map, vector);
 }
 
 #endif /* __ASM_MACH_IPI_H */
--- a/arch/x86_64/kernel/genapic_flat.c	2005-03-02 15:38:09.000000000 +0800
+++ b/arch/x86_64/kernel/genapic_flat.c	2005-04-26 09:26:09.298529176 +0800
@@ -45,20 +45,19 @@ static void flat_init_apic_ldr(void)
 	apic_write_around(APIC_LDR, val);
 }
 
+static void flat_send_IPI_mask(cpumask_t cpumask, int vector);
 static void flat_send_IPI_allbutself(int vector)
 {
-	/*
-	 * if there are no other CPUs in the system then
-	 * we get an APIC send error if we try to broadcast.
-	 * thus we have to avoid sending IPIs in this case.
-	 */
-	if (num_online_cpus() > 1)
-		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector, APIC_DEST_LOGICAL);
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
+
+	if (likely(!cpus_empty(mask)))
+		flat_send_IPI_mask(mask, vector);
 }
 
 static void flat_send_IPI_all(int vector)
 {
-	__send_IPI_shortcut(APIC_DEST_ALLINC, vector, APIC_DEST_LOGICAL);
+	flat_send_IPI_mask(cpu_online_map, vector);
 }
 
 static void flat_send_IPI_mask(cpumask_t cpumask, int vector)

