Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269337AbUIIBYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269337AbUIIBYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 21:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269329AbUIIBYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 21:24:19 -0400
Received: from holomorphy.com ([207.189.100.168]:40620 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269337AbUIIBVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 21:21:47 -0400
Date: Wed, 8 Sep 2004 18:21:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: [2/2] handle CONFIG_MMU=n and use new vm stats for CONFIG_MMU=y
Message-ID: <20040909012137.GM3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909004320.GJ3106@holomorphy.com> <20040909011549.GK3106@holomorphy.com> <20040909011708.GL3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909011708.GL3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 06:15:49PM -0700, William Lee Irwin III wrote:
>> This is a straight rediff of nproc vs. 2.6.9-rc1-mm4. No changes
>> whatsoever to the underlying code were made; rather, this merely
>> resolves offsets so it applies cleanly.
>> Compiletested on ia64.

On Wed, Sep 08, 2004 at 06:17:08PM -0700, William Lee Irwin III wrote:
> Repost with appropriate Subject: line.

Make __task_mem() and __task_mem_cheap() use the appropriate methods
for CONFIG_MMU=y and add some attempt at correct code for CONFIG_MMU=n.
The new methods for /proc/ accounting involve using counters kept in
the mm instead of iteration over vmas. For the CONFIG_MMU=y case this
does not involve acquiring mm->mmap_sem for any per-mm statistics. The
CONFIG_MMU=n case still needs iteration over tblocks to calculate them.


-- wli

Index: mm4-2.6.9-rc1/kernel/nproc.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/nproc.c	2004-09-08 17:45:27.503587983 -0700
+++ mm4-2.6.9-rc1/kernel/nproc.c	2004-09-08 18:11:24.826811093 -0700
@@ -44,44 +44,20 @@
  * __task_mem/__task_mem_cheap basically duplicate the MMU version of
  * task_mem, but they are split by cost and work on structs.
  */
-
+#ifdef CONFIG_MMU
 static void __task_mem(struct task_struct *tsk, struct task_mem *res)
 {
 	struct mm_struct *mm = get_task_mm(tsk);
-	if (mm) {
-		unsigned long data = 0, stack = 0, exec = 0, lib = 0;
-		struct vm_area_struct *vma;
-
-		down_read(&mm->mmap_sem);
-		for (vma = mm->mmap; vma; vma = vma->vm_next) {
-			unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
-			if (!vma->vm_file) {
-				data += len;
-				if (vma->vm_flags & VM_GROWSDOWN)
-					stack += len;
-				continue;
-			}
-			if (vma->vm_flags & VM_WRITE)
-				continue;
-			if (vma->vm_flags & VM_EXEC) {
-				exec += len;
-				if (vma->vm_flags & VM_EXECUTABLE)
-					continue;
-				lib += len;
-			}
-		}
-		res->vmdata = data - stack;
-		res->vmstack = stack;
-		res->vmexe = exec - lib;
-		res->vmlib = lib;
-		up_read(&mm->mmap_sem);
 
+	if (!mm)
+		memset(res, 0, sizeof(struct task_mem));
+	else {
+		res->vmdata = (mm->total_vm - mm->shared_vm - mm->stack_vm)
+							<< (PAGE_SHIFT - 10);
+		res->vmstack = mm->stack_vm << (PAGE_SHIFT - 10);
+		res->vmexe = PAGE_ALIGN(mm->end_code - mm->start_code) >> 10;
+		res->vmlib = (mm->exec_vm << (PAGE_SHIFT - 10)) - res->vmexe;
 		mmput(mm);
-	} else {
-		res->vmdata = 0;
-		res->vmstack = 0;
-		res->vmexe = 0;
-		res->vmlib = 0;
 	}
 }
 
@@ -99,6 +75,80 @@
 		res->vmrss = 0;
 	}
 }
+#else /* !CONFIG_MMU */
+static void __task_mem(task_t *task, struct task_mem *stats)
+{
+	struct mm_struct *mm = get_task_mm(task)
+
+	if (!mm)
+		memset(stats, 0, sizeof(struct task_mem));
+	else {
+		unsigned long bytes = 0, sbytes = 0, slack = 0;
+		struct mm_tblk_struct *tblk;
+
+		down_read(&mm->mmap_sem);
+		for (tblk = &mm->context.tblk; tblk; tblk = tblk->next) {
+			if (!tblk->rblock)
+				continue;
+			bytes += kobjsize(tblk);
+			if (atomic_read(&mm->mm_count) > 1) ||
+					tblk->rblock->refcount > 1) {
+				sbytes += kobjsize(tblk->rblock->kblock);
+				sbytes += kobjsize(tblk->rblock);
+			} else {
+				bytes += kobjsize(tblk->rblock->kblock);
+				bytes += kobjsize(tblk->rblock);
+				slack += kobjsize(tblock->rblock->kblock);
+			}
+		}
+		if (atomic_read(&mm->mm_count) > 1)
+			sbytes += kobjsize(mm);
+		else
+			bytes += kobjsize(mm);
+		up_read(&mm->mmap_sem);
+		mmput(mm);
+		if (task->fs && atomic_read(&task->fs->count) > 1)
+			sbytes += kobjsize(task->files);
+		else
+			bytes += kobjsize(task->files);
+		if (task->sighand && atomic_read(&task->sighand->count) > 1)
+			sbytes += kobjsize(task->sighand);
+		else
+			bytes += kobjsize(task->sighand);
+		bytes += kobjsize(task);
+		/* some interpretation is needed */
+		stats->vmdata = bytes;
+		stats->vmstack = sbytes;
+		stats->vmexe = stats->vmlib = 0;
+	}
+}
+
+static void __task_mem_cheap(task_t *task, struct task_mem_cheap *stats)
+{
+	struct mm_struct *mm = get_task_mm(task);
+	struct mm_tblock_struct *tblk;
+	int size;
+
+	memset(stats, 0, sizeof(struct task_mem_cheap));
+	stats->vmrss += kobjsize(mm);
+	down_read(&mm->mmap_sem);
+	for (tblk = &mm->context.block; tblk; tblk = tblk->next) {
+		if (tblk->next)
+			stats->vmrss += kobjsize(tblk->next);
+		if (tblk->rblock) {
+			stats->vmsize += kobjsize(tblk->rblock);
+			stats->vmrss += kobjsize(tblk->rblock);
+			stats->vmrss += kobjsize(tblk->rblock->kblock);
+		}
+	}
+	stats->vmrss += mm->end_code - mm->start_code;
+	stats->vmrss += mm->start_stack - mm->start_data;
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	stats->vmrss >>= 10;
+	stats->vmsize >>= 10;
+}
+#endif /* !CONFIG_MMU */
 
 /*
  * page_alloc.c already has an extra function broken out to fill a
