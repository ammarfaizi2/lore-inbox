Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266608AbRGLVng>; Thu, 12 Jul 2001 17:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266725AbRGLVn1>; Thu, 12 Jul 2001 17:43:27 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:63157 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S266608AbRGLVnT>; Thu, 12 Jul 2001 17:43:19 -0400
Date: Thu, 12 Jul 2001 17:43:21 -0400 (EDT)
From: Dirk Wetter <dirkw@rentec.com>
To: Mike Galbraith <mikeg@wen-online.de>, <riel@conectiva.com.br>,
        <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: dead mem walking ;-) 
In-Reply-To: <Pine.LNX.4.33.0107122109350.504-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0107121719590.2326-100000@monster000.rentec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi guys,

On Thu, 12 Jul 2001, Mike Galbraith wrote:

> > > Have you had a chance to try 2.4.7-pre-latest yet?  I'd be interested
> > > in a small sample of vmstat 1 leading into heavy swap with >=pre5 if
> > > it is still a problem.
> >
> > i will definetely check it out and give a report, since the test i did
> > yesterday the *command* "vmstat 1" in typed in appeared to be :)) more
> > like "vmstat 180", no kidding.
>
> Ok, you have some 'io bound' issues that need to be looked at.  Present
> the data in that light please.

so here is result of my testing: the scenario: vanilla kernel
2.4.6, config is CONFIG_HIGHMEM4G=y, it's a dual intel box with 4GB
mem.  the machine was freshly booted before the test with profile=2
(more detailed data is av. @ www.desy.de/~dirkw/linux-kernel/ )



a while before the jobs were submitted i did "readprofile | sort -nr | head -10":
296497 total                                      0.3442
295348 default_idle                             5679.7692
   300 __rdtsc_delay                             10.7143
   215 si_swapinfo                                1.2500
   138 do_softirq                                 1.0147
   107 printk                                     0.2816
    28 do_wp_page                                 0.0272
    17 schedule                                   0.0117
    10 tcp_get_info                               0.0077
    10 filemap_nopage                             0.0073

the same after i was able to kill the jobs (see below):

836552 total                                      0.9710
458757 default_idle                             8822.2500
361961 __get_swap_page                          665.3695
  6629 si_swapinfo                               38.5407
  1655 do_anonymous_page                          5.3734
   760 file_read_actor                            3.0645
   652 statm_pgd_range                            1.6633
   592 do_softirq                                 4.3529
   498 skb_copy_bits                              0.5845
   302 __rdtsc_delay                             10.7857


i also did a "vmstat 1" (sorry about the long lines):

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
[..]
 0  0  0      0 4004896   3184  13600   0   0     0     0  183    60   0   6  94
 0  0  0      0 4004896   3184  13600   0   0     0     0  153    88   0   3  97
 0  0  0      0 4004892   3184  13604   0   0     0     0  109    63   0   3  97
then, as the jobs were submitted:
 0  1  0      0 4001772   3252  15084   0   0   224    56 2804  2806  10   7  83
 0  0  0      0 3997784   3252  15852   0   0     4     8 2133  2117  14   8  78
 0  1  0      0 3997744   3252  15896   0   0     0     0 3526  3487   7   9  84
 0  1  0      0 3995872   3256  16700   0   0   324    24 1624  1732   9   5  86
 1  0  0      0 3995900   3256  16876   0   0     0    24 2652  3648  13   8  79
 1  0  1      0 3993068   3256  16908   0   0     4    28 1894  2703  33  14  54
[..]
 2  0  0      0 2648168   4716 303564   0   0     0    24 5675  1718  70  29   1
[..]
 2  0  0      0 1851568   4856 500804   0   0   456     0  265   148  87  10   3
[..] it became "idle?":
 0  2  0      0 1023728   4944 661724   0   0     0     0 3944  3023   4  12  84
[..]
 1  1  0      0 510344   4972 764132   0   0     0     0 3647  2601   6  21  74
[..]
 0  2  0      0 251700   4972 817964   0   0     0     0 6440  4888  11  27  63
[..]
 0  2  0      0  63300   4972 856792   0   0     0     0 6876  5836  10  20  70
[..]
 2  0  0      0   5092   2912 377904   0   0     0     4 5514  4359   7  30  63
and now continously:
 0  2  0      0   5092   2912 328024   0   0     0     0 6660  5991   8  20  72
 0  2  0      0   5092   2836 297044   0   0     0     0 7777  7083   9  21  70
 0  2  0    292   6644   2808 274684   0   0   588     0 1026   992  71  15  14
 0  2  1    708   5084   2784 269260   0   0   676    88  261   269  57  31  12
 0  2  0 455800   5072   2756 871396   0   0  2920     0  423   579  40  44  17
 2  0  0 1232696   5092   2696 1469092   0   0     0     0 3534  1076  32  63   5
 2  0  1 1264360   5100   2672 1490184   0   0     0     0 4400  1286  72  28   0
 3  0  0 1313796   6720   2632 1505580   0   0     4     0 7147  2554  54  41   5
 4  0  2 1532260   5092   2652 1783788   0   0     0    76 7655  2998  51  43   5
