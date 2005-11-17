Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVKQN06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVKQN06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVKQN06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:26:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:8382 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750814AbVKQN05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:26:57 -0500
Date: Thu, 17 Nov 2005 18:56:59 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 7/10] kdump: x86_64 kexec on panic
Message-ID: <20051117132659.GK3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com> <20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117132557.GJ3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Implementing the machine_crash_shutdown for x86_64 which will be
  called by crash_kexec (called in case of a panic, sysrq etc.).
  Here we do things similar to i386. Disable the interrupts, shootdown
  the cpus and shutdown LAPIC and IOAPIC.

Changes in this version:

o As the Eric's APIC initialization patches are reverted back, 
  reintroducing LAPIC and IOAPIC shutdown. 

o Added some comments on CPU hotplug, modified code as suggested 
  by Andi kleen.

Signed-off-by:Murali M Chakravarthy <muralim@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/crash.c |   86 +++++++++++-
 1 files changed, 85 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/crash.c~x86_64-kexec-on-panic arch/x86_64/kernel/crash.c
--- linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/crash.c~x86_64-kexec-on-panic	2005-11-17 11:11:10.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/crash.c	2005-11-17 11:54:15.000000000 +0530
@@ -13,15 +13,85 @@
 #include <linux/smp.h>
 #include <linux/reboot.h>
 #include <linux/kexec.h>
+#include <linux/delay.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
+#include <asm/mach_apic.h>
+
+/* This keeps a track of which one is crashing cpu. */
+static int crashing_cpu;
+
+#ifdef CONFIG_SMP
+static atomic_t waiting_for_crash_ipi;
+
+static int crash_nmi_callback(struct pt_regs *regs, int cpu)
+{
+	/*
+	 * Don't do anything if this handler is invoked on crashing cpu.
+	 * Otherwise, system will completely hang. Crashing cpu can get
+	 * an NMI if system was initially booted with nmi_watchdog parameter.
+	 */
+	if (cpu == crashing_cpu)
+		return 1;
+	local_irq_disable();
+
+	disable_local_APIC();
+	atomic_dec(&waiting_for_crash_ipi);
+	/* Assume hlt works */
+	for(;;)
+		asm("hlt");
+
+	return 1;
+}
+
+static void smp_send_nmi_allbutself(void)
+{
+	send_IPI_allbutself(APIC_DM_NMI);
+}
+
+/*
+ * This code is a best effort heuristic to get the
+ * other cpus to stop executing. So races with
+ * cpu hotplug shouldn't matter.
+ */
+
+static void nmi_shootdown_cpus(void)
+{
+	unsigned long msecs;
+
+	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+	set_nmi_callback(crash_nmi_callback);
+
+	/*
+	 * Ensure the new callback function is set before sending
+	 * out the NMI
+	 */
+	wmb();
+
+	smp_send_nmi_allbutself();
+
+	msecs = 1000; /* Wait at most a second for the other cpus to stop */
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
+		mdelay(1);
+		msecs--;
+	}
+	/* Leave the nmi callback set */
+	disable_local_APIC();
+}
+#else
+static void nmi_shootdown_cpus(void)
+{
+	/* There are no cpus to shootdown */
+}
+#endif
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
-	/* This function is only called after the system
+	/*
+	 * This function is only called after the system
 	 * has paniced or is otherwise in a critical state.
 	 * The minimum amount of code to allow a kexec'd kernel
 	 * to run successfully needs to happen here.
@@ -29,4 +99,18 @@ void machine_crash_shutdown(struct pt_re
 	 * In practice this means shooting down the other cpus in
 	 * an SMP system.
 	 */
+	/* The kernel is broken so disable interrupts */
+	local_irq_disable();
+
+	/* Make a note of crashing cpu. Will be used in NMI callback.*/
+	crashing_cpu = smp_processor_id();
+	nmi_shootdown_cpus();
+
+	if(cpu_has_apic)
+		 disable_local_APIC();
+
+#if defined(CONFIG_X86_IO_APIC)
+	disable_IO_APIC();
+#endif
+
 }
_
