Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWFITSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWFITSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWFITSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:18:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16269 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030260AbWFITSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:18:40 -0400
Date: Fri, 9 Jun 2006 12:18:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, npiggin@suse.de,
       ak@suse.de, hugh@veritas.com
Subject: Light weight counter 1/1 Framework
Message-ID: <Pine.LNX.4.64.0606091216320.1174@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The remaining counters in page_state after the zoned VM counter patch has been
applied are all just for show in /proc/vmstat. They have no essential function
for the VM and therefore maybe we can make these counters lightweight by making
them per cpu and ignoring races. We can then get away without disabling 
interrupts for these counters.

The patchset also adds an off switch for embedded systems that allows a building
of linux kernels without these counters.

This may be one case in which perhaps Andi's local_t can come into play to
avoid per cpu races on x86_64 and i386 in a light weight way. However, for
all other platforms we would not want the fallback to an atomic
type.

The implementation of these counters is through inline code that typically
results in a simple increment of a global memory locations.

Also
- Rename page_state to event_state
- Make event state an array indexed by the event item like the zoned counters.

Caveat: If use space tools rely on these counters being accurate on SMP and UP
then this wont work.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/init/Kconfig
===================================================================
--- linux-2.6.17-rc6-mm1.orig/init/Kconfig	2006-06-08 15:20:11.226963282 -0700
+++ linux-2.6.17-rc6-mm1/init/Kconfig	2006-06-09 12:07:56.893459696 -0700
@@ -446,6 +446,15 @@ config SLOB
 	default !SLAB
 	bool
 
+config VM_EVENT_COUNTERS
+	default y
+	bool "Enable event counters for /proc/vmstat" if EMBEDDED
+	help
+	  Event counters are only needed to display statistics. They
+	  have no function for the kernel itself. This option allows
+	  the disabling of the event counters. /proc/vmstat will only
+	  contain essential counters.
+
 menu "Loadable module support"
 
 config MODULES
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-09 12:00:00.272620254 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-09 12:07:56.895412700 -0700
@@ -1582,79 +1582,50 @@ static void show_node(struct zone *zone)
 #define show_node(zone)	do { } while (0)
 #endif
 
-/*
- * Accumulate the page_state information across all CPUs.
- * The result is unavoidably approximate - it can change
- * during and after execution of this function.
- */
-static DEFINE_PER_CPU(struct page_state, page_states) = {0};
+#ifdef CONFIG_VM_EVENT_COUNTERS
+DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};
 
-static void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
+void sum_vm_events(unsigned long *ret, cpumask_t *cpumask)
 {
-	unsigned cpu;
+	int cpu = 0;
+	int i;
 
-	memset(ret, 0, nr * sizeof(unsigned long));
-	cpus_and(*cpumask, *cpumask, cpu_online_map);
+	memset(ret, 0, NR_VM_EVENT_ITEMS * sizeof(unsigned long));
 
-	for_each_cpu_mask(cpu, *cpumask) {
-		unsigned long *in;
-		unsigned long *out;
-		unsigned off;
-		unsigned next_cpu;
+	cpu = first_cpu(*cpumask);
+	while (cpu < NR_CPUS) {
+		struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
 
-		in = (unsigned long *)&per_cpu(page_states, cpu);
+		cpu = next_cpu(cpu, *cpumask);
 
-		next_cpu = next_cpu(cpu, *cpumask);
-		if (likely(next_cpu < NR_CPUS))
-			prefetch(&per_cpu(page_states, next_cpu));
+		if (cpu < NR_CPUS)
+			prefetch(&per_cpu(vm_event_states, cpu));
 
-		out = (unsigned long *)ret;
-		for (off = 0; off < nr; off++)
-			*out++ += *in++;
+
+		for (i=0; i< NR_VM_EVENT_ITEMS; i++)
+			ret[i] += this->event[i];
 	}
 }
+EXPORT_SYMBOL(sum_vm_events);
 
-void get_full_page_state(struct page_state *ret)
+void all_vm_events(unsigned long *ret)
 {
-	cpumask_t mask = CPU_MASK_ALL;
-
-	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long), &mask);
+	sum_vm_events(ret, &cpu_online_map);
 }
+EXPORT_SYMBOL(all_vm_events);
 
-unsigned long read_page_state_offset(unsigned long offset)
+unsigned long get_global_vm_events(enum vm_event_item e)
 {
 	unsigned long ret = 0;
 	int cpu;
 
-	for_each_online_cpu(cpu) {
-		unsigned long in;
+	for_each_possible_cpu(cpu)
+		ret += per_cpu(vm_event_states, cpu).event[e];
 
-		in = (unsigned long)&per_cpu(page_states, cpu) + offset;
-		ret += *((unsigned long *)in);
-	}
 	return ret;
 }
