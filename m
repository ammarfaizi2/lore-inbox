Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132428AbRDWWXy>; Mon, 23 Apr 2001 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRDWWWw>; Mon, 23 Apr 2001 18:22:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7182 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132413AbRDWWVX>;
	Mon, 23 Apr 2001 18:21:23 -0400
From: rmk@arm.linux.org.uk
Message-Id: <200104232221.XAA01479@raistlin.arm.linux.org.uk>
Subject: pgd_alloc to include mm_struct
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 23 Apr 2001 23:21:17 +0100 (BST)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This continues from my previous thread (subject line "All architecture
maintainers: pgd_alloc()" on lkml), and for Linus' sake, here is the
explaination I supplied:

| For ARM, I require pgd_alloc to take a struct mm_struct argument (so the
| pgd_alloc prototype becomes "pgd_t *pgd_alloc(struct mm_struct *)".
|   
| Why?  Because ARM must always have the first virtual page allocated and
| present - its used for the hardware vectors, and in order to allocate
| the page table for this page, I need a mm_struct (see the pte_alloc
| prototype and associated code in mm/memory.c).

Here is the patch - it does not contain the ARM changes; they are already
in the 2.4.4-pre tree.  It does however touch every single other
architecture.

The changes look ok, but obviously have only been run on ARM (other
architecture maintainers please help out here if Linus requires it to
be tested).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

diff -u orig/include/asm-alpha/pgalloc.h linux/include/asm-alpha/pgalloc.h
--- orig/include/asm-alpha/pgalloc.h	Sun Apr 22 09:58:37 2001
+++ linux/include/asm-alpha/pgalloc.h	Mon Apr 23 23:06:17 2001
@@ -338,7 +338,7 @@
 #define pte_free(pte)		pte_free_fast(pte)
 #define pmd_free(pmd)		pmd_free_fast(pmd)
 #define pgd_free(pgd)		free_pgd_fast(pgd)
-#define pgd_alloc()		get_pgd_fast()
+#define pgd_alloc(mm)		get_pgd_fast()
 
 extern int do_check_pgt_cache(int, int);
 
diff -u orig/include/asm-cris/pgalloc.h linux/include/asm-cris/pgalloc.h
--- orig/include/asm-cris/pgalloc.h	Thu Feb 22 11:25:43 2001
+++ linux/include/asm-cris/pgalloc.h	Mon Apr 23 23:06:17 2001
@@ -191,7 +191,7 @@
 /* pgd handling */
 
 #define pgd_free(pgd)      free_pgd_slow(pgd)
-#define pgd_alloc()        get_pgd_fast()
+#define pgd_alloc(mm)      get_pgd_fast()
 
 /* other stuff */
 
diff -u orig/include/asm-i386/pgalloc.h linux/include/asm-i386/pgalloc.h
--- orig/include/asm-i386/pgalloc.h	Sat Mar 31 23:47:42 2001
+++ linux/include/asm-i386/pgalloc.h	Mon Apr 23 23:06:17 2001
@@ -130,7 +130,7 @@
 
 #define pte_free(pte)		pte_free_slow(pte)
 #define pgd_free(pgd)		free_pgd_slow(pgd)
-#define pgd_alloc()		get_pgd_fast()
+#define pgd_alloc(mm)		get_pgd_fast()
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff -u orig/include/asm-ia64/pgalloc.h linux/include/asm-ia64/pgalloc.h
--- orig/include/asm-ia64/pgalloc.h	Sun Apr 22 09:58:41 2001
+++ linux/include/asm-ia64/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -48,7 +48,7 @@
 }
 
 static inline pgd_t*
-pgd_alloc (void)
+pgd_alloc (struct mm_struct *mm)
 {
 	/* the VM system never calls pgd_alloc_one_fast(), so we do it here. */
 	pgd_t *pgd = pgd_alloc_one_fast();
diff -u orig/include/asm-m68k/motorola_pgalloc.h linux/include/asm-m68k/motorola_pgalloc.h
--- orig/include/asm-m68k/motorola_pgalloc.h	Wed Dec 13 00:00:25 2000
+++ linux/include/asm-m68k/motorola_pgalloc.h	Mon Apr 23 23:08:43 2001
@@ -160,7 +160,7 @@
 	free_pmd_fast((pmd_t *)pgd);
 }
 
-extern inline pgd_t *pgd_alloc(void)
+extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd = (pgd_t *)get_pmd_fast();
 	if (!pgd)
diff -u orig/include/asm-m68k/sun3_pgalloc.h linux/include/asm-m68k/sun3_pgalloc.h
--- orig/include/asm-m68k/sun3_pgalloc.h	Wed Dec 13 00:00:25 2000
+++ linux/include/asm-m68k/sun3_pgalloc.h	Mon Apr 23 23:07:47 2001
@@ -134,7 +134,7 @@
         free_page((unsigned long) pgd);
 }
 
