Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130522AbRCDVuW>; Sun, 4 Mar 2001 16:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbRCDVuL>; Sun, 4 Mar 2001 16:50:11 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:47796 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S130522AbRCDVt7>; Sun, 4 Mar 2001 16:49:59 -0500
Date: Sun, 4 Mar 2001 22:49:51 +0100
From: Ulrich Kunitz <gefm21@uumail.de>
To: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: [PATCH] tiny MM performance and typo patches for 2.4.2
Message-ID: <20010304224951.B1979@uumail.de>
Mail-Followup-To: Ulrich Kunitz <gefm21@uumail.de>,
	linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

this is a list of patches I collected while looking at the memory
management sources. Two patches might improve the performance of your
box. The others are more or less cosmetic. 

This mail is sent with a kernel using these patches.
Here is a list sorted with decreasing importance:

patch-uk2 	makes use of the pgd, pmd and pte quicklists for x86 too;
		risky: there might be a reason that 2.4.x doesn't use the
		quicklists.

patch-uk6	In 2.4.x _page_hashfn divides struct address_space pointer
		with a parameter derived from the size of struct
		inode. Deriving this parameter from the size of struct
		address_space makes more sense -- at least for me.

patch-uk5	cleans the bd_flush_param union.

patch-uk1	fixes a comment typo in asm-i386/highmem.h.

patch-uk3	fixes a comment typo in asm-i386/pgtable-3level.h.

Ciao,

Uli Kunitz

-- 
Ulrich Kunitz (gefm21@uumail.de)

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-uk2
Content-Disposition: inline; filename=patch-uk2

--- linux-2.4.2/include/asm-i386/pgalloc.h	Thu Feb 22 01:09:57 2001
+++ linux/include/asm-i386/pgalloc.h	Sun Mar  4 20:14:50 2001
@@ -92,9 +92,9 @@
 	free_page((unsigned long)pte);
 }
 
-#define pte_free_kernel(pte)    free_pte_slow(pte)
-#define pte_free(pte)	   free_pte_slow(pte)
-#define pgd_free(pgd)	   free_pgd_slow(pgd)
+#define pte_free_kernel(pte)    free_pte_fast(pte)
+#define pte_free(pte)	   free_pte_fast(pte)
+#define pgd_free(pgd)	   free_pgd_fast(pgd)
 #define pgd_alloc()	     get_pgd_fast()
 
 extern inline pte_t * pte_alloc_kernel(pmd_t * pmd, unsigned long address)
@@ -145,7 +145,7 @@
  * inside the pgd, so has no extra memory associated with it.
  * (In the PAE case we free the page.)
  */
-#define pmd_free(pmd)	   free_pmd_slow(pmd)
+#define pmd_free(pmd)	   free_pmd_fast(pmd)
 
 #define pmd_free_kernel		pmd_free
 #define pmd_alloc_kernel	pmd_alloc

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-uk6
Content-Disposition: inline; filename=patch-uk6

--- linux-2.4.2/include/linux/pagemap.h	Thu Feb 22 01:10:01 2001
+++ linux/include/linux/pagemap.h	Sun Mar  4 20:14:50 2001
@@ -58,7 +58,8 @@
  */
 extern inline unsigned long _page_hashfn(struct address_space * mapping, unsigned long index)
 {
-#define i (((unsigned long) mapping)/(sizeof(struct inode) & ~ (sizeof(struct inode) - 1)))
+#define i (((unsigned long) mapping) / \
+	(sizeof(struct address_space) & ~ (sizeof(struct address_space) - 1)))
 #define s(x) ((x)+((x)>>PAGE_HASH_BITS))
 	return s(i+index) & (PAGE_HASH_SIZE-1);
 #undef i

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-uk5
Content-Disposition: inline; filename=patch-uk5

--- linux-2.4.2/fs/buffer.c	Fri Feb  9 20:29:44 2001
+++ linux/fs/buffer.c	Sun Mar  4 19:27:31 2001
@@ -112,19 +112,18 @@
  */
 union bdflush_param {
 	struct {
-		int nfract;  /* Percentage of buffer cache dirty to 
-				activate bdflush */
-		int ndirty;  /* Maximum number of dirty blocks to write out per
+		int nfract;   /* Percentage of buffer cache dirty to 
+				 activate bdflush */
+		int ndirty;   /* Maximum number of dirty blocks to write out per
 				wake-cycle */
-		int nrefill; /* Number of clean buffers to try to obtain
-				each time we call refill */
 		int dummy1;   /* unused */
+		int dummy2;   /* unused */
 		int interval; /* jiffies delay between kupdate flushes */
 		int age_buffer;  /* Time for normal buffer to age before we flush it */
 		int nfract_sync; /* Percentage of buffer cache dirty to 
 				    activate bdflush synchronously */
-		int dummy2;    /* unused */
-		int dummy3;    /* unused */
+		int dummy3;   /* unused */
+		int dummy4;   /* unused */
 	} b_un;
 	unsigned int data[N_PARAM];
 } bdf_prm = {{30, 64, 64, 256, 5*HZ, 30*HZ, 60, 0, 0}};

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-uk1
Content-Disposition: inline; filename=patch-uk1

--- linux-2.4.2/include/asm-i386/highmem.h	Thu Feb 22 01:09:58 2001
+++ linux/include/asm-i386/highmem.h	Sun Mar  4 20:14:50 2001
@@ -9,7 +9,7 @@
  *
  *
  * Redesigned the x86 32-bit VM architecture to deal with 
- * up to 16 Terrabyte physical memory. With current x86 CPUs
+ * up to 16 Terabyte physical memory. With current x86 CPUs
  * we now support up to 64 Gigabytes physical RAM.
  *
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-uk3
Content-Disposition: inline; filename=patch-uk3

--- linux-2.4.2/include/asm-i386/pgtable-3level.h	Wed Oct 18 23:25:46 2000
+++ linux/include/asm-i386/pgtable-3level.h	Sun Mar  4 19:25:00 2001
@@ -48,7 +48,7 @@
 /* Rules for using set_pte: the pte being assigned *must* be
  * either not present or in a state where the hardware will
  * not attempt to update the pte.  In places where this is
- * not possible, use pte_get_and_clear to obtain the old pte
+ * not possible, use ptep_get_and_clear to obtain the old pte
  * value and then use set_pte to update it.  -ben
  */
 static inline void set_pte(pte_t *ptep, pte_t pte)

--gatW/ieO32f1wygP--
