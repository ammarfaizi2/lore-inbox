Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRJIXtv>; Tue, 9 Oct 2001 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277203AbRJIXto>; Tue, 9 Oct 2001 19:49:44 -0400
Received: from cs.wustl.edu ([128.252.165.15]:41875 "EHLO
	taumsauk.cs.wustl.edu") by vger.kernel.org with ESMTP
	id <S273345AbRJIXte>; Tue, 9 Oct 2001 19:49:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15299.36115.575814.386840@samba.doc.wustl.edu>
Date: Tue, 9 Oct 2001 18:49:39 -0500
From: Krishnakumar B <kitty@cs.wustl.edu>
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH *] faster cache reclaim
In-Reply-To: <Pine.LNX.4.33L.0110082032070.26495-100000@duckman.distro.conectiva>
X-Mailer: VM 6.96 under 21.4 (patch 4) "Artificial Intelligence" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 8 October 2001, Rik van Riel wrote:
> [WANTED: testers]
> 
> Hi,
> 
> after looking at some other things for a while, I made a patch to
> get 2.4.10-ac* to correctly eat pages from the cache when it is
> about pages belonging to files which aren't currently in use. This
> should also give some of the benefits of use-once, but without the
> flaw of not putting pressure on the working set when a streaming IO
> load is going on.
> 
> It also reduces the distance between inactive_shortage and
> inactive_plenty, so kswapd should spend much less time rolling
> over pages from zones we're not interested in.
> 
> This patch is meant to fix the problems where heavy cache
> activity flushes out pages from the working set, while still
> allowing the cache to put some pressure on the working set.
> 
> I've only done a few tests with this patch, reports on how
> different workloads are handled are very much welcome:

My configuration is dual PIII 933 Mhz with 512 MB RAM, 1GB swap. Three
simulatenous compilations (gcc, kernel, gdb...each with make -j3), playing
XMMS and browsing web using Mozilla (3 windows) + XEmacs. Switching between
workspaces is slow...Everytime a page is loaded in Mozilla, XMMS stops for
a second before continuing. Mouse pointer jumps.

I have attached vmstat and top output from 2 different runs (with the same
load). Seems that swapping is not smooth. It suddenly jumps from 2896 to
26780. I have noticed similar behaviour with 2.4.10-ac10 (before applying
this patch). swpd entry doesn't seem to increase at all, even when the
machine has similar loads as the current load.

HTH.

-kitty.


