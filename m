Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTEMVq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTEMVq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:46:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:38877 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262406AbTEMVqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:46:20 -0400
Date: Tue, 13 May 2003 13:58:07 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com
Cc: mjbligh@us.ibm.com
Subject: [RFC][PATCH] Fix for latent bug in vmtruncate()
Message-ID: <20030513135807.E2929@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vmtruncate() function shifts down by PAGE_CACHE_SHIFT, then
calls vmtruncate_list(), which deals in terms of PAGE_SHIFT
instead.  Currently, no harm done, since PAGE_CACHE_SHIFT and
PAGE_SHIFT are identical.  Some day they might not be, hence
this patch.

I also took the liberty of modifying a hand-coded "if" that
seems to optimize for files that are not mapped to instead
use unlikely().

Thoughts?

					Thanx, Paul

diff -urN -X dontdiff linux-2.5.69/mm/memory.c linux-2.5.69.vmtruncate/mm/memory.c
--- linux-2.5.69/mm/memory.c	Sun May  4 16:53:14 2003
+++ linux-2.5.69.vmtruncate/mm/memory.c	Fri May  9 17:29:02 2003
@@ -1108,17 +1108,12 @@
 	if (inode->i_size < offset)
 		goto do_expand;
 	inode->i_size = offset;
+	pgoff = (offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	down(&mapping->i_shared_sem);
-	if (list_empty(&mapping->i_mmap) && list_empty(&mapping->i_mmap_shared))
-		goto out_unlock;
-
-	pgoff = (offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (!list_empty(&mapping->i_mmap))
+	if (unlikely(!list_empty(&mapping->i_mmap)))
 		vmtruncate_list(&mapping->i_mmap, pgoff);
-	if (!list_empty(&mapping->i_mmap_shared))
+	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
 		vmtruncate_list(&mapping->i_mmap_shared, pgoff);
-
-out_unlock:
 	up(&mapping->i_shared_sem);
 	truncate_inode_pages(mapping, offset);
 	goto out_truncate;
