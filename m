Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbVLNXvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVLNXvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVLNXvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:51:35 -0500
Received: from fmr22.intel.com ([143.183.121.14]:20417 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S965127AbVLNXv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:51:26 -0500
Date: Wed, 14 Dec 2005 15:50:59 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: ananth@in.ibm.com, akpm@osdl.org, paulmck@us.ibm.com,
       linux-kernel@vger.kernel.org, prasanna@in.ibm.com,
       systemtap@sources.redhat.com, oleg@tv-sign.ru
Subject: Re: [patch 3/4] Kprobes - Changed from using spinlock to mutext
Message-ID: <20051214155059.A5350@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20051213203547.649087523@csdlinux-2.jf.intel.com> <20051213203901.264302465@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051213203901.264302465@csdlinux-2.jf.intel.com>; from anil.s.keshavamurthy@intel.com on Tue, Dec 13, 2005 at 12:35:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 12:35:50PM -0800, Anil S Keshavamurthy wrote:
> [PATCH] Kprobes - Changed from using spinlock to mutext
> 
> 	Since Kprobes runtime exception handlers is now
> lock free as this code path is now using RCU to walk 
> through the list, there is no need for the 
> register/unregister{_kprobe} to use 
> spin_{lock/unlock}_isr{save/restore}. The serialization
> during registration/unregistration is now possible using
> just a mutex.
> 
> In the above process, this patch also fixes a minor memory
> leak for x86_64 and powerpc.
> 
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

Andrew,
	Based on some feedback from Oleg Nesterov, I have 
made few changes to previously posted patch.

The below fix should cleanly apply to the patch named
kprobes-changed-form-using-spinlock-to-mutex.patch 
in you mm2 tree.

Please consider this for your next mm.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-----------------------------------------------------------------

 arch/powerpc/kernel/kprobes.c |    3 ---
 arch/x86_64/kernel/kprobes.c  |    4 ++--
 kernel/kprobes.c              |   32 ++++++++++++++++++--------------
 3 files changed, 20 insertions(+), 19 deletions(-)

Index: linux-2.6.15-rc5-git3/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-git3.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.15-rc5-git3/arch/powerpc/kernel/kprobes.c
@@ -35,7 +35,6 @@
 #include <asm/kdebug.h>
 #include <asm/sstep.h>
 
-static DECLARE_MUTEX(kprobe_mutex);
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -54,9 +53,7 @@ int __kprobes arch_prepare_kprobe(struct
 
 	/* insn must be on a special executable page on ppc64 */
 	if (!ret) {
-		down(&kprobe_mutex);
 		p->ainsn.insn = get_insn_slot();
-		up(&kprobe_mutex);
 		if (!p->ainsn.insn)
 			ret = -ENOMEM;
 	}
Index: linux-2.6.15-rc5-git3/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-git3.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.15-rc5-git3/arch/x86_64/kernel/kprobes.c
@@ -43,7 +43,7 @@
 #include <asm/kdebug.h>
 
 void jprobe_return_end(void);
-void __kprobes arch_copy_kprobe(struct kprobe *p);
+static void __kprobes arch_copy_kprobe(struct kprobe *p);
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
@@ -180,7 +180,7 @@ static inline s32 *is_riprel(u8 *insn)
 	return NULL;
 }
 
-void __kprobes arch_copy_kprobe(struct kprobe *p)
+static void __kprobes arch_copy_kprobe(struct kprobe *p)
 {
 	s32 *ripdisp;
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE);
Index: linux-2.6.15-rc5-git3/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-git3.orig/kernel/kprobes.c
+++ linux-2.6.15-rc5-git3/kernel/kprobes.c
@@ -431,7 +431,7 @@ static int __kprobes register_aggr_kprob
 		copy_kprobe(old_p, p);
 		ret = add_new_kprobe(old_p, p);
 	} else {
-		ap = kcalloc(1, sizeof(struct kprobe), GFP_ATOMIC);
+		ap = kcalloc(1, sizeof(struct kprobe), GFP_KERNEL);
 		if (!ap)
 			return -ENOMEM;
 		add_aggr_kprobe(ap, old_p);
@@ -491,7 +491,8 @@ out:
 void __kprobes unregister_kprobe(struct kprobe *p)
 {
 	struct module *mod;
-	struct kprobe *old_p, *cleanup_p;
+	struct kprobe *old_p, *list_p;
+	int cleanup_p;
 
 	down(&kprobe_mutex);
 	old_p = get_kprobe(p->addr);
@@ -499,22 +500,25 @@ void __kprobes unregister_kprobe(struct 
 		up(&kprobe_mutex);
 		return;
 	}
-
-	if ((old_p->pre_handler == aggr_pre_handler) &&
+	if (p != old_p) {
+		list_for_each_entry_rcu(list_p, &old_p->list, list)
+			if (list_p == p)
+			/* kprobe p is a valid probe */
+				goto valid_p;
+		up(&kprobe_mutex);
+		return;
+	}
+valid_p:
+	if ((old_p == p) || ((old_p->pre_handler == aggr_pre_handler) &&
 		(p->list.next == &old_p->list) &&
-		(p->list.prev == &old_p->list)) {
-		/* Only one element in the aggregate list */
+		(p->list.prev == &old_p->list))) {
+		/* Only probe on the hash list */
 		arch_disarm_kprobe(p);
 		hlist_del_rcu(&old_p->hlist);
-		cleanup_p = old_p;
-	} else if (old_p == p) {
-		/* Only one kprobe element in the hash list */
-		arch_disarm_kprobe(p);
-		hlist_del_rcu(&p->hlist);
-		cleanup_p = p;
+		cleanup_p = 1;
 	} else {
 		list_del_rcu(&p->list);
-		cleanup_p = NULL;
+		cleanup_p = 0;
 	}
 
 	up(&kprobe_mutex);
@@ -524,7 +528,7 @@ void __kprobes unregister_kprobe(struct 
 		module_put(mod);
 
 	if (cleanup_p) {
-		if (cleanup_p->pre_handler == aggr_pre_handler) {
+		if (p != old_p) {
 			list_del_rcu(&p->list);
 			kfree(old_p);
 		}


	
