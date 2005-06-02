Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVFBJls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVFBJls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVFBJls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:41:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34547 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261338AbVFBJlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:41:21 -0400
Date: Thu, 2 Jun 2005 15:16:30 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ak@muc.de, davem@davemloft.net, amavin@redhat.com
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: [patch 1/1] Allow a jprobe to coexist with muliple kprobes
Message-ID: <20050602094630.GA1324@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please provide your comments on the patch below. This patch has
been tested on i386 and x86_64 architecture.

Thanks
Prasanna

Presently either multiple kprobes or only one jprobe could be inserted. This
patch removes the above limitation and allows one jprobe and multiple kprobes to
coexist at the same address. 

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Signed-off-by: Ananth N Mavinakayanhalli <amavin@redhat.com>


---

 linux-2.6.12-rc5-mm2-prasanna/kernel/kprobes.c |   61 ++++++++++++++++++++-----
 1 files changed, 51 insertions(+), 10 deletions(-)

diff -puN kernel/kprobes.c~jprobe-kprobe-can-coexist kernel/kprobes.c
--- linux-2.6.12-rc5-mm2/kernel/kprobes.c~jprobe-kprobe-can-coexist	2005-06-02 11:53:58.000000000 +0530
+++ linux-2.6.12-rc5-mm2-prasanna/kernel/kprobes.c	2005-06-02 11:53:58.000000000 +0530
@@ -89,9 +89,10 @@ int aggr_pre_handler(struct kprobe *p, s
 	list_for_each_entry(kp, &p->list, list) {
 		if (kp->pre_handler) {
 			curr_kprobe = kp;
-			kp->pre_handler(kp, regs);
-			curr_kprobe = NULL;
+			if (kp->pre_handler(kp, regs))
+				return 1;
 		}
+		curr_kprobe = NULL;
 	}
 	return 0;
 }
@@ -124,6 +125,19 @@ int aggr_fault_handler(struct kprobe *p,
 	return 0;
 }
 
+int aggr_break_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kprobe *kp = curr_kprobe;
+	if (curr_kprobe && kp->break_handler) {
+		if (kp->break_handler(kp, regs)) {
+			curr_kprobe = NULL;
+			return 1;
+		}
+	}
+	curr_kprobe = NULL;
+	return 0;
+}
+
 struct kprobe trampoline_p = {
 		.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
 		.pre_handler = trampoline_probe_handler,
@@ -257,18 +271,45 @@ inline void free_rp_inst(struct kretprob
 }
 
 /*
+ * Keep all fields in the kprobe consistent
+ */
+static inline void copy_kprobe(struct kprobe *old_p, struct kprobe *p)
+{
+	memcpy(&p->opcode, &old_p->opcode, sizeof(kprobe_opcode_t));
+	memcpy(&p->ainsn, &old_p->ainsn, sizeof(struct arch_specific_insn));
+}
+
+/*
+* Add the new probe to old_p->list. Fail if this is the
+* second jprobe at the address - two jprobes can't coexist
+*/
+static int add_new_kprobe(struct kprobe *old_p, struct kprobe *p)
+{
+        struct kprobe *kp;
+
+	if (p->break_handler) {
+		list_for_each_entry(kp, &old_p->list, list) {
+			if (kp->break_handler)
+				return -EEXIST;
+		}
+		list_add_tail(&p->list, &old_p->list);
+	} else
+		list_add(&p->list, &old_p->list);
+	return 0;
+}
+
+/*
  * Fill in the required fields of the "manager kprobe". Replace the
  * earlier kprobe in the hlist with the manager kprobe
  */
 static inline void add_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 {
+	copy_kprobe(p, ap);
 	ap->addr = p->addr;
-	memcpy(&ap->opcode, &p->opcode, sizeof(kprobe_opcode_t));
-	memcpy(&ap->ainsn, &p->ainsn, sizeof(struct arch_specific_insn));
-
 	ap->pre_handler = aggr_pre_handler;
 	ap->post_handler = aggr_post_handler;
 	ap->fault_handler = aggr_fault_handler;
+	ap->break_handler = aggr_break_handler;
 
 	INIT_LIST_HEAD(&ap->list);
 	list_add(&p->list, &ap->list);
@@ -289,16 +330,16 @@ static int register_aggr_kprobe(struct k
 	int ret = 0;
 	struct kprobe *ap;
 
-	if (old_p->break_handler || p->break_handler) {
-		ret = -EEXIST;	/* kprobe and jprobe can't (yet) coexist */
-	} else if (old_p->pre_handler == aggr_pre_handler) {
-		list_add(&p->list, &old_p->list);
+	if (old_p->pre_handler == aggr_pre_handler) {
+		copy_kprobe(old_p, p);
+		ret = add_new_kprobe(old_p, p);
 	} else {
 		ap = kcalloc(1, sizeof(struct kprobe), GFP_ATOMIC);
 		if (!ap)
 			return -ENOMEM;
 		add_aggr_kprobe(ap, old_p);
-		list_add(&p->list, &ap->list);
+		copy_kprobe(ap, p);
+		ret = add_new_kprobe(ap, p);
 	}
 	return ret;
 }

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
