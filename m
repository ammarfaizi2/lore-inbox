Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWDLTWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWDLTWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 15:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWDLTWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 15:22:41 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:23487 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932106AbWDLTWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 15:22:40 -0400
Subject: [RFC] Making percpu module variables have their own memory.
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 15:22:19 -0400
Message-Id: <1144869739.26133.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone using the -rt patch found that one of the tracing options caused
the per_cpu memory of some modules to grow very large and the modules
failed to load due to inefficient space in the per_cpu area.  To fix
this the PERCPU_ENOUGH_ROOM had to be increased quite a bit.

Looking into this, I found that the method of using the per_cpu macros
for modules seems to waste a lot of space.  The vanilla kernel allocates
64K for every CPU to cover all the per_cpu variables used in the kernel
as well as all the modules that _might_ be loaded.  Even if you don't
load any modules that use per_cpu, this space is allocated if you have
loadable module support and SMP.

I thought that there should be a better way and started exploring it.

History:

In response to the -rt patch increase size of PERCPU_ENOUGH_ROOM I wrote
up the rational for per_cpu macros, and for those that don't already
know what the rational is, you can read my write up here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114480722127297&w=2

The kernel allocates space for modules to use for its per_cpu variables,
and this is because the per_cpu macro can't determine if the variable
was declared in a module or the kernel.  So the offset to find the space
the variable is actually at, needs to be the same for both the kernel
and the modules. Hence we allocate wasted space as a place holder for
modules.

So if we want modules to have their own allocation for their per_cpu
variables, we need to have the per_cpu macro distinguish the difference
between per_cpu variables declared as follows:

1. at kernel compile time (offset with __per_cpu_offset) and used in
   both the kernel and modules

2. per_cpu variables declared in a module and used in that module

3. and per_cpu variables declared in one module and used in another
   module.

So to solve the above problem, I added a new variable with the
declaration of the per_cpu macro, and this variable is placed in its own
section called .data.percpu_types.  The kernel defines this variable as
a pointer to a structure that is different than the modules declaration
of this variable.

   typedef struct { int module; } *percpu_module_t;
   typedef struct { int kernel; } *percpu_kernel_t;

   #ifdef MODULE
   # define PERCPU_TYPE percpu_module_t
   #else
   # define PERCPU_TYPE percpu_kernel_t
   #endif

   /* Separate out the type, so (int[3], foo) works. */
   #define DEFINE_PER_CPU(type, name) \
       __attribute__((__section__(".data.percpu_type"))) PERCPU_TYPE per_cpu_type__##name; \
       __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name


Here the per_cpu_type__##name is defined and placed in
the .data.percpu_type section.  When some code is compiled as a module
(MODULE defined) then the type of the per_cpu_type__##name is of type
percpu_module_t, otherwise it is of type percpu_kernel_t.

Now that there are variables with two different types, the per_cpu macro
has something to compare to determine if the variable belongs to the
kernel or a module.

