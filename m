Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423003AbWBBGY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423003AbWBBGY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423016AbWBBGY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:24:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:18401 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423003AbWBBGY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:24:27 -0500
Date: Thu, 2 Feb 2006 11:53:54 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>
Subject: [PATCH] Kprobes: Fix deadlock in function-return probes
Message-ID: <20060202062353.GA3279@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

When two function-return probes are inserted on kfree()[1] and the
second on say, sys_link()[2], and later [2] is unregistered, we have
a deadlock as kfree is called with the kretprobe_lock held and the
function-return probe on kfree will also try to grab the same lock.

However, we can move the kfree() during unregistration to outside
the spinlock as we are sure that no instances from the free list
will be used after synchronized_sched() returns during the
unregistration process. Thanks to Masami Hiramatsu for spotting this.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---


 kernel/kprobes.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc1/kernel/kprobes.c
===================================================================
--- linux-2.6.16-rc1.orig/kernel/kprobes.c
+++ linux-2.6.16-rc1/kernel/kprobes.c
@@ -631,12 +631,12 @@ void __kprobes unregister_kretprobe(stru
 	unregister_kprobe(&rp->kp);
 	/* No race here */
 	spin_lock_irqsave(&kretprobe_lock, flags);
-	free_rp_inst(rp);
 	while ((ri = get_used_rp_inst(rp)) != NULL) {
 		ri->rp = NULL;
 		hlist_del(&ri->uflist);
 	}
 	spin_unlock_irqrestore(&kretprobe_lock, flags);
+	free_rp_inst(rp);
 }
 
 static int __init init_kprobes(void)
