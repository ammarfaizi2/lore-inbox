Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbVLAIej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbVLAIej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbVLAIej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:34:39 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:24020 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750773AbVLAIei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:34:38 -0500
Date: Thu, 1 Dec 2005 14:06:14 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, prasanna@in.ibm.com,
       jkenisto@us.ibm.com
Subject: [PATCH] kprobes: fix race in unregister_kprobe()
Message-ID: <20051201083614.GA6513@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

On architectures which have no-execute support, we use a
module_alloc()ed scratch area to store the kprobed instruction
for out-of-line single-stepping. This instruction slot is
released during unregister_kprobe().

We are currently releasing the slot before synchronize_sched()
would return, leading to a potential reuse of the slot by
another kprobe before the current references are released.
Small patch to fix that condition.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Acked-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 kernel/kprobes.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc3/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc3.orig/kernel/kprobes.c
+++ linux-2.6.15-rc3/kernel/kprobes.c
@@ -436,7 +436,6 @@ static inline void cleanup_kprobe(struct
 	arch_disarm_kprobe(p);
 	hlist_del_rcu(&p->hlist);
 	spin_unlock_irqrestore(&kprobe_lock, flags);
-	arch_remove_kprobe(p);
 }
 
 static inline void cleanup_aggr_kprobe(struct kprobe *old_p,
@@ -506,6 +505,8 @@ void __kprobes unregister_kprobe(struct 
 			cleanup_kprobe(p, flags);
 
 		synchronize_sched();
+		arch_remove_kprobe(p);
+
 		if (old_p->pre_handler == aggr_pre_handler &&
 				list_empty(&old_p->list))
 			kfree(old_p);
