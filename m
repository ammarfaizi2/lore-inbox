Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVDKKUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVDKKUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVDKKUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:20:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6568 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261763AbVDKKRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:17:22 -0400
Date: Mon, 11 Apr 2005 15:48:18 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       akpm@osdl.org, suparna@in.ibm.com
Subject: Re: [RFC] Kprobes: Multiple probes feature at given address
Message-ID: <20050411101818.GB17425@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050408144746.GA3814@in.ibm.com> <20050411045640.GA3655@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411045640.GA3655@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Maneesh for your comments. Please find
the patch below.

> [..]
> > Assumption : If a user has already inserted a probe using old register_kprobe()
> > routine, and later wants to insert another probe at the same address using
> > register_multiprobe() routine, then register_multiprobe() will return EEXIST.
> > This can be avoided by renaming the interface routines.
> > 	
> I am not sure if systemTap can tolerate this resitriction.
> 

Basically lets understand that there are two sets of users
1. One set wants to use the older register_kprobe() interface
and dont want multiprobe complexities.

2. Second set of users want multiprobes (such as systemtap).

By adding two new interface to insert multiprobe should help both
the types of users. And now the new interface in this patch
also accepts the same datatype ie struct kprobe *. Just by
writting the wrappers around these interfaces will help the 
systemtap. I have modified this patch as per your comments.


> I think it should not exit here without un-registering any thing if temp
> is an active_probe. Instead, it should parse the ap->head to look
> for the desired multiprobe to unregsiter.
> 

Let the user take care about this.


> -EEXIST doesnot seem to be a proper error code here. When temp is NULL that 
> means, there is no such kprobe.

modified in the new patch.

Please let me know if you have any issues.

Thanks
Prasanna




Here is an attempt to provide multiple handlers feature as an addon patch over
the existing kprobes infrastructure without even changing existing kprobes
infrastructure. The design goal is to provide a simple, compact multiprobe
feature without even changing a single line of existing kprobes. This patch 
introduces two new interface:

register_multiprobe(struct kprobe *p); and
unregister_multiprobe(struct kprobe *p);

register_multiprobe(struct kprobe *p):
User has to allocate kprobe (defined in kprobes.h) and pass the pointer to 
register_multiprobe();
This routine does some housekeeping by storing reference to individual handlers
and registering kprobes with common handler if the user requests for the first 
time at a given address. On subsequenct calls to insert probes on the same 
address, this routines just adds the individual handlers to the hhlist 
(struct kprobe) without registering the kprobes.
unregister_multiprobe(struct kprobe *p):
User has to pass the kprobe pointer to unregister. This routine just checks
if he is the only active user and calls unregister kprobes. If there are more 
active users, it just removes the individual handlers inserted by this user 
from the hhlist.

Advantages :
        1. Layered architecture, need not worry about underlying stuff.
        2. Its simple and compact.
        3. Wrapper routines can be written over new and existing interface
        to handle interface naming issue.
        4. It works without even changing a single line of existing
        kprobes code.

Assumption : If a user has already inserted a probe using old
register_kprobe()
routine, and later wants to insert another probe at the same address using
register_multiprobe() routine, then register_multiprobe() will return EEXIST.
This can be avoided by renaming the interface routines.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.12-rc2-prasanna/include/linux/kprobes.h |   26 +++
 linux-2.6.12-rc2-prasanna/kernel/kprobes.c        |  152 ++++++++++++++++++++++
 2 files changed, 178 insertions(+)

diff -puN kernel/kprobes.c~kprobes-layered-multiple-handlers kernel/kprobes.c
--- linux-2.6.12-rc2/kernel/kprobes.c~kprobes-layered-multiple-handlers	2005-04-11 13:52:52.000000000 +0530
+++ linux-2.6.12-rc2-prasanna/kernel/kprobes.c	2005-04-11 13:57:55.000000000 +0530
@@ -27,6 +27,9 @@
  *		interface to access function arguments.
  * 2004-Sep	Prasanna S Panchamukhi <prasanna@in.ibm.com> Changed Kprobes
  *		exceptions notifier to be first on the priority list.
