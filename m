Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWE2VZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWE2VZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWE2VY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53714 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751327AbWE2VYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:51 -0400
Date: Mon, 29 May 2006 23:25:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 24/61] lock validator: procfs
Message-ID: <20060529212509.GX3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

lock validator /proc/lockdep and /proc/lockdep_stats support.
(FIXME: should go into debugfs)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/Makefile       |    3 
 kernel/lockdep_proc.c |  345 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 348 insertions(+)

Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -13,6 +13,9 @@ obj-y     = sched.o fork.o exec_domain.o
 obj-y += time/
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_LOCKDEP) += lockdep.o
+ifeq ($(CONFIG_PROC_FS),y)
+obj-$(CONFIG_LOCKDEP) += lockdep_proc.o
+endif
 obj-$(CONFIG_FUTEX) += futex.o
 ifeq ($(CONFIG_COMPAT),y)
 obj-$(CONFIG_FUTEX) += futex_compat.o
Index: linux/kernel/lockdep_proc.c
===================================================================
--- /dev/null
+++ linux/kernel/lockdep_proc.c
@@ -0,0 +1,345 @@
+/*
+ * kernel/lockdep_proc.c
+ *
+ * Runtime locking correctness validator
+ *
+ * Started by Ingo Molnar:
+ *
+ *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * Code for /proc/lockdep and /proc/lockdep_stats:
+ *
+ */
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/kallsyms.h>
+#include <linux/debug_locks.h>
+
+#include "lockdep_internals.h"
+
+static void *l_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct lock_type *type = v;
+
+	(*pos)++;
+
+	if (type->lock_entry.next != &all_lock_types)
+		type = list_entry(type->lock_entry.next, struct lock_type,
+				  lock_entry);
+	else
+		type = NULL;
+	m->private = type;
+
+	return type;
+}
+
+static void *l_start(struct seq_file *m, loff_t *pos)
+{
+	struct lock_type *type = m->private;
+
+	if (&type->lock_entry == all_lock_types.next)
+		seq_printf(m, "all lock types:\n");
+
+	return type;
+}
+
+static void l_stop(struct seq_file *m, void *v)
+{
+}
+
+static unsigned long count_forward_deps(struct lock_type *type)
+{
+	struct lock_list *entry;
+	unsigned long ret = 1;
+
+	/*
+	 * Recurse this type's dependency list:
+	 */
+	list_for_each_entry(entry, &type->locks_after, entry)
+		ret += count_forward_deps(entry->type);
+
+	return ret;
+}
+
+static unsigned long count_backward_deps(struct lock_type *type)
+{
+	struct lock_list *entry;
+	unsigned long ret = 1;
+
+	/*
+	 * Recurse this type's dependency list:
+	 */
+	list_for_each_entry(entry, &type->locks_before, entry)
+		ret += count_backward_deps(entry->type);
+
+	return ret;
+}
+
+static int l_show(struct seq_file *m, void *v)
+{
+	unsigned long nr_forward_deps, nr_backward_deps;
+	struct lock_type *type = m->private;
+	char str[128], c1, c2, c3, c4;
+	const char *name;
+
+	seq_printf(m, "%p", type->key);
+#ifdef CONFIG_DEBUG_LOCKDEP
+	seq_printf(m, " OPS:%8ld", type->ops);
+#endif
+	nr_forward_deps = count_forward_deps(type);
+	seq_printf(m, " FD:%5ld", nr_forward_deps);
+
+	nr_backward_deps = count_backward_deps(type);
+	seq_printf(m, " BD:%5ld", nr_backward_deps);
+
+	get_usage_chars(type, &c1, &c2, &c3, &c4);
+	seq_printf(m, " %c%c%c%c", c1, c2, c3, c4);
+
+	name = type->name;
+	if (!name) {
+		name = __get_key_name(type->key, str);
+		seq_printf(m, ": %s", name);
+	} else{
+		seq_printf(m, ": %s", name);
+		if (type->name_version > 1)
+			seq_printf(m, "#%d", type->name_version);
+		if (type->subtype)
+			seq_printf(m, "/%d", type->subtype);
+	}
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+static struct seq_operations lockdep_ops = {
+	.start	= l_start,
+	.next	= l_next,
+	.stop	= l_stop,
+	.show	= l_show,
+};
+
+static int lockdep_open(struct inode *inode, struct file *file)
+{
+	int res = seq_open(file, &lockdep_ops);
+	if (!res) {
+		struct seq_file *m = file->private_data;
+
+		if (!list_empty(&all_lock_types))
+			m->private = list_entry(all_lock_types.next,
+					struct lock_type, lock_entry);
+		else
+			m->private = NULL;
+	}
+	return res;
+}
+
+static struct file_operations proc_lockdep_operations = {
+	.open		= lockdep_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static void lockdep_stats_debug_show(struct seq_file *m)
+{
+#ifdef CONFIG_DEBUG_LOCKDEP
+	unsigned int hi1 = debug_atomic_read(&hardirqs_on_events),
+		     hi2 = debug_atomic_read(&hardirqs_off_events),
+		     hr1 = debug_atomic_read(&redundant_hardirqs_on),
+		     hr2 = debug_atomic_read(&redundant_hardirqs_off),
+		     si1 = debug_atomic_read(&softirqs_on_events),
+		     si2 = debug_atomic_read(&softirqs_off_events),
+		     sr1 = debug_atomic_read(&redundant_softirqs_on),
+		     sr2 = debug_atomic_read(&redundant_softirqs_off);
+
+	seq_printf(m, " chain lookup misses:           %11u\n",
+		debug_atomic_read(&chain_lookup_misses));
+	seq_printf(m, " chain lookup hits:             %11u\n",
+		debug_atomic_read(&chain_lookup_hits));
+	seq_printf(m, " cyclic checks:                 %11u\n",
+		debug_atomic_read(&nr_cyclic_checks));
+	seq_printf(m, " cyclic-check recursions:       %11u\n",
+		debug_atomic_read(&nr_cyclic_check_recursions));
+	seq_printf(m, " find-mask forwards checks:     %11u\n",
+		debug_atomic_read(&nr_find_usage_forwards_checks));
+	seq_printf(m, " find-mask forwards recursions: %11u\n",
+		debug_atomic_read(&nr_find_usage_forwards_recursions));
+	seq_printf(m, " find-mask backwards checks:    %11u\n",
+		debug_atomic_read(&nr_find_usage_backwards_checks));
+	seq_printf(m, " find-mask backwards recursions:%11u\n",
+		debug_atomic_read(&nr_find_usage_backwards_recursions));
+
+	seq_printf(m, " hardirq on events:             %11u\n", hi1);
+	seq_printf(m, " hardirq off events:            %11u\n", hi2);
+	seq_printf(m, " redundant hardirq ons:         %11u\n", hr1);
+	seq_printf(m, " redundant hardirq offs:        %11u\n", hr2);
+	seq_printf(m, " softirq on events:             %11u\n", si1);
+	seq_printf(m, " softirq off events:            %11u\n", si2);
+	seq_printf(m, " redundant softirq ons:         %11u\n", sr1);
+	seq_printf(m, " redundant softirq offs:        %11u\n", sr2);
+#endif
+}
+
+static int lockdep_stats_show(struct seq_file *m, void *v)
+{
+	struct lock_type *type;
+	unsigned long nr_unused = 0, nr_uncategorized = 0,
+		      nr_irq_safe = 0, nr_irq_unsafe = 0,
+		      nr_softirq_safe = 0, nr_softirq_unsafe = 0,
+		      nr_hardirq_safe = 0, nr_hardirq_unsafe = 0,
+		      nr_irq_read_safe = 0, nr_irq_read_unsafe = 0,
+		      nr_softirq_read_safe = 0, nr_softirq_read_unsafe = 0,
+		      nr_hardirq_read_safe = 0, nr_hardirq_read_unsafe = 0,
+		      sum_forward_deps = 0, factor = 0;
+
+	list_for_each_entry(type, &all_lock_types, lock_entry) {
+
+		if (type->usage_mask == 0)
+			nr_unused++;
+		if (type->usage_mask == LOCKF_USED)
+			nr_uncategorized++;
+		if (type->usage_mask & LOCKF_USED_IN_IRQ)
+			nr_irq_safe++;
+		if (type->usage_mask & LOCKF_ENABLED_IRQS)
+			nr_irq_unsafe++;
+		if (type->usage_mask & LOCKF_USED_IN_SOFTIRQ)
+			nr_softirq_safe++;
+		if (type->usage_mask & LOCKF_ENABLED_SOFTIRQS)
+			nr_softirq_unsafe++;
+		if (type->usage_mask & LOCKF_USED_IN_HARDIRQ)
+			nr_hardirq_safe++;
+		if (type->usage_mask & LOCKF_ENABLED_HARDIRQS)
+			nr_hardirq_unsafe++;
+		if (type->usage_mask & LOCKF_USED_IN_IRQ_READ)
+			nr_irq_read_safe++;
+		if (type->usage_mask & LOCKF_ENABLED_IRQS_READ)
+			nr_irq_read_unsafe++;
+		if (type->usage_mask & LOCKF_USED_IN_SOFTIRQ_READ)
+			nr_softirq_read_safe++;
+		if (type->usage_mask & LOCKF_ENABLED_SOFTIRQS_READ)
+			nr_softirq_read_unsafe++;
+		if (type->usage_mask & LOCKF_USED_IN_HARDIRQ_READ)
+			nr_hardirq_read_safe++;
+		if (type->usage_mask & LOCKF_ENABLED_HARDIRQS_READ)
+			nr_hardirq_read_unsafe++;
+
+		sum_forward_deps += count_forward_deps(type);
+	}
+#ifdef CONFIG_LOCKDEP_DEBUG
+	DEBUG_WARN_ON(debug_atomic_read(&nr_unused_locks) != nr_unused);
+#endif
+	seq_printf(m, " lock-types:                    %11lu [max: %lu]\n",
+			nr_lock_types, MAX_LOCKDEP_KEYS);
+	seq_printf(m, " direct dependencies:           %11lu [max: %lu]\n",
+			nr_list_entries, MAX_LOCKDEP_ENTRIES);
+	seq_printf(m, " indirect dependencies:         %11lu\n",
+			sum_forward_deps);
+
+	/*
+	 * Total number of dependencies:
+	 *
+	 * All irq-safe locks may nest inside irq-unsafe locks,
+	 * plus all the other known dependencies:
+	 */
+	seq_printf(m, " all direct dependencies:       %11lu\n",
+			nr_irq_unsafe * nr_irq_safe +
+			nr_hardirq_unsafe * nr_hardirq_safe +
+			nr_list_entries);
+
+	/*
+	 * Estimated factor between direct and indirect
+	 * dependencies:
+	 */
+	if (nr_list_entries)
+		factor = sum_forward_deps / nr_list_entries;
+
+	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
+			nr_lock_chains, MAX_LOCKDEP_CHAINS);
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	seq_printf(m, " in-hardirq chains:             %11u\n",
+			nr_hardirq_chains);
+	seq_printf(m, " in-softirq chains:             %11u\n",
+			nr_softirq_chains);
+#endif
+	seq_printf(m, " in-process chains:             %11u\n",
+			nr_process_chains);
+	seq_printf(m, " stack-trace entries:           %11lu [max: %lu]\n",
+			nr_stack_trace_entries, MAX_STACK_TRACE_ENTRIES);
+	seq_printf(m, " combined max dependencies:     %11u\n",
+			(nr_hardirq_chains + 1) *
+			(nr_softirq_chains + 1) *
+			(nr_process_chains + 1)
+	);
+	seq_printf(m, " hardirq-safe locks:            %11lu\n",
+			nr_hardirq_safe);
+	seq_printf(m, " hardirq-unsafe locks:          %11lu\n",
+			nr_hardirq_unsafe);
+	seq_printf(m, " softirq-safe locks:            %11lu\n",
+			nr_softirq_safe);
+	seq_printf(m, " softirq-unsafe locks:          %11lu\n",
+			nr_softirq_unsafe);
+	seq_printf(m, " irq-safe locks:                %11lu\n",
+			nr_irq_safe);
+	seq_printf(m, " irq-unsafe locks:              %11lu\n",
+			nr_irq_unsafe);
+
+	seq_printf(m, " hardirq-read-safe locks:       %11lu\n",
+			nr_hardirq_read_safe);
+	seq_printf(m, " hardirq-read-unsafe locks:     %11lu\n",
+			nr_hardirq_read_unsafe);
+	seq_printf(m, " softirq-read-safe locks:       %11lu\n",
+			nr_softirq_read_safe);
+	seq_printf(m, " softirq-read-unsafe locks:     %11lu\n",
+			nr_softirq_read_unsafe);
+	seq_printf(m, " irq-read-safe locks:           %11lu\n",
+			nr_irq_read_safe);
+	seq_printf(m, " irq-read-unsafe locks:         %11lu\n",
+			nr_irq_read_unsafe);
+
+	seq_printf(m, " uncategorized locks:           %11lu\n",
+			nr_uncategorized);
+	seq_printf(m, " unused locks:                  %11lu\n",
+			nr_unused);
+	seq_printf(m, " max locking depth:             %11u\n",
+			max_lockdep_depth);
+	seq_printf(m, " max recursion depth:           %11u\n",
+			max_recursion_depth);
+	lockdep_stats_debug_show(m);
+	seq_printf(m, " debug_locks:                   %11u\n",
+			debug_locks);
+
+	return 0;
+}
+
+static int lockdep_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lockdep_stats_show, NULL);
+}
+
+static struct file_operations proc_lockdep_stats_operations = {
+	.open		= lockdep_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int __init lockdep_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("lockdep", S_IRUSR, NULL);
+	if (entry)
+		entry->proc_fops = &proc_lockdep_operations;
+
+	entry = create_proc_entry("lockdep_stats", S_IRUSR, NULL);
+	if (entry)
+		entry->proc_fops = &proc_lockdep_stats_operations;
+
+	return 0;
+}
+
+__initcall(lockdep_proc_init);
+
