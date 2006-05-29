Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWE2V0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWE2V0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWE2V0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:45 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53217 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751357AbWE2V0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:24 -0400
Date: Mon, 29 May 2006 23:26:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 45/61] lock validator: special locking: mm
Message-ID: <20060529212643.GS3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 mm/memory.c |    2 +-
 mm/mremap.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c
+++ linux/mm/memory.c
@@ -509,7 +509,7 @@ again:
 		return -ENOMEM;
 	src_pte = pte_offset_map_nested(src_pmd, addr);
 	src_ptl = pte_lockptr(src_mm, src_pmd);
-	spin_lock(src_ptl);
+	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
 	do {
 		/*
Index: linux/mm/mremap.c
===================================================================
--- linux.orig/mm/mremap.c
+++ linux/mm/mremap.c
@@ -97,7 +97,7 @@ static void move_ptes(struct vm_area_str
  	new_pte = pte_offset_map_nested(new_pmd, new_addr);
 	new_ptl = pte_lockptr(mm, new_pmd);
 	if (new_ptl != old_ptl)
-		spin_lock(new_ptl);
+		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
