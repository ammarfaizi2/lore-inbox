Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWBWH3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWBWH3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 02:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWBWH3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 02:29:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:47016 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750941AbWBWH3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 02:29:47 -0500
Date: Thu, 23 Feb 2006 12:59:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org, sct@redhat.com, mason@suse.com,
       linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc: kenneth.w.chen@intel.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       sonny@burdell.org
Subject: [RFC][WIP] DIO simplification and AIO-DIO stability
Message-ID: <20060223072955.GA14244@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DIO code complexity and stability concerns were discussed way back during
OLS and Kernel summit last year. Still, the lack of a solid alternative and
motivation to subject oneself to the test of courage and delicate balance
that fiddling with this code entails, has meant that gingerly applying fixes
and bandaids as and when bugs are found, and moving on thereafter,
continues to be the most palatable option.

A recent AIO-DIO bug reported by Kenneth Chen, came very close
to being the proverbial last straw for me. Hence, here is a rough attempt to
put together a (currently WIP) draft towards DIO code simplication, based
on suggestions that some of you have brought up at various times. Several
details, e.g. range locking implementation still need to be fleshed out
completely, ideas/comments/suggestions would be welcome.

http://www.kernel.org/pub/linux/kernel/people/suparna/DIO-simplify.txt
(also inlined below)

It would be quite pointless (and painful!), if the rewrite ends up becoming
just as tricky and error prone as before. Such a patch will need a very
close critical review by many sharp eyes, to avoid disrupting the current
state of stability. So before going any further with this, I'm looking
for feedback along the lines of:

- Is this a worthwhile thing to attempt ? Or is status quo good enough ?
- Does the approach make sense ? Is there a simpler way ?
- Is there any hidden complexity or performance overhead that you forsee ?
- Adding an extra tag to the radix-tree for locking a range of pages would
  impact the size of the radix tree; would that be a concern ?

Regards
Suparna

------------------------------------------------------

Need for simplification
-----------------------
- The code has become tricky and hence difficult to understand and maintain
- Stability has been a concern, bugs never seem to stop cropping up (especially
  with regard to error handling), and there still are some potential loopholes
  ini the current implementation, esp AIO-DIO e.g.
  - AIO-DIO has some potential races in handling of IO errors, e.g. EIO.
  - For AIO-DIO writes, invalidate_inode_pages may be called before write
    completes

Considerations for simplification
---------------------------------
- Reduce the number of special cases and conditions to check for
- Bring locking model closer to that followed for regular read/writes
- Unify logic as far as possible for conceptual simplicity
- Optimize for the most common situation, i.e. non-extending DIO to
  already allocated blocks, with no concurrent buffered IO on the same
  file, and no concurrent DIO to the same part of the file.

I. DIO read
-----------

Protection against buffered IO hole overwrite, where uninstantiated blocks
may be exposed until writeback completes. Buffered reads go through page
cache and hence never see stale data. Direct reads however go directly to
disk.

(a) Current Solution:
	- i_alloc_sem held for read => protects against truncate
	- i_mutex held => no new blocks get created until DIO getblocks
	  completes
	- filemap_write_and_wait => ensures any existing uninstantiated blocks
			complete writeback to disk

	- AIO error handling paths differ for errors during submission
	  vs during IO - in one case aio_complete issued by higher layer,
	  in another case within the io completion path in finished_one_bio


(b) Alternative Solution
	(Follow similar locking rules as buffered read)
	- i_alloc_sem held for read => protects against truncate
	- Lookup and lock pages in the range by tagging the radix tree
	  slots as "TAG_LOCKED", and locking pages that were present.
	  Modify find_get_page et al to return a dummy locked cache page
	  if TAG_LOCKED. (Alternatively put the check in add_to_page_cache,
	  instead)
		=> no new writes or blocks instantiated until DIO getblocks
		   completes
	- Issue equiv of filemap_write_and_wait_range that acts on already
	  locked pages	(also likely to be useful for mpage_writepages) 
		=> ensures existing uninstantiated blocks written to disk
	- On IO completion release lock on pages and the range, including
	  unlocking and releasing dummy cache page.
		=> This will wake up readers and writers blocked on locked
		   pages. Since on wakeup most code paths check mapping once
		   again and also hold an extra ref count, this should be safe. 
		   (hopefully !)

	Optional:
	- With retry based AIO-DIO => aio_complete can happen in the same
	  way during submission and during a retry following completion, thus
	  error handling takes the same path in both cases.

II. DIO write

Protection against buffered IO reads or DIO reads being exposed
to uninstantiated blocks during a DIO hole overwrite/extend. Holding
i_sem in DIO writes doesn't help protect buffered IO reads, since i_sem
is not acquired in read paths.

(a) Current Solution
	- i_alloc_sem held for read => protects against truncate
	- Hold i_mutex at least till completion of DIO getblocks and submission
	- Force file extending DIO writes to be i_mutex holding until i_size
	  increase (i.e till DIO completes) to avoid exposing new blocks
	- Fallback to buffered IO for hole overwrites, so that the default page
   	  based locking protects buffered IO reads from seeing uninstantiated
	  blocks
	- filemap_write_and_wait => ensures any pending writes complete
	  writeback to disk
	- Perform DIO write
	- invalidate pages => subsequent reads should see newly written data

	- Force extending AIO-DIO writes to be synchronous
	- Force AIO-DIO overwrites that cross holes to be synchronous for
	  issued DIO before fallback to buffered IO.
	- AIO Error handling takes different paths for errors during submission
	  and during IO completion. Fallback to buffered adds another level
	  of complexity, as does forced synchronous behaviour for extends.

(b) Alternative Solution
	(Follow similar locking rules as buffered IO)
	- i_alloc_sem held for read => protects against truncate
	- check if this is an extending write, and if not release i_mutex
	- Lookup and lock pages in the range by tagging the radix tree
	  slots as "TAG_LOCKED", and locking pages that were present.
		=> reads are blocked until DIO write completes, i.e
		   uninstantiated blocks not exposed
	- Issue equiv of filemap_write_and_wait_range that acts on already
	  locked pages and then invalidate the pages.
		=> subsequent reads should see newly written data
	- Perform DIO write (including block allocations etc)
	- On IO completion release lock on pages and unlock the range,
	  including unlocking and releasing dummy cache page, release
	  i_alloc_sem and i_mutex.

	  [i_mutex and i_alloc_sem handling can be moved entirely into
 	   higher levels, which avoids DIO_LOCKING checks inside the DIO
	   code; Since i_mutex is held only for extending writes it should
	   not be a concurrency issue; Also in the AIO case, it is ok to
	   update i_size and release i_mutex (perhaps even i_alloc_sem) w/o
	   having to wait for IO completion since pages are still locked ]
	
	Optional:
	- With retry based AIO-DIO => aio_complete happens in the same
	  way during submission and during a retry following completion.
	  Unlocking the range and release of pages can likewise happen
	  in retry context (not in interrupt context).

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

