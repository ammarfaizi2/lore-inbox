Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278968AbRJ2D32>; Sun, 28 Oct 2001 22:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278969AbRJ2D3T>; Sun, 28 Oct 2001 22:29:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:42827 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278968AbRJ2D3I>; Sun, 28 Oct 2001 22:29:08 -0500
Date: Mon, 29 Oct 2001 04:29:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: VM test on 2.4.14pre3aa2 (compared to 2.4.14pre3aa1)
Message-ID: <20011029042938.M1396@athlon.random>
In-Reply-To: <20011028120721.A286@earthlink.net> <20011029014715.J1396@athlon.random> <20011029034546.L1396@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011029034546.L1396@athlon.random>; from andrea@suse.de on Mon, Oct 29, 2001 at 03:45:46AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:45:46AM +0100, Andrea Arcangeli wrote:
> andrea@dev4-000:~> time ./mtest01 -b $[1024*1024*512] -w     
> PASS ... 536870912 bytes allocated.
> 
> real    1m8.655s
> user    0m9.370s
> sys     0m2.250s
> andrea@dev4-000:~> 

new exciting result on exactly the same test (4Ganon mem +512m swap,
then started the bench):

andrea@dev4-000:~> time ./mtest01 -b $[1024*1024*512] -w
PASS ... 536870912 bytes allocated.

real    0m40.473s
user    0m9.290s
sys     0m3.860s
andrea@dev4-000:~> 

(mainline takes 1m 40s, 1 minute more for the same thing)

I guess I cheated this time though :), see the _only_ change that I did to
speedup from 68/69 seconds to exactly 40 seconds:

--- 2.4.14pre3aa2/mm/page_io.c.~1~	Tue May  1 19:35:33 2001
+++ 2.4.14pre3aa2/mm/page_io.c	Mon Oct 29 03:58:23 2001
@@ -43,10 +43,12 @@
 	struct inode *swapf = 0;
 	int wait = 0;
 
+#if 0
 	/* Don't allow too many pending pages in flight.. */
 	if ((rw == WRITE) && atomic_read(&nr_async_pages) >
 			pager_daemon.swap_cluster * (1 << page_cluster))
 		wait = 1;
+#endif
 
 	if (rw == READ) {
 		ClearPageUptodate(page);
@@ -75,10 +77,12 @@
 	} else {
 		return 0;
 	}
+#if 0
  	if (!wait) {
  		SetPageDecrAfter(page);
  		atomic_inc(&nr_async_pages);
  	}
+#endif
 
  	/* block_size == PAGE_SIZE/zones_used */
  	brw_page(rw, page, dev, zones, block_size);

I found we were hurted by not being able to use the full I/O pipeline
like we do for writes.

Now it swapouts constantly and regularly at 12.8 Mbyte/sec (still
smooth), the write throttling happens at the PG_launder layer like for
MAP_SHARED.

hdparm -t on the swap partition says 27 Mbyte/sec but that's unreal, at
least with writes, a cp flood at max runs at 17mbyte/sec on such scsi
disk where we also swapout to.  Without the above change it swapouts at
7.5 Mbyte/sec instead of 12.8 Mbyte/sec.  12.8Mbyte/sec seems acceptable
also considering the pagetable walking etc... more costly than a stright
generic_file_write + balance_dirty.

I'm aware of the implications of the above, we may empty the pfmemalloc
pool, but that should mostly cause some sched_yields, it still runs
stable during this test at least. I'd prefer to fix any places to
sched_yield rather than running at 7.5 mbyte/sec.

But my strongest non-cheat (and backwards compatibility, no too risk in
2.4) is that we just don't use the nr_async_pages during pageout to disk
of the MAP_SHARED segments, so why should we use it for pageout of the
anonymous memory that doesn't even need to pass through the fs? (in most
setups with a proper swap partition) As far as MAP_SHARED is just correct,
page_io.c also shouldn't need it. comments?

Andrea
