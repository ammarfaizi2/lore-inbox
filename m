Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbTLHNil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTLHNil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:38:41 -0500
Received: from intra.cyclades.com ([64.186.161.6]:6808 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265400AbTLHNiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:38:20 -0500
Date: Mon, 8 Dec 2003 11:22:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: bad performance on 2.4.23
In-Reply-To: <3FD2FDE3.9060909@wanadoo.es>
Message-ID: <Pine.LNX.4.44.0312081101030.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Dec 2003, Xose Vazquez Perez wrote:

> Maybe you are interested:
> 
> -------- Original Message --------
> Subject: bad performance on 2.4.23
> Date: Sun, 30 Nov 2003 04:15:51 +0100
> From: Xose Vazquez Perez <xose@wanadoo.es>
> To: ext3-users@redhat.com
> 
> hi,
> 
> - big and ugly mail. If you don't like them, delete it now :-) -
> 
> I have collected and classified some information of:
> http://home.earthlink.net/~rwhron/kernel/bigbox.html
> 
> And I observed that ext3 performance is worse than previous
> kernels(2.4.19...). -ac and -aa are here only as reference.
> 
> Complete information is in the upper URL.
> 
> 
> dbench: Performance is worse.
> 
> dbench (Numbers are in MB/second, so bigger is better)
> ======
> 
> dbench-1.3 ext3 192 processes 	Average		+/- MB/sec
> 
> 2.4.20-rc1aa1                    79.3               5.3
> 2.4.19                           61.1               1.1
> 2.4.21-pre4-ac3                  60.1		    1.7
> 2.4.20-rc1                       60.6               3.2
> 2.4.21-rc6-ac1                   49.9		    7.5
> 2.4.23-rc1                       45.4               0.8
> 2.4.22aa1                        40.3		   11.2
> 2.4.18                           27.0               0.3
> 
> dbench-1.3 ext3 64 processes 	Averag		+/- MB/sec
> 
> 2.4.20-rc1aa1                   102.6              16.0
> 2.4.21-rc6-ac1                   86.1  		   14.5
> 2.4.21-pre4-ac3                  84.9		   14.6
> 2.4.19                           83.6              12.8
> 2.4.20-rc1                       81.3              12.4
> 2.4.22aa1                        75.2		    4.8
> 2.4.23-rc1                       72.6               6.2
> 2.4.18                           64.2               3.7
> 
> - tbench: Performance is worse than previous kernels, but not too much.
> 
> tbench (Numbers are in MB/second, so bigger is better)
> ======
> 
> tbench-1.3 192 processes	Average		+/- MB/sec
> 
> 2.4.22aa1                        136.8             1.9
> 2.4.20-rc1aa1                    105.4             3.4
> 2.4.21-rc6-ac1               	 103.4		   2.8
> 2.4.21-pre4-ac3              	 101.7		   2.1
> 2.4.18                         	  29.8		   0.1
> 2.4.19                       	  29.6		   0.1
> 2.4.20-rc1                        28.1		   0.2
> 2.4.23-rc1                        26.4             0.3
> 
> tbench-1.3 64 processes   	Average		+/- MB/sec
> 
> 2.4.22aa1                        135.2             5.4
> 2.4.20-rc1aa1                    109.9             3.2
> 2.4.21-rc6-ac1                	 105.1		   3.1
> 2.4.21-pre4-ac3                	 104.7		   2.3
> 2.4.18                         	 101.8		   1.8
> 2.4.19                           100.2             2.6
> 2.4.20-rc1                     	  96.5		   2.8
> 2.4.23-rc1                        94.8             2.4
> 
> - tiobench(ext3):


I believe the average slowdowns between 2.4.20 and 2.4.23 have been caused
by the interactivity changes done in the IO scheduler. They throttle 
writers earlier. Jens?

About the high numbers on -ac and -aa:

-ac includes rmap and the drop_behind() logic (I just posted the patch
against 2.4.23 to lkml). I believe its the reason for the read slowdowns
reported on lkml.

-aa includes this patch which will increase the max readahead 
significantly. Mind trying it?

--- ./drivers/ide/ide-probe.c.~1~       Fri Mar 29 13:35:36 2002
+++ ./drivers/ide/ide-probe.c   Fri Mar 29 16:30:51 2002
@@ -813,7 +813,10 @@
                 * IDE can do up to 128K per request == 256
                 */
                *max_sect++ = ((hwif->chipset == ide_pdc4030) ? 127 : 
128);
-               *max_ra++ = vm_max_readahead;
+               *max_ra = (128 >> (PAGE_SHIFT - 10)) - 1; /* sequential  read with 128k large DMA */
+               if (hwif->chipset == ide_pdc4030)
+                       *max_ra = (127 >> (PAGE_SHIFT - 10)) - 1; /* sequential read with 127k large DMA */
+               max_ra++;
        }


        for (unit = 0; unit < units; ++unit)
