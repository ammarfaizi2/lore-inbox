Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVEWVHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVEWVHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVEWVHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:07:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:13246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261958AbVEWVGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:06:42 -0400
Date: Mon, 23 May 2005 14:06:29 -0700
From: Chris Wright <chrisw@osdl.org>
To: mingo@elte.hu, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mmap topdown fix for large stack limit, large allocation
Message-ID: <20050523210629.GH27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The topdown changes in 2.6.12-rc1 can cause large allocations with
large stack limit to fail, despite there being space available.  The
mmap_base-len is only valid when len >= mmap_base.  However, nothing in
topdown allocator checks this.  It's only (now) caught at higher level,
which will cause allocation to simply fail.  The following change restores
the fallback to bottom-up path, which will allow large allocations with
large stack limit to potentially still succeed.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 mm/mmap.c |    4 ++++
 1 files changed, 4 insertions(+)

mm/mmap.c: de54acd9942f9929004921042721df5cdfe2b6c7
--- k/mm/mmap.c
+++ l/mm/mmap.c
@@ -1251,6 +1251,9 @@ arch_get_unmapped_area_topdown(struct fi
 			return (mm->free_area_cache = addr-len);
 	}
 
+	if (mm->mmap_base < len)
+		goto bottomup;
+
 	addr = mm->mmap_base-len;
 
 	do {
@@ -1268,6 +1271,7 @@ arch_get_unmapped_area_topdown(struct fi
 		addr = vma->vm_start-len;
 	} while (len < vma->vm_start);
 
+bottomup:
 	/*
 	 * A failed mmap() very likely causes application failure,
 	 * so fall back to the bottom-up function here. This scenario
