Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313755AbSDPQ0R>; Tue, 16 Apr 2002 12:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313758AbSDPQ0Q>; Tue, 16 Apr 2002 12:26:16 -0400
Received: from [195.223.140.120] ([195.223.140.120]:32852 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313755AbSDPQ0P>; Tue, 16 Apr 2002 12:26:15 -0400
Date: Tue, 16 Apr 2002 18:25:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Moritz Franosch <jfranosc@physik.tu-muenchen.de>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
Message-ID: <20020416182550.J29747@dualathlon.random>
In-Reply-To: <20020416165358.E29747@dualathlon.random> <Pine.LNX.4.44L.0204161236320.16531-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 12:39:22PM -0300, Rik van Riel wrote:
> On Tue, 16 Apr 2002, Andrea Arcangeli wrote:
> > On Fri, Apr 05, 2002 at 11:04:18PM +0200, Moritz Franosch wrote:
> 
> > > The problem is that writing to a DVD-RAM, ZIP or MO device almost
> > > totally blocks reading from a _different_ device. Here is some data.
> > >
> > > nr bench read       write      2.4.18  2.4.19-rc5  expected factor
> > > 1  dd    30GB HDD   DVD-RAM    278     490         60       8.2
> > > 2  dd    120GB HDD  DVD-RAM    197     438         32       14
> > > 3  dd    30GB HDD   ZIP        158     239         60       4.0
> > > 4  dd    120GB HDD  ZIP        142     249         32       7.8
> > > 5  dd    30GB HDD   120GB HDD   87      89         60       1.5
> > > 6  dd    120GB HDD  30GB HDD    66      69         32       2.2
> > > 7  cp    30GB HDD   120GB HDD   97      77         60       1.3
> > > 8  cp    120GB HDD  30GB HDD    78      65         50       1.3
> > >
> > > The columns 2.4.18 and 2.4.19-rc5 list execution times in seconds of
> > > the respective benchmark. The column "expected" lists the time I would
> > > have expected for the respective benchmark to complete with a
> > > "perfect" kernel. The "factor" is the factor 2.4.19-rc5 is slower than
> > > a perfect kernel would be.
> 
> > The reason hd is faster is because new algorithm is much better than the
> > previous mainline code. Now the reason the DVDRAM hangs the machine
> > more, that's probably because more ram can be marked dirty with those
> > new changes (beneficial for some workload, but it stalls much more the
> > fast hd, if there's one very slow blkdev in the system). You can try
> > decrasing the percent of vm dirty in the system with:
> >
> > 	echo 2 500 0 0 500 3000 3 1 0 >/proc/sys/vm/bdflush
> 
> Judging from the performance regression above it would seem the
> new defaults suck rocks.
> 
> Can we please stop optimising Linux for a single workload benchmark
> and start tuning it for the common case of running multiple kinds
> of applications and making sure one application can't mess up the
> others ?
> 
> Personally I couldn't care less if my tar went 30% faster if it
> meant having my desktop unresponsive for the whole time.

Your desktop is not unresponsive for the whole time. The problem happens
only under a flood to DVD and ZIP and as you can see above 2.4.18 sucks
rocks for such a workload too in the first place and that's nothing new,
not a problem introduced by my changes, more detailed explanation
follows.

DVDRAM and ZIP writes are dogslow and for such a slow blkdev allowing
60% of freeable ram to be locked in dirty buffers, is exactly like if
you have to swapout on top of a DVDRAM instead of on top of a 40M/sec hd
while allocating memory.  You will have to wait minutes before such 60%
of freeable ram is flushed to disk. Zip and DVDRAM write with a bandwith
lower than 1M/sec, swapping out on them clearly can lead a malloc to
take minutes (having to flush dirty data as said is equivalent to
swapout on them). OTOH if you don't reach the 60% the DVDRAM and ZIP
will behave better with the new changes, it's the cp /dev/zero /dvdram
that cause you to wait the 100 seconds at the next malloc.

So if you are used to cp /dev/zero /dvdram you should definitely reduce
the max dirty amount of freeable ram to 3%, and that's what the above bdflush
tuning does. 

The only way to avoid you to set the nfract levels, is to have them per
blkdev but I don't see it as a 2.4 requirement but it would be nice to
have it for 2.5 at least.

This is an issue of swapping on a very slow HD, you will be slow be
sure of that, with mainline too, with the new changes even more becaue
you will have to swapout more. Reducing the bdflush is equivalent to swap
less. If the HD would be as fast as memory we should swap more. The
slower the HD the less we must swap to be fast. It's not that we are
optimizing for a single workload, but it's that it's not possible to
generate with math the most efficient number that will lead to the max
possible performance in terms of performance while still providing good
latency, the current heuristic is tuned for a fairly normal hd, so
slower hd requires and always required in previous mainline too, the
tuning of the VM to avoid swapping out too much if the HD runs at less
than 1M/sec.

Not to tell the writes to a slow HD will hang all the writes of the fast
HD, and that's another basic design issue that is completly unchanged
between the two kernels, but that could be completly rewritten to allow
a fast HD to write at max speed while the slow HD writes at max speed.
This is definitely not possible right now, the fast HD will write seldom
in small chunks in such a workload.

You should acknowledge the new changes and defaults are better, they
even are better at showing basic design problems of the kernel with HD
with performance much slower than memory than the normal hd. Just trying
to hide those design problems by setting a default of 3% would be wrong,
doing that would lead to your production desktop and servers to be much
slower. If it's slow only during the backup to zip or dvdram it's not a
showstopper, no failures, just higher write and read latencies and
higher allocation latencies than when you run cp /dev/zero on a normal
HD.

Andrea
