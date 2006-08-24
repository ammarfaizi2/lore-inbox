Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWHXRln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWHXRln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWHXRln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:41:43 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:24987 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751618AbWHXRlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:41:42 -0400
Subject: [RFC] maximum latency tracking infrastructure
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 19:41:35 +0200
Message-Id: <1156441295.3014.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [RFC] maximum latency tracking infrastructure
From: Arjan van de Ven <arjan@linux.intel.com>

The patch below adds infrastructure to track "maximum allowable latency" for power
saving policies.

The reason for adding this infrastructure is that power management in the
idle loop needs to make a tradeoff between latency and power savings (deeper
power save modes have a longer latency to running code again). 
The code that today makes this tradeoff just does a rather simple algorithm;
however this is not good enough: There are devices and use cases where a
lower latency is required than that the higher power saving states provide.
An example would be audio playback, but another example is the ipw2100
wireless driver that right now has a very direct and ugly acpi hook to
disable some higher power states randomly when it gets certain types of
error.

The proposed solution is to have an interface where drivers can
* announce the maximum latency (in microseconds) that they can deal with
* modify this latency
* give up their constraint
and a function where the code that decides on power saving strategy can query
the current global desired maximum.

This patch has a user of each side: on the consumer side, ACPI is patched to use this,
on the producer side the ipw2100 driver is patched. 

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

---
 drivers/acpi/processor_idle.c  |    8 +
 drivers/net/wireless/ipw2100.c |   10 +
 include/linux/latency.h        |   18 +++
 kernel/Makefile                |    2 
 kernel/latency.c               |  245 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 280 insertions(+), 3 deletions(-)

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
+			cx->promotion.state->latency <= get_acceptable_latency()) {
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
+		pr->power.state->latency > get_acceptable_latency()) {
 		if (cx->demotion.state)
 			next_state = cx->demotion.state;
 	}
Index: linux-2.6.18-rc4-latency/include/linux/latency.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc4-latency/include/linux/latency.h
@@ -0,0 +1,18 @@
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
+void set_acceptable_latency(char *identifier, int usecs);
+void modify_acceptable_latency(char *identifier, int usecs);
+void remove_acceptable_latency(char *identifier);
+int get_acceptable_latency(void);
+
+#define INFINITE_LATENCY 1000000
+
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
@@ -0,0 +1,245 @@
+/*
+ * latency.c: Explicit system-wise latency-expectation infrastructure
+ *
+ * The purpose of this infrastructure is to allow device drivers to set
+ * latency requirements they have and to collect and summarize these
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
+ * requirement of, say, 150 usec.
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
+#include <asm/atomic.h>
+
+struct latency_info {
+	struct list_head list;
+	int usecs;
+	char *identifier;
+};
+
+static atomic_t current_max_latency;
+static DEFINE_SPINLOCK(latency_lock);
+
+static LIST_HEAD(latency_list);
+
+
+
+/*
+ * This function returns the maximum latency allowed, which
+ * happens to be the minimum of all maximum latencies on the
+ * list.
+ */
+static int __find_max_latency(void)
+{
+	int max = INFINITE_LATENCY;
+	struct latency_info *info;
+	list_for_each_entry(info, &latency_list, list) {
+		if (info->usecs < max) /* new minimum */
+			max = info->usecs;
+	}
+	return max;
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
+	int newmax;
+
+	info = kmalloc(sizeof(struct latency_info), GFP_KERNEL);
+	if (!info)
+		return;
+	memset(info, 0, sizeof(struct latency_info));
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
+		}
+	}
+	if (!found_old)
+		list_add(&info->list, &latency_list);
+
+	newmax = __find_max_latency();
+	atomic_set(&current_max_latency, newmax);
+
+	spin_unlock_irqrestore(&latency_lock, flags);
+
+	/* if we inserted the new one, we're done; otherwise there was
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
+ */
+void modify_acceptable_latency(char *identifier, int usecs)
+{
+	struct latency_info *iter;
+	unsigned long flags;
+	int newmax;
+
+	spin_lock_irqsave(&latency_lock, flags);
+	list_for_each_entry(iter, &latency_list, list) {
+		if (strcmp(iter->identifier, identifier)==0)
+			iter->usecs = usecs;
+	}
+	newmax = __find_max_latency();
+	atomic_set(&current_max_latency, newmax);
+	spin_unlock_irqrestore(&latency_lock, flags);
+}
+EXPORT_SYMBOL_GPL(modify_acceptable_latency);
+
+/*
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
+		if (strcmp(iter->identifier, identifier)==0)
+			list_del(&iter->list);
+			newmax = iter->usecs;
+			kfree(iter->identifier);
+			kfree(iter);
+	}
+
+	/* If we just deleted the system wide value, we need to
+	 * recalculate
+	 */
+	if (newmax == atomic_read(&current_max_latency)) {
+		newmax = __find_max_latency();
+		atomic_set(&current_max_latency, newmax);
+	}
+	spin_unlock_irqrestore(&latency_lock, flags);
+}
+EXPORT_SYMBOL_GPL(remove_acceptable_latency);
+
+/*
+ * get_acceptable_latency - queries the system wide latency maximum
+ *
+ * This function returns the system wide maximum latency in
+ * microseconds.
+ *
+ * This function does not sleep and can be called in any context.
+ */
+int get_acceptable_latency(void)
+{
+	return atomic_read(&current_max_latency);
+}
+EXPORT_SYMBOL_GPL(get_acceptable_latency);
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
+	printk(KERN_INFO "Current minimum\t: %i\n", get_acceptable_latency());
+	list_for_each_entry(info, &latency_list, list)  {
+		printk(KERN_INFO "%s\t\t: %i\n", info->identifier, info->usecs);
+	}
+	printk(KERN_INFO "-------------------------\n");
+	spin_unlock_irqrestore(&latency_lock, flags);
+}
+static struct sysrq_key_op sysrq_latlist_op = {
+	.handler        = sysrq_handle_latlist,
+	.help_msg       = "Latencylist",
+	.action_msg     = "Printing latency list",
+};
+#endif
+
+static int latency_init(void)
+{
+	register_sysrq_key('l', &sysrq_latlist_op);
+	/* we don't want by default to have longer latencies than 2 ticks,
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
+	 * longer than 500usec
+	 */
+	modify_acceptable_latency("ipw2100", 500);
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

