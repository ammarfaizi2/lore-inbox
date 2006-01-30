Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWA3Inu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWA3Inu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWA3Inu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:43:50 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37056
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751263AbWA3Inu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:43:50 -0500
Message-Id: <43DDDFDD.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 30 Jan 2006 09:43:57 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tvec_bases too large for per-cpu data
References: <43CE4C98.76F0.0078.0@novell.com> <20060120232500.07f0803a.akpm@osdl.org> <43D4BE7F.76F0.0078.0@novell.com> <20060123025702.1f116e70.akpm@osdl.org>
In-Reply-To: <20060123025702.1f116e70.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartFAD869DD.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartFAD869DD.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hopefully attached revised patch addresses all concerns mentioned (except that it intentionally continues to not use
alloc_percpu()).

Jan

>>> Andrew Morton <akpm@osdl.org> 23.01.06 11:57:02 >>>
"Jan Beulich" <JBeulich@novell.com> wrote:
>
> >>> Andrew Morton <akpm@osdl.org> 21.01.06 08:25:00 >>>
> >"Jan Beulich" <JBeulich@novell.com> wrote:
> >>
> >> The biggest arch-independent consumer is tvec_bases (over 4k on 32-bit
> >>  archs,
> >>  over 8k on 64-bit ones), which now gets converted to use dynamically
> >>  allocated
> >>  memory instead.
> >
> >ho hum, another pointer hop.
> >
> >Did you consider using alloc_percpu()?
> 
> I did, but I saw drawbacks with that (most notably the fact that all instances are allocated at
> once, possibly wasting a lot of memory).

It's 4k for each cpu which is in the possible_map but which will never be
brought online.  I don't think that'll be a lot of memory - are there
machines which have a lot of possible-but-not-really-there CPUs?

> >The patch does trickery in init_timers_cpu() which, from my reading, defers
> >the actual per-cpu allocation until the second CPU comes online. 
> >Presumably because of some ordering issue which you discovered.  Readers of
> >the code need to know what that issue was.
> 
> No, I don't see any trickery there (on demand allocation in CPU_UP_PREPARE is being done
> elsewhere in very similar ways), and I also didn't see any ordering issues. Hence I also didn't
> see any need to explain this in detail.

There _must_ be ordering issues.  Otherwise we'd just dynamically allocate
all the structs up-front and be done with it.

Presumably the ordering issue is that init_timers() is called before
kmem_cache_init().  That's non-obvious and should be commented.

> >And boot_tvec_bases will always be used for the BP, and hence one slot in
> >the per-cpu array will forever be unused.  Until the BP is taken down and
> >brought back up, in which case it will suddenly start to use a dynamically
> >allocated structure.
> 
> Why? Each slot is allocated at most once, the BP's is never allocated (it will continue to use the
> static one even when brought down and back up).

OK, I missed the `if (likely(!base))' test in there.  Patch seems OK from
that POV and we now seem to know what the ordering problem is.

- The `#ifdef CONFIG_NUMA' in init_timers_cpu() seems to be unnecessary -
  kmalloc_node() will use kmalloc() if !NUMA.

- The likely()s in init_timers_cpu() seems fairly pointless - it's not a
  fastpath.

- We prefer to do this:

	if (expr) {
		...
	} else {
		...
	}

  and not

	if (expr) {
		...
	}
	else {
		...
	}



--=__PartFAD869DD.1__=
Content-Type: text/plain; name="linux-2.6.16-rc1-per-cpu-tvec_bases.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.16-rc1-per-cpu-tvec_bases.patch"

From: Jan Beulich <jbeulich@novell.com>

With internal Xen-enabled kernels we see the kernel's static per-cpu data area
exceed the limit of 32k on x86-64, and even native x86-64 kernels get fairly
close to that limit. I generally question whether it is reasonable to have
data structures several kb in size allocated as per-cpu data when the space
there is rather limited.
The biggest arch-independent consumer is tvec_bases (over 4k on 32-bit archs,
over 8k on 64-bit ones), which now gets converted to use dynamically allocated
memory instead.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/kernel/timer.c 2.6.16-rc1-per-cpu-tvec_bases/kernel/timer.c
--- /home/jbeulich/tmp/linux-2.6.16-rc1/kernel/timer.c	2006-01-27 15:10:49.000000000 +0100
+++ 2.6.16-rc1-per-cpu-tvec_bases/kernel/timer.c	2006-01-27 16:22:35.000000000 +0100
@@ -86,7 +86,8 @@ struct tvec_t_base_s {
 } ____cacheline_aligned_in_smp;
 
 typedef struct tvec_t_base_s tvec_base_t;
