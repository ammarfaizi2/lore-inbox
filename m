Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUCCHJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 02:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUCCHJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 02:09:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12301
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262087AbUCCHIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 02:08:54 -0500
Date: Wed, 3 Mar 2004 08:09:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040303070933.GB4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While merging 230-objrmap in my tree I spotted 2 bugs potentially
generating random memory corruption and 1 superflous bit that I dropped
(mostly for documentation reasons, I like strict and in turn self
documenting). Here below the fixes.

in the first file we needs the page_table_lock while changing the rbtree
etc... both the page_table_lock and the down_write must be held during
all writes, so the reader can choose between a down_read or a spin_lock.

The second one is a bug in mainline 2.6 too apparently, maybe I'm
missing something but I don't see how you prevent the vm to swapout a
reserved region without my fix. A reserved region must not be messed
from the vm since it's a dma hardware region that we page lazily instead
of using PG_reserved (or MMIO) + remap_page_range. It's different from
VM_LOCKED so you can't clear that bit IIRC but that's the same,
VM_LOCKED == VM_RESERVED in VM terms.  As said I believe you inherit
this bug from mainline 2.6 (2.4 has always been safe instead).

The third is a superflous down_read, it's not needed because the
page_table_lock is held during the call and it seems not to need to drop
it to schedule (and either we use the spinlock or the semaphore, both
doesn't make much sense for a reader).

Please double check, thanks.

I'm running some shm swap regression test on this right now and I'll
leave it running for a day. In a few hours I will proceed starting
dropping the pte_chain from the page sturcture and then I'll test the
anon swapout. I will also follow the 6 great-effort anobjrmap posted by
Hugh against objrmap while doing that, they're quite old (almost 1 year)
but they still apply cleanly by hand so they're useful.

--- sles-objrmap/mm/mmap.c.~1~	2004-03-03 06:45:38.980596736 +0100
+++ sles-objrmap/mm/mmap.c	2004-03-03 06:53:46.945414808 +0100
@@ -1284,8 +1284,8 @@ int do_munmap(struct mm_struct *mm, unsi
 	/*
 	 * Remove the vma's, and unmap the actual pages
 	 */
-	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
 	spin_lock(&mm->page_table_lock);
+	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
 	unmap_region(mm, mpnt, prev, start, end);
 	spin_unlock(&mm->page_table_lock);
 
--- sles-objrmap/mm/rmap.c.~1~	2004-03-03 06:45:38.995594456 +0100
+++ sles-objrmap/mm/rmap.c	2004-03-03 07:01:39.200621104 +0100
@@ -470,7 +470,7 @@ try_to_unmap_obj_one(struct vm_area_stru
 	if (!pte)
 		goto out;
 
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
 		ret =  SWAP_FAIL;
 		goto out_unmap;
 	}
--- sles-objrmap/mm/swapfile.c.~1~	2004-03-03 06:45:39.023590200 +0100
+++ sles-objrmap/mm/swapfile.c	2004-03-03 07:03:33.128301464 +0100
@@ -499,7 +499,6 @@ static int unuse_process(struct mm_struc
 	/*
 	 * Go through process' page directory.
 	 */
-	down_read(&mm->mmap_sem);
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
@@ -507,7 +506,6 @@ static int unuse_process(struct mm_struc
 			break;
 	}
 	spin_unlock(&mm->page_table_lock);
-	up_read(&mm->mmap_sem);
 	pte_chain_free(pte_chain);
 	return 0;
 }



About 2.5:1.5 it seems not everybody is happy to lose 512m (and it's not
Oracle), but before ruling it out I'd like to get some real life number,
to be sure the performance of 2.0^W4:4 are really close (if not
"better") than 3:1 as someone said. If we go with 4:4 IMHO at the very
least the vgettimeofday backport from x86-64 is a must. In the meantime
I keep going with the rmap removal to fixup the fork  and to get back
the 128m of normal zone useful on the 32G boxes. Could be also that new
cpus are a lot better at reloading the tlbs from the pagetables dunno,
the first numbers I recall about 4:4 predates to 2000 when PII was quite
optimal.  I'd only like to see an opteron and a xeon dealing with 4:4.
