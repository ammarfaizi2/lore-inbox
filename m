Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269487AbTCDSVt>; Tue, 4 Mar 2003 13:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269488AbTCDSVt>; Tue, 4 Mar 2003 13:21:49 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:62325 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S269487AbTCDSVq>; Tue, 4 Mar 2003 13:21:46 -0500
Date: Tue, 04 Mar 2003 12:32:11 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2.5.63] Make objrmap mapcount non-atomic
Message-ID: <30210000.1046802731@baldur.austin.ibm.com>
In-Reply-To: <20030303141518.12d9ccd8.akpm@digeo.com>
References: <20030227025900.1205425a.akpm@digeo.com>
 <200302280822.09409.kernel@kolivas.org>
 <20030227134403.776bf2e3.akpm@digeo.com>
 <118810000.1046383273@baldur.austin.ibm.com>
 <20030227142450.1c6a6b72.akpm@digeo.com>
 <103400000.1046725581@baldur.austin.ibm.com>
 <20030303131210.36645af6.akpm@digeo.com>
 <107610000.1046726685@baldur.austin.ibm.com>
 <20030303133539.6594e0b6.akpm@digeo.com>
 <117290000.1046728362@baldur.austin.ibm.com>
 <20030303141518.12d9ccd8.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1834499384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1834499384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--On Monday, March 03, 2003 14:15:18 -0800 Andrew Morton <akpm@digeo.com>
wrote:

> Well why not make mapcount an "int" and move the places where it is
> modified inside pte_chain_lock()?
> 
> That does not increase the number of atomic operations, and it makes me
> stop wondering if this:
> 
>                 if (atomic_read(&page->pte.mapcount) == 0)
>                         inc_page_state(nr_mapped);
> 
> is racy ;)

That would be entirely too easy a solution :)

You're entirely right, of course.  Here's the patch that makes it an int
instead of atomic, with the appropriate locking.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1834499384==========
Content-Type: text/plain; charset=us-ascii; name="objfix-2.5.63-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="objfix-2.5.63-2.diff"; size=2270

--- 2.5.63-objrmap/./include/linux/mm.h	2003-02-27 15:58:34.000000000 -0600
+++ 2.5.63-objfix/./include/linux/mm.h	2003-03-03 16:26:21.000000000 -0600
@@ -172,7 +172,7 @@
 		struct pte_chain *chain;/* Reverse pte mapping pointer.
 					 * protected by PG_chainlock */
 		pte_addr_t direct;
-		atomic_t mapcount;
+		int mapcount;
 	} pte;
 	unsigned long private;		/* mapping-private opaque data */
 
--- 2.5.63-objrmap/./mm/rmap.c	2003-02-28 14:19:10.000000000 -0600
+++ 2.5.63-objfix/./mm/rmap.c	2003-03-03 20:08:43.000000000 -0600
@@ -144,7 +144,7 @@
 	struct vm_area_struct *vma;
 	int referenced = 0;
 
-	if (atomic_read(&page->pte.mapcount) == 0)
+	if (!page->pte.mapcount)
 		return 0;
 
 	if (!mapping)
@@ -243,19 +243,20 @@
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return pte_chain;
 
+	pte_chain_lock(page);
+
 	if (!PageAnon(page)) {
 		if (!page->mapping)
 			BUG();
 		if (PageSwapCache(page))
 			BUG();
-		if (atomic_read(&page->pte.mapcount) == 0)
+		if (!page->pte.mapcount)
 			inc_page_state(nr_mapped);
-		atomic_inc(&page->pte.mapcount);
+		page->pte.mapcount++;
+		pte_chain_unlock(page);
 		return pte_chain;
 	}
 
-	pte_chain_lock(page);
-
 #ifdef DEBUG_RMAP
 	/*
 	 * This stuff needs help to get up to highmem speed.
@@ -342,20 +343,22 @@
 	if (!page_mapped(page))
 		return;		/* remap_page_range() from a driver? */
 
+	pte_chain_lock(page);
+
 	if (!PageAnon(page)) {
 		if (!page->mapping)
 			BUG();
 		if (PageSwapCache(page))
 			BUG();
-		if (atomic_read(&page->pte.mapcount) == 0)
+		if (!page->pte.mapcount)
 			BUG();
-		if (atomic_dec_and_test(&page->pte.mapcount))
+		page->pte.mapcount--;
+		if (!page->pte.mapcount)
 			dec_page_state(nr_mapped);
+		pte_chain_unlock(page);
 		return;
 	}
 
-	pte_chain_lock(page);
-
 	if (PageDirect(page)) {
 		if (page->pte.direct == pte_paddr) {
 			page->pte.direct = 0;
@@ -471,11 +474,11 @@
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
-	if (atomic_read(&page->pte.mapcount) == 0)
+	if (!page->pte.mapcount)
 		BUG();
 
 	mm->rss--;
-	atomic_dec(&page->pte.mapcount);
+	page->pte.mapcount--;
 	page_cache_release(page);
 
 out_unmap:
@@ -516,7 +519,7 @@
 			goto out;
 	}
 
-	if (atomic_read(&page->pte.mapcount) != 0)
+	if (page->pte.mapcount)
 		BUG();
 
 out:

--==========1834499384==========--

