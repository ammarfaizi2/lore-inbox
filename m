Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269711AbUJAGFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269711AbUJAGFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 02:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269713AbUJAGFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 02:05:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:30435 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269711AbUJAGEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 02:04:13 -0400
Date: Thu, 30 Sep 2004 23:01:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: ak@muc.de, suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com, James Cleverdon <jamesclv@us.ibm.com>
Subject: Re: [Patch 1/2] Disable SW irqbalance/irqaffinity for
 E7520/E7320/E7525 - change TARGET_CPUS on x86_64
Message-Id: <20040930230133.0d4bcc0d.akpm@osdl.org>
In-Reply-To: <20040930183235.F29549@unix-os.sc.intel.com>
References: <2HSdY-7dr-3@gated-at.bofh.it>
	<m3mzzf99vz.fsf@averell.firstfloor.org>
	<20040930183235.F29549@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh Siddha <suresh.b.siddha@intel.com> wrote:
>
> Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code inline
>  with x86 mach-default. Fix MSI_TARGET_CPU code which will break with this 
>  target_cpus change.

This gets rejects all over the place against the x86_64 clustered APIC mode
patch.

Which has priority here?



From: James Cleverdon <jamesclv@us.ibm.com>

Forthcoming IBM boxes will be using Nocona and/or Opteron chips in
clustered mode to get beyond 8 CPUs.  In fact, there are plans to try for
128 CPUs when the Tulsa chip comes out.  Thus, there are a fair number of
signed vs.  unsigned changes in the patch.

Thanks to the HPET timer and some HW changes, I've been able to remove the
MPS/ACPI string comparisons from the detection code.  Instead, it scans
bios_cpu_apicid and uses simple heuristics to select the correct IRQ
delivery mode.  No need for a config option.  Hurrah!

Likewise, I've been able to avoid the preprocessor tricks that the i386
sub-arch needed to build with one or more sub-arches.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/acpi/boot.c         |    2 
 25-akpm/arch/x86_64/kernel/Makefile          |    3 
 25-akpm/arch/x86_64/kernel/apic.c            |   22 ----
 25-akpm/arch/x86_64/kernel/genapic.c         |   80 ++++++++++++++
 25-akpm/arch/x86_64/kernel/genapic_cluster.c |  146 +++++++++++++++++++++++++++
 25-akpm/arch/x86_64/kernel/genapic_flat.c    |  119 ++++++++++++++++++++++
 25-akpm/arch/x86_64/kernel/io_apic.c         |   60 ++---------
 25-akpm/arch/x86_64/kernel/smp.c             |  100 ------------------
 25-akpm/arch/x86_64/kernel/smpboot.c         |    9 -
 25-akpm/include/asm-x86_64/apic.h            |    1 
 25-akpm/include/asm-x86_64/apicdef.h         |   33 ++++--
 25-akpm/include/asm-x86_64/genapic.h         |   34 ++++++
 25-akpm/include/asm-x86_64/ipi.h             |  113 ++++++++++++++++++++
 25-akpm/include/asm-x86_64/irq.h             |    2 
 25-akpm/include/asm-x86_64/mach_apic.h       |   28 +++++
 25-akpm/include/asm-x86_64/mpspec.h          |    4 
 25-akpm/include/asm-x86_64/msi.h             |    1 
 25-akpm/include/asm-x86_64/smp.h             |   41 +++----
 18 files changed, 588 insertions(+), 210 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~x86-64-clustered-apic-support arch/i386/kernel/acpi/boot.c
--- 25/arch/i386/kernel/acpi/boot.c~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/arch/i386/kernel/acpi/boot.c	Thu Sep 30 16:11:08 2004
@@ -40,7 +40,7 @@
 #ifdef	CONFIG_X86_64
 
 static inline void  acpi_madt_oem_check(char *oem_id, char *oem_table_id) { }
-static inline void clustered_apic_check(void) { }
+extern void __init clustered_apic_check(void);
 static inline int ioapic_setup_disabled(void) { return 0; }
 #include <asm/proto.h>
 
diff -puN arch/x86_64/kernel/apic.c~x86-64-clustered-apic-support arch/x86_64/kernel/apic.c
--- 25/arch/x86_64/kernel/apic.c~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/arch/x86_64/kernel/apic.c	Thu Sep 30 16:11:08 2004
@@ -32,6 +32,7 @@
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
+#include <asm/mach_apic.h>
 
 int apic_verbosity;
 
@@ -330,8 +331,7 @@ void __init setup_local_APIC (void)
 	 * Double-check whether this APIC is really registered.
 	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
-	if (!clustered_apic_mode &&
-		!physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map))
+	if (!apic_id_registered())
 		BUG();
 
 	/*
@@ -339,23 +339,7 @@ void __init setup_local_APIC (void)
 	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
 	 * document number 292116).  So here it goes...
 	 */
