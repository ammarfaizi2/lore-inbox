Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVIFLAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVIFLAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVIFLAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:00:04 -0400
Received: from ozlabs.org ([203.10.76.45]:11927 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964789AbVIFLAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:00:03 -0400
To: Paul Mackerras <paulus@samba.org>
CC: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>, Linus Torvalds <torvalds@osdl.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] ppc64: Fix oops for !CONFIG_NUMA
Message-Id: <20050906110002.B586C68110@ozlabs.org>
Date: Tue,  6 Sep 2005 21:00:02 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SPARSEMEM EXTREME code (802f192e4a600f7ef84ca25c8b818c8830acef5a) that
went in yesterday broke PPC64 for !CONFIG_NUMA.

The problem is that (free|reserve)_bootmem don't take a page number as their
first argument, they take an address. Ruh roh.

Booted on P5 LPAR, iSeries and G5.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/ppc64/mm/init.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: work/arch/ppc64/mm/init.c
===================================================================
--- work.orig/arch/ppc64/mm/init.c
+++ work/arch/ppc64/mm/init.c
@@ -553,12 +553,12 @@ void __init do_init_bootmem(void)
 	 * present.
 	 */
 	for (i=0; i < lmb.memory.cnt; i++)
-		free_bootmem(lmb_start_pfn(&lmb.memory, i),
+		free_bootmem(lmb.memory.region[i].base,
 			     lmb_size_bytes(&lmb.memory, i));
 
 	/* reserve the sections we're already using */
 	for (i=0; i < lmb.reserved.cnt; i++)
-		reserve_bootmem(lmb_start_pfn(&lmb.reserved, i),
+		reserve_bootmem(lmb.reserved.region[i].base,
 				lmb_size_bytes(&lmb.reserved, i));
 
 	for (i=0; i < lmb.memory.cnt; i++)
