Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265319AbUFBC0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUFBC0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 22:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbUFBC0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 22:26:13 -0400
Received: from ozlabs.org ([203.10.76.45]:15549 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265319AbUFBC0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 22:26:11 -0400
Date: Wed, 2 Jun 2004 12:23:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Hugepage bugfix
Message-ID: <20040602022312.GB2042@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, apw@shadowen.org, wli@holomorphy.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Currently the hugepage code stores the hugepage destructor in the
mapping field of the second of the compound pages.  However, this
field is never cleared again, which causes tracebacks from
free_pages_check() if the hugepage is later destroyed by reducing the
number in /proc/sys/vm/nr_hugepages.  This patch fixes the bug by
clearing the mapping field when the hugepage is freed.

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2004-05-20 12:59:04.000000000 +1000
+++ working-2.6/mm/hugetlb.c	2004-06-02 12:14:53.582693952 +1000
@@ -57,6 +57,7 @@
 	BUG_ON(page_count(page));
 
 	INIT_LIST_HEAD(&page->lru);
+	page[1].mapping = NULL;
 
 	spin_lock(&hugetlb_lock);
 	enqueue_huge_page(page);



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