samba> vmstat 4
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
15  1  2   2808  59100  38608 181280   0   0   168   250  622  1035  66   9  24
17  0  2   2808  47696  38668 187668   0   0   115   501 2978  3357  87  13   0
17  0  1   2808  59508  38768 192496   0   0    58   462 2790  2955  90  10   0
18  0  1   2808  60644  38980 201152   0   0   134   732 3413  3064  86  14   0
21  0  2   2808  42024  39060 208916   0   0   158   679 3138  3430  88  13   0
16  1  1   2808  35160  39084 216564   0   0    77     0 3165  3269  88  12   0
14  1  3   2808  30592  39192 209908   0   0    87   683 2575  2945  81  19   0
14  1  1   2808  58196  39264 216024   0   0   103   478 2779  3045  86  14   0
12  1  1   2808  46052  39360 216704   0   0   105   709 1662  2917  91  10   0
16  1  1   2808  35684  39400 219056   0   0    93   551 1965  2390  92   8   0
13  1  2   2808  45152  39432 225140   0   0    81   150 2908  2850  89  11   0
13  1  1   2808  24272  39512 231084   0   0    88   577 2875  3197  88  12   0
10  1  2   2808  28616  39568 237144   0   0    86   530 2928  2947  88  12   0
10  0  2   2808  32492  39628 248456   0   0    88   554 4009  3858  84  16   0
11  1  5   2808   6588  39652 259328   0   0    69   260 3714  3117  88  12   0
12  1  1   2808  17712  39700 267524   0   0   212   242 3198  3259  85  15   0
10  1  0   2808   5848  39780 267492   0   0   143   611 2900  2863  83  17   0
12  0  1   2896   6080  39872 263696   0   0   116   685 2861  3167  87  13   0
10  1  1   2896   3500  39996 263352   0   0    67   607 3016  3569  89  12   0
13  0  1   2896   3216  39996 258668   0   0   102     0 3237  3840  89  11   0
11  1  2   2896  20152  40100 264064   0   0    94   618 2942  3307  88  12   0
10  2  3   2896  19444  40168 255592   0   0    70   807 3871  3437  86  14   0
10  1  2  26780   6284  40076 263220   0   0    39   427 3877  3622  85  15   0
13  0  3  30372   4548  39628 257012   0   0    99   597 2989  3643  87  12   0
11  1  0  31628  14332  39656 254832   0   0   160     0 1966  2824  92   8   0
13  1  1  31628  10048  39720 256512   0   0   119   607 1602  2457  93   7   0
10  1  0  31864   3064  39764 254680   0   0    80   625 1608  2372  92   8   0
10  1  1  31864  23444  39792 256820   0   0   189   533 2590  3193  89  11   0
12  1  3  31864  21240  39900 263328   0   0   196   880 2854  3160  86  14   0
10  0  1  31864  17960  39964 267336   0   0   101   141 2887  3681  88  12   0
13  1  0  31864  26340  40060 273696   0   0   114   625 2977  3551  87  13   0
11  0  1  31864  15908  40156 279980   0   0    74   724 3045  3662  81  19   0
10  1  1  31864  11768  40304 281812   0   0   160   842 2978  3779  79  21   0
14  1  2  31864  16648  40336 271284   0   0   144     0 2499  3529  82  18   0
14  1  1  31864  17504  40456 264972   0   0   218   783 1701  2932  85  15   0
 9  1  0  31864  13596  40600 265736   0   0   102   633 1667  2792  91   9   0
11  1  2  34012  15928  40732 255932   0   0   241   650 1788  2903  91   9   0
10  1  4  34012  10192  40788 265600   0   0   454   571 3305  3574  87  13   0
11  0  2  34012   8248  40836 269864   0   0   152   156 2582  3299  83  17   0
 9  0  1  34012   3064  40948 259848   0   0    86   993 1569  2381  90  10   0
12  0  0  34012   9832  41136 249256   0   0   279   657 1598  2750  92   8   0
15  0  1  34012   3064  41292 232216   0   0   941   453 1616  2610  91   9   0
11  0  1  34012  15916  41324 226912   0   0   186     0 1561  2409  92   8   0
14  0  0  34012   3064  41416 227680   0   0   175   445 1582  2324  88  12   0
10  0  1  36408  10368  38304 214216   0   0   215   601 1639  2620  84  16   0
11  0  0  36408   4648  38396 209864   0   0   286   655 1579  2369  90  10   0
 8  1  1  36408  19992  38452 233672   0   0  3562     0 1700  2779  85  15   0
10  0  1  36648   6288  34596 238324   0   0  1743  5900 1633  2515  88  12   0
 8  0  1  36552  14948  34684 241360   0   0   228  1919 1620  2279  95   5   0
 7  1  1  36552  31788  34716 244068   0   0   161     0 1575  2293  93   7   0
12  0  1  37836   3064  30636 203352   0   0   186  1409 1583  2739  91   9   0
12  2  1  45316  26024  28616 200512   0   8  1410   250 1605  2225  92   8   0

  5:17pm  up 11 min, 12 users,  load average: 11.41, 10.14, 5.33
