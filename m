Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbSKPWKY>; Sat, 16 Nov 2002 17:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbSKPWKY>; Sat, 16 Nov 2002 17:10:24 -0500
Received: from verein.lst.de ([212.34.181.86]:53775 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267383AbSKPWKW>;
	Sat, 16 Nov 2002 17:10:22 -0500
Date: Sat, 16 Nov 2002 23:17:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fork.c bits for uClinux
Message-ID: <20021116231718.A26716@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mmuless ports don't need dup_mmap nor allocation of a pgd.

I tried to avoid ifdef-mess as far as possible, and to archive that
I created small wrappers for pgd allocation/freeing and move taking
of the mmap semaphore into dup_mmap from the only caller.  The end
result is just one additiona ifdef.


--- 1.83/kernel/fork.c	Tue Nov  5 23:27:16 2002
+++ edited/kernel/fork.c	Thu Nov 14 00:53:05 2002
@@ -205,12 +205,14 @@
 	return tsk;
 }
 
+#ifdef CONFIG_MMU
 static inline int dup_mmap(struct mm_struct * mm)
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
 	unsigned long charge = 0;
 
+	down_write(&mm->mmap_sem);
 	flush_cache_mm(current->mm);
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
@@ -287,11 +289,29 @@
 
 out:
 	flush_tlb_mm(current->mm);
+	up_write(&mm->mmap_sem);
 	return retval;
 fail_nomem:
 	vm_unacct_memory(charge);
 	goto out;
 }
+static inline int mm_alloc_pgd(struct mm_struct * mm)
+{
+	mm->pgd = pgd_alloc(mm);
+	if (unlikely(!mm->pgd))
+		return -ENOMEM;
+	return 0;
+}
+
+static inline void mm_free_pgd(struct mm_struct * mm)
+{
+	pgd_free(mm->pgd);
+}
+#else
+#define dup_mmap(mm)		(0)
+#define mm_alloc_pgd(mm)	(0)
+#define mm_free_pgd(mm)
+#endif /* CONFIG_MMU */
 
 spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int mmlist_nr;
@@ -314,8 +334,7 @@
 	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 
-	mm->pgd = pgd_alloc(mm);
-	if (mm->pgd)
+	if (likely(!mm_alloc_pgd(mm)))
 		return mm;
 	free_mm(mm);
 	return NULL;
@@ -344,8 +363,8 @@
  */
 inline void __mmdrop(struct mm_struct *mm)
 {
-	if (mm == &init_mm) BUG();
-	pgd_free(mm->pgd);
+	BUG_ON(mm == &init_mm);
+	mm_free_pgd(mm);
 	destroy_context(mm);
 	free_mm(mm);
 }
@@ -444,10 +463,7 @@
 	if (init_new_context(tsk,mm))
 		goto free_pt;
 
-	down_write(&oldmm->mmap_sem);
 	retval = dup_mmap(mm);
-	up_write(&oldmm->mmap_sem);
-
 	if (retval)
 		goto free_pt;
 
