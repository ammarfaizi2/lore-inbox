Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUBDLn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 06:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUBDLmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 06:42:01 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:20444 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266340AbUBDLlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 06:41:17 -0500
Date: Wed, 04 Feb 2004 20:40:58 +0900 (JST)
Message-Id: <20040204.204058.1025214600.nomura@linux.bs1.fc.nec.co.jp>
To: hugh@veritas.com
Cc: j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4] heavy-load under swap space shortage
From: j-nomura@ce.jp.nec.com
In-Reply-To: <Pine.LNX.4.44.0402031638350.19713-100000@localhost.localdomain>
References: <20040203.165359.149824126.nomura@linux.bs1.fc.nec.co.jp>
	<Pine.LNX.4.44.0402031638350.19713-100000@localhost.localdomain>
X-Mailer: Mew version 3.3 on XEmacs 21.4.14 (Reasonable Discussion)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> May save CPU, but won't do the freeing expected of it.
> Or am I reading your patch wrongly?

No, you're right.

> Let me dig out my patch for 2.4.13, it appears to apply much the
> same to 2.4.24 or 2.4.25-pre8, though untested recently.  I think I
> got involved in something else, and never pushed it out back then.
> Do you find it helpful?

With slight modification (please see the patch below), it's really helpful.
I hope you push it again to the mainline.

> It's a little more complicated than yours because although it's good
> to let the tasks encountering page_table_lock contention go on to
> try another mm, it would not be good to update swap_mm too readily:
> the contentious mm is likely to be the one which most needs freeing.

I agree.

> Think carefully about swap_address here: I seem to recall that
> it is racy, but benign - won't go wrong often enough to matter.

I had to remove raciness check in swap_out_mm, otherwise swap_out_mm
returns immediately and contend on mmlist_lock in mmput().
I think removal is ok because we now avoid the 'rush to same mm' by trylock.

I added the check for 'mm == swap_mm'. It might be necessary to avoid
the corner case where mmlist_lock being held too long.

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com>


--- linux-2.4.24/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -292,13 +292,7 @@ static inline int swap_out_mm(struct mm_
 	 * Find the proper vm-area after freezing the vma chain 
 	 * and ptes.
 	 */
-	spin_lock(&mm->page_table_lock);
 	address = mm->swap_address;
-	if (address == TASK_SIZE || swap_mm != mm) {
-		/* We raced: don't count this mm but try again */
-		++*mmcounter;
-		goto out_unlock;
-	}
 	vma = find_vma(mm, address);
 	if (vma) {
 		if (address < vma->vm_start)
@@ -310,15 +304,14 @@ static inline int swap_out_mm(struct mm_
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
 
@@ -345,12 +338,20 @@ static int swap_out(zone_t * classzone)
 			swap_mm = mm;
 		}
 
+		/* scan mmlist and lock the first available mm */
+		while (mm == &init_mm || !spin_trylock(&mm->page_table_lock)) {
+			mm = list_entry(mm->mmlist.next, struct mm_struct, mmlist);
+			if (mm == swap_mm)
+				goto empty;
+		}
+
 		/* Make sure the mm doesn't disappear when we drop the lock.. */
 		atomic_inc(&mm->mm_users);
 		spin_unlock(&mmlist_lock);
 
 		nr_pages = swap_out_mm(mm, nr_pages, &counter, classzone);
 
+		spin_unlock(&mm->page_table_lock);
 		mmput(mm);
 
 		if (!nr_pages)
