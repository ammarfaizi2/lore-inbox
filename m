Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282858AbRK0ILz>; Tue, 27 Nov 2001 03:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282866AbRK0ILj>; Tue, 27 Nov 2001 03:11:39 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:47365 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S282857AbRK0ILB>;
	Tue, 27 Nov 2001 03:11:01 -0500
Date: Tue, 27 Nov 2001 19:07:07 +1100
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mingo@elte.hu, velco@fadata.bg, linux-kernel@vger.kernel.org
Subject: benchmark results: Scalable page cache
Message-ID: <20011127190707.C13824@krispykreme>
In-Reply-To: <87elml4ssx.fsf@fadata.bg> <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain> <20011126.100217.112611573.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011126.100217.112611573.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> His tree is per-inode, so you'd need a fully in ram 16GB _FILE_ to get
> the bad tree search properties you describe.

Well lets pass my dbench-o-matic over the two patches.

http://samba.org/~anton/linux/pagecache_locking/

The tests were run on an old 12 way ppc64 machine. I might do the runs
again on a newer 16 way, it just takes ages to boot it.

summary.png shows an equal improvement from 8 clients through to 12
clients with either patch. Ignore the breakdown after 12 clients, I need
to look closer at what is going on there.

I was seeing larger problems with the pagecache lock on zero copy
workloads with the standard kernel. It might show up some differences in
the two approaches with that sort of workload, if I get a chance I'll do
more testing.

The dbench-o-matic gives some more detailed information as well as the
summary. For each dbench run you can get the results from the kernel
statistical profiler. For the top 40 kernel functions you can also see
the breakdown of hits (in % of total hits for that function) against
the disassembly.

eg for standard 2.4.16 and 12 clients, the __find_lock disassembly
is:

http://samba.org/~anton/linux/pagecache_locking/2.4.16/12/8.html

One hint for reading the disassembly, this is a spin lock aquisition
in ppc64:

c0000000000e38e8 b	c0000000000e3900
c0000000000e38ec mr	r1,r1
c0000000000e38f0 lwzx r11,r0,r0
c0000000000e38f4 cmpwi	r11,0
c0000000000e38f8 bne+	c0000000000e38ec
c0000000000e38fc mr	r2,r2
c0000000000e3900 lwarx r11,r0,r0
c0000000000e3904 cmpwi	r11,0
c0000000000e3908 bne-	c0000000000e38ec
c0000000000e390c stwcx.	r9,r0,r0
c0000000000e3910 bne- c0000000000e3900
c0000000000e3914 isync

If you see a large percentage on the first five instructions then
we are spending a lot of time busy spinning for a spinlock to be
dropped. Another useful tip is that hits are usually attributed to the
instruction after the offending one, because we use the return address
from the timer interrupt.

In the case of __find_lock_page we see both contention (looping over the
first five instructions) and also what looks to be cacheline ping ponging
(the high % of hits the instruction after the lwarx).

Anton
