Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266602AbUBQUGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUBQUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:06:07 -0500
Received: from galileo.bork.org ([66.11.174.156]:62103 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S266602AbUBQUF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:05:59 -0500
Date: Tue, 17 Feb 2004 15:05:58 -0500
From: Martin Hicks <mort@wildopensource.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce TLB flushing during process migration
Message-ID: <20040217200558.GO12142@localhost>
References: <40323FB6.1030208@colorfullife.com> <20040217100852.2eb50c4b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="O7hm+SMpb/lu0d4d"
Content-Disposition: inline
In-Reply-To: <20040217100852.2eb50c4b.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O7hm+SMpb/lu0d4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



On Tue, Feb 17, 2004 at 10:08:52AM -0800, David S. Miller wrote:
> On Tue, 17 Feb 2004 17:22:14 +0100
> Manfred Spraul <manfred@colorfullife.com> wrote:
> 
> > >+		 * we want a new context here. This eliminates TLB
> > >+		 * flushes on the cpus where the process executed prior to
> > >+		 * the migration.
> > >+		 */
> > >+		flush_tlb_mm(current->mm);
>  ...
> > I think flush_tlb_mm() is the wrong function - e.g. for i386, it's a 
> > wasted flush, because i386 disconnects previous cpus from the tlb flush 
> > automatically.
> > And it's always the wrong thing if you've migrated one thread of a task 
> > that runs on multiple cpus. I think you need a new hook.
> 
> Yes, you're probably right.  Just name it tlb_migrate_prepare(mm) or
> something like that.
> 
> I think most if not all non-x86 platforms will define this straight
> to flush_tlb_mm().

Here's an updated patch that creates the new wrapper.  I only changed
ia64 to call flush_tlb_mm() because I'm a little wary about assuming
that all non-x86 arches want this.

Boot tested on ia64, compile tested on x86.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--O7hm+SMpb/lu0d4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="process-migration-2.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1680  -> 1.1681 
#	include/asm-generic/tlb.h	1.20    -> 1.21   
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
--- a/include/asm-generic/tlb.h	Tue Feb 17 11:31:56 2004
+++ b/include/asm-generic/tlb.h	Tue Feb 17 11:31:56 2004
@@ -146,4 +146,6 @@
 		__pmd_free_tlb(tlb, pmdp);			\
 	} while (0)
 
+#define tlb_migrate_prepare(mm)
+
 #endif /* _ASM_GENERIC__TLB_H */
diff -Nru a/include/asm-ia64/tlb.h b/include/asm-ia64/tlb.h
--- a/include/asm-ia64/tlb.h	Tue Feb 17 11:31:56 2004
+++ b/include/asm-ia64/tlb.h	Tue Feb 17 11:31:56 2004
@@ -210,6 +210,8 @@
 	tlb->end_addr = address + PAGE_SIZE;
 }
 
+#define tlb_migrate_prepare(mm) flush_tlb_mm(mm)
+
 #define tlb_start_vma(tlb, vma)			do { } while (0)
 #define tlb_end_vma(tlb, vma)			do { } while (0)
 
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Feb 17 11:31:56 2004
+++ b/kernel/sched.c	Tue Feb 17 11:31:56 2004
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

--O7hm+SMpb/lu0d4d--
