Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVASH5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVASH5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVASH4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:56:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52415 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261629AbVASHdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:25 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 22/29] x86-crash_shutdown-nmi-shootdown
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-crash-shutdown-nmi-shootdown-11061198973234@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <kexec-ppc-support-11061198973302@ebiederm.dsl.xmission.com>
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
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
	<x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
	<kexec-ppc-support-11061198973302@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of the dangers when switching from one kernel to another
is what happens to all of the other cpus that were running
in the crashed kernel.   In an attempt to avoid that problem
this patch adds a nmi handler and attempts to shoot down
the other cpus by sending them non maskable interrupts.

The code then waits for 1 second or until all known cpus
have stopped running and then jumps from the running kernel
that has crashed to the kernel in reserved memory.

The kernel spin loop is used for the delay as that should
behave continue to be safe even in after a crash.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 crash.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/i386/kernel/crash.c linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-nmi-shootdown/arch/i386/kernel/crash.c
--- linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/i386/kernel/crash.c	Tue Jan 18 22:58:15 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-nmi-shootdown/arch/i386/kernel/crash.c	Tue Jan 18 23:15:17 2005
@@ -23,12 +23,65 @@
 #include <asm/hardirq.h>
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
+#include <mach_ipi.h>
 
 #define MAX_NOTE_BYTES 1024
 typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
 
 note_buf_t crash_notes[NR_CPUS];
 
+#ifdef CONFIG_SMP
+static atomic_t waiting_for_crash_ipi;
+
+static int crash_nmi_callback(struct pt_regs *regs, int cpu)
+{
+	local_irq_disable();
+	atomic_dec(&waiting_for_crash_ipi);
+	/* Assume hlt works */
+	__asm__("hlt");
+	for(;;);
+	return 1;
+}
+
+/*
+ * By using the NMI code instead of a vector we just sneak thru the
+ * word generator coming out with just what we want.  AND it does
+ * not matter if clustered_apic_mode is set or not.
+ */
+static void smp_send_nmi_allbutself(void)
+{
+	send_IPI_allbutself(APIC_DM_NMI);
+}
+
+static void nmi_shootdown_cpus(void)
+{
+	unsigned long msecs;
+	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+
+	/* Would it be better to replace the trap vector here? */
+	set_nmi_callback(crash_nmi_callback);
+	/* Ensure the new callback function is set before sending
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
+	
+	/* Leave the nmi callback set */
+}
+#else
+static void nmi_shootdown_cpus(void)
+{
+	/* There are no cpus to shootdown */
+}
+#endif
+
 void machine_crash_shutdown(void)
 {
 	/* This function is only called after the system
@@ -39,4 +92,7 @@
 	 * In practice this means shooting down the other cpus in
 	 * an SMP system.
 	 */
+	/* The kernel is broken so disable interrupts */
+	local_irq_disable();
+	nmi_shootdown_cpus();
 }
