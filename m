Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWBWJbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWBWJbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWBWJbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:31:12 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:6114 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751057AbWBWJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:31:09 -0500
Subject: [Patch 1/3] prefetch the mmap_sem in the fault path
From: Arjan van de Ven <arjan@intel.linux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1140686152.2972.25.camel@laptopd505.fenrus.org>
References: <1140686152.2972.25.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 10:30:07 +0100
Message-Id: <1140687007.4672.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a micro-benchmark that stresses the pagefault path, the down_read_trylock
on the mmap_sem showed up quite high on the profile. Turns out this lock is
bouncing between cpus quite a bit and thus is cache-cold a lot. This patch
prefetches the lock (for write) as early as possible (and before some other
somewhat expensive operations). With this patch, the down_read_trylock
basically fell out of the top of profile.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86_64/mm/fault.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-work/arch/x86_64/mm/fault.c
===================================================================
--- linux-work.orig/arch/x86_64/mm/fault.c
+++ linux-work/arch/x86_64/mm/fault.c
@@ -312,6 +312,10 @@ asmlinkage void __kprobes do_page_fault(
 	unsigned long flags;
 	siginfo_t info;
 
+	tsk = current;
+	mm = tsk->mm;
+	prefetchw(&mm->mmap_sem);
+
 	/* get the address */
 	__asm__("movq %%cr2,%0":"=r" (address));
 	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
@@ -325,8 +329,6 @@ asmlinkage void __kprobes do_page_fault(
 		printk("pagefault rip:%lx rsp:%lx cs:%lu ss:%lu address %lx error %lx\n",
 		       regs->rip,regs->rsp,regs->cs,regs->ss,address,error_code); 
 
-	tsk = current;
-	mm = tsk->mm;
 	info.si_code = SEGV_MAPERR;
 


