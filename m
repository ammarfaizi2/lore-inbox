Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312896AbSDBTZ4>; Tue, 2 Apr 2002 14:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312898AbSDBTZr>; Tue, 2 Apr 2002 14:25:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8197 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312896AbSDBTZe>; Tue, 2 Apr 2002 14:25:34 -0500
Date: Tue, 2 Apr 2002 21:25:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: -aa VM splitup
Message-ID: <20020402212517.C26986@dualathlon.random>
In-Reply-To: <20020401200202.Q1331@dualathlon.random> <Pine.LNX.4.10.10204020916560.313-100000@mikeg.wen-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 09:28:51AM +0200, Mike Galbraith wrote:
> Only thing interesting during testing was that 2.4.19pre5aa1
> lost by a consistant ~15% in the move a tree around test.

I'm not sure what your problem is but I made a fast check on the
performance difference between 2.4.6 and 2.4.19pre5aa1:

2.4.19pre5aa1 mem=1200M:

time dd if=/dev/zero of=test bs=4096 count=$[1500*1024*1024/4096] ; time sync ; time dd if=/dev/zero of=test bs=4096 count=$[1500*1024*1024/4096] ; time sync
384000+0 records in
384000+0 records out

real    0m48.776s
user    0m0.380s
sys     0m11.850s

real    0m24.589s
user    0m0.000s
sys     0m0.290s
384000+0 records in
384000+0 records out

real    0m45.774s
user    0m0.330s
sys     0m12.190s

real    0m26.813s
user    0m0.010s
sys     0m0.290s

time dd if=test of=/dev/null bs=4096 count=$[1500*1024*1024/4096]; time dd if=test of=/dev/null bs=4096 count=$[1500*1024*1024/4096]
384000+0 records in
384000+0 records out

real    1m2.269s
user    0m0.250s
sys     0m12.070s
384000+0 records in
384000+0 records out

real    1m2.284s
user    0m0.240s
sys     0m12.510s

(andrew test below, just in case)

time dd if=/dev/zero of=test bs=5000 count=$[1500*1024*1024/5000] ; time sync ; time dd if=/dev/zero of=test bs=5000 count=$[1500*1024*1024/5000] ; time sync
314572+0 records in
314572+0 records out

real    0m49.273s
user    0m0.430s
sys     0m12.420s

real    0m25.064s
user    0m0.000s
sys     0m0.300s
314572+0 records in
314572+0 records out

real    0m49.567s
user    0m0.350s
sys     0m12.070s

real    0m25.618s
user    0m0.010s
sys     0m0.320s

official 2.4.6 mem=1200M:

time dd if=/dev/zero of=test bs=4096 count=$[1500*1024*1024/4096] ; time sync ; time dd if=/dev/zero of=test bs=4096 count=$[1500*1024*1024/4096] ; time sync
384000+0 records in
384000+0 records out

real    0m37.425s
user    0m0.590s
sys     0m14.900s

real    0m33.751s
user    0m0.000s
sys     0m0.100s
384000+0 records in
384000+0 records out

real    0m34.182s
user    0m0.500s
sys     0m14.780s

real    0m35.487s
user    0m0.000s
sys     0m0.160s

time dd if=test of=/dev/null bs=4096 count=$[1500*1024*1024/4096]; time dd if=test of=/dev/null bs=4096 count=$[1500*1024*1024/4096]
384000+0 records in
384000+0 records out

real    1m2.978s
user    0m0.230s
sys     0m11.330s
384000+0 records in
384000+0 records out

real    1m2.660s
user    0m0.290s
sys     0m11.050s

time dd if=/dev/zero of=test bs=5000 count=$[1500*1024*1024/5000] ; time sync ; time dd if=/dev/zero of=test bs=5000 count=$[1500*1024*1024/5000] ; time sync
314572+0 records in
314572+0 records out

real    0m37.602s
user    0m0.450s
sys     0m15.270s

real    0m36.123s
user    0m0.000s
sys     0m0.180s
314572+0 records in
314572+0 records out

real    0m36.118s
user    0m0.460s
sys     0m15.820s

real    0m33.486s
user    0m0.020s
sys     0m0.160s

As you can see the write/read raw performance is the same, dominated
only by raw disk speed. I'm not sure how can you write or read to disk
faster with 2.4.6. Also note that raw speed with total cache trashing is
quite unrelated to the VM if balance_dirty()/bdflush works sanely.

One thing that cames to mind is the fact the old 2.4.6 balance_dirty()
was passing over .ndirty buffers before breaking the loop, now we stop
much earlier, so we may take less advantage of some cpu cache doing so,
that may matter on slow cpu machines, for my box clearly doesn't matter.

Are you sure the 15% of performance you're talking about isn't your disk
that keeps writing when your workload finishes? I mean, see the sync
time, it decreases because the latest kernels have lower bdflush sync
percentages, that's normal and expected. You should take the sync time
into account too of course. If you want the level of dirty buffers in
the system to be larger you only need to tweak bdflush, the default has
to be conservative to be fair with the users that are only reading.

The difference between 2.4.6 and the latest VM code should kick in when
the VM really starts to matter.

It is possible that your read/write mixed workload gets the elevator
into the equation too. But the most important thing is that raw
read/write speed with total cache trashing is fast, and that's the case,
so whatever involvement with mixed read/write load it has to be only an
elevator thing or a bdflush tuning parameter changable via sysctl.

Andrea
