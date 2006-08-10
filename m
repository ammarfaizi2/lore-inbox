Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161369AbWHJQEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161369AbWHJQEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161372AbWHJQEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:04:12 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:59121 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161370AbWHJQEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:04:11 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 2/14] Generic ioremap_page_range: flush_cache_vmap
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:34 +0200
Message-Id: <11552258271630-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1155225827754-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <1155225827754-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The existing implementation of ioremap_page_range(), which was taken
from i386, does this:

	flush_cache_all();
	/* modify page tables */
	flush_tlb_all();

I think this is a bit defensive, so this patch changes the generic
implementation to do:

	/* modify page tables */
	flush_cache_vmap(start, end);

instead, which is similar to what vmalloc() does. This should still
be correct because we never modify existing PTEs. According to
James Bottomley:

The problem the flush_tlb_all() is trying to solve is to avoid stale tlb
entries in the ioremap area.  We're just being conservative by flushing
on both map and unmap.  Technically what vmalloc/vfree does (only flush
the tlb on unmap) is just fine because it means that the only tlb
entries in the remap area must belong to in-use mappings.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 lib/ioremap.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index 6419101..d2cb1eb 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -75,8 +75,6 @@ int ioremap_page_range(unsigned long add
 
 	BUG_ON(addr >= end);
 
-	flush_cache_all();
-
 	start = addr;
 	phys_addr -= addr;
 	pgd = pgd_offset_k(addr);
@@ -87,7 +85,7 @@ int ioremap_page_range(unsigned long add
 			break;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_all();
+	flush_cache_vmap(start, end);
 
 	return err;
 }
-- 
1.4.0

