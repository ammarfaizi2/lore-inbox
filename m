Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317847AbSFSLS0>; Wed, 19 Jun 2002 07:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317848AbSFSLSZ>; Wed, 19 Jun 2002 07:18:25 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:9480 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317847AbSFSLSY>; Wed, 19 Jun 2002 07:18:24 -0400
Date: Wed, 19 Jun 2002 04:18:00 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Where:  http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/

This patch implements Rik van Riel's patches for a reverse mapping VM 
atop the 2.5.23 kernel infrastructure.  The principal sticky bits in 
the port are correct interoperability with Andrew Morton's patches to 
cleanup and extend the writeback and readahead code, among other things.  
This patch reinstates Rik's (active, inactive dirty, inactive clean) 
LRU list logic with the rmap information used for proper selection of pages 
for eviction and better page aging.  It seems to do a pretty good job even 
for a first porting attempt.  A simple, indicative test suite on a 192 MB 
PII machine (loading a large image in GIMP, loading other applications, 
heightening memory load to moderate swapout, then going back and 
manipulating the original Gimp image to test page aging, then closing all 
apps to the starting configuration) shows the following:

2.5.22 vanilla:
Total kernel swapouts during test = 29068 kB
Total kernel swapins during test  = 16480 kB
Elapsed time for test: 141 seconds

2.5.23-rmap13b:
Total kernel swapouts during test = 40696 kB
Total kernel swapins during test  =   380 kB
Elapsed time for test: 133 seconds

Although rmap's page_launder evicts a ton of pages under load, it seems to 
swap the 'right' pages, as it doesn't need to swap them back in again.
This is a good sign.  [recent 2.4-aa work pretty nicely too]

Various details for the curious or bored:

	- Tested:   UP, 16 MB < mem < 256 MB, x86 arch. 
	  Untested: SMP, highmem, other archs.  

	  In particular, I didn't even attempt to port rmap-related 
	  changes to 2.5's arch/arm/mm/mm-armv.c.  

	- page_launder() is coarse and tends to clean/flush too 
	  many pages at once.  This is known behavior, but seems slightly 
	  worse in 2.5 for some reason. 

	- pf_gfp_mask() doesn't exist in 2.5, nor does PF_NOIO.  I have 
	  simply dropped the call in try_to_free_pages() in vmscan.c, but 
	  there is probably a way to reinstate its logic 
	  (i.e. avoid memory balancing I/O if the current task 
	  can't block on I/O).  I didn't even attempt it.

	- Writeback:  instead of forcing reinstating a page on the 
	  inactive list when !PageActive, page->mapping, !Pagedirty, and 
	  !PageWriteback (see mm/page-writeback.c, fs/mpage.c), I just 
	  let it go without any LRU list changes.  If the page is 
	  inactive and needs attention, it'll end up on the inactive 
	  dirty list soon anyway, AFAICT.  Seems okay so far, but that 
	  may be flawed/sloppy reasoning... We could always look at the 
	  page flags and reinstate the page to the appropriate LRU list 
	  (i.e. inactive clean or dirty) if this turns out to be a 
	  problem...

	- Make shrink_[i,d,dq]cache_memory return the result of 
	  kmem_cache_shrink(), not simply 0.  Seems pointless to waste 
	  that information, since we're getting it for free.  Rik's patch 
	  wants that info anyway...

	- Readahead and drop_behind:  With the new readahead code, we have 
	  some choices regarding under what circumstances we choose to 
	  drop_behind (i.e. only drop_behind if the reads look really 
	  sequential, etc...).  This patch blindly calls drop_behind at 
	  the conclusion of page_cache_readahead().  Hopefully the 
	  drop_behind code correctly interprets the new readahead indices. 
	  It *seems* to behave correctly, but a quick look by another 
	  pair of eyes would be reassuring. 

	- A couple of trivial rmap cleanups for Rik:
		a) Semicolon day!  System fails to boot if rmap debugging 
		   is enabled in rmap.c.  Fix is to remove the extraneous 
		   semicolon in page_add_rmap():

				if (!ptep_to_mm(ptep)); <--

		b) The pte_chain_unlock/lock() pair between the tests for 
		   "The page is in active use" and "Anonymous process 
		   memory without backing store" in vmscan.c seems
		   unnecessary. 

		c) Drop PG_launder page flag, ala current 2.5 tree.

		d) if(page_count(page)) == 0)  --->  if(!page_count(page))
		   and things like that...

	- To be consistent with 2.4-rmap, this patch includes a 
	  minimal BIO-ified port of Andrew Morton's read-latency2 patch
	  (i.e. minus the elvtune ioctl stuff) to 2.5, from his patch 
	  sets.  This adds about 7 kB to the patch. 

	- The patch also includes compilation fixes:  
	(2.5.22)
	      drivers/scsi/constants.c (undeclared integer variable)
	      drivers/pci/pci-driver.c (unresolved symbol in pcmcia_core)
	(2.5.23)
	      include/linux/smp.h (define cpu_online_map for UP)
	      kernel/ksyms.c    (export default_wake_function for modules)  
	      arch/i386/i386_syms.c   (export ioremap_nocache for modules)


Hope this is of use to someone!  It's certainly been a fun and 
instructive exercise for me so far.  ;)

I'll attempt to keep up with the 2.5 and rmap changes, fix inevitable 
bugs in porting, and will upload regular patches to the above URL, at 
least until the usual VM suspects start paying more attention to 2.5.  
I'll post a quick changelog to the list occasionally if and when any 
changes are significant, i.e. other then boring hand patching and 
diffing.   


Comments, feedback & patches always appreciated!

Craig Kulesa
Steward Observatory, Univ. of Arizona