-extern inline pgd_t * pgd_alloc(void)
+extern inline pgd_t * pgd_alloc(struct mm_struct *mm)
 {
      pgd_t *new_pgd;
 
diff -u orig/include/asm-mips/pgalloc.h linux/include/asm-mips/pgalloc.h
--- orig/include/asm-mips/pgalloc.h	Fri May 26 11:56:30 2000
+++ linux/include/asm-mips/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -128,7 +128,7 @@
 #define pte_free_kernel(pte)    free_pte_fast(pte)
 #define pte_free(pte)           free_pte_fast(pte)
 #define pgd_free(pgd)           free_pgd_fast(pgd)
-#define pgd_alloc()             get_pgd_fast()
+#define pgd_alloc(mm)           get_pgd_fast()
 
 extern inline pte_t * pte_alloc_kernel(pmd_t * pmd, unsigned long address)
 {
diff -u orig/include/asm-mips64/pgalloc.h linux/include/asm-mips64/pgalloc.h
--- orig/include/asm-mips64/pgalloc.h	Wed Dec 13 00:00:25 2000
+++ linux/include/asm-mips64/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -151,7 +151,7 @@
 #define pte_free(pte)           free_pte_fast(pte)
 #define pmd_free(pte)           free_pmd_fast(pte)
 #define pgd_free(pgd)           free_pgd_fast(pgd)
-#define pgd_alloc()             get_pgd_fast()
+#define pgd_alloc(mm)           get_pgd_fast()
 
 extern inline pte_t * pte_alloc(pmd_t * pmd, unsigned long address)
 {
diff -u orig/include/asm-parisc/pgalloc.h linux/include/asm-parisc/pgalloc.h
--- orig/include/asm-parisc/pgalloc.h	Wed Dec 13 00:00:27 2000
+++ linux/include/asm-parisc/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -372,7 +372,7 @@
 #define pte_free(pte)		free_pte_fast(pte)
 #define pmd_free(pmd)           free_pmd_fast(pmd)
 #define pgd_free(pgd)		free_pgd_fast(pgd)
-#define pgd_alloc()		get_pgd_fast()
+#define pgd_alloc(mm)		get_pgd_fast()
 
 extern void __bad_pmd(pmd_t *pmd);
 
diff -u orig/include/asm-ppc/pgalloc.h linux/include/asm-ppc/pgalloc.h
--- orig/include/asm-ppc/pgalloc.h	Sat Mar 31 23:47:43 2001
+++ linux/include/asm-ppc/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -87,7 +87,7 @@
 }
 
 #define pgd_free(pgd)		free_pgd_fast(pgd)
-#define pgd_alloc()		get_pgd_fast()
+#define pgd_alloc(mm)		get_pgd_fast()
 
 /*
  * We don't have any real pmd's, and this code never triggers because
diff -u orig/include/asm-s390/pgalloc.h linux/include/asm-s390/pgalloc.h
--- orig/include/asm-s390/pgalloc.h	Sun Apr 22 09:58:43 2001
+++ linux/include/asm-s390/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -52,7 +52,7 @@
         return (pgd_t *)ret;
 }
 
-extern __inline__ pgd_t *pgd_alloc(void)
+extern __inline__ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 
diff -u orig/include/asm-s390x/pgalloc.h linux/include/asm-s390x/pgalloc.h
--- orig/include/asm-s390x/pgalloc.h	Sun Apr 22 09:58:44 2001
+++ linux/include/asm-s390x/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -55,7 +55,7 @@
 	return (pgd_t *) ret;
 }
 
-extern __inline__ pgd_t *pgd_alloc (void)
+extern __inline__ pgd_t *pgd_alloc (struct mm_struct *mm)
 {
 	pgd_t *pgd;
 
diff -u orig/include/asm-sh/pgalloc.h linux/include/asm-sh/pgalloc.h
--- orig/include/asm-sh/pgalloc.h	Sun Apr 22 09:58:44 2001
+++ linux/include/asm-sh/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -89,7 +89,7 @@
 
 #define pte_free(pte)		pte_free_slow(pte)
 #define pgd_free(pgd)		free_pgd_slow(pgd)
-#define pgd_alloc()		get_pgd_fast()
+#define pgd_alloc(mm)		get_pgd_fast()
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff -u orig/include/asm-sparc/pgalloc.h linux/include/asm-sparc/pgalloc.h
--- orig/include/asm-sparc/pgalloc.h	Thu Nov  2 12:46:15 2000
+++ linux/include/asm-sparc/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -137,6 +137,6 @@
 BTFIXUPDEF_CALL(pgd_t *, pgd_alloc, void)
 
 #define pgd_free(pgd) BTFIXUP_CALL(pgd_free)(pgd)
-#define pgd_alloc() BTFIXUP_CALL(pgd_alloc)()
+#define pgd_alloc(mm) BTFIXUP_CALL(pgd_alloc)()
 
 #endif /* _SPARC64_PGALLOC_H */
diff -u orig/include/asm-sparc64/pgalloc.h linux/include/asm-sparc64/pgalloc.h
--- orig/include/asm-sparc64/pgalloc.h	Sun Apr 22 09:58:46 2001
+++ linux/include/asm-sparc64/pgalloc.h	Mon Apr 23 23:06:18 2001
@@ -300,7 +300,7 @@
 #define pte_free(pte)		free_pte_fast(pte)
 #define pmd_free(pmd)		free_pmd_fast(pmd)
 #define pgd_free(pgd)		free_pgd_fast(pgd)
-#define pgd_alloc()		get_pgd_fast()
+#define pgd_alloc(mm)		get_pgd_fast()
 
 extern int do_check_pgt_cache(int, int);
 
diff -u linux-orig/kernel/fork.c linux/kernel/fork.c
--- linux-orig/kernel/fork.c	Sat Mar 31 23:47:46 2001
+++ linux/kernel/fork.c	Sat Apr  7 10:46:24 2001
@@ -203,7 +203,7 @@
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
-	mm->pgd = pgd_alloc();
+	mm->pgd = pgd_alloc(mm);
 	if (mm->pgd)
 		return mm;
 	free_mm(mm);

