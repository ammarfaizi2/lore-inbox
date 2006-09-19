Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWISP3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWISP3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWISP3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:29:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21420 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751162AbWISP3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:29:53 -0400
Date: Tue, 19 Sep 2006 10:29:42 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>, Jes Sorensen <jes@sgi.com>
Subject: [PATCH] Migration of Standard Timers
Message-ID: <20060919152942.GA26863@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reposting this with some suggested changes.


This patch allows the user to migrate currently queued
standard timers from one cpu to another.  Migrating
timers off of select cpus allows those cpus to run
time critical threads with minimal timer induced latency
(which can reach 100's of usec for a single timer as shown
on an X86_64 test machine), thereby improving overall
determinance on those selected cpus.

This patch considers timers placed with add_timer_on()
to have 'cpu affinity' and does not move them, unless the
timers are being migrated off of a hotplug cpu that is
going down.

The changes in drivers/base/cpu.c provide a clean and
convenient interface for triggering the migration through
sysfs, via writing the destination cpu number to an owner
writeable file (0200 permissions) associated with the source
cpu.  In additon, this functionality is available for kernel
module use.

Note that migrating timers will not, by itself, keep new
timers off of the chosen cpu.  But with careful control of
thread affinity, one can control the affinity of new timers
and keep timer induced latencies off of the chosen cpu.

