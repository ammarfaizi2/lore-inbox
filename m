Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTARGe2>; Sat, 18 Jan 2003 01:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTARGe2>; Sat, 18 Jan 2003 01:34:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:58760 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262806AbTARGe0>;
	Sat, 18 Jan 2003 01:34:26 -0500
Date: Fri, 17 Jan 2003 22:44:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: recent change to exit_mmap
Message-Id: <20030117224444.08c48290.akpm@digeo.com>
In-Reply-To: <20030118060522.GE7800@krispykreme>
References: <20030118060522.GE7800@krispykreme>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 06:43:19.0522 (UTC) FILETIME=[E33B0420:01C2BEBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> Hi,
> 
> On ppc64 a 32bit task has 4GB and a 64bit task has 2TB of address space.
> 
> We use a bit in the thread struct to decide which limit to apply against
> TASK_SIZE:
> 
> #define TASK_SIZE (test_thread_flag(TIF_32BIT) ? \
>                 TASK_SIZE_USER32 : TASK_SIZE_USER64)
> 
> The TIF_32BIT flag gets set in the arch specific SET_PERSONALITY hook
> in load_elf_binary.
> 
> After the recent changes in mm/mmap.c, the following sequence of events
> happens:
> 
> 1. a 64bit task tries to exec a 32bit one
> 2. we reach load_elf_binary
> 3. call SET_PERSONALITY which sets TIF_32BIT to true
> 4. call flush_old_exec->exec_mmap->mmput->exit_mmap
> 5. call unmap_vmas(,,,,TASK_SIZE,) which only flushes mappings below 4GB
> 6. BUG_ON in exit_mmap
> 
> It seems with the TIF_32BIT scheme we have a window between
> SET_PERSONALITY until exec returns where TASK_SIZE might be considered
> incorrect (although at which exact point to you decide that, yes we are
> now in the new context).
> 
> Any ideas on how to fix this? Maybe we can move SET_PERSONALITY down
> after flush_old_exec.

(Does this only apply to elf?)


If the old process has 64-bit virtual address space and the new process has
32-bit, you want to unmap the 64-bit space, yes?

And if the old process is 32-bit and the new process is 64-bit (possible?)
you want to unmap the 32-bit space.  But unmapping 64-bit space here is
harmless, yes?

Yes, it would be more logical to still be running with the personality of the
old process when we try to expunge all its mappings.  However I suspect we
need all those mappings to grab the exec arguments.

How about we make exit_mmap() be independent of the personality again by
doing something like this?

Looks like ia64 needs work, too...



 asm-ppc64/processor.h |    1 +
 mmap.c                |   18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff -puN mm/mmap.c~exit_mmap-fix mm/mmap.c
--- 25/mm/mmap.c~exit_mmap-fix	2003-01-17 22:35:13.000000000 -0800
+++ 25-akpm/mm/mmap.c	2003-01-17 22:41:10.000000000 -0800
@@ -1379,6 +1379,22 @@ void build_mmap_rb(struct mm_struct * mm
 	}
 }
 
+/*
+ * During exit_mmap, TASK_SIZE is not a reliable indication of the virtual
+ * size of the mm which is being torn down.  Because on the exec() path, this
+ * process may have switched its personality from 64-bit to 32-bit prior to
+ * calling exit_mmap().  So TASK_SIZE returns a value suitable for a 32-bit
+ * process, and not the 64-bit process whose mm we need to invalidate.
+ *
+ * So what we do is to always unmap the largest virtual address space which
+ * the architecture supports.  unmap_vmas() will then unmap every VMA in the
+ * mm, which is what we want to happen here.
+ */
+
+#ifndef TASK_SIZE_MAX
+#define TASK_SIZE_MAX TASK_SIZE
+#endif
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
@@ -1395,7 +1411,7 @@ void exit_mmap(struct mm_struct *mm)
 	tlb = tlb_gather_mmu(mm, 1);
 	flush_cache_mm(mm);
 	mm->map_count -= unmap_vmas(&tlb, mm, mm->mmap, 0,
-					TASK_SIZE, &nr_accounted);
+					TASK_SIZE_MAX, &nr_accounted);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
 	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
diff -puN include/asm-ppc64/processor.h~exit_mmap-fix include/asm-ppc64/processor.h
--- 25/include/asm-ppc64/processor.h~exit_mmap-fix	2003-01-17 22:41:32.000000000 -0800
+++ 25-akpm/include/asm-ppc64/processor.h	2003-01-17 22:42:03.000000000 -0800
@@ -630,6 +630,7 @@ extern struct task_struct *last_task_use
 
 #define TASK_SIZE (test_thread_flag(TIF_32BIT) ? \
 		TASK_SIZE_USER32 : TASK_SIZE_USER64)
+#define TASK_SIZE_MAX	TASK_SIZE_USER64
 #endif /* __KERNEL__ */
 
 

_

