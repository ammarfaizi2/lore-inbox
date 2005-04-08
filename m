Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVDHOqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVDHOqw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbVDHOqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:46:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48569 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262836AbVDHOqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:46:35 -0400
Date: Fri, 8 Apr 2005 20:17:46 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: ak@muc.de, linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       akpm@osdl.org, suparna@in.ibm.com, prasanna@in.ibm.com
Subject: [RFC] Kprobes: Multiple probes feature at given address
Message-ID: <20050408144746.GA3814@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch below provides multiple probe feature at a given address.
Please provide your review comments.

Thanks
Prasanna


Here is an attempt to provide multiple handlers feature as an addon patch over
the existing kprobes infrastructure without even changing existing kprobes
infrastructure. The design goal is to provide a simple, compact multiprobe
feature without even changing a single line of existing kprobes. This patch 
introduces two new interface:

register_multiprobe(struct multiprobe *p); and
unregister_multiprobe(struct multiprobe *p);

register_multiprobe(struct multiprobe *p):
User has to allocate multiprobe (defined in kprobes.h) and pass the pointer to 
register_multiprobe();
This routine does some housekeeping by storing reference to individual handlers
and registering kprobes with common handler if the user requests for the first 
time at a given address. On subsequenct calls to insert probes on the same 
address, this routines just adds the individual handlers to the list without 
registering the kprobes.
unregister_multiprobe(struct multiprobe *p):
User has to pass the multiprobe pointer to unregister. This routine just checks
if he is the only active user and calls unregister kprobes. If there are more 
active users, it just removes the individual handlers inserted by this user 
from the list.

Advantages :
	1. Layered architecture, need not worry about underlying stuff.
	2. Its simple and compact.
	3. Wrapper routines can be written over new and existing interface
	to handle interface naming issue.
	4. It works without even changing a single line of existing
	kprobes code.

Assumption : If a user has already inserted a probe using old register_kprobe()
routine, and later wants to insert another probe at the same address using
register_multiprobe() routine, then register_multiprobe() will return EEXIST.
This can be avoided by renaming the interface routines.
	
Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.12-rc2-prasanna/include/linux/kprobes.h |   30 ++++
 linux-2.6.12-rc2-prasanna/kernel/kprobes.c        |  164 ++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff -puN kernel/kprobes.c~kprobes-layered-multiple-handlers kernel/kprobes.c
