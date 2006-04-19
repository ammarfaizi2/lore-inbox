Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWDSWcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWDSWcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDSWcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:32:15 -0400
Received: from mga06.intel.com ([134.134.136.21]:21341 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751195AbWDSWbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:31:49 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25199698:sNHT51245012"
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25199663:sNHT50752527"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25199623:sNHT50060101"
Message-Id: <20060419221948.714146860@csdlinux-2.jf.intel.com>
References: <20060419221419.382297865@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 15:14:26 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(resend)patch 7/7] Kprobes - Register for page fault notify on active probes
Content-Disposition: inline; filename=kprobes_noitfy_register.patch
X-OriginalArrivalTime: 19 Apr 2006 22:31:45.0967 (UTC) FILETIME=[0A72ABF0:01C66401]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch Kprobes now registers for page fault notifications only
when their is an active probe registered. Once all the active probes are
unregistered their is no need to be notified of page faults and kprobes
unregisters itself from the page fault notifications. Hence we
will have ZERO side effects when no probes are active.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---
 kernel/kprobes.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

Index: linux-2.6.17-rc1-mm3/kernel/kprobes.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/kprobes.c
+++ linux-2.6.17-rc1-mm3/kernel/kprobes.c
@@ -47,11 +47,17 @@
 
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
+static atomic_t kprobe_count;
 
 DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
 DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
+static struct notifier_block kprobe_page_fault_nb = {
+	.notifier_call = kprobe_exceptions_notify,
+	.priority = 0x7fffffff /* we need to notified first */
+};
+
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
 /*
  * kprobe->ainsn.insn points to the copy of the instruction to be
@@ -464,6 +470,8 @@ static int __kprobes __register_kprobe(s
 	old_p = get_kprobe(p->addr);
 	if (old_p) {
 		ret = register_aggr_kprobe(old_p, p);
+		if (!ret)
+			atomic_inc(&kprobe_count);
 		goto out;
 	}
 
@@ -474,6 +482,9 @@ static int __kprobes __register_kprobe(s
 	hlist_add_head_rcu(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
+	if(atomic_add_return(1, &kprobe_count) == 2)
+		register_page_fault_notifier(&kprobe_page_fault_nb);
+
   	arch_arm_kprobe(p);
 
 out:
@@ -523,9 +534,13 @@ valid_p:
 		cleanup_p = 0;
 	}
 
+	if(atomic_add_return(-1, &kprobe_count) == 1)
+		unregister_page_fault_notifier(&kprobe_page_fault_nb);
+	else
+		synchronize_rcu();
+
 	mutex_unlock(&kprobe_mutex);
 
-	synchronize_sched();
 	if (p->mod_refcounted &&
 	    (mod = module_text_address((unsigned long)p->addr)))
 		module_put(mod);
@@ -544,10 +559,6 @@ static struct notifier_block kprobe_exce
 	.priority = 0x7fffffff /* we need to notified first */
 };
 
-static struct notifier_block kprobe_page_fault_nb = {
-	.notifier_call = kprobe_exceptions_notify,
-	.priority = 0x7fffffff /* we need to notified first */
-};
 
 int __kprobes register_jprobe(struct jprobe *jp)
 {
@@ -654,14 +665,12 @@ static int __init init_kprobes(void)
 		INIT_HLIST_HEAD(&kprobe_table[i]);
 		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
 	}
+	atomic_set(&kprobe_count, 0);
 
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
 
-	if (!err)
-		err = register_page_fault_notifier(&kprobe_page_fault_nb);
-
 	return err;
 }
 

--