133 processes: 116 sleeping, 17 running, 0 zombie, 0 stopped
CPU0 states: 93.1% user,  6.1% system,  0.0% nice,  0.0% idle
CPU1 states: 96.0% user,  3.2% system,  0.0% nice,  0.0% idle
Mem:   513016K av,  509932K used,    3084K free,     384K shrd,   28720K buff
Swap: 1052216K av,   45316K used, 1006900K free                  202492K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
12786 kitty     15   0 13224  12M  2496 R    16.4  2.5   0:01 cc1
12804 kitty     14   0  5392 5392   792 R    16.4  1.0   0:00 ld
12796 kitty     14   0 12684  12M  2544 R    16.1  2.4   0:00 cc1
12818 kitty     14   0  9136 9132  1824 R    16.1  1.7   0:00 cc1
12820 kitty     14   0  9588 9584  1812 R    16.1  1.8   0:00 cc1
12259 kitty     14   0 14920  14M  3320 R    15.7  2.9   0:10 cc1
12741 kitty     14   0 11320  11M  2868 R    15.7  2.2   0:02 cc1
12799 kitty     14   0 12604  12M  2544 R    15.7  2.4   0:00 cc1
12763 kitty     14   0 14308  13M  2576 R    15.4  2.7   0:01 cc1
12772 kitty     14   0 13764  13M  2576 R    15.4  2.6   0:01 cc1
11828 kitty     14   0 27672  27M   444 R    15.1  5.3   0:11 genattrtab
12824 kitty     14   0  8796 8792  1808 R    14.1  1.7   0:00 cc1
 1184 root      10   0 81808  20M  1548 R     3.2  4.0   0:54 X
11044 kitty     11   0  1224 1220   908 R     1.3  0.2   0:02 top
12715 kitty      9   0   512  512   404 S     0.9  0.0   0:00 esd
12719 kitty      9   0  5840 5092  2684 S     0.6  0.9   0:00 xmms
 1226 kitty      9   0  5000 3312  1784 S     0.3  0.6   0:05 enlightenment
 1283 root       9   0  3432 2348  1780 S     0.3  0.4   0:00 xterm
10881 kitty      5   0  1556 1312  1216 S     0.3  0.2   0:00 bash
10999 root       9   0  2424 2136  1768 S     0.3  0.4   0:00 xterm
12765 kitty      9   0  1096 1096   696 S     0.3  0.2   0:00 as
12821 kitty      9   0   568  568   460 S     0.3  0.1   0:00 gcc
12822 kitty      9   0   912  912   632 S     0.3  0.1   0:00 as
    1 root       8   0   532  480   464 S     0.0  0.0   0:03 init
    3 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    5 root      19  19     0    0     0 RWN   0.0  0.0   0:00 ksoftirqd_CPU1
    6 root       9   0     0    0     0 SW    0.0  0.0   0:01 kswapd
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
    8 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    9 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdated
   10 root       9   0     0    0     0 SW    0.0  0.0   0:00 kjournald
   76 root       9   0     0    0     0 SW    0.0  0.0   0:00 khubd
  168 root       9   0     0    0     0 SW    0.0  0.0   0:00 kjournald
  169 root       9   0     0    0     0 SW    0.0  0.0   0:00 kjournald
  560 root       9   0   620  564   520 S     0.0  0.1   0:00 syslogd
  565 root       9   0  1032  428   428 S     0.0  0.0   0:00 klogd
  579 rpc        9   0   556  472   472 S     0.0  0.0   0:00 portmap
  594 rpcuser    9   0   728  624   624 S     0.0  0.1   0:00 rpc.statd
  685 root       9   0   816  720   668 S     0.0  0.1   0:00 ypbind
  687 root       9   0   816  720   668 S     0.0  0.1   0:00 ypbind
  688 root       9   0   816  720   668 S     0.0  0.1   0:00 ypbind
  689 root       9   0   816  720   668 S     0.0  0.1   0:00 ypbind
  750 root       8   0   624  536   520 S     0.0  0.1   0:00 automount
  769 root       9   0   624  536   520 S     0.0  0.1   0:00 automount
  791 root       9   0   624  536   520 S     0.0  0.1   0:00 automount
  824 root       9   0   664  572   556 S     0.0  0.1   0:00 automount
  853 root       8   0   664  572   556 S     0.0  0.1   0:00 automount
  899 root       8   0   664  576   556 S     0.0  0.1   0:00 automount
  924 root       9   0   664  572   556 S     0.0  0.1   0:00 automount
  946 root       9   0   664  572   556 S     0.0  0.1   0:00 automount
  961 daemon     9   0   544  472   472 S     0.0  0.0   0:00 atd
  972 root       9   0   852  672   672 S     0.0  0.1   0:00 sshd
 1003 root       9   0  1612 1124  1124 S     0.0  0.2   0:00 sendmail
 1016 root       9   0   480  428   412 S     0.0  0.0   0:00 gpm
 1028 root       8   0   736  660   624 S     0.0  0.1   0:00 crond
 1058 xfs        9   0  8012 5028  1000 S     0.0  0.9   0:02 xfs
 1083 root       9   0   600  528   528 S     0.0  0.1   0:00 rhnsd
 1099 root       9   0  1740 1164   880 S     0.0  0.2   0:00 cupsd
 1111 root       9   0  1256  844   844 S     0.0  0.1   0:00 login
 1112 root       9   0   428  364   364 S     0.0  0.0   0:00 mingetty
 1113 root       9   0   428  364   364 S     0.0  0.0   0:00 mingetty
 1114 root       9   0   428  364   364 S     0.0  0.0   0:00 mingetty
 1115 root       9   0   428  364   364 S     0.0  0.0   0:00 mingetty

