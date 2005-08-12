Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVHLSBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVHLSBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVHLSAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:00:24 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:35218 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1750804AbVHLRym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:42 -0400
Subject: [patch 16/39] remap_file_pages protection support: readd lock downgrading
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:32:12 +0200
Message-Id: <20050812173212.D241824E7E6@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Even now, we'll sometimes take the write lock.  So, in that case, we could
downgrade it; after a tiny bit of thought, I've choosen doing that when we'll
either do any I/O or we'll alter a lot of PTEs. About how much "a lot" is,
I've copied the values from this code in mm/memory.c:

#ifdef CONFIG_PREEMPT
# define ZAP_BLOCK_SIZE	(8 * PAGE_SIZE)
#else
/* No preempt: go for improved straight-line efficiency */
# define ZAP_BLOCK_SIZE	(1024 * PAGE_SIZE)
#endif

I'm not sure about the trade-offs - we used to have a down_write, now we have
a down_read() and a possible up_read()down_write(), and with this patch, the
fast-path still takes only down_read, but the slow path will do down_read(),
down_write(), downgrade_write(). This will increase the number of atomic
operation but increase concurrency wrt mmap and similar operations - I don't
know how much contention there is on that lock.

Also, drop a bust comment: we cannot clear VM_NONLINEAR simply because code
elsewhere is going to use it. At the very least, madvise_dontneed() relies on
that flag being set (remaining non-linear truncation read the mapping
list), but the list is probably longer and going to increase in the next
patches of this series.

Just in case this wasn't clear: this patch is not strictly related to
protection support, I was just too lazy to move it up in the hierarchy.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff -puN mm/fremap.c~rfp-downgrade-lock mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-downgrade-lock	2005-08-11 23:04:39.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 23:04:39.000000000 +0200
@@ -152,6 +152,13 @@ err_unlock:
 }
 
 
+#ifdef CONFIG_PREEMPT
+# define INSTALL_SIZE	(8 * PAGE_SIZE)
+#else
+/* No preempt: go for improved straight-line efficiency */
+# define INSTALL_SIZE	(1024 * PAGE_SIZE)
+#endif
+
 /***
  * sys_remap_file_pages - remap arbitrary pages of a shared backing store
  *                        file within an existing vma.
@@ -266,14 +273,15 @@ retry:
 			}
 		}
 
+		/* Do NOT hold the write lock while doing any I/O, nor when
+		 * iterating over too many PTEs. Values might need tuning. */
+		if (has_write_lock && (!(flags & MAP_NONBLOCK) || size > INSTALL_SIZE)) {
+			downgrade_write(&mm->mmap_sem);
+			has_write_lock = 0;
+		}
 		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
 				flags & MAP_NONBLOCK);
 
-		/*
-		 * We can't clear VM_NONLINEAR because we'd have to do
-		 * it after ->populate completes, and that would prevent
-		 * downgrading the lock.  (Locks can't be upgraded).
-		 */
 	}
 
 out_unlock:
_