-
-	if (!clustered_apic_mode) {
-		/*
-		 * In clustered apic mode, the firmware does this for us 
-		 * Put the APIC into flat delivery mode.
-		 * Must be "all ones" explicitly for 82489DX.
-		 */
-		apic_write_around(APIC_DFR, 0xffffffff);
-
-		/*
-		 * Set up the logical destination ID.
-		 */
-		value = apic_read(APIC_LDR);
-		value &= ~APIC_LDR_MASK;
-		value |= (1<<(smp_processor_id()+24));
-		apic_write_around(APIC_LDR, value);
-	}
+	init_apic_ldr();
 
 	/*
 	 * Set Task Priority to 'accept all'. We never change this
diff -puN /dev/null arch/x86_64/kernel/genapic.c
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/arch/x86_64/kernel/genapic.c	Thu Sep 30 16:11:08 2004
@@ -0,0 +1,80 @@
+/*
+ * Copyright 2004 James Cleverdon, IBM.
+ * Subject to the GNU Public License, v.2
+ *
+ * Generic APIC sub-arch probe layer.
+ *
+ * Hacked for x86-64 by James Cleverdon from i386 architecture code by
+ * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
+ * James Cleverdon.
+ */
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <linux/cpumask.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/ctype.h>
+#include <linux/init.h>
+#include <asm/smp.h>
+#include <asm/ipi.h>
+
+/* which logical CPU number maps to which CPU (physical APIC ID) */
+u8 x86_cpu_to_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+EXPORT_SYMBOL(x86_cpu_to_apicid);
+u8 x86_cpu_to_log_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+
+extern struct genapic apic_cluster;
+extern struct genapic apic_flat;
+
+struct genapic *genapic;
+
+
+/*
+ * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
+ */
+void __init clustered_apic_check(void)
+{
+	long i;
+	u8 clusters, max_cluster;
+	u8 id;
+	u8 cluster_cnt[NUM_APIC_CLUSTERS];
+
+	memset(cluster_cnt, 0, sizeof(cluster_cnt));
+
+	for (i = 0; i < NR_CPUS; i++) {
+		id = bios_cpu_apicid[i];
+		if (id != BAD_APICID)
+			cluster_cnt[APIC_CLUSTERID(id)]++;
+	}
+
+	clusters = 0;
+	max_cluster = 0;
+	for (i = 0; i < NUM_APIC_CLUSTERS; i++) {
+		if (cluster_cnt[i] > 0) {
+			++clusters;
+			if (cluster_cnt[i] > max_cluster)
+				max_cluster = cluster_cnt[i];
+		}
+	}
+
+	/*
+	 * If we have clusters <= 1 and CPUs <= 8 in cluster 0, then flat mode,
+	 * else if max_cluster <= 4 and cluster_cnt[15] == 0, clustered logical
+	 * else physical mode.
+	 * (We don't use lowest priority delivery + HW APIC IRQ steering, so
+	 * can ignore the clustered logical case and go straight to physical.)
+	 */
+	if (clusters <= 1 && max_cluster <= 8 && cluster_cnt[0] == max_cluster)
+		genapic = &apic_flat;
+	else
+		genapic = &apic_cluster;
+
+	printk(KERN_INFO "Setting APIC routing to %s\n", genapic->name);
+}
+
+/* Same for both flat and clustered. */
+
+void send_IPI_self(int vector)
+{
+	__send_IPI_shortcut(APIC_DEST_SELF, vector, APIC_DEST_PHYSICAL);
+}
diff -puN /dev/null arch/x86_64/kernel/genapic_cluster.c
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/arch/x86_64/kernel/genapic_cluster.c	Thu Sep 30 16:11:08 2004
@@ -0,0 +1,146 @@
+/*
+ * Copyright 2004 James Cleverdon, IBM.
+ * Subject to the GNU Public License, v.2
+ *
+ * Clustered APIC subarch code.  Up to 255 CPUs, physical delivery.
+ * (A more realistic maximum is around 230 CPUs.)
+ *
+ * Hacked for x86-64 by James Cleverdon from i386 architecture code by
+ * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
+ * James Cleverdon.
+ */
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <linux/cpumask.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/ctype.h>
+#include <linux/init.h>
+#include <asm/smp.h>
+#include <asm/ipi.h>
+
+
+/*
+ * Set up the logical destination ID.
+ *
+ * Intel recommends to set DFR, LDR and TPR before enabling
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
+ * document number 292116).  So here it goes...
+ */
+static void cluster_init_apic_ldr(void)
+{
+	unsigned long val, id;
+	long i, count;
+	u8 lid;
+	u8 my_id = hard_smp_processor_id();
+	u8 my_cluster = APIC_CLUSTER(my_id);
+
+	/* Create logical APIC IDs by counting CPUs already in cluster. */
+	for (count = 0, i = NR_CPUS; --i >= 0; ) {
+		lid = x86_cpu_to_log_apicid[i];
+		if (lid != BAD_APICID && APIC_CLUSTER(lid) == my_cluster)
+			++count;
+	}
+	/*
+	 * We only have a 4 wide bitmap in cluster mode.  There's no way
+	 * to get above 60 CPUs and still give each one it's own bit.
+	 * But, we're using physical IRQ delivery, so we don't care.
+	 * Use bit 3 for the 4th through Nth CPU in each cluster.
+	 */
+	if (count >= XAPIC_DEST_CPUS_SHIFT)
+		count = 3;
+	id = my_cluster | (1UL << count);
+	x86_cpu_to_log_apicid[smp_processor_id()] = id;
+	apic_write_around(APIC_DFR, APIC_DFR_CLUSTER);
+	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	val |= SET_APIC_LOGICAL_ID(id);
+	apic_write_around(APIC_LDR, val);
+}
+
+
+/* Mapping from cpu number to logical apicid */
+static int cluster_cpu_to_logical_apicid(int cpu)
+{
+       if ((unsigned)cpu >= NR_CPUS)
+	       return BAD_APICID;
+	return x86_cpu_to_log_apicid[cpu];
+}
+
+static int cluster_cpu_present_to_apicid(int mps_cpu)
+{
+	if ((unsigned)mps_cpu < NR_CPUS)
+		return (int)bios_cpu_apicid[mps_cpu];
+	else
+		return BAD_APICID;
+}
+
+/* Distribute IRQ load with round-robin allocation */
+
+static u8 cluster_target_cpus(void)
+{
+	unsigned long	i;
+	static unsigned long	last_cpu = 0;
+
+	i = last_cpu;
+	do {
+		if (++i >= NR_CPUS)
+			i = 0;
+	} while (x86_cpu_to_apicid[i] == BAD_APICID);
+	last_cpu = i;
+
+	return x86_cpu_to_apicid[i];
+}
+
+static void cluster_send_IPI_mask(cpumask_t mask, int vector)
+{
+	send_IPI_mask_sequence(mask, vector);
+}
+
+static void cluster_send_IPI_allbutself(int vector)
+{
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
+
+	if (!cpus_empty(mask))
+		cluster_send_IPI_mask(mask, vector);
+}
+
+static void cluster_send_IPI_all(int vector)
+{
+	cluster_send_IPI_mask(cpu_online_map, vector);
+}
+
+static int cluster_apic_id_registered(void)
+{
+	return 1;
+}
+
+static unsigned int cluster_cpu_mask_to_apicid(cpumask_t cpumask)
+{
+	long cpu;
+
+	/*
+	 * We're using fixed IRQ delivery, can only return one phys APIC ID.
+	 * May as well be the first.
+	 */
+	cpu = first_cpu(cpumask);
+	if (cpu >= 0 && cpu < NR_CPUS)
+		return x86_cpu_to_apicid[cpu];
+	else
+		return BAD_APICID;
+}
+
+
+struct genapic apic_cluster = {
+	.name = "clustered",
+	.int_delivery_mode = dest_Fixed,
+	.int_dest_mode = (APIC_DEST_PHYSICAL != 0),
+	.int_delivery_dest = APIC_DEST_PHYSICAL | APIC_DM_FIXED,
+	.target_cpus = cluster_target_cpus,
+	.apic_id_registered = cluster_apic_id_registered,
+	.init_apic_ldr = cluster_init_apic_ldr,
+	.send_IPI_all = cluster_send_IPI_all,
+	.send_IPI_allbutself = cluster_send_IPI_allbutself,
+	.send_IPI_mask = cluster_send_IPI_mask,
+	.cpu_mask_to_apicid = cluster_cpu_mask_to_apicid,
+};
diff -puN /dev/null arch/x86_64/kernel/genapic_flat.c
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/arch/x86_64/kernel/genapic_flat.c	Thu Sep 30 16:11:08 2004
@@ -0,0 +1,119 @@
+/*
+ * Copyright 2004 James Cleverdon, IBM.
+ * Subject to the GNU Public License, v.2
+ *
+ * Flat APIC subarch code.  Maximum 8 CPUs, logical delivery.
+ *
+ * Hacked for x86-64 by James Cleverdon from i386 architecture code by
+ * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
+ * James Cleverdon.
+ */
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <linux/cpumask.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/ctype.h>
+#include <linux/init.h>
+#include <asm/smp.h>
+#include <asm/ipi.h>
+
+
+static u8 flat_target_cpus(void)
+{
+	return cpus_addr(cpu_online_map)[0];
+}
+
+/*
+ * Set up the logical destination ID.
+ *
+ * Intel recommends to set DFR, LDR and TPR before enabling
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
+ * document number 292116).  So here it goes...
+ */
+static void flat_init_apic_ldr(void)
+{
+	unsigned long val;
+	unsigned long num, id;
+
+	num = smp_processor_id();
+	id = 1UL << num;
+	x86_cpu_to_log_apicid[num] = id;
+	apic_write_around(APIC_DFR, APIC_DFR_FLAT);
+	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	val |= SET_APIC_LOGICAL_ID(id);
+	apic_write_around(APIC_LDR, val);
+}
+
+static void flat_send_IPI_allbutself(int vector)
+{
+	/*
+	 * if there are no other CPUs in the system then
+	 * we get an APIC send error if we try to broadcast.
+	 * thus we have to avoid sending IPIs in this case.
+	 */
+	if (num_online_cpus() > 1)
+		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector, APIC_DEST_LOGICAL);
+}
+
+static void flat_send_IPI_all(int vector)
+{
+	__send_IPI_shortcut(APIC_DEST_ALLINC, vector, APIC_DEST_LOGICAL);
+}
+
+static void flat_send_IPI_mask(cpumask_t cpumask, int vector)
+{
+	unsigned long mask = cpus_addr(cpumask)[0];
+	unsigned long cfg;
+	unsigned long flags;
+
+	local_save_flags(flags);
+	local_irq_disable();
+
+	/*
+	 * Wait for idle.
+	 */
+	apic_wait_icr_idle();
+
+	/*
+	 * prepare target chip field
+	 */
+	cfg = __prepare_ICR2(mask);
+	apic_write_around(APIC_ICR2, cfg);
+
+	/*
+	 * program the ICR
+	 */
+	cfg = __prepare_ICR(0, vector, APIC_DEST_LOGICAL);
+
+	/*
+	 * Send the IPI. The write to APIC_ICR fires this off.
+	 */
+	apic_write_around(APIC_ICR, cfg);
+	local_irq_restore(flags);
+}
+
+static int flat_apic_id_registered(void)
+{
+	return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
+}
+
+static unsigned int flat_cpu_mask_to_apicid(cpumask_t cpumask)
+{
+	return cpus_addr(cpumask)[0] & APIC_ALL_CPUS;
+}
+
+
+struct genapic apic_flat =  {
+	.name = "flat",
+	.int_delivery_mode = dest_LowestPrio,
+	.int_dest_mode = (APIC_DEST_LOGICAL != 0),
+	.int_delivery_dest = APIC_DEST_LOGICAL | APIC_DM_LOWEST,
+	.target_cpus = flat_target_cpus,
+	.apic_id_registered = flat_apic_id_registered,
+	.init_apic_ldr = flat_init_apic_ldr,
+	.send_IPI_all = flat_send_IPI_all,
+	.send_IPI_allbutself = flat_send_IPI_allbutself,
+	.send_IPI_mask = flat_send_IPI_mask,
+	.cpu_mask_to_apicid = flat_cpu_mask_to_apicid,
+};
diff -puN arch/x86_64/kernel/io_apic.c~x86-64-clustered-apic-support arch/x86_64/kernel/io_apic.c
--- 25/arch/x86_64/kernel/io_apic.c~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/arch/x86_64/kernel/io_apic.c	Thu Sep 30 16:11:08 2004
@@ -36,6 +36,7 @@
 #include <asm/smp.h>
 #include <asm/desc.h>
 #include <asm/proto.h>