Second run
----------


samba> vmstat 4
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 9  0  0  74700  20764  38828 312172   2   5    99   150  696  1162  55   6  40
 9  0  0  74652   3064  38940 309256 175   0   389   694  202  1344  94   6   0
11  0  0  74640   7920  39072 303268 210   0   628   218  263  1816  93   7   0
11  0  1  74640   3064  39168 303700   3   0   140   631 1586  2403  93   7   0
11  0  0  74640  12992  39252 304540   0   0   148   556 1562  2221  90  10   0
10  1  0  74640  11464  39336 300244   0   0    83   564 1562  2469  90   9   0
13  0  1  74640   3064  39404 302728   0   0   207     0 1545  2394  92   8   0
10  0  2  74640  10820  39532 274052   0   0   179  1457 1578  2503  92   8   0
16  1  1  74640   3064  39676 274900  48   0   199   747 1649  2625  93   7   0
21  0  1  75180   3064  35656 231056 321   0  1176   686 1624  1749  88  11   0
18  0  4  76136   3076  27600 205960 145 1630   417  1949 1674  2145  92   8   0
21  1  1  76236  63624  27684 205472  44   0   362   123 1621  2403  91   9   0
19  0  1  76236  32392  27804 209304 237   0  1087   691 1659  2369  94   6   0
20  0  1  76236  29132  27872 211740 539   0  1068   378 1605  2311  94   6   0
24  0  2  76236   6044  27968 212628  32   0   155   411 1594  2237  93   7   0
19  0  2  76236   3068  27936 197704   7   0   119     0 1597  2363  90  10   0
18  1  1  76236  11088  27980 197328 189   0   482   233 1620  2238  91   9   0
18  0  2  76044  46220  28260 200216 252   0   591   906 1617  2110  91   9   0
16  1  1  76044  53080  28320 201076  70   0   205   462 1639  2081  90  10   0
19  0  1  75312  42900  28424 201664 109   0   295   524 1622  2086  90  10   0
21  0  2  75312  16768  28432 202308 147   0   181     0 1586  2207  91   9   0
19  0  1  75312   8672  28540 203028 271   0   344   502 1605  1991  93   7   0
17  0  1  75312  34768  28616 194192 325   0   418   483 1557  2187  93   7   0
16  0  1  75312  50680  28904 195344  39   0   218   639 1561  2581  91   9   0
16  1  3  75312  61912  28944 196200  16   0    77   418 1552  2509  92   8   0
16  0  0  75312  50296  29060 197340   0   0   194   168 1562  2538  88  12   0
13  0  1  75312  50096  29212 200692   0   0   115  1187 1574  2231  87  13   0
13  0  1  75312  53016  29280 201272   1   0   111   411 1568  2281  84  16   0
16  0  2  75312  80180  29432 203620 248   0   506   810 1673  2467  94   7   0
14  0  0  74912  68232  29536 204416 196   0   370     0 1615  2706  91   8   0
13  0  1  74912  56772  29668 205552 203   0   316   664 1640  2663  92   8   0
13  0  1  74912  46536  29732 206196   0   0    62   390 1562  2692  94   6   0
12  0  0  74912  75088  29884 207756   0   0   103   568 1592  2499  93   8   0
14  0  1  74912  51196  29904 208860  16   0   171     0 1551  2256  92   7   0
13  0  0  74912  53472  29996 209476  13   0   112   573 1614  2349  92   8   0
13  1  1  74912  55744  30108 210700 145   0   250   701 1617  2123  92   8   0
13  0  1  74912  46092  30248 211464 231   0   289   736 1571  1983  94   6   0
13  0  1  74908  45128  30336 212100  16   0   103   444 1597  2384  91   9   0
13  0  2  74908  42672  30364 212664   0   0    32     0 1551  2371  88  12   0
15  0  2  74908  44268  30460 219444   0   0   306   449 1573  2326  88  12   0
13  0  1  74908  41324  30576 220956   1   0   107  1890 1590  2510  90  10   0
14  0  1  74908  38128  30688 221640   0   0    94   640 1582  2765  89  11   0
11  0  1  74908  57516  30708 223460   0   0    68     0 1566  2939  90  10   0
21  1  1  74908  29840  30960 224536  17   0    91  1035 1578  2153  84  15   0
20  0  1  74908  19276  31004 225380   0   0   104   427 1554  2202  85  15   0
24  0  1  74908  26924  31364 217516   0   0    92   841 1574  2065  83  17   0
19  0  1  74908  17764  31384 218368   0   0    97     0 1533  1989  87  13   0
20  0  2  74908  20920  31540 209716  16   0    78   707 1554  2054  95   5   0
18  0  2  74908   3064  31644 208688   0   0    88   482 1551  2240  93   7   0
21  0  0  74908  28460  31688 190564   0   0    51   292 1544  2229  94   6   0
15  0  2  74908  41856  31772 191584  16   0   116   423 1566  2604  91   9   0
15  0  1  74908  40144  31816 192752   0   0    69     0 1543  2540  90  10   0
17  0  1  74908  21508  31864 192896   0   0   104   602 1550  2479  91   9   0
17  0  1  74908  51012  31924 194564   0   0    94   624 1557  2441  90  10   0
15  0  2  74908  57640  31996 194400   0   0    83   554 1541  2440  91   9   0
12  0  0  74908  70516  32092 194704   1   0    32   657 1548  2194  85  15   0
13  0  0  74908  76732  32108 195912   0   0   102     0 1540  2292  93   7   0
13  0  1  74908  55176  32184 196832   0   0    76   479 1556  2398  95   5   0
12  0  1  74908  53736  32240 197896   0   0   117   409 1602  2455  96   4   0
14  0  2  74908  56632  32304 199280   0   0   139   572 1553  2441  94   6   0
13  1  3  74908  46272  32372 199868   0   0    89   445 1575  2307  94   6   0

  5:17pm  up 11 min, 12 users,  load average: 11.41, 10.14, 5.33
