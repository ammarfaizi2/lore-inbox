Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269285AbUJKWKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269285AbUJKWKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUJKWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:10:45 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:17616 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269285AbUJKWKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:10:14 -0400
Date: Tue, 12 Oct 2004 00:11:04 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: ptep_establish smp race x86 PAE >4G
Message-ID: <20041011221104.GA17372@dualathlon.random>
References: <20040930060851.GJ22008@dualathlon.random> <20040930172650.4301ec92.akpm@osdl.org> <20041001003613.GE32279@dualathlon.random> <20040930175232.4d65ef50.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930175232.4d65ef50.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This avoid userspace mm corruption during COWs with threads (i.e.
malloc;fork;clone) on x86 PAE with >4G of ram

Signed-Off-By: Andrea Arcangeli <andrea@novell.com>

Index: linux-2.5/include/asm-i386/pgtable-3level.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/asm-i386/pgtable-3level.h,v
retrieving revision 1.20
diff -u -p -r1.20 pgtable-3level.h
--- linux-2.5/include/asm-i386/pgtable-3level.h	24 Aug 2004 18:28:07 -0000	1.20
+++ linux-2.5/include/asm-i386/pgtable-3level.h	11 Oct 2004 21:17:56 -0000
@@ -54,6 +54,7 @@ static inline void set_pte(pte_t *ptep, 
 	smp_wmb();
 	ptep->pte_low = pte.pte_low;
 }
+#define __HAVE_ARCH_SET_PTE_ATOMIC
 #define set_pte_atomic(pteptr,pteval) \
 		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
 #define set_pmd(pmdptr,pmdval) \
Index: linux-2.5/include/asm-generic/pgtable.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/asm-generic/pgtable.h,v
retrieving revision 1.8
diff -u -p -r1.8 pgtable.h
--- linux-2.5/include/asm-generic/pgtable.h	29 Jul 2004 06:01:30 -0000	1.8
+++ linux-2.5/include/asm-generic/pgtable.h	11 Oct 2004 22:07:31 -0000
@@ -13,11 +13,19 @@
  * Note: the old pte is known to not be writable, so we don't need to
  * worry about dirty bits etc getting lost.
  */
+#ifndef __HAVE_ARCH_SET_PTE_ATOMIC
 #define ptep_establish(__vma, __address, __ptep, __entry)		\
 do {				  					\
 	set_pte(__ptep, __entry);					\
 	flush_tlb_page(__vma, __address);				\
 } while (0)
+#else /* __HAVE_ARCH_SET_PTE_ATOMIC */
+#define ptep_establish(__vma, __address, __ptep, __entry)		\
+do {				  					\
+	set_pte_atomic(__ptep, __entry);				\
+	flush_tlb_page(__vma, __address);				\
+} while (0)
+#endif /* __HAVE_ARCH_SET_PTE_ATOMIC */
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
