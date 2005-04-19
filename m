Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVDSNU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVDSNU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDSNU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:20:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261503AbVDSNTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:19:35 -0400
Message-ID: <4265061A.9070802@redhat.com>
Date: Tue, 19 Apr 2005 09:22:34 -0400
From: Ananth N Mavinakayanahalli <amavin@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davem@davemloft.net, ak@muc.de, rusty@rustcorp.com.au, suparna@in.ibm.com,
       prasanna@in.ibm.com, ananth@in.ibm.com
Subject: [RFC] [PATCH] Multiple kprobes at an address
Content-Type: multipart/mixed;
 boundary="------------000008050007020608070106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000008050007020608070106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Some instrumentation tools on Linux, like Itrace and systemtap
(http://sourceware.org/systemtap) now use the kprobe infrastructure to
gather information. One of the requirements of projects like systemtap 
is the ability to define multiple kprobes at a given address.

To this end, here is a patch that provides the feature. Patch is
against linux-2.6.12-rc2.

This patch provides the facility to register multiple kprobes at the
same address using the existing interfaces. The house-keeping in
case of multiple kprobes is taken care of within the base kprobes
infrastructure.

Another approach considered was to have a layer above the existing
kprobes base (no modification to current kprobes base at all). A patch
to this end is available at:

http://sourceware.org/ml/systemtap/2005-q2/msg00089.html

This approach would also allow for two sets of interfaces for
un/registering kprobes. There has been quite a few discussions on the
systemtap lists whether two interfaces are necessary or not. But, with
the current kprobes locking model, the layered approach leaves room
for a few kprobe registration races.

Both approaches are architecture agnostic.

Other kprobe enhancements in the pipeline, such as, improving kprobe
locking, support for return address probes, etc. Given that, the main
questions to be answered now for the multi-kprobe feature are:

1. Is the approach taken by the patch attached good?
2. Do we take the layered approach?
3. If we take the layered approach, do we need multiple interfaces?
4. Would existing users be impacted by the change?

Comments?

Thanks,
Ananth


--------------000008050007020608070106
Content-Type: text/plain;
 name="single-interface-15apr-take2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="single-interface-15apr-take2.patch"

diff -Naurp temp/linux-2.6.12-rc2/include/linux/kprobes.h linux-2.6.12-rc2/include/linux/kprobes.h
--- temp/linux-2.6.12-rc2/include/linux/kprobes.h	2005-04-18 11:44:57.000000000 -0400
+++ linux-2.6.12-rc2/include/linux/kprobes.h	2005-04-18 13:36:23.000000000 -0400
@@ -43,6 +43,9 @@ typedef int (*kprobe_fault_handler_t) (s
 struct kprobe {
 	struct hlist_node hlist;
 
+	/* list of kprobes for multi-handler support */
+	struct list_head list;
+
 	/* location of the probe point */
 	kprobe_opcode_t *addr;
 
diff -Naurp temp/linux-2.6.12-rc2/kernel/kprobes.c linux-2.6.12-rc2/kernel/kprobes.c
--- temp/linux-2.6.12-rc2/kernel/kprobes.c	2005-04-18 11:44:57.000000000 -0400
+++ linux-2.6.12-rc2/kernel/kprobes.c	2005-04-18 13:41:38.000000000 -0400
@@ -44,6 +44,7 @@ static struct hlist_head kprobe_table[KP
 
 unsigned int kprobe_cpu = NR_CPUS;
 static DEFINE_SPINLOCK(kprobe_lock);
+static struct kprobe *curr_kprobe;
 
 /* Locks kprobe: irqs must be disabled */
 void lock_kprobes(void)
@@ -73,22 +74,142 @@ struct kprobe *get_kprobe(void *addr)
 	return NULL;
 }
 
+/*
+ * Aggregate handlers for multiple kprobes support - these handlers 
+ * take care of invoking the individual kprobe handlers on p->list
+ */ 
+int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kprobe *kp;
+
+	list_for_each_entry(kp, &p->list, list) {
+		if (kp->pre_handler) {
+			curr_kprobe = kp;
+			kp->pre_handler(kp, regs);
+			curr_kprobe = NULL;
+		}
+	}
+	return 0;
+}
+
+void aggr_post_handler(struct kprobe *p, struct pt_regs *regs, 
+		unsigned long flags)
+{
+	struct kprobe *kp;
+
+	list_for_each_entry(kp, &p->list, list) {
+		if (kp->post_handler) {
+			curr_kprobe = kp;
+			kp->post_handler(kp, regs, flags);
+			curr_kprobe = NULL;
+		}
+	}
+	return;
+}
+
+int aggr_fault_handler(struct kprobe *p, struct pt_regs *regs, int trapnr)
+{
+	/* 
+	 * if we faulted "during" the execution of a user specified
+	 * probe handler, invoke just that probe's fault handler
+	 */ 
+	if (curr_kprobe && curr_kprobe->fault_handler) {
+		if (curr_kprobe->fault_handler(curr_kprobe, regs, trapnr))
+			return 1;
+	}
+	return 0;
+}
+
+/* 
+ * Fill in the required fields of the "manager kprobe". Replace the 
+ * earlier kprobe in the hlist with the manager kprobe
+ */ 
+static inline void add_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
+{
+	ap->addr = p->addr;
+	ap->opcode = p->opcode;
+	memcpy(&ap->ainsn, &p->ainsn, sizeof(struct arch_specific_insn));
+
+	ap->pre_handler = aggr_pre_handler;
+	ap->post_handler = aggr_post_handler;
+	ap->fault_handler = aggr_fault_handler;
+
+	INIT_LIST_HEAD(&ap->list);
+	list_add(&p->list, &ap->list);
+
+	INIT_HLIST_NODE(&ap->hlist);
+	hlist_del(&p->hlist);
+	hlist_add_head(&ap->hlist,
+		&kprobe_table[hash_ptr(ap->addr, KPROBE_HASH_BITS)]);
+}
+
+/*
+ * This is the second or subsequent kprobe at the address - handle
+ * the intricacies
+ * TODO: Move kcalloc outside the spinlock
+ */ 
+static int register_aggr_kprobe(struct kprobe *old_p, struct kprobe *p)
+{
+	int ret = 0;
+	struct kprobe *ap;
+
+	if (old_p->break_handler || p->break_handler) {
+		ret = -EEXIST;	/* kprobe and jprobe can't (yet) coexist */
+		goto out;
+	} else if (old_p->pre_handler == aggr_pre_handler) {
+		list_add(&p->list, &old_p->list);
+		goto out;
+	} else {
+		ap = kcalloc(1, sizeof(struct kprobe), GFP_ATOMIC);
+		if (!ap)
+			return -ENOMEM;
+		add_aggr_kprobe(ap, old_p);
+		list_add(&p->list, &ap->list);
+	}
+out:
+	return ret;
+}
+
+/* kprobe removal house-keeping routines */
+static inline void cleanup_kprobe(struct kprobe *p, unsigned long flags)
+{
+	*p->addr = p->opcode;
+	hlist_del(&p->hlist);
+	flush_icache_range((unsigned long) p->addr,
+		   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+	spin_unlock_irqrestore(&kprobe_lock, flags);
+	arch_remove_kprobe(p);
+}
+
+static inline void cleanup_aggr_kprobe(struct kprobe *old_p, 
+		struct kprobe *p, unsigned long flags)
+{
+	list_del(&p->list);
+	if (list_empty(&old_p->list)) {
+		cleanup_kprobe(old_p, flags);
+		kfree(old_p);
+	} else
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+}
+
 int register_kprobe(struct kprobe *p)
 {
 	int ret = 0;
 	unsigned long flags = 0;
+	struct kprobe *old_p;
 
 	if ((ret = arch_prepare_kprobe(p)) != 0) {
 		goto rm_kprobe;
 	}
 	spin_lock_irqsave(&kprobe_lock, flags);
-	INIT_HLIST_NODE(&p->hlist);
-	if (get_kprobe(p->addr)) {
-		ret = -EEXIST;
+	old_p = get_kprobe(p->addr);
+	if (old_p) {
+		ret = register_aggr_kprobe(old_p, p);
 		goto out;
 	}
-	arch_copy_kprobe(p);
 
+	arch_copy_kprobe(p);
+	INIT_HLIST_NODE(&p->hlist);
 	hlist_add_head(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
@@ -107,13 +228,17 @@ rm_kprobe:
 void unregister_kprobe(struct kprobe *p)
 {
 	unsigned long flags;
-	arch_remove_kprobe(p);
+	struct kprobe *old_p;
+
 	spin_lock_irqsave(&kprobe_lock, flags);
-	*p->addr = p->opcode;
-	hlist_del(&p->hlist);
-	flush_icache_range((unsigned long) p->addr,
-			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
-	spin_unlock_irqrestore(&kprobe_lock, flags);
+	old_p = get_kprobe(p->addr);
+	if (old_p) {
+		if (old_p->pre_handler == aggr_pre_handler)
+			cleanup_aggr_kprobe(old_p, p, flags);
+		else
+			cleanup_kprobe(p, flags);
+	} else
+		spin_unlock_irqrestore(&kprobe_lock, flags);
 }
 
 static struct notifier_block kprobe_exceptions_nb = {

--------------000008050007020608070106--
