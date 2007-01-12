Return-Path: <linux-kernel-owner+w=401wt.eu-S932348AbXALRh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXALRh4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbXALRh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:37:56 -0500
Received: from lucidpixels.com ([66.45.37.187]:50944 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbXALRhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:37:55 -0500
Date: Fri, 12 Jan 2007 12:37:48 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Michael Tokarev <mjt@tls.msk.ru>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1:
 (211MB/s read & 195MB/s write)
In-Reply-To: <Pine.LNX.4.64.0701120934260.21164@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0701121236470.3840@p34.internal.lan>
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan>
 <45A794B4.5020608@tls.msk.ru> <Pine.LNX.4.64.0701120934260.21164@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RAID 5 TWEAKED: 1:06.41 elapsed @ 60% CPU

This should be 1:14 not 1:06(was with a similarly sized file but not the 
same) the 1:14 is the same file as used with the other benchmarks.  and to 
get that I used 256mb read-ahead and 16384 stripe size ++ 128 
max_sectors_kb (same size as my sw raid5 chunk size)

On Fri, 12 Jan 2007, Justin Piszcz wrote:

> 
> 
> On Fri, 12 Jan 2007, Michael Tokarev wrote:
> 
> > Justin Piszcz wrote:
> > > Using 4 raptor 150s:
> > > 
> > > Without the tweaks, I get 111MB/s write and 87MB/s read.
> > > With the tweaks, 195MB/s write and 211MB/s read.
> > > 
> > > Using kernel 2.6.19.1.
> > > 
> > > Without the tweaks and with the tweaks:
> > > 
> > > # Stripe tests:
> > > echo 8192 > /sys/block/md3/md/stripe_cache_size
> > > 
> > > # DD TESTS [WRITE]
> > > 
> > > DEFAULT: (512K)
> > > $ dd if=/dev/zero of=10gb.no.optimizations.out bs=1M count=10240
> > > 10240+0 records in
> > > 10240+0 records out
> > > 10737418240 bytes (11 GB) copied, 96.6988 seconds, 111 MB/s
> > []
> > > 8192K READ AHEAD
> > > $ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
> > > 10240+0 records in
> > > 10240+0 records out
> > > 10737418240 bytes (11 GB) copied, 64.9454 seconds, 165 MB/s
> > 
> > What exactly are you measuring?  Linear read/write, like copying one
> > device to another (or to /dev/null), in large chunks?
> Check bonnie benchmarks below.
> > 
> > I don't think it's an interesting test.  Hint: how many times a day
> > you plan to perform such a copy?
> It is a measurement of raw performance.
> > 
> > (By the way, for a copy of one block device to another, try using
> > O_DIRECT, with two dd processes doing the copy - one reading, and
> > another writing - this way, you'll get best results without huge
> > affect on other things running on the system.  Like this:
> > 
> >  dd if=/dev/onedev bs=1M iflag=direct |
> >  dd of=/dev/twodev bs=1M oflag=direct
> > )
> Interesting, I will take this into consideration-- however, an untar test 
> shows a 2:1 improvement, see below.
> > 
> > /mjt
> > 
> 
> Decompress/unrar a DVD-sized file:
> 
> On the following RAID volumes with the same set of [4] 150GB raptors:
> 
> RAID  0] 1:13.16 elapsed @ 49% CPU
> RAID  4] 2:05.85 elapsed @ 30% CPU 
> RAID  5] 2:01.94 elapsed @ 32% CPU
> RAID  6] 2:39.34 elapsed @ 24% CPU
> RAID 10] 1:52.37 elapsed @ 32% CPU
> 
> RAID 5 Tweaked (8192 stripe_cache & 16384 setra/blockdev)::
> 
> RAID 5 TWEAKED: 1:06.41 elapsed @ 60% CPU
> 
> I did not tweak raid 0, but seeing how RAID5 tweaked is faster than RAID0 
> is good enough for me :)
> 
> RAID0 did 278MB/s read and 317MB/s write (by the way)
> 
> Here are the bonnie results, the times alone speak for themselves, from 8 
> minutes to min and 48-59 seconds.
> 
> # No optimizations:
> # Run Benchmarks
> Default Bonnie: 
> [nr_requests=128,max_sectors_kb=512,stripe_cache_size=256,read_ahead=1536]
> default_run1,4000M,42879,98,105436,19,41081,11,46277,96,87845,15,639.2,1,16:100000:16/64,380,4,29642,99,2990,18,469,5,11784,40,1712,12
> default_run2,4000M,47145,99,108664,19,40931,11,46466,97,94158,16,634.8,0,16:100000:16/64,377,4,16990,56,2850,17,431,4,21066,71,1800,13
> default_run3,4000M,43653,98,109063,19,40898,11,46447,97,97141,16,645.8,1,16:100000:16/64,373,4,22302,75,2793,16,420,4,16708,56,1794,13
> default_run4,4000M,46485,98,110664,20,41102,11,46443,97,93616,16,631.3,1,16:100000:16/64,363,3,14484,49,2802,17,388,4,25532,86,1604,12
> default_run5,4000M,43813,98,109800,19,41214,11,46457,97,92563,15,635.1,1,16:100000:16/64,376,4,28990,95,2827,17,388,4,22874,76,1817,13
> 
> 169.88user 44.01system 8:02.98elapsed 44%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (6major+1102minor)pagefaults 0swaps
> 161.60user 44.33system 7:53.14elapsed 43%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (13major+1095minor)pagefaults 0swaps
> 166.64user 45.24system 8:00.07elapsed 44%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (13major+1096minor)pagefaults 0swaps
> 161.90user 44.66system 8:00.85elapsed 42%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (13major+1094minor)pagefaults 0swaps
> 167.61user 44.12system 8:03.26elapsed 43%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (13major+1092minor)pagefaults 0swaps
> 
> 
> All optimizations [bonnie++] 
> 
> 168.08user 46.05system 5:55.13elapsed 60%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (16major+1092minor)pagefaults 0swaps
> 162.65user 46.21system 5:48.47elapsed 59%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (7major+1101minor)pagefaults 0swaps
> 168.06user 45.74system 5:59.84elapsed 59%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (7major+1102minor)pagefaults 0swaps
> 168.00user 46.18system 5:58.77elapsed 59%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (13major+1095minor)pagefaults 0swaps
> 167.98user 45.53system 5:56.49elapsed 59%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (5major+1101minor)pagefaults 0swaps
> 
> c6300-optimized:4000M,43976,99,167209,29,73109,22,43471,91,208572,40,511.4,1,16:100000:16/64,1109,12,26948,89,2469,14,1051,11,29037,97,2167,16
> c6300-optimized:4000M,47455,99,190212,35,70402,21,43167,92,206290,40,503.3,1,16:100000:16/64,1071,11,29893,99,2804,16,1059,12,24887,84,2090,16
> c6300-optimized:4000M,43979,99,172543,29,71811,21,41760,87,201870,39,498.9,1,16:100000:16/64,1042,11,30276,99,2800,16,1063,12,29491,99,2257,17
> c6300-optimized:4000M,43824,98,164585,29,73470,22,43098,90,207003,40,489.1,1,16:100000:16/64,1045,11,30288,98,2512,15,1018,11,27365,92,2097,16
> c6300-optimized:4000M,44003,99,194250,32,71055,21,43327,91,196553,38,505.8,1,16:100000:16/64,1031,11,30278,98,2474,14,1049,12,28068,94,2027,15
> 
> txt version of optimized results:
> 
> Version  1.03      ------Sequential Output------ --Sequential Input- 
> --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
> --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
> /sec %CP
> c6300-optimiz 47455    99 190212    35 70402    21 43167    92 206290    
> 40 503.3     1
> c6300-optimiz 43979    99 172543    29 71811    21 41760    87 201870    
> 39 498.9     1
> c6300-optimiz 43824    98 164585    29 73470    22 43098    90 207003    
> 40 489.1     1
> c6300-optimiz 44003    99 194250    32 71055    21 43327    91 196553    
> 38 505.8     1
> 
> 
