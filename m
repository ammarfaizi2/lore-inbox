Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284958AbRLMTPu>; Thu, 13 Dec 2001 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284917AbRLMTPb>; Thu, 13 Dec 2001 14:15:31 -0500
Received: from mustard.heime.net ([194.234.65.222]:58591 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284857AbRLMTPS>; Thu, 13 Dec 2001 14:15:18 -0500
Date: Thu, 13 Dec 2001 20:14:53 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] RAID sub system
In-Reply-To: <Pine.LNX.4.33.0112131354490.15231-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0112132003280.27508-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > do did you actually try this with a bunch of parallel dd's?
> >
> > I just did now. Same result:
> >
> > # vmstat 2
> >  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> >  0 200  1   1676   3200   3012 786004   0 292 42034   298  791   745   4  29  67
> >  0 200  1   1676   3308   3136 785760   0   0 44304     0  748   758   3  15  82
> >  0 200  1   1676   3296   3232 785676   0   0 44236     0  756   710   2  23  75
> >  0 200  1   1676   3304   3356 785548   0   0 38662    70  778   791   3  19  78
> >  0 200  1   1676   3200   3456 785552   0   0 33536     0  693   594   3  13  84
> >  1 200  0   1676   3224   3528 785192   0   0 35330    24  794   712   3  16  81
> >  0 200  0   1676   3304   3736 784324   0   0 30524    74  725   793  12  14  74
> >  0 200  0   1676   3256   3796 783664   0   0 29984     0  718   826   4  10  86
> >  0 200  0   1676   3288   3868 783592   0   0 25540   152  763   812   3  17  80
> >  0 200  0   1676   3276   3908 783472   0   0 22820     0  693   731   0   7  92
> >  0 200  0   1676   3200   3964 783540   0   0 23312     6  759   827   4  11  85
> >  0 200  0   1676   3308   3984 783452   0   0 17506     0  687   697   0  11  89
> >  0 200  0   1676   3388   4012 783888   0   0 14512     0  671   638   1   5  93
> >  0 200  0   2188   3208   4048 784156   0 512 16104   548  707   833   2  10  88
> >  0 200  0   3468   3204   4048 784788   0  66  8220    66  628   662   0   3  96
> >  0 200  0   3468   3296   4060 784680   0   0  1036     6  687   714   1   6  93
> >  0 200  0   3468   3316   4060 784668   0   0  1018     0  613   631   1   2  97
> >  0 200  0   3468   3292   4060 784688   0   0  1034     0  617   638   0   3  97
> >  0 200  0   3468   3200   4068 784772   0   0  1066     6  694   727   2   4  94
>
> so help me out here a little.   the first dozen or so lines look good,
> but obviously slowing down (which is a little odd).  then at line -6,
> the VM freaks, tries swapping out, and everything goes to sleep.
> it's the going to sleep you're worried about, right?

Yes. I really need all available I/O here, not nasty bugs.

hm

trying to time the problem:

# init 6
...
# free
             total       used       free     shared    buffers     cached
Mem:        899712      75576     824136          0       4836      29408
-/+ buffers/cache:      41332     858380
Swap:       674720          0     674720
# dd-test ; vmstat -n 2 > vmstat &
# tail -f vmstat
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 200  0      0 767440   5036  36616   0   0   565   153 4337   276   9  20  71
 0 200  0      0 733012   5412  69180   0   0 16324     0  603   628   0   6  94
 0 200  0      0 667196   5428 132408   0   0 31488    56  678   530   1  12  87
 0 200  0      0 600792   5580 196472   0   0 32114     0  683   536   2  10  88
 0 200  0      0 528956   5616 265956   0   0 34708    30  678   482   0  15  85
 0 200  0      0 451496   5724 340508   0   0 37338     0  724   640   1  16  82
 0 200  0      0 383020   5936 406512   0   0 33096     8  699   689   2  11  87
 0 200  0      0 301368   6032 485432   0   0 39464     0  726   522   2  15  83
 0 200  0      0 216412   6124 567552   0   0 41092     0  698   613   2  17  81
 0 200  0      0 131364   6248 649732   0   0 41162     8  722   701   2  18  80
 0 200  0      0  52740   6372 725696   0   0 38028     0  721   461   2  14  84
 0 200  1   2676   3264   2944 778932   0 308 44816   380  766   804   0  23  76
 0 200  1   2676   3272   3032 778844   0   0 45562     0  764   642   2  17  81
 0 200  1   2676   3292   3136 778712   0   0 39156     0  721   767   1  20  78
 0 200  1   2676   3264   3260 778620   0   0 40664     8  738   624   2  11  86
 0 200  0   2676   3212   3368 778480   0   0 37056     0  727   614   1  15  84
 0 200  1   2676   3228   3464 778468   0   0 32052     8  654   743   2  12  86
 0 200  1   2676   3196   3492 778472   0   2 30882     2  713   721   0  12  88
 0 200  1   2676   3220   3556 778368   0   0 26490     0  698   739   1  10  89
 0 200  0   2676   3224   3640 778212   0   0 25194    36  709   706   0  11  89
 0 200  0   2676   3304   3692 778136   0   0 20998     0  678   732   1   6  93
 0 200  0   2676   3272   3748 778108   0   0 19734    16  689   768   1  11  88
 0 200  1   2676   3236   3780 778060   0   0 13708     0  644   748   0   6  94
 0 200  0   2676   3196   3800 778076   0   0  9492     0  629   644   0   8  92
 0 200  0   2676   3308   3828 778020   0   0 12978     8  664   727   1   6  93
 0 200  0   2676   3512   3848 777716   0  14 11130    14  664   698   1   6  93
 0 200  0   2804   3256   3860 777896   0 870  7074   878  677   674   0   3  96
 0 200  0   2804   3288   3860 777856   0   0  1068     0  625   665   1   3  96
 0 200  0   2804   3320   3868 777816   0  16  1068    24  627   667   1   2  97
 0 200  0   2804   3212   3868 777928   0  84  1080    84  600   671   1   2  97

...and so on

This gives a total read of a little less than 800MB before giving up. Is
there a cache timeout that needs to be set any lower?

roy


--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

