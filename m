Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269266AbUINLcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbUINLcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUINL3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:29:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22252 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269297AbUINLTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:19:08 -0400
Date: Tue, 14 Sep 2004 12:50:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched, mm: fix scheduling latencies in copy_page_range()
Message-ID: <20040914105048.GA31238@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20040914104449.GA30790@elte.hu>
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


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch does a lock-break in copy_page_range() if needed, to
reduce scheduling latencies.

has been tested as part of the -VP patchset.

	Ingo

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-copy_page_range.patch"


The attached patch does a lock-break in copy_page_range() if needed, to
reduce scheduling latencies.

has been tested as part of the -VP patchset.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/mm/memory.c.orig	
+++ linux/mm/memory.c	
@@ -337,6 +337,25 @@ cont_copy_pte_range_noset:
 				}
 				src_pte++;
 				dst_pte++;
+				/*
+				 * We are holding two locks at this point -
+				 * any of them could generate latencies in
+				 * another task on another CPU:
+				 */
+				if (need_resched() ||
+					need_lockbreak(&src->page_table_lock) ||
+					need_lockbreak(&dst->page_table_lock))
+				{
+					pte_unmap_nested(src_pte);
+					pte_unmap(dst_pte);
+					spin_unlock(&src->page_table_lock);
+					spin_unlock(&dst->page_table_lock);
+					cond_resched();
+					spin_lock(&dst->page_table_lock);
+					spin_lock(&src->page_table_lock);
+					dst_pte = pte_offset_map(dst_pmd, address);
+					src_pte = pte_offset_map_nested(src_pmd, address);
+				}
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
 			pte_unmap_nested(src_pte-1);
 			pte_unmap(dst_pte-1);

--SLDf9lqlvOQaIe6s--
