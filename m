Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272343AbRHXXXi>; Fri, 24 Aug 2001 19:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272345AbRHXXX3>; Fri, 24 Aug 2001 19:23:29 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:12199 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S272343AbRHXXXY>;
	Fri, 24 Aug 2001 19:23:24 -0400
Date: Sat, 25 Aug 2001 01:23:38 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010825012338.B547@cerebro.laendle>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010824201125Z16096-32383+1213@humbolt.nl.linux.org> <Pine.LNX.4.33L.0108241713420.31410-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108241713420.31410-100000@duckman.distro.conectiva>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 05:19:07PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> Actually, no.  FIFO would be ok if you had ONE readahead
> stream going on, but when you have multiple readahead

Do we all agree that read-ahead is actually the problem? ATM, I serve ~800
files, read()ing them in turn. When I increase the number of threads I
have more reads at the same time in the kernel, but the absolute number of
read() requests decreases.

So if read-ahead is the problem, then there must be some interdependency
between read-aheads for serial requests and read-aheads for concurrent
requests.

For example, I could imagine that read() executes, returns to
userspace and at the same time the kernel thinks "nothing to do, let's
readahead". While, in the concurrent case, there is hardly a time when no
read() is running. But read-ahead does not seem to work that way.

I usually have around 200MB of free memory, this leaves ~200k/handle
(enough for read-ahead). let's see what happens with vmstat. this is after i
kill -STOP httpd:

 0  2  0      0   4140  15448 185972   0   0     0   264 1328    88   1   3  96
 0  2  0      0   4136  15448 185976   0   0     0     0  793    62   0   3  97
 0  2  0      0   4136  15448 185976   0   0     0     0  538    62   0   1  98
 0  2  0      0   4128  15448 185984   0   0     0     0  382    62   1   1  98
 0  2  0      0   4128  15448 185984   0   0     0     0  312    66   0   1  99
 1  1  0      0   3056  15448 185088   0   0    48   132 2465   321  24  28  48
 2  1  1      0   3056  15448 186392   0   0  4704     0 3017   925  11  21  68
 1  1  2      0   3804  15440 185516   0   0  4708     0 3909  1196  28  38  34
 1  1  0      0   3056  15440 186212   0   0  5392     0 4004  1579  21  32  47
 1  1  1      0   3064  15436 186220   0   0  6668     0 3676  1273  19  42  39
 0  1  1      0   3056  15468 186168   0   0  4488  1424 3889  1342  16  34  50
 0  1  2      0   3056  15468 186116   0   0  3372     0 3854  1525  20  34  46
 1  1  1      0   3060  15468 186084   0   0  4096     0 4088  1641  21  37  41
 0  1  2      0   3056  15468 186044   0   0  6744     0 3679  1415  22  33  45
 1  1  1      0   3072  15468 186040   0   0  4700     0 3713  1429  19  32  50

at some point I killall -CONT myhttpd (it seems more than the 2mb/s is
being read, though, although I only server about 2.3mb/s). now let's see
when i dynamically add 15 reader threads:

  procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  1  1      0   3056  14636 193104   0   0  5248     0 3531  1428  11  35  53
 0  1  2      0   3056  14604 193072   0   0  5936     0 3730  1416  10  33  57
 0  1  0      0   3056  14604 193068   0   0  5628     0 4025  1504  16  34  50
# added 15 threads
 0 16  0      0   3060  14580 192952   0   0  5412     0 3394  1010  12  31  57
 1 16  1      0   3060  14580 192944   0   0  2580   268 2253   636   8  23  69
 0 16  0      0   3056  14580 192944   0   0   380   852 1570   488   5  13  82
 0 16  0      0   3064  14580 192880   0   0  2652     0 1470   583   6  14  80
 0 16  0      0   3056  14560 192888   0   0  2944     0 2068   693   5  23  72
 0 16  0      0   3056  14560 192888   0   0   544     0 1732   550   5  15  80
 1 16  0      0   3056  14560 192884   0   0  2892     0 1513   741   4  14  82
 0 16  1      0   3056  14560 192884   0   0  2236   552 1894   742   5  17  77
 1 16  0      0   3056  14560 192880   0   0  1100   128 1699   604   4  15  81

woaw. blocks in decreases a slot. now let's remove the extra threads again:

 0 16  1      0   3056  14552 193720   0   0  4944   660 1463   721   3  20  77
 0 16  0      0   3056  14552 193648   0   0  1756   136 1451   726   4  18  79
 0 16  0      0   3056  14552 193588   0   0   440     0 1221   565   3  13  84
 0 16  0      0   3056  14552 193584   0   0  3308     0 1278   632   4   9  88
 1 16  0      0   3056  14536 193608   0   0  3040     0 2469  1168   7  21  72
 0 16  0      0   3056  14536 193608   0   0  2320     0 1844   730   5  15  80
 1 16  1      0   3056  14536 193612   0   0  1660   596 1557   559  12  24  64
# here the server starts rto reap threads. this is a slow and inefficient process
# that take svery long and block the server.
 1 16  0      0   3056  14536 193612   0   0  2188   164  831   440  25  30  45
 1 16  0      0   3056  14536 193612   0   0  2324     0  506   329  23  30  47
 1 16  0      0   3056  14536 193612   0   0  1452     0  460   401  24  30  46
# many similar lines snipped
 1 16  0      0   3056  14516 193692   0   0  3932     0  510   621  20  38  42
 1 16  0      0   3056  14516 193692   0   0  1744     0  338   369  23  31  46
 1 16  0      0   3056  14568 193872   0   0  1292   476  383   392  20  32  48
 2  0  2      0   3056  14616 175104   0   0  5748     0 3670  1342  24  37  39
 2  1  1      0   3560  14616 174708   0   0  5028     0 3539   989  22  43  35
 0  1  0      0  93948  14660 175764   0   0  1604     0 3341   667  10  22  68
 1  0  0      0  92244  14844 176212   0   0   524     0 3240   424  12  12  76
 0  1  0      0  90532  15212 176404   0   0   200  1524 3308   426  16  14  71
 0  1  1      0  84600  15212 179096   0   0  2712     0 2710   669  26  11  63
 0  1  2      0  77768  15212 183132   0   0  4012     0 3041   889  19  18  63
 0  1  0      0  68724  15212 189440   0   0  6284     0 3110   998  21  21  58
 1  1  0      0  58892  15212 195984   0   0  6528     0 3149   975  28  25  47
 2  1  0      0  50636  15248 201316   0   0  5316  1368 3321   968  20  28  52
 1  1  0      0  38520  15248 210004   0   0  8664     0 3250   910  28  26  46
 0  1  1      0  28100  15248 218520   0   0  8508     0 3186   777  20  28  52
 1  1  1      0  18848  15248 227028   0   0  8500     0 3090   704  15  26  59
 0  1  0      0  10752  15248 233752   0   0  6732     0 3223   774  20  27  53

back to 2.1mb/s, but reading much more.

this certainly looks like overzealus read-ahead, but I should have the
memory available for read-ahead. So is it "just" the use-once-optimization
that throws away read-ahead pages? If yes, then why do I see exactly
the same performance under 2.4.5pre4, which didn't have (AFAIK) the
use-once-opt.?

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
