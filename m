Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264088AbUFBUTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUFBUTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUFBUS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:18:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:33714 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264088AbUFBURL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:17:11 -0400
Date: Wed, 2 Jun 2004 21:16:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: davidm@hpl.hp.com, <James.Bottomley@SteelEye.com>, <ak@suse.de>,
       <rmk@arm.linux.org.uk>, <paulus@samba.org>, <anton@samba.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] pretest pte_young and pte_dirty
In-Reply-To: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0406022114110.27696-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Test for pte_young before going to the costlier atomic test_and_clear,
as asm-generic does.  Test for pte_dirty before going to the costlier
atomic test_and_clear, as asm-generic does (I said before that I would
not do so for pte_dirty, but was missing the point: there is nothing
atomic about deciding to do nothing).  But I've not touched the rather
different ppc and ppc64.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 include/asm-i386/pgtable.h   |   16 ++++++++++++++--
 include/asm-ia64/pgtable.h   |    4 ++++
 include/asm-parisc/pgtable.h |    4 ++++
 include/asm-x86_64/pgtable.h |   17 +++++++++++++++--
 4 files changed, 37 insertions(+), 4 deletions(-)

--- 2.6.7-rc2/include/asm-i386/pgtable.h	2004-05-30 11:36:30.000000000 +0100
+++ linux/include/asm-i386/pgtable.h	2004-06-02 16:32:40.032214544 +0100
@@ -220,8 +220,20 @@ static inline pte_t pte_mkdirty(pte_t pt
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 
-static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
-static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low); }
+static inline int ptep_test_and_clear_dirty(pte_t *ptep)
+{
+	if (!pte_dirty(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
+}
+
+static inline int ptep_test_and_clear_young(pte_t *ptep)
+{
+	if (!pte_young(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low);
+}
+
 static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, &ptep->pte_low); }
 static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
 
--- 2.6.7-rc2/include/asm-ia64/pgtable.h	2004-05-30 11:36:31.000000000 +0100
+++ linux/include/asm-ia64/pgtable.h	2004-06-02 16:32:40.034214240 +0100
@@ -346,6 +346,8 @@ static inline int
 ptep_test_and_clear_young (pte_t *ptep)
 {
 #ifdef CONFIG_SMP
+	if (!pte_young(*ptep))
+		return 0;
 	return test_and_clear_bit(_PAGE_A_BIT, ptep);
 #else
 	pte_t pte = *ptep;
@@ -360,6 +362,8 @@ static inline int
 ptep_test_and_clear_dirty (pte_t *ptep)
 {
 #ifdef CONFIG_SMP
+	if (!pte_dirty(*ptep))
+		return 0;
 	return test_and_clear_bit(_PAGE_D_BIT, ptep);
 #else
 	pte_t pte = *ptep;
--- 2.6.7-rc2/include/asm-parisc/pgtable.h	2004-05-30 11:36:33.000000000 +0100
+++ linux/include/asm-parisc/pgtable.h	2004-06-02 16:32:40.035214088 +0100
@@ -417,6 +417,8 @@ extern void update_mmu_cache(struct vm_a
 static inline int ptep_test_and_clear_young(pte_t *ptep)
 {
 #ifdef CONFIG_SMP
+	if (!pte_young(*ptep))
+		return 0;
 	return test_and_clear_bit(xlate_pabit(_PAGE_ACCESSED_BIT), ptep);
 #else
 	pte_t pte = *ptep;
@@ -430,6 +432,8 @@ static inline int ptep_test_and_clear_yo
 static inline int ptep_test_and_clear_dirty(pte_t *ptep)
 {
 #ifdef CONFIG_SMP
+	if (!pte_dirty(*ptep))
+		return 0;
 	return test_and_clear_bit(xlate_pabit(_PAGE_DIRTY_BIT), ptep);
 #else
 	pte_t pte = *ptep;
--- 2.6.7-rc2/include/asm-x86_64/pgtable.h	2004-05-30 11:36:35.000000000 +0100
+++ linux/include/asm-x86_64/pgtable.h	2004-06-02 16:32:40.036213936 +0100
@@ -262,8 +262,21 @@ extern inline pte_t pte_mkexec(pte_t pte
 extern inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
 extern inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_RW)); return pte; }
-static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep); }
-static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep); }
+
+static inline int ptep_test_and_clear_dirty(pte_t *ptep)
+{
+	if (!pte_dirty(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep);
+}
+
+static inline int ptep_test_and_clear_young(pte_t *ptep)
+{
+	if (!pte_young(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep);
+}
+
 static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, ptep); }
 static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, ptep); }
 

