Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbTATTIz>; Mon, 20 Jan 2003 14:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTATTIz>; Mon, 20 Jan 2003 14:08:55 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:45495 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266733AbTATTIv>;
	Mon, 20 Jan 2003 14:08:51 -0500
From: Andrew Theurer <habanero@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [patch] sched-2.5.59-A2
Date: Mon, 20 Jan 2003 13:13:39 -0600
User-Agent: KMail/1.4.3
Cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>
References: <Pine.LNX.4.44.0301201817220.12564-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301201817220.12564-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RE11RXGJ72UQE87J3V19"
Message-Id: <200301201313.39621.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_RE11RXGJ72UQE87J3V19
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > I think the large PPC64 boxes have multilevel NUMA as well - two real
> > phys cores on one die, sharing some cache (L2 but not L1? Anton?). An=
d
> > SGI have multilevel nodes too I think ... so we'll still need multile=
vel
> > NUMA at some point ... but maybe not right now.
>
> Intel's HT is the cleanest case: pure logical cores, which clearly need
> special handling. Whether the other SMT solutions want to be handled vi=
a
> the logical-cores code or via another level of NUMA-balancing code,
> depends on benchmarking results i suspect. It will be one more flexibil=
ity
> that system maintainers will have, it's all set up via the
> sched_map_runqueue(cpu1, cpu2) boot-time call that 'merges' a CPU's
> runqueue into another CPU's runqueue. It's basically the 0th level of
> balancing, which will be fundamentally different. The other levels of
> balancing are (or should be) similar to each other - only differing in
> weight of balancing, not differing in the actual algorithm.

I have included a very rough patch to do ht-numa topology.  I requires to=
=20
manually define CONFIG_NUMA and CONFIG_NUMA_SCHED.  It also uses num_cpun=
odes=20
instead of numnodes and defines MAX_NUM_NODES to 8 if CONFIG_NUMA is defi=
ned. =20

I had to remove the first check in sched_best_cpu() to get decent low loa=
d=20
performance out of this.  I am still sorting through some things, but I=20
though it would be best if I just post what I have now.

-Andrew Theurer


--------------Boundary-00=_RE11RXGJ72UQE87J3V19
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-htnuma-topology"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-htnuma-topology"

diff -Naur linux-2.5.59-clean/arch/i386/kernel/smpboot.c linux-2.5.59-A2-HT-clean/arch/i386/kernel/smpboot.c
--- linux-2.5.59-clean/arch/i386/kernel/smpboot.c	2003-01-16 20:22:09.000000000 -0600
+++ linux-2.5.59-A2-HT-clean/arch/i386/kernel/smpboot.c	2003-01-17 15:36:38.000000000 -0600
@@ -61,6 +61,7 @@
 int smp_num_siblings = 1;
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
+int num_cpunodes = 0;
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
 
@@ -510,6 +511,10 @@
 static inline void map_cpu_to_node(int cpu, int node)
 {
 	printk("Mapping cpu %d to node %d\n", cpu, node);
+	if (!node_2_cpu_mask[node]) {
+		num_cpunodes++;
+		printk("nodecount is now %i\n", num_cpunodes);
+	}
 	node_2_cpu_mask[node] |= (1 << cpu);
 	cpu_2_node[cpu] = node;
 }
@@ -522,7 +527,11 @@
 	printk("Unmapping cpu %d from all nodes\n", cpu);
 	for (node = 0; node < MAX_NR_NODES; node ++)
 		node_2_cpu_mask[node] &= ~(1 << cpu);
-	cpu_2_node[cpu] = -1;
+	node = cpu_2_node[cpu];
+	if (node_2_cpu_mask[node])
+		num_cpunodes--;
+	cpu_2_node[node] = -1;
+	
 }
 #else /* !CONFIG_NUMA */
 
@@ -540,6 +549,9 @@
 
 	cpu_2_logical_apicid[cpu] = apicid;
 	map_cpu_to_node(cpu, apicid_to_node(apicid));
+	printk("cpu[%i]\tapicid[%i]\tnode[%i]\n", cpu, apicid, 
+			apicid_to_node(apicid));
+	printk("MAXNUMNODES[%i]\n", MAX_NUMNODES);
 }
 
 void unmap_cpu_to_logical_apicid(int cpu)
diff -Naur linux-2.5.59-clean/arch/i386/mach-default/topology.c linux-2.5.59-A2-HT-clean/arch/i386/mach-default/topology.c
--- linux-2.5.59-clean/arch/i386/mach-default/topology.c	2003-01-16 20:22:40.000000000 -0600
+++ linux-2.5.59-A2-HT-clean/arch/i386/mach-default/topology.c	2003-01-17 15:10:41.000000000 -0600
@@ -44,11 +44,11 @@
 	int i;
 
 	for (i = 0; i < num_online_nodes(); i++)
