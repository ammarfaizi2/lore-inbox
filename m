Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263661AbUERWM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUERWM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUERWM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:12:26 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13047 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263661AbUERWKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:10:25 -0400
Date: Tue, 18 May 2004 23:06:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 34 vm_flags page_table_lock
Message-ID: <Pine.LNX.4.44.0405182304150.3416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of a batch of seven rmap patches, based on 2.6.6-mm3.  Probably
the final batch: remaining issues outstanding can have isolated patches.
The first half of the batch is good for anonmm or anon_vma, the second
half of the batch replaces my anonmm rmap by Andrea's anon_vma rmap.

Judge for yourselves which you prefer.  I do think I was wrong to call
anon_vma more complex than anonmm (its lists are easier to understand
than my refcounting), and I'm happy with its vma merging after the last
patch.  It just comes down to whether we can spare the extra 24 bytes
(maximum, on 32-bit) per vma for its advantages in swapout and mremap.

rmap 34 vm_flags page_table_lock

Why do we guard vm_flags mods with page_table_lock when it's already
down_write guarded by mmap_sem?  There's probably a historical reason,
but no sign of any need for it now.  Andrea added a comment and removed
the instance from mprotect.c, Hugh plagiarized his comment and removed
the instances from madvise.c and mlock.c.  Huge leap in scalability...
not expected; but this should stop people asking why those spinlocks.

 mm/madvise.c  |    5 +++--
 mm/mlock.c    |    9 ++++++---
 mm/mprotect.c |    6 ++++--
 3 files changed, 13 insertions(+), 7 deletions(-)

--- rmap33/mm/madvise.c	2004-05-16 11:39:26.000000000 +0100
+++ rmap34/mm/madvise.c	2004-05-18 20:50:32.613664464 +0100
@@ -31,7 +31,9 @@ static long madvise_behavior(struct vm_a
 			return -EAGAIN;
 	}
 
-	spin_lock(&mm->page_table_lock);
+	/*
+	 * vm_flags is protected by the mmap_sem held in write mode.
+	 */
 	VM_ClearReadHint(vma);
 
 	switch (behavior) {
@@ -44,7 +46,6 @@ static long madvise_behavior(struct vm_a
 	default:
 		break;
 	}
-	spin_unlock(&mm->page_table_lock);
 
 	return 0;
 }
--- rmap33/mm/mlock.c	2004-05-16 11:39:25.000000000 +0100
+++ rmap34/mm/mlock.c	2004-05-18 20:50:32.613664464 +0100
@@ -32,10 +32,13 @@ static int mlock_fixup(struct vm_area_st
 			goto out;
 		}
 	}
-	
-	spin_lock(&mm->page_table_lock);
+
+	/*
+	 * vm_flags is protected by the mmap_sem held in write mode.
+	 * It's okay if try_to_unmap_one unmaps a page just after we
+	 * set VM_LOCKED, make_pages_present below will bring it back.
+	 */
 	vma->vm_flags = newflags;
-	spin_unlock(&mm->page_table_lock);
 
 	/*
 	 * Keep track of amount of locked VM.
--- rmap33/mm/mprotect.c	2004-05-16 11:39:24.000000000 +0100
+++ rmap34/mm/mprotect.c	2004-05-18 20:50:32.614664312 +0100
@@ -212,10 +212,12 @@ mprotect_fixup(struct vm_area_struct *vm
 			goto fail;
 	}
 
-	spin_lock(&mm->page_table_lock);
+	/*
+	 * vm_flags and vm_page_prot are protected by the mmap_sem
+	 * held in write mode.
+	 */
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
-	spin_unlock(&mm->page_table_lock);
 success:
 	change_protection(vma, start, end, newprot);
 	return 0;

