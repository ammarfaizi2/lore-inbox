Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311735AbSCXH1I>; Sun, 24 Mar 2002 02:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311737AbSCXH06>; Sun, 24 Mar 2002 02:26:58 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51464 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311735AbSCXH0o>; Sun, 24 Mar 2002 02:26:44 -0500
Message-ID: <3C9D7F4B.45B1A766@zip.com.au>
Date: Sat, 23 Mar 2002 23:24:59 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Updated -aa VM patches
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Slightly reworked, and a lot more testing.  The diffs against
2.4.19-pre4 are at

	http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre4/aa3/

- Removed the double underscores which offended hch.
- Shuffled the order so that zone_accounting.patch comes
  immediately before swap_out.patch.  This is the correct
  ordering and the patch series now works OK at all steps.
- I added aa-230-free_zone_bhs.patch to the series.

The latter is code which purportedly fixes the "ZONE_NORMAL
full of buffer_heads" problem.  I wasn't able to reproduce
this with a 15:1 highmem:normal split.  But the problem is real.

This piece of code is not a thing of beauty, but I can't think of a
different way of fixing the problem, and nobody else has proposed
a different way, and the problem which it addresses is a box-killer.
A killer of $100,000 boxes, indeed.  It has zilch performance
impact on lesser machines (I instrumented it), it is stable and I
think it should go in.

I haven't done anything about the nr_dirty-doesn't-do-anything
issue.  The code as it stands works well.  The management of
writeback and dirty memory is the best I've ever seen in Linux.
Sure, maybe we can get some additional benefit from making nr_dirty
work as originally intended.  But that's a new feature which can
potentially have subtle effects.  Now is not the time to be
fiddling with it, somewhat invalidating all the testing which Andrea,
SuSE, myself and others have performed.

The other outstanding issue is the icache and dcache shrinkage
ratios.  Again, I believe that tuning these should be a separate
effort.  It's not causing any obvious problems.


Proposed merge timing is:

writeback changes:
        aa-010-show_stack.patch
        aa-020-sync_buffers.patch
        aa-030-writeout_scheduling.patch
        aa-040-touch_buffer.patch

VM changes:
        aa-093-vm_tunables.patch
        aa-095-zone_accounting.patch
        aa-096-swap_out.patch
        aa-100-local_pages.patch
        aa-120-try_to_free_pages_nozone.patch

The rest:
        aa-140-misc_junk.patch
        aa-150-read_write_tweaks.patch
        aa-160-lru_release_check.patch
        aa-170-drain_cpu_caches.patch
        aa-180-activate_page_cleanup.patch
        aa-190-block_flushpage_check.patch
        aa-200-active_page_swapout.patch
        aa-230-free_zone_bhs.patch

-
