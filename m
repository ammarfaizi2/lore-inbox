Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271059AbTGPTei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271062AbTGPTei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:34:38 -0400
Received: from dp.samba.org ([66.70.73.150]:52922 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271059AbTGPTeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:34:37 -0400
Date: Thu, 17 Jul 2003 05:46:46 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix bootmem allocator on machines with holes in memory
Message-ID: <20030716194646.GA793@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

If the memory we are trying to allocate is too large to fit in the
current region, we should skip to the end. We currently search the
available bitmap, find the area is too small, increment the start by
incr and try again. This resulted in an apparent lockup on a 64GB
machine that had a 3GB IO hole starting at 1GB (and the mem_map array
would not fit in the first region).

Also use ALIGN macro instead of an open coded version.

Anton

===== mm/bootmem.c 1.18 vs edited =====
--- 1.18/mm/bootmem.c	Sat Jul  5 16:52:55 2003
+++ edited/mm/bootmem.c	Thu Jul 17 05:00:42 2003
@@ -183,7 +183,7 @@
 	for (i = preferred; i < eidx; i += incr) {
 		unsigned long j;
 		i = find_next_zero_bit(bdata->node_bootmem_map, eidx, i);
-		i = (i + incr - 1) & -incr;
+		i = ALIGN(i, incr);
 		if (test_bit(i, bdata->node_bootmem_map))
 			continue;
 		for (j = i + 1; j < i + areasize; ++j) {
@@ -195,7 +195,7 @@
 		start = i;
 		goto found;
 	fail_block:
-		;
+		i = ALIGN(j, incr);
 	}
 
 	if (preferred > offset) {