133 processes: 116 sleeping, 17 running, 0 zombie, 0 stopped
CPU0 states: 93.1% user,  6.1% system,  0.0% nice,  0.0% idle
  6:43pm  up  1:37, 14 users,  load average: 14.21, 6.84, 2.96
133 processes: 118 sleeping, 15 running, 0 zombie, 0 stopped
CPU0 states: 88.1% user, 11.1% system,  0.0% nice,  0.0% idle
CPU1 states: 88.1% user, 11.0% system,  0.0% nice,  0.1% idle
Mem:   513016K av,  470664K used,   42352K free,     384K shrd,   30572K buff
Swap: 1052216K av,   74908K used,  977308K free                  220748K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  581 kitty     20   0 12452  12M  3180 R    15.1  2.4   0:01 cc1
 1071 kitty     16   0  9224 9220  1948 R    13.4  1.7   0:00 cc1plus
32655 kitty     16   0 25456  24M  2736 R    13.1  4.9   0:04 cc1plus
 1063 kitty     16   0 11228  10M  3060 R    13.1  2.1   0:00 cc1
 1075 kitty     17   0 10408  10M  2964 R    13.1  2.0   0:00 cc1
 1289 kitty     20   0  7344 7344  2536 R    12.4  1.4   0:00 cc1
 1240 kitty     16   0  7204 7204  2568 R    11.5  1.4   0:00 cc1
 1184 root      16   0 84424  23M  7432 R    11.1  4.6   8:39 X
 1349 kitty     17   0  6788 6784  1748 R    10.5  1.3   0:00 cc1
 1375 kitty     17   0  6468 6468  2528 R     9.8  1.2   0:00 cc1
 1379 kitty     17   0  7048 7044  1748 R     9.8  1.3   0:00 cc1
 1384 kitty     20   0  6888 6884  1744 R     9.5  1.3   0:00 cc1
 1387 kitty     20   0  4132 4132  1760 R     5.5  0.8   0:00 cc1plus
 1119 kitty      9   0  2192 2192   868 S     2.3  0.4   0:00 sh
