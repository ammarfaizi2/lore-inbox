Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272371AbRIFBB7>; Wed, 5 Sep 2001 21:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272370AbRIFBBu>; Wed, 5 Sep 2001 21:01:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9476 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272369AbRIFBBj>; Wed, 5 Sep 2001 21:01:39 -0400
Date: Thu, 6 Sep 2001 03:02:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rohit.seth@intel.com
Subject: kiobuf wrong changes in 2.4.9ac9
Message-ID: <20010906030228.C11329@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suggest to backout the kiobuf patch in 2.4.9ac9. Right performance fix
is just in 2.4.10pre4aa1 and it depends on O_DIRECT.

see:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre4aa1/00_o_direct-15
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre4aa1/10_rawio-f_iobuf-1

Porting to 2.4.5 is very very very trivial if truly needed.

I cannot care less if with 2 hounrded of harddisks and 2 houndred of
tasks all doing simultaneous I/O to all the 2 hounrded of harddisks, 2
hounrded of mbytes of ram are statically allocated in kiobufs. If you
have money for such configuration you *defininitely* don't want to waste
cpu in kiobufs allocation but you want to keep them preallocated and
spend the money in the 2 houndred mbytes of ram (today in Italy a pair
kilometers away from my home I can buy a 128mbytes 133mhz dimm for 20
EUR [in us it has to be cheaper], compare that with the price of the
rest of the system). I didn't even attempted to count the static ram you
as well spend in the large preallocated I/O queues for each harddisk for
the same reason.

In low end configuration with a few disks and a few tasks doing I/O the
ram overhead is some houndred kbytes so it's fine.

For the thread/process issue there's no difference at all (I'm not
penalyzing threads), it's just that you must reopen the file if the
child thread or process will do simutalenous I/O to the same rawio
device with the parent (the only difference between process and thread
is that you will be forced to share the same fd space with the parent in
the thread case but it's a long time [2.2] that the fd space is
1024*1024 fd high bound).

Now I'm not saying we don't need to shrink the size of the kiobuf so we
can save ram [notably for non IO backed kiobuf users] and make the
contention case faster as well (btw, having the KIO_MAX_ATOMIC_IO at
512k is useful only in -aa with the other changes that allows the 512k
scsi commands:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre4aa1/00_sd-max_sectors-1

). But my plan was to split the kiobuf in two entities to save ram and
to try to slabify it again, but that's a much lower prio work (the high
prio stuff is what I'm shipping above in -aa) and my point here is that
this lower prio work it's not in the direction of the patch.

The above is all about performance and design, about real world
showstopper the one in 2.4.9ac9 is that kiobuf allocations are going to
fail during read/writes due mem framentation (this is why it was using
vmalloc indeed) [those faliures should be easily reprocible on x86 boxes
with PAGE_SIZE = 4k]. The reason kmem allocations larger than PAGE_SIZE
aren't reliable is because the slab like everything else is alloc_pages
backed and the main allocator isn't reliable to allocate anything larger
than PAGE_SIZE.  OTOH for the kernel stack we also allocate 2*PAGE_SIZE
physically contigous, but here the kiobuf structure would generate an
order 2 allocation that will definitely fail with the current vm
eventually [ask Daniel] (not order 1 like kernel stack)

I told Rohit a few days ago about some of those issues as argument why I
didn't accepted the patch, he raised a few issues that I hope to have
addressed in this email, I was busy with other things and so I managed
to answer only now, I'm sorry for the delay Rohit.

Rohit could you please do a run of the benchmark on top of
2.4.10pre4aa1 to verify I'm right about the "high prio" stuff, then
we'll address the "low prio" contention optimization and finegrined
memory-saving part relaxed in a larger patch.

Andrea
