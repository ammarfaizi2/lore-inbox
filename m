Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRATPeI>; Sat, 20 Jan 2001 10:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130022AbRATPd6>; Sat, 20 Jan 2001 10:33:58 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:3470 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S129860AbRATPdo>; Sat, 20 Jan 2001 10:33:44 -0500
Date: Sat, 20 Jan 2001 16:33:41 +0100
From: Ulrich Kunitz <gefm21@uumail.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 i386: Why free_xxx_slow() instead free_xxx_fast()?
Message-ID: <20010120163341.A767@uumail.de>
Mail-Followup-To: Ulrich Kunitz <gefm21@uumail.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in include/asm-i386/pgalloc.h the {pgd,pmd,pte}_free* functions are
defined as the functions free_{pgd,pmd,pte}_slow (see the patch below).
IMO this leaves the quick lists pretty useless for i386.
Have I overlooked something?

There is a linux-kernel mail from Martin Schwidefsky
(schwidefsky@de.ibm.com) about 2.4.0-test10 hinting on bad_pmd_table()
and bad_pgd_table() landing in the quick lists. Using the _slow
functions would fix any problem with the quick lists for now.

Changing the defines as in the patch seems to work here on a
two uniprocessor machines (Pentium III, Athlon). I've checked with
2.4.1-pre9 too. But what are the risks?

Ciao,

Uli Kunitz

--- linux-2.4.0/include/asm-i386/pgalloc.h	Tue Jan  9 15:00:08 2001
+++ linux/include/asm-i386/pgalloc.h	Thu Jan 11 17:30:55 2001
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

-- 
Ulrich Kunitz (gefm21@uumail.de)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
