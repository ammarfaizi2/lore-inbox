Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWEaVuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWEaVuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWEaVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:50:55 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:13218 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965185AbWEaVuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:50:54 -0400
Date: Wed, 31 May 2006 23:50:21 +0200
From: Voluspa <lista1@comhem.se>
To: Valdis.Kletnieks@vt.edu
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-Id: <20060531235021.41a58425.lista1@comhem.se>
In-Reply-To: <200605301649.k4UGnooZ004266@turing-police.cc.vt.edu>
References: <20060530053631.57899084.lista1@comhem.se>
	<200605301649.k4UGnooZ004266@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 12:49:50 -0400 Valdis.Kletnieks wrote:
> On Tue, 30 May 2006 05:36:31 +0200, Voluspa said:
> > On 2006-05-30 0:37:57 Wu Fengguang wrote:
> > > On Mon, May 29, 2006 at 03:44:59PM -0400, Valdis Kletnieks wrote:
[...]
> Damn, this is a lot harder to benchmark than the sort of microbenchmarks
> we usually see around here. :)

I don't even know what a microbenchmark is, but 'cp' and its higher-level
equivalents is such a frequent operation that I always begin any test
there.

[...] [Correction, should be: 'click-read-pause, click-read-pause etc']
> > later) there's a slow 'click-read-click-read-click-etc' during the
> > same movie as the head travels _somewhere_ to rest(?) between reads.
> 
> For my usage patterns, this is a feature, not a bug. As mentioned before,
> on this machine anything that reduces the number of seeks is a Good Thing.
> 
> > Distracting in silent sequences, and perhaps increased disk wear/tear.
> 
> It would be increased wear/tear only if the disk was idle long enough to
> spin down. Especially for video, the read-ahead needed to let the disk spin
> down (assuming a sane timeout for that) would be enormous. :)

:-) I was thinking more in terms of disk head _arm_ wear. Somehow there's a
picture in my head of the arm swinging back to a rest position at an outer
(or inner?) "safe" disk track if read/write operations are delayed too much.
And therefore I associate a 'click' with the arm swinging back into action.
Normal quick read/write arm movement noise is distinctly different - in my
uninformed user ears.

I haven't adjusted the readahed size yet, but instead performed a series of
real-world usage tests.

Conclusion: On _this_ machine, with _these_ operations, Adaptive Readahead
in its current incarnation and default settings is a _loss_.

Patch version:
http://web.comhem.se/~u46139355/storetmp/adaptive-readahead-v14-linux-2.6.17-rc5-part-01to28of32-and-update-01to04of04-and-saner-CDVD-medium-error-handling.patch

Relevant hardware:
AMD Athlon 64 Processor 3400+ (2200 MHz top speed) L1 I Cache: 64K (64 
bytes/line), D cache 64K (64 bytes/line), L2 Cache: 1024K (64 bytes/line).
VIA K8M800 chipset with VT8235 south. Kingmax 2x1GB DDR-333MHz SO-DIMM memory.
Hitachi Travelstar 7K100 (HTS721010G9AT00) 100GB 7200RPM Parallel-ATA disk,
http://www.hitachigst.com/hdd/support/7k100/7k100.htm acoustic management
value was set to 254 (fast/"noisy") at delivery.

Soft system:
Is extremely lean and simple. Pure 64bit compiled in a lfs-ish way almost
exactly 1 year ago. No desktop, just a wm (which wasn't even launched in
these tests). Toolchain glibc-2.3.5 (nptl), binutils-2.16.1, gcc-3.4.4

Filesystem:
Journaled ext3 with default mount (ordered data mode) and noatime.

Kernels:
loke:sleipner:~$ ls -l /boot/kernel-2.6.17-rc5*
1440 -rw-r--r--  1 root root 1469211 May 30 02:25 /boot/kernel-2.6.17-rc5
1444 -rw-r--r--  1 root root 1470540 May 30 19:07 /boot/kernel-2.6.17-rc5-ar

All tests were performed as the root user from a machine standstill "cold
boot" for each iteration and prepared for a 'console login - immediate run'
ie. eventual previous output deleted/reset.

_Massive READ_

[/usr had some 490000 files]

"cd /usr ; time find . -type f -exec md5sum {} \;"

2.6.17-rc5 ------- 2.6.17-rc5-ar

real 21m21.009s -- 21m37.663s
user 3m20.784s  -- 3m20.701s
sys  6m34.261s  -- 6m41.735s

I had planned to run this at least three times, but didn't realize I had
12 compiled kernel trees and 3 uncompiled there... So, a one-shot had to
do. But it's still significant.

_READ/WRITE_

[255 .tga files, each is 1244178 bytes]
[1 .wav file which is 1587644 bytes]
[movie becomes 573298 bytes ~9s long]

"time mencoder -ovc lavc -lavcopts aspect=16/9 mf://picsave/kreation/03-logo-joined/*.tga -oac lavc -audiofile kreation-files/kreation-logo-final.wav -o logo-final-widescreen-speedtest.avi"

2.6.17-rc5

real 0m10.164s 0m10.224s 0m10.141s
user 0m3.301s  0m3.304s  0m3.297s
sys  0m1.103s  0m1.097s  0m1.082s

2.6.17-rc5-ar

real 0m10.831s 0m10.816s 0m10.747s
user 0m3.319s  0m3.313s  0m3.324s
sys  0m1.081s  0m1.099s  0m1.042s

A 0.6s slowdown might not seem as such a big deal, but this is on a 9s
movie! Furthermore, the test was conducted on the / root partition which
resides on hda2. Subtracting the 8GB hda1 and the occupied 1.2GB of hda2
places us 9.2GB in from the disk edge (assuming 1 platter). I did a
one-shot test of this movie on hda3 - closes to the spindle - which all
in all gives a distance of ~95GB:

2.6.17-rc5 ------ 2.6.17-rc5-ar

real 0m16.134s -- 0m17.456s
user 0m3.311s  -- 0m3.312s
sys  0m1.111s  -- 0m1.135s

Wow. If nothing else, these tests have made me rethink my partitioning
scheme. I've used the same layout since xx-years ago when proximity of
swap-usr-home on those slow disks really made a difference. And since
I don't touch swap in normal operation nowadays... Power to the Edge!

_Geek usage_

[Kernel compile]
[CONFIG_REORDER "Processor type and features -> Function reordering" adds
ca 30s here]
[Note: I made a mistake by booting the -ar kernel first, and also didn't
alternate like I should have. This was the first set of tests and chip
temperature rise seem to slow things down. Physics reason above my head]

"time make"

2.6.17-rc5-ar

real 5m3.654s  5m3.787s  5m4.390s  5m4.991s
user 4m17.595s 4m17.580s 4m17.701s 4m18.043s
sys  0m31.551s 0m31.506s 0m31.368s 0m31.563s

2.6.17-rc5

real 5m4.606s  5m5.798s  5m4.684s  5m4.508s
user 4m18.586s 4m19.183s 4m19.111s 4m17.799s
sys  0m31.241s 0m31.482s 0m31.278s 0m31.610s

Any difference here should really be considered noise. The file read/write
is too infrequent and slow to really measure.

_Caveat and preemptive Mea Culpa_

The patching of 2.6.17-rc5 has neither been approved or verified as to
its correctness. The kernel compiles without errors and the new
/proc/sys/kernel/ sysctl readahead_ratio and readahead_hit_rate turn up
with the default 50 and 1. This is however not a proof of total parity
with the official -mm patch-set.

Mvh
Mats Johannesson
--