starting from here, the machine was comatose
11  1  1 2126752   5216   2644 2312428   0   0    39     1  202   140   4  20  76
 9  1  1 2153304  61684   2644 2282860   0   0     0    56 17401   188   0 100   0
spat-out frequency ;-) now was now ~ 1 line/2-5 minutes:
18  0  3 2179888  61084   2644 2310692   0   0     0    64 18828   610   0 100   0
 6  0  2 2180032  58184   2644 2313340   0   0     0    88 3293  1194  14  85   0
20  0  2 2205848  55024   2644 2340136   0   0     0     8 18377  1085   0 100   0
15  0  2 2231488  54952   2644 2365796   0   0    16    12 16970   179   0 100   0
27  1  3 2256488  52756   2644 2391040   0   0    76    20 17124   328   0 100   0
25  1  2 2281296  53504   2644 2416300   0   0     0    95 17093   146   0 100   0
[..]
22  1  2 2422088  40496   2644 2568668   0   0     0    52 30513   236   0 100   0
19  1  1 2444300  39228   2644 2593716   0   0     0   152 17785  1051   0 100   0
13  1  1 2466092  38800   2644 2615504   0   0     0    44 14733   308   0 100   0
10  3  1 2508800  36820   2644 2659232   0   0     0    44 29436   563   0 100   0
after i managed to kill the jobs:
15  0  4 2609772  58396   2656 2778556   0   0    19     1  128    70   2  61  37
 0  1  0 2602520 1248956   2672 2771456   0   0   160     0 2500  3795   1  24  75
 0  1  0 2602520 1249340   2672 2771456   0   0     0     0 1930  3108   3   6  92
 0  1  0 2602520 1249572   2676 2771488   0   0    36    20  660  1022   3  14  83
 0  1  0 2602520 1249572   2676 2771488   0   0     0     0  109    56   0   4  96
 0  1  0 2602520 1249560   2688 2771488   0   0    12     0  141    69   0   7  93
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id


strange is, that si/so was all the time 0, also in the lines i
omittted, but i guess that only appeared to be ;-) . system was 100%
in kernel, load was through the ceiling:


  2:05pm  up 42 min,  3 users,  load average: 21.54, 9.50, 3.69
68 processes: 63 sleeping, 4 running, 1 zombie, 0 stopped
CPU0 states: 54.2% user, 36.1% system, 53.4% nice,  9.2% idle
CPU1 states: 45.2% user, 47.0% system, 45.3% nice,  6.4% idle
Mem:  4057236K av, 4049964K used,    7272K free,       0K shrd,    2632K buff
Swap: 14337736K av, 1313796K used, 13023940K free                 1505452K cached
  PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
 1377  1213 usersid   18 1854M 636M 1.2G   568  0M R N  70.9 30.7   2:18 ceqsim
 1387  1284 usersid   19 1854M 636M 1.2G   568  0M R N  70.7 30.7   2:17 ceqsim
 1213  1188 usersid    9  8124 2512 5612   732  1K S     0.0  0.1   0:02 sfmbB2
 1284  1259 usersid    9  8124 2512 5612   732  1K S     0.0  0.1   0:02 sfmbC2

  2:18pm  up 36 min,  2 users,  load average: 24.09, 20.61, 12.52
81 processes: 70 sleeping, 9 running, 2 zombie, 0 stopped
CPU0 states:  0.1% user, 100.0% system,  0.0% nice,  0.-1% idle
CPU1 states:  1.9% user, 99.0% system,  0.5% nice,  0.-1% idle
Mem:  4057240K av, 4052876K used,    4364K free,       0K shrd,     332K buff
Swap: 14337736K av, 3334732K used, 11003004K free                 3370160K cached
  PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
 1186  1109 usersid   15 1936M 1.4G 526M 33736  0M R N  23.3 13.2   8:27 ceqsim
 1054   975 usersid   20 1936M 1.7G 157M 20292 36K R N  18.9  3.9   5:18 ceqsim
  229     1 root       9  1568    0 1568  1352  54 S     0.0  0.0   0:00 xntpd
  543     1 root      20   780   48  732   708  42 R     2.5  0.0   0:01 pbs_mo

 2:54pm  up  1:32,  2 users,  load average: 25.37, 25.03, 24.13
66 processes: 54 sleeping, 12 running, 0 zombie, 0 stopped
CPU0 states:  0.3% user, 99.216% system,  0.47% nice,  0.1% idle
CPU1 states:  0.0% user, 99.265% system,  0.3% nice,  0.-1% idle
Mem:  4057236K av, 4025056K used,   32180K free,       0K shrd,    2644K buff
Swap: 14337736K av, 2550220K used, 11787516K free                 2704768K cached
  PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
 1377  1213 usersid   15 1859M 1.2G 643M   568  0M R N   0.1 16.2  23:25 ceqsim
 1387  1284 usersid   15 1859M 1.2G 622M   568  0M R N  49.7 15.7  25:13 ceqsim
 1213  1188 usersid    9  8124 5308 2816   732 521 S     0.0  0.0   0:02 sfmbB2
 1284  1259 usersid    9  8124 5308 2816   732 521 S     0.0  0.0   0:02 sfmbC2



ok. if could do more to resolve this problem, let me know what I
should do and I'll try to make further tests then.


thanks,
	~dirkw