This particular patch does not affect the hrtimers.  That
could be addressed later.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>


Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -147,6 +147,7 @@ void fastcall init_timer(struct timer_li
 {
 	timer->entry.next = NULL;
 	timer->base = __raw_get_cpu_var(tvec_bases);
+	timer->is_bound_to_cpu = 0;
 }
 EXPORT_SYMBOL(init_timer);
 
@@ -250,6 +251,7 @@ void add_timer_on(struct timer_list *tim
   	BUG_ON(timer_pending(timer) || !timer->function);
 	spin_lock_irqsave(&base->lock, flags);
 	timer->base = base;
+	timer->is_bound_to_cpu = 1;	/* Don't migrate if cpu online */
 	internal_add_timer(base, timer);
 	spin_unlock_irqrestore(&base->lock, flags);
 }
@@ -1616,50 +1618,65 @@ static int __devinit init_timers_cpu(int
 	return 0;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-static void migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
+static void migrate_timer_list(tvec_base_t *new_base, struct list_head *head, int cpu_down)
 {
-	struct timer_list *timer;
+	struct timer_list *timer, *t;
 
-	while (!list_empty(head)) {
-		timer = list_entry(head->next, struct timer_list, entry);
+	list_for_each_entry_safe(timer, t, head, entry) {
+		if (!cpu_down && timer->is_bound_to_cpu)
+			continue;
 		detach_timer(timer, 0);
 		timer->base = new_base;
 		internal_add_timer(new_base, timer);
 	}
 }
 
-static void __devinit migrate_timers(int cpu)
+int migrate_timers(int dest_cpu, int source_cpu, int cpu_down)
 {
 	tvec_base_t *old_base;
 	tvec_base_t *new_base;
+	spinlock_t *lock1, *lock2;
+	unsigned long flags;
 	int i;
 
-	BUG_ON(cpu_online(cpu));
-	old_base = per_cpu(tvec_bases, cpu);
-	new_base = get_cpu_var(tvec_bases);
-
-	local_irq_disable();
-	spin_lock(&new_base->lock);
-	spin_lock(&old_base->lock);
+	if (source_cpu == dest_cpu)
+		return -EINVAL;
+
+	if (!cpu_online(dest_cpu))
+		return -EINVAL;
+
+	if (cpu_down)
+		BUG_ON(cpu_online(source_cpu));
+	else if (!cpu_online(source_cpu))
+		return -EINVAL;
+
+	old_base = per_cpu(tvec_bases, source_cpu);
+	new_base = per_cpu(tvec_bases, dest_cpu);
 
-	BUG_ON(old_base->running_timer);
+	/* Order locking based on relative cpu number */
+	lock1 = dest_cpu > source_cpu ? &old_base->lock : &new_base->lock;
+	lock2 = dest_cpu > source_cpu ? &new_base->lock : &old_base->lock;
+
+	spin_lock_irqsave(lock1, flags);
+	spin_lock(lock2);
+
+	if (cpu_down)
+		BUG_ON(old_base->running_timer);
 
 	for (i = 0; i < TVR_SIZE; i++)
-		migrate_timer_list(new_base, old_base->tv1.vec + i);
+		migrate_timer_list(new_base, old_base->tv1.vec + i, cpu_down);
 	for (i = 0; i < TVN_SIZE; i++) {
-		migrate_timer_list(new_base, old_base->tv2.vec + i);
-		migrate_timer_list(new_base, old_base->tv3.vec + i);
-		migrate_timer_list(new_base, old_base->tv4.vec + i);
-		migrate_timer_list(new_base, old_base->tv5.vec + i);
+		migrate_timer_list(new_base, old_base->tv2.vec + i, cpu_down);
+		migrate_timer_list(new_base, old_base->tv3.vec + i, cpu_down);
+		migrate_timer_list(new_base, old_base->tv4.vec + i, cpu_down);
+		migrate_timer_list(new_base, old_base->tv5.vec + i, cpu_down);
 	}
 
-	spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
-	local_irq_enable();
-	put_cpu_var(tvec_bases);
+	spin_unlock(lock2);
+	spin_unlock_irqrestore(lock1, flags);
+	return 0;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
+EXPORT_SYMBOL_GPL(migrate_timers);
 
 static int __cpuinit timer_cpu_notify(struct notifier_block *self,
 				unsigned long action, void *hcpu)
@@ -1672,7 +1689,7 @@ static int __cpuinit timer_cpu_notify(st
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
-		migrate_timers(cpu);
+		migrate_timers(smp_processor_id(), cpu, 1);
 		break;
 #endif
 	default:
Index: linux/drivers/base/cpu.c
===================================================================
--- linux.orig/drivers/base/cpu.c
+++ linux/drivers/base/cpu.c
@@ -54,6 +54,25 @@ static ssize_t store_online(struct sys_d
 }
 static SYSDEV_ATTR(online, 0600, show_online, store_online);
 
+static ssize_t store_timer_migrate(struct sys_device *dev, const char *buf,
+				size_t count)
+{
+	unsigned int source_cpu = dev->id;
+	unsigned long dest_cpu;
+	int rc;
+
+	dest_cpu = simple_strtoul(buf, NULL, 10);
+	if (dest_cpu > INT_MAX)
+		return -EINVAL;
+
+	rc = migrate_timers(dest_cpu, source_cpu, 0);
+	if (rc < 0)
+		return rc;
+	else
+		return count;
+}
+static SYSDEV_ATTR(timer_migrate, 0200, NULL, store_timer_migrate);
+
 static void __devinit register_cpu_control(struct cpu *cpu)
 {
 	sysdev_create_file(&cpu->sysdev, &attr_online);
@@ -62,6 +81,8 @@ void unregister_cpu(struct cpu *cpu)
 {
 	int logical_cpu = cpu->sysdev.id;
 
+	sysdev_remove_file(&cpu->sysdev, &attr_timer_migrate);
+
 	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
 
 	sysdev_remove_file(&cpu->sysdev, &attr_online);
@@ -124,6 +145,8 @@ int __devinit register_cpu(struct cpu *c
 		cpu_sys_devices[num] = &cpu->sysdev;
 	if (!error)
 		register_cpu_under_node(num, cpu_to_node(num));
+	if (!error)
+		sysdev_create_file(&cpu->sysdev, &attr_timer_migrate);
 
 #ifdef CONFIG_KEXEC
 	if (!error)
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -15,6 +15,8 @@ struct timer_list {
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
+
+	char is_bound_to_cpu;
 };
 
 extern struct tvec_t_base_s boot_tvec_bases;
@@ -24,6 +26,7 @@ extern struct tvec_t_base_s boot_tvec_ba
 		.expires = (_expires),				\
 		.data = (_data),				\
 		.base = &boot_tvec_bases,			\
+		.is_bound_to_cpu = 0,				\
 	}
 
 #define DEFINE_TIMER(_name, _function, _expires, _data)		\
@@ -95,6 +98,7 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
+extern int migrate_timers(int dest_cpu, int source_cpu, int cpu_down);
 struct hrtimer;
 extern int it_real_fn(struct hrtimer *);
 