+#include <asm/mach_apic.h>
 
 #define __apicdebuginit  __init
 
@@ -728,8 +729,8 @@ void __init setup_IO_APIC_irqs(void)
 		 */
 		memset(&entry,0,sizeof(entry));
 
-		entry.delivery_mode = dest_LowestPrio;
-		entry.dest_mode = INT_DELIVERY_MODE;
+		entry.delivery_mode = INT_DELIVERY_MODE;
+		entry.dest_mode = INT_DEST_MODE;
 		entry.mask = 0;				/* enable IRQ */
 		entry.dest.logical.logical_dest = TARGET_CPUS;
 
@@ -797,10 +798,10 @@ void __init setup_ExtINT_IRQ0_pin(unsign
 	 * We use logical delivery to get the timer IRQ
 	 * to the first CPU.
 	 */
-	entry.dest_mode = INT_DELIVERY_MODE;
+	entry.dest_mode = INT_DEST_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
 	entry.dest.logical.logical_dest = TARGET_CPUS;
-	entry.delivery_mode = dest_LowestPrio;
+	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.polarity = 0;
 	entry.trigger = 0;
 	entry.vector = vector;
@@ -1180,7 +1181,6 @@ void disable_IO_APIC(void)
 static void __init setup_ioapic_ids_from_mpc (void)
 {
 	union IO_APIC_reg_00 reg_00;
-	physid_mask_t phys_id_present_map = phys_cpu_present_map;
 	int apic;
 	int i;
 	unsigned char old_id;
@@ -1206,28 +1206,7 @@ static void __init setup_ioapic_ids_from
 			mp_ioapics[apic].mpc_apicid = reg_00.bits.ID;
 		}
 
-		/*
-		 * Sanity check, is the ID really free? Every APIC in a
-		 * system must have a unique ID or we get lots of nice
-		 * 'stuck on smp_invalidate_needed IPI wait' messages.
-	 	 */
-		if (physid_isset(mp_ioapics[apic].mpc_apicid, phys_id_present_map)) {
-			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
-				apic, mp_ioapics[apic].mpc_apicid);
-			for (i = 0; i < 0xf; i++)
-				if (!physid_isset(i, phys_id_present_map))
-					break;
-			if (i >= 0xf)
-				panic("Max APIC ID exceeded!\n");
-			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				i);
-			physid_set(i, phys_id_present_map);
-			mp_ioapics[apic].mpc_apicid = i;
-		} else {
-			printk(KERN_INFO 
-			       "Using IO-APIC %d\n", mp_ioapics[apic].mpc_apicid);
-			physid_set(mp_ioapics[apic].mpc_apicid, phys_id_present_map);
-		}
+		printk(KERN_INFO "Using IO-APIC %d\n", mp_ioapics[apic].mpc_apicid);
 
 
 		/*
@@ -1436,9 +1415,9 @@ static void set_ioapic_affinity_irq(unsi
 	dest = cpu_mask_to_apicid(mask);
 
 	/*
-	 * Only the first 8 bits are valid.
+	 * Only the high 8 bits are valid.
 	 */
