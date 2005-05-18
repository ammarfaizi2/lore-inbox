Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVERT7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVERT7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVERT6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:58:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262335AbVERT5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:57:37 -0400
Date: Wed, 18 May 2005 15:57:35 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: [PATCH] prevent NULL mmap in topdown model
Message-ID: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This (trivial) patch prevents the topdown allocator from allocating
mmap areas all the way down to address zero.  It's not the prettiest
patch, so suggestions for improvement are welcome ;)

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.11/mm/mmap.c.nullptr	2005-05-17 23:07:26.000000000 -0400
+++ linux-2.6.11/mm/mmap.c	2005-05-17 23:18:53.000000000 -0400
@@ -1251,7 +1251,7 @@
 	addr = mm->free_area_cache;
 
 	/* make sure it can fit in the remaining address space */
-	if (addr >= len) {
+	if (addr >= (len + mm->brk)) {
 		vma = find_vma(mm, addr-len);
 		if (!vma || addr <= vma->vm_start)
 			/* remember the address as a hint for next time */
@@ -1267,13 +1267,13 @@
 		 * return with success:
 		 */
 		vma = find_vma(mm, addr);
-		if (!vma || addr+len <= vma->vm_start)
+		if ((!vma || addr+len <= vma->vm_start) && addr > mm->brk)
 			/* remember the address as a hint for next time */
 			return (mm->free_area_cache = addr);
 
 		/* try just below the current vma->vm_start */
 		addr = vma->vm_start-len;
-	} while (len <= vma->vm_start);
+	} while (len <= vma->vm_start && addr > mm->brk);
 
 	/*
 	 * A failed mmap() very likely causes application failure,