-static DEFINE_PER_CPU(tvec_base_t, tvec_bases);
+static DEFINE_PER_CPU(tvec_base_t *, tvec_bases);
+static tvec_base_t boot_tvec_bases;
 
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
@@ -157,7 +158,7 @@ EXPORT_SYMBOL(__init_timer_base);
 void fastcall init_timer(struct timer_list *timer)
 {
 	timer->entry.next = NULL;
-	timer->base = &per_cpu(tvec_bases, raw_smp_processor_id()).t_base;
+	timer->base = &per_cpu(tvec_bases, raw_smp_processor_id())->t_base;
 }
 EXPORT_SYMBOL(init_timer);
 
@@ -218,7 +219,7 @@ int __mod_timer(struct timer_list *timer
 		ret = 1;
 	}
 
-	new_base = &__get_cpu_var(tvec_bases);
+	new_base = __get_cpu_var(tvec_bases);
 
 	if (base != &new_base->t_base) {
 		/*
@@ -258,7 +259,7 @@ EXPORT_SYMBOL(__mod_timer);
  */
 void add_timer_on(struct timer_list *timer, int cpu)
 {
-	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
+	tvec_base_t *base = per_cpu(tvec_bases, cpu);
   	unsigned long flags;
 
   	BUG_ON(timer_pending(timer) || !timer->function);
@@ -492,7 +493,7 @@ unsigned long next_timer_interrupt(void)
 	tvec_t *varray[4];
 	int i, j;
 
-	base = &__get_cpu_var(tvec_bases);
+	base = __get_cpu_var(tvec_bases);
 	spin_lock(&base->t_base.lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
 	list = 0;
@@ -856,7 +857,7 @@ EXPORT_SYMBOL(xtime_lock);
  */
 static void run_timer_softirq(struct softirq_action *h)
 {
-	tvec_base_t *base = &__get_cpu_var(tvec_bases);
+	tvec_base_t *base = __get_cpu_var(tvec_bases);
 
  	hrtimer_run_queues();
 	if (time_after_eq(jiffies, base->timer_jiffies))
@@ -1209,12 +1210,34 @@ asmlinkage long sys_sysinfo(struct sysin
 	return 0;
 }
 
-static void __devinit init_timers_cpu(int cpu)
+static int __devinit init_timers_cpu(int cpu)
 {
 	int j;
 	tvec_base_t *base;
 
-	base = &per_cpu(tvec_bases, cpu);
+	base = per_cpu(tvec_bases, cpu);
+	if (!base) {
+		static char boot_done;
+
+		/* Cannot do allocation in init_timers as that runs before the
+		   allocator initializes (and would waste memory if there are
+		   more possible CPUs than will ever be installed/brought up). */
+		if (boot_done) {
+#ifdef CONFIG_NUMA
+			base = kmalloc_node(sizeof(*base), GFP_KERNEL, cpu_to_node(cpu));
+			if (!base)
+				/* Just in case, fall back to normal allocation. */
+#endif
+				base = kmalloc(sizeof(*base), GFP_KERNEL);
+			if (!base)
+				return -ENOMEM;
+			memset(base, 0, sizeof(*base));
+		} else {
+			base = &boot_tvec_bases;
+			boot_done = 1;
+		}
+		per_cpu(tvec_bases, cpu) = base;
+	}
 	spin_lock_init(&base->t_base.lock);
 	for (j = 0; j < TVN_SIZE; j++) {
 		INIT_LIST_HEAD(base->tv5.vec + j);
@@ -1226,6 +1249,7 @@ static void __devinit init_timers_cpu(in
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
 	base->timer_jiffies = jiffies;
+	return 0;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1248,8 +1272,8 @@ static void __devinit migrate_timers(int
 	int i;
 
 	BUG_ON(cpu_online(cpu));
-	old_base = &per_cpu(tvec_bases, cpu);
-	new_base = &get_cpu_var(tvec_bases);
+	old_base = per_cpu(tvec_bases, cpu);
+	new_base = get_cpu_var(tvec_bases);
 
 	local_irq_disable();
 	spin_lock(&new_base->t_base.lock);
@@ -1279,7 +1303,8 @@ static int __devinit timer_cpu_notify(st
 	long cpu = (long)hcpu;
 	switch(action) {
 	case CPU_UP_PREPARE:
-		init_timers_cpu(cpu);
+		if (init_timers_cpu(cpu) < 0)
+			return NOTIFY_BAD;
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:

--=__PartFAD869DD.1__=--