--- ./mm/filemap.c.~1~  Fri Mar 29 15:58:52 2002
+++ ./mm/filemap.c      Fri Mar 29 16:27:21 2002
@@ -46,7 +46,7 @@
 unsigned int page_hash_bits;
 struct page **page_hash_table;

-int vm_max_readahead = 31;
+int vm_max_readahead = (512 >> (PAGE_SHIFT - 10)) - 1; /* sequential read with 512k large DMA */
 int vm_min_readahead = 3;
 EXPORT_SYMBOL(vm_max_readahead);
 EXPORT_SYMBOL(vm_min_readahead);


-aa also changes increases the bdflush activation from 30 to 50: 

ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa1/00_bdflush-tuning-1

> In 'Sequential Reads' and 'Sequential Writes', 'Maximum Latency' is _too much high_
> 
> tiobench
> ========
> 
> Sequential Reads ext3
>                               File  Blk   Num                    Avg       Maximum     Lat%     Lat%    CPU
> Kernel                        Size  Size  Thr   Rate  (CPU%)   Latency     Latency      &2s     &10s    Eff
> ---------------------------- ------ ----- ---  ------------------------------------------------------------
> 2.4.20-pre10                  8192  4096    1   37.28 21.64%     0.312      135.50  0.00000  0.00000    172
> 2.4.20-pre8                   8192  4096    1   37.34 21.38%     0.311      133.76  0.00000  0.00000    175
> 2.4.20-rc1                    8192  4096    1   37.36 21.44%     0.311      421.18  0.00000  0.00000    174
> 2.4.21-pre4-ac3               8192  4096    1   30.50 16.92%     0.382      549.18  0.00000  0.00000    180
> 2.4.21-pre4aa1                8192  4096    1   50.38 28.03%     0.230      529.88  0.00000  0.00000    180
> 2.4.21-rc6-ac1                8192  4096    1   31.17 17.28%     0.373      856.73  0.00000  0.00000    180
> 2.4.22-pre7aa1                8192  4096    1   49.77 28.51%     0.233      660.13  0.00000  0.00000    175
> 2.4.22aa1                     8192  4096    1   50.60 28.60%     0.229      791.48  0.00000  0.00000    177
> 2.4.23-pre4                   8192  4096    1   27.65 14.80%     0.421      761.52  0.00000  0.00000    187
> 2.4.23-rc1                    8192  4096    1   27.54 14.89%     0.423      731.87  0.00000  0.00000    185
> 
> 2.4.20-pre10                  8192  4096  256    7.20  4.92%   358.227    46127.19  5.62634  0.02361    146
> 2.4.20-pre8                   8192  4096  256    7.42  5.07%   343.312    43765.93  5.46589  0.02732    146
> 2.4.20-rc1                    8192  4096  256    7.14  4.87%   360.645    43486.21  5.66969  0.02255    147
> 2.4.21-pre4-ac3               8192  4096  256    7.08  4.56%   335.749    43307.31  5.60594  0.01083    155
> 2.4.21-pre4aa1                8192  4096  256    8.09  9.48%   204.764   696991.89  0.59543  0.44203     85
> 2.4.21-rc6-ac1                8192  4096  256    7.86 16.80%   292.629   939153.21  0.77891  0.54994     47
> 2.4.22-pre7aa1                8192  4096  256    7.04 16.77%   418.784    84440.45  2.40402  2.22159     42
> 2.4.22aa1                     8192  4096  256    6.69 14.81%   443.855    63577.04  2.40921  2.29164     45
> 2.4.23-pre4                   8192  4096  256    5.10  6.83%   430.551  1602091.53  0.35501  0.31585     75
> 2.4.23-rc1                    8192  4096  256    5.04  6.94%   432.486  1937701.66  0.33408  0.29884     73

