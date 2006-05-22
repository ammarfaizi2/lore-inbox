Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWEVWne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWEVWne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWEVWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:43:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25048 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751286AbWEVWnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:43:33 -0400
Date: Tue, 23 May 2006 08:43:09 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: XFS write speed drop
Message-ID: <20060523084309.A239136@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr> <20060522105326.A212600@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Mon, May 22, 2006 at 02:21:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Mon, May 22, 2006 at 02:21:48PM +0200, Jan Engelhardt wrote:
> I shuffled a bit in the source code and the word 'order' is quite often 
> around 'barrier', so I thought the 'barrier' option makes the IO 
> scheduler strictly ordered, that is, write log first, then data. (like 

Not quite, theres an explanation here:
http://oss.sgi.com/projects/xfs/faq.html#wcache

> >Can you send the benchmark results themselves please?  (as in,
> >the test(s) you've run that lead you to see 6-8x, and the data
> >those tests produced).  Also, xfs_info output, and maybe list
> >the device driver(s) involved here too.

Thanks!

> xfs_info
> ========
> 14:20 shanghai:/root # xfs_info /
> meta-data=/dev/hda3              isize=256    agcount=19, agsize=462621 blks
>          =                       sectsz=512   attr=1
> data     =                       bsize=4096   blocks=8586742, imaxpct=25
>          =                       sunit=0      swidth=0 blks, unwritten=1
> naming   =version 2              bsize=4096  
> log      =internal               bsize=4096   blocks=3614, version=1
>          =                       sectsz=512   sunit=0 blks
> realtime =none                   extsz=65536  blocks=0, rtextents=0
> 14:20 shanghai:/root # xfs_info /D
> meta-data=/dev/hdc2              isize=256    agcount=16, agsize=3821963 blks
>          =                       sectsz=512   attr=1
> data     =                       bsize=4096   blocks=61151408, imaxpct=25
>          =                       sunit=0      swidth=0 blks, unwritten=1
> naming   =version 2              bsize=4096  
> log      =internal               bsize=4096   blocks=29859, version=1
>          =                       sectsz=512   sunit=0 blks
> realtime =none                   extsz=65536  blocks=0, rtextents=0
> ...
> Script started on Mon May 22 15:32:29 2006
> 15:32 (none):~ # mount /dev/hdc2 /D -o barrier
> 15:32 (none):~ # df -Th / /D
> Filesystem    Type    Size  Used Avail Use% Mounted on
> /dev/hda3      xfs     33G  6.7G   27G  21% /
> /dev/hdc2      xfs    234G  142G   92G  61% /D

> A small nitpick BTW, the barrier flag is not listed in /proc/mounts.

Its the default, and so we don't list that.  Quirk of the code I guess,
we could add code to distinguish default from requested but it doesn't
seem worth it really.

> hda is always in nobarrier mode.
> <6>hda: cache flushes not supported
> <6>hdc: cache flushes supported
> <5>Filesystem "hda3": Disabling barriers, not supported by the underlying
> device
> hdc can do barriers if wanted.
> 
> CASE 1: Copying from one disk to another
> ========================================
> Copying a compiled 2.6.17-rc4 tree; 306907 KB in 28566 files in 2090
> directories.

OK, we can call this a metadata intensive workload - lots of small
files, lots of creates.  Barriers will hurt the most here, as we'd
already have been log I/O bound most likely, and I'd expect barriers
to only slow that further.

> 15:33 (none):/tmp # time rsync -PHSav kernel-source/ /D/kernel-0/ >/dev/null
> real	7m31.776s
> user	0m7.030s
> sys	0m14.450s

versus:

> 15:42 (none):/tmp # rsync -PHSav kernel-source/ /D/kernel-1/ >/dev/null
> real	2m14.401s
> user	0m7.290s
> sys	0m14.900s

Yep, note the user/sys shows no change, we're basically IO bound in
both tests, and barriers are hurting (as expected).

You may be able to combat this by switching to version 2 log format
(see the xfs_db version command in the _very_ latest xfs_db, as of a
few days ago, which allows this switch to be made on an unmounted fs).
Then you will be able to use larger incore log buffers, and this
should reduce the impact the barriers have (fewer, larger log IOs, so
fewer barriers).

> CASE 2: Removing
> ================
> Remove the copies we created in case 1.
> 
> 15:45 (none):/tmp # mount /dev/hdc2 /D -o barrier
> 15:45 (none):/D # time rm -Rf kernel-0
> real	3m31.901s
> user	0m0.050s
> sys	0m3.140s

versus:

> 15:49 (none):/ # mount /dev/hdc2 /D -o nobarrier
> 15:49 (none):/D # time rm -Rf kernel-1
> 
> real	0m53.471s
> user	0m0.070s
> sys	0m1.990s
> 15:50 (none):/D # cd /
> 15:50 (none):/ # umount /D

Also metadata intensive, of course.  All the same issues as above,
and the same techniques should be used to address it.

Odd that the system time jumped here.  Roughly the same decrease in
performance though (3-4x).

> CASE 3: Copying to the same disk
> ================================
> Copy a file from hdc2 to hdc2. The result is _extremely_ interesting. So the
> 'barrier' thing is only relevant for large sets of files, it seems.

Its consistent, and easily understood however...

> 15:50 (none):/ # mount /dev/hdc2 /D -o barrier
> 15:50 (none):/D/Video # ls -l The*
> -rw-r--r--  1 jengelh users 6861772800 Mar 17 23:02 TLK3.iso
> 15:50 (none):/D/Video # time cp TLK3.iso ../tlk-0.iso
> real	8m1.051s
> user	0m0.670s
> sys	0m41.120s

versus:

> 15:59 (none):/ # mount /dev/hdc2 /D -o nobarrier
> 15:59 (none):/D/Video # time cp TLK3.iso ../tlk-1.iso
> real	7m53.275s
> user	0m0.560s
> sys	0m40.010s

This one is a file throughput workload, and so there are far fewer
metadata updates involved here.  This means far fewer barrier
operations (far fewer log writes), so we should expect the results
to be as they are - slightly worse with barriers enabled, nothing
drastic though.

So, I agree, you're seeing the cost of write barriers here, but I
don't see anything unexpected (unfortunately for you, I guess).
The FAQ entry above will explain why they're enabled by default.
Try the v2 log change I suggested, hopefully that will mitigate
the problem somewhat.  Alternatively, buy some decent hardware if
you're after performance. ;)

cheers.

-- 
Nathan
