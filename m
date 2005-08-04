Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVHDATK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVHDATK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVHDATK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:19:10 -0400
Received: from graphe.net ([209.204.138.32]:59582 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261656AbVHDATI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:19:08 -0400
Date: Wed, 3 Aug 2005 17:19:04 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1122937261.7648.151.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508031716001.24733@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
  <1122926537.7648.105.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0508011335090.7011@graphe.net>  <1122930474.7648.119.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011414480.7574@graphe.net>  <1122931637.7648.125.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011438010.7888@graphe.net>  <1122933133.7648.141.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011517300.8498@graphe.net> <1122937261.7648.151.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you try the following patch? I think the problem was that higher 
addressses were not mappable via the page fault handler. This patch 
inserts the pmd entry into the pgd as necessary if the pud level is 
folded.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc4/mm/memory.c
===================================================================
--- linux-2.6.13-rc4.orig/mm/memory.c	2005-08-03 17:08:29.000000000 -0700
+++ linux-2.6.13-rc4/mm/memory.c	2005-08-03 17:15:22.000000000 -0700
@@ -2144,9 +2144,16 @@
 	 */
 	page_table_atomic_start(mm);
 	pgd = pgd_offset(mm, address);
-#ifndef __PAGETABLE_PUD_FOLDED
 	if (unlikely(pgd_none(*pgd))) {
+#ifdef __PAGETABLE_PUD_FOLDED
+		/* If the pud is folded then we need to insert a pmd entry into
+		 * a pgd. pud_none(pgd) == 0 so the next if statement will never
+		 * be taken
+		 */
+		pmd_t *new;
+#else
 		pud_t *new;
+#endif
 
 		page_table_atomic_stop(mm);
 		new = pud_alloc_one(mm, address);
@@ -2158,7 +2165,6 @@
 		if (!pgd_test_and_populate(mm, pgd, new))
 			pud_free(new);
 	}
-#endif
 
 	pud = pud_offset(pgd, address);
 	if (unlikely(pud_none(*pud))) {
Index: linux-2.6.13-rc4/include/asm-generic/4level-fixup.h
===================================================================
--- linux-2.6.13-rc4.orig/include/asm-generic/4level-fixup.h	2005-08-03 17:06:01.000000000 -0700
+++ linux-2.6.13-rc4/include/asm-generic/4level-fixup.h	2005-08-03 17:09:38.000000000 -0700
@@ -27,6 +27,7 @@
 #define pud_ERROR(pud)			do { } while (0)
 #define pud_clear(pud)			pgd_clear(pud)
 #define pud_populate			pgd_populate
+#define pud_alloc_one			pmd_alloc_one
 
 #undef pud_free_tlb
 #define pud_free_tlb(tlb, x)            do { } while (0)
