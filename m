Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVCNXuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVCNXuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVCNXuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:50:54 -0500
Received: from fmr22.intel.com ([143.183.121.14]:56494 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262134AbVCNXu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:50:27 -0500
Date: Mon, 14 Mar 2005 15:50:04 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       davidm@hpl.hp.com, hch@lst.de
Subject: Fix irq_affinity write from /proc for IPF
Message-ID: <20050314155004.A22573@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew/Tony

This patch is required for IPF to perform deferred write to rte's when
affinity is programmed via /proc. These entries can only be programmed when 
interrupt is pending.

We will eventually need the same method for x86 and x86_64 as well. 

This patch is only for IPF though. (the others are comming, more testing and
changes needed in my sandbox)

Could you please queue this up for next mm candidate? if it looks acceptable.

Since iam touching a common file for GENERIC_HARDIRQ, it would be best it its
reviwed in the -mm releases for any potential conflicts.

[ sorry for the cross post to lia64 ]

-- 
Cheers,
Ashok Raj
- Open Source Technology Center



---
fix_ia64_smp_affinity - Make GENERIC_HARDIRQ work for IPF and CPU Hotplug

Signed-off-by: Ashok Raj <ashok.raj@intel.com>

Made GENERIC_HARDIRQ mechanism work for IPF and CPU hotplug. When write to 
/proc/irq is handled it is not appropriate to perform set_rte immediatly, 
since there is a race when the interrupt is asserted while the re-program 
is happening. Hence such programming is only safe when we do the re-program 
at the time of servicing an interrupt. This got broken when GENERIC_HARDIRQ 
got introduced for IPF.

- added CONFIG_PENDING_IRQ so default /proc/irq write handler can do the right 
  thing.

TBD: We currently dont handle redirectable hint either in the display, or when
we handle writes to /proc/irq/XX/smp_affinity. We need an arch specific way to 
account for the presence of "r" hint when we handle the proc write.
---

 release_dir-araj/arch/ia64/kernel/irq.c |   12 ++++++++++--
 release_dir-araj/kernel/irq/proc.c      |   10 ++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff -puN arch/ia64/kernel/irq.c~fix_ia64_smp_affinity arch/ia64/kernel/irq.c
--- release_dir/arch/ia64/kernel/irq.c~fix_ia64_smp_affinity	2005-03-14 14:35:44.589293491 -0800
+++ release_dir-araj/arch/ia64/kernel/irq.c	2005-03-14 15:27:54.262106715 -0800
@@ -94,12 +94,20 @@ skip:
 /*
  * This is updated when the user sets irq affinity via /proc
  */
-cpumask_t __cacheline_aligned pending_irq_cpumask[NR_IRQS];
+static cpumask_t __cacheline_aligned pending_irq_cpumask[NR_IRQS];
 static unsigned long pending_irq_redir[BITS_TO_LONGS(NR_IRQS)];
 
-static cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
 static char irq_redir [NR_IRQS]; // = { [0 ... NR_IRQS-1] = 1 };
 
+/*
+ * Arch specific routine for deferred write to iosapic rte to reprogram
+ * intr destination.
+ */
+void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
+{
+	pending_irq_cpumask[irq] = mask_val;
+}
+
 void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
 {
 	cpumask_t mask = CPU_MASK_NONE;
diff -puN kernel/irq/proc.c~fix_ia64_smp_affinity kernel/irq/proc.c
--- release_dir/kernel/irq/proc.c~fix_ia64_smp_affinity	2005-03-14 14:41:05.475031747 -0800
+++ release_dir-araj/kernel/irq/proc.c	2005-03-14 15:27:59.436911339 -0800
@@ -19,6 +19,13 @@ static struct proc_dir_entry *root_irq_d
  */
 static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
 
+void __attribute__((weak))
+proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
+{
+	irq_affinity[irq] = mask_val;
+	irq_desc[irq].handler->set_affinity(irq, mask_val);
+}
+
 static int irq_affinity_read_proc(char *page, char **start, off_t off,
 				  int count, int *eof, void *data)
 {
@@ -53,8 +60,7 @@ static int irq_affinity_write_proc(struc
 	if (cpus_empty(tmp))
 		return -EINVAL;
 
-	irq_affinity[irq] = new_value;
-	irq_desc[irq].handler->set_affinity(irq, new_value);
+	proc_set_irq_affinity(irq, new_value);
 
 	return full_count;
 }
_
