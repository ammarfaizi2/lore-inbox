Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130755AbRARG4b>; Thu, 18 Jan 2001 01:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131843AbRARG4L>; Thu, 18 Jan 2001 01:56:11 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:24595 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S130755AbRARG4I>; Thu, 18 Jan 2001 01:56:08 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: dprobes@oss.lotus.com, linux-kernel@vger.kernel.org
cc: Andi Kleen <ak@suse.de>
Message-ID: <CA2569D8.00260CFA.00@d73mta05.au.ibm.com>
Date: Thu, 18 Jan 2001 12:19:25 +0530
Subject: [ANNOUNCE] Dynamic Probes 1.3 released
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've just released version 1.3 of the Dynamic Probes facility. This has
2.4.0 and 2.2.18 support and some bug fixes, including Andi Kleen's
suggestions for fixing the races in handling of swapped out COW pages.

For more information on DProbes see the dprobes homepage at
http://oss.software.ibm.com/developer/opensource/linux/projects/dprobes/

Changes in this version:

- DProbes for kernel version 2.2.18 and 2.4.0.
- Fix for race condition in COW page handling and some other
  corrections in the detection of correct offsets in COW pages.
- Removed the mmap_sem trylock from trap3 handling. The correct
  thing to do is to use the page_table_lock.
- Probe on BOUND instruction now logs data.
- Probes can now be inserted into modules that are getting initialized.
- kernel/time.c and arch/i386/kernel/time.c treated as exclude regions.
- Architecture specific FPU code moved to arch specific dprobes file.
- Minor bug fix in merge code which merges probes that are excluded.
- Exit to crashdump supported for 2.2.x kernels also.

We are no longer updating the patches for 2.2.12, 2.2.16 on the site.
If you require patches for these kernel versions, contact us at
dprobes@oss.software.ibm.com

----------------------------------------------------------------------------------------------------------------------------------------------------------------

Race condition fixes in handling COW pages:
----------------------------------------------------------------

Some updates on the race condition fixes for COW page handling, since the
discussions that happened last, for those who might have been following the
thread:

We eventually decided to drop the idea of trying achieve on-demand probe
insertion for swapped out COW pages by having a vm_ops->swapin() routine
that we could take over.

The reason was that we realized that the vm_ops->swapin() replacement
approach, while good for insert, is not suitable for remove, since then we
might need to keep around the probes records for a removed module, until
the swapped out pages eventually get cleaned out of the probes. (This may
have been feasible without too much work because we already have the logic
for quietly removing probes, but then it didn't seem like a good idea to
have ghost records around in this way -  makes it harder to maintain/debug
).

So, we ended up implementing Andi Kleen's original suggestion of a 2 pass
approach, instead. In the first pass, which takes place with the i_shared
lock held, we build a list of swapped out page locators (mm, addr), while
taking care of incrementing the mm reference count, and in the second pass
which happens with the spin locks released, we actually bring in the page
and cross-check that it is the same one that we'd meant to bring in. In the
second pass, we hold the mmap_sem while bringing the page in. With  David
Miller's lock hierarchy fixes, the i_shared_lock is now always higher in
the hierarchy than the page_table_lock, so we are OK there.

I hope we haven't missed anything. If anyone spots any gotchas or slips, or
some other races that still exist, do let us know. We've done some simple
testing to try to exercise a few scenarios that we could simulate easily,
but that's about it.

Regards
Suparna


  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
