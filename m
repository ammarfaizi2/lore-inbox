Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWHYLXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWHYLXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWHYLXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:23:04 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:60295 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750710AbWHYLXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:23:02 -0400
Subject: [RFC] maximum latency tracking infrastructure (version 2)
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, mingo@elte.hu, akpm@osdl.org,
       jbarnes@virtuousgeek.org, dwalker@mvista.com, nickpiggin@yahoo.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 13:22:19 +0200
Message-Id: <1156504939.3032.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New in this version:
* implemented the various comments on the code
* implemented a notifier mechanism so that code can serialize on latency (Nick)
* put the max latency in the ACPI C states file

One open question is if the sysreq key is considered useful or only a bad hack..



Subject: [RFC] maximum latency tracking infrastructure
From: Arjan van de Ven <arjan@linux.intel.com>

The patch below adds infrastructure to track "maximum allowable latency" for
power saving policies.

The reason for adding this infrastructure is that power management in the
idle loop needs to make a tradeoff between latency and power savings (deeper
power save modes have a longer latency to running code again).  The code
that today makes this tradeoff just does a rather simple algorithm; however
this is not good enough: There are devices and use cases where a lower
latency is required than that the higher power saving states provide. An
example would be audio playback, but another example is the ipw2100 wireless
driver that right now has a very direct and ugly acpi hook to disable some
higher power states randomly when it gets certain types of error.

The proposed solution is to have an interface where drivers can
* announce the maximum latency (in microseconds) that they can deal with
* modify this latency
* give up their constraint
and a function where the code that decides on power saving strategy can query
the current global desired maximum.

This patch has a user of each side: on the consumer side, ACPI is patched to
use this, on the producer side the ipw2100 driver is patched.

A generic maximum latency is also registered of 2 timer ticks (more and you
lose accurate time tracking after all).

While the existing users of the patch are x86 specific, the infrastructure
is not. I'd like to ask the arch maintainers of other architectures if the
infrastructure is generic enough for their use (assuming the architecture
has such a tradeoff as concept at all), and the sound/multimedia driver
owners to look at the driver facing API to see if this is something they can
use.

A sysrq key is registered to dump the list of registered latencies so that
bugreports about too high latency / too high power usage can be analyzed.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 drivers/acpi/processor_idle.c  |   37 ++++
 drivers/net/wireless/ipw2100.c |   10 +
 include/linux/latency.h        |   28 +++
 kernel/Makefile                |    2 
 kernel/latency.c               |  309 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 381 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc4-latency/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.18-rc4-latency.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.18-rc4-latency/drivers/acpi/processor_idle.c
