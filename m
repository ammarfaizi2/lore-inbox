Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUIITFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUIITFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUIITFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:05:17 -0400
Received: from holomorphy.com ([207.189.100.168]:35250 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266725AbUIITCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:02:22 -0400
Date: Thu, 9 Sep 2004 12:02:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: [4/2] consolidate __task_mem() and __task_mem_cheap()
Message-ID: <20040909190214.GI3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909190024.GH3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909190024.GH3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 12:00:24PM -0700, William Lee Irwin III wrote:
> Consolidate __task_mem() and __task_mem_cheap() now that both have been
> made cheap, and also combine struct task_mem with struct task_mem_cheap.
> Also adjust various users of *_cheap to the new terminology so no trace
> of the *_cheap bits remains. Compiletested on ia64.

Repost with appropriate Subject: line.


Index: mm4-2.6.9-rc1/kernel/nproc.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/nproc.c	2004-09-08 18:11:24.826811093 -0700
+++ mm4-2.6.9-rc1/kernel/nproc.c	2004-09-09 12:00:44.649267323 -0700
@@ -32,17 +32,14 @@
 	u32	vmstack;
 	u32	vmexe;
 	u32	vmlib;
-};
-
-struct task_mem_cheap {
 	u32	vmsize;
 	u32	vmlock;
 	u32	vmrss;
 };
 
 /*
- * __task_mem/__task_mem_cheap basically duplicate the MMU version of
- * task_mem, but they are split by cost and work on structs.
+ * __task_mem() basically duplicates() the MMU and nommu versions of
+ * task_mem() from fs/proc/task_mmu.c and fs/proc/task_nommu.c
  */
 #ifdef CONFIG_MMU
 static void __task_mem(struct task_struct *tsk, struct task_mem *res)
@@ -57,22 +54,10 @@
 		res->vmstack = mm->stack_vm << (PAGE_SHIFT - 10);
 		res->vmexe = PAGE_ALIGN(mm->end_code - mm->start_code) >> 10;
 		res->vmlib = (mm->exec_vm << (PAGE_SHIFT - 10)) - res->vmexe;
-		mmput(mm);
-	}
-}
-
-static void __task_mem_cheap(struct task_struct *tsk, struct task_mem_cheap *res)
-{
-	struct mm_struct *mm = get_task_mm(tsk);
-	if (mm) {
 		res->vmsize = mm->total_vm << (PAGE_SHIFT-10);
 		res->vmlock = mm->locked_vm << (PAGE_SHIFT-10);
 		res->vmrss = mm->rss << (PAGE_SHIFT-10);
 		mmput(mm);
-	} else {
-		res->vmsize = 0;
-		res->vmlock = 0;
-		res->vmrss = 0;
 	}
 }
 #else /* !CONFIG_MMU */
@@ -86,9 +71,16 @@
 		unsigned long bytes = 0, sbytes = 0, slack = 0;
 		struct mm_tblk_struct *tblk;
 
+		stats->vmrss += kobjsize(mm);
 		down_read(&mm->mmap_sem);
 		for (tblk = &mm->context.tblk; tblk; tblk = tblk->next) {
-			if (!tblk->rblock)
+			if (tblk->next)
+				stats->vmrss += kobjsize(tblk->next);
+			if (tblk->rblock) {
+				stats->vmsize += kobjsize(tblk->rblock);
+				stats->vmrss += kobjsize(tblk->rblock);
+				stats->vmrss += kobjsize(tblk->rblock->kblock);
+			} else
 				continue;
 			bytes += kobjsize(tblk);
 			if (atomic_read(&mm->mm_count) > 1) ||
@@ -120,34 +112,12 @@
 		stats->vmdata = bytes;
 		stats->vmstack = sbytes;
 		stats->vmexe = stats->vmlib = 0;
+		stats->vmrss += mm->end_code - mm->start_code;
+		stats->vmrss += mm->start_stack - mm->start_data;
+		stats->vmrss >>= 10;
+		stats->vmsize >>= 10;
 	}
 }
-
-static void __task_mem_cheap(task_t *task, struct task_mem_cheap *stats)
-{
-	struct mm_struct *mm = get_task_mm(task);
-	struct mm_tblock_struct *tblk;
-	int size;
-
-	memset(stats, 0, sizeof(struct task_mem_cheap));
-	stats->vmrss += kobjsize(mm);
-	down_read(&mm->mmap_sem);
-	for (tblk = &mm->context.block; tblk; tblk = tblk->next) {
-		if (tblk->next)
-			stats->vmrss += kobjsize(tblk->next);
-		if (tblk->rblock) {
-			stats->vmsize += kobjsize(tblk->rblock);
-			stats->vmrss += kobjsize(tblk->rblock);
-			stats->vmrss += kobjsize(tblk->rblock->kblock);
-		}
-	}
-	stats->vmrss += mm->end_code - mm->start_code;
-	stats->vmrss += mm->start_stack - mm->start_data;
-	up_read(&mm->mmap_sem);
-	mmput(mm);
-	stats->vmrss >>= 10;
-	stats->vmsize >>= 10;
-}
 #endif /* !CONFIG_MMU */
 
 /*
@@ -223,10 +193,9 @@
 static char *nproc_ps_field(u32 id, char *buf, task_t *tsk)
 {
 	struct task_mem tsk_mem;
-	struct task_mem_cheap tsk_mem_cheap;
 
 	tsk_mem.vmdata = (~0);
-	tsk_mem_cheap.vmsize = (~0);
+	tsk_mem.vmsize = (~0);
 
 	switch (id) {
 		case NPROC_PID:
@@ -238,20 +207,20 @@
 		case NPROC_VMSIZE:
 		case NPROC_VMLOCK:
 		case NPROC_VMRSS:
-			if (tsk_mem_cheap.vmsize == (~0))
-				__task_mem_cheap(tsk, &tsk_mem_cheap);
+			if (tsk_mem.vmsize == (~0))
+				__task_mem(tsk, &tsk_mem);
 
 			switch (id) {
 				case NPROC_VMSIZE:
-					mstore(tsk_mem_cheap.vmsize,
+					mstore(tsk_mem.vmsize,
 							NPROC_VMSIZE, buf);
 					break;
 				case NPROC_VMLOCK:
-					mstore(tsk_mem_cheap.vmlock,
+					mstore(tsk_mem.vmlock,
 							NPROC_VMLOCK, buf);
 					break;
 				case NPROC_VMRSS:
-					mstore(tsk_mem_cheap.vmrss,
+					mstore(tsk_mem.vmrss,
 							NPROC_VMRSS, buf);
 					break;
 			}