30992 kitty     12   0  1260 1260   908 R     1.3  0.2   0:02 top
31045 kitty     10   0   512  512   404 S     1.3  0.0   0:01 esd
31046 kitty      9   0  6080 5400  2464 S     0.9  1.0   0:01 xmms
 1088 kitty      9   0  2192 2192   868 S     0.9  0.4   0:00 sh
  169 root       9   0     0    0     0 SW    0.6  0.0   0:00 kjournald
32656 kitty      9   0  3084 3084   696 S     0.6  0.6   0:00 as
 1305 kitty      9   0  6080 5400  2464 S     0.3  1.0   0:40 xmms
30937 kitty      9   0   528  528   444 S     0.3  0.1   0:00 vmstat
 1072 kitty      9   0  1108 1108   688 S     0.3  0.2   0:00 as
 1081 kitty      9   0  2192 2192   868 S     0.3  0.4   0:00 sh
 1279 kitty      9   0   492  492   392 S     0.3  0.0   0:00 gcc
 1378 kitty      9   0   568  568   460 S     0.3  0.1   0:00 gcc
    1 root       9   0   532  480   464 S     0.0  0.0   0:03 init
    3 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    5 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU1
    6 root       9   0     0    0     0 SW    0.0  0.0   0:04 kswapd
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
    8 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    9 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdated
   10 root       9   0     0    0     0 SW    0.0  0.0   0:01 kjournald
   76 root       9   0     0    0     0 SW    0.0  0.0   0:00 khubd
  168 root       9   0     0    0     0 SW    0.0  0.0   0:01 kjournald
  560 root       9   0   612  556   536 S     0.0  0.1   0:00 syslogd
  565 root       9   0  1032  428   428 S     0.0  0.0   0:00 klogd
  579 rpc        9   0   632  596   592 S     0.0  0.1   0:00 portmap
  594 rpcuser    9   0   728  624   624 S     0.0  0.1   0:00 rpc.statd
  685 root       9   0   820  744   692 S     0.0  0.1   0:00 ypbind
  687 root       9   0   820  744   692 S     0.0  0.1   0:00 ypbind
  688 root       9   0   820  744   692 S     0.0  0.1   0:00 ypbind
  689 root       9   0   820  744   692 S     0.0  0.1   0:00 ypbind
  750 root       9   0   584  496   480 S     0.0  0.0   0:00 automount
  769 root       9   0   584  496   480 S     0.0  0.0   0:00 automount
  791 root       9   0   588  536   520 S     0.0  0.1   0:00 automount
  824 root       9   0   620  528   512 S     0.0  0.1   0:00 automount
  853 root       9   0   620  528   512 S     0.0  0.1   0:00 automount
  899 root       8   0   624  564   544 S     0.0  0.1   0:00 automount
  924 root       9   0   620  528   512 S     0.0  0.1   0:00 automount
  946 root       9   0   620  528   512 S     0.0  0.1   0:00 automount
  961 daemon     9   0   556  492   492 S     0.0  0.0   0:00 atd
  972 root       9   0   688  508   508 S     0.0  0.0   0:00 sshd
 1003 root       8   0  1208  780   760 S     0.0  0.1   0:00 sendmail
 1016 root       9   0   480  428   412 S     0.0  0.0   0:00 gpm
 1028 root       9   0   736  660   624 S     0.0  0.1   0:00 crond
 1058 xfs        9   0  8364 4276  4132 S     0.0  0.8   0:03 xfs
 1083 root       9   0   600  528   528 S     0.0  0.1   0:00 rhnsd
 1099 root       9   0  1712 1136   904 S     0.0  0.2   0:00 cupsd


