Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135793AbREICfa>; Tue, 8 May 2001 22:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135805AbREICfV>; Tue, 8 May 2001 22:35:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:54108 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135793AbREICfK>; Tue, 8 May 2001 22:35:10 -0400
Date: Wed, 9 May 2001 04:34:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Jens Axboe <axboe@suse.de>
Subject: blkdev in pagecache
Message-ID: <20010509043456.A2506@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This night I moved the blkdev layer in pagecache in this patch:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.5pre1/blkdev-pagecache-1

It is incremental and depends on the o_direct functionality, latest
o_direct patch against 2.4.5pre1 is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.5pre1/o_direct-5

The main reasons I moved the blkdev in pagecaches is that the current
blkdev provides horrible performance with fast I/O subsystem capable of
over 50mbyte/sec that I just increased x2 with a simple hack that you
can see here if you're curious:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5pre1aa2/00_4k_block_dev-1

(btw, also the current rawio uses a 512byte bh->b_size granularity that is even
worse than the 1024byte b_size of the blkdev, O_DIRECT is much smarter
on this side as it uses the softblocksize of the fs that can be as well
4k if you created the fs with -b 4096)

However after running this 4k_block_dev-1 hack on some more machine I
noticed the blkdev layer wasn't able anymore to update the superblock of
1k ext2 filesystems and to make it "usable" in real life I needed to fix
it. But I didn't wanted ot invest any further time on such an hack and I
preferred to move the blkdev in pagecache and to fix the problem on top
of the new better design (moving blkdev in pagecache of course
introduces that same problem too as I also mentioned in one of the below
points).

I'll describe here some of the details of the blkdev-pagecache-1 patch:

- /dev/raw* and drivers/char/raw.c gets obsoleted and replaced by
  opening the blkdevice with O_DIRECT, it looks much saner and I
  basically get it for free by just implementing 10 lines of the
  blkdev_direct_IO callback, of course I didn't removed the /dev/raw*
  API for compatibility.

  While testing O_DIRECT I destroyed the first 50mbyte of the root
  partition so I will need to wait the test box to return alive before I
  can make further testing ;). But I just fixed the bug that caused the
  corruption before uploading the patch so I don't expect further
  problems (it was only a s/i_dev/i_rdev thing) because the regression
  testing was working well even if it was writing in the wrong disk ;).

- I force the virtual blocksize for all the blkdev I/O
  (buffered and direct) to work with a 4096 bytes granularity instead of
  the current 1024 softblocksize because we need that for getting higher
  performance, 1024 is too low because it wastes too much ram and too
  much cpu. So a DBMS won't be able anymore to write 512bytes to the
  disk using rawio being sure it will be a single atomic block update.
  If you use /dev/raw nothing changed of course, only opening blkdev
  with O_DIRECT enforce a minimal granularity of 4096 bytes in the I/O.
  I don't think this is a problem, and also O_DIRECT through the fs was
  just using the fs softblocksize instead of the hardblocksize as unit
  of the minimal direct-IO granularity.

- writes to the blockdevice won't end in the buffer cache, so it will
  be impossible to update the superblock of an ext2 partition mounted ro
  for example, it must not be mounted at all to update the superblock, I
  will need to invent an hack to fix this problem or it will get too
  annoying. One way could simply to change ext2 and have it checking
  the buffer to be uptodate before marking it dirty again but maybe
  we could also do it in a generic manner that fixes all the fs at once
  (OTOH probably not that many fs needs to be fscked online...).

- mmap should be functional but it's totally untested.

- currently the last `harddisk_size & 4095' bytes (if any) won't be
  accessible via the blkdev, to avoid sending to the hardware requests
  beyond the end of the device. Not sure how/if to solve this. But this is
  definitely not a new issue, the same thing happens today in 2.2 and
  2.4 after you mount a 4k filesystem on a blockdevice. OTOH I'm scared
  a mke2fs -b 1024 could get confused. But I really don't want to
  decrease the b_size of the buffer header even if we fix this.

- to share all the filemap.c code and not to change too much stuff in
  the first patch I added some ISBLK check in fast paths, basically
  only to check against blk_size instead of inode->i_size, I also
  considered changing the i_size semantics for the blkdev inodes but
  I didn't wanted to break all the fs yet so I took the localized
  slower way for now (I doubt it is noticeable in the benchmarks
  but nevertheless it would be nice to optimize away those branches).

- once the blkdev is closed in the block_close callback I
  filemap_fdatasync;fsync_dev;filemap_fdatawait;invalidate_inode_pages2
  (fdatawait seems not necessary but it won't hurt). I'm not calling
  truncate_inode_pages because those pages could be still mapped
  (->release is called when f_count goes down to zero, not when
  i_count reaches zero). I'd like to defer the invalidate_inode_pages2
  to the time an fs gets mounted or when check_media_change triggers
  like in 2.2, but this is another issue.

Besides the s/i_dev/i_rdev/ thing that is just fixed, it looked stable
but better to backup before playing with it ;).

Andrea
