Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263927AbRGRW5E>; Wed, 18 Jul 2001 18:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbRGRW4z>; Wed, 18 Jul 2001 18:56:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22288 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263927AbRGRW4q>; Wed, 18 Jul 2001 18:56:46 -0400
Date: Wed, 18 Jul 2001 18:25:37 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mike Galbraith <mikeg@wen-online.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of zoned inactive/free shortage patch
In-Reply-To: <Pine.LNX.4.33L.0107181700320.28730-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0107181818090.8651-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jul 2001, Rik van Riel wrote:

> On Wed, 18 Jul 2001, Mike Galbraith wrote:
> 
> > You didn't paying enough attention.  Marcelo is hot on the trail
> > of a problem.
> 
> Looks like it indeed, however I think it's a shame
> he isn't showing us the numbers from his nice VM
> statistics patch.

MemTotal:       900012 kB
SwapTotal:      775152 kB

Running "fillmem 1024". 

Note that in general, the DMA zone is under high shortage while the kernel
is working on the normal zone (of course, its bigger).

That behaviour changes with the zoned approach: if there is no global
shortage but zone specific only shortage the kernel _will_ do work on the
zone which needs work.

 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  0  0 426500 281628    852 432444   16  155    25   158   17    32  0  1 99
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     0        0         0       2        0     12        1
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      0      0      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       3      0          0          0      11      4      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0    562     45     47    419     46      5      7
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
    377     324     225     76        300          0       3    316    121

 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  0  0 335228   3056    852 341540    0    0     0    12  253   575  1 12 87
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     0        0         1       0        0      0        0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      0    129      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0       0      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0      0      0      0      0      0      0     29
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
     53      25      28     13         37          4       0      0      0


 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  0  0 509944   3056    272 510396   98  106   210   306  260   334  1 21 79
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     5        1       108       2        1      0       27
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      0    129      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0    1642      0          0          0       0   1642      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0 236302  17670     30 201475  16872     68     22
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
  34648   33889   77114    636      33812        200       1 118400  42045

 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  1  2 471872   2544    216 462360    0 10654     2 10708  343   542  1 10 89
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     4        4        18     332        3     76       18
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0     138   1642   1642
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0  81667  17994   2331  41469  19618    403      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
  28879   28867      92   3870      25003          6     329  16572  16491


 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  1  1 607020   2544    244 542816   34 30898   322 30926  527  7558  1  7 92
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
    10       10        15     390        0   3542      151
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0    3471      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0  62712   7751   7720  38225   7996    958      3
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
  25581   25441     216   6722      18837         23     777  17274  17199


Do you see a DMA free and inactive shortage (causing a lot reclaim_page()
failures (recfail field)) and the kernel aging/unmapping/laundering normal
zone pages ?


 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  3  1 610412   2544    376 504444  186 30950  1244 31064  597  6933  0  6 94
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
    22       22        15     425        0   3088      331
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
   1642    1642       0      0       1642          0    2974      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0 144379   6638   9992 117916   8302   1190      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
  27446   27421   13227   8025      19421          1     820  13745    542

 
r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  1  2 610328   2544    472 440108  228 31238   846 31298  574  9233  0  8 92
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
    17       17        18     462        0   4401      238
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0    4179      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0 107342   7447   9510  79205   8364   1258      2
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
  28298   28068   19713   8903      19395          1     897  19629    149
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  0  1 610328   2556    484 433224    0 26072     8 26186  578  1604 12  2 86
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
    15       15        20       0        0    391      194
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0      64      0          0          0     379     64      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0  35576   7482   6884  14220   6866      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
  19709   19653   19544   7007      12702          0       0  19518     30
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  1  1 610332   2672    508 432924    0 4216    42  4222  326   738 10  3 87
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     5        5         7       0        0     23       90
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
   1642     423    1219      0       1642          0      21      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0  19051   1191   1491  12808   1255   2319      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
  10232    6463    8453   3252       6981          0       0   4685      2
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  2  1 745672   2548    328 569368  558 1934   564  1976  226   259  2 14 84
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
    12       12        98       0        0      2      187
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
   4925    4502    2129      0       4925          0       2   3347   1642
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0   9070   2628   1105   4375    759     16    125
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
 144232  106821  120225   3703     140524          5       0 134754  51940
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  2  1 745676   2544    360 568628 1264 3630  1730  3692  234   608  1  1 99
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     7        7         2       0        0    305      118
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0     199      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0  40894    919   1454  37376   1056      0   1488
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
   6194    6083     131   2106       4088          0       0   1691   1672
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  1  1 745664   2548    348 568640 1064 4150  1068  4152  208   358  0  0 100
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     1        1         1       0        0    165        9
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0      97      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0   5250    929   1083   2182   1055      0   3506
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
   4005    4001      12    912       3094          0       0     12      5
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  2  1 745664   2544    348 568644 1250 3838  1250  3838  194   426  0  0 100
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     0        0         0       0        0    197        0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0     109      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0   1919      8    952      0    967      0    494
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0       0      0      0

