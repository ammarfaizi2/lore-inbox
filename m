Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUEOA5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUEOA5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUEOAyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:54:49 -0400
Received: from omr1.netsolmail.com ([216.168.230.162]:4067 "EHLO
	omr1.netsolmail.com") by vger.kernel.org with ESMTP id S264628AbUEOAvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:51:49 -0400
Message-Id: <200405150051.BMA31289@ms6.netsolmail.com>
Reply-To: <shai@ftcon.com>
From: "Shai Fultheim" <shai@ftcon.com>
To: "'Mikael Pettersson'" <mikpe@csd.uu.se>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][6/7] perfctr-2.7.2 for 2.6.6-mm2: global-mode counters
Date: Fri, 14 May 2004 17:51:35 -0700
Organization: FT Consulting
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200405141413.i4EEDBcG018431@alkaid.it.uu.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQ5wJr9shL6/tL2Qh+KPmwfYBJthgAVghmg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael,

Can you use DEFINE_PER_CPU instead of:

+static struct gperfctr per_cpu_gperfctr[NR_CPUS] __cacheline_aligned;

?

--Shai


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Mikael Pettersson
Sent: Friday, May 14, 2004 07:13
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][6/7] perfctr-2.7.2 for 2.6.6-mm2: global-mode counters

perfctr-2.7.2 for 2.6.6-mm2, part 6/7:

- driver for global-mode (system-wide) performance counters

 global.c |  238
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 global.h |   16 ++++
 2 files changed, 254 insertions(+)

