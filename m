Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266045AbUBCRTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 12:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266093AbUBCRTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 12:19:24 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:39599 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266045AbUBCRTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 12:19:20 -0500
Date: Tue, 3 Feb 2004 17:19:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: j-nomura@ce.jp.nec.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040203.165359.149824126.nomura@linux.bs1.fc.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0402031638350.19713-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004 j-nomura@ce.jp.nec.com wrote:
> 
> The main cause of the heavy load seems hard contention on page_table_lock.
> The CPUs are virtually seriarized for swap_out_mm with each unfruitful
> scannings.

Ah yes, now I remember observing the same, back in 2.4.13 days.
I haven't given it much thought between then and now.

> The contention could be avoided by changing the spinlock to trylock.
> How about the patch below?

It looks plausible and fooled me at first.  But since you return from
swap_out_mm without adjusting swap_address or *mmcounter, I think
you'll find that tasks encountering that contention just spin around
the swap_out loop, retrying the same mm, decrementing counter until
it's zero.  May save CPU, but won't do the freeing expected of it.
Or am I reading your patch wrongly?

> I'm not sure in this case whether the test for nr_swap_pages is necessary.

Unnecessary, nr_swap_pages is irrelevant, better spin_trylock in all cases.

Let me dig out my patch for 2.4.13, it appears to apply much the
same to 2.4.24 or 2.4.25-pre8, though untested recently.  I think I
got involved in something else, and never pushed it out back then.
Do you find it helpful?

It's a little more complicated than yours because although it's good
to let the tasks encountering page_table_lock contention go on to
try another mm, it would not be good to update swap_mm too readily:
the contentious mm is likely to be the one which most needs freeing.

Think carefully about swap_address here: I seem to recall that
it is racy, but benign - won't go wrong often enough to matter.

Hugh

--- 2.4.25-pre8/mm/vmscan.c	2004-01-30 13:41:14.000000000 +0000
+++ linux/mm/vmscan.c	2004-02-03 16:33:43.212770936 +0000
@@ -292,12 +292,11 @@
 	 * Find the proper vm-area after freezing the vma chain 
 	 * and ptes.
 	 */
-	spin_lock(&mm->page_table_lock);
 	address = mm->swap_address;
 	if (address == TASK_SIZE || swap_mm != mm) {
 		/* We raced: don't count this mm but try again */
 		++*mmcounter;
-		goto out_unlock;
+		goto out;
 	}
 	vma = find_vma(mm, address);
 	if (vma) {
@@ -310,15 +309,14 @@
 			if (!vma)
 				break;
 			if (!count)
-				goto out_unlock;
+				goto out;
 			address = vma->vm_start;
 		}
 	}
 	/* Indicate that we reached the end of address space */
 	mm->swap_address = TASK_SIZE;
 
-out_unlock:
-	spin_unlock(&mm->page_table_lock);
+out:
 	return count;
 }
 
@@ -344,13 +342,18 @@
 				goto empty;
 			swap_mm = mm;
 		}
+		while (!spin_trylock(&mm->page_table_lock)) {
+			mm = list_entry(mm->mmlist.next, struct mm_struct, mmlist);
+			if (mm == &init_mm)
+				mm = list_entry(mm->mmlist.next, struct mm_struct, mmlist);
+		}
 
 		/* Make sure the mm doesn't disappear when we drop the lock.. */
 		atomic_inc(&mm->mm_users);
 		spin_unlock(&mmlist_lock);
 
 		nr_pages = swap_out_mm(mm, nr_pages, &counter, classzone);
-
+		spin_unlock(&mm->page_table_lock);
 		mmput(mm);
 
 		if (!nr_pages)