+ * 2005-April	Prasanna S Panchamukhi <prasanna@in.ibm.com> Added multiple
+ *		handlers feature as an addon interface over existing kprobes
+ *		interface.
  */
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
@@ -116,6 +119,153 @@ void unregister_kprobe(struct kprobe *p)
 	spin_unlock_irqrestore(&kprobe_lock, flags);
 }
 
+
+/* common kprobes pre handler that gets control when the registered probe
+ * gets fired. This routines is wrapper over the inserted multiple handlers
+ * at a given address and calls individual handlers.
+ */
+int comm_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct active_probe *ap;
+	struct hlist_node *node;
+	struct hlist_head *head;
+
+	ap = container_of(p, struct active_probe, comm_probe);
+	head = &ap->head;
+	hlist_for_each(node, head) {
+		struct kprobe *kp = hlist_entry(node, struct kprobe , hhlist);
+		if (kp->pre_handler)
+			kp->pre_handler(kp, regs);
+	}
+	return 0;
+}
+
+/* common kprobes post handler that gets control when the registered probe
+ * gets fired. This routines is wrapper over the inserted multiple handlers
+ * at a given address and calls individual handlers.
+ */
+void comm_post_handler(struct kprobe *p, struct pt_regs *regs,
+						unsigned long flags)
+{
+	struct active_probe *ap;
+	struct hlist_node *node;
+	struct hlist_head *head;
+
+	ap = container_of(p, struct active_probe, comm_probe);
+	head = &ap->head;
+	hlist_for_each(node, head) {
+		struct kprobe *kp = hlist_entry(node, struct kprobe , hhlist);
+		if (kp->post_handler)
+			kp->post_handler(kp, regs, flags);
+	}
+	return;
+}
+
+/* common kprobes fault handler that gets control when the registered probe
+ * gets fired. This routines is wrapper over the inserted multiple handlers
+ * at a given address and calls individual handlers.
+ */
+int comm_fault_handler(struct kprobe *p, struct pt_regs *regs, int trapnr)
+{
+	struct active_probe *ap;
+	struct hlist_node *node;
+	struct hlist_head *head;
+
+	ap = container_of(p, struct active_probe, comm_probe);
+	head = &ap->head;
+	hlist_for_each(node, head) {
+		struct kprobe *kp = hlist_entry(node, struct kprobe , hhlist);
+		if (kp->fault_handler)
+			kp->fault_handler(kp, regs, trapnr);
+	}
+	return 1;
+}
+
+/* New interface to support multiple handlers feature without even changing a
+ * single line of exiting kprobes interface. Added a list_node hhlist to kprobes
+ * structure.This routines accepts pointer to kprobe structure, user has to
+ * allocate kprobe structure and pass the pointer. This routine basically checks
+ * and registers the kprobes common handlers if the user is inserting a probe
+ * for the first time and saves the references to individual kprobes handlers.
+ * On subsequent call to this routine to insert multiple handler at the same
+ * address, it just adds the kprobe structure to the hhlist.
+ */
+int register_multiprobe(struct kprobe *p)
+{
+	struct active_probe *ap = NULL;
+	struct kprobe *temp = NULL;
+	unsigned long flags = 0;
+	int ret = 0;
+
+	spin_lock_irqsave(&kprobe_lock, flags);
+	temp = get_kprobe(p->addr);
+
+	if (temp == NULL) {
+		ap = kmalloc(sizeof(struct active_probe), GFP_ATOMIC);
+		if (!ap) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ap->comm_probe.addr = p->addr;
+		ap->comm_probe.pre_handler = comm_pre_handler;
+		ap->comm_probe.post_handler = comm_post_handler;
+		ap->comm_probe.fault_handler = comm_fault_handler;
+		INIT_HLIST_HEAD(&ap->head);
+		INIT_HLIST_NODE(&p->hhlist);
+		hlist_add_head(&p->hhlist, &ap->head);
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+		if ((ret = register_kprobe(&ap->comm_probe)) != 0) {
+			spin_lock_irqsave(&kprobe_lock, flags);
+			hlist_del(&p->hhlist);
+			kfree(ap);
+			goto out;
+		}
+		return ret;
+	} else {
+		if (temp->pre_handler != comm_pre_handler) {
+			ret = -EEXIST;
+			goto out;
+		}
+		ap = container_of(temp, struct active_probe, comm_probe);
+		INIT_HLIST_NODE(&p->hhlist);
+		hlist_add_head(&p->hhlist, &ap->head);
+	}
+out:
+	spin_unlock_irqrestore(&kprobe_lock, flags);
+	return ret;
+}
+
+/* New interface to remove a inserted kprobe if multiple handlers are defined
+ * for a given address. This routine accepts just a pointer to kprobe
+ * structure. This routines checks and unregisters the probe, if the user trying
+ * to remove a probe is only the active user. If there are more active user
+ * registerd, it just deletes the kprobe structure from the hhlist.
+ */
+void unregister_multiprobe(struct kprobe *p)
+{
+	struct active_probe *ap;
+	struct kprobe *temp;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&kprobe_lock, flags);
+	temp = get_kprobe(p->addr);
+
+	if ((temp == NULL) || (temp->pre_handler != comm_pre_handler)) {
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+		return;
+	}
+	ap = container_of(temp, struct active_probe, comm_probe);
+	hlist_del(&p->hhlist);
+	if (hlist_empty(&ap->head)) {
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+		unregister_kprobe(&ap->comm_probe);
+		kfree(ap);
+		return;
+	}
+	spin_unlock_irqrestore(&kprobe_lock, flags);
+	return;
+}
+
 static struct notifier_block kprobe_exceptions_nb = {
 	.notifier_call = kprobe_exceptions_notify,
 	.priority = 0x7fffffff /* we need to notified first */
@@ -155,3 +305,5 @@ EXPORT_SYMBOL_GPL(unregister_kprobe);
 EXPORT_SYMBOL_GPL(register_jprobe);
 EXPORT_SYMBOL_GPL(unregister_jprobe);
 EXPORT_SYMBOL_GPL(jprobe_return);
+EXPORT_SYMBOL_GPL(register_multiprobe);
+EXPORT_SYMBOL_GPL(unregister_multiprobe);
diff -puN include/linux/kprobes.h~kprobes-layered-multiple-handlers include/linux/kprobes.h
--- linux-2.6.12-rc2/include/linux/kprobes.h~kprobes-layered-multiple-handlers	2005-04-11 13:52:52.000000000 +0530
+++ linux-2.6.12-rc2-prasanna/include/linux/kprobes.h	2005-04-11 13:52:52.000000000 +0530
@@ -42,6 +42,8 @@ typedef int (*kprobe_fault_handler_t) (s
 				       int trapnr);
 struct kprobe {
 	struct hlist_node hlist;
+	/* lists of the individual handler */
+	struct hlist_node hhlist;
 
 	/* location of the probe point */
 	kprobe_opcode_t *addr;
@@ -82,6 +84,21 @@ struct jprobe {
 	kprobe_opcode_t *entry;	/* probe handling code to jump to */
 };
 
+/*
+ * Addon feature to specify multiple handlers at a given address. A new
+ * objects is defined active_probe, which use the existing
+ * kprobes object. The way it works is by defining common handlers at a given
+ * address and by storing individual multiple handlers in the hhlist for a given
+ * address. Later when probe is fired, control is passed to common handlers,
+ * where individual registered pre, post handlers get called.
+ */
+
+struct active_probe {
+	struct hlist_head head;
+	/*common kprobes object where common pre and post handlers are defined*/
+	struct kprobe comm_probe;
+};
+
 #ifdef CONFIG_KPROBES
 /* Locks kprobe: irq must be disabled */
 void lock_kprobes(void);
@@ -109,6 +126,8 @@ int longjmp_break_handler(struct kprobe 
 int register_jprobe(struct jprobe *p);
 void unregister_jprobe(struct jprobe *p);
 void jprobe_return(void);
+int register_multiprobe(struct kprobe *p);
+void unregister_multiprobe(struct kprobe *p);
 
 #else
 static inline int kprobe_running(void)
@@ -132,5 +151,12 @@ static inline void unregister_jprobe(str
 static inline void jprobe_return(void)
 {
 }
+static inline int register_multiprobe(struct kprobe *p)
+{
+	return -ENOSYS;
+}
+static inline void unregister_multiprobe(struct kprobe *p)
+{
+}
 #endif
 #endif				/* _LINUX_KPROBES_H */

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
