Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVLTX5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVLTX5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVLTX5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:57:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:60840 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932219AbVLTX5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:57:48 -0500
Date: Tue, 20 Dec 2005 15:57:33 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC] Event counters [1/3]: Basic counter functionality
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Light weight counter functions

The remaining counters in page_state after the zoned VM counter patch has been
applied are all just for show in /proc/vmstat. They have no essential function
for the VM and therefore we can make these counters lightweight by ignoring
races and also allow an off switch for embedded systems that allows a building
of a linux kernels without these counters.

The implementation of these counters is through inline code that typically
results in a simple increment of a global memory locations.

Also
- Rename page_state to event_state
- Make event state an array indexed by the event item.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/init/Kconfig
===================================================================
--- linux-2.6.15-rc5-mm3.orig/init/Kconfig	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/init/Kconfig	2005-12-20 14:15:23.000000000 -0800
@@ -411,6 +411,15 @@ config SLAB
 	  SLOB is more space efficient but does not scale well and is
 	  more susceptible to fragmentation.
 
+config EVENT_COUNTERS
+	default y
+	bool "Enable event counters for /proc/vmstat" if EMBEDDED
+	help
+	  Event counters are only needed to display statistics. They
+	  have no function for the kernel itself. This option allows
+	  the disabling of the event counters. /proc/vmstat will only
+	  contain essential counters.
+
 config SERIAL_PCI
 	depends PCI && SERIAL_8250
 	default y
Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-20 13:15:45.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 14:55:00.000000000 -0800
@@ -77,120 +77,70 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#ifdef CONFIG_EVENT_COUNTERS
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
- * modified from process context, or only modified from interrupt context.
- * In this case, the field should be commented here.
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
+enum event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
+		FOR_ALL_ZONES(PGALLOC),
+		PGFREE, PGACTIVATE, PGDEACTIVATE,
+		PGFAULT, PGMAJFAULT,
+ 		FOR_ALL_ZONES(PGREFILL),
+ 		FOR_ALL_ZONES(PGSTEAL),
+		FOR_ALL_ZONES(PGSCAN_KSWAPD),
+		FOR_ALL_ZONES(PGSCAN_DIRECT),
+		PGINODESTEAL, SLABS_SCANNED, KSWAPD_STEAL, KSWAPD_INODESTEAL,
+		PAGEOUTRUN, ALLOCSTALL, PGROTATED,
+		NR_EVENT_ITEMS
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
+struct event_state {
+	unsigned long event[NR_EVENT_ITEMS];
+};
+
+DECLARE_PER_CPU(struct event_state, event_states);
+
+extern unsigned long get_global_events(enum event_item e);
+extern void sum_events(unsigned long *r, cpumask_t *cpumask);
+extern void all_events(unsigned long *r);
+
+static inline unsigned long get_cpu_events(enum event_item item)
+{
+	return __get_cpu_var(event_states).event[item];
+}
+
+static inline void count_event(enum event_item item)
+{
+	__get_cpu_var(event_states).event[item]++;
+}
+
+static inline void count_events(enum event_item item, long delta)
+{
+	__get_cpu_var(event_states).event[item] += delta;
+}
+
+#else
+/* Disable counters */
+#define get_cpu_events(e)	0L
+#define get_global_events(e)	0L
+#define count_event(e)		do { } while (0)
+#define count_events(e,d)	do { } while (0)
+#endif
+
+#define count_zone_event(item, zone) count_event(item##_DMA + zone_idx(zone))
+#define count_zone_events(item, zone, delta) count_events(item##_DMA + zone_idx(zone), delta)
 
 /*
  * Zone based accounting with per cpu differentials.
Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 14:14:33.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 15:46:46.000000000 -0800
@@ -1573,77 +1573,50 @@ static void show_node(struct zone *zone)
 #define show_node(zone)	do { } while (0)
 #endif
 
-/*
- * Accumulate the page_state information across all CPUs.
- * The result is unavoidably approximate - it can change
- * during and after execution of this function.
- */
-static DEFINE_PER_CPU(struct page_state, page_states) = {0};
+#ifdef CONFIG_EVENT_COUNTERS
+DEFINE_PER_CPU(struct event_state, event_states) = {{0}};
 
-static void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
+void sum_events(unsigned long *ret, cpumask_t *cpumask)
 {
 	int cpu = 0;
+	int i;
 
-	memset(ret, 0, sizeof(*ret));
+	memset(ret, 0, NR_EVENT_ITEMS * sizeof(unsigned long));
 
 	cpu = first_cpu(*cpumask);
 	while (cpu < NR_CPUS) {
-		unsigned long *in, *out, off;
-
-		in = (unsigned long *)&per_cpu(page_states, cpu);
+		struct event_state *this = &per_cpu(event_states, cpu);
 
 		cpu = next_cpu(cpu, *cpumask);
 
 		if (cpu < NR_CPUS)
-			prefetch(&per_cpu(page_states, cpu));
+			prefetch(&per_cpu(event_states, cpu));
+
 
-		out = (unsigned long *)ret;
-		for (off = 0; off < nr; off++)
-			*out++ += *in++;
+		for (i=0; i< NR_EVENT_ITEMS; i++)
+			ret[i] += this->event[i];
 	}
 }
+EXPORT_SYMBOL(sum_events);
 
-void get_full_page_state(struct page_state *ret)
+void all_events(unsigned long *ret)
 {
-	cpumask_t mask = CPU_MASK_ALL;
-
-	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long), &mask);
+	sum_events(ret, &cpu_online_map);
 }
+EXPORT_SYMBOL(all_events);
 
-unsigned long read_page_state_offset(unsigned long offset)
+unsigned long get_global_events(enum event_item e)
 {
 	unsigned long ret = 0;
 	int cpu;
 
-	for_each_cpu(cpu) {
-		unsigned long in;
+	for_each_cpu(cpu)
+		ret += per_cpu(event_states, cpu).event[e];
 
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
-	ptr = &__get_cpu_var(page_states);
-	local_irq_save(flags);
-	*(unsigned long *)(ptr + offset) += delta;
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(mod_page_state_offset);
+EXPORT_SYMBOL(get_global_events);
+#endif
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
@@ -2663,7 +2636,7 @@ static char *vmstat_text[] = {
 	"nr_unstable",
 	"nr_bounce",
 
-	/* Page state */
+#ifdef CONFIG_EVENT_COUNTERS
 	"pgpgin",
 	"pgpgout",
 	"pswpin",
@@ -2709,28 +2682,36 @@ static char *vmstat_text[] = {
 	"allocstall",
 
 	"pgrotated"
+#endif
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
 {
 	unsigned long *v;
-	struct page_state *ps;
+#ifdef CONFIG_EVENT_COUNTERS
+	unsigned long *e;
+#endif
 	int i;
 
 	if (*pos >= ARRAY_SIZE(vmstat_text))
 		return NULL;
-
+#ifdef CONFIG_EVENT_COUNTERS
 	v = kmalloc(NR_STAT_ITEMS * sizeof(unsigned long)
-			+ sizeof(struct page_state), GFP_KERNEL);
+			+ sizeof(struct event_state), GFP_KERNEL);
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
+#ifdef CONFIG_EVENT_COUNTERS
+	e = v + NR_STAT_ITEMS;
+	all_events(e);
+	e[PGPGIN] /= 2;		/* sectors -> kbytes */
+	e[PGPGOUT] /= 2;
+#endif
 	return v + *pos;
 }
 

