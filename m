Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268189AbTBSBHo>; Tue, 18 Feb 2003 20:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268190AbTBSBHn>; Tue, 18 Feb 2003 20:07:43 -0500
Received: from holomorphy.com ([66.224.33.161]:39831 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268189AbTBSBHm>;
	Tue, 18 Feb 2003 20:07:42 -0500
Date: Tue, 18 Feb 2003 17:16:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: remove (start|end)_lazy_tlb()
Message-ID: <20030219011648.GA17318@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove start_lazy_tlb() and end_lazy_tlb(), as they are unused.

 include/linux/sched.h |    3 ---
 kernel/exit.c         |   26 --------------------------
 2 files changed, 29 deletions(-)


diff -urpN linux-2.5.62/include/linux/sched.h cleanup-2.5.62-1/include/linux/sched.h
--- linux-2.5.62/include/linux/sched.h	2003-02-17 14:55:53.000000000 -0800
+++ cleanup-2.5.62-1/include/linux/sched.h	2003-02-18 17:13:37.000000000 -0800
@@ -571,9 +571,6 @@ static inline int capable(int cap)
  */
 extern struct mm_struct * mm_alloc(void);
 
-extern struct mm_struct * start_lazy_tlb(void);
-extern void end_lazy_tlb(struct mm_struct *mm);
-
 /* mmdrop drops the mm and the page tables */
 extern inline void FASTCALL(__mmdrop(struct mm_struct *));
 static inline void mmdrop(struct mm_struct * mm)
diff -urpN linux-2.5.62/kernel/exit.c cleanup-2.5.62-1/kernel/exit.c
--- linux-2.5.62/kernel/exit.c	2003-02-17 14:56:54.000000000 -0800
+++ cleanup-2.5.62-1/kernel/exit.c	2003-02-18 17:13:05.000000000 -0800
@@ -435,32 +435,6 @@ void exit_fs(struct task_struct *tsk)
 }
 
 /*
- * We can use these to temporarily drop into
- * "lazy TLB" mode and back.
- */
-struct mm_struct * start_lazy_tlb(void)
-{
-	struct mm_struct *mm = current->mm;
-	current->mm = NULL;
-	/* active_mm is still 'mm' */
-	atomic_inc(&mm->mm_count);
-	enter_lazy_tlb(mm, current, smp_processor_id());
-	return mm;
-}
-
-void end_lazy_tlb(struct mm_struct *mm)
-{
-	struct mm_struct *active_mm = current->active_mm;
-
-	current->mm = mm;
-	if (mm != active_mm) {
-		current->active_mm = mm;
-		activate_mm(active_mm, mm);
-	}
-	mmdrop(active_mm);
-}
-
-/*
  * Turn us into a lazy TLB process if we
  * aren't already..
  */
