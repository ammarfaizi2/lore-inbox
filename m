Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311583AbSDASCp>; Mon, 1 Apr 2002 13:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311839AbSDASCg>; Mon, 1 Apr 2002 13:02:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30066 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311583AbSDASCZ>; Mon, 1 Apr 2002 13:02:25 -0500
Date: Mon, 1 Apr 2002 20:02:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
Message-ID: <20020401200202.Q1331@dualathlon.random>
In-Reply-To: <20020401030207.N1331@dualathlon.random> <Pine.LNX.4.10.10204011405360.270-100000@mikeg.wen-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2002 at 02:07:23PM +0200, Mike Galbraith wrote:
> On Mon, 1 Apr 2002, Andrea Arcangeli wrote:
> 
> > On Sun, Mar 31, 2002 at 02:26:14PM +0200, Mike Galbraith wrote:
> > > #!/bin/sh
> > > # testo
> > > # /tmp is tmpfs
> > > 
> > > for i in 1 2 3 4 5
> > > do
> > > 	mv /test/linux-2.5.7 /tmp/.
> > > 	mv /tmp/linux-2.5.7 /test/.
> > > done
> > 
> > It would be important to see the /tmp and /test tests benchmarked
> > separately, the way tmpfs and normal filesystem writes to disk is very
> > different and involves different algorithms, so it's not easy to say
> > which one could go wrong by looking at the global result. Just in case:
> > it is very important that the tmpfs contents are exactly the same before
> > starting the two tests. If you load something into /tmp before starting
> > the test performance will be different due the need of additional
> > swapouts.
> > 
> > So I would suggest moving linux-2.5.7 over two normal fs and then just
> > moving it over two tmpfs, so we know what's running slower.
> 
> 2.5.7.virgin
> 
> time testo (mv tree between /test and /usr/local partitions)
> real    10m42.697s
> user    0m5.110s
> sys     1m16.240s
> 
> Bonnie -s 1000
>      -------Sequential Output-------- ---Sequential Input-- --Random--
>      -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
>   MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
> 1000  7197 27.4  8557 12.0  4273  7.3  8049 40.6  9049  8.0 111.5  1.3
> 
> 2.5.7.aa
> 
> time testo
> real    51m17.577s
> user    0m5.680s
> sys     1m15.320s
> 
> Bonnie -s 1000
>      -------Sequential Output-------- ---Sequential Input-- --Random--
>      -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
>   MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
> 1000  5184 19.6  5965  8.9  3081  4.4  8936 45.5  9049  8.1  98.2  1.0
> 
> Egad.  Before I gallop off to look for a merge booboo, let me show you
> what I was looking for with the aa writeout changes ;-)
> 
> 2.4.6.virgin
> 
> time testo
> real    12m12.384s
> user    0m5.280s
> sys     0m54.110s
> 
>      -------Sequential Output-------- ---Sequential Input-- --Random--
>      -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
>   MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
> 1000  8377 31.3 10560 12.3  3236  5.2  7289 36.1  8974  6.7 113.3  1.0
> 
> 2.4.6.flushto
> 
> time testo
> real    9m5.801s
> user    0m5.060s
> sys     0m59.310s
> 
> Bonnie -s 1000
>      -------Sequential Output-------- ---Sequential Input-- --Random--
>      -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
>   MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
> 1000 10553 37.6 11785 13.5  4174  6.5  6785 33.7  8964  6.9 115.7  1.2
> 
> 	pittypatterpittypatter...

comparing 2.4 with 2.5 is a bit unfair, can you try 2.4.19pre5aa1
first? Note that you didn't applied all the vm patches, infact I've no
idea how they apply to 2.5 in the first place (I assume they applied
cleanly).

Also it would be interesting to know how much memory you have in use
before starting the benchmark, it maybe you're triggering some swap
because the VM understand lots of your mappings are unused and that
so you're swapping out during the I/O benchmark because of that. the
anon pages in the lru are meant exactly for that purpose. If you want a
vm that never ever swaps during an I/O benchmark all mapped pages should
not be considered by the vm until we run out of unmapped pages, it's
quite equivalent to raising vm_mapped_ratio to 10000, you can try with
vm_mapped_ratio set to 10000 too infact.

Andrea