@@ -38,6 +38,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/latency.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -453,7 +454,8 @@ static void acpi_processor_idle(void)
 	 */
 	if (cx->promotion.state &&
 	    ((cx->promotion.state - pr->power.states) <= max_cstate)) {
-		if (sleep_ticks > cx->promotion.threshold.ticks) {
+		if (sleep_ticks > cx->promotion.threshold.ticks &&
+			cx->promotion.state->latency <= system_latency_constraint()) {
 			cx->promotion.count++;
 			cx->demotion.count = 0;
 			if (cx->promotion.count >=
@@ -494,8 +496,10 @@ static void acpi_processor_idle(void)
       end:
 	/*
 	 * Demote if current state exceeds max_cstate
+	 * or if the latency of the current state is unacceptable
 	 */
-	if ((pr->power.state - pr->power.states) > max_cstate) {
+	if ((pr->power.state - pr->power.states) > max_cstate ||
+		pr->power.state->latency > system_latency_constraint()) {
 		if (cx->demotion.state)
 			next_state = cx->demotion.state;
 	}
@@ -1009,9 +1013,10 @@ static int acpi_processor_power_seq_show
 
 	seq_printf(seq, "active state:            C%zd\n"
 		   "max_cstate:              C%d\n"
-		   "bus master activity:     %08x\n",
+		   "bus master activity:     %08x\n"
+		   "maximum allowed latency: %d usec\n",
 		   pr->power.state ? pr->power.state - pr->power.states : 0,
-		   max_cstate, (unsigned)pr->power.bm_activity);
+		   max_cstate, (unsigned)pr->power.bm_activity, system_latency_constraint());
 
 	seq_puts(seq, "states:\n");
 
@@ -1077,6 +1082,28 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 
+
+static void smp_callback(void *v)
+{
+	/* we already woke the CPU up, nothing more to do */
+}
+
+/*
+ * This function gets called when a part of the kernel has a new latency requirement.
+ * This means we need to get all processors out of their C-state, and then recalculate
+ * a new suitable C-state. Just do a cross-cpu IPI; that wakes them all right up.
+ */
+static int acpi_processor_latency_notify(struct notifier_block *b,
+		unsigned long l, void *v)
+{
+	smp_call_function(smp_callback, NULL, 0, 1);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block acpi_processor_latency_notifier = {
+	.notifier_call = acpi_processor_latency_notify,
+};
+
 int acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
@@ -1093,6 +1120,7 @@ int acpi_processor_power_init(struct acp
 			       "ACPI: processor limited to max C-state %d\n",
 			       max_cstate);
 		first_run++;
+		register_latency_notifier(&acpi_processor_latency_notifier);
 	}
 
 	if (!pr)
@@ -1164,6 +1192,7 @@ int acpi_processor_power_exit(struct acp
 		 * copies of pm_idle before proceeding.
 		 */
 		cpu_idle_wait();
+		unregister_latency_notifier(&acpi_processor_latency_notifier);
 	}
 
 	return 0;
Index: linux-2.6.18-rc4-latency/include/linux/latency.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc4-latency/include/linux/latency.h
@@ -0,0 +1,28 @@
+/*
+ * latency.h: Explicit system-wise latency-expectation infrastructure
+ *
+ * (C) Copyright 2006 Intel Corporation
+ * Author: Arjan van de Ven <arjan@linux.intel.com>
+ *
+ */
+
+#ifdef __KERNEL__
+
+#ifndef _INCLUDE_GUARD_LATENCY_H_
+#define _INCLUDE_GUARD_LATENCY_H_
+
+#include <linux/notifier.h>
+
+void set_acceptable_latency(char *identifier, int usecs);
+void modify_acceptable_latency(char *identifier, int usecs);
+void remove_acceptable_latency(char *identifier);
+void synchronize_acceptable_latency(void);
+int system_latency_constraint(void);
+
+int register_latency_notifier(struct notifier_block * nb);
+int unregister_latency_notifier(struct notifier_block * nb);
+
+#define INFINITE_LATENCY 1000000
+
+#endif
+#endif
Index: linux-2.6.18-rc4-latency/kernel/Makefile
===================================================================
--- linux-2.6.18-rc4-latency.orig/kernel/Makefile
+++ linux-2.6.18-rc4-latency/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
-	    hrtimer.o rwsem.o
+	    hrtimer.o rwsem.o latency.o
 
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
Index: linux-2.6.18-rc4-latency/kernel/latency.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc4-latency/kernel/latency.c
@@ -0,0 +1,309 @@
+/*
+ * latency.c: Explicit system-wise latency-expectation infrastructure
+ *
+ * The purpose of this infrastructure is to allow device drivers to set
+ * latency constraint they have and to collect and summarize these
+ * expectations globally. The cummulated result can then be used by
+ * power management and similar users to make decisions that have
+ * tradoffs with a latency component.
+ *
+ * An example user of this are the x86 C-states; each higher C state saves
+ * more power, but has a higher exit latency. For the idle loop power
+ * code to make a good decision which C-state to use, information about
+ * acceptable latencies is required.
+ *
+ * An example announcer of latency is an audio driver that knowns it
+ * will get an interrupt when the hardware has 200 usec of samples
+ * left in the DMA buffer; in that case the driver can set a latency
+ * constraint of, say, 150 usec.
+ *
+ * Multiple drivers can each announce their maximum accepted latency,
+ * to keep these appart, a string based identifier is used.
+ *
+ *
+ * (C) Copyright 2006 Intel Corporation
+ * Author: Arjan van de Ven <arjan@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#include <linux/latency.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/sysrq.h>
+#include <linux/notifier.h>
+#include <asm/atomic.h>
+
+struct latency_info {
+	struct list_head list;
+	int usecs;
+	char *identifier;
+};
+
+/*
+ * locking rule: all modifications to current_max_latency and
+ * latency_list need to be done while holding the latency_lock.
+ * latency_lock needs to be taken _irqsave.
+ */
+static atomic_t current_max_latency;
+static DEFINE_SPINLOCK(latency_lock);
+
+static LIST_HEAD(latency_list);
+static BLOCKING_NOTIFIER_HEAD(latency_notifier);
+
+/*
+ * This function returns the maximum latency allowed, which
+ * happens to be the minimum of all maximum latencies on the
+ * list.
+ */
+static int __find_max_latency(void)
+{
+	int min = INFINITE_LATENCY;
+	struct latency_info *info;
+
+	list_for_each_entry(info, &latency_list, list) {
+		if (info->usecs < min)
+			min = info->usecs;
+	}
+	return min;
+}
+
+/**
+ * set_acceptable_latency - sets the maximum latency acceptable
+ * @identifier: string that identifies this driver
+ * @usecs: maximum acceptable latency for this driver
+ *
+ * This function informs the kernel that this device(driver)
+ * can accept at most usecs latency. This setting is used for
+ * power management and similar tradeoffs.
+ *
+ * This function sleeps and can only be called from process
+ * context.
+ * Calling this function with an existing identifier is valid
+ * and will cause the existing latency setting to be changed.
+ */
+void set_acceptable_latency(char *identifier, int usecs)
+{
+	struct latency_info *info, *iter;
+	unsigned long flags;
+	int found_old = 0;
+
+	info = kzalloc(sizeof(struct latency_info), GFP_KERNEL);
+	if (!info)
+		return;
+	info->usecs = usecs;
+	info->identifier = kstrdup(identifier, GFP_KERNEL);
+	if (!info->identifier)
+		goto free_info;
+
+	spin_lock_irqsave(&latency_lock, flags);
+	list_for_each_entry(iter, &latency_list, list) {
+		if (strcmp(iter->identifier, identifier)==0) {
+			found_old = 1;
+			iter->usecs = usecs;
+			break;
+		}
+	}
+	if (!found_old)
+		list_add(&info->list, &latency_list);
+
+	if (usecs < atomic_read(&current_max_latency))
+		atomic_set(&current_max_latency, usecs);
+
+	spin_unlock_irqrestore(&latency_lock, flags);
+
+	blocking_notifier_call_chain(&latency_notifier,
+		atomic_read(&current_max_latency), NULL);
+
+	/*
+	 * if we inserted the new one, we're done; otherwise there was
+	 * an existing one so we need to free the redundant data
+	 */
+	if (!found_old)
+		return;
+
+	kfree(info->identifier);
+free_info:
+	kfree(info);
+}
+EXPORT_SYMBOL_GPL(set_acceptable_latency);
+
+/**
+ * modify_acceptable_latency - changes the maximum latency acceptable
+ * @identifier: string that identifies this driver
+ * @usecs: maximum acceptable latency for this driver
+ *
+ * This function informs the kernel that this device(driver)
+ * can accept at most usecs latency. This setting is used for
+ * power management and similar tradeoffs.
+ *
+ * This function does not sleep and can be called in any context.
+ * Trying to use a non-existing identifier silently gets ignored.
+ *
+ * Due to the atomic nature of this function, the modified latency
+ * value will only be used for future decisions; past decisions
+ * can still lead to longer latencies in the near future.
+ */
+void modify_acceptable_latency(char *identifier, int usecs)
+{
+	struct latency_info *iter;
+	unsigned long flags;
+
+	spin_lock_irqsave(&latency_lock, flags);
+	list_for_each_entry(iter, &latency_list, list) {
+		if (strcmp(iter->identifier, identifier)==0)
+			iter->usecs = usecs;
+		break;
+	}
+	if (usecs < atomic_read(&current_max_latency))
+		atomic_set(&current_max_latency, usecs);
+	spin_unlock_irqrestore(&latency_lock, flags);
+}
+EXPORT_SYMBOL_GPL(modify_acceptable_latency);
+
+/**
+ * remove_acceptable_latency - removes the maximum latency acceptable
+ * @identifier: string that identifies this driver
+ *
+ * This function removes a previously set maximum latency setting
+ * for the driver and frees up any resources associated with the
+ * bookkeeping needed for this.
+ *
+ * This function does not sleep and can be called in any context.
+ * Trying to use a non-existing identifier silently gets ignored.
+ */
+
+void remove_acceptable_latency(char *identifier)
+{
+	unsigned long flags;
+	int newmax = 0;
+	struct latency_info *iter, *temp;
+
+	spin_lock_irqsave(&latency_lock, flags);
+
+	list_for_each_entry_safe(iter,  temp, &latency_list, list) {
+		if (strcmp(iter->identifier, identifier)==0) {
+			list_del(&iter->list);
+			newmax = iter->usecs;
+			kfree(iter->identifier);
+			kfree(iter);
+			break;
+		}
+	}
+
+	/* If we just deleted the system wide value, we need to
+	 * recalculate with a full search
+	 */
+	if (newmax == atomic_read(&current_max_latency)) {
+		newmax = __find_max_latency();
+		atomic_set(&current_max_latency, newmax);
+	}
+	spin_unlock_irqrestore(&latency_lock, flags);
+}
+EXPORT_SYMBOL_GPL(remove_acceptable_latency);
+
+/**
+ * system_latency_constraint - queries the system wide latency maximum
+ *
+ * This function returns the system wide maximum latency in
+ * microseconds.
+ *
+ * This function does not sleep and can be called in any context.
+ */
+int system_latency_constraint(void)
+{
+	return atomic_read(&current_max_latency);
+}
+EXPORT_SYMBOL_GPL(system_latency_constraint);
+
+/**
+ * synchronize_acceptable_latency - recalculates all latency decisions
+ *
+ * This function will cause a callback to various kernel pieces that
+ * will make those pieces rethink their latency decisions. This implies
+ * that if there are overlong latencies in hardware state already, those
+ * latencies get taken right now. When this call completes no overlong
+ * latency decisions should be active anymore.
+ *
+ * Typical usecase of this is after a modify_acceptable_latency() call,
+ * which in itself is non-blocking and non-synchronizing.
+ *
+ * This function blocks and should not be called with locks held.
+ */
+
+void synchronize_acceptable_latency(void)
+{
+	blocking_notifier_call_chain(&latency_notifier,
+		atomic_read(&current_max_latency), NULL);
+}
+EXPORT_SYMBOL_GPL(synchronize_acceptable_latency);
+
+/*
+ * Latency notifier: this notifier gets called when a non-atomic new
+ * latency value gets set. The expectation nof the caller of the
+ * non-atomic set is that when the call returns, future latencies
+ * are within bounds, so the functions on the notifier list are
+ * expected to take the overlong latencies immediately, inside the
+ * callback, and not make a overlong latency decision anymore.
+ *
+ * The callback gets called when the new latency value is made
+ * active so system_latency_constraint() returns the new latency.
+ */
+int register_latency_notifier(struct notifier_block * nb)
+{
+	return blocking_notifier_chain_register(&latency_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(register_latency_notifier);
+
+int unregister_latency_notifier(struct notifier_block * nb)
+{
+	return blocking_notifier_chain_unregister(&latency_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_latency_notifier);
+
+
+#ifdef CONFIG_MAGIC_SYSRQ
+
+static void sysrq_handle_latlist(int key, struct pt_regs *pt_regs,
+                                  struct tty_struct *tty)
+{
+	unsigned long flags;
+	struct latency_info *info;
+
+	spin_lock_irqsave(&latency_lock, flags);
+	printk(KERN_INFO "Latency restrictions list\n");
+	printk(KERN_INFO "-------------------------\n");
+	printk(KERN_INFO "Current minimum\t: %i\n", system_latency_constraint());
+	list_for_each_entry(info, &latency_list, list)  {
+		printk(KERN_INFO "%s\t\t: %i\n", info->identifier, info->usecs);
+	}
+	printk(KERN_INFO "-------------------------\n");
+	spin_unlock_irqrestore(&latency_lock, flags);
+}
+
+static struct sysrq_key_op sysrq_latlist_op = {
+	.handler        = sysrq_handle_latlist,
+	.help_msg       = "Latencylist",
+	.action_msg     = "Printing latency list",
+};
+
+#endif
+
+static __init int latency_init(void)
+{
+	register_sysrq_key('l', &sysrq_latlist_op);
+	atomic_set(&current_max_latency, INFINITE_LATENCY);
+	/*
+	 * we don't want by default to have longer latencies than 2 ticks,
+	 * since that would cause lost ticks
+	 */
+	set_acceptable_latency("kernel", 2*1000000/HZ);
+	return 0;
+}
+
+module_init(latency_init);
Index: linux-2.6.18-rc4-latency/drivers/net/wireless/ipw2100.c
===================================================================
--- linux-2.6.18-rc4-latency.orig/drivers/net/wireless/ipw2100.c
+++ linux-2.6.18-rc4-latency/drivers/net/wireless/ipw2100.c
@@ -163,6 +163,7 @@ that only one external action is invoked
 #include <linux/firmware.h>
 #include <linux/acpi.h>
 #include <linux/ctype.h>
+#include <linux/latency.h>
 
 #include "ipw2100.h"
 
@@ -1697,6 +1698,11 @@ static int ipw2100_up(struct ipw2100_pri
 		return 0;
 	}
 
+	/* the ipw2100 hardware really doesn't want power management delays
+	 * longer than 175usec
+	 */
+	modify_acceptable_latency("ipw2100", 175);
+
 	/* If the interrupt is enabled, turn it off... */
 	spin_lock_irqsave(&priv->low_lock, flags);
 	ipw2100_disable_interrupts(priv);
@@ -1849,6 +1855,8 @@ static void ipw2100_down(struct ipw2100_
 	ipw2100_disable_interrupts(priv);
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 
+	modify_acceptable_latency("ipw2100", INFINITE_LATENCY);
+
 #ifdef ACPI_CSTATE_LIMIT_DEFINED
 	if (priv->config & CFG_C3_DISABLED) {
 		IPW_DEBUG_INFO(": Resetting C3 transitions.\n");
@@ -6533,6 +6541,7 @@ static int __init ipw2100_init(void)
 
 	ret = pci_module_init(&ipw2100_pci_driver);
 
+	set_acceptable_latency("ipw2100", INFINITE_LATENCY);
 #ifdef CONFIG_IPW2100_DEBUG
 	ipw2100_debug_level = debug;
 	driver_create_file(&ipw2100_pci_driver.driver,
@@ -6553,6 +6562,7 @@ static void __exit ipw2100_exit(void)
 			   &driver_attr_debug_level);
 #endif
 	pci_unregister_driver(&ipw2100_pci_driver);
+	remove_acceptable_latency("ipw2100");
 }
 
 module_init(ipw2100_init);