-		arch_register_node(i);
+//		arch_register_node(i);
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpu_possible(i)) arch_register_cpu(i);
 	for (i = 0; i < num_online_memblks(); i++)
-		arch_register_memblk(i);
+//		arch_register_memblk(i);
 	return 0;
 }
 
diff -Naur linux-2.5.59-clean/drivers/base/Makefile linux-2.5.59-A2-HT-clean/drivers/base/Makefile
--- linux-2.5.59-clean/drivers/base/Makefile	2003-01-16 20:22:30.000000000 -0600
+++ linux-2.5.59-A2-HT-clean/drivers/base/Makefile	2003-01-17 15:10:14.000000000 -0600
@@ -2,7 +2,7 @@
 
 obj-y		:= core.o sys.o interface.o power.o bus.o \
 			driver.o class.o intf.o platform.o \
-			cpu.o firmware.o
+			cpu.o firmware.o 
 
 obj-$(CONFIG_NUMA)	+= node.o  memblk.o
 
diff -Naur linux-2.5.59-clean/include/asm-i386/mach-default/mach_apic.h linux-2.5.59-A2-HT-clean/include/asm-i386/mach-default/mach_apic.h
--- linux-2.5.59-clean/include/asm-i386/mach-default/mach_apic.h	2003-01-16 20:22:59.000000000 -0600
+++ linux-2.5.59-A2-HT-clean/include/asm-i386/mach-default/mach_apic.h	2003-01-17 10:43:22.000000000 -0600
@@ -60,7 +60,15 @@
 
 static inline int apicid_to_node(int logical_apicid)
 {
-	return 0;
+	int node = 0;
+
+	logical_apicid >>= 2;
+
+	while(logical_apicid) {
+		logical_apicid >>= 2;
+		node++;
+	}
+	return node;
 }
 
 /* Mapping from cpu number to logical apicid */
diff -Naur linux-2.5.59-clean/include/asm-i386/numnodes.h linux-2.5.59-A2-HT-clean/include/asm-i386/numnodes.h
--- linux-2.5.59-clean/include/asm-i386/numnodes.h	2003-01-16 20:21:41.000000000 -0600
+++ linux-2.5.59-A2-HT-clean/include/asm-i386/numnodes.h	2003-01-17 10:07:38.000000000 -0600
@@ -6,7 +6,7 @@
 #ifdef CONFIG_X86_NUMAQ
 #include <asm/numaq.h>
 #else
-#define MAX_NUMNODES	1
+#define MAX_NUMNODES	8
 #endif /* CONFIG_X86_NUMAQ */
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Naur linux-2.5.59-clean/include/linux/mmzone.h linux-2.5.59-A2-HT-clean/include/linux/mmzone.h
--- linux-2.5.59-clean/include/linux/mmzone.h	2003-01-17 09:22:22.000000000 -0600
+++ linux-2.5.59-A2-HT-clean/include/linux/mmzone.h	2003-01-17 15:31:12.000000000 -0600
@@ -11,12 +11,13 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <asm/atomic.h>
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
 #include <asm/numnodes.h>
 #endif
 #ifndef MAX_NUMNODES
 #define MAX_NUMNODES 1
-#endif
+#endif 
+
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
@@ -191,6 +192,7 @@
 } pg_data_t;
 
 extern int numnodes;
+extern int num_cpunodes;
 extern struct pglist_data *pgdat_list;
 
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
diff -Naur linux-2.5.59-clean/kernel/sched.c linux-2.5.59-A2-HT-clean/kernel/sched.c
--- linux-2.5.59-clean/kernel/sched.c	2003-01-17 09:22:22.000000000 -0600
+++ linux-2.5.59-A2-HT-clean/kernel/sched.c	2003-01-17 17:36:18.000000000 -0600
@@ -705,7 +705,7 @@
 		return best_cpu;
 
 	minload = 10000000;
-	for (i = 0; i < numnodes; i++) {
+	for (i = 0; i < num_cpunodes; i++) {
 		load = atomic_read(&node_nr_running[i]);
 		if (load < minload) {
 			minload = load;
@@ -730,7 +730,7 @@
 {
 	int new_cpu;
 
-	if (numnodes > 1) {
+	if (num_cpunodes > 1) {
 		new_cpu = sched_best_cpu(current);
 		if (new_cpu != smp_processor_id())
 			sched_migrate_task(current, new_cpu);
@@ -750,7 +750,7 @@
 	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
 		+ atomic_read(&node_nr_running[this_node]);
 	this_rq()->prev_node_load[this_node] = this_load;
-	for (i = 0; i < numnodes; i++) {
+	for (i = 0; i < num_cpunodes; i++) {
 		if (i == this_node)
 			continue;
 		load = (this_rq()->prev_node_load[i] >> 1)

--------------Boundary-00=_RE11RXGJ72UQE87J3V19--

