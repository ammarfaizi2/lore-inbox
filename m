Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313765AbSDPQlw>; Tue, 16 Apr 2002 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313766AbSDPQlv>; Tue, 16 Apr 2002 12:41:51 -0400
Received: from [195.223.140.120] ([195.223.140.120]:45656 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313765AbSDPQlo>; Tue, 16 Apr 2002 12:41:44 -0400
Date: Tue, 16 Apr 2002 18:41:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Moritz Franosch <jfranosc@physik.tu-muenchen.de>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
Message-ID: <20020416184154.K29747@dualathlon.random>
In-Reply-To: <20020416165358.E29747@dualathlon.random> <E16xVW9-0000Fq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 05:09:17PM +0100, Alan Cox wrote:
> > > The problem is that writing to a DVD-RAM, ZIP or MO device almost
> > > totally blocks reading from a _different_ device. Here is some data.
> 
> Yes I saw this with M/O disks, thats one reason the -ac tree doesn't adopt
> all the ll_rw_blk/elevator changes from the vanilla tree.

that should have nothing to do with the elevator. The elevator matters
within the same disk. here it's the other (fast) disks that are slower
while you write to the slow ZIP M/O DVDRAM. That is always been the
case, I remeber that since I run 2.0.25 the first time with ppa.

> > > DVD-RAM while reading from the (fast) 130GB HDD (benchmark 2) almost
> > > totally blocks the read process. Under 2.4.19-rc5, it takes 14 times
> 
> You'll see this on other things too. Large file creates seem to basically
> stall anything wanting swap

the "wanting swap" bit also depends how much anon/shm ram there is in the
system compared to clean freeable cache. With the rest of the patches
applied you should not want swap during a large file create unless
you've quite a lot of physical ram mapped in shm/anon.

> > > benchmarks 1-4, kernel 2.4.19-pre5 performed much worse than
> > > 2.4.18. The reason may be that the main throughput stems from the
> > > short moments where, for what reason whatsoever, read speed increases
> 
> Fairness, throughput, latency - pick any two..  
> 
> > Right fix is different but not suitable for 2.4.
> 
> Curious - what do you think the right fix is ?

One part of the fix is not to allow dirty buffers belonging to the
zip/M/O/DVDRAM drives to grow over 3/4% of the total freeable ram in the
system. So the rest of the 96/97% of freeable ram can be allocated
nearly atomically without blocking. And really that percentage can
depend on the user needs too. If an user needs to rewrite and rewrite
and he never goes to use more than 20% of the physical ram as cache, he
will probably want a limit of 30%, not 3/4%, even if then a malloc
requiring such 30% to be flushed to disk could take several minutes to
return. It's not a trivial problem, but at least having per-blkdev
tunings would make it much better. 60% of ram in something that writes
512bytes/sec would be totally insane for example. If something writes at
512bytes/sec we should allow at most a few pages of cache to be dirty
simultaneously. the best would be if the kernel could learn a limit with
runtime for each blkdev, the fixed 3/4% still is not very appealing.

The other side of the fix, is to rewrite the write against writes in the
BUF_DIRTY list, now even if the allocations don't block, the other async
flushes will wait those three pages to be written at 512bytes/sec,
despite the other async flushes could go to the hd in parallel at
30M/sec.

The linux vm (this is always been true since 2.0) is tuned and behaves
well with normal HD running at similar speeds, if the speed of the HD
very a lot or if the HD is dogslow, linux async flushing it's not
optimal. The new more aggressive tunings just put it at the light more,
despite other more server oriented workloads are improved because of the
faster hardware and the fact they actually take advantage of the larger
dirty cache, unlike the dd where if it would be synchronous it wouldn't
matter.

Andrea
