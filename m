Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbSKPWhl>; Sat, 16 Nov 2002 17:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbSKPWhl>; Sat, 16 Nov 2002 17:37:41 -0500
Received: from verein.lst.de ([212.34.181.86]:15888 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267388AbSKPWhi>;
	Sat, 16 Nov 2002 17:37:38 -0500
Date: Sat, 16 Nov 2002 23:44:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork.c bits for uClinux
Message-ID: <20021116234432.A27155@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20021116231718.A26716@lst.de> <20021116233306.J628@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021116233306.J628@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Sat, Nov 16, 2002 at 11:33:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 11:33:06PM +0100, Ingo Oeser wrote:
> The contents of the old struct mm_struct is copied and the
> semaphore of the old structure is taken. Now the content of the
> NEW semaphore is taken, which might be wrong, because the
> semaphore value is contained in the struct mm_struct and not a
> pointer.
> 
> Fix is to do give the oldmm as argument to dup_mm

Here's the update patch, thanks for the spot.


--- 1.83/kernel/fork.c	Tue Nov  5 23:27:16 2002
+++ edited/kernel/fork.c	Sat Nov 16 22:40:59 2002
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/futex.h>
 #include <linux/ptrace.h>
+#include <linux/mount.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -205,12 +206,14 @@
 	return tsk;
 }
 
-static inline int dup_mmap(struct mm_struct * mm)
+#ifdef CONFIG_MMU
+static inline int dup_mmap(struct mm_struct * mm, struct mm_struct * oldmm)
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
 	unsigned long charge = 0;
 
+	down_write(&oldmm->mmap_sem);
 	flush_cache_mm(current->mm);
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
@@ -287,11 +290,29 @@
 
 out:
 	flush_tlb_mm(current->mm);
+	up_write(&oldmm->mmap_sem);
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
+#define dup_mmap(mm, oldmm)	(0)
+#define mm_alloc_pgd(mm)	(0)
+#define mm_free_pgd(mm)
+#endif /* CONFIG_MMU */
 
 spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int mmlist_nr;
@@ -314,8 +335,7 @@
 	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 
-	mm->pgd = pgd_alloc(mm);
-	if (mm->pgd)
+	if (likely(!mm_alloc_pgd(mm)))
 		return mm;
 	free_mm(mm);
 	return NULL;
@@ -344,8 +364,8 @@
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
@@ -444,10 +464,7 @@
 	if (init_new_context(tsk,mm))
 		goto free_pt;
 
-	down_write(&oldmm->mmap_sem);
-	retval = dup_mmap(mm);
-	up_write(&oldmm->mmap_sem);
-
+	retval = dup_mmap(mm, oldmm);
 	if (retval)
 		goto free_pt;
 
