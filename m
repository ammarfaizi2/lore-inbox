Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSJMMGa>; Sun, 13 Oct 2002 08:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSJMMG3>; Sun, 13 Oct 2002 08:06:29 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:21137 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261506AbSJMMGH>;
	Sun, 13 Oct 2002 08:06:07 -0400
Message-ID: <3DA962D3.7080906@colorfullife.com>
Date: Sun, 13 Oct 2002 14:10:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] remove copy_segments, release_segments, forget_segments
Content-Type: multipart/mixed;
 boundary="------------000405030008010900050807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000405030008010900050807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

forget_segments and copy_segments are already dead, release_segments is
used right now for i386 and x86_64 to release the ldt structures.
But the code is asymmetric: creation in init_new_context(), destruction
in release_segments().

What about the attached patch?
i386 and x86_64 can use destroy_context, then the _segment functions can
be removed entirely.

--
	Manfred


--------------000405030008010900050807
Content-Type: text/plain;
 name="patch-remove_segments"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-remove_segments"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 42
//  EXTRAVERSION =
--- 2.5/arch/i386/kernel/ldt.c	Sun Oct 13 14:01:08 2002
+++ build-2.5/arch/i386/kernel/ldt.c	Sun Oct 13 13:44:52 2002
@@ -104,7 +104,7 @@
 /*
  * No need to lock the MM as we are the last user
  */
-void release_segments(struct mm_struct *mm)
+void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context.size) {
 		if (mm == current->active_mm)
--- 2.5/include/asm-i386/mmu_context.h	Sun Sep 22 06:24:57 2002
+++ build-2.5/include/asm-i386/mmu_context.h	Sun Oct 13 13:42:50 2002
@@ -8,10 +8,10 @@
 #include <asm/tlbflush.h>
 
 /*
- * possibly do the LDT unload here?
+ * Used for LDT copy/destruction.
  */
-#define destroy_context(mm)		do { } while(0)
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+void destroy_context(struct mm_struct *mm);
 
 #ifdef CONFIG_SMP
 
--- 2.5/include/asm-i386/processor.h	Sun Oct 13 13:56:03 2002
+++ build-2.5/include/asm-i386/processor.h	Sun Oct 13 13:44:02 2002
@@ -437,9 +437,6 @@
  */
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/* Release all segment info associated with a VM */
-extern void release_segments(struct mm_struct * mm);
-
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
 
 unsigned long get_wchan(struct task_struct *p);
--- 2.5/mm/mmap.c	Sun Oct 13 13:56:04 2002
+++ build-2.5/mm/mmap.c	Sun Oct 13 13:43:55 2002
@@ -1278,8 +1278,6 @@
 
 	profile_exit_mmap(mm);
  
-	release_segments(mm);
- 
 	spin_lock(&mm->page_table_lock);
 
 	flush_cache_mm(mm);

--------------000405030008010900050807--


