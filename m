Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWJHNpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWJHNpa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWJHNp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:45:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61596 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751161AbWJHNp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:45:28 -0400
Date: Sun, 8 Oct 2006 14:45:28 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] alpha pt_regs cleanups: collapse set_irq_regs() in titan_dispatch_irqs()
Message-ID: <20061008134528.GQ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

titan_dispatch_irqs() always gets get_irq_regs() as argument; kill
the argument and collapse set_irq_regs() in body.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/err_titan.c |    4 ++--
 arch/alpha/kernel/proto.h     |    2 +-
 arch/alpha/kernel/sys_titan.c |    5 +----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/err_titan.c b/arch/alpha/kernel/err_titan.c
index 2e6e629..febe71c 100644
--- a/arch/alpha/kernel/err_titan.c
+++ b/arch/alpha/kernel/err_titan.c
@@ -452,7 +452,7 @@ #endif /* CONFIG_VERBOSE_MCHECK */
 		 * machine checks to interrupts
 		 */
 		irqmask = tmchk->c_dirx & TITAN_MCHECK_INTERRUPT_MASK;
-		titan_dispatch_irqs(irqmask, get_irq_regs());
+		titan_dispatch_irqs(irqmask);
 	}	
 
 
@@ -746,7 +746,7 @@ #define PRIVATEER_HOTPLUG_INTERRUPT_MASK
 	/*
 	 * Dispatch the interrupt(s).
 	 */
-	titan_dispatch_irqs(irqmask, get_irq_regs());
+	titan_dispatch_irqs(irqmask);
 
 	/* 
 	 * Release the logout frame.
diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index 3fff887..daccd4b 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -177,7 +177,7 @@ extern void dik_show_regs(struct pt_regs
 extern void die_if_kernel(char *, struct pt_regs *, long, unsigned long *);
 
 /* sys_titan.c */
-extern void titan_dispatch_irqs(u64, struct pt_regs *);
+extern void titan_dispatch_irqs(u64);
 
 /* ../mm/init.c */
 extern void switch_to_system_map(void);
diff --git a/arch/alpha/kernel/sys_titan.c b/arch/alpha/kernel/sys_titan.c
index e8e8ec9..161d691 100644
--- a/arch/alpha/kernel/sys_titan.c
+++ b/arch/alpha/kernel/sys_titan.c
@@ -243,9 +243,8 @@ titan_legacy_init_irq(void)
 }
 
 void
-titan_dispatch_irqs(u64 mask, struct pt_regs *regs)
+titan_dispatch_irqs(u64 mask)
 {
-	struct pt_regs *old_regs;
 	unsigned long vector;
 
 	/*
@@ -253,7 +252,6 @@ titan_dispatch_irqs(u64 mask, struct pt_
 	 */
 	mask &= titan_cpu_irq_affinity[smp_processor_id()];
 
-	old_regs = set_irq_regs(regs);
 	/*
 	 * Dispatch all requested interrupts 
 	 */
@@ -267,7 +265,6 @@ titan_dispatch_irqs(u64 mask, struct pt_
 		/* dispatch it */
 		alpha_mv.device_interrupt(vector);
 	}
-	set_irq_regs(old_regs);
 }
   
 
-- 
1.4.2.GIT