-	dest = dest << 24;
+	dest = SET_APIC_LOGICAL_ID(dest);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
 	__DO_ACTION(1, = dest, )
@@ -1920,7 +1899,7 @@ device_initcall(ioapic_init_sysfs);
 
 #ifdef CONFIG_ACPI_BOOT
 
-#define IO_APIC_MAX_ID		15
+#define IO_APIC_MAX_ID		0xFE
 
 int __init io_apic_get_unique_id (int ioapic, int apic_id)
 {
@@ -2037,8 +2016,8 @@ int io_apic_set_pci_routing (int ioapic,
 
 	memset(&entry,0,sizeof(entry));
 
-	entry.delivery_mode = dest_LowestPrio;
-	entry.dest_mode = INT_DELIVERY_MODE;
+	entry.delivery_mode = INT_DELIVERY_MODE;
+	entry.dest_mode = INT_DEST_MODE;
 	entry.dest.logical.logical_dest = TARGET_CPUS;
 	entry.trigger = edge_level;
 	entry.polarity = active_high_low;
@@ -2072,20 +2051,3 @@ int io_apic_set_pci_routing (int ioapic,
 
 #endif /*CONFIG_ACPI_BOOT*/
 
-#ifndef CONFIG_SMP
-void send_IPI_self(int vector)
-{
-	unsigned int cfg;
-
-       /*
-        * Wait for idle.
-        */
-	apic_wait_icr_idle();
-	cfg = APIC_DM_FIXED | APIC_DEST_SELF | vector | APIC_DEST_LOGICAL;
-
-	/*
-	 * Send the IPI. The write to APIC_ICR fires this off.
-	 */
-	apic_write_around(APIC_ICR, cfg);
-}
-#endif
diff -puN arch/x86_64/kernel/Makefile~x86-64-clustered-apic-support arch/x86_64/kernel/Makefile
--- 25/arch/x86_64/kernel/Makefile~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/arch/x86_64/kernel/Makefile	Thu Sep 30 16:11:08 2004
@@ -17,7 +17,8 @@ obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
-obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
+obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o \
+		genapic.o genapic_cluster.o genapic_flat.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_PM)		+= suspend.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
diff -puN arch/x86_64/kernel/smpboot.c~x86-64-clustered-apic-support arch/x86_64/kernel/smpboot.c
--- 25/arch/x86_64/kernel/smpboot.c~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/arch/x86_64/kernel/smpboot.c	Thu Sep 30 16:11:08 2004
@@ -56,15 +56,12 @@
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
-char phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
+/* Package ID of each logical CPU */
+u8 phys_proc_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map;
 
-/* which logical CPU number maps to which CPU (physical APIC ID) */
-volatile char x86_cpu_to_apicid[NR_CPUS];
-EXPORT_SYMBOL(x86_cpu_to_apicid);
-
 static cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
@@ -658,6 +655,8 @@ static void __init do_boot_cpu (int apic
 		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
 		cpucount--;
+		x86_cpu_to_apicid[cpu] = BAD_APICID;
+		x86_cpu_to_log_apicid[cpu] = BAD_APICID;
 	}
 }
 
diff -puN arch/x86_64/kernel/smp.c~x86-64-clustered-apic-support arch/x86_64/kernel/smp.c
--- 25/arch/x86_64/kernel/smp.c~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/arch/x86_64/kernel/smp.c	Thu Sep 30 16:11:08 2004
@@ -24,105 +24,7 @@
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-
-/*
- * the following functions deal with sending IPIs between CPUs.
- *
- * We use 'broadcast', CPU->CPU IPIs and self-IPIs too.
- */
-
-static inline unsigned int __prepare_ICR (unsigned int shortcut, int vector)
-{
-	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | APIC_DEST_LOGICAL;
-	if (vector == KDB_VECTOR) 
-		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI; 		
-	return icr;
-}
-
-static inline int __prepare_ICR2 (unsigned int mask)
-{
-	return SET_APIC_DEST_FIELD(mask);
-}
-
-static inline void __send_IPI_shortcut(unsigned int shortcut, int vector)
-{
-	/*
-	 * Subtle. In the case of the 'never do double writes' workaround
-	 * we have to lock out interrupts to be safe.  As we don't care
-	 * of the value read we use an atomic rmw access to avoid costly
-	 * cli/sti.  Otherwise we use an even cheaper single atomic write
-	 * to the APIC.
-	 */
-	unsigned int cfg;
-
-	/*
-	 * Wait for idle.
-	 */
-	apic_wait_icr_idle();
-
-	/*
-	 * No need to touch the target chip field
-	 */
-	cfg = __prepare_ICR(shortcut, vector);
-
-	/*
-	 * Send the IPI. The write to APIC_ICR fires this off.
-	 */
-	apic_write_around(APIC_ICR, cfg);
-}
-
-static inline void send_IPI_allbutself(int vector)
-{
-	/*
-	 * if there are no other CPUs in the system then
-	 * we get an APIC send error if we try to broadcast.
-	 * thus we have to avoid sending IPIs in this case.
-	 */
-	if (num_online_cpus() > 1)
-		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-}
-
-static inline void send_IPI_all(int vector)
-{
-	__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-}
-
-void send_IPI_self(int vector)
-{
-	__send_IPI_shortcut(APIC_DEST_SELF, vector);
-}
-
-static inline void send_IPI_mask(cpumask_t cpumask, int vector)
-{
-	unsigned long mask = cpus_addr(cpumask)[0];
-	unsigned long cfg;
-	unsigned long flags;
-
-	local_save_flags(flags);
-	local_irq_disable();
-
-	/*
-	 * Wait for idle.
-	 */
-	apic_wait_icr_idle();
-
-	/*
-	 * prepare target chip field
-	 */
-	cfg = __prepare_ICR2(mask);
-	apic_write_around(APIC_ICR2, cfg);
-
-	/*
-	 * program the ICR 
-	 */
-	cfg = __prepare_ICR(0, vector);
-	
-	/*
-	 * Send the IPI. The write to APIC_ICR fires this off.
-	 */
-	apic_write_around(APIC_ICR, cfg);
-	local_irq_restore(flags);
-}
+#include <asm/mach_apic.h>
 
 /*
  *	Smarter SMP flushing macros. 
diff -puN include/asm-x86_64/apicdef.h~x86-64-clustered-apic-support include/asm-x86_64/apicdef.h
--- 25/include/asm-x86_64/apicdef.h~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/include/asm-x86_64/apicdef.h	Thu Sep 30 16:11:08 2004
@@ -11,26 +11,26 @@
 #define		APIC_DEFAULT_PHYS_BASE	0xfee00000
  
 #define		APIC_ID		0x20
-#define			APIC_ID_MASK		(0x0F<<24)
-#define			GET_APIC_ID(x)		(((x)>>24)&0x0F)
+#define			APIC_ID_MASK		(0xFFu<<24)
+#define			GET_APIC_ID(x)		(((x)>>24)&0xFFu)
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
-#define			GET_APIC_VERSION(x)	((x)&0xFF)
-#define			GET_APIC_MAXLVT(x)	(((x)>>16)&0xFF)
-#define			APIC_INTEGRATED(x)	((x)&0xF0)
+#define			GET_APIC_VERSION(x)	((x)&0xFFu)
+#define			GET_APIC_MAXLVT(x)	(((x)>>16)&0xFFu)
+#define			APIC_INTEGRATED(x)	((x)&0xF0u)
 #define		APIC_TASKPRI	0x80
-#define			APIC_TPRI_MASK		0xFF
+#define			APIC_TPRI_MASK		0xFFu
 #define		APIC_ARBPRI	0x90
-#define			APIC_ARBPRI_MASK	0xFF
+#define			APIC_ARBPRI_MASK	0xFFu
 #define		APIC_PROCPRI	0xA0
 #define		APIC_EOI	0xB0
 #define			APIC_EIO_ACK		0x0		/* Write this to the EOI register */
 #define		APIC_RRR	0xC0
 #define		APIC_LDR	0xD0
-#define			APIC_LDR_MASK		(0xFF<<24)
-#define			GET_APIC_LOGICAL_ID(x)	(((x)>>24)&0xFF)
+#define			APIC_LDR_MASK		(0xFFu<<24)
+#define			GET_APIC_LOGICAL_ID(x)	(((x)>>24)&0xFFu)
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
-#define			APIC_ALL_CPUS		0xFF
+#define			APIC_ALL_CPUS		0xFFu
 #define		APIC_DFR	0xE0
 #define			APIC_DFR_CLUSTER		0x0FFFFFFFul
 #define			APIC_DFR_FLAT			0xFFFFFFFFul
@@ -60,6 +60,7 @@
 #define			APIC_INT_ASSERT		0x04000
 #define			APIC_ICR_BUSY		0x01000
 #define			APIC_DEST_LOGICAL	0x00800
+#define			APIC_DEST_PHYSICAL	0x00000
 #define			APIC_DM_FIXED		0x00000
 #define			APIC_DM_LOWEST		0x00100
 #define			APIC_DM_SMI		0x00200
@@ -114,6 +115,18 @@
 #define MAX_IO_APICS 32
 
 /*
+ * All x86-64 systems are xAPIC compatible.
+ * In the following, "apicid" is a physical APIC ID.
+ */
+#define XAPIC_DEST_CPUS_SHIFT	4
+#define XAPIC_DEST_CPUS_MASK	((1u << XAPIC_DEST_CPUS_SHIFT) - 1)
+#define XAPIC_DEST_CLUSTER_MASK	(XAPIC_DEST_CPUS_MASK << XAPIC_DEST_CPUS_SHIFT)
+#define APIC_CLUSTER(apicid)	((apicid) & XAPIC_DEST_CLUSTER_MASK)
+#define APIC_CLUSTERID(apicid)	(APIC_CLUSTER(apicid) >> XAPIC_DEST_CPUS_SHIFT)
+#define APIC_CPUID(apicid)	((apicid) & XAPIC_DEST_CPUS_MASK)
+#define NUM_APIC_CLUSTERS	((BAD_APICID + 1) >> XAPIC_DEST_CPUS_SHIFT)
+
+/*
  * the local APIC register structure, memory mapped. Not terribly well
  * tested, but we might eventually use this one in the future - the
  * problem why we cannot use it right now is the P5 APIC, it has an
diff -puN include/asm-x86_64/apic.h~x86-64-clustered-apic-support include/asm-x86_64/apic.h
--- 25/include/asm-x86_64/apic.h~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/include/asm-x86_64/apic.h	Thu Sep 30 16:11:08 2004
@@ -111,7 +111,6 @@ extern unsigned int nmi_watchdog;
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
-#define clustered_apic_mode 0
 #define esr_disable 0
 extern unsigned boot_cpu_id;
 
diff -puN /dev/null include/asm-x86_64/genapic.h
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/include/asm-x86_64/genapic.h	Thu Sep 30 16:11:08 2004
@@ -0,0 +1,34 @@
+#ifndef _ASM_GENAPIC_H
+#define _ASM_GENAPIC_H 1
+
+/*
+ * Copyright 2004 James Cleverdon, IBM.
+ * Subject to the GNU Public License, v.2
+ *
+ * Generic APIC sub-arch data struct.
+ *
+ * Hacked for x86-64 by James Cleverdon from i386 architecture code by
+ * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
+ * James Cleverdon.
+ */
+
+struct genapic {
+	char *name;
+	u32 int_delivery_mode;
+	u32 int_dest_mode;
+	u32 int_delivery_dest;	/* for quick IPIs */
+	int (*apic_id_registered)(void);
+	u8 (*target_cpus)(void);
+	void (*init_apic_ldr)(void);
+	/* ipi */
+	void (*send_IPI_mask)(cpumask_t mask, int vector);
+	void (*send_IPI_allbutself)(int vector);
+	void (*send_IPI_all)(int vector);
+	/* */
+	unsigned int (*cpu_mask_to_apicid)(cpumask_t cpumask);
+};
+
+
+extern struct genapic *genapic;
+
+#endif
diff -puN /dev/null include/asm-x86_64/ipi.h
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/include/asm-x86_64/ipi.h	Thu Sep 30 16:11:08 2004
@@ -0,0 +1,113 @@
+#ifndef __ASM_IPI_H
+#define __ASM_IPI_H
+
+/*
+ * Copyright 2004 James Cleverdon, IBM.
+ * Subject to the GNU Public License, v.2
+ *
+ * Generic APIC InterProcessor Interrupt code.
+ *
+ * Moved to include file by James Cleverdon from
+ * arch/x86-64/kernel/smp.c
+ *
+ * Copyrights from kernel/smp.c:
+ *
+ * (c) 1995 Alan Cox, Building #3 <alan@redhat.com>
+ * (c) 1998-99, 2000 Ingo Molnar <mingo@redhat.com>
+ * (c) 2002,2003 Andi Kleen, SuSE Labs.
+ * Subject to the GNU Public License, v.2
+ */
+
+#include <asm/fixmap.h>
+#include <asm/hw_irq.h>
+#include <asm/apicdef.h>
+#include <asm/genapic.h>
+
+/*
+ * the following functions deal with sending IPIs between CPUs.
+ *
+ * We use 'broadcast', CPU->CPU IPIs and self-IPIs too.
+ */
+
+static inline unsigned int __prepare_ICR (unsigned int shortcut, int vector, unsigned int dest)
+{
+	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
+	if (vector == KDB_VECTOR)
+		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;
+	return icr;
+}
+
+static inline int __prepare_ICR2 (unsigned int mask)
+{
+	return SET_APIC_DEST_FIELD(mask);
+}
+
+static inline void __send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
+{
+	/*
+	 * Subtle. In the case of the 'never do double writes' workaround
+	 * we have to lock out interrupts to be safe.  As we don't care
+	 * of the value read we use an atomic rmw access to avoid costly
+	 * cli/sti.  Otherwise we use an even cheaper single atomic write
+	 * to the APIC.
+	 */
+	unsigned int cfg;
+
+	/*
+	 * Wait for idle.
+	 */
+	apic_wait_icr_idle();
+
+	/*
+	 * No need to touch the target chip field
+	 */
+	cfg = __prepare_ICR(shortcut, vector, dest);
+
+	/*
+	 * Send the IPI. The write to APIC_ICR fires this off.
+	 */
+	apic_write_around(APIC_ICR, cfg);
+}
+
+
+static inline void send_IPI_mask_sequence(cpumask_t mask, int vector)
+{
+	unsigned long cfg, flags;
+	unsigned long query_cpu;
+
+	/*
+	 * Hack. The clustered APIC addressing mode doesn't allow us to send
+	 * to an arbitrary mask, so I do a unicast to each CPU instead.
+	 * - mbligh
+	 */
+	local_irq_save(flags);
+
+	for (query_cpu = 0; query_cpu < NR_CPUS; ++query_cpu) {
+		if (cpu_isset(query_cpu, mask)) {
+
+			/*
+			 * Wait for idle.
+			 */
+			apic_wait_icr_idle();
+
+			/*
+			 * prepare target chip field
+			 */
+			cfg = __prepare_ICR2(x86_cpu_to_apicid[query_cpu]);
+			apic_write_around(APIC_ICR2, cfg);
+
+			/*
+			 * program the ICR
+			 */
+			cfg = __prepare_ICR(0, vector, APIC_DEST_PHYSICAL);
+
+			/*
+			 * Send the IPI. The write to APIC_ICR fires this off.
+			 */
+			apic_write_around(APIC_ICR, cfg);
+		}
+	}
+	local_irq_restore(flags);
+}
+
+#endif /* __ASM_IPI_H */
diff -puN include/asm-x86_64/irq.h~x86-64-clustered-apic-support include/asm-x86_64/irq.h
--- 25/include/asm-x86_64/irq.h~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/include/asm-x86_64/irq.h	Thu Sep 30 16:11:08 2004
@@ -36,7 +36,7 @@
 #define NR_IRQ_VECTORS NR_IRQS
 #else
 #define NR_IRQS 224
-#define NR_IRQ_VECTORS NR_IRQS
+#define NR_IRQ_VECTORS 1024
 #endif
 
 static __inline__ int irq_canonicalize(int irq)
diff -puN /dev/null include/asm-x86_64/mach_apic.h
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/include/asm-x86_64/mach_apic.h	Thu Sep 30 16:11:08 2004
@@ -0,0 +1,28 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+/*
+ * Copyright 2004 James Cleverdon, IBM.
+ * Subject to the GNU Public License, v.2
+ *
+ * Generic APIC sub-arch defines.
+ *
+ * Hacked for x86-64 by James Cleverdon from i386 architecture code by
+ * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
+ * James Cleverdon.
+ */
+
+#include <asm/genapic.h>
+
+#define INT_DELIVERY_MODE (genapic->int_delivery_mode)
+#define INT_DEST_MODE (genapic->int_dest_mode)
+#define INT_DELIVERY_DEST (genapic->int_delivery_dest)
+#define TARGET_CPUS	  (genapic->target_cpus())
+#define apic_id_registered (genapic->apic_id_registered)
+#define init_apic_ldr (genapic->init_apic_ldr)
+#define send_IPI_mask (genapic->send_IPI_mask)
+#define send_IPI_allbutself (genapic->send_IPI_allbutself)
+#define send_IPI_all (genapic->send_IPI_all)
+#define cpu_mask_to_apicid (genapic->cpu_mask_to_apicid)
+
+#endif /* __ASM_MACH_APIC_H */
diff -puN include/asm-x86_64/mpspec.h~x86-64-clustered-apic-support include/asm-x86_64/mpspec.h
--- 25/include/asm-x86_64/mpspec.h~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/include/asm-x86_64/mpspec.h	Thu Sep 30 16:11:08 2004
@@ -14,9 +14,9 @@
 #define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')
 
 /*
- * a maximum of 16 APICs with the current APIC ID architecture.
+ * A maximum of 255 APICs with the current APIC ID architecture.
  */
-#define MAX_APICS 16
+#define MAX_APICS 128
 
 struct intel_mp_floating
 {
diff -puN include/asm-x86_64/msi.h~x86-64-clustered-apic-support include/asm-x86_64/msi.h
--- 25/include/asm-x86_64/msi.h~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/include/asm-x86_64/msi.h	Thu Sep 30 16:11:08 2004
@@ -7,6 +7,7 @@
 #define ASM_MSI_H
 
 #include <asm/desc.h>
+#include <asm/mach_apic.h>
 
 #define LAST_DEVICE_VECTOR		232
 #define MSI_DEST_MODE			MSI_LOGICAL_MODE
diff -puN include/asm-x86_64/smp.h~x86-64-clustered-apic-support include/asm-x86_64/smp.h
--- 25/include/asm-x86_64/smp.h~x86-64-clustered-apic-support	Thu Sep 30 16:11:08 2004
+++ 25-akpm/include/asm-x86_64/smp.h	Thu Sep 30 16:11:08 2004
@@ -48,7 +48,7 @@ extern void (*mtrr_hook) (void);
 extern void zap_low_mappings(void);
 void smp_stop_cpu(void);
 extern cpumask_t cpu_sibling_map[NR_CPUS];
-extern char phys_proc_id[NR_CPUS];
+extern u8 phys_proc_id[NR_CPUS];
 
 #define SMP_TRAMPOLINE_BASE 0x6000
 
@@ -74,14 +74,29 @@ extern __inline int hard_smp_processor_i
 	return GET_APIC_ID(*(unsigned int *)(APIC_BASE+APIC_ID));
 }
 
+#define safe_smp_processor_id() (disable_apic ? 0 : x86_apicid_to_cpu(hard_smp_processor_id()))
+
+#endif /* !ASSEMBLY */
+
+#define NO_PROC_ID		0xFF		/* No processor magic marker */
+
+#endif
+
+#ifndef ASSEMBLY
 /*
  * Some lowlevel functions might want to know about
  * the real APIC ID <-> CPU # mapping.
- * AK: why is this volatile?
  */
-extern volatile char x86_cpu_to_apicid[NR_CPUS];
+extern u8 x86_cpu_to_apicid[NR_CPUS];	/* physical ID */
+extern u8 x86_cpu_to_log_apicid[NR_CPUS];
+extern u8 bios_cpu_apicid[];
+
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
+{
+	return cpus_addr(cpumask)[0];
+}
 
-static inline char x86_apicid_to_cpu(char apicid)
+static inline int x86_apicid_to_cpu(u8 apicid)
 {
 	int i;
 
@@ -92,10 +107,6 @@ static inline char x86_apicid_to_cpu(cha
 	return -1;
 }
 
-#define safe_smp_processor_id() (disable_apic ? 0 : x86_apicid_to_cpu(hard_smp_processor_id()))
-
-extern u8 bios_cpu_apicid[];
-
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < NR_CPUS)
@@ -103,20 +114,6 @@ static inline int cpu_present_to_apicid(
 	else
 		return BAD_APICID;
 }
-
-#endif /* !ASSEMBLY */
-
-#define NO_PROC_ID		0xFF		/* No processor magic marker */
-
-#endif
-#define INT_DELIVERY_MODE 1     /* logical delivery */
-#define TARGET_CPUS 1
-
-#ifndef ASSEMBLY
-static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
-{
-	return cpus_addr(cpumask)[0];
-}
 #endif
 
 #ifndef CONFIG_SMP
_

