Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVAJEWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVAJEWp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 23:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVAJEWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 23:22:41 -0500
Received: from ozlabs.org ([203.10.76.45]:4747 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262067AbVAJEWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 23:22:35 -0500
Date: Tue, 11 Jan 2005 02:55:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Hugepage bugfix
Message-ID: <20050110155520.GA22101@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus, please apply:

Fix a stupid unbalanced lock bug in the ppc64 hugepage code.  Lead
rapidly to a crash if both CONFIG_HUGETLB_PAGE and CONFIG_PREEMPT were
enabled (even without actually using hugepages at all).

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2005-01-06 10:47:48.000000000 +1100
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2005-01-10 15:16:25.142319552 +1100
@@ -745,7 +745,7 @@
 
 	pgdir = mm->context.huge_pgdir;
 	if (! pgdir)
-		return;
+		goto out;
 
 	mm->context.huge_pgdir = NULL;
 
@@ -768,6 +768,7 @@
 	BUG_ON(memcmp(pgdir, empty_zero_page, PAGE_SIZE));
 	kmem_cache_free(zero_cache, pgdir);
 
+ out:
 	spin_unlock(&mm->page_table_lock);
 }
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
