Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319388AbSHQJ5r>; Sat, 17 Aug 2002 05:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319393AbSHQJ5r>; Sat, 17 Aug 2002 05:57:47 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:5328 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319388AbSHQJ5p>; Sat, 17 Aug 2002 05:57:45 -0400
Date: Sat, 17 Aug 2002 06:05:07 -0400
To: green@namesys.com
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] big reiserfs regression in 2.4.20-pre2
Message-ID: <20020817100507.GA10770@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oleg Drokin <green @ namesys . com> wrote:
>   Is regression going away if you pass this mount option to reiserfs:
>      -o alloc=preallocmin=4:preallocsize=9

Yes.  

On a quad xeon with 3.75 gb ram there is a regression on reiserfs
in dbench and tiobench with many threads between 2.4.20-pre1 and 2.4.20-pre2.  
With alloc=preallocmin=4:preallocsize=9 mount option, throughput in pre2
is improved over pre1.

16% improvement instead of 23% regression at 192 processes

dbench reiserfs 192 processes	Average		High		Low
2.4.20-pre1              	 55.94		 58.17		 54.26
2.4.20-pre2              	 42.98		 44.73		 42.30
2.4.20-pre2-oleg         	 64.95		 66.72		 63.36


9% improvement instead of 13% regression at 64 processes.

dbench reiserfs 64 processes	Average		High		Low
2.4.20-pre1              	 70.98		 72.53		 69.47
2.4.20-pre2              	 61.93		 64.01		 57.31
2.4.20-pre2-oleg         	 77.32		 80.89		 74.95

tiobench-0.3.3
Unit information
================
File size = 12288 megabytes
Blk Size  = 4096 bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

tiobench has a 5-8% improvement instead of ~70% regression on seq read
throughput.  Latency numbers are affected too.

Sequential Reads reiserfs
                   Num                    Avg       Maximum     Lat%     Lat%  CPU
Kernel             Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s  Eff
------------------ ---  ----------------------------------------------------------
2.4.20-pre1          1   35.11 23.02%     0.331      107.07  0.00000  0.00000  152
2.4.20-pre2          1   34.68 22.83%     0.335      119.57  0.00000  0.00000  152
2.4.20-pre2-oleg     1   34.33 22.14%     0.339      105.78  0.00000  0.00000  155

2.4.20-pre1         32   27.27 20.12%    11.536   258436.68  0.01275  0.01135  136
2.4.20-pre2         32    8.00  6.05%    43.881     7568.44  0.00096  0.00000  132
2.4.20-pre2-oleg    32   28.72 21.72%    11.138   343417.50  0.00893  0.00801  132

2.4.20-pre1         64   26.50 19.63%    21.328   361756.08  0.02183  0.02053  135
2.4.20-pre2         64    8.42  6.46%    79.039    15721.84  0.18813  0.00000  130
2.4.20-pre2-oleg    64   29.98 22.19%    18.659   467771.18  0.01456  0.01335  135

2.4.20-pre1        128   27.72 21.17%    35.485   814716.92  0.02671  0.02549  131
2.4.20-pre2        128    9.30  7.10%   135.056    32520.09  3.92532  0.00035  131
2.4.20-pre2-oleg   128   27.71 21.14%    35.468   828979.66  0.02130  0.02066  131

2.4.20-pre1        256   26.55 19.95%    68.425   825224.03  0.04636  0.04515  133
2.4.20-pre2        256    8.47  6.49%   285.430    62013.50  4.68931  0.11676  131
2.4.20-pre2-oleg   256   28.64 22.36%    61.458   950604.45  0.03516  0.03408  128

Random Reads on reiserfs also improved instead of regressed with mount option.

                   Num                    Avg       Maximum     Lat%     Lat%  CPU
Kernel             Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s  Eff
------------------ ---  ----------------------------------------------------------
2.4.20-pre1          1    0.68  0.84%    17.320       51.54  0.00000  0.00000   81
2.4.20-pre2          1    0.70  0.76%    16.787       53.99  0.00000  0.00000   92
2.4.20-pre2-oleg     1    0.70  0.98%    16.619       43.82  0.00000  0.00000   72

2.4.20-pre1         32    3.09  6.80%   102.783      535.46  0.00000  0.00000   46
2.4.20-pre2         32    1.98  3.84%   147.780    16015.44  0.55000  0.00000   52
2.4.20-pre2-oleg    32    3.39  5.63%    92.170      502.70  0.00000  0.00000   60

