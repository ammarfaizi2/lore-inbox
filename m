Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266552AbUBQUiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUBQUiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:38:50 -0500
Received: from galileo.bork.org ([66.11.174.156]:24216 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S266552AbUBQUh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:37:56 -0500
Date: Tue, 17 Feb 2004 15:37:56 -0500
From: Martin Hicks <mort@wildopensource.com>
To: "David S. Miller" <davem@redhat.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Reduce TLB flushing during process migration
Message-ID: <20040217203756.GP12142@localhost>
References: <40323FB6.1030208@colorfullife.com> <20040217100852.2eb50c4b.davem@redhat.com> <20040217200558.GO12142@localhost> <20040217120828.37d810d4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="p11K2BJEgMZL61bg"
Content-Disposition: inline
In-Reply-To: <20040217120828.37d810d4.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p11K2BJEgMZL61bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



On Tue, Feb 17, 2004 at 12:08:28PM -0800, David S. Miller wrote:
> On Tue, 17 Feb 2004 15:05:58 -0500
> Martin Hicks <mort@wildopensource.com> wrote:
> 
> > Here's an updated patch that creates the new wrapper.  I only changed
> > ia64 to call flush_tlb_mm() because I'm a little wary about assuming
> > that all non-x86 arches want this.
> 
> Please use "do { } while (0)" for the NOP define of the macro else
> we'll end up with empty-statement warnings from the compiler.

Certainly.

Andrew:  Are you willing to pickup this change?

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--p11K2BJEgMZL61bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="process-migration-3.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1680  -> 1.1681 
#	include/asm-generic/tlb.h	1.20    -> 1.22   
#	include/asm-ia64/tlb.h	1.18    -> 1.19   
#	      kernel/sched.c	1.240   -> 1.241  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/17	mort@tomahawk.engr.sgi.com	1.1681
# Add tlb_migrate_prepare().  Most arches will define this to tlb_flush_mm().
# x86 is an exception.  For now make the default to do nothing.  Let each
# arch define tlb_migrate_prepare appropriately.
# --------------------------------------------
#
diff -Nru a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
--- a/include/asm-generic/tlb.h	Tue Feb 17 12:32:18 2004
+++ b/include/asm-generic/tlb.h	Tue Feb 17 12:32:18 2004
@@ -146,4 +146,6 @@
 		__pmd_free_tlb(tlb, pmdp);			\
 	} while (0)
 
+#define tlb_migrate_prepare(mm) do { } while(0)
+
 #endif /* _ASM_GENERIC__TLB_H */
diff -Nru a/include/asm-ia64/tlb.h b/include/asm-ia64/tlb.h
--- a/include/asm-ia64/tlb.h	Tue Feb 17 12:32:18 2004
+++ b/include/asm-ia64/tlb.h	Tue Feb 17 12:32:18 2004
@@ -210,6 +210,8 @@
 	tlb->end_addr = address + PAGE_SIZE;
 }
 
+#define tlb_migrate_prepare(mm) flush_tlb_mm(mm)
+
 #define tlb_start_vma(tlb, vma)			do { } while (0)
 #define tlb_end_vma(tlb, vma)			do { } while (0)
 
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Feb 17 12:32:18 2004
+++ b/kernel/sched.c	Tue Feb 17 12:32:18 2004
@@ -25,6 +25,7 @@
 #include <linux/highmem.h>
 #include <linux/smp_lock.h>
 #include <asm/mmu_context.h>
+#include <asm/tlb.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
@@ -1135,6 +1136,14 @@
 		task_rq_unlock(rq, &flags);
 		wake_up_process(rq->migration_thread);
 		wait_for_completion(&req.done);
+
+		/*
+		 * we want a new context here. This eliminates TLB
+		 * flushes on the cpus where the process executed prior to
+		 * the migration.
+		 */
+		tlb_migrate_prepare(current->mm);
+
 		return;
 	}
 out:

--p11K2BJEgMZL61bg--
