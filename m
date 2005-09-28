Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVI1UBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVI1UBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVI1UBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:01:37 -0400
Received: from gold.veritas.com ([143.127.12.110]:902 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750781AbVI1UBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:01:37 -0400
Date: Wed, 28 Sep 2005 21:01:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH mm] linear pte_file fix
Message-ID: <Pine.LNX.4.61.0509282057290.20548@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Sep 2005 20:01:36.0489 (UTC) FILETIME=[6E862D90:01C5C467]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My recent mm patch to give pte_ERROR in do_file_page unless VM_NONLINEAR
was incorrect.  I was forgetting Oleg's patch to the populate functions,
which forces install_file_pte when MAP_POPULATE + MAP_NONBLOCK but page
not in cache (in case an existing nonlinear entry needs removing).  But
that's only necessary in the VM_NONLINEAR case: let's keep the strict
check in do_file_page, and adjust filemap_populate and shmem_populate.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.14-rc2-mm1/mm/filemap.c	2005-09-22 12:32:03.000000000 +0100
+++ linux/mm/filemap.c	2005-09-28 20:38:20.000000000 +0100
@@ -1542,7 +1542,7 @@ repeat:
 			page_cache_release(page);
 			return err;
 		}
-	} else {
+	} else if (vma->vm_flags & VM_NONLINEAR) {
 		/* No page was found just because we can't read it in now (being
 		 * here implies nonblock != 0), but the page may exist, so set
 		 * the PTE to fault it in later. */
--- 2.6.14-rc2-mm1/mm/shmem.c	2005-09-22 12:32:04.000000000 +0100
+++ linux/mm/shmem.c	2005-09-28 20:40:23.000000000 +0100
@@ -1201,7 +1201,7 @@ static int shmem_populate(struct vm_area
 				page_cache_release(page);
 				return err;
 			}
-		} else {
+		} else if (vma->vm_flags & VM_NONLINEAR) {
 			/* No page was found just because we can't read it in
 			 * now (being here implies nonblock != 0), but the page
 			 * may exist, so set the PTE to fault it in later. */
