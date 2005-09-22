Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVIVSdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVIVSdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVIVSdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:33:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:44516 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751014AbVIVSdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:33:03 -0400
Date: Fri, 23 Sep 2005 00:02:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Tony Lindgren <tony@atomide.com>, Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050922183215.GB7744@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050905170202.GJ25856@us.ibm.com> <20050907073743.GB5804@atomide.com> <20050907150517.GC4590@us.ibm.com> <20050908100035.GD25847@atomide.com> <20050908212213.GB2997@us.ibm.com> <20050908220854.GE2997@us.ibm.com> <20050920110654.GA373@in.ibm.com> <20050920145856.GE6589@us.ibm.com> <1127396290.4903.43.camel@localhost.localdomain> <20050922145222.GD5910@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20050922145222.GD5910@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 22, 2005 at 07:52:22AM -0700, Nishanth Aravamudan wrote:

> - recover_time(): since we skip ticks, we *must* recover time. Now, one
>   option is simply to hook into the normal interrupt path, and I am
>   talking with John about the best approach for that (e.g., just have an
>   interrupt happen, and *in theory* the time/timer subsystem should be
>   capable of recovering from "missed" or "lost" ticks), but for now we
>   have a manual callback to catch up.

It's not just xtime but jiffies also needs to be recovered. My understanding
of John's TOD is that it keeps up time and not jiffies. In which case
we still need to recover jiffies? 

Also, I think "recover_time" on s390 may do more than recovering time (as 
per Martin's note). So we should probably change the name - "handler" as in
ARM :)?

> > > Considering that not all architectures have such routines, then the
> > > use of spinlock can be entirely within the arch code. Maybe the

I eat my words. I tried embedding the spinlock entirely inside the arch-code
and find it non-trivial and very racy, as illustrated below:

[CPU0 going down]

> > current_dyntick_timer->reprogram();
> > if (cpus_full(noidlehz_mask))

	Lets say that this check was true (becasue CPU0 and CPU1 both
	were idle). But before we grab the spinlock, CPU1 wakes up
	(in the code below), also notices that all_were_idle,
	gets spinlock and calls exit_all_cpus_idle. After CPU1 releases
	the spinlock, CPU0 now gets the spinlock and calls
	enter_all_cpus_idle, which is _wrong_.
	
> >     current_dyntick_timer->enter_all_cpus_idle(); // which will lock
> >                                     // with
> >                                     // current_dyntick_timer->lock,
> >                                     // if necessary


[CPU1 coming up]

> >
> > dyn_tick_interrupt():
> >
> > if (cpus_full(noidlehz_mask)) {
> >     cpu_unset(cpu, noidlehz_mask);
> >     current_dyntick_timer->exit_all_cpus_idle(); // which will lock
> >                                     // with
> >                                     // current_dyntick_timer->lock,
> >                                     // if necessary
>


This is lot simpler if we use the lock to set/clear the bitmap also.
Question is : what overhead will that introduce on other arches 
(like s390/arm) where it not really required (since they will not 
have enter/exit_all_idle routines). We could define some macro, 
dyn_tick_lock()?, which evaluates to no-op on those arches, but
becomes a spinlock on x86-kind arch'es, something like:

static inline void dyn_tick_lock(void)
{
	spin_lock(&dyn_tick->lock);
}

for x86, and

static inline void dyn_tick_lock(void)
{
}

for s390/ARM.

> > I would really like to see how all the fields from the dyntick_timer
> > structure are supposed to be used. Especially the who-calls-what graph,
> > if I got it right then the low-level arch code calls common code
> > functions which in turn call functions from the dyntick_timer structure.


> > After a cpu woke up some code need to check if a tick has passed or not.
> > For s390 this is done in the start_hz_timer function called from the
> > idle notifier. Even if "nothing" has happened it's not just paranoia,
> > account_ticks sets up the clock comparator for the next tick, updates
> > xtime if it is necessary and account_user_vtime()/update_process_times()
> > for cpu time accounting. It is the exact same function that is used for
> > the regular tick interrupts, its just called from a different context.
> 
> You are right, and in fact, I mis-wrote when I replied to Vatsa. I think
> this is how all archs should treat recover_time(). But doesn't the timer
> interrupt already do much of this? I mean, if we were to allow the next
> interrupt to occur as usual (maybe forced to be called from our common
> dyntick_interrupt()), should time not get caught up that way?

If you are referring to calling the actual timer interrupt handler "as is" from
dyntick_interrupt(), then I feel uncomfortable about it, primary because
of some hardware interactions timer interrupt handler may have assuming that 
it is invoked due to a timer interrupt.

> > > > We probably also need to document how 'reprogram' will be invoked 
> > > > - with xtime_lock held or not. Again s390 does not seem to require it
> > > > while ARM is using one. I think we should let the arch code take
> > > > xtime_lock if they deem it necessary.
> > > 
> > > That seems buggy. I'm guessing they need the xtime_lock there just as
> > > much as ARM and x86 will. In fact, I'm pretty sure all archs will need
> > > it. But I'm fine with leaving it to the arch for now, and then unifying
> > > the locking later, if we find that all archs call seq_lock(xtime_lock).
> > 
> > Why do you need the xtime_lock to reprogram the clock comparator (=local
> > APIC timer) for the next timer interrupt? Neither xtime nor jiffies are
> > needed to reprogram the timer.
> 
> Hrm, you might be right. I might have mis-typed again. At the point
> where we are ready to hook into the underlying arch-dependent
> current_dyntick_timer->reprogram() routine, we should know the delta
> according to next_timer_interrupt(), so we should not need to query
> jiffies or xtime anymore...

I feel this is a bit tricky on non-comparator based interrupt sources like
a decrementer on PPC64 or the local APIC timer.


	cpu_idle()
	  | 
	  | (IRQs disabled)
	  V
	unsigned int dyn_tick_reprogram_timer(void)
	{
		int cpu = smp_processor_id();
		unsigned int delta;

		cpu_set(cpu, nohz_cpu_mask);

		smp_wmb();

		if (rcu_pending(cpu) || local_softirq_pending()) {
			cpu_clear(cpu, nohz_cpu_mask);
			return 0;
		}

a.		delta = next_timer_interrupt() - jiffies;

		if (delta < dyn_tick->min_skip) {
			cpu_clear(cpu, nohz_cpu_mask);
			return 0;
		}

		if (delta > dyn_tick->max_skip)
			delta = dyn_tick->max_skip;

b.		dyn_tick->reprogram(delta);

		return delta;
	}

				
If we pass just the number of ticks to skip to 'reprogram' then clearly it
is racy with respect to a changing jiffy. For example, lets say that:

At point a) jiffies = 100, next_timer_interrupt = 105. So we pass count 5 to
reprogram.

However by the time we reach point b) jiffies changes to 101. However since
only relative number was passed, reprogram code will cause the CPU to wake up
at 106.

We could consider passing absolute value to 'reprogram' (say 105), like below:

	unsigned int dyn_tick_reprogram_timer(void)
	{
		int cpu = smp_processor_id();
		unsigned long next, delta, seq;

		cpu_set(cpu, nohz_cpu_mask);

		smp_wmb();

		if (rcu_pending(cpu) || local_softirq_pending()) {
			cpu_clear(cpu, nohz_cpu_mask);
			return 0;
		}

		do { 
			read_seqbegin(&xtime_lock);
	
			next = next_timer_interrupt();
			delta = next - jiffies;

			if (delta < dyn_tick->min_skip) {
				cpu_clear(cpu, nohz_cpu_mask);
				return 0;
			}

			if (delta > dyn_tick->max_skip)
				next = jiffies + dyn_tick->max_skip;

		} while (read_seqretry(&xtime_lock, seq));

		dyn_tick->reprogram(next);

		return delta;
	}
	

Since reprogram has to convert it back to some relative number, it will need
to reference jiffy, which makes it racy and require the read_seqbegin/retry
based conversion to relative number.  I feel it is lot cleaner in such
a case to just take a write_lock(&xtime_lock) for the whole of 
dyn_tick_reprogram_timer.

> > Again the question who-calls-what. 
> 
> This is what I get for replying on little sleep. Vatsa, what arch-code
> should need access to current_dyntick_timer->recover_time() or the
> current_dyntick_timer->{enter,exit}_all_cpus_idle() routines? Ah...maybe
> the problem is I removed the generic dyntick_interrupt()? If we have
> that function again, we cann call current_dyntick_timer->recover_time()
> from there as well as current_dyntick_timer->exit_all_cpus_idle().
> current_dyntick_timer->enter_all_cpus_idle() should only need to be
> called from reprogram_dyntick().


Here's what I had in mind for the entire call-flow. This is based on the
interface attached in the mail.

At bootup:

	a. dyn_tick_timer structure is initalized and registered 
	   (dyn_tick_register). dyn_tick_register will set the
	   global dyn_tick pointer to the passed structure.
	   (See kernel/dyn-tick.c attached)

	b. Somewhere down the line, arch code calls dyn_tick_enable() 
	   to enable skipping ticks.  This should be called only after
	   initializing various h/w resources that will be reprogrammed
	   when we call dyn_tick->reprogram(). 

	   Typically both a. and b. are done during device_initcall time.

	c. init_dyn_tick_sysfs() creates "/sys/devices/system/dyn_tick/dyn_tick0/enable" file if dyn_tick_register has been called by know (i.e dyn_tick pointer
 	   is non-NULL).


Entering tickless state:

	a. cpu_idle calls dyn_tick_reprogram_timer() with IRQs disabled.

	b. dyn_tick_reprogram_timer finds out when the next timer is and
	   whether is atleast min_skip away. If so, it calls
	   dyn_tick->reprogram(). In the interface that I have attached,
	   this is called with write_lock held on xtime_lock and is
	   passed the relative value of number of ticks to be skipped.
	   Also on x86-arch, it is called with dyn_tick->lock held.

	c. dyn_tick->reprogram will arrange for that many ticks to be
	   skipped. In addition, on x86 like platforms, it can do
	   step d.

	d. if (cpus_equal(nohz_cpu_mask, cpu_online_map))
		dyn_tick->enter_all_cpus_idle();


Exiting tickless state:

	a. H/w interrupt comes in. dyn_tick_interrupt() is called 
	   as one of the first steps. dyn_tick_interrupt() is completely
	   defined in arch-code and does what it wants. As an example,
	   it can do this:
	   
		b. dyn_tick_lock(); 	/* spin_lock(&dyn_tick->lock) on x86 */

		   if (cpus_equal(nohz_cpu_mask, cpu_online_map))
			all_were_idle = 1;
		   else
			all_were_idle = 0;
	
		   cpu_clear(cpu, nohz_cpu_mask);
	
		   if (all_were_idle)
			dyn_tick->exit_all_cpus_idle();

		   dyn_tick_unlock(); 	/* spin_unlock(&dyn_tick->lock) on x86 */
	
		c. dyn_tick->recover_time(); 
			This can recover jiffies/xtime and also setup the
			next timer. On s390 this can be account_ticks() for
			example. Maybe we should call this dyn_tick->handler?


	d. dyn_tick_interrupt() returns so that rest of interrupt processing
	   can occur.


Note that a-d are completely inside arch-code.
		

I have attached include/linux/dyn-tick.h & kernel/dyn-tick.c as
detailed reference of the interface.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-tick.patch"

---

 linux-2.6.14-rc1-vatsa/include/linux/dyn-tick.h |   84 +++++++++++
 linux-2.6.14-rc1-vatsa/kernel/dyn-tick.c        |  182 ++++++++++++++++++++++++
 2 files changed, 266 insertions(+)

diff -puN /dev/null kernel/dyn-tick.c
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.14-rc1-vatsa/kernel/dyn-tick.c	2005-09-22 23:58:51.000000000 +0530
@@ -0,0 +1,182 @@
+/*
+ * linux/kernel/dyn-tick.c
+ *
+ * Beginnings of generic dynamic tick timer support
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/sysdev.h>
+#include <linux/interrupt.h>
+#include <linux/cpumask.h>
+#include <linux/pm.h>
+#include <linux/dyn-tick.h>
+#include <linux/rcupdate.h>
+
+#define DYN_TICK_VERSION	"050610-1"
+
+struct dyn_tick_state *dyn_tick;
+
+/*
+ * Arch independent code needed to reprogram next timer interrupt.
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle loop.
+ */
+unsigned int dyn_tick_reprogram_timer(void)
+{
+	int cpu = smp_processor_id();
+	unsigned int delta;
+
+	if (!dyn_tick_enabled())
+		return 0;
+
+	/* This is defined in asm/dyn-tick.h */
+	dyn_tick_lock();
+
+	/* Check if we can start skipping ticks */
+	write_seqlock(&xtime_lock);
+
+
+	cpu_set(cpu, nohz_cpu_mask);
+
+	smp_wmb();
+
+	if (rcu_pending(cpu) || local_softirq_pending()) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		return 0;
+	}
+
+	delta = next_timer_interrupt() - jiffies;
+
+	if (delta < dyn_tick->min_skip) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		return 0;
+	}
+
+	if (delta > dyn_tick->max_skip)
+		delta = dyn_tick->max_skip;
+
+	dyn_tick->reprogram(delta);
+
+	write_sequnlock(&xtime_lock);
+
+	dyn_tick_unlock();
+
+	return delta;
+}
+
+int dyn_tick_enable(void)
+{
+        unsigned long flags;
+        int ret = -ENODEV;
+
+        if (dyn_tick) {
+                write_seqlock_irqsave(&xtime_lock, flags);
+                ret = 0;
+                if (!dyn_tick_enabled())
+                        ret = dyn_tick->enable();
+
+                        if (ret == 0)
+                                dyn_tick->state |= DYN_TICK_ENABLED;
+                }
+                write_sequnlock_irqrestore(&xtime_lock, flags);
+        }
+
+        return ret;
+}
+
+int dyn_tick_disable(void)
+{
+        unsigned long flags;
+        int ret = -ENODEV;
+
+        if (dyn_tick) {
+                write_seqlock_irqsave(&xtime_lock, flags);
+                ret = 0;
+                if (dyn_tick_enabled())
+                        ret = dyn_tick->disable();
+
+                        if (ret == 0)
+                                dyn_tick->state &= ~DYN_TICK_ENABLED;
+                }
+                write_sequnlock_irqrestore(&xtime_lock, flags);
+        }
+
+        return ret;
+}
+
+
+void dyn_tick_register(struct dyn_tick_timer *arch_timer)
+{
+	dyn_tick = arch_timer;
+	printk(KERN_INFO "dyn-tick: Registering dynamic tick timer v%s\n",
+	       DYN_TICK_VERSION);
+}
+
+/*
+ * ---------------------------------------------------------------------------
+ * Sysfs interface
+ * ---------------------------------------------------------------------------
+ */
+
+extern struct sys_device device_timer;
+
+static ssize_t show_dyn_tick_enable(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "enabled:\t%i\n", dyn_tick_enabled());
+}
+
+static ssize_t set_dyn_tick_enable(struct sys_device *dev, const char *buf,
+				   size_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+
+	if (enable)
+		dyn_tick_enable();
+	else
+		dyn_tick_disable();
+
+	return count;
+}
+
+static SYSDEV_ATTR(enable, 0644, show_dyn_tick_enable,
+		   set_dyn_tick_enable);
+
+static struct sysdev_class dyn_tick_sysclass = {
+	set_kset_name("dyn_tick"),
+};
+
+static struct sys_device device_dyn_tick = {
+	.id = 0,
+	.cls = &dyn_tick_sysclass,
+};
+
+static int init_dyn_tick_sysfs(void)
+{
+	int error = 0;
+
+	if (!dyn_tick)
+		goto out;
+
+	if ((error = sysdev_class_register(&dyn_tick_sysclass)))
+		goto out;
+	if ((error = sysdev_register(&device_dyn_tick)))
+		goto out;
+	error = sysdev_create_file(&device_dyn_tick, &attr_enable);
+
+out:
+	return error;
+}
+
+late_initcall(init_dyn_tick_sysfs);
diff -puN /dev/null include/linux/dyn-tick.h
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.14-rc1-vatsa/include/linux/dyn-tick.h	2005-09-22 23:59:46.000000000 +0530
@@ -0,0 +1,84 @@
+/*
+ * linux/include/linux/dyn-tick.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DYN_TICK_TIMER_H
+#define _DYN_TICK_TIMER_H
+
+#include <linux/interrupt.h>
+#include <asm/timer.h>
+
+#define DYN_TICK_ENABLED	(1 << 1)
+
+/*
+ * Abstraction of a dynamic tick source:
+ *
+ * @state	     	: current state (bitfield)
+ * @max_skip	     	: maximum number of ticks to skip
+ * @min_skip		: minimum number of ticks to skip
+ * @enable_dyn_tick  	: called via sysfs to enable interrupt skipping
+ * @disable_dyn_tick 	: called via sysfs to disable interrupt skipping
+ * @reprogram	     	: reprogram the interrupt source to skip ticks.
+	               	  Passed with one argument - the number of ticks
+			  to skip. Called with IRQs disabled and with
+			  write_xtime_lock held.
+ * @recover_time 	: handler to recover time. Called when coming out of
+			  tickless state by each CPU.
+ * @enter_all_cpus_idle	: last cpu to go idle can call this. Typically
+			  invoked from reprogram routine.
+ * @exit_all_cpus_idle	: called when coming out of all_cpus_idle state
+ * @lock		: Used to serialize enter/exit routines
+ * 			  with modifications to nohz_cpu_mask.
+ */
+
+struct dyn_tick_timer {
+	unsigned int state;
+	unsigned long max_skip;
+	unsigned long min_skip;
+	void (*enable) (void);
+	void (*disable) (void);
+	unsigned long (*reprogram) (unsigned long);
+	unsigned long (*recover_time) (int, void *, struct pt_regs *);
+	void (*enter_all_cpus_idle) (int);
+	void (*exit_all_cpus_idle) (int);
+	spinlock_t lock;
+};
+
+extern struct dyn_tick_timer *dyn_tick;
+
+extern void dyn_tick_timer_register(struct dyn_tick_timer *new_dyntick_timer);
+extern int dyn_tick_enable(void);
+extern int dyn_tick_disable(void);
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern unsigned int dyn_tick_reprogram_timer(void);
+
+static inline int dyn_tick_enabled(void)
+{
+	return (dyn_tick->state & DYN_TICK_ENABLED);
+}
+
+#else	/* CONFIG_NO_IDLE_HZ */
+static inline unsigned int dyn_tick_reprogram_timer(void)
+{
+	return 0;
+}
+
+static inline int dyn_tick_enabled(void)
+{
+	return 0;
+}
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+/* Pick up arch specific header */
+#include <asm/dyn-tick.h>
+
+#endif	/* _DYN_TICK_TIMER_H */

_

--LZvS9be/3tNcYl/X--
