Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUI0Xnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUI0Xnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUI0Xnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:43:49 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:45482 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267464AbUI0Xnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:43:46 -0400
Date: Tue, 28 Sep 2004 01:45:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix CONFIG_DEBUG_HIGHMEM assert in copy_page_range()
Message-ID: <20040927234523.GA2889@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


copy_page_range() triggers a CONFIG_DEBUG_HIGHMEM assert, because if a
preemption occurs right at a PMD_SIZE boundary the kmap/kunmap doesnt
match. This isnt a real problem because atomic_kunmap doesnt do anything
if CONFIG_DEBUG_HIGHMEM is not set and the atomic_map's are still
correct, but it's ugly nevertheless.

tested patch is against 2.6.9-rc2-mm4.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/mm/memory.c.orig	
+++ linux/mm/memory.c	
@@ -337,14 +337,6 @@ skip_copy_pte_range:
 				set_pte(dst_pte, pte);
 				page_dup_rmap(page);
 cont_copy_pte_range_noset:
-				address += PAGE_SIZE;
-				if (address >= end) {
-					pte_unmap_nested(src_pte);
-					pte_unmap(dst_pte);
-					goto out_unlock;
-				}
-				src_pte++;
-				dst_pte++;
 				/*
 				 * We are holding two locks at this point -
 				 * any of them could generate latencies in
@@ -364,6 +356,14 @@ cont_copy_pte_range_noset:
 					dst_pte = pte_offset_map(dst_pmd, address);
 					src_pte = pte_offset_map_nested(src_pmd, address);
 				}
+				address += PAGE_SIZE;
+				if (address >= end) {
+					pte_unmap_nested(src_pte);
+					pte_unmap(dst_pte);
+					goto out_unlock;
+				}
+				src_pte++;
+				dst_pte++;
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
 			pte_unmap_nested(src_pte-1);
 			pte_unmap(dst_pte-1);
