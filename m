Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLWKwg>; Sat, 23 Dec 2000 05:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLWKw1>; Sat, 23 Dec 2000 05:52:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63505 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129210AbQLWKwT>;
	Sat, 23 Dec 2000 05:52:19 -0500
Date: Sat, 23 Dec 2000 10:21:52 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] find_vma_prev rewrite
Message-ID: <20001223102152.B17346@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


find_vma_prev doesn't return a pointer to the `prev' vma if the address
is greater than the last existing vma.  This doesn't matter unless you're
on a PA-RISC machine :-)

This rewrite should speed up & make find_vma_prev simpler, as well as
fixing the previous behaviour.

--- linux-t10/mm/mmap.c	Fri Oct 13 20:10:30 2000
+++ linux-mine/mm/mmap.c	Wed Dec 20 15:22:53 2000
@@ -417,54 +417,48 @@
 struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
 				      struct vm_area_struct **pprev)
 {
-	if (mm) {
-		if (!mm->mmap_avl) {
-			/* Go through the linear list. */
-			struct vm_area_struct * prev = NULL;
-			struct vm_area_struct * vma = mm->mmap;
-			while (vma && vma->vm_end <= addr) {
-				prev = vma;
-				vma = vma->vm_next;
-			}
-			*pprev = prev;
-			return vma;
-		} else {
-			/* Go through the AVL tree quickly. */
-			struct vm_area_struct * vma = NULL;
-			struct vm_area_struct * last_turn_right = NULL;
-			struct vm_area_struct * prev = NULL;
-			struct vm_area_struct * tree = mm->mmap_avl;
-			for (;;) {
-				if (tree == vm_avl_empty)
+	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *prev = NULL;
+	if (!mm)
+		goto out;
+	prev = mm->mmap_cache;
+	if (prev) {
+		vma = prev->vm_next;
+		if (prev->vm_end < addr &&
+				((vma == NULL) || (addr < vma->vm_end)))
+			goto out;
+		prev = NULL;
+	}
+	vma = mm->mmap; /* guard against there being no prev */
+	if (!mm->mmap_avl) {
+		/* Go through the linear list. */
+		while (vma && vma->vm_end <= addr) {
+			prev = vma;
+			vma = vma->vm_next;
+		}
+	} else {
+		/* Go through the AVL tree quickly. */
+		struct vm_area_struct * tree = mm->mmap_avl;
+		while (tree != vm_avl_empty) {
+			if (addr < tree->vm_end) {
+				tree = tree->vm_avl_left;
+			} else {
+				prev = tree;
+				if (tree->vm_next == NULL)
 					break;
-				if (tree->vm_end > addr) {
-					vma = tree;
-					prev = last_turn_right;
-					if (tree->vm_start <= addr)
-						break;
-					tree = tree->vm_avl_left;
-				} else {
-					last_turn_right = tree;
-					tree = tree->vm_avl_right;
-				}
-			}
-			if (vma) {
-				if (vma->vm_avl_left != vm_avl_empty) {
-					prev = vma->vm_avl_left;
-					while (prev->vm_avl_right != vm_avl_empty)
-						prev = prev->vm_avl_right;
-				}
-				if ((prev ? prev->vm_next : mm->mmap) != vma)
-					printk("find_vma_prev: tree inconsistent with list\n");
-				*pprev = prev;
-				return vma;
+				if (addr < tree->vm_next->vm_end)
+					break;
+				tree = tree->vm_avl_right;
 			}
 		}
 	}
-	*pprev = NULL;
-	return NULL;
+	mm->mmap_cache = prev;
+out:
+	*pprev = prev;
+	return prev ? prev->vm_next : vma;
 }
 
+/* XXX: Needs to be fixed for PA-RISC -- won't grow our stack. */
 struct vm_area_struct * find_extend_vma(struct mm_struct * mm, unsigned long addr)
 {
 	struct vm_area_struct * vma;

-- 
Revolutions do not require corporate support.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
