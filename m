Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVJDPDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVJDPDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVJDPDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:03:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54491 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932522AbVJDPDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:03:54 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>
Subject: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 09:02:30 -0600
Message-ID: <m1k6gt8gvt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The per cpu nmi watchdog timer is based on an event counter.  
idle cpus don't generate events so the NMI watchdog doesn't fire
and the test to see if the watchdog is working fails.

- Add nmi_cpu_busy so idle cpus don't mess up the test.
- kmalloc prev_nmi_count to keep kernel stack usage bounded.
- Improve the error message on failure so there is enough
  information to debug problems.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/i386/kernel/nmi.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

42b4c9dd7c387ed2eb7a29c9f02c4c8ed75a736f
diff --git a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
--- a/arch/i386/kernel/nmi.c
+++ b/arch/i386/kernel/nmi.c
@@ -100,16 +100,44 @@ int nmi_active;
 	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
+#ifdef CONFIG_SMP
+/* The performance counters used by NMI_LOCAL_APIC don't trigger when
+ * the CPU is idle. To make sure the NMI watchdog really ticks on all
+ * CPUs during the test make them busy.
+ */
+static __init void nmi_cpu_busy(void *data)
+{
+	volatile int *endflag = data;
+	local_irq_enable();
+	/* Intentionally don't use cpu_relax here. This is
+	   to make sure that the performance counter really ticks,
+	   even if there is a simulator or similar that catches the
+	   pause instruction. On a real HT machine this is fine because
+	   all other CPUs are busy with "useless" delay loops and don't
+	   care if they get somewhat less cycles. */
+	while (*endflag == 0)
+		barrier();
+}
+#endif
+
 static int __init check_nmi_watchdog(void)
 {
-	unsigned int prev_nmi_count[NR_CPUS];
+	volatile int endflag = 0;
+	unsigned int *prev_nmi_count;
 	int cpu;
 
 	if (nmi_watchdog == NMI_NONE)
 		return 0;
 
+	prev_nmi_count = kmalloc(NR_CPUS * sizeof(int), GFP_KERNEL);
+	if (!prev_nmi_count)
+		return -1;
+
 	printk(KERN_INFO "Testing NMI watchdog ... ");
 
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
+
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
 	local_irq_enable();
@@ -123,12 +151,18 @@ static int __init check_nmi_watchdog(voi
 			continue;
 #endif
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
-			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
+			endflag = 1;
+			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n", 
+				cpu,
+				prev_nmi_count[cpu],
+				nmi_count(cpu));
 			nmi_active = 0;
 			lapic_nmi_owner &= ~LAPIC_NMI_WATCHDOG;
+			kfree(prev_nmi_count);
 			return -1;
 		}
 	}
+	endflag = 1;
 	printk("OK.\n");
 
 	/* now that we know it works we can reduce NMI frequency to
@@ -136,6 +170,7 @@ static int __init check_nmi_watchdog(voi
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		nmi_hz = 1;
 
+	kfree(prev_nmi_count);
 	return 0;
 }
 /* This needs to happen later in boot so counters are working */