2.4.20-pre1         64    3.10  5.99%   178.641    10722.38  0.50403  0.00000   52
2.4.20-pre2         64    2.18  3.70%   229.511    16850.53  2.77218  0.00000   59
2.4.20-pre2-oleg    64    3.48  7.41%   168.446    10493.64  0.22682  0.00000   47

2.4.20-pre1        128    3.35  5.27%   226.876     9018.16  1.91532  0.00000   64
2.4.20-pre2        128    2.31  3.98%   378.511    17932.69  5.77117  0.00000   58
2.4.20-pre2-oleg   128    3.39  5.54%   250.196    10655.95  3.09980  0.00000   61

2.4.20-pre1        256    3.26  6.44%   249.264     5751.33  0.57292  0.00000   51
2.4.20-pre2        256    2.20  5.53%   724.340    19268.40 13.09896  0.00000   40
2.4.20-pre2-oleg   256    3.60  7.93%   230.657     6055.77  0.10417  0.00000   45

Sequential Writes reiserfs
                   Num                    Avg       Maximum     Lat%     Lat%  CPU
Kernel             Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s  Eff
------------------ ---  ----------------------------------------------------------
2.4.20-pre1          1   39.31 71.71%     0.282     6301.59  0.00012  0.00000   55
2.4.20-pre2          1   38.28 73.39%     0.290     8058.03  0.00019  0.00000   52
2.4.20-pre2-oleg     1   38.01 70.29%     0.293     6619.27  0.00009  0.00000   54

2.4.20-pre1         32   29.64 119.5%    11.171    16619.06  0.18094  0.00000   25
2.4.20-pre2         32   23.52 103.0%    10.242    17721.55  0.13629  0.00000   23
2.4.20-pre2-oleg    32   29.49 117.0%    11.299    17672.19  0.17456  0.00000   25

2.4.20-pre1         64   29.02 115.6%    22.065    38792.62  0.38675  0.00426   25
2.4.20-pre2         64   20.92 84.06%    19.449    41273.31  0.33824  0.00480   25
2.4.20-pre2-oleg    64   30.07 108.3%    21.271    46079.52  0.35420  0.01504   28

2.4.20-pre1        128   31.52 111.6%    36.264   104743.20  0.40728  0.11428   28
2.4.20-pre2        128   22.31 87.18%    36.251    78916.66  0.46791  0.10154   26
2.4.20-pre2-oleg   128   30.70 109.9%    38.972   110734.31  0.46263  0.11740   28

2.4.20-pre1        256   28.95 132.7%    75.959   163159.61  0.79301  0.24067   22
2.4.20-pre2        256   20.08 93.50%    74.113   114883.50  0.83399  0.23864   21
2.4.20-pre2-oleg   256   29.69 125.8%    75.775   177649.14  0.73569  0.24844   24

Random Writes reiserfs
                   Num                    Avg       Maximum     Lat%     Lat%  CPU
Kernel             Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s  Eff
------------------ ---  ----------------------------------------------------------
2.4.20-pre1          1    3.57  3.80%     0.091        0.57  0.00000  0.00000   94
2.4.20-pre2          1    3.63  3.79%     0.089        0.68  0.00000  0.00000   96
2.4.20-pre2-oleg     1    3.62  3.78%     0.091        0.73  0.00000  0.00000   96

2.4.20-pre1         32    3.52  9.15%     0.654      268.43  0.00000  0.00000   38
2.4.20-pre2         32    3.57  8.15%     0.377      258.42  0.00000  0.00000   44
2.4.20-pre2-oleg    32    3.66  9.44%     0.268       73.53  0.00000  0.00000   39

2.4.20-pre1         64    3.68  9.50%     0.567      196.77  0.00000  0.00000   39
2.4.20-pre2         64    3.78  9.76%     0.450      319.24  0.00000  0.00000   39
2.4.20-pre2-oleg    64    3.85  9.36%     0.446      258.01  0.00000  0.00000   41

2.4.20-pre1        128    3.48  8.38%     2.923      626.60  0.00000  0.00000   42
2.4.20-pre2        128    3.54  8.98%     0.669      735.87  0.00000  0.00000   39
2.4.20-pre2-oleg   128    3.48  9.20%     0.794      742.98  0.00000  0.00000   38

2.4.20-pre1        256    3.45  9.11%     3.416      572.87  0.00000  0.00000   38
2.4.20-pre2        256    3.59 10.12%     1.350      824.15  0.00000  0.00000   35
2.4.20-pre2-oleg   256    3.58  9.06%     1.938      841.72  0.00000  0.00000   39


More details at:
http://home.earthlink.net/~rwhron/kernel/bigbox.html
-- 
Randy Hron