#define per_cpu(var, cpu)			\
	__builtin_choose_expr ( \
		PERCPU_TYPE_EQUAL(per_cpu_type__##var, percpu_kernel_t),	\
			per_cpu_kernel(var, cpu), \
	__builtin_choose_expr ( \
		PERCPU_TYPE_EQUAL(per_cpu_type__##var, percpu_kernel_t[]),	\
			per_cpu_kernel(var, cpu), \
	__builtin_choose_expr( \
		PERCPU_TYPE_EQUAL(per_cpu_type__##var, percpu_module_t),	\
			per_cpu_module(var, cpu),				\
	__builtin_choose_expr( \
		PERCPU_TYPE_EQUAL(per_cpu_type__##var, percpu_module_t[]),	\
			per_cpu_module(var, cpu),				\
		(void)0))))


With per_cpu_kernel defined as the old per_cpu macro:

  #define per_cpu_kernel(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))

And the per_cpu_module defined as follows:

  #define per_cpu_module(var, cpu) \
	(*RELOC_HIDE(&per_cpu__##var, ((unsigned long *)per_cpu_type__##var)[cpu]))



At first this seems to waste more space in the kernel, since I've added
a per_cpu_type__##name variable for all per_cpu__##name variables.  But
since the variable for the kernel is never actually used, and is only
used to distinguish types, I placed the type variable in its own section
and placed that section in the init_data section.  So it is freed along
with the init_data.  I first tried to put it in the discard section, but
since the type variables also need to be exported for modules to have
this work, I got an error that an exported symbol was put in the discard
section.  So to I had to use the init data instead.  Hopefully this is
OK.

As for modules, I still need to save a variable for where to find the
offset to.  And since one module can be using a per_cpu variable that
was declared in another module, I need to know where to find that data.
So the per_cpu_type__##name is now used for modules to store the offset
to where the per_cpu__##name variable is stored.

Now this part, I'm a little leery on.  Since I do need to add one
variable for every instance of a per_cpu variable in a module. But I'm
not too upset by it.  Since this method still saves all the space that
was wasted in the anticipating what per_cpu modules are going to be
loaded.  As well as, this extra variable section is only created once,
even if there are 64 CPUs.  The .data.percpu_type section is loaded with
a pointer (one per variable) to the actual offset. So the offset itself
is also only allocate once per module.  Just a pointer to the offset is
made per per_cpu variable of a module.


Conclusion:

I have a strong belief (haven't actually went over the numbers yet, but
maybe someone can help me here) that this method can save a bit of
wasted memory.  The kernel no longer needs a PERCPU_ENOUGH_ROOM variable
to store extra room for a modules per_cpu variables that _might_ get
loaded.  Only the modules that use per_cpu variables will allocate this
when needed.

PATCH:

Below is a patch against 2.6.16-rt16 and only for the intel platform.
This was just a proof in concept patch (otherwise the subject above
would have had [PATCH]).  There's still some debug stuff in the patch
and it needs to be cleaned up, not to mention ported to all archs (only
the vmlinux.lds.S and for a few archs that have it's own per_cpu.h need
to be changed).

I've applied this patch already and ran some initial tests.  It seems to
work so far.

So please send back feed back. If this looks like a good idea to
continue, I'll clean it up, port it and send out a patch for 2.6.17-mm.

Credit:  Some of my ideas for this came from looking at Ingo Molnar's
         -rt spin_lock macro implementation.

-- Steve

Index: linux-2.6.16-rt16/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.16-rt16.orig/include/asm-generic/percpu.h	2006-04-11 22:22:42.000000000 -0400
+++ linux-2.6.16-rt16/include/asm-generic/percpu.h	2006-04-12 12:15:36.000000000 -0400
@@ -7,15 +7,52 @@
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
+typedef struct { int module; } *percpu_module_t;
+typedef struct { int kernel; } *percpu_kernel_t;
+
+#ifdef MODULE
+# define PERCPU_TYPE percpu_module_t
+#else
+# define PERCPU_TYPE percpu_kernel_t
+#endif
+
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu_type"))) PERCPU_TYPE per_cpu_type__##name; \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
+
 #define DEFINE_PER_CPU_LOCKED(type, name) \
+    __attribute__((__section__(".data.percpu_type"))) PERCPU_TYPE per_cpu_type__##name; \
     __attribute__((__section__(".data.percpu"))) spinlock_t per_cpu_lock__##name##_locked = SPIN_LOCK_UNLOCKED; \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name##_locked
 
+#undef PERCPU_TYPE_EQUAL
+#define PERCPU_TYPE_EQUAL(var, type) \
+		__builtin_types_compatible_p(typeof(var), type)
+
+#define per_cpu_module(var, cpu) \
+	(*RELOC_HIDE(&per_cpu__##var, ((unsigned long *)per_cpu_type__##var)[cpu]))
+
+#define per_cpu(var, cpu)			\
+	__builtin_choose_expr ( \
+		PERCPU_TYPE_EQUAL(per_cpu_type__##var, percpu_kernel_t),	\
+			per_cpu_kernel(var, cpu), \
+	__builtin_choose_expr ( \
+		PERCPU_TYPE_EQUAL(per_cpu_type__##var, percpu_kernel_t[]),	\
+			per_cpu_kernel(var, cpu), \
+	__builtin_choose_expr( \
+		PERCPU_TYPE_EQUAL(per_cpu_type__##var, percpu_module_t),	\
+			per_cpu_module(var, cpu),				\
+	__builtin_choose_expr( \
+		PERCPU_TYPE_EQUAL(per_cpu_type__##var, percpu_module_t[]),	\
+			per_cpu_module(var, cpu),				\
+		(void)0))))
+
+// per_cpu_kernel(var, cpu)))))
+
+
 /* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
+#define per_cpu_kernel(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
 #define per_cpu_lock(var, cpu) \
@@ -27,15 +64,19 @@ extern unsigned long __per_cpu_offset[NR
 #define __get_cpu_var_locked(var, cpu) \
 		per_cpu_var_locked(var, cpu)
 
-/* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size)			\
-do {								\
-	unsigned int __i;					\
-	for (__i = 0; __i < NR_CPUS; __i++)			\
-		if (cpu_possible(__i))				\
-			memcpy((pcpudst)+__per_cpu_offset[__i],	\
-			       (src), (size));			\
-} while (0)
+#define DECLARE_PER_CPU(type, name)			\
+	extern __typeof__(type) per_cpu__##name;	\
+	extern PERCPU_TYPE per_cpu_type__##name
+#define DECLARE_PER_CPU_LOCKED(type, name)			\
+	extern spinlock_t per_cpu_lock__##name##_locked;	\
+	extern __typeof__(type) per_cpu__##name##_locked;	\
+	extern PERCPU_TYPE per_cpu_type__##name
+
+# define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var); EXPORT_SYMBOL(per_cpu_type__##var)
+# define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var); EXPORT_SYMBOL_GPL(per_cpu_type__##var)
+# define EXPORT_PER_CPU_LOCKED_SYMBOL(var) EXPORT_SYMBOL(per_cpu_lock__##var##_locked); EXPORT_SYMBOL(per_cpu__##var##_locked); EXPORT_SYMBOL(per_cpu_type__##var)
+# define EXPORT_PER_CPU_LOCKED_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu_lock__##var##_locked); EXPORT_SYMBOL_GPL(per_cpu__##var##_locked); EXPORT_SYMBOL_GPL(per_cpu_type__##var)
+
 #else /* ! SMP */
 
 #define DEFINE_PER_CPU(type, name) \
@@ -50,8 +91,6 @@ do {								\
 #define __get_cpu_lock(var, cpu)		per_cpu_lock__##var##_locked
 #define __get_cpu_var_locked(var, cpu)		per_cpu__##var##_locked
 
-#endif	/* SMP */
-
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
 #define DECLARE_PER_CPU_LOCKED(type, name) \
     extern spinlock_t per_cpu_lock__##name##_locked; \
@@ -62,4 +101,6 @@ do {								\
 #define EXPORT_PER_CPU_LOCKED_SYMBOL(var) EXPORT_SYMBOL(per_cpu_lock__##var##_locked); EXPORT_SYMBOL(per_cpu__##var##_locked)
 #define EXPORT_PER_CPU_LOCKED_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu_lock__##var##_locked); EXPORT_SYMBOL_GPL(per_cpu__##var##_locked)
 
+#endif	/* SMP */
+
 #endif /* _ASM_GENERIC_PERCPU_H_ */
Index: linux-2.6.16-rt16/kernel/softirq.c
===================================================================
--- linux-2.6.16-rt16.orig/kernel/softirq.c	2006-04-12 09:30:08.000000000 -0400
+++ linux-2.6.16-rt16/kernel/softirq.c	2006-04-12 09:31:14.000000000 -0400
@@ -95,7 +95,7 @@ void wait_for_softirq(int softirq)
 static void wakeup_softirqd(int softirq)
 {
 	/* Interrupts are disabled: no need to stop preemption */
-	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);
+	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq]).tsk;
 
 	if (tsk && tsk->state != TASK_RUNNING)
 		wake_up_process(tsk);
@@ -104,7 +104,7 @@ static void wakeup_softirqd(int softirq)
 static void wakeup_softirqd_prio(int softirq, int prio)
 {
 	/* Interrupts are disabled: no need to stop preemption */
-	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);
+	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq]).tsk;
 
 	if (tsk) {
 		if (tsk->normal_prio != prio) {
@@ -735,8 +735,8 @@ static int __devinit cpu_callback(struct
 			BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
 		}
 		for (i = 0; i < MAX_SOFTIRQ; i++) {
-			per_cpu(ksoftirqd[i].nr, hotcpu) = i;
-			per_cpu(ksoftirqd[i].cpu, hotcpu) = hotcpu;
+			per_cpu(ksoftirqd[i], hotcpu).nr = i;
+			per_cpu(ksoftirqd[i], hotcpu).cpu = hotcpu;
 			p = kthread_create(ksoftirqd, &per_cpu(ksoftirqd[i], hotcpu),
 					   "softirq-%s/%d", softirq_names[i], hotcpu);
 			if (IS_ERR(p)) {
@@ -744,12 +744,12 @@ static int __devinit cpu_callback(struct
 				return NOTIFY_BAD;
 			}
 			kthread_bind(p, hotcpu);
-			per_cpu(ksoftirqd[i].tsk, hotcpu) = p;
+			per_cpu(ksoftirqd[i], hotcpu).tsk = p;
 		}
  		break;
 	case CPU_ONLINE:
 		for (i = 0; i < MAX_SOFTIRQ; i++)
-			wake_up_process(per_cpu(ksoftirqd[i].tsk, hotcpu));
+			wake_up_process(per_cpu(ksoftirqd[i], hotcpu).tsk);
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
Index: linux-2.6.16-rt16/mm/page-writeback.c
===================================================================
--- linux-2.6.16-rt16.orig/mm/page-writeback.c	2006-03-30 07:10:13.000000000 -0500
+++ linux-2.6.16-rt16/mm/page-writeback.c	2006-04-12 09:46:56.000000000 -0400
@@ -39,6 +39,8 @@
  */
 #define MAX_WRITEBACK_PAGES	1024
 
+DEFINE_PER_CPU(int, page_wb_ratelimits);
+
 /*
  * After a CPU has dirtied this many pages, balance_dirty_pages_ratelimited
  * will look to see if it needs to force writeback or throttling.
@@ -269,7 +271,6 @@ static void balance_dirty_pages(struct a
  */
 void balance_dirty_pages_ratelimited(struct address_space *mapping)
 {
-	static DEFINE_PER_CPU(int, ratelimits) = 0;
 	long ratelimit;
 
 	ratelimit = ratelimit_pages;
@@ -280,13 +281,13 @@ void balance_dirty_pages_ratelimited(str
 	 * Check the rate limiting. Also, we do not want to throttle real-time
 	 * tasks in balance_dirty_pages(). Period.
 	 */
-	if (get_cpu_var(ratelimits)++ >= ratelimit) {
-		__get_cpu_var(ratelimits) = 0;
-		put_cpu_var(ratelimits);
+	if (get_cpu_var(page_wb_ratelimits)++ >= ratelimit) {
+		__get_cpu_var(page_wb_ratelimits) = 0;
+		put_cpu_var(page_wb_ratelimits);
 		balance_dirty_pages(mapping);
 		return;
 	}
-	put_cpu_var(ratelimits);
+	put_cpu_var(page_wb_ratelimits);
 }
 EXPORT_SYMBOL(balance_dirty_pages_ratelimited);
 
Index: linux-2.6.16-rt16/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rt16.orig/mm/page_alloc.c	2006-04-11 22:22:42.000000000 -0400
+++ linux-2.6.16-rt16/mm/page_alloc.c	2006-04-12 09:45:13.000000000 -0400
@@ -1249,7 +1249,7 @@ static void show_node(struct zone *zone)
  * The result is unavoidably approximate - it can change
  * during and after execution of this function.
  */
-static DEFINE_PER_CPU_LOCKED(struct page_state, page_states);
+DEFINE_PER_CPU_LOCKED(struct page_state, page_states);
 
 atomic_t nr_pagecache = ATOMIC_INIT(0);
 EXPORT_SYMBOL(nr_pagecache);
Index: linux-2.6.16-rt16/mm/swap.c
===================================================================
--- linux-2.6.16-rt16.orig/mm/swap.c	2006-04-11 22:22:42.000000000 -0400
+++ linux-2.6.16-rt16/mm/swap.c	2006-04-12 09:47:43.000000000 -0400
@@ -136,8 +136,8 @@ EXPORT_SYMBOL(mark_page_accessed);
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
  */
-static DEFINE_PER_CPU_LOCKED(struct pagevec, lru_add_pvecs) = { 0, };
-static DEFINE_PER_CPU_LOCKED(struct pagevec, lru_add_active_pvecs) = { 0, };
+DEFINE_PER_CPU_LOCKED(struct pagevec, lru_add_pvecs) = { 0, };
+DEFINE_PER_CPU_LOCKED(struct pagevec, lru_add_active_pvecs) = { 0, };
 
 void fastcall lru_cache_add(struct page *page)
 {
Index: linux-2.6.16-rt16/include/linux/module.h
===================================================================
--- linux-2.6.16-rt16.orig/include/linux/module.h	2006-04-12 11:15:09.000000000 -0400
+++ linux-2.6.16-rt16/include/linux/module.h	2006-04-12 11:31:47.000000000 -0400
@@ -309,6 +309,7 @@ struct module
 
 	/* Per-cpu data. */
 	void *percpu;
+	unsigned long *percpu_offset;
 
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
Index: linux-2.6.16-rt16/init/main.c
===================================================================
--- linux-2.6.16-rt16.orig/init/main.c	2006-04-11 22:22:42.000000000 -0400
+++ linux-2.6.16-rt16/init/main.c	2006-04-12 10:18:34.000000000 -0400
@@ -339,10 +339,6 @@ static void __init setup_per_cpu_areas(v
 
 	/* Copy section for each CPU (we discard the original) */
 	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-#ifdef CONFIG_MODULES
-	if (size < PERCPU_ENOUGH_ROOM)
-		size = PERCPU_ENOUGH_ROOM;
-#endif
 
 	ptr = alloc_bootmem(size * NR_CPUS);
 
Index: linux-2.6.16-rt16/kernel/module.c
===================================================================
--- linux-2.6.16-rt16.orig/kernel/module.c	2006-03-30 07:10:13.000000000 -0500
+++ linux-2.6.16-rt16/kernel/module.c	2006-04-12 13:24:29.000000000 -0400
@@ -256,8 +256,6 @@ extern char __per_cpu_start[], __per_cpu
 static void *percpu_modalloc(unsigned long size, unsigned long align,
 			     const char *name)
 {
-	unsigned long extra;
-	unsigned int i;
 	void *ptr;
 
 	if (align > SMP_CACHE_BYTES) {
@@ -265,69 +263,80 @@ static void *percpu_modalloc(unsigned lo
 		       name, align, SMP_CACHE_BYTES);
 		align = SMP_CACHE_BYTES;
 	}
+	size = ALIGN(size, SMP_CACHE_BYTES);
 
-	ptr = __per_cpu_start;
-	for (i = 0; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
-		/* Extra for alignment requirement. */
-		extra = ALIGN((unsigned long)ptr, align) - (unsigned long)ptr;
-		BUG_ON(i == 0 && extra != 0);
+	ptr = kmalloc(size * NR_CPUS, GFP_KERNEL);
+	if (!ptr)
+		printk(KERN_WARNING "Could not allocate %lu bytes percpu data\n",
+		       size);
+	return ptr;
+}
+
+static void percpu_modfree(void *freeme, void *freemetoo)
+{
+	kfree(freeme);
+	kfree(freemetoo);
+}
+
+#if 0
+/* A macro to avoid #include hell... */
+#define percpu_modcopy(pcpudst, src, size)			\
+do {								\
+	unsigned int __i;					\
+	for (__i = 0; __i < NR_CPUS; __i++)			\
+		if (cpu_possible(__i))				\
+			memcpy((pcpudst)+__per_cpu_offset[__i],	\
+			       (src), (size));			\
+} while (0)
+#endif
 
-		if (pcpu_size[i] < 0 || pcpu_size[i] < extra + size)
-			continue;
+static void percpu_modcopy(void *pcpudst, const void *src,
+			   unsigned long size,
+			   unsigned long *per_cpu_offset)
+{
+	unsigned int i;
 
-		/* Transfer extra to previous block. */
-		if (pcpu_size[i-1] < 0)
-			pcpu_size[i-1] -= extra;
-		else
-			pcpu_size[i-1] += extra;
-		pcpu_size[i] -= extra;
-		ptr += extra;
-
-		/* Split block if warranted */
-		if (pcpu_size[i] - size > sizeof(unsigned long))
-			if (!split_block(i, size))
-				return NULL;
-
-		/* Mark allocated */
-		pcpu_size[i] = -pcpu_size[i];
-		return ptr;
-	}
+	if (!pcpudst)
+		return;
 
-	printk(KERN_WARNING "Could not allocate %lu bytes percpu data\n",
-	       size);
-	return NULL;
+	for (i=0; i < NR_CPUS; i++) {
+		if (cpu_possible(i))
+			memcpy(pcpudst + per_cpu_offset[i],
+			       src, size);
+	}
 }
 
-static void percpu_modfree(void *freeme)
+static void *percpu_type_setup(void *dest, void *percpu,
+			       unsigned long var_size,
+			       unsigned long sect_size)
 {
-	unsigned int i;
-	void *ptr = __per_cpu_start + block_size(pcpu_size[0]);
+	char *pptr = percpu;
+	char *percpu_start = percpu;
+	unsigned long *ptr = dest;
+	unsigned long *per_cpu_offset;
+	int i;
 
-	/* First entry is core kernel percpu data. */
-	for (i = 1; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
-		if (ptr == freeme) {
-			pcpu_size[i] = -pcpu_size[i];
-			goto free;
-		}
-	}
-	BUG();
+	/* make sure everything is smp cache aligned */
+	var_size = ALIGN(var_size, SMP_CACHE_BYTES);
 
- free:
-	/* Merge with previous? */
-	if (pcpu_size[i-1] >= 0) {
-		pcpu_size[i-1] += pcpu_size[i];
-		pcpu_num_used--;
-		memmove(&pcpu_size[i], &pcpu_size[i+1],
-			(pcpu_num_used - i) * sizeof(pcpu_size[0]));
-		i--;
-	}
-	/* Merge with next? */
-	if (i+1 < pcpu_num_used && pcpu_size[i+1] >= 0) {
-		pcpu_size[i] += pcpu_size[i+1];
-		pcpu_num_used--;
-		memmove(&pcpu_size[i+1], &pcpu_size[i+2],
-			(pcpu_num_used - (i+1)) * sizeof(pcpu_size[0]));
-	}
+	/* allocate the modules own per_cpu_offset pointer */
+	per_cpu_offset = kmalloc(sizeof(unsigned long) * NR_CPUS, GFP_KERNEL);
+	if (!per_cpu_offset)
+		return NULL;
+
+	/* Set the pointer to the index of each CPU area */
+	for (i = 0; i < NR_CPUS; i++, pptr += var_size)
+		per_cpu_offset[i] = pptr - percpu_start;
+
+	/*
+	 * Now copy this offset to all of the percpu_type pointers in the
+	 * percpu_type section. This is how the per_cpu variables can find
+	 * the offset into this section from the per_cpu macros.
+	 */
+	for (i=0; i < sect_size; i++, ptr++)
+		*ptr = (unsigned long)per_cpu_offset;
+
+	return per_cpu_offset;
 }
 
 static unsigned int find_pcpusec(Elf_Ehdr *hdr,
@@ -337,6 +346,13 @@ static unsigned int find_pcpusec(Elf_Ehd
 	return find_sec(hdr, sechdrs, secstrings, ".data.percpu");
 }
 
+static unsigned int find_pcputypesec(Elf_Ehdr *hdr,
+				     Elf_Shdr *sechdrs,
+				     const char *secstrings)
+{
+	return find_sec(hdr, sechdrs, secstrings, ".data.percpu_type");
+}
+
 static int percpu_modinit(void)
 {
 	pcpu_num_used = 2;
@@ -365,14 +381,29 @@ static inline void percpu_modfree(void *
 {
 	BUG();
 }
+
+static inline void *percpu_type_setup(void *dest, void *percpu,
+				      unsigned long var_size,
+				      unsigned long sect_size)
+{
+	return NULL;
+}
+
 static inline unsigned int find_pcpusec(Elf_Ehdr *hdr,
 					Elf_Shdr *sechdrs,
 					const char *secstrings)
 {
 	return 0;
 }
+static inline unsigned int find_pcputypesec(Elf_Ehdr *hdr,
+					    Elf_Shdr *sechdrs,
+					    const char *secstrings)
+{
+	return 0;
+}
 static inline void percpu_modcopy(void *pcpudst, const void *src,
-				  unsigned long size)
+				  unsigned long size,
+				  unsigned long *per_cpu_offset)
 {
 	/* pcpusec should be 0, and size of that section should be 0. */
 	BUG_ON(size != 0);
@@ -1181,7 +1212,7 @@ static void free_module(struct module *m
 	module_free(mod, mod->module_init);
 	kfree(mod->args);
 	if (mod->percpu)
-		percpu_modfree(mod->percpu);
+		percpu_modfree(mod->percpu, mod->percpu_offset);
 
 	/* Finally, free the core (containing the module structure) */
 	module_free(mod, mod->module_core);
@@ -1537,13 +1568,14 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex, pcpuindex;
+		crcindex, gplcrcindex, versindex, pcpuindex, pcputypeindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
 	struct exception_table_entry *extable;
 	mm_segment_t old_fs;
+	unsigned long *percpu_offset = NULL;
 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
 	       umod, len, uargs);
@@ -1626,6 +1658,7 @@ static struct module *load_module(void _
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
 	pcpuindex = find_pcpusec(hdr, sechdrs, secstrings);
+	pcputypeindex = find_pcputypesec(hdr, sechdrs, secstrings);
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1686,6 +1719,7 @@ static struct module *load_module(void _
 		goto free_mod;
 
 	if (pcpuindex) {
+		BUG_ON(!pcputypeindex);
 		/* We have a special allocation for this section. */
 		percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
 					 sechdrs[pcpuindex].sh_addralign,
@@ -1734,9 +1768,20 @@ static struct module *load_module(void _
 		else
 			dest = mod->module_core + sechdrs[i].sh_entsize;
 
-		if (sechdrs[i].sh_type != SHT_NOBITS)
-			memcpy(dest, (void *)sechdrs[i].sh_addr,
-			       sechdrs[i].sh_size);
+		if (sechdrs[i].sh_type != SHT_NOBITS) {
+			if (i && i == pcputypeindex) {
+				unsigned long *ret;
+				BUG_ON(!pcpuindex);
+				ret = percpu_type_setup(dest, mod->percpu,
+							sechdrs[pcpuindex].sh_size,
+							sechdrs[i].sh_size);
+				if (!ret)
+					goto cleanup; /* is this right? */
+				percpu_offset = ret;
+			} else
+				memcpy(dest, (void *)sechdrs[i].sh_addr,
+				       sechdrs[i].sh_size);
+		}
 		/* Update sh_addr to point to copy in image. */
 		sechdrs[i].sh_addr = (unsigned long)dest;
 		DEBUGP("\t0x%lx %s\n", sechdrs[i].sh_addr, secstrings + sechdrs[i].sh_name);
@@ -1744,6 +1789,9 @@ static struct module *load_module(void _
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
 
+	/* Update the percpu_offset here since we might miss it when copying */
+	mod->percpu_offset = percpu_offset;
+
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
 
@@ -1820,7 +1868,7 @@ static struct module *load_module(void _
 
 	/* Finally, copy percpu area over. */
 	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
-		       sechdrs[pcpuindex].sh_size);
+		       sechdrs[pcpuindex].sh_size, mod->percpu_offset);
 
 	add_kallsyms(mod, sechdrs, symindex, strindex, secstrings);
 
@@ -1895,7 +1943,7 @@ static struct module *load_module(void _
 	module_free(mod, mod->module_core);
  free_percpu:
 	if (percpu)
-		percpu_modfree(percpu);
+		percpu_modfree(percpu, percpu_offset);
  free_mod:
 	kfree(args);
  free_hdr:


