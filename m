Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVK2OTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVK2OTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVK2OTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:19:42 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10178 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751353AbVK2OTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:19:41 -0500
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com, nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com, akpm@osdl.org
In-Reply-To: <p73mzjngwim.fsf@verdi.suse.de>
References: <20051118220755.GA3029@elte.hu>
	 <1132353689.4735.43.camel@cmn3.stanford.edu>
	 <1132367947.5706.11.camel@localhost.localdomain>
	 <20051124150731.GD2717@elte.hu>
	 <1132952191.24417.14.camel@localhost.localdomain>
	 <20051126130548.GA6503@elte.hu>
	 <1133232503.6328.18.camel@localhost.localdomain>
	 <20051128190253.1b7068d6.akpm@osdl.org>
	 <1133235740.6328.27.camel@localhost.localdomain>
	 <20051128200108.068b2dcd.akpm@osdl.org> <20051129064420.GA15374@elte.hu>
	 <p73mzjngwim.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 09:19:31 -0500
Message-Id: <1133273971.6328.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 11:05 -0700, Andi Kleen so nicely wrote:
> > idle=poll is also frequently done for performance reasons [it reduces 
> > idle wakeup latency by 10 usecs] 
> 
> And it's obsolete on CPUs with monitor/mwait.

And I wish my system supported it.

> And in practice the CPU will run so hot that only benchmarkers like it.

Why would it run hot?  What's the difference between polling and doing
other things.  How many transistors does it take to poll?

> 
> I think switching idle is the wrong way to do. We should rather
> fix the various problems.
> 
> For fixing the TSC issue it is 100% the wrong approach Imho.

I would only say 80% the wrong approach, but that's me ;-)

> Basically software has to live with TSCs being unsynchronized
> and gettimeofday should do the right thing (and if not it should be fixed)

I guess the biggest complaint most have is that the rdtsc _is_ the
fastest way to read a clock.  If it isn't reliable, then what good is
it?  It's unfortunate that Intel didn't solidify the clock usage. Yes,
use HPET, or something else, but those are slower, and may not be on all
systems.  Every system that I owned had a tsc but for critical systems
it isn't up to par (what a shame).

> 
> - while it could be turned off if the 
> > system has been idle for some time. E.g. cpufreqd could sample idle time 
> > and turn on/off idle=poll. High-performance setups could enable it all 
> > the time.
> 
> And upgrade their server air condition or issue additional ear protection
> to the desktop user? Most likely you will just drive the CPUs into
> thermal throttle at some point with that, not get more performance anyways.

Again, what would make it so hot?  It is a waste of CPU cycles, and does
waste energy that way, but does it really heat up the CPU that much?
It's just a loop.  I've run much more complex algorithms for days
without any problems.  I only once over heated a CPU and that was doing
some brute force calculations of prime numbers.

>   
> > as long as it can be done with zero-cost, i dont see why Steven's patch 
> > wouldnt be a plus for us. It's a performance thing, and having runtime 
> > switches for seemless performance features cannot be bad.
> 
> The interface is ugly and I suspect fixing the various obscure race this
> obscure feature would undoubtedly add will be a long term maintenance
> issue. And it's the wrong thing to do anyways because it just papers
> over other problems that should be fixed in the right way.

Oh come now, it's not that ugly.  And it would not produce any more
obscure race conditions than the current method of changing idle with
the acpi processor_idle module has.

But I'll agree that this is more of a paper over than a solution.  Too
bad I wasted a day writing and testing it (mostly just to learn about
kobjects and sysfs which I still feel is very clumsy).

But since I did clean up the patch, and it is still useful for those
debugging problems with timers.  I'm supplying this cleaned up version
(Thank you Andrew for the comments).

-- Steve

Ingo, would you like this for -rt? Even if it will never be accepted
into mainline.


[take 3]:

Index: linux-2.6.15-rc2-git5/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/i386/kernel/process.c	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/i386/kernel/process.c	2005-11-29 07:43:52.000000000 -0500
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/idle.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -72,11 +73,6 @@
 	return ((unsigned long *)tsk->thread.esp)[3];
 }
 
-/*
- * Powermanagement idle function, if any..
- */
-void (*pm_idle)(void);
-EXPORT_SYMBOL(pm_idle);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
 void disable_hlt(void)
@@ -185,7 +181,7 @@
 				__get_cpu_var(cpu_idle_state) = 0;
 
 			rmb();
-			idle = pm_idle;
+			idle = idle_func;
 
 			if (!idle)
 				idle = default_idle;
@@ -250,6 +246,11 @@
 	}
 }
 
+static struct idle_info idle_mwait = {
+	.name = "mwait",
+	.func = mwait_idle
+};
+
 void __devinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
@@ -258,25 +259,60 @@
 		 * Skip, if setup has overridden idle.
 		 * One CPU supports mwait => All CPUs supports mwait
 		 */
-		if (!pm_idle) {
+		register_idle(&idle_mwait);
+
+		if (!idle_func) {
 			printk("using mwait in idle threads.\n");
-			pm_idle = mwait_idle;
+			set_idle("mwait");
 		}
 	}
 }
 
+static struct idle_info idle_default = {
+	.name = "default",
+	.func = default_idle
+};
+
+static struct idle_info idle_poll = {
+	.name = "poll",
+	.func = poll_idle
+};
+
+static int __init add_idle(void)
+{
+	static int set;
+
+	if (set)
+		return 0;
+	set = 1;
+
+	register_idle(&idle_poll);
+
+	/*
+	 * Allow the user to switch out of poll_idle even
+	 * if it was a boot option.
+	 */
+	register_idle(&idle_default);
+
+	return 0;
+}
+
+arch_initcall(add_idle);
+
 static int __init idle_setup (char *str)
 {
+	add_idle();
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		set_idle("poll");
+
 #ifdef CONFIG_X86_SMP
 		if (smp_num_siblings > 1)
 			printk("WARNING: polling idle and HT enabled, performance may degrade.\n");
 #endif
 	} else if (!strncmp(str, "halt", 4)) {
 		printk("using halt in idle threads.\n");
-		pm_idle = default_idle;
+		set_idle("default");
 	}
 
 	boot_option_idle_override = 1;
Index: linux-2.6.15-rc2-git5/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/x86_64/kernel/process.c	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/x86_64/kernel/process.c	2005-11-29 07:45:44.000000000 -0500
@@ -36,6 +36,8 @@
 #include <linux/utsname.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/spinlock.h>
+#include <linux/idle.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -60,10 +62,6 @@
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-/*
- * Powermanagement idle function, if any..
- */
-void (*pm_idle)(void);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
 void disable_hlt(void)
@@ -195,7 +193,7 @@
 				__get_cpu_var(cpu_idle_state) = 0;
 
 			rmb();
-			idle = pm_idle;
+			idle = idle_func;
 			if (!idle)
 				idle = default_idle;
 			if (cpu_is_offline(smp_processor_id()))
@@ -229,29 +227,68 @@
 	}
 }
 
+static struct idle_info idle_mwait = {
+	.name = "mwait",
+	.func = mwait_idle
+};
+
 void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	static int printed;
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
+		register_idle(&idle_mwait);
+
 		/*
 		 * Skip, if setup has overridden idle.
 		 * One CPU supports mwait => All CPUs supports mwait
 		 */
-		if (!pm_idle) {
+		if (!idle_func) {
 			if (!printed) {
 				printk("using mwait in idle threads.\n");
 				printed = 1;
 			}
-			pm_idle = mwait_idle;
+			set_idle("mwait");
 		}
 	}
 }
 
+static struct idle_info idle_default = {
+	.name = "default",
+	.func = default_idle
+};
+
+static struct idle_info idle_poll = {
+	.name = "poll",
+	.func = poll_idle
+};
+
+static int __init add_idle(void)
+{
+	static int set;
+
+	if (set)
+		return 0;
+	set = 1;
+
+	register_idle(&idle_poll);
+
+	/*
+	 * Allow the user to switch out of poll_idle even
+	 * if it was a boot option.
+	 */
+	register_idle(&idle_default);
+
+	return 0;
+}
+arch_initcall(add_idle);
+
 static int __init idle_setup (char *str)
 {
+	add_idle();
+
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		set_idle("poll");
 	}
 
 	boot_option_idle_override = 1;
Index: linux-2.6.15-rc2-git5/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/drivers/acpi/processor_idle.c	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/drivers/acpi/processor_idle.c	2005-11-29 07:47:52.000000000 -0500
@@ -38,6 +38,8 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/spinlock.h>
+#include <linux/idle.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -56,6 +58,7 @@
 #define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 static void (*pm_idle_save) (void);
 module_param(max_cstate, uint, 0644);
+#define PM_IDLE_NAME "pm_idle"
 
 static unsigned int nocst = 0;
 module_param(nocst, uint, 0000);
@@ -891,13 +894,13 @@
 		return_VALUE(-ENODEV);
 
 	/* Fall back to the default idle loop */
-	pm_idle = pm_idle_save;
+	set_idle(NULL);
 	synchronize_sched();	/* Relies on interrupts forcing exit from idle. */
 
 	pr->flags.power = 0;
 	result = acpi_processor_get_power_info(pr);
 	if ((pr->flags.power == 1) && (pr->flags.power_setup_done))
-		pm_idle = acpi_processor_idle;
+		set_idle(PM_IDLE_NAME);
 
 	return_VALUE(result);
 }
@@ -983,6 +986,12 @@
 	.release = single_release,
 };
 
+static struct idle_info pm_idle_info = {
+	.name = PM_IDLE_NAME,
+	.func = acpi_processor_idle,
+	.freeze = 1
+};
+
 int acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
@@ -1032,8 +1041,12 @@
 		printk(")\n");
 
 		if (pr->id == 0) {
-			pm_idle_save = pm_idle;
-			pm_idle = acpi_processor_idle;
+			register_idle(&pm_idle_info);
+			/*
+			 * Just use the default idle
+			 */
+			pm_idle_save = get_idle(NULL);
+			set_idle(PM_IDLE_NAME);
 		}
 	}
 
