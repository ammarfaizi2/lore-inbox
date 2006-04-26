Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWDZJdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWDZJdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWDZJdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:33:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:62509 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751253AbWDZJdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:33:37 -0400
X-IronPort-AV: i="4.04,157,1144047600"; 
   d="scan'208"; a="27917395:sNHT21332423"
X-IronPort-AV: i="4.04,157,1144047600"; 
   d="scan'208"; a="27917387:sNHT23009686"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,157,1144047600"; 
   d="scan'208"; a="28733847:sNHT21322924"
Message-ID: <444F3E77.6070602@intel.com>
Date: Wed, 26 Apr 2006 17:33:43 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>, prasanna@in.ibm.com,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Jim Keniston <jkenisto@us.ibm.com>
CC: systemtap@sources.redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] kprobe-booster: boosting multi-probe
References: <43F5C22C.5050702@sdl.hitachi.co.jp> <44151136.7020101@intel.com> <441578BF.6090001@sdl.hitachi.co.jp> <44162569.6060402@intel.com> <444F2684.2080601@sdl.hitachi.co.jp>
In-Reply-To: <444F2684.2080601@sdl.hitachi.co.jp>
Content-Type: multipart/mixed;
 boundary="------------010101050103030602050309"
X-OriginalArrivalTime: 26 Apr 2006 09:33:34.0765 (UTC) FILETIME=[7D36E5D0:01C66914]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010101050103030602050309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,
    If there are multi kprobes on the same probepoint, there
will be one extra aggr_kprobe on the head of kprobe list.
The aggr_kprobe has aggr_post_handler/aggr_break_handler
whether the other kprobe post_hander/break_handler is NULL
or not. This patch modifies this, only when there is one or
more kprobe in the list whose post_handler is not NULL,
post_handler of aggr_kprobe will be set as aggr_post_handler.

Signed-off-by: bibo, mao <bibo.mao@intel.com>

Thanks
bibo,mao

--------------010101050103030602050309
Content-Type: text/x-patch;
 name="kprobe_booster_multiprobe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kprobe_booster_multiprobe.patch"

diff -Nruap 2.6.17-rc1-mm3.org/arch/i386/kernel/kprobes.c 2.6.17-rc1-mm3/arch/i386/kernel/kprobes.c
--- 2.6.17-rc1-mm3.org/arch/i386/kernel/kprobes.c	2006-04-26 15:52:24.000000000 +0800
+++ 2.6.17-rc1-mm3/arch/i386/kernel/kprobes.c	2006-04-26 16:18:50.000000000 +0800
@@ -206,9 +206,7 @@ static int __kprobes kprobe_handler(stru
 	int ret = 0;
 	kprobe_opcode_t *addr;
 	struct kprobe_ctlblk *kcb;
-#ifdef CONFIG_PREEMPT
 	unsigned pre_preempt_count = preempt_count();
-#endif /* CONFIG_PREEMPT */
 
 	addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
 
@@ -294,22 +292,14 @@ static int __kprobes kprobe_handler(stru
 		/* handler has already set things up, so skip ss setup */
 		return 1;
 
-	if (p->ainsn.boostable == 1 &&
-#ifdef CONFIG_PREEMPT
-	    !(pre_preempt_count) && /*
-				       * This enables booster when the direct
-				       * execution path aren't preempted.
-				       */
-#endif /* CONFIG_PREEMPT */
-	    !p->post_handler && !p->break_handler ) {
+ss_probe:
+	if (pre_preempt_count && p->ainsn.boostable == 1 && !p->post_handler){
 		/* Boost up -- we can execute copied instructions directly */
 		reset_current_kprobe();
 		regs->eip = (unsigned long)p->ainsn.insn;
 		preempt_enable_no_resched();
 		return 1;
 	}
-
-ss_probe:
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
diff -Nruap 2.6.17-rc1-mm3.org/kernel/kprobes.c 2.6.17-rc1-mm3/kernel/kprobes.c
--- 2.6.17-rc1-mm3.org/kernel/kprobes.c	2006-04-26 15:52:24.000000000 +0800
+++ 2.6.17-rc1-mm3/kernel/kprobes.c	2006-04-26 16:09:14.000000000 +0800
@@ -368,16 +368,15 @@ static inline void copy_kprobe(struct kp
 */
 static int __kprobes add_new_kprobe(struct kprobe *old_p, struct kprobe *p)
 {
-        struct kprobe *kp;
-
 	if (p->break_handler) {
-		list_for_each_entry_rcu(kp, &old_p->list, list) {
-			if (kp->break_handler)
-				return -EEXIST;
-		}
+		if (old_p->break_handler)
+			return -EEXIST;
 		list_add_tail_rcu(&p->list, &old_p->list);
+		old_p->break_handler = aggr_break_handler;
 	} else
 		list_add_rcu(&p->list, &old_p->list);
+	if (p->post_handler && !old_p->post_handler)
+		old_p->post_handler = aggr_post_handler;
 	return 0;
 }
 
@@ -390,9 +389,11 @@ static inline void add_aggr_kprobe(struc
 	copy_kprobe(p, ap);
 	ap->addr = p->addr;
 	ap->pre_handler = aggr_pre_handler;
-	ap->post_handler = aggr_post_handler;
 	ap->fault_handler = aggr_fault_handler;
-	ap->break_handler = aggr_break_handler;
+	if (p->post_handler)
+		ap->post_handler = aggr_post_handler;
+	if (p->break_handler)
+		ap->break_handler = aggr_break_handler;
 
 	INIT_LIST_HEAD(&ap->list);
 	list_add_rcu(&p->list, &ap->list);
@@ -536,6 +537,21 @@ valid_p:
 			kfree(old_p);
 		}
 		arch_remove_kprobe(p);
+	} else {
+		mutex_lock(&kprobe_mutex);
+		if (p->break_handler)
+			old_p->break_handler = NULL;
+		if (p->post_handler){
+			list_for_each_entry_rcu(list_p, &old_p->list, list){
+				if (list_p->post_handler){
+					cleanup_p = 2;
+					break;
+				}
+			}
+			if (cleanup_p == 0)
+				old_p->post_handler = NULL;
+		}
+		mutex_unlock(&kprobe_mutex);
 	}
 }
 

--------------010101050103030602050309--
