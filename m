Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311459AbSCTDzG>; Tue, 19 Mar 2002 22:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311479AbSCTDy5>; Tue, 19 Mar 2002 22:54:57 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51724 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311459AbSCTDyp>; Tue, 19 Mar 2002 22:54:45 -0500
Message-ID: <3C9807AD.65EBB69C@zip.com.au>
Date: Tue, 19 Mar 2002 19:53:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: -aa VM splitup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been crunching on Andrea's 10_vm-32 patch for a number of days
with a view to getting it into the main tree.

At http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre3/aa/ are 24
separate patches - the sum of all these is basically identical to
10_vm-32.  Note that the commentary in some of those patches is not
completely accurate.

Linus reviewed those patches over the weekend.  As a result of that and
some of my own work, we're down to 16 patches.  They are at

http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre3/aa2/

I'll be feeding those 16 patches onto this mailing list for review. 
Here's a summary:

aa-010-show_stack.patch
	Sort-of provides an arch-independent show_stack() API.

aa-020-sync_buffers.patch
	writeback changes.

aa-030-writeout_scheduling.patch
	More writeback changes.

aa-040-touch_buffer.patch
	Buffer page aging changes.

aa-050-page_virtual.patch
        Linus said: "it just makes a micro-optimization to
        "page_address()" for the case where there is only one mem_map. 
        In my book, it only makes the thing more unreadable."

        Not included in aa2.

aa-060-start_aggressive_readahead.patch
        This was patch leakage from the XFS tree.  Not included in aa2

aa-070-exclusive_swap_page.patch
	Linus says this was addressed by other means.  Not included.

aa-080-async_swap_speedup.patch
        Linus said "The other part (that allows async swapins)
        was dangerous in my testing (it's originally from me): it
        allows a process that has a big dirty footprint to keep on to
        its pages without ever waiting for their dirty writeback.  I
        ended up reverting it because it allowed hoggers to make for
        worse interactive behaviour, but it definitely improves
        throughput."

        Not included.

aa-090-zone_watermarks.patch
        "I think the same problem got fixed with a simple
        one-liner in my 2.4.17 or something: make the "pages_low"
        requirement add up over all zones you go through."

        Not included.

aa-093-vm_tunables.patch
        Adds /proc tunables

aa-096-swap_out.patch
        Changes to the swap_out logic.  With this patch the VM
        becomes *totally* unusable.  It needs the changes in aa-110 as
        well.

aa-100-local_pages.patch
        This was some code which added a memclass check to the
        local_pages logic.  After examination I decided that there was
        tons more code in there than we actually needed, so I stripped
        this down to just a single process-local page.  Which is
        basically all that the code ever did.

aa-110-zone_accounting.patch
        Adds all the instrumentation which aa-096 needs.  'fraid I got those patches
        backwards.

        Andrea had implemented this as lots of macros in
        swap.h.  Linus' said "but should be cleaned up to use real
        functions instead of those macros from hell.  So I did that.

aa-120-try_to_free_pages_nozone.patch
        Support function needed by buffer.c

aa-140-misc_junk.patch
        Random little stuff

aa-150-read_write_tweaks.patch
        Little changes to pagefault and write(2) code.

aa-160-lru_release_check.patch
        Hugh's famous BUG() check in free_pages.

aa-170-drain_cpu_caches.patch
        microoptimisation

aa-180-activate_page_cleanup.patch
        Code cleanup

aa-190-block_flushpage_check.patch
        BUG check

aa-200-active_page_swapout.patch
        Remove dead code (I think)

aa-210-tlb_flush_speedup.patch
        microoptimisation

aa-230-free_zone_bhs.patch
        Prevent ZONE_NORMAL from getting clogged with
        buffer_heads.  Everyone agrees that this is a pretty ugly hack.
         I'm not proposing it for inclusion at this time, but the diff
        is there, and it is stable.

aa-240-page_table_hash.patch
        This is the patch which changes Bill Irwin's hashing
        scheme for per-page waitqueues.  I'm not proposing it for
        merging at this time - I think that more discussion and
        evaluation is needed to justify such action.  But the patch is
        there, and is stable.


For a merging plan I'd propose that the patches be considered in three
groups.  Maybe split across three kernel releases.

writeback changes:
	aa-010-show_stack.patch
	aa-020-sync_buffers.patch
	aa-030-writeout_scheduling.patch
	aa-040-touch_buffer.patch

VM changes:
	aa-093-vm_tunables.patch
	aa-096-swap_out.patch
	aa-100-local_pages.patch
	aa-110-zone_accounting.patch
	aa-120-try_to_free_pages_nozone.patch

The rest:
	aa-140-misc_junk.patch
	aa-150-read_write_tweaks.patch
	aa-160-lru_release_check.patch
	aa-170-drain_cpu_caches.patch
	aa-180-activate_page_cleanup.patch
	aa-190-block_flushpage_check.patch
	aa-200-active_page_swapout.patch

There are still a few areas which need more work, but they're not
critical.  They're highlighted in the commentary against the individual
patches.

-