-
-void __mod_page_state_offset(unsigned long offset, unsigned long delta)
-{
-	void *ptr;
-
-	ptr = &__get_cpu_var(page_states);
-	*(unsigned long *)(ptr + offset) += delta;
-}
-EXPORT_SYMBOL(__mod_page_state_offset);
-
-void mod_page_state_offset(unsigned long offset, unsigned long delta)
-{
-	unsigned long flags;
-	void *ptr;
-
-	local_irq_save(flags);
-	ptr = &__get_cpu_var(page_states);
-	*(unsigned long *)(ptr + offset) += delta;
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(mod_page_state_offset);
+EXPORT_SYMBOL(get_global_vm_events);
+#endif
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
@@ -2792,7 +2763,7 @@ static char *vmstat_text[] = {
 	"nr_unstable",
 	"nr_bounce",
 
-	/* Page state */
+#ifdef CONFIG_VM_EVENT_COUNTERS
 	"pgpgin",
 	"pgpgout",
 	"pswpin",
@@ -2838,28 +2809,36 @@ static char *vmstat_text[] = {
 	"allocstall",
 
 	"pgrotated"
+#endif
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
 {
 	unsigned long *v;
-	struct page_state *ps;
+#ifdef CONFIG_VM_EVENT_COUNTERS
+	unsigned long *e;
+#endif
 	int i;
 
 	if (*pos >= ARRAY_SIZE(vmstat_text))
 		return NULL;
-
+#ifdef CONFIG_VM_EVENT_COUNTERS
 	v = kmalloc(NR_STAT_ITEMS * sizeof(unsigned long)
-			+ sizeof(struct page_state), GFP_KERNEL);
+			+ sizeof(struct vm_event_state), GFP_KERNEL);
+#else
+	v = kmalloc(NR_STAT_ITEMS * sizeof(unsigned long), GFP_KERNEL);
+#endif
 	m->private = v;
 	if (!v)
 		return ERR_PTR(-ENOMEM);
 	for (i = 0; i < NR_STAT_ITEMS; i++)
 		v[i] = global_page_state(i);
-	ps = (struct page_state *)(v + NR_STAT_ITEMS);
-	get_full_page_state(ps);
-	ps->pgpgin /= 2;		/* sectors -> kbytes */
-	ps->pgpgout /= 2;
+#ifdef CONFIG_VM_EVENT_COUNTERS
+	e = v + NR_STAT_ITEMS;
+	all_vm_events(e);
+	e[PGPGIN] /= 2;		/* sectors -> kbytes */
+	e[PGPGOUT] /= 2;
+#endif
 	return v + *pos;
 }
 
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-09 11:47:36.275737668 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-09 12:07:56.896389202 -0700
@@ -104,121 +104,70 @@
 #define PG_uncached		31	/* Page has been mapped as uncached */
 #endif
 
+#ifdef CONFIG_VM_EVENT_COUNTERS
 /*
- * Global page accounting.  One instance per CPU.  Only unsigned longs are
- * allowed.
+ * Light weight per cpu counter implementation.
  *
- * - Fields can be modified with xxx_page_state and xxx_page_state_zone at
- * any time safely (which protects the instance from modification by
- * interrupt.
- * - The __xxx_page_state variants can be used safely when interrupts are
- * disabled.
- * - The __xxx_page_state variants can be used if the field is only
- * modified from process context and protected from preemption, or only
- * modified from interrupt context.  In this case, the field should be
- * commented here.
+ * Note that these can race. We do not bother to enable preemption
+ * or care about interrupt races. All we care about is to have some
+ * approximate count of events.
+ *
+ * Counters should only be incremented and no critical kernel component
+ * should rely on the counter values.
+ *
+ * Counters are handled completely inline. On many platforms the code
+ * generated will simply be the increment of a global address.
  */
-struct page_state {
-	/*
-	 * The below are zeroed by get_page_state().  Use get_full_page_state()
-	 * to add up all these.
-	 */
-	unsigned long pgpgin;		/* Disk reads */
-	unsigned long pgpgout;		/* Disk writes */
-	unsigned long pswpin;		/* swap reads */
-	unsigned long pswpout;		/* swap writes */
-
-	unsigned long pgalloc_high;	/* page allocations */
-	unsigned long pgalloc_normal;
-	unsigned long pgalloc_dma32;
-	unsigned long pgalloc_dma;
-
-	unsigned long pgfree;		/* page freeings */
-	unsigned long pgactivate;	/* pages moved inactive->active */
-	unsigned long pgdeactivate;	/* pages moved active->inactive */
-
-	unsigned long pgfault;		/* faults (major+minor) */
-	unsigned long pgmajfault;	/* faults (major only) */
-
-	unsigned long pgrefill_high;	/* inspected in refill_inactive_zone */
-	unsigned long pgrefill_normal;
-	unsigned long pgrefill_dma32;
-	unsigned long pgrefill_dma;
-
-	unsigned long pgsteal_high;	/* total highmem pages reclaimed */
-	unsigned long pgsteal_normal;
-	unsigned long pgsteal_dma32;
-	unsigned long pgsteal_dma;
-
-	unsigned long pgscan_kswapd_high;/* total highmem pages scanned */
-	unsigned long pgscan_kswapd_normal;
-	unsigned long pgscan_kswapd_dma32;
-	unsigned long pgscan_kswapd_dma;
-
-	unsigned long pgscan_direct_high;/* total highmem pages scanned */
-	unsigned long pgscan_direct_normal;
-	unsigned long pgscan_direct_dma32;
-	unsigned long pgscan_direct_dma;
-
-	unsigned long pginodesteal;	/* pages reclaimed via inode freeing */
-	unsigned long slabs_scanned;	/* slab objects scanned */
-	unsigned long kswapd_steal;	/* pages reclaimed by kswapd */
-	unsigned long kswapd_inodesteal;/* reclaimed via kswapd inode freeing */
-	unsigned long pageoutrun;	/* kswapd's calls to page reclaim */
-	unsigned long allocstall;	/* direct reclaim calls */
+#define FOR_ALL_ZONES(x) x##_DMA, x##_DMA32, x##_NORMAL, x##_HIGH
 
-	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
+enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
+		FOR_ALL_ZONES(PGALLOC),
+		PGFREE, PGACTIVATE, PGDEACTIVATE,
+		PGFAULT, PGMAJFAULT,
+ 		FOR_ALL_ZONES(PGREFILL),
+ 		FOR_ALL_ZONES(PGSTEAL),
+		FOR_ALL_ZONES(PGSCAN_KSWAPD),
+		FOR_ALL_ZONES(PGSCAN_DIRECT),
+		PGINODESTEAL, SLABS_SCANNED, KSWAPD_STEAL, KSWAPD_INODESTEAL,
+		PAGEOUTRUN, ALLOCSTALL, PGROTATED,
+		NR_VM_EVENT_ITEMS
 };
 
-extern void get_full_page_state(struct page_state *ret);
-extern unsigned long read_page_state_offset(unsigned long offset);
-extern void mod_page_state_offset(unsigned long offset, unsigned long delta);
-extern void __mod_page_state_offset(unsigned long offset, unsigned long delta);
-
-#define read_page_state(member) \
-	read_page_state_offset(offsetof(struct page_state, member))
-
-#define mod_page_state(member, delta)	\
-	mod_page_state_offset(offsetof(struct page_state, member), (delta))
-
-#define __mod_page_state(member, delta)	\
-	__mod_page_state_offset(offsetof(struct page_state, member), (delta))
-
-#define inc_page_state(member)		mod_page_state(member, 1UL)
-#define dec_page_state(member)		mod_page_state(member, 0UL - 1)
-#define add_page_state(member,delta)	mod_page_state(member, (delta))
-#define sub_page_state(member,delta)	mod_page_state(member, 0UL - (delta))
-
-#define __inc_page_state(member)	__mod_page_state(member, 1UL)
-#define __dec_page_state(member)	__mod_page_state(member, 0UL - 1)
-#define __add_page_state(member,delta)	__mod_page_state(member, (delta))
-#define __sub_page_state(member,delta)	__mod_page_state(member, 0UL - (delta))
-
-#define page_state(member) (*__page_state(offsetof(struct page_state, member)))
-
-#define state_zone_offset(zone, member)					\
-({									\
-	unsigned offset;						\
-	if (is_highmem(zone))						\
-		offset = offsetof(struct page_state, member##_high);	\
-	else if (is_normal(zone))					\
-		offset = offsetof(struct page_state, member##_normal);	\
-	else if (is_dma32(zone))					\
-		offset = offsetof(struct page_state, member##_dma32);	\
-	else								\
-		offset = offsetof(struct page_state, member##_dma);	\
-	offset;								\
-})
-
-#define __mod_page_state_zone(zone, member, delta)			\
- do {									\
-	__mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
- } while (0)
-
-#define mod_page_state_zone(zone, member, delta)			\
- do {									\
-	mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
- } while (0)
+struct vm_event_state {
+	unsigned long event[NR_VM_EVENT_ITEMS];
+};
+
+DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
+
+extern unsigned long get_global_vm_events(enum vm_event_item e);
+extern void sum_vm_events(unsigned long *r, cpumask_t *cpumask);
+extern void all_vm_events(unsigned long *r);
+
+static inline unsigned long get_cpu_vm_events(enum vm_event_item item)
+{
+	return __get_cpu_var(vm_event_states).event[item];
+}
+
+static inline void count_vm_event(enum vm_event_item item)
+{
+	__get_cpu_var(vm_event_states).event[item]++;
+}
+
+static inline void count_vm_events(enum vm_event_item item, long delta)
+{
+	__get_cpu_var(vm_event_states).event[item] += delta;
+}
+
+#else
+/* Disable counters */
+#define get_cpu_vm_events(e)	0L
+#define get_global_vm_events(e)	0L
+#define count_vm_event(e)	do { } while (0)
+#define count_vm_events(e,d)	do { } while (0)
+#endif
+
+#define count_zone_vm_event(item, zone) count_vm_event(item##_DMA + zone_idx(zone))
+#define count_zone_vm_events(item, zone, delta) count_vm_events(item##_DMA + zone_idx(zone), delta)
 
 /*
  * Zone based accounting with per cpu differentials.