samba> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525328384 451035136 74293248   393216 29913088 247504896
Swap: 1077469184 77119488 1000349696
MemTotal:       513016 kB
MemFree:         72552 kB
MemShared:         384 kB
Buffers:         29212 kB
Cached:         200304 kB
SwapCached:      41400 kB
Active:         151752 kB
Inact_dirty:     41652 kB
Inact_clean:     77896 kB
Inact_target:   104776 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513016 kB
LowFree:         72552 kB
SwapTotal:     1052216 kB
SwapFree:       976904 kB

samba> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525328384 460922880 64405504   393216 29913088 247582720
Swap: 1077469184 77119488 1000349696
MemTotal:       513016 kB
MemFree:         62896 kB
MemShared:         384 kB
Buffers:         29212 kB
Cached:         200380 kB
SwapCached:      41400 kB
Active:         151752 kB
Inact_dirty:     41728 kB
Inact_clean:     77896 kB
Inact_target:   104776 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513016 kB
LowFree:         62896 kB
SwapTotal:     1052216 kB
SwapFree:       976904 kB
samba> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525328384 469659648 55668736   393216 29913088 247713792
Swap: 1077469184 77119488 1000349696
MemTotal:       513016 kB
MemFree:         54364 kB
MemShared:         384 kB
Buffers:         29212 kB
Cached:         200508 kB
SwapCached:      41400 kB
Active:         150868 kB
Inact_dirty:     42740 kB
Inact_clean:     77896 kB
Inact_target:   104776 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513016 kB
LowFree:         54364 kB
SwapTotal:     1052216 kB
SwapFree:       976904 kB
samba> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525328384 476512256 48816128   393216 29913088 247963648
Swap: 1077469184 77119488 1000349696
MemTotal:       513016 kB
MemFree:         47672 kB
MemShared:         384 kB
Buffers:         29212 kB
Cached:         200752 kB
SwapCached:      41400 kB
Active:         151044 kB
Inact_dirty:     42808 kB
Inact_clean:     77896 kB
Inact_target:   104776 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513016 kB
LowFree:         47672 kB
SwapTotal:     1052216 kB
SwapFree:       976904 kB
samba> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525328384 469082112 56246272   393216 29913088 247996416
Swap: 1077469184 77119488 1000349696
MemTotal:       513016 kB
MemFree:         54928 kB
MemShared:         384 kB
Buffers:         29212 kB
Cached:         200784 kB
SwapCached:      41400 kB
Active:         151068 kB
Inact_dirty:     42816 kB
Inact_clean:     77896 kB
Inact_target:   104776 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513016 kB
LowFree:         54928 kB
SwapTotal:     1052216 kB
SwapFree:       976904 kB
samba> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525328384 461758464 63569920   393216 29925376 247906304
Swap: 1077469184 77119488 1000349696
MemTotal:       513016 kB
MemFree:         62080 kB
MemShared:         384 kB
Buffers:         29224 kB
Cached:         200696 kB
SwapCached:      41400 kB
Active:         149056 kB
Inact_dirty:     44752 kB
Inact_clean:     77896 kB
Inact_target:   104776 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513016 kB
LowFree:         62080 kB
SwapTotal:     1052216 kB
SwapFree:       976904 kB
samba> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525328384 470618112 54710272   413696 29925376 247971840
Swap: 1077469184 77119488 1000349696
MemTotal:       513016 kB
MemFree:         53428 kB
MemShared:         404 kB
Buffers:         29224 kB
Cached:         200760 kB
SwapCached:      41400 kB
Active:         149076 kB
Inact_dirty:     44816 kB
Inact_clean:     77896 kB
Inact_target:   104776 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513016 kB
LowFree:         53428 kB
SwapTotal:     1052216 kB
SwapFree:       976904 kB

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
