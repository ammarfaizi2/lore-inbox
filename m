Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVJaLIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVJaLIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVJaLIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:08:54 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:46772 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751081AbVJaLIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:08:52 -0500
Message-ID: <4365FB42.7040502@sdl.hitachi.co.jp>
Date: Mon, 31 Oct 2005 20:08:50 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>, noboru.obata.ar@hitachi.com,
       systemtap@sources.redhat.com
Subject: [RFC][PATCH 2/3]Djprobe (Direct Jump Probe) for 2.6.14-rc5-mm1
References: <4365FA24.7030207@sdl.hitachi.co.jp> <4365FB01.2070505@sdl.hitachi.co.jp>
In-Reply-To: <4365FB01.2070505@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is the architecture independant part of djprobe.
The djprobe would replace the kernel codes (target codes) to insert
a jump instruction.
But the target codes may be run by other processors. So the djprobe
should ensure that no other processor is running on the target codes.
First, the djprobe makes a bypass route from a copy of the target codes.
And it inserts kprobes at the top address of the target codes. Thus
other processors can detour the target codes by using the bypass route.
Next, the djprobe runs works on other processors and waits until all
works are finished to run. After that, it can ensure other processors
are not running on the target codes.

So, it can replace the target codes to a jump instruction safely.

---
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 include/linux/djprobe.h |   80 +++++++++++++++
 include/linux/kprobes.h |    4
 kernel/Makefile         |    1
 kernel/djprobe.c        |  253 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kprobes.c        |    8 +
 5 files changed, 345 insertions(+), 1 deletion(-)
diff -Narup linux-2.6.14-rc5-mm1.djp.1/include/linux/djprobe.h linux-2.6.14-rc5-mm1.djp.2/include/linux/djprobe.h
--- linux-2.6.14-rc5-mm1.djp.1/include/linux/djprobe.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.2/include/linux/djprobe.h	2005-10-26 15:52:22.000000000 +0900
@@ -0,0 +1,80 @@
+#ifndef _LINUX_DJPROBE_H
+#define _LINUX_DJPROBE_H
+/*
+ *  Kernel Direct Jump Probe (Djprobe)
+ *  include/linux/djprobe.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) Hitachi, Ltd. 2005
+ *
+ * 2005-Aug	Created by Masami HIRAMATSU <hiramatu@sdl.hitachi.co.jp>
+ * 		Initial implementation of Direct jump probe (djprobe)
+ *              to reduce overhead.
+ */
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/smp.h>
+#include <linux/kprobes.h>
+#include <asm/djprobe.h>
+
+struct djprobe;
+/* djprobe's instance (internal use)*/
+struct djprobe_instance {
+	struct list_head plist; /* list of djprobes for multiprobe support */
+	struct arch_djprobe_stub stub;
+	struct kprobe kp;
+	struct hlist_node hlist; /* list of djprobe_instances */
+};
+#define DJPI_EMPTY(djpi)  (list_empty(&djpi->plist))
+
+struct djprobe;
+typedef void (*djprobe_handler_t) (struct djprobe *, struct pt_regs *);
+/*
+ * Direct Jump probe interface structure
+ */
+struct djprobe {
+	/* list of djprobes */
+	struct list_head plist;
+
+	/* probing handler (pre-executed) */
+	djprobe_handler_t handler;
+	
+	/* pointer for instance */
+	struct djprobe_instance *inst;
+};
+
+#ifdef CONFIG_DJPROBE
+extern int arch_prepare_djprobe_instance(struct djprobe_instance *djpi,
+					 unsigned long size);
+extern int djprobe_pre_handler(struct kprobe *, struct pt_regs *);
+extern void djprobe_post_handler(struct kprobe *, struct pt_regs *,
+				 unsigned long);
+extern void arch_install_djprobe_instance(struct djprobe_instance *djpi);
+extern void arch_uninstall_djprobe_instance(struct djprobe_instance *djpi);
+struct djprobe_instance *__kprobes get_djprobe_instance(void *addr, int size);
+
+int register_djprobe(struct djprobe *p, void *addr, int size);
+void unregister_djprobe(struct djprobe *p);
+#else /* CONFIG_DJPROBE */
+static inline int register_djprobe(struct djprobe *p)
+{
+	return -ENOSYS;
+}
+static inline void unregister_djprobe(struct djprobe *p)
+{
+}
+#endif				/* CONFIG_DJPROBE */
+#endif				/* _LINUX_DJPROBE_H */
diff -Narup linux-2.6.14-rc5-mm1.djp.1/include/linux/kprobes.h linux-2.6.14-rc5-mm1.djp.2/include/linux/kprobes.h
--- linux-2.6.14-rc5-mm1.djp.1/include/linux/kprobes.h	2005-10-25 13:11:26.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.2/include/linux/kprobes.h	2005-10-25 13:32:59.000000000 +0900
@@ -163,10 +163,14 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern kprobe_opcode_t *get_insn_slot(void);
 extern void free_insn_slot(kprobe_opcode_t *slot);
