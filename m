Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbTAPBgW>; Wed, 15 Jan 2003 20:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTAPBgW>; Wed, 15 Jan 2003 20:36:22 -0500
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:16523 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266964AbTAPBgU>; Wed, 15 Jan 2003 20:36:20 -0500
Date: Wed, 15 Jan 2003 20:50:23 -0500
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: big ext3 sequential write improvement in 2.5.51-mm1 gone in 2.5.53-mm1?
Message-ID: <20030116015023.GA5439@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a quad xeon running tiobench...
The throughput and max latency for ext3 sequential writes
looks very good when threads >= 2 on 2.5.51-mm1.

Did 2.5.51-mm1 mount ext3 as ext2?  I have ext2 logs for
2.5.51-mm1 and they look similar to the ext3 results.
The other 2.5 kernels from around that time look more
like 2.5.53-mm1.

file size = 8192 megs
block size = 4096 bytes
rate in megabytes/second
latency in milliseconds

Sequential Writes
              Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier    Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
------------  ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51-mm1      1   55.58 46.70%     0.234    18461.07   0.00834  0.00000   119
2.5.51-mm1      2   38.00 31.54%     0.563    18460.95   0.00896  0.00000   120
2.5.51-mm1      4   35.28 32.69%     1.041    84910.77   0.01306  0.00057   108
2.5.51-mm1      8   34.86 32.97%     2.090   113261.88   0.02433  0.00387   106
2.5.51-mm1     16   34.79 32.80%     3.786   216278.13   0.02923  0.01054   106
2.5.51-mm1     32   33.25 32.31%     7.083   331456.04   0.03152  0.01411   103
2.5.51-mm1     64   31.77 32.14%    14.020   604095.22   0.03772  0.02094    99
2.5.51-mm1    128   30.59 31.60%    25.436   653761.04   0.04019  0.02298    97
2.5.51-mm1    256   32.45 34.83%    47.633   598925.79   0.06914  0.04615    93

Sequential Writes
              Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier    Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
------------  ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53-mm1      1   52.74 68.60%     0.604    19544.48   0.01731  0.00000    77
2.5.53-mm1      2    2.70 4.951%     7.589    54571.99   0.12716  0.00739    55
2.5.53-mm1      4    2.78 34.78%    13.966   467805.71   0.16842  0.03018     8
2.5.53-mm1      8    2.93 59.73%    26.819  1008655.17   0.19922  0.04420     5
2.5.53-mm1     16    3.14 26.13%    45.610  1939797.82   0.14705  0.05607    12
2.5.53-mm1     32    3.35 19.17%    80.421  3055837.66   0.12188  0.04888    17
2.5.53-mm1     64    3.43 15.13%   163.323  4284106.34   0.11868  0.05264    23
2.5.53-mm1    128    3.66 20.04%   260.372  5148947.62   0.12889  0.04530    18
2.5.53-mm1    256    4.26 20.30%   382.981  3094442.29   0.20232  0.06323    21

There is another odd thing in some of the 2.5 ext3 results.  Several of the
kernels show a jump in throughput at 256 threads. 

Sequential Writes
              Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier    Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
------------  ---  ------ ------ --------- -----------  -------- -------- -----
2.5.56          1   53.17 69.99%     0.194    36612.36   0.00029  0.00005    76
2.5.56          2    2.53 4.728%     7.549  1219600.59   0.05112  0.00205    53
2.5.56          4    2.58 73.97%    15.141   823168.02   0.05078  0.01531     3
2.5.56          8    2.67 179.9%    29.981   641722.67   0.07091  0.04382     1
2.5.56         16    3.34 136.6%    47.075  1416051.92   0.11807  0.09304     2
2.5.56         32    2.93 124.8%   100.112  1842078.09   0.18826  0.14262     2
2.5.56         64    3.66 37.46%   147.693  4216304.67   0.12394  0.06661    10
2.5.56        128    4.01 17.11%   237.592  4194864.65   0.10777  0.05642    23
2.5.56        256   12.64 48.78%   353.895  3741404.43   0.10434  0.05335    26

2.4 has a more gentle degradation in throughput and max latency for seq writes 
on ext3:

Sequential Writes
              Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier    Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
------------- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre10    1   37.71 56.08%     0.288     4315.58   0.00000  0.00000    67
2.4.20-pre10    2   33.01 98.65%     0.592     5517.10   0.00010  0.00000    33
2.4.20-pre10    4   30.83 153.3%     1.162     3684.74   0.00000  0.00000    20
2.4.20-pre10    8   24.86 126.9%     2.523     7436.22   0.00058  0.00000    20
2.4.20-pre10   16   21.21 104.0%     4.893     9132.94   0.00992  0.00000    20
2.4.20-pre10   32   18.14 97.27%    10.394    13451.42   0.09843  0.00000    19
2.4.20-pre10   64   15.63 90.39%    22.679    18888.44   0.39897  0.00000    17
2.4.20-pre10  128   12.03 78.06%    54.387    31156.69   1.12638  0.00038    15
2.4.20-pre10  256    9.94 71.13%   134.323    61604.97   2.87437  0.03022    14

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

