Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289802AbSAKA0k>; Thu, 10 Jan 2002 19:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289803AbSAKA01>; Thu, 10 Jan 2002 19:26:27 -0500
Received: from proxy.ATComputing.nl ([195.108.229.1]:63699 "EHLO
	atcmpg.ATComputing.nl") by vger.kernel.org with ESMTP
	id <S289802AbSAKA0M>; Thu, 10 Jan 2002 19:26:12 -0500
Date: Fri, 11 Jan 2002 01:26:07 +0100
From: Daniel Tuijnman <daniel@ATComputing.nl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management problems in 2.4.16
Message-ID: <20020111012607.A5047@ATComputing.nl>
In-Reply-To: <20020109234706.B4555@ATComputing.nl> <Pine.LNX.4.33L.0201092053010.2985-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0201092053010.2985-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Jan 09, 2002 at 08:57:24PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 08:57:24PM -0200, Rik van Riel wrote:
> If you have the time,

Actually not, but I got curious...

> you could try my latest -rmap patch,
> available at:
>
> 	http://surriel.com/patches/2.4/2.4.17-rmap-11a
> 
> I've done some testing with 'mem=9m' (using a rather fat
> kernel w/ profiling) and it seems to work decently.

Thanks for pointing me to the right direction, Rik!

And thanks to Roy who pointed me to using vmstat to look at memory usage!

On a freshly booted machine, I ran

# echo "0 0" > /proc/sys/vm/pagetable_cache
# vmstat -n 5 | tee log &
# diff /var/lib/dpkg/avail*

(a 6Mb file of available Debian packages and a backup version of it).

With a 2.4.16 kernel, this gave as result:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0     36    152    276   2332   0   0    52     3  213    31   8   8  84
 0  0  0     36    444    180   2208   0   0    40     1  186    30   3   4  93
 0  0  0     36    440    180   2212   0   0     0     0  102     4   1   0  99
 0  0  0     36    440    180   2212   0   0     0     0  110    24   0   1  98
 1  0  1     36    100    124   2192   0   0   174     2  455   192   2  24  74

and then the machine hangs: no further output from vmstat...

With a 2.4.17 kernel with Riks patch, this gives:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  0    852     84    244   2916   1   4   172    15  477    47   9  10  81
 0  0  0    852     84    232   2928   0   0     0     0  103     6   1   0  99
 0  0  0    860    292    212   2784   2   2     3     2  118    23   3   3  94
 0  0  0    860    292    216   2780   0   0     0     0  110    25   0   1  99
 0  1  0   1480     84     60   1852   0 125   430   131 1223    56   2  26  72
 1  0  0   5288     84     68   1212  12 778   873   778 3494   200   0  28  72
 0  1  0   7204     84     64   1232  20 358   392   358 1530    85   2  22  77
 0  1  0   9596     88     68    980   2 538   574   539 2446   152   1  27  72
 1  0  1  11592     84     64   1016  16 362   354   363 1568    70   1  26  74
 1  0  0  11888     84     60    524 164  59   164    59  549    87   2   3  95
 1  0  0  12208     84     56    484 152 164   152   165  729    84   2   3  94
 1  0  0  12244     84     84    500 133 119   154   120  655    92   2   4  94
 2  0  0  12352     84     84    512 130 150   141   150  684    84   2   4  94
 2  0  0  12540     84    128    960  55  93   159    93  606    93   3   5  91
 1  0  0  12204     84    124   1144 124   0   165     0  435    88   2   4  94
 1  0  0  12324     84     88    972 150 102   150   104  610    86   2   3  94
 1  0  0  12516     84     52    828 158 140   158   141  698    89   3   4  93
 1  0  0  12400     84     56    776 168 139   173   140  727    97   2   4  94
 1  0  0  12416     84     52    576 151  78   151    79  561    81   3   3  94
 1  0  0  12204     84     52    516 158   1   158     1  420    79   2   3  95
 1  0  0  12312     84     52    400 138 111   138   112  600    79   1   3  95
 1  0  0  12540     84     52    296 140 121   140   121  623    79   2   4  94
 1  0  0  12496     84     52    240 142 122   143   122  629    78   2   4  94
 1  0  0  12204     84     88    332 130  35   153    35  480    84   2   3  95
 1  0  0  12204     84     64    344 154  72   154    72  554    83   3   3  94
 0  1  0  12756     84     52    320 154 112   154   113  510    78   4   4  92
 1  1  0  12880     84     72    628  97 118   159   119  776    89   2   5  93
 2  0  0  13280     84    132   1032  48 127   140   128  643    87   3   6  91
 0  0  0   2140   2472    136   1420  65  29   152    29  468    65   2   3  95

Then I got curious and compiled a vanilla 2.4.17 kernel. Which gives as
result:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0   1256    276    404   2556  16  35    84    40  350    42  15  13  72
 0  0  0   1256    260    412   2564   0   0     1     5  113     4   0   1  99
 0  0  0   1256    260    412   2564   0   0     0     0  111    27   1   1  98
 0  2  0   5352    208    148    832  34 869  1389   871 4838   163   1  24  75
 1  0  0  10832    276    140    696  33 1144  1244  1145 5057   127   0  24  75
 1  0  0  12712    172    136    228 330 357   466   357 1817   106   7  10  83
 0  2  0  12632    248     96    228 290 299   294   300 1276    80   8   7  85
 1  0  0  12204    192     96    232 364  97   366    97 1040   108  10   6  84
 2  1  0  12544    172     96    588 194 181   272   181 1003    69   5   8  87
 1  1  0  12840    216    144    756 142 186   220   186  912    67   5   7  88
 1  0  0  12328    316    164    932 198  83   274    84  827    80   8   7  84
 1  0  0  12256    264    152    732 317 200   317   200 1137    94   9   7  85
 1  1  0  12668    200    108    432 290 241   294   244 1175    88   8   6  86
 1  0  0  12204    196     76    252 357 105   359   105 1030   108   9   8  83
 1  0  0   2360   3028     88    784 198 208   311   208 1139    68   5   9  87
 0  0  0   2360   2924     96    856   5   0    18     0  140    15   0   1  98

This works actually faster, and comparable in speed to the 2.20 kernel I
was using before. So apparently, the changes between 2.4.16 and 2.4.17 suffice
to get the kernel swapping out buffercache. I hope this helps in tuning
the VM system in the right direction...

Greetings,
Daniel