+extern kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_page_list *pages);
+extern void __free_insn_slot(struct kprobe_insn_page_list *pages,
+			     kprobe_opcode_t * slot);

 /* Get the kprobe at this addr (if any) - called under a rcu_read_lock() */
 struct kprobe *get_kprobe(void *addr);
 struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
+int in_kprobes_functions(unsigned long addr);

 /* kprobe_running() will just return the current_kprobe on this CPU */
 static inline struct kprobe *kprobe_running(void)
diff -Narup linux-2.6.14-rc5-mm1.djp.1/kernel/djprobe.c linux-2.6.14-rc5-mm1.djp.2/kernel/djprobe.c
--- linux-2.6.14-rc5-mm1.djp.1/kernel/djprobe.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.2/kernel/djprobe.c	2005-10-27 11:59:10.000000000 +0900
@@ -0,0 +1,253 @@
+/*
+ *  Kernel Direct Jump Probe (Djprobe)
+ *  kernel/djprobes.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) Hitachi, Ltd. 2005
+ *
+ * 2005-Aug	Created by Masami HIRAMATSU <hiramatu@sdl.hitachi.co.jp>
+ * 		Initial implementation of Direct jump probe (djprobe)
+ *              to reduce overhead.
+ */
+#include <linux/djprobe.h>
+#include <linux/hash.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleloader.h>
+#include <asm-generic/sections.h>
+#include <asm/cacheflush.h>
+#include <asm/errno.h>
+
+#include <linux/cpu.h>
+#include <linux/percpu.h>
+#include <asm/semaphore.h>
+
+/*
+ * The djprobe do not refer instances list when probe function called.
+ * This list is operated on registering and unregistering djprobe.
+ */
+#define DJPROBE_BLOCK_BITS 6
+#define DJPROBE_BLOCK_SIZE (1 << DJPROBE_BLOCK_BITS)
+#define DJPROBE_HASH_BITS 8
+#define DJPROBE_TABLE_SIZE (1 << DJPROBE_HASH_BITS)
+#define DJPROBE_TABLE_MASK (DJPROBE_TABLE_SIZE - 1)
+
+/* djprobe instance hash table */
+static struct hlist_head djprobe_inst_table[DJPROBE_TABLE_SIZE];
+
+#define hash_djprobe(key) \
+	(((unsigned long)(key) >> DJPROBE_BLOCK_BITS) & DJPROBE_TABLE_MASK)
+
+static DECLARE_MUTEX(djprobe_mutex);
+static DEFINE_PER_CPU(struct work_struct, djprobe_works);
+static DECLARE_WAIT_QUEUE_HEAD(djprobe_wqh);
+static atomic_t djprobe_count = ATOMIC_INIT(0);
+
+/* Instruction pages for djprobe's stub code */
+static struct kprobe_insn_page_list djprobe_insn_pages = {
+	HLIST_HEAD_INIT, 0
+};
+
+static inline void __free_djprobe_instance(struct djprobe_instance *djpi)
+{
+	hlist_del(&djpi->hlist);
+	if (djpi->kp.addr) {
+		unregister_kprobe(&(djpi->kp));
+	}
+	if (djpi->stub.insn)
+		__free_insn_slot(&djprobe_insn_pages, djpi->stub.insn);
+	kfree(djpi);
+}
+
+static inline
+    struct djprobe_instance *__create_djprobe_instance(struct djprobe *djp,
+						       void *addr, int size)
+{
+	struct djprobe_instance *djpi;
+	/* allocate a new instance */
+	djpi = kcalloc(1, sizeof(struct djprobe_instance), GFP_ATOMIC);
+	if (djpi == NULL) {
+		goto out;
+	}
+	/* allocate stub */
+	djpi->stub.insn = __get_insn_slot(&djprobe_insn_pages);
+	if (djpi->stub.insn == NULL) {
+		__free_djprobe_instance(djpi);
+		djpi = NULL;
+		goto out;
+	}
+
+	/* attach */
+	djp->inst = djpi;
+	INIT_LIST_HEAD(&djpi->plist);
+	list_add_rcu(&djp->plist, &djpi->plist);
+	djpi->kp.addr = addr;
+	djpi->kp.pre_handler = djprobe_pre_handler;
+	djpi->kp.post_handler = djprobe_post_handler;
+	arch_prepare_djprobe_instance(djpi, size);
+
+	INIT_HLIST_NODE(&djpi->hlist);
+	hlist_add_head(&djpi->hlist, &djprobe_inst_table[hash_djprobe(addr)]);
+      out:
+	return djpi;
+}
+
+static struct djprobe_instance *__kprobes __get_djprobe_instance(void *addr,
+								 int size)
+{
+	struct djprobe_instance *djpi;
+	struct hlist_node *node;
+	unsigned long idx, eidx;
+
+	idx = hash_djprobe(addr - ARCH_STUB_INSN_MAX);
+	eidx = ((hash_djprobe(addr + size) + 1) & DJPROBE_TABLE_MASK);
+	do {
+		hlist_for_each_entry(djpi, node, &djprobe_inst_table[idx],
+				     hlist) {
+			if (((long)addr <
+			     (long)djpi->kp.addr + DJPI_ARCH_SIZE(djpi))
+			    && ((long)djpi->kp.addr < (long)addr + size)) {
+				return djpi;
+			}
+		}
+		idx = ((idx + 1) & DJPROBE_TABLE_MASK);
+	}while (idx != eidx);
+
+	return NULL;
+}
+
+struct djprobe_instance *__kprobes get_djprobe_instance(void *addr, int size)
+{
+	struct djprobe_instance *djpi;
+	down(&djprobe_mutex);
+	djpi = __get_djprobe_instance(addr, size);
+	up(&djprobe_mutex);
+	return djpi;
+}
+
+/* This work function invoked while djprobe_mutex is locked. */
+static void __kprobes __work_check_safety(void *data)
+{
+	if (atomic_dec_and_test(&djprobe_count)) {
+		wake_up_all(&djprobe_wqh);
+	}
+}
+
+static void __kprobes __check_safety(void)
+{
+	int cpu;
+	struct work_struct *wk;
+	lock_cpu_hotplug();
+	atomic_set(&djprobe_count, num_online_cpus() - 1);
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		wk = &per_cpu(djprobe_works, cpu);
+		INIT_WORK(wk, __work_check_safety, NULL);
+		schedule_delayed_work_on(cpu, wk, 0);
+	}
+	wait_event(djprobe_wqh, (atomic_read(&djprobe_count) == 0));
+	unlock_cpu_hotplug();
+}
+
+int __kprobes register_djprobe(struct djprobe *djp, void *addr, int size)
+{
+	struct djprobe_instance *djpi;
+	struct kprobe *kp;
+	int ret = 0, i;
+
+	BUG_ON(in_interrupt());
+
+	if (size > ARCH_STUB_INSN_MAX || size < ARCH_STUB_INSN_MIN)
+		return -EINVAL;
+
+	if ((ret = in_kprobes_functions((unsigned long)addr)) != 0)
+		return ret;
+
+	down(&djprobe_mutex);
+	INIT_LIST_HEAD(&djp->plist);
+	/* check confliction with other djprobes */
+	djpi = __get_djprobe_instance(addr, size);
+	if (djpi) {
+		if (djpi->kp.addr == addr) {
+			djp->inst = djpi;	/* add to another instance */
+			list_add_rcu(&djp->plist, &djpi->plist);
+		} else {
+			ret = -EEXIST;	/* other djprobes were inserted */
+		}
+		goto out;
+	}
+	djpi = __create_djprobe_instance(djp, addr, size);
+	if (djpi == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* check confliction with kprobes */
+	for (i = 0; i < size; i++) {
+		kp = get_kprobe((void *)((long)addr + i));
+		if (kp != NULL) {
+			ret = -EEXIST;	/* a kprobes were inserted */
+			goto fail;
+		}
+	}
+	ret = register_kprobe(&djpi->kp);
+	if (ret < 0) {
+       fail:
+		djpi->kp.addr = NULL;
+		djp->inst = NULL;
+		list_del_rcu(&djp->plist);
+		__free_djprobe_instance(djpi);
+	} else {
+		__check_safety();
+		arch_install_djprobe_instance(djpi);
+	}
+       out:
+	up(&djprobe_mutex);
+	return ret;
+}
+
+void __kprobes unregister_djprobe(struct djprobe *djp)
+{
+	struct djprobe_instance *djpi;
+
+	BUG_ON(in_interrupt());
+
+	down(&djprobe_mutex);
+	djpi = djp->inst;
+	if (djp->plist.next == djp->plist.prev) {
+		arch_uninstall_djprobe_instance(djpi);	/* this requires irq enabled */
+		list_del_rcu(&djp->plist);
+		djp->inst = NULL;
+		__check_safety();
+		__free_djprobe_instance(djpi);
+	} else {
+		list_del_rcu(&djp->plist);
+		djp->inst = NULL;
+	}
+	up(&djprobe_mutex);
+}
+
+static int __init init_djprobe(void)
+{
+	djprobe_insn_pages.insn_size = ARCH_STUB_SIZE;
+	return 0;
+}
+
+__initcall(init_djprobe);
+
+EXPORT_SYMBOL_GPL(register_djprobe);
+EXPORT_SYMBOL_GPL(unregister_djprobe);
diff -Narup linux-2.6.14-rc5-mm1.djp.1/kernel/kprobes.c linux-2.6.14-rc5-mm1.djp.2/kernel/kprobes.c
--- linux-2.6.14-rc5-mm1.djp.1/kernel/kprobes.c	2005-10-25 13:13:58.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.2/kernel/kprobes.c	2005-10-26 15:53:05.000000000 +0900
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/moduleloader.h>
+#include <linux/djprobe.h>
 #include <asm-generic/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
@@ -467,7 +468,7 @@ static inline void cleanup_aggr_kprobe(s
 		spin_unlock_irqrestore(&kprobe_lock, flags);
 }

-static int __kprobes in_kprobes_functions(unsigned long addr)
+int __kprobes in_kprobes_functions(unsigned long addr)
 {
 	if (addr >= (unsigned long)__kprobes_text_start
 		&& addr < (unsigned long)__kprobes_text_end)
@@ -483,6 +484,11 @@ int __kprobes register_kprobe(struct kpr

 	if ((ret = in_kprobes_functions((unsigned long) p->addr)) != 0)
 		return ret;
+#ifdef CONFIG_DJPROBE
+	if (p->pre_handler != djprobe_pre_handler &&
+	    get_djprobe_instance(p->addr, 1) != NULL)
+		return -EEXIST;
+#endif /* CONFIG_DJPROBE */
 	if ((ret = arch_prepare_kprobe(p)) != 0)
 		goto rm_kprobe;

diff -Narup linux-2.6.14-rc5-mm1.djp.1/kernel/Makefile linux-2.6.14-rc5-mm1.djp.2/kernel/Makefile
--- linux-2.6.14-rc5-mm1.djp.1/kernel/Makefile	2005-10-25 11:29:02.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.2/kernel/Makefile	2005-10-25 13:22:27.000000000 +0900
@@ -27,6 +27,7 @@ obj-$(CONFIG_STOP_MACHINE) += stop_machi
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_DJPROBE) += djprobe.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_DETECT_SOFTLOCKUP) += softlockup.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/

