Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWB0Wmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWB0Wmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWB0WmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:42:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52867 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932348AbWB0WbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:25 -0500
Message-Id: <20060227223325.282784000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:06 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Hugh Dickins <hugh@veritas.com>, Don Dupuis <dondster@gmail.com>,
       William Irwin <wli@holomorphy.com>, Adam Litke <agl@us.ibm.com>,
       William Irwin <wli@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/39] [PATCH] hugetlbfs mmap ENOMEM failure
Content-Disposition: inline; filename=hugetlbfs-mmap-enomem-failure.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

2.6.15's hugepage faulting introduced huge_pages_needed accounting into
hugetlbfs: to count how many pages are already in cache, for spot check
on how far a new mapping may be allowed to extend the file.  But it's
muddled: each hugepage found covers HPAGE_SIZE, not PAGE_SIZE.  Once
pages were already in cache, it would overshoot, wrap its hugepages
count backwards, and so fail a harmless repeat mapping with -ENOMEM.
Fixes the problem found by Don Dupuis.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-By: Adam Litke <agl@us.ibm.com>
Acked-by: William Irwin <wli@us.ibm.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/hugetlbfs/inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15.4.orig/fs/hugetlbfs/inode.c
+++ linux-2.6.15.4/fs/hugetlbfs/inode.c
@@ -71,8 +71,8 @@ huge_pages_needed(struct address_space *
 	unsigned long start = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long hugepages = (end - start) >> HPAGE_SHIFT;
-	pgoff_t next = vma->vm_pgoff;
-	pgoff_t endpg = next + ((end - start) >> PAGE_SHIFT);
+	pgoff_t next = vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
+	pgoff_t endpg = next + hugepages;
 
 	pagevec_init(&pvec, 0);
 	while (next < endpg) {

--
