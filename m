Return-Path: <linux-kernel-owner+w=401wt.eu-S1758839AbWLIEtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758839AbWLIEtc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 23:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758826AbWLIEtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 23:49:32 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36665 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758839AbWLIEtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 23:49:31 -0500
Date: Sat, 9 Dec 2006 13:52:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clameter@engr.sgi.com,
       apw@shadowen.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [1/4]  map and
 unmap
Message-Id: <20061209135250.dffc1d2f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061209114333.355c62e9.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160142.d40cf636.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208162819.f809d703.akpm@osdl.org>
	<20061209114333.355c62e9.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes implicit default actions in map_generic_kernel() call.
Also changes comments in vmalloc.h

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: devel-2.6.19/include/linux/vmalloc.h
===================================================================
--- devel-2.6.19.orig/include/linux/vmalloc.h	2006-12-08 15:02:39.000000000 +0900
+++ devel-2.6.19/include/linux/vmalloc.h	2006-12-09 13:46:17.000000000 +0900
@@ -81,6 +81,9 @@
  * not managed by standard vmap calls.
  * The caller has to be responsible to manage his own virtual address space.
  *
+ * what you have to do in pud/pmd/pte allocation is allocate page and
+ * populate that entry.
+ *
  * Bootstrap consideration:
  * you can pass pud/pmd/pte alloc functions to map_generic_kernel().
  * So you can use bootmem function or something to alloc page tables if
@@ -88,13 +91,12 @@
  */
 
 struct gen_map_kern_ops {
-	/* must be defined */
+	/* all pointers must be filled */
 	int	(*k_pte_set)(pte_t *pte, unsigned long addr, void *data);
-	int	(*k_pte_clear)(pte_t *pte, unsigned long addr, void *data);
-	/* optional */
 	int 	(*k_pud_alloc)(pgd_t *pgd, unsigned long addr, void *data);
 	int 	(*k_pmd_alloc)(pud_t *pud, unsigned long addr, void *data);
 	int 	(*k_pte_alloc)(pmd_t *pmd, unsigned long addr, void *data);
+	int	(*k_pte_clear)(pte_t *pte, unsigned long addr, void *data);
 };
 
 /*
Index: devel-2.6.19/mm/vmalloc.c
===================================================================
--- devel-2.6.19.orig/mm/vmalloc.c	2006-12-08 15:02:39.000000000 +0900
+++ devel-2.6.19/mm/vmalloc.c	2006-12-09 13:44:35.000000000 +0900
@@ -764,15 +764,10 @@
 	int ret = 0;
 	unsigned long next;
 	if (!pmd_present(*pmd)) {
-		if (ops->k_pte_alloc) {
-			ret = ops->k_pte_alloc(pmd, addr, data);
-			if (ret)
-				return ret;
-		} else {
-			pte = pte_alloc_kernel(pmd, addr);
-			if (!pte)
-				return -ENOMEM;
-		}
+		BUG_ON(!ops->k_pte_alloc);
+		ret = ops->k_pte_alloc(pmd, addr, data);
+		if (ret)
+			return ret;
 	}
 	pte = pte_offset_kernel(pmd, addr);
 
@@ -796,15 +791,10 @@
 	int ret;
 
 	if (pud_none(*pud)) {
-		if (ops->k_pmd_alloc) {
-			ret = ops->k_pmd_alloc(pud, addr, data);
-			if (ret)
-				return ret;
-		} else {
-			pmd = pmd_alloc(&init_mm, pud, addr);
-			if (!pmd)
-				return -ENOMEM;
-		}
+		BUG_ON(!ops->k_pmd_alloc);
+		ret = ops->k_pmd_alloc(pud, addr, data);
+		if (ret)
+			return ret;
 	}
 	pmd = pmd_offset(pud, addr);
 	do {
@@ -824,15 +814,10 @@
 	unsigned long next;
 	int ret;
 	if (pgd_none(*pgd)) {
-		if (ops->k_pud_alloc) {
-			ret = ops->k_pud_alloc(pgd, addr, data);
-			if (ret)
-				return ret;
-		} else {
-			pud = pud_alloc(&init_mm, pgd, addr);
-			if (!pud)
-				return -ENOMEM;
-		}
+		BUG_ON(!ops->k_pud_alloc);
+		ret = ops->k_pud_alloc(pgd, addr, data);
+		if (ret)
+			return ret;
 	}
 	pud = pud_offset(pgd, addr);
 	do {

