Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311475AbSDANHd>; Mon, 1 Apr 2002 08:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311519AbSDANHY>; Mon, 1 Apr 2002 08:07:24 -0500
Received: from www.wen-online.de ([212.223.88.39]:63504 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S311475AbSDANHL>;
	Mon, 1 Apr 2002 08:07:11 -0500
Date: Mon, 1 Apr 2002 14:07:23 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
In-Reply-To: <20020401030207.N1331@dualathlon.random>
Message-ID: <Pine.LNX.4.10.10204011405360.270-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Andrea Arcangeli wrote:

> On Sun, Mar 31, 2002 at 02:26:14PM +0200, Mike Galbraith wrote:
> > #!/bin/sh
> > # testo
> > # /tmp is tmpfs
> > 
> > for i in 1 2 3 4 5
> > do
> > 	mv /test/linux-2.5.7 /tmp/.
> > 	mv /tmp/linux-2.5.7 /test/.
> > done
> 
> It would be important to see the /tmp and /test tests benchmarked
> separately, the way tmpfs and normal filesystem writes to disk is very
> different and involves different algorithms, so it's not easy to say
> which one could go wrong by looking at the global result. Just in case:
> it is very important that the tmpfs contents are exactly the same before
> starting the two tests. If you load something into /tmp before starting
> the test performance will be different due the need of additional
> swapouts.
> 
> So I would suggest moving linux-2.5.7 over two normal fs and then just
> moving it over two tmpfs, so we know what's running slower.

2.5.7.virgin

time testo (mv tree between /test and /usr/local partitions)
real    10m42.697s
user    0m5.110s
sys     1m16.240s

Bonnie -s 1000
     -------Sequential Output-------- ---Sequential Input-- --Random--
     -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
  MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
1000  7197 27.4  8557 12.0  4273  7.3  8049 40.6  9049  8.0 111.5  1.3

2.5.7.aa

time testo
real    51m17.577s
user    0m5.680s
sys     1m15.320s

Bonnie -s 1000
     -------Sequential Output-------- ---Sequential Input-- --Random--
     -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
  MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
1000  5184 19.6  5965  8.9  3081  4.4  8936 45.5  9049  8.1  98.2  1.0

Egad.  Before I gallop off to look for a merge booboo, let me show you
what I was looking for with the aa writeout changes ;-)

2.4.6.virgin

time testo
real    12m12.384s
user    0m5.280s
sys     0m54.110s

     -------Sequential Output-------- ---Sequential Input-- --Random--
     -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
  MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
1000  8377 31.3 10560 12.3  3236  5.2  7289 36.1  8974  6.7 113.3  1.0

2.4.6.flushto

time testo
real    9m5.801s
user    0m5.060s
sys     0m59.310s

Bonnie -s 1000
     -------Sequential Output-------- ---Sequential Input-- --Random--
     -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
  MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
1000 10553 37.6 11785 13.5  4174  6.5  6785 33.7  8964  6.9 115.7  1.2

	pittypatterpittypatter...

		-Mike

