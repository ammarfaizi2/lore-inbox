Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQKONKB>; Wed, 15 Nov 2000 08:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbQKONJw>; Wed, 15 Nov 2000 08:09:52 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:8176 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129455AbQKONJl> convert rfc822-to-8bit; Wed, 15 Nov 2000 08:09:41 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C1256998.004585F4.00@d12mta07.de.ibm.com>
Date: Wed, 15 Nov 2000 13:39:13 +0100
Subject: Memory management bug
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I think I spotted a problem in the memory management of some (all?)
architectures in 2.4.0-test10.  At the moment I am fighting with the 64bit
backend for the new S/390 machines. I experienced infinite loops in
do_check_pgt_cache because pgtable_cache_size indicated that a lot of pages
are in the quicklists but the pgd/pmd/pte quicklists have been empty (NULL
pointers). After some trickery with some special hardware feature (storage
keys) I found out that empty_bad_pmd_table and empty_bad_pte_table have
been put to the page table quicklists multiple(!) times. It is already a
bug that these two arrays are inserted into the quicklist at all but the
second insertation destroys the quicklists. I solved this problem by
inserting checks for the special entries in  the free_xxx_fast routines,
here is a sample for the i386 free_pte_fast:

diff -u -r1.5 pgalloc.h
--- include/asm-i386/pgalloc.h  2000/11/02 10:14:51     1.5
+++ include/asm-i386/pgalloc.h  2000/11/15 12:27:58
@@ -80,8 +80,11 @@
        return (pte_t *)ret;
 }

+extern pte_t empty_bad_pte_table[];
 extern __inline__ void free_pte_fast(pte_t *pte)
 {
+       if (pte == empty_bad_pte_table)
+               return;
        *(unsigned long *)pte = (unsigned long) pte_quicklist;
        pte_quicklist = (unsigned long *) pte;
        pgtable_cache_size++;

I still get the "__alloc_pages: 2-order allocation failed." error messages
but at least the machine doesn't go into infinite loops anymore. Could
someone with more experience with the other architectures verify that my
observation is true?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
