Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRBBTdN>; Fri, 2 Feb 2001 14:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbRBBTdD>; Fri, 2 Feb 2001 14:33:03 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:51314 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129131AbRBBTcr>; Fri, 2 Feb 2001 14:32:47 -0500
Date: Fri, 2 Feb 2001 14:32:39 -0500 (EST)
From: <bcrl@redhat.com>
To: <linux-kernel@vger.kernel.org>
cc: <linux-aio@kvack.org>, <kiobuf-io-devel@lists.sourceforge.net>
Subject: 1st glance at kiobuf overhead in kernel aio vs pread vs user aio
Message-ID: <Pine.LNX.4.30.0102021317470.4628-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

First off, sorry for spamming all the mailing lists, but I want to make
sure that everyone interested in kiobufs, aio and the like sees this.
Since the mass of discussion going on about kiobufs started, I ran a few
tests of the behaviour of various code when reading from a cached ~700mb
file.  The first thing I've noticed is that I have to slim down the posix
compatibility code for aio =).  In any case, here are some graphs of
interest:

	http://www.kvack.org/~blah/aio_plot5.png
	http://www.kvack.org/~blah/aio_plot5_nouser.png

The graph is of log2(buffersize) vs microseconds to read 700MB of file
into this buffer.  The machine used was a 4way 1MB Xeon.  The 1gb items
were done while running with no highmem support, and 4gb with highmem but
no PAE.  Of the graphs, the second is probably more interesting since it
removes the userland aio data points which squash things quite a bit.

Note that the aio code makes use of map_user_kiobuf for all access to/from
user space and avoids context switches on page cache hits.  There is also
overhead for setting up the data structures that is probably causing a lot
of the base overhead, especially in glibc; to this end I'll post updated
results from using aio syscalls directly, as well as after changing the
kernel aio read path to improve cache locality.

The plateaus visible at 2**18 and 2**20 onward would be the transition
from L2 cache to main memory bandwidth; buffer sizes less than 1 page may
result in a similar picture.  The overhead of kmaps for highmem looks to
be fairly low (~5%), and aio is ~9% at 64K to ~5% at 1MB and larger.  My
goal is to reduce aio's overhead to less than 1%.

If you want to take a peek at the aio code, you can grab it from
http://www.kvack.org/~blah/aio/aio-v2.4.0-20010123.diff .  There are a few
changes still pending, and I'll look into improving the performance with
smaller buffers over the weekend.  I'll try reducing the cache damage done
with the aio code as compared to pread, and isolating the costs of setting
up/tearing down a kiobuf versus reusing one.  To this end, I'm going to
implement aio sendfile and use the kiobuf device idea from Stephen.
Comments/thoughts/patches appreciated...  Cheers,

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