diff -ruN linux-2.6.6-mm2/drivers/perfctr/global.c
linux-2.6.6-mm2.perfctr-2.7.2.global/drivers/perfctr/global.c
--- linux-2.6.6-mm2/drivers/perfctr/global.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.global/drivers/perfctr/global.c
2004-05-14 14:35:08.600164909 +0200
@@ -0,0 +1,238 @@
+/* $Id: global.c,v 1.40 2004/05/13 23:32:49 mikpe Exp $
+ * Global-mode performance-monitoring counters.
+ *
+ * Copyright (C) 2000-2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/perfctr.h>
+
+#include <asm/uaccess.h>
+
+#include "cpumask.h"
+#include "global.h"
+#include "marshal.h"
+
+static const char this_service[] = __FILE__;
+static int hardware_is_ours = 0;
+static struct timer_list sampling_timer;
+static DECLARE_MUTEX(control_mutex);
+static unsigned int nr_active_cpus = 0;
+
+struct gperfctr {
+	struct perfctr_cpu_state cpu_state;
+	spinlock_t lock;
+} ____cacheline_aligned;
+
+static struct gperfctr per_cpu_gperfctr[NR_CPUS] __cacheline_aligned;
+
+static int reserve_hardware(void)
+{
+	const char *other;
+
+	if( hardware_is_ours )
+		return 0;
+	other = perfctr_cpu_reserve(this_service);
+	if( other ) {
+		printk(KERN_ERR __FILE__ ":%s: failed because hardware is
taken by '%s'\n",
+		       __FUNCTION__, other);
+		return -EBUSY;
+	}
+	hardware_is_ours = 1;
+	return 0;
+}
+
+static void release_hardware(void)
+{
+	int i;
+
+	nr_active_cpus = 0;
+	if( hardware_is_ours ) {
+		hardware_is_ours = 0;
+		del_timer(&sampling_timer);
+		sampling_timer.data = 0;
+		perfctr_cpu_release(this_service);
+		for(i = 0; i < NR_CPUS; ++i)
+			per_cpu_gperfctr[i].cpu_state.cstatus = 0;
+	}
+}
+
+static void sample_this_cpu(void *unused)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	struct gperfctr *perfctr;
+
+	perfctr = &per_cpu_gperfctr[smp_processor_id()];
+	if( !perfctr_cstatus_enabled(perfctr->cpu_state.cstatus) )
+		return;
+	spin_lock(&perfctr->lock);
+	perfctr_cpu_sample(&perfctr->cpu_state);
+	spin_unlock(&perfctr->lock);
+}
+
+static void sample_all_cpus(void)
+{
+	on_each_cpu(sample_this_cpu, NULL, 1, 1);
+}
+
+static void sampling_timer_function(unsigned long interval)
+{	
+	sample_all_cpus();
+	sampling_timer.expires = jiffies + interval;
+	add_timer(&sampling_timer);
+}
+
+static unsigned long usectojiffies(unsigned long usec)
+{
+	usec += 1000000 / HZ - 1;
+	usec /= 1000000 / HZ;
+	return usec;
+}
+
+static void start_sampling_timer(unsigned long interval_usec)
+{
+	if( interval_usec > 0 ) {
+		unsigned long interval = usectojiffies(interval_usec);
+		init_timer(&sampling_timer);
+		sampling_timer.function = sampling_timer_function;
+		sampling_timer.data = interval;
+		sampling_timer.expires = jiffies + interval;
+		add_timer(&sampling_timer);
+	}
+}
+
+static void start_this_cpu(void *unused)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	struct gperfctr *perfctr;
+
+	perfctr = &per_cpu_gperfctr[smp_processor_id()];
+	if( perfctr_cstatus_enabled(perfctr->cpu_state.cstatus) )
+		perfctr_cpu_resume(&perfctr->cpu_state);
+}
+
+static void start_all_cpus(void)
+{
+	on_each_cpu(start_this_cpu, NULL, 1, 1);
+}
+
+static int gperfctr_control(struct perfctr_struct_buf *argp)
+{
+	int ret;
+	struct gperfctr *perfctr;
+	struct gperfctr_cpu_control cpu_control;
+
+	ret = perfctr_copy_from_user(&cpu_control, argp,
&gperfctr_cpu_control_sdesc);
+	if( ret )
+		return ret;
+	if( cpu_control.cpu >= NR_CPUS ||
+	    !cpu_online(cpu_control.cpu) ||
+	    perfctr_cpu_is_forbidden(cpu_control.cpu) )
+		return -EINVAL;
+	/* we don't permit i-mode counters */
+	if( cpu_control.cpu_control.nrictrs != 0 )
+		return -EPERM;
+	down(&control_mutex);
+	ret = -EBUSY;
+	if( hardware_is_ours )
+		goto out_up;	/* you have to stop them first */
+	perfctr = &per_cpu_gperfctr[cpu_control.cpu];
+	spin_lock(&perfctr->lock);
+	perfctr->cpu_state.tsc_start = 0;
+	perfctr->cpu_state.tsc_sum = 0;
+	memset(&perfctr->cpu_state.pmc, 0, sizeof perfctr->cpu_state.pmc);
+	perfctr->cpu_state.control = cpu_control.cpu_control;
+	ret = perfctr_cpu_update_control(&perfctr->cpu_state, 1);
+	spin_unlock(&perfctr->lock);
+	if( ret < 0 )
+		goto out_up;
+	if( perfctr_cstatus_enabled(perfctr->cpu_state.cstatus) )
+		++nr_active_cpus;
+	ret = nr_active_cpus;
+ out_up:
+	up(&control_mutex);
+	return ret;
+}
+
+static int gperfctr_start(unsigned int interval_usec)
+{
+	int ret;
+
+	if( interval_usec < 10000 )
+		return -EINVAL;
+	down(&control_mutex);
+	ret = nr_active_cpus;
+	if( ret > 0 ) {
+		if( reserve_hardware() < 0 ) {
+			ret = -EBUSY;
+		} else {
+			start_all_cpus();
+			start_sampling_timer(interval_usec);
+		}
+	}
+	up(&control_mutex);
+	return ret;
+}
+
+static int gperfctr_stop(void)
+{
+	down(&control_mutex);
+	release_hardware();
+	up(&control_mutex);
+	return 0;
+}
+
+static int gperfctr_read(struct perfctr_struct_buf *argp)
+{
+	struct gperfctr *perfctr;
+	struct gperfctr_cpu_state state;
+	int err;
+
+	// XXX: sample_all_cpus() ???
+	err = perfctr_copy_from_user(&state, argp,
&gperfctr_cpu_state_only_cpu_sdesc);
+	if( err )
+		return err;
+	if( state.cpu >= NR_CPUS || !cpu_online(state.cpu) )
+		return -EINVAL;
+	perfctr = &per_cpu_gperfctr[state.cpu];
+	spin_lock(&perfctr->lock);
+	state.cpu_control = perfctr->cpu_state.control;
+	//state.sum = perfctr->cpu_state.sum;
+	{
+		int j;
+		state.sum.tsc = perfctr->cpu_state.tsc_sum;
+		for(j = 0; j < ARRAY_SIZE(state.sum.pmc); ++j)
+			state.sum.pmc[j] = perfctr->cpu_state.pmc[j].sum;
+	}
+	spin_unlock(&perfctr->lock);
+	return perfctr_copy_to_user(argp, &state,
&gperfctr_cpu_state_sdesc);
+}
+
+int sys_gperfctr(unsigned int cmd, unsigned long arg)
+{
+	if( !capable(CAP_SYS_PTRACE) )
+		return -EPERM;
+	switch( cmd ) {
+	case GPERFCTR_CONTROL:
+		return gperfctr_control((struct perfctr_struct_buf*)arg);
+	case GPERFCTR_READ:
+		return gperfctr_read((struct perfctr_struct_buf*)arg);
+	case GPERFCTR_STOP:
+		return gperfctr_stop();
+	case GPERFCTR_START:
+		return gperfctr_start(arg);
+	}
+	return -EINVAL;
+}
+
+void __init gperfctr_init(void)
+{
+	int i;
+
+	for(i = 0; i < NR_CPUS; ++i)
+		per_cpu_gperfctr[i].lock = SPIN_LOCK_UNLOCKED;
+}
diff -ruN linux-2.6.6-mm2/drivers/perfctr/global.h
linux-2.6.6-mm2.perfctr-2.7.2.global/drivers/perfctr/global.h
--- linux-2.6.6-mm2/drivers/perfctr/global.h	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.global/drivers/perfctr/global.h
2004-05-14 14:35:08.600164909 +0200
@@ -0,0 +1,16 @@
+/* $Id: global.h,v 1.8 2004/05/13 23:32:49 mikpe Exp $
+ * Global-mode performance-monitoring counters.
+ *
+ * Copyright (C) 2000-2004  Mikael Pettersson
+ */
+
+#ifdef CONFIG_PERFCTR_GLOBAL
+extern int sys_gperfctr(unsigned int cmd, unsigned long arg);
+extern void gperfctr_init(void);
+#else
+extern int sys_gperfctr(unsigned int cmd, unsigned long arg)
+{
+	return -EINVAL;
+}
+static inline void gperfctr_init(void) { }
+#endif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

