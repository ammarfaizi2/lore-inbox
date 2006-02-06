Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWBFCT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWBFCT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 21:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWBFCT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 21:19:29 -0500
Received: from ozlabs.org ([203.10.76.45]:36019 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750774AbWBFCT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 21:19:29 -0500
Date: Mon, 6 Feb 2006 13:18:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: William Lee Irwin <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Hugepages need clear_user_highpage() not clear_highpage()
Message-ID: <20060206021853.GC10708@localhost.localdomain>
Mail-Followup-To: William Lee Irwin <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When hugepages are newly allocated to a file in mm/hugetlb.c, we clear
them with a call to clear_highpage() on each of the subpages.  We
should be using clear_user_highpage(): on powerpc, at least,
clear_highpage() doesn't correctly mark the page as icache dirty so if
the page is executed shortly after it's possible to get strange
results.

This is a bugfix and should go into 2.6.16.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2006-02-06 12:58:07.000000000 +1100
+++ working-2.6/mm/hugetlb.c	2006-02-06 12:58:19.000000000 +1100
@@ -107,7 +107,7 @@ struct page *alloc_huge_page(struct vm_a
 	set_page_count(page, 1);
 	page[1].mapping = (void *)free_huge_page;
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
-		clear_highpage(&page[i]);
+		clear_user_highpage(&page[i], addr);
 	return page;
 }
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
