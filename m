Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131517AbRAEO7W>; Fri, 5 Jan 2001 09:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131697AbRAEO7B>; Fri, 5 Jan 2001 09:59:01 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:39667 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131517AbRAEO64>; Fri, 5 Jan 2001 09:58:56 -0500
Date: Fri, 5 Jan 2001 12:58:34 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: linux-kernel@vger.kernel.org
Subject: 2.4 todo list update
Message-ID: <Pine.LNX.4.21.0101051244440.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

in the last few weeks quite a few of the bugs listed on your
(excellent) http://linux24.sourceforge.net/ have been fixed.

Here is a list of the VM bugs that are on your list and can
be moved to the "fixed" category:

* truncate->invalidate_inode_pages removes mapping information from
  mapped pages which may be dirty; sync_pte -> crash. (CRITICAL)

	fixed by Linus and Al

* VM: raw I/O data loss (raw IO may arrive in a page which afer it
  is unammped from a process) (CRITICAL)

	fixed by Linus, now page_launder() does the IO
	and try_to_swap_out() only unmaps the pte
 
* VM: Fix the highmem deadlock, where the swapper cannot create low
  memory bounce buffers OR swap out low memory because it has
  consumed all resources {CRITICAL}

	this was never an issue, the pagecache has been
	highmem safe for a long time and the whole bounce
	buffer creation has been removed

* VM: page->mapping->flush() callback in page_lauder() for easier
  integration with journaling filesystem and maybe the network
  filesystems 

	page->mapping->writepage(), used from page_launder()
	... now ext3, reiserfs, xfs and others need to make
	their own ->writepage() function
	... some semantics are still being discussed, but it's
	mostly ready

* VM: maybe rebalance the swapper a bit... we do page aging now so
  maybe refill_inactive_scan() / shm_swap() and swap_out() need to
  be rebalanced a bit

	moving shm into the page cache permanently and doing
	the page down aging from refill_inactive_scan() seems
	to have fixed most of this
	... low priority, but may still have some room for
	improvement  (consider it fixed)



The following bugs _could_ be fixed ... I'm not 100% certain
but they're probably gone (could somebody confirm/deny?):

* mm->rss is modified in some places without holding the
  page_table_lock

* VFS?VM - mmap/write deadlock (demo code seems to show lock
  is there)


The "probably post 2.4" category VM issues remain ... maybe
we want to add the following 2 items though:

* VM: experiment with different forms of page aging ... maybe
  different aging rates for pages of different ages

* VM: RSS ulimit enforcement (trivial)


regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
