Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287183AbSALQbV>; Sat, 12 Jan 2002 11:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSALQbC>; Sat, 12 Jan 2002 11:31:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:42346 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287173AbSALQa7>; Sat, 12 Jan 2002 11:30:59 -0500
Date: Sat, 12 Jan 2002 17:30:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writeout in recent kernels/VMs poor compared to last -ac
Message-ID: <20020112173018.Q1482@inspiron.school.suse.de>
In-Reply-To: <009e01c19b7c$463457d0$02c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <009e01c19b7c$463457d0$02c8a8c0@kroptech.com>; from akropel1@rochester.rr.com on Sat, Jan 12, 2002 at 10:17:39AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 10:17:39AM -0500, Adam Kropelin wrote:
> I recently began regularly transferring large (600 MB+) files to my
> Linux-based fileserver and have noticed what I would characterize as poor
> writeout behavior under this load. I've done a bit of comparison testing
> which may help reveal the problem better.
> 
> Disclaimer: I did not choose this test because it is scientific or stresses
> the system in any particular way. I use it because it's an operation which I
> perform frequently and so the faster it goes, the broader I smile. This may
> be an entirely inappropriate load to optimize for, and if so I understand.
> 
> Test consisted of FTPing in (Linux was the destination) a 650 MB file and
> timing the transfer (from the client's perspective) which capturing "vmstat
> 1" output on the server. Server hardware is Dual PPro 200, 160 MB RAM, 512
> MB swap, destination filesystem is VFAT[0] on cpqarray partition on a RAID5
> logical drive. Root and swap are not on the cpqarray.
> 
> Here are my results (average of 2 runs, each from a clean reboot with all
> unneeded services disabled):
> 
> 2.4.17: 6:52
> 2.4.17-rmap11a: 6:53
> 2.4.18-pre2aa2: 7:10
> 2.4.13-ac7: 5:30 (!)
> 2.4.17 with cpqarray driver update from -ac: 6:30
> 
> The last test was just to see if -ac's better performance had anything to do
> with the driver update. Apparently it had little or nothing to do with it.
> 
> The vmstat output is very revealing. All tests except for -ac show a strong
> oscillation on the blocks out (this is a representative sample from stock
> 2.4.17 but the other recent kernels show essentially the same behavior):
> 
>    procs                      memory    swap          io     system
> cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
> id
>  0  1  1      0   4408   2712 118756   0   0     0     0  109    16   0   0
> 100
>  0  1  1      0   4436   2716 118724   0   0     1  3913  287    13   0   8
> 92
>  0  1  0      0   4436   2716 118724   0   0     0     0  118    11   0   0
> 100
>  0  0  0      0   4352   2724 118816   0   0     8     0 3639   203   2  28
> 70
>  0  0  0      0   4420   2736 118752   0   0    11     0 4530   259   0  33
> 67
>  0  0  0      0   4348   2744 118816   0   0    10     0 4273   245   0  42
> 58
>  1  0  0      0   4376   2756 118772   0   0    11     0 4551   246   1  39
> 60
>  0  1  1      0   4364   2760 118724   0   0     4  6730 1710    93   1  19
> 80
>  0  1  1      0   4364   2760 118724   0   0     0     0  108     9   0   0
> 100
>  0  1  1      0   4364   2760 118724   0   0     0  3667  117     9   0   2
> 98
>  0  1  1      0   4364   2760 118724   0   0     0     0  125     8   0   0
> 100
>  1  0  1      0   4364   2760 118724   0   0     0  3819  124    10   0   2
> 98
>  0  1  1      0   4372   2760 118704   0   0     0  2055  195    10   0   5
> 95
>  0  1  1      0   4372   2760 118704   0   0     0     0  120     6   0   0
> 100
>  0  1  1      0   4408   2760 118668   0   0     0  2415  203    16   0   4
> 96
>  0  1  1      0   4472   2760 118608   0   0     0  4321  280    18   1   6
> 93
>  0  2  1      0   4468   2760 118608   0   0     0     0  112     8   0   0
> 100
>  0  1  1      0   4352   2760 118724   0   0     1  3232  227     9   0  10
> 90
>  0  1  1      0   4352   2760 118724   0   0     0     0  108     8   0   0
> 100
>  0  0  0      0   4440   2768 118696   0   0     7     0 3233   179   1  25
> 74
>  1  0  0      0   4448   2776 118680   0   0    11     0 4417   253   0  36

I think you simply want to trigger the soft-bdflush event earlier, with
-aa something like this may do the trick:

	echo 5 500 64 256 500 3000 60 2 0 > /proc/sys/vm/bdflush

this way you'll wakeup as soon as 5% of the 118mbytes (+ free memory,
none in this case) are dirty, and bdflush will stop as soon as the level
is back to 2% (then kupdate will take care of the 2%). Those suggested
values may be too strict but this way you should get the idea if it
helps somehow or not :)

Andrea
