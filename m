Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRDFQPp>; Fri, 6 Apr 2001 12:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131942AbRDFQPf>; Fri, 6 Apr 2001 12:15:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3176 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131899AbRDFQPS>; Fri, 6 Apr 2001 12:15:18 -0400
Date: Fri, 6 Apr 2001 18:34:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: 2 times faster rawio and several fixes (2.4.3aa3)
Message-ID: <20010406183440.B28118@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I merged some of SCT's fixes plus I fixed another couple of bugs and then I
boosted the code to run faster. There's still room for improvements for example
by using a ring of iobuf to walk pagetables and lock down pages for the next
atomic I/O chunk while the I/O of the previous iobuf is in progress (before
waiting synchronously) but with those first basic improvements it just runs
exactly 2 times faster than vanilla 2.4.3 on my hardware.  NOTE: since I made
the atomic I/O 512k to go in sync with the max size of a io-request and to take
advantage of the large I/O requests the MAX_KIO_SECTORS grown so much that it
cannot be loaded on the stack anymore (it was just a bad idea anyways to load
it on the stack anyways) so for things like the buffer array I preallocate an
helper buffer in the kiovec structure for that.

This should very significantly boost Oracle when the working set doesn't fit in
cache because the rawio path should be quite efficient now (comparable to
regular I/O through the cache).

2.4.3aa3 without rawio-1:

alpha:/home/andrea # time ./rawio-bench
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m10.323s
user    0m0.002s
sys     0m1.248s
alpha:/home/andrea # time ./rawio-bench
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m10.299s
user    0m0.002s
sys     0m1.247s
alpha:/home/andrea # time ./rawio-bench
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m10.557s
user    0m0.004s
sys     0m1.267s
alpha:/home/andrea # time ./rawio-bench
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m10.310s
user    0m0.003s
sys     0m1.282s
alpha:/home/andrea # 

2.4.3aa3 with rawio-1:

root@alpha:/home/andrea > time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.208s
user    0m0.001s
sys     0m1.162s
root@alpha:/home/andrea > time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.233s
user    0m0.002s
sys     0m1.184s
root@alpha:/home/andrea > time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.378s
user    0m0.002s
sys     0m1.213s
root@alpha:/home/andrea > time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.258s
user    0m0.001s
sys     0m1.183s
root@alpha:/home/andrea > 

Original patch is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.3aa3/20_rawio-1

however to apply cleanly to lvm you need to first apply the lvm patches into
the 2.4.3aa3 directory to upgrade to 0.9.1 beta6 (btw, I appreciated very much
the sistina folks that gone back to IPO 10 as suggested a few weeks ago,
thanks! :)

I also ported the patch to vanilla 2.4.3 for inclusion (however that version is
untested but the only rejects was in lvm-snap.c and they were obvious enough not
to require testing) but lvm people please look at the other patch that will
just apply cleanly to your CVS tree:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.3/rawio-1

Andrea
