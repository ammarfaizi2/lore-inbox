Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUGIOI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUGIOI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUGIOI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:08:29 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:49167 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id S264717AbUGIOIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:08:21 -0400
Message-ID: <40EEA7B2.92FC5F46@tv-sign.ru>
Date: Fri, 09 Jul 2004 18:12:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: [BUG][PATCH] hugetlbfs vm_pgoff bugs.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. hugetlbfs_file_mmap() must check that vm_pgoff is hugepage aligned.

2. hugetlb_vmtruncate_list() confuses << with >> while converting
vm_pgoff to huge page offset, and zaps wrong area.

Patch against mm7.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.7-mm7/fs/hugetlbfs/inode.c.orig	2004-07-09 16:41:15.000000000 +0400
+++ 2.6.7-mm7/fs/hugetlbfs/inode.c	2004-07-09 16:56:02.000000000 +0400
@@ -52,6 +52,9 @@ static int hugetlbfs_file_mmap(struct fi
 	loff_t len, vma_len;
 	int ret;
 
+	if (vma->vm_pgoff & (HPAGE_SIZE / PAGE_SIZE - 1))
+		return -EINVAL;
+
 	if (vma->vm_start & ~HPAGE_MASK)
 		return -EINVAL;
 
@@ -280,16 +283,16 @@ hugetlb_vmtruncate_list(struct prio_tree
 		unsigned long v_length;
 		unsigned long v_offset;
 
-		h_vm_pgoff = vma->vm_pgoff << (HPAGE_SHIFT - PAGE_SHIFT);
-		v_length = vma->vm_end - vma->vm_start;
+		h_vm_pgoff = vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
 		v_offset = (h_pgoff - h_vm_pgoff) << HPAGE_SHIFT;
-
 		/*
 		 * Is this VMA fully outside the truncation point?
 		 */
 		if (h_vm_pgoff >= h_pgoff)
 			v_offset = 0;
 
+		v_length = vma->vm_end - vma->vm_start;
+
 		zap_hugepage_range(vma,
 				vma->vm_start + v_offset,
 				v_length - v_offset);
