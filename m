Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWINN33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWINN33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWINN33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:29:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31116 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932093AbWINN32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:29:28 -0400
Date: Thu, 14 Sep 2006 08:29:17 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>
Subject: [PATCH] Migration of standard timers
Message-ID: <20060914132917.GA9898@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the user to migrate currently queued
standard timers from one cpu to another, thereby reducing
timer induced latency on the chosen cpu.  Timers that
were placed with add_timer_on() are considered to have 
'cpu affinity' and are not moved.

The changes in drivers/base/cpu.c provide a clean and
convenient interface for triggering the migration through
sysfs, via writing the destination cpu number to a file
associated with the source cpu.

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
+	timer->aff = 0;
 }
 EXPORT_SYMBOL(init_timer);
 
@@ -250,6 +251,7 @@ void add_timer_on(struct timer_list *tim
   	BUG_ON(timer_pending(timer) || !timer->function);
 	spin_lock_irqsave(&base->lock, flags);
 	timer->base = base;
+	timer->aff = 1;		/* Don't migrate */
 	internal_add_timer(base, timer);
 	spin_unlock_irqrestore(&base->lock, flags);
 }
@@ -1661,6 +1663,52 @@ static void __devinit migrate_timers(int
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+static void move_timer_list(tvec_base_t *new_base, struct list_head *head)
+{
+	struct timer_list *timer, *t;
+
+	list_for_each_entry_safe(timer, t, head, entry) {
+		if (timer->aff)
+			continue;
+		detach_timer(timer, 0);
+		timer->base = new_base;
+		internal_add_timer(new_base, timer);
+	}
+}
+
+int move_timers(int cpu, int dest)
+{
+	tvec_base_t *old_base;
+	tvec_base_t *new_base;
+	unsigned long flags;
+	int i;
+
+	if (cpu == dest)
+		return -EINVAL;
+
+	if (!cpu_online(cpu) || !cpu_online(dest))
+		return -EINVAL;
+
+	old_base = per_cpu(tvec_bases, cpu);
+	new_base = per_cpu(tvec_bases, dest);
+
+	spin_lock_irqsave(&new_base->lock, flags);
+	spin_lock(&old_base->lock);
+
+	for (i = 0; i < TVR_SIZE; i++)
+		move_timer_list(new_base, old_base->tv1.vec + i);
+	for (i = 0; i < TVN_SIZE; i++) {
+		move_timer_list(new_base, old_base->tv2.vec + i);
+		move_timer_list(new_base, old_base->tv3.vec + i);
+		move_timer_list(new_base, old_base->tv4.vec + i);
+		move_timer_list(new_base, old_base->tv5.vec + i);
+	}
+
+	spin_unlock(&old_base->lock);
+	spin_unlock_irqrestore(&new_base->lock, flags);
+	return 0;
+}
+
 static int __cpuinit timer_cpu_notify(struct notifier_block *self,
 				unsigned long action, void *hcpu)
 {
Index: linux/drivers/base/cpu.c
===================================================================
--- linux.orig/drivers/base/cpu.c
+++ linux/drivers/base/cpu.c
@@ -54,6 +54,26 @@ static ssize_t store_online(struct sys_d
 }
 static SYSDEV_ATTR(online, 0600, show_online, store_online);
 
+static ssize_t store_migrate(struct sys_device *dev, const char *buf,
+				size_t count)
+{
+	unsigned int cpu = dev->id;
+	unsigned long dest;
+	int rc;
+
+	dest = simple_strtoul(buf, NULL, 10);
+	if (dest > INT_MAX)
+		return -EINVAL;
+
+	rc = move_timers(cpu, dest);
+	if (rc < 0)
+		return rc;
+	else
+		return count;
+}
+
+static SYSDEV_ATTR(timer_migrate, 0200, NULL, store_migrate);
+
 static void __devinit register_cpu_control(struct cpu *cpu)
 {
 	sysdev_create_file(&cpu->sysdev, &attr_online);
@@ -62,6 +82,8 @@ void unregister_cpu(struct cpu *cpu)
 {
 	int logical_cpu = cpu->sysdev.id;
 
+	sysdev_remove_file(&cpu->sysdev, &attr_timer_migrate);
+
 	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
 
 	sysdev_remove_file(&cpu->sysdev, &attr_online);
@@ -124,6 +146,8 @@ int __devinit register_cpu(struct cpu *c
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
+	short aff;
 };
 
 extern struct tvec_t_base_s boot_tvec_bases;
@@ -24,6 +26,7 @@ extern struct tvec_t_base_s boot_tvec_ba
 		.expires = (_expires),				\
 		.data = (_data),				\
 		.base = &boot_tvec_bases,			\
+		.aff = 0,					\
 	}
 
 #define DEFINE_TIMER(_name, _function, _expires, _data)		\
@@ -95,6 +98,7 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
+extern int move_timers(int, int);
 struct hrtimer;
 extern int it_real_fn(struct hrtimer *);
 