@@ -1068,8 +1081,8 @@
 
 	/* Unregister the idle handler when processor #0 is removed. */
 	if (pr->id == 0) {
-		pm_idle = pm_idle_save;
-
+		set_idle(NULL);
+		unregister_idle(PM_IDLE_NAME);
 		/*
 		 * We are about to unload the current idle thread pm callback
 		 * (pm_idle), Wait for all processors to update cached/local
Index: linux-2.6.15-rc2-git5/include/linux/pm.h
===================================================================
--- linux-2.6.15-rc2-git5.orig/include/linux/pm.h	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/include/linux/pm.h	2005-11-28 20:31:47.000000000 -0500
@@ -25,6 +25,7 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/spinlock.h>
 #include <asm/atomic.h>
 
 /*
@@ -102,6 +103,8 @@
  */
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
+extern spinlock_t pm_idle_switch_lock;
+extern int pm_idle_locked;
 
 typedef int __bitwise suspend_state_t;
 
Index: linux-2.6.15-rc2-git5/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/x86_64/Kconfig	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/x86_64/Kconfig	2005-11-28 20:31:47.000000000 -0500
@@ -69,6 +69,10 @@
 	bool
 	default y
 
+config DYNAMIC_IDLE
+	bool
+	default y
+
 source "init/Kconfig"
 
 
Index: linux-2.6.15-rc2-git5/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/x86_64/kernel/x8664_ksyms.c	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/x86_64/kernel/x8664_ksyms.c	2005-11-28 20:31:47.000000000 -0500
@@ -58,7 +58,6 @@
 EXPORT_SYMBOL(disable_irq_nosync);
 EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
 
Index: linux-2.6.15-rc2-git5/include/linux/idle.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2-git5/include/linux/idle.h	2005-11-28 20:31:47.000000000 -0500
@@ -0,0 +1,71 @@
+/*
+ *  idle.h - Registering of the idle function (for supported archs)
+ *
+ *  Copyright (C) 2005 Steven Rostedt <rostedt@goodmis.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _LINUX_IDLE_H
+#define _LINUX_IDLE_H
+
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/kobject.h>
+#include <asm/atomic.h>
+
+typedef void (*idlefunc_t)(void);
+
+struct idle_info {
+	struct list_head list;
+	const char *name;	/* Name visible to users */
+	idlefunc_t func;	/* idle function to run  */
+	int freeze;		/* Only allow kernel to add or remove */
+	int inuse;		/* set when being used */
+#ifdef CONFIG_SYSFS
+	struct kobject kobj;
+#endif
+};
+
+/*
+ * Registering and unregistering functions that may be used
+ * instead of the default idle function.  This only adds
+ * them to the list of functions to be used, it does not
+ * set the
+ */
+extern int register_idle(struct idle_info *info);
+extern int unregister_idle(const char *name);
+
+/*
+ * This sets the idle function to the registered function
+ * by name.  Use NULL to set the idle function back to
+ * the default.
+ */
+extern int set_idle(const char *name);
+
+/*
+ * Return the function that is registered by name.
+ * Use NULL to get the default function.
+ * NULL may be returned (as that may be what the current
+ * idle function is set to, to use a default). NULL will
+ * also be returned if name is not registered.
+ */
+extern idlefunc_t get_idle(const char *name);
+
+extern idlefunc_t idle_func;
+
+#endif /* _LINUX_IDLE_H */
Index: linux-2.6.15-rc2-git5/kernel/Makefile
===================================================================
--- linux-2.6.15-rc2-git5.orig/kernel/Makefile	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/kernel/Makefile	2005-11-28 20:31:47.000000000 -0500
@@ -32,6 +32,7 @@
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_DYNAMIC_IDLE) += idle.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.15-rc2-git5/kernel/idle.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2-git5/kernel/idle.c	2005-11-28 20:31:47.000000000 -0500
@@ -0,0 +1,308 @@
+/*
+ *  kernel/idle.c
+ *
+ *  Setting up of the idle function to be dynamic.
+ *
+ *  Copyright (C) 2005 Steven Rostedt
+ */
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/spinlock.h>
+#include <linux/idle.h>
+
+idlefunc_t idle_func;
+
+static void (*idle_default)(void);
+static LIST_HEAD(idle_elements);
+static DECLARE_MUTEX(idle_sem);
+static struct idle_info *curr_idle;
+
+#ifdef CONFIG_SYSFS
+int idle_sysfs_init;
+#endif
+
+extern void poll_idle (void);
+
+static struct idle_info *__find_idle_info(const char *name)
+{
+	struct list_head *curr;
+	struct idle_info *p;
+	/*
+	 * A little inefficient, but this isn't called often.
+	 */
+	list_for_each(curr, &idle_elements) {
+		p = list_entry(curr, struct idle_info, list);
+		if (!strcmp(name, p->name))
+			break;
+	}
+	if (curr == &idle_elements)
+		p = NULL;
+
+	return p;
+}
+
+int register_idle(struct idle_info *info)
+{
+	struct idle_info *p;
+	int ret = -EEXIST;
+
+	BUG_ON(!info->name);
+
+	down(&idle_sem);
+
+	p = __find_idle_info(info->name);
+	if (p)
+		goto out;
+	ret = 0;
+
+	list_add(&info->list, &idle_elements);
+
+out:
+	up(&idle_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_idle);
+
+int unregister_idle(const char *name)
+{
+	struct idle_info *p;
+	int ret = -EINVAL;
+
+	BUG_ON(!name);
+
+	down(&idle_sem);
+
+	p = __find_idle_info(name);
+	if (!p)
+		goto out;
+	if (p->inuse) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = 0;
+
+	list_del_init(&p->list);
+
+out:
+	up(&idle_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_idle);
+
+static int __set_idle(struct idle_info *info)
+{
+	if (curr_idle)
+		curr_idle->inuse--;
+	info->inuse++;
+	curr_idle = info;
+	return 0;
+}
+
+int set_idle(const char *name)
+{
+	struct idle_info *p;
+	int ret = 0;
+
+	down(&idle_sem);
+
+	if (!name) {
+		/* Set to the default function */
+		if (curr_idle) {
+			curr_idle->inuse--;
+			curr_idle = NULL;
+		}
+		idle_func = idle_default;
+		goto out;
+	}
+
+	ret = -EINVAL;
+	p = __find_idle_info(name);
+	if (!p)
+		goto out;
+
+	__set_idle(p);
+out:
+	up(&idle_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(set_idle);
+
+idlefunc_t get_idle(const char *name)
+{
+	struct idle_info *p;
+	idlefunc_t ret = idle_default;
+
+	down(&idle_sem);
+
+	if (!name)
+		goto out;
+
+	p = __find_idle_info(name);
+	if (!p)
+		goto out;
+
+	ret = p->func;
+out:
+	up(&idle_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(get_idle);
+
+#ifdef CONFIG_SYSFS
+#define KERNEL_ATTR_RW(_name) \
+static struct subsys_attribute _name##_attr = \
+	__ATTR(_name, 0644, _name##_show, _name##_store)
+
+static struct idlep_kobject
+{
+	struct kobject kobj;
+} idle_kobj;
+
+static ssize_t idle_ctrl_show(struct subsystem *subsys, char *page)
+{
+	ssize_t ret;
+	char *star = "";
+	const char *name = "default";
+
+	down(&idle_sem);
+	if (curr_idle) {
+		name = curr_idle->name;
+		if (curr_idle->freeze)
+			star = "*";
+	}
+	ret = sprintf(page, "%s%s\n", star, name);
+	up(&idle_sem);
+
+	return ret;
+}
+
+static ssize_t idle_ctrl_store(struct subsystem *subsys,
+			       const char *buf, size_t len)
+{
+	struct list_head *curr;
+	struct idle_info *p;
+	ssize_t ret = -EBUSY;
+
+	down(&idle_sem);
+
+	if (curr_idle && curr_idle->freeze)
+		goto out;
+
+	list_for_each(curr, &idle_elements) {
+		int size;
+		p = list_entry(curr, struct idle_info, list);
+
+		size = strlen(p->name);
+		if (len <= size)
+			continue;
+		if (!strncmp(p->name, buf, size))
+			break;
+	}
+	if (curr == &idle_elements) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * This idle routine may have been registered to
+	 * not allow users to add or remove this.
+	 */
+	if (p->freeze)
+		goto out;
+
+	__set_idle(p);
+
+	ret = len;
+out:
+	up(&idle_sem);
+
+	return ret;
+}
+
+KERNEL_ATTR_RW(idle_ctrl);
+
+static ssize_t idle_methods_show(struct subsystem *subsys, char *page)
+{
+	struct list_head *curr;
+	struct idle_info *p;
+	ssize_t len = 0;
+
+	down(&idle_sem);
+	list_for_each(curr, &idle_elements) {
+		p = list_entry(curr, struct idle_info, list);
+		if (len + 3 + strlen(p->name) >= PAGE_SIZE) {
+			printk("idle functions overflowed sysfs??\n");
+			break;
+		}
+		len += sprintf(page+len, "%s%s%s",
+			       len ? " " : "",
+			       p->freeze ? "*" : "",
+			       p->name);
+	}
+	if (len + 2 < PAGE_SIZE)
+		len += sprintf(page+len, "\n");
+
+	up(&idle_sem);
+	return len;
+}
+
+static ssize_t idle_methods_store(struct subsystem *subsys,
+				  const char *buf, size_t len)
+{
+	/* do nothing */
+	return len;
+}
+
+KERNEL_ATTR_RW(idle_methods);
+
+static struct attribute * idle_attrs[] = {
+	&idle_ctrl_attr.attr,
+	&idle_methods_attr.attr,
+	NULL
+};
+
+static struct attribute_group idle_attr_group = {
+	.attrs = idle_attrs,
+};
+
+static int __init idle_setup_sysfs(void)
+{
+	int err;
+
+	memset(&idle_kobj, 0, sizeof(idle_kobj));
+	err = kobject_set_name(&idle_kobj.kobj, "%s", "idle");
+	if (err)
+		goto out;
+
+	kobj_set_kset_s(&idle_kobj, kernel_subsys);
+
+	idle_kobj.kobj.parent = &kernel_subsys.kset.kobj;
+	err = kobject_register(&idle_kobj.kobj);
+	if (err)
+		goto out;
+
+	err = sysfs_create_group(&idle_kobj.kobj,
+				 &idle_attr_group);
+	if (err)
+		goto out;
+
+       	return 0;
+out:
+	printk(KERN_INFO "Problem setting up sysfs idle_ctrl\n");
+	return 0;
+}
+#endif /* CONFIG_SYSFS */
+
+static int __init idle_setup(void)
+{
+	idle_default = idle_func;
+
+#ifdef CONFIG_SYSFS
+	idle_setup_sysfs();
+#endif
+	return 0;
+}
+
+late_initcall(idle_setup);
Index: linux-2.6.15-rc2-git5/arch/i386/Kconfig
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/i386/Kconfig	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/i386/Kconfig	2005-11-28 20:31:47.000000000 -0500
@@ -45,6 +45,10 @@
 	bool
 	default y
 
+config DYNAMIC_IDLE
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "Processor type and features"
Index: linux-2.6.15-rc2-git5/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/i386/kernel/apm.c	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/i386/kernel/apm.c	2005-11-28 20:31:47.000000000 -0500
@@ -225,6 +225,7 @@
 #include <linux/smp_lock.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
+#include <linux/idle.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -2220,6 +2221,9 @@
 	{ }
 };
 
+static struct idle_info apm_idle;
+#define APM_IDLE_NAME "apm"
+
 /*
  * Just start the APM thread. We do NOT want to do APM BIOS
  * calls from anything but the APM thread, if for no other reason
@@ -2373,8 +2377,14 @@
 	if (HZ != 100)
 		idle_period = (idle_period * HZ) / 100;
 	if (idle_threshold < 100) {
-		original_pm_idle = pm_idle;
-		pm_idle  = apm_cpu_idle;
+                memset(&apm_idle, 0, sizeof(apm_idle));
+                apm_idle.name = APM_IDLE_NAME;
+                apm_idle.func = apm_cpu_idle;
+                apm_idle.freeze = 1;
+                register_idle(&apm_idle);
+
+		original_pm_idle = get_idle(NULL);
+                set_idle(APM_IDLE_NAME);
 		set_pm_idle = 1;
 	}
 
@@ -2386,7 +2396,26 @@
 	int	error;
 
 	if (set_pm_idle) {
-		pm_idle = original_pm_idle;
+		int tries = 0;
+		int ret;
+		set_idle(NULL);
+		do {
+			if ((ret = unregister_idle(APM_IDLE_NAME)) == 0)
+				break;
+			/*
+			 * for some reason the idle function is being used.
+			 * Wait a little and then try again.
+			 */
+			if (ret == -EINVAL) {
+				printk(KERN_WARNING
+				       "APM idle function never registered?\n");
+				break;
+			}
+			yield();
+		} while (tries++ < 10);
+		if (tries > 10)
+			printk(KERN_WARNING
+			       "Unable to unresgister APM idle function\n");
 		/*
 		 * We are about to unload the current idle thread pm callback
 		 * (pm_idle), Wait for all processors to update cached/local
Index: linux-2.6.15-rc2-git5/arch/ia64/Kconfig
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/ia64/Kconfig	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/ia64/Kconfig	2005-11-28 20:31:47.000000000 -0500
@@ -62,6 +62,10 @@
 	bool
 	default y
 
+config DYNAMIC_IDLE
+	bool
+	default y
+
 choice
 	prompt "System type"
 	default IA64_GENERIC
Index: linux-2.6.15-rc2-git5/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/ia64/kernel/acpi.c	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/ia64/kernel/acpi.c	2005-11-28 20:31:47.000000000 -0500
@@ -60,8 +60,6 @@
 
 #define PREFIX			"ACPI: "
 
-void (*pm_idle) (void);
-EXPORT_SYMBOL(pm_idle);
 void (*pm_power_off) (void);
 EXPORT_SYMBOL(pm_power_off);
 
Index: linux-2.6.15-rc2-git5/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/ia64/kernel/process.c	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/ia64/kernel/process.c	2005-11-28 20:31:47.000000000 -0500
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/kprobes.h>
+#include <linux/idle.h>
 
 #include <asm/cpu.h>
 #include <asm/delay.h>
@@ -289,7 +290,7 @@
 			if (mark_idle)
 				(*mark_idle)(1);
 
-			idle = pm_idle;
+			idle = idle_func;
 			if (!idle)
 				idle = default_idle;
 			(*idle)();
Index: linux-2.6.15-rc2-git5/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/ia64/kernel/setup.c	2005-11-28 20:31:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/ia64/kernel/setup.c	2005-11-29 07:46:59.000000000 -0500
@@ -43,6 +43,7 @@
 #include <linux/initrd.h>
 #include <linux/platform.h>
 #include <linux/pm.h>
+#include <linux/idle.h>
 
 #include <asm/ia32.h>
 #include <asm/machvec.h>
@@ -738,6 +739,11 @@
 		ia64_max_cacheline_size = max;
 }
 
+struct idle_info idle_default = {
+	.name = "default",
+	.func = default_idle
+};
+
 /*
  * cpu_init() initializes state that is per-CPU.  This function acts
  * as a 'CPU state barrier', nothing should get across.
@@ -861,7 +867,10 @@
 	/* size of physical stacked register partition plus 8 bytes: */
 	__get_cpu_var(ia64_phys_stacked_size_p8) = num_phys_stacked*8 + 8;
 	platform_cpu_init();
-	pm_idle = default_idle;
+
+	register_idle(&idle_default);
+
+	set_idle("default");
 }
 
 void


