Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268948AbUHMCfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268948AbUHMCfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 22:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268951AbUHMCfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 22:35:20 -0400
Received: from holomorphy.com ([207.189.100.168]:14224 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268948AbUHMCfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 22:35:13 -0400
Date: Thu, 12 Aug 2004 19:35:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: use linear_page_index() in mm/mempolicy.c
Message-ID: <20040813023512.GV11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm/mempolicy.c is computing linear_page_index() by hand. This teaches
alloc_page_vma() to use the pagemap.h helper function for it. This is
particularly helpful for when how linear_page_index() is computed changes.


Index: spinlock-2.6.8-rc4/mm/mempolicy.c
===================================================================
--- spinlock-2.6.8-rc4.orig/mm/mempolicy.c	2004-08-10 23:00:25.101832328 -0700
+++ spinlock-2.6.8-rc4/mm/mempolicy.c	2004-08-12 19:20:41.784408232 -0700
@@ -668,11 +668,9 @@
 	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
 		unsigned nid;
 		if (vma) {
-			unsigned long off;
+			unsigned long off = linear_page_index(vma, addr);
 			BUG_ON(addr >= vma->vm_end);
 			BUG_ON(addr < vma->vm_start);
-			off = vma->vm_pgoff;
-			off += (addr - vma->vm_start) >> PAGE_SHIFT;
 			nid = offset_il_node(pol, vma, off);
 		} else {
 			/* fall back to process interleaving */
