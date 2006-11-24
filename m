Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966223AbWKXWAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966223AbWKXWAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 17:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966231AbWKXWAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 17:00:31 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:6592 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966223AbWKXWA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 17:00:29 -0500
Date: Fri, 24 Nov 2006 17:00:26 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 10/16] LTTng 0.6.36 for 2.6.18 : Core module
Message-ID: <20061124220026.GK25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:59:48 up 93 days, 19:07,  3 users,  load average: 0.56, 0.60, 0.44
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lttng core module.

patch10-2.6.18-lttng-core-0.6.36-core.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1807,6 +1807,13 @@ W:	http://lsm.immunix.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git
 S:	Supported
 
+LINUX TRACE TOOLKIT NEXT GENERATION
+P:	Mathieu Desnoyers
+M:	mathieu.desnoyers@polymtl.ca
+L:	ltt-dev@listserv.shafik.org
+W:	http://ltt.polymtl.ca
+S:	Maintained
+
 LM83 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
--- /dev/null
+++ b/ltt/ltt-core.c
@@ -0,0 +1,27 @@
+
+/*
+ * LTT core in-kernel infrastructure.
+ *
+ * Copyright 2006 - Mathieu Desnoyers mathieu.desnoyers@polymtl.ca
+ *
+ * Distributed under the GPL license
+ */
+
+#include <linux/ltt-core.h>
+#include <linux/module.h>
+
+/* Traces structures */
+struct ltt_traces ltt_traces = {
+	.head = LIST_HEAD_INIT(ltt_traces.head),
+	.num_active_traces = 0
+};
+
+EXPORT_SYMBOL(ltt_traces);
+
+volatile unsigned int ltt_nesting[NR_CPUS] = { [ 0 ... NR_CPUS-1 ] = 0 } ;
+
+EXPORT_SYMBOL(ltt_nesting);
+
+atomic_t lttng_logical_clock = ATOMIC_INIT(0);
+EXPORT_SYMBOL(lttng_logical_clock);
+
--- /dev/null
+++ b/ltt/ltt-heartbeat.c
@@ -0,0 +1,211 @@
+/*
+ * ltt-heartbeat.c
+ *
+ * (C) Copyright	2006 -
+ * 		Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * notes : heartbeat timer cannot be used for early tracing in the boot process,
+ * as it depends on timer interrupts.
+ *
+ * The timer needs to be only on one CPU to support hotplug.
+ * We have the choice between schedule_delayed_work_on and an IPI to get each
+ * CPU to write the heartbeat. IPI have been chosen because it is considered
+ * faster than passing through the timer to get the work scheduled on all the
+ * CPUs.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/ltt-core.h>
+#include <linux/workqueue.h>
+#include <linux/cpu.h>
+#include <linux/timex.h>
+#include <ltt/ltt-facility-select-core.h>
+#include <ltt/ltt-facility-core.h>
+
+/* How often the LTT per-CPU timers fire */
+#define LTT_PERCPU_TIMER_FREQ  (HZ/10)
+
+static struct timer_list heartbeat_timer;
+static unsigned int precalc_heartbeat_expire = 0;
+
+#ifdef CONFIG_LTT_SYNTHETIC_TSC
+/* For architectures with 32 bits TSC */
+static struct synthetic_tsc_struct {
+	u32 tsc[2][2];	/* a pair of 2 32 bits. [0] is the MSB, [1] is LSB */
+	unsigned int index;	/* Index of the current synth. tsc. */
+} ____cacheline_aligned synthetic_tsc[NR_CPUS];
+
+/* Called from one CPU, before any tracing starts, to init each structure */
+static void ltt_heartbeat_init_synthetic_tsc(void)
+{
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		synthetic_tsc[cpu].tsc[0][0] = 0;	
+		synthetic_tsc[cpu].tsc[0][1] = 0;	
+		synthetic_tsc[cpu].tsc[1][0] = 0;
+		synthetic_tsc[cpu].tsc[1][1] = 0;
+		synthetic_tsc[cpu].index = 0;
+	}
+	smp_wmb();
+}
+
+/* Called from heartbeat IPI : either in interrupt or process context */
+static void ltt_heartbeat_update_synthetic_tsc(void)
+{
+	struct synthetic_tsc_struct *cpu_synth;
+	u32 tsc;
+
+	preempt_disable();
+	cpu_synth = &synthetic_tsc[smp_processor_id()];
+	tsc = (u32)get_cycles();	/* We deal with a 32 LSB TSC */
+
+	if (tsc < cpu_synth->tsc[cpu_synth->index][1]) {
+		unsigned int new_index = cpu_synth->index ? 0 : 1; /* 0 <-> 1 */
+		/* Overflow */
+		/* Non atomic update of the non current synthetic TSC, followed
+		 * by an atomic index change. There is no write concurrency,
+		 * so the index read/write does not need to be atomic. */
+		cpu_synth->tsc[new_index][1] = tsc; /* LSB update */
+		cpu_synth->tsc[new_index][0] =
+			cpu_synth->tsc[cpu_synth->index][0]+1; /* MSB update */
+		cpu_synth->index = new_index;	/* atomic change of index */
+	} else {
+		/* No overflow : we can simply update the 32 LSB of the current
+		 * synthetic TSC as it's an atomic write. */
+		cpu_synth->tsc[cpu_synth->index][1] = tsc;
+	}
+	preempt_enable();
+}
+
+/* Called from buffer switch : in _any_ context (even NMI) */
+u64 ltt_heartbeat_read_synthetic_tsc(void)
+{
+	struct synthetic_tsc_struct *cpu_synth;
+	u64 ret;
+	unsigned int index;
+	u32 tsc;
+
+	preempt_disable();
+	cpu_synth = &synthetic_tsc[smp_processor_id()];
+	index = cpu_synth->index; /* atomic read */
+	tsc = (u32)get_cycles();	/* We deal with a 32 LSB TSC */
+
+	if (tsc < cpu_synth->tsc[index][1]) {
+		/* Overflow */
+		ret = ((u64)(cpu_synth->tsc[index][0]+1) << 32) | ((u64)tsc);
+	} else {
+		/* no overflow */
+		ret = ((u64)cpu_synth->tsc[index][0] << 32) | ((u64)tsc);
+	}
+	preempt_enable();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ltt_heartbeat_read_synthetic_tsc);
+#endif //CONFIG_LTT_SYNTHETIC_TSC
+
+
+static void heartbeat_ipi(void *info)
+{
+#ifdef CONFIG_LTT_SYNTHETIC_TSC
+	ltt_heartbeat_update_synthetic_tsc();
+#endif //CONFIG_LTT_SYNTHETIC_TSC
+
+#ifdef CONFIG_LTT_HEARTBEAT_EVENT
+	/* Log a heartbeat event for each trace, each tracefile */
+	trace_core_time_heartbeat(GET_CHANNEL_INDEX(facilities));
+	trace_core_time_heartbeat(GET_CHANNEL_INDEX(interrupts));
+	trace_core_time_heartbeat(GET_CHANNEL_INDEX(processes));
+	trace_core_time_heartbeat(GET_CHANNEL_INDEX(modules));
+	trace_core_time_heartbeat(GET_CHANNEL_INDEX(cpu));
+	trace_core_time_heartbeat(GET_CHANNEL_INDEX(network));
+#endif //CONFIG_LTT_HEARTBEAT_EVENT
+}
+
+/* We need to be in process context to do an IPI */
+static void heartbeat_work(void *dummy)
+{
+	on_each_cpu(heartbeat_ipi, NULL, 1, 0);
+}
+
+static DECLARE_WORK(hb_work, heartbeat_work, NULL);
+
+/**
+ * heartbeat_timer : - Timer function generating hearbeat.
+ * @data: unused
+ *
+ * Guarantees at least 1 execution of heartbeat before low word of TSC wraps.
+ */
+static void heartbeat_timer_fct(unsigned long data)
+{
+	PREPARE_WORK(&hb_work, heartbeat_work, NULL);
+	schedule_work(&hb_work);
+	
+	mod_timer(&heartbeat_timer, jiffies + precalc_heartbeat_expire);
+}
+
+
+/**
+ * init_heartbeat_timer: - Start timer generating hearbeat events.
+ */
+static void init_heartbeat_timer(void)
+{
+	if (loops_per_jiffy > 0) {
+		printk(KERN_DEBUG "LTT : ltt-heartbeat start\n");
+		precalc_heartbeat_expire = ( 0xffffffffUL/(loops_per_jiffy << 1)
+			- 1 - LTT_PERCPU_TIMER_FREQ) >> 1;
+
+		heartbeat_work(NULL);
+
+		init_timer(&heartbeat_timer);
+		heartbeat_timer.function = heartbeat_timer_fct;
+		heartbeat_timer.expires = jiffies + precalc_heartbeat_expire;
+		add_timer(&heartbeat_timer);
+	} else
+		printk(KERN_WARNING
+			"LTT: No TSC for heartbeat timer "
+			"- continuing without one \n");
+}
+
+/**
+ * delete_heartbeat_timer: - Stop timer generating hearbeat events.
+ */
+static void delete_heartbeat_timer(void)
+{
+ 	if (loops_per_jiffy > 0) {
+		printk(KERN_DEBUG "LTT : ltt-heartbeat stop\n");
+		del_timer(&heartbeat_timer);
+	}
+}
+
+
+int ltt_heartbeat_trigger(enum ltt_heartbeat_functor_msg msg)
+{
+	printk(KERN_DEBUG "LTT : ltt-heartbeat trigger\n");
+	switch (msg) {
+		case LTT_HEARTBEAT_START:
+			init_heartbeat_timer();
+			break;
+		case LTT_HEARTBEAT_STOP:
+			delete_heartbeat_timer();
+			break;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(ltt_heartbeat_trigger);
+
+static int __init ltt_heartbeat_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-heartbeat init\n");
+#ifdef CONFIG_LTT_SYNTHETIC_TSC
+	ltt_heartbeat_init_synthetic_tsc();
+#endif //CONFIG_LTT_SYNTHETIC_TSC
+	return 0;
+}
+
+__initcall(ltt_heartbeat_init);
+
+
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
