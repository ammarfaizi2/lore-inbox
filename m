Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVBIJ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVBIJ6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 04:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVBIJ60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 04:58:26 -0500
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:17863 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S261803AbVBIJ6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 04:58:16 -0500
Date: Wed, 9 Feb 2005 20:58:07 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: davem@davemloft.net, hugh@veritas.com, akpm@osdl.org,
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: [Patch] Fix oops in alloc_zeroed_user_highpage() when page is NULL
Message-Id: <20050209205807.221d4591.michael@ellerman.id.au>
In-Reply-To: <Pine.LNX.4.58.0501211206380.25925@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
	<20050108135636.6796419a.davem@davemloft.net>
	<Pine.LNX.4.58.0501211206380.25925@schroedinger.engr.sgi.com>
Organization: IBM LTC
X-Mailer: Sylpheed version 1.0.0-gtk2-20041224 (GTK+ 2.6.2; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The generic and IA-64 versions of alloc_zeroed_user_highpage() don't check the return value from alloc_page_vma(). This can lead to an oops if we're OOM.

This fixes my oops on PPC64, but I haven't got an IA-64 machine/compiler handy.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

diff -rN -p -u oombreakage-old/include/asm-ia64/page.h oombreakage-new/include/asm-ia64/page.h
--- oombreakage-old/include/asm-ia64/page.h	2005-02-04 04:10:37.000000000 +1100
+++ oombreakage-new/include/asm-ia64/page.h	2005-02-09 20:53:37.000000000 +1100
@@ -79,7 +79,8 @@ do {						\
 #define alloc_zeroed_user_highpage(vma, vaddr) \
 ({						\
 	struct page *page = alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr); \
-	flush_dcache_page(page);		\
+	if (page)				\
+ 		flush_dcache_page(page);	\
 	page;					\
 })
 
diff -rN -p -u oombreakage-old/include/linux/highmem.h oombreakage-new/include/linux/highmem.h
--- oombreakage-old/include/linux/highmem.h	2005-02-09 20:22:41.000000000 +1100
+++ oombreakage-new/include/linux/highmem.h	2005-02-09 20:47:01.000000000 +1100
@@ -48,7 +48,9 @@ alloc_zeroed_user_highpage(struct vm_are
 {
 	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
 
-	clear_user_highpage(page, vaddr);
+	if (page)
+		clear_user_highpage(page, vaddr);
+
 	return page;
 }
 #endif