Now this is really odd. When did it started happening?

> 
> Random Reads ext3
>                               File  Blk   Num                    Avg       Maximum     Lat%     Lat%    CPU
> Kernel                        Size  Size  Thr   Rate  (CPU%)   Latency     Latency      &2s     &10s    Eff
> ---------------------------- ------ ----- ---  ------------------------------------------------------------
> 2.4.20-pre10                  8192  4096    1    0.95  0.81%    12.341       75.99  0.00000  0.00000    117
> 2.4.20-pre8                   8192  4096    1    0.96  1.23%    12.185       62.69  0.00000  0.00000     78
> 2.4.20-rc1                    8192  4096    1    0.96  0.96%    12.176       46.93  0.00000  0.00000    100
> 2.4.21-pre4-ac3               8192  4096    1    0.91  1.09%    12.859      112.29  0.00000  0.00000     84
> 2.4.21-pre4aa1                8192  4096    1    0.91  0.93%    12.879      116.53  0.00000  0.00000     98
> 2.4.21-rc6-ac1                8192  4096    1    0.95  0.81%    12.295       41.46  0.00000  0.00000    117
> 2.4.22-pre7aa1                8192  4096    1    0.90  0.98%    13.014      335.35  0.00000  0.00000     92
> 2.4.22aa1                     8192  4096    1    0.92  1.01%    12.797      111.10  0.00000  0.00000     90
> 2.4.23-pre4                   8192  4096    1    0.91  0.88%    12.817       99.40  0.00000  0.00000    104
> 2.4.23-rc1                    8192  4096    1    0.89  0.82%    13.118      123.33  0.00000  0.00000    109
> 
> 2.4.20-pre10                  8192  4096  256    2.33  4.40%   661.619    18451.11 12.91666  0.00000     53
> 2.4.20-pre8                   8192  4096  256    2.35  3.34%   678.482    18276.93 12.99479  0.00000     70
> 2.4.20-rc1                    8192  4096  256    2.32  2.67%   672.370    18505.69 12.81250  0.00000     87
> 2.4.21-pre4-ac3               8192  4096  256    2.35  2.40%   668.279    18366.33 12.99479  0.00000     98
> 2.4.21-pre4aa1                8192  4096  256    3.31  5.30%   485.616    10704.34  5.72916  0.00000     62
> 2.4.21-rc6-ac1                8192  4096  256    2.26  4.72%   700.081    18934.72 12.78646  0.00000     48
> 2.4.22-pre7aa1                8192  4096  256    3.38  6.16%   671.347     8870.86  5.20833  0.00000     55
> 2.4.22aa1                     8192  4096  256    3.22 11.08%   785.687     1793.92  0.00000  0.00000     29
> 2.4.23-pre4                   8192  4096  256    2.20  4.49%   839.345     5697.90  0.00000  0.00000     49
> 2.4.23-rc1                    8192  4096  256    2.28  4.10%   878.192     2519.29  0.00000  0.00000     56
> 
> Sequential Writes ext3
>                               File  Blk   Num                    Avg       Maximum     Lat%     Lat%    CPU
> Kernel                        Size  Size  Thr   Rate  (CPU%)   Latency     Latency      &2s     &10s    Eff
> ---------------------------- ------ ----- ---  ------------------------------------------------------------
> 2.4.20-pre10                  8192  4096    1   37.71 56.08%     0.288     4315.58  0.00000  0.00000     67
> 2.4.20-pre8                   8192  4096    1   37.80 53.97%     0.287     4157.16  0.00000  0.00000     70
> 2.4.20-rc1                    8192  4096    1   37.68 55.47%     0.288     4225.93  0.00000  0.00000     68
> 2.4.21-pre4-ac3               8192  4096    1   37.36 46.88%     0.290     3403.73  0.00000  0.00000     80
> 2.4.21-pre4aa1                8192  4096    1   40.48 49.75%     0.251      909.26  0.00000  0.00000     81
> 2.4.21-rc6-ac1                8192  4096    1   34.55 42.89%     0.326    15687.97  0.00397  0.00000     81
> 2.4.22-pre7aa1                8192  4096    1   43.37 56.97%     0.235     3174.53  0.00005  0.00000     76
> 2.4.22aa1                     8192  4096    1   44.25 57.99%     0.230      718.76  0.00000  0.00000     76
> 2.4.23-pre4                   8192  4096    1   41.66 57.58%     0.264     1032.96  0.00000  0.00000     72
> 2.4.23-rc1                    8192  4096    1   39.69 54.68%     0.278      730.02  0.00000  0.00000     73
> 
> 2.4.20-pre10                  8192  4096  256    9.94 71.13%   134.323    61604.97  2.87437  0.03022     14
> 2.4.20-pre8                   8192  4096  256    9.88 75.43%   133.434    62461.37  2.83661  0.03186     13
> 2.4.20-rc1                    8192  4096  256    9.97 73.84%   133.300    65690.42  2.93164  0.02885     14
> 2.4.21-pre4-ac3               8192  4096  256    9.22 44.18%   134.944    36902.34  2.99883  0.00290     21
> 2.4.21-pre4aa1                8192  4096  256    7.38 41.41%   168.063   151496.74  2.74157  0.28987     18
> 2.4.21-rc6-ac1                8192  4096  256    4.96 25.59%   284.662   387169.56  2.23074  0.83136     19
> 2.4.22-pre7aa1                8192  4096  256    8.66 49.63%   142.657    83844.75  2.59070  0.11811     17
> 2.4.22aa1                     8192  4096  256   12.57 65.96%   117.692    29694.33  1.48821  0.00000     19
> 2.4.23-pre4                   8192  4096  256    9.46 53.32%   150.534   172363.64  2.09446  0.27799     18
> 2.4.23-rc1                    8192  4096  256    9.09 50.56%   160.462   161442.23  2.30537  0.28430     18
> 
> Random Writes ext3
>                               File  Blk   Num                    Avg       Maximum     Lat%     Lat%    CPU
> Kernel                        Size  Size  Thr   Rate  (CPU%)   Latency     Latency      &2s     &10s    Eff
> ---------------------------- ------ ----- ---  ------------------------------------------------------------
> 2.4.20-pre10                  8192  4096    1    3.72  3.81%     0.080        0.68  0.00000  0.00000     98
> 2.4.20-pre8                   8192  4096    1    3.71  3.25%     0.079        0.70  0.00000  0.00000    114
> 2.4.20-rc1                    8192  4096    1    3.72  3.81%     0.080        0.71  0.00000  0.00000     98
> 2.4.21-pre4-ac3               8192  4096    1    3.72  3.33%     0.082        0.62  0.00000  0.00000    112
> 2.4.21-pre4aa1                8192  4096    1    4.49  4.98%     0.067        0.68  0.00000  0.00000     90
> 2.4.21-rc6-ac1                8192  4096    1    3.85  3.69%     0.082        0.64  0.00000  0.00000    104
> 2.4.22-pre7aa1                8192  4096    1    4.60  5.11%     0.082        1.20  0.00000  0.00000     90
> 2.4.22aa1                     8192  4096    1    4.61  5.81%     0.083        1.08  0.00000  0.00000     79
> 2.4.23-pre4                   8192  4096    1    3.94  5.05%     0.086        0.64  0.00000  0.00000     78
> 2.4.23-rc1                    8192  4096    1    3.94  5.04%     0.087        0.62  0.00000  0.00000     78
> 
> 2.4.20-pre10                  8192  4096  256    3.63 10.31%     0.482      273.57  0.00000  0.00000     35
> 2.4.20-pre8                   8192  4096  256    3.62 13.36%     0.599      372.91  0.00000  0.00000     27
> 2.4.20-rc1                    8192  4096  256    3.62 10.86%     0.478      247.68  0.00000  0.00000     33
> 2.4.21-pre4-ac3               8192  4096  256    3.62 10.94%     0.255        3.48  0.00000  0.00000     33
> 2.4.21-pre4aa1                8192  4096  256    4.39 30.16%     0.199        6.97  0.00000  0.00000     15
> 2.4.21-rc6-ac1                8192  4096  256    3.68 17.09%     0.260        1.39  0.00000  0.00000     22
> 2.4.22-pre7aa1                8192  4096  256    4.45 31.24%     0.241        7.13  0.00000  0.00000     14
> 2.4.22aa1                     8192  4096  256    4.44 21.90%     0.247        7.29  0.00000  0.00000     20
> 2.4.23-pre4                   8192  4096  256    3.83 29.77%     0.248       55.60  0.00000  0.00000     13
> 2.4.23-rc1                    8192  4096  256    3.77 29.99%     0.256       59.45  0.00000  0.00000     13
> 
> - bonnie++-1.02c(ext3): Performance is a little worse than previous kernels.
> 
> bonnie++-1.02c on ext3
> ==============
>                       --------------------- Sequential Output ------------------  -------- Sequential Input ----------   ----- Random -----
>                       ---- Per Char -----  ------ Block ----- ---- Rewrite ----   ---- Per Char ---  ----- Block -----   ----- Seeks  -----
> Kernel          Size  MB/sec   %CPU   Eff  MB/sec   %CPU  Eff MB/sec  %CPU  Eff   MB/sec  %CPU  Eff  MB/sec  %CPU  Eff    /sec  %CPU   Eff
> 
> 2.4.18          8192    9.03   99.0  9.12   28.65   38.3   75 18.35  25.0   73     9.13  96.3  9.5   30.40  18.0  169   383.9  2.67  14396
> 2.4.19          8192    8.97   98.0  9.15   41.43   51.3   81 19.94  21.0   95     9.15  97.0  9.4   30.85  18.3  168   385.9  2.33  16540
> 2.4.20-rc1      8192    8.85   97.0  9.12   41.20   52.3   79 19.78  21.0   94     9.16  97.0  9.4   30.71  18.3  167   617.7  5.00  12355
> 2.4.21-rc6-ac1  8192    7.92   87.0  9.10   43.34   47.0   92 17.38  17.0  102     9.38  99.0  9.5   31.04  14.0  222   604.0  2.67  22650
> 2.4.21-pre4-ac3 8192    8.85   97.0  9.13   41.51   45.3   92 17.02  16.0  106     9.37  99.0  9.5   31.41  14.7  214   614.5  3.00  20482
> 2.4.22aa1       8192    8.92   95.0  9.39   51.80   57.7   90 22.52  23.7   95     8.82  91.0  9.7   51.78  26.3  197   560.9  3.00  18698
> 2.4.23-rc1      8192    8.95   97.0  9.23   42.71   50.7   84 15.09  14.0  108     7.64  78.7  9.7   28.63  13.0  220   579.1  2.33  24819
> 
>                         ----------------------Sequential---------------------  ------------------------ Random -----------------------
>                         ----- Create -----  ----- Read -----  ----Delete ----  ----- Create ----   ----- Read -----   ---- Delete ----
>                 files   /sec  %CPU    Eff  /sec  %CPU   Eff  /sec %CPU   Eff   /sec  %CPU   Eff    /sec  %CPU   Eff  /sec  %CPU   Eff
> 
> 2.4.18          65536    127  99.0    128     na   na    na 29074  97.0  2997    127  99.0   128      na    na    na   488  96.0   508
> 2.4.19          65536    126  99.0    127     na   na    na 30095  96.7  3113    129  99.0   130      na    na    na   490  96.0   511
> 2.4.20-rc1      65536    124  99.0    125     na   na    na 28556  99.7  2865    130  99.0   131      na    na    na   483  96.0   503
> 2.4.21-rc6-ac1  65536    121  94.7    128     na   na    na 26040  94.7  2750    121  95.0   128      na    na    na   450  89.3   504
> 2.4.21-pre4-ac3 65536    129  99.0    130     na   na    na 27719  97.7  2838    127  99.0   129      na    na    na   475  96.0   494
> 2.4.22aa1       65536    119  94.7    125     na   na    na 27655  95.0  2911    123  95.0   129      na    na    na   443  90.7   488
> 2.4.23-rc1      65536    124  94.7    131     na   na    na 26297 100.0  2629    121  95.0   128      na    na    na   442  89.0   497
> 
> 
> is there any reasonable explication ?
> 
> -thanks-
> 