--- linux-2.6.12-rc2/kernel/kprobes.c~kprobes-layered-multiple-handlers	2005-04-08 16:39:05.000000000 +0530
+++ linux-2.6.12-rc2-prasanna/kernel/kprobes.c	2005-04-08 19:23:11.000000000 +0530
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
@@ -44,6 +47,7 @@ static struct hlist_head kprobe_table[KP
 
 unsigned int kprobe_cpu = NR_CPUS;
 static DEFINE_SPINLOCK(kprobe_lock);
+static DEFINE_RWLOCK(multiprobe_lock);
 
 /* Locks kprobe: irqs must be disabled */
 void lock_kprobes(void)
@@ -116,6 +120,164 @@ void unregister_kprobe(struct kprobe *p)
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
+	read_lock(&multiprobe_lock);
+	ap = container_of(p, struct active_probe, comm_probe);
+	head = &ap->head;
+	hlist_for_each(node, head) {
+		struct multiprobe *mp =
+				hlist_entry(node, struct multiprobe, hlist);
+		if (mp->kp.pre_handler)
+			mp->kp.pre_handler(&mp->kp, regs);
+	}
+	read_unlock(&multiprobe_lock);
+	return 0;
+}
+
+/* common kprobes post handler that gets control when the registered probe
+ * gets fired. This routines is wrapper over the insereted multiple handlers
+ * at a given address and calls individual handlers.
+ */
+void comm_post_handler(struct kprobe *p, struct pt_regs *regs,
+						unsigned long flags)
+{
+	struct active_probe *ap;
+	struct hlist_node *node;
+	struct hlist_head *head;
+
+	read_lock(&multiprobe_lock);
+	ap = container_of(p, struct active_probe, comm_probe);
+	head = &ap->head;
+	hlist_for_each(node, head) {
+		struct multiprobe *mp =
+				hlist_entry(node, struct multiprobe, hlist);
+		if (mp->kp.post_handler)
+			mp->kp.post_handler(&mp->kp, regs, flags);
+	}
+	read_unlock(&multiprobe_lock);
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
+	read_lock(&multiprobe_lock);
+	ap = container_of(p, struct active_probe, comm_probe);
+	head = &ap->head;
+	hlist_for_each(node, head) {
+		struct multiprobe *mp =
+				hlist_entry(node, struct multiprobe, hlist);
+		if (mp->kp.fault_handler)
+			mp->kp.fault_handler(&mp->kp, regs, trapnr);
+	}
+	read_unlock(&multiprobe_lock);
+	return 1;
+}
+
+/* New interface to support multiple handlers feature without even changing a
+ * single line of exiting kprobes interface and data structures. This routines
+ * accepts pointer to multiprobe structure, user has to allocate
+ * multiprobe structure and pass the pointer. This routine basically checks
+ * and registers the kprobes common handlers if the user is inserting a probe
+ * for the first time and saves the references to individual kprobes handlers.
+ * On subsequent call to this routine to insert multiple handler at the same
+ * address, it just adds the multiprobe structure to the list.
+ */
+int register_multiprobe(struct multiprobe *p)
+{
+	struct active_probe *ap = NULL;
+	struct kprobe *temp = NULL;
+	unsigned long flags = 0;
+	int ret = 0;
+
+	write_lock_irq(&multiprobe_lock);
+	spin_lock_irqsave(&kprobe_lock, flags);
+	temp = get_kprobe(p->kp.addr);
+
+	if (temp == NULL) {
+		ap = kmalloc(sizeof(struct active_probe), GFP_ATOMIC);
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+		if (!ap) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ap->comm_probe.addr = p->kp.addr;
+		ap->comm_probe.pre_handler = comm_pre_handler;
+		ap->comm_probe.post_handler = comm_post_handler;
+		ap->comm_probe.fault_handler = comm_fault_handler;
+		INIT_HLIST_HEAD(&ap->head);
+		if ((ret = register_kprobe(&ap->comm_probe)) != 0) {
+			kfree(ap);
+			goto out;
+		}
+	} else {
+		if (temp->pre_handler != comm_pre_handler) {
+			spin_unlock_irqrestore(&kprobe_lock, flags);
+			ret = -EEXIST;
+			goto out;
+		}
+		ap = container_of(temp, struct active_probe, comm_probe);
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+	}
+
+	INIT_HLIST_NODE(&p->hlist);
+	hlist_add_head(&p->hlist, &ap->head);
+out:
+	write_unlock_irq(&multiprobe_lock);
+	return ret;
+}
+
+/* New interface to remove a inserted kprobe if multiple handlers are defined
+ * for a given address. This routine accepts just a pointer to multiprobe
+ * structure. This routines checks and unregisters the probe, if the user trying
+ * to remove a probe is only the active user. If there are more active user
+ * registerd, it just deletes the multiprobe structure from the list.
+ */
+int unregister_multiprobe(struct multiprobe *p)
+{
+	struct active_probe *ap;
+	struct kprobe *temp;
+	unsigned long flags = 0;
+	int ret = 0;
+
+	write_lock_irq(&multiprobe_lock);
+	spin_lock_irqsave(&kprobe_lock, flags);
+	temp = get_kprobe(p->kp.addr);
+
+	if ((temp == NULL) || (temp->pre_handler != comm_pre_handler)) {
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+		ret = -EEXIST;
+		goto out;
+	}
+	ap = container_of(temp, struct active_probe, comm_probe);
+	spin_unlock_irqrestore(&kprobe_lock, flags);
+	hlist_del(&p->hlist);
+	if (hlist_empty(&ap->head)) {
+		unregister_kprobe(&ap->comm_probe);
+		kfree(ap);
+	}
+out:
+	write_unlock_irq(&multiprobe_lock);
+	return ret;
+}
+
 static struct notifier_block kprobe_exceptions_nb = {
 	.notifier_call = kprobe_exceptions_notify,
 	.priority = 0x7fffffff /* we need to notified first */
@@ -155,3 +317,5 @@ EXPORT_SYMBOL_GPL(unregister_kprobe);
 EXPORT_SYMBOL_GPL(register_jprobe);
 EXPORT_SYMBOL_GPL(unregister_jprobe);
 EXPORT_SYMBOL_GPL(jprobe_return);
+EXPORT_SYMBOL_GPL(register_multiprobe);
+EXPORT_SYMBOL_GPL(unregister_multiprobe);
diff -puN include/linux/kprobes.h~kprobes-layered-multiple-handlers include/linux/kprobes.h
--- linux-2.6.12-rc2/include/linux/kprobes.h~kprobes-layered-multiple-handlers	2005-04-08 16:39:05.000000000 +0530
+++ linux-2.6.12-rc2-prasanna/include/linux/kprobes.h	2005-04-08 16:39:05.000000000 +0530
@@ -82,6 +82,26 @@ struct jprobe {
 	kprobe_opcode_t *entry;	/* probe handling code to jump to */
 };
 
+/*
+ * Addon feature to specify multiple handlers at a given address. Two new
+ * objects are defined multiprobe and active_probe, which use the existing
+ * kprobes object. The way it works is by defining common handlers at a given
+ * address and by storing individual multiple handlers in the list for a given
+ * address. Later when probe is fired, control is passed to common handlers,
+ * where individual registered pre, post handlers get called.
+ */
+
+struct multiprobe {
+	struct hlist_node hlist;
+	struct kprobe kp; /*individual kprobes structure*/
+};
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
@@ -109,6 +129,8 @@ int longjmp_break_handler(struct kprobe 
 int register_jprobe(struct jprobe *p);
 void unregister_jprobe(struct jprobe *p);
 void jprobe_return(void);
+int register_multiprobe(struct multiprobe *p);
+int unregister_multiprobe(struct multiprobe *p);
 
 #else
 static inline int kprobe_running(void)
@@ -132,5 +154,13 @@ static inline void unregister_jprobe(str
 static inline void jprobe_return(void)
 {
 }
+static inline int register_multiprobe(struct multiprobe *p)
+{
+	return -ENOSYS;
+}
+static inline int unregister_multiprobe(struct multiprobe *p)
+{
+	return -ENOSYS;
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
