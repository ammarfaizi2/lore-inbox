Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVBKUnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVBKUnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVBKUnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:43:13 -0500
Received: from [83.102.214.158] ([83.102.214.158]:3473 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262334AbVBKUmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:42:50 -0500
X-Comment-To: Mingming Cao
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       tytso@mit.edu, pbadari@us.ibm.com, suparna@in.ibm.com,
       gerrit@us.ibm.com, tappro@clusterfs.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, alex@clusterfs.com
Subject: Re: Latest ext3 patches (extents, mballoc, delayed allocation)
References: <1106354192.3634.19.camel@dyn318043bld.beaverton.ibm.com>
	<m3hdl2lehb.fsf@bzzz.home.net> <4207BBEA.7090705@us.ibm.com>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Date: Fri, 11 Feb 2005 23:40:21 +0300
Message-ID: <m3y8dude4q.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day all, 

I've updated the patchset against 2.6.10. A bunch of bugs have been
fixed and mballoc now behaves smarter a bit. Extents and mballoc 
patches collects some stats they print upon umount. NOTE: they must
not be used to store important data. A lot of things are to be done.

Please review. Any comments and suggestions are very welcome.

The patches are too big to send in a message (previous time they got
rejected). I put them in ftp://ftp.clusterfs.com/pub/people/alex/2.6.10

The following names are used:
  ext3rs - ext3 mounted with data=writeback,reservation options
  ext3i  - ext3 mounted with extents,mballoc,delalloc options
  reiser - reiserfs v3

I did some benchmarking. Two systems were used:
  SMP - dual PIII-1GHz, 1GB, FC-connected to 2 disks raid0
  UP  - PIII-933MHz, 256MB, FC-connected to 2 disks raid0



The tests dd500 and dd1000 generate 500M and 1000M using dd on fresh fs.
Real time varies run from run because of disks, but sys.time is stable.

                      SMP                    UP
TEST / FS         real   sys             real   sys
dd500/ext2      - 9.14   2.33            19.03  2.50
dd500/ext3      - 12.23  4.06            18.99  4.19
dd500/ext3rs    - 13.39  4.01            15.08  4.16
dd500/ext3i     - 9.19   2.31            19.07  2.52
dd500/reiser    - 7.95   2.87            21.23  3.09
dd500/xfs       - 17.88  2.42            19.25  2.67

dd1000/ext2     - 37.47  4.69            44.59  5.02
dd1000/ext3     - 38.03  7.90            40.77  8.31
dd1000/ext3rs   - 34.62  7.95            40.51  8.30
dd1000/ext3i    - 33.73  4.65            38.74  4.93
dd1000/reiser   - 29.29  5.79            44.88  6.08
dd1000/xfs      - 37.11  5.03            39.98  5.27



The test untar unpacks linux-2.6.0.tar:

                      SMP                   UP 
TEST / FS         real   sys             real   sys
untar/ext2      - 9.21   2.47            27.31  2.57
untar/ext3      - 15.63  3.38            34.54  3.61
untar/ext3rs    - 15.91  3.27            35.98  3.65
untar/ext3i     - 8.33   2.70            16.75  2.84
untar/reiser    - 13.38  5.47            25.88  5.96
untar/xfs       - 44.62  5.64            51.92  4.88



The next test is dbench:

                       SMP                              UP
TEST / FS         real   sys     MB/s           real   sys     MB/s
dbench1/ext2    - 5.87   1.43    63.7256        5.93   1.54    63.79
dbench1/ext3    - 2.46   1.75    139.794        3.60   1.85    131.372
dbench1/ext3rs  - 2.46   1.73    140.378        3.55   1.85    133.071
dbench1/ext3i   - 2.19   1.48    156.976        2.28   1.53    150.403
dbench1/reiser  - 2.80   2.05    122.761        2.88   2.11    119.815
dbench1/xfs     - 2.83   1.81    122.159        2.87   1.91    119.564

dbench4/ext2    - 4.99   7.13    274.216        9.96   6.22    137.316
dbench4/ext3    - 5.79   8.64    236.858        11.49  7.40    130.146
dbench4/ext3rs  - 5.80   8.57    236.356        11.45  7.38    130.467
dbench4/ext3i   - 5.16   7.16    265.621        9.25   6.31    147.872
dbench4/reiser  - 7.11   10.85   192.491        11.85  8.59    115.392
dbench4/xfs     - 6.60   8.88    207.599        11.98  7.69    114.177

dbench8/ext2    - 16.04  14.27   181.93         18.32  12.14   149.228
dbench8/ext3    - 18.87  17.04   165.214        23.77  14.88   119.995
dbench8/ext3rs  - 11.52  17.21   237.647        23.35  15.04   123.088
dbench8/ext3i   - 11.20  14.66   268.052        21.00  12.49   130.223
dbench8/reiser  - 13.92  21.65   196.306        24.98  17.67   114.083
dbench8/xfs     - 14.84  18.23   184.263        25.84  15.53   105.743

dbench16/ext2   - 20.39  28.79   267.979        47.37  25.13   115.582
dbench16/ext3   - 25.69  34.54   212.745        53.43  30.78   102.266
dbench16/ext3rs - 24.47  34.36   223.37         54.68  30.44   100.082
dbench16/ext3i  - 22.94  29.40   238.215        44.89  25.73   121.962
dbench16/reiser - 28.56  43.86   191.407        56.48  36.41   96.9686
dbench16/xfs    - 33.49  36.94   163.159        78.68  32.56   69.4764

dbench32/ext2   - 43.54  58.87   250.947        108.1  51.24   101.354
dbench32/ext3   - 61.83  70.66   176.707        139.84 63.77   78.8818
dbench32/ext3rs - 67.24  71.69   162.651        145.03 63.38   75.5155
dbench32/ext3i  - 55.29  59.41   197.757        100.24 52.50   109.26
dbench32/reiser - 76.32  93.45   143.127        128.77 77.94   85.7179
dbench32/xfs    - 119.4  88.09   91.4746        670.45 76.19   16.298



The followins crazy listing shows tiobench's results for SMP box:

Sequential Reads
                              File  Blk   Num                   Avg     CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----
ext2                          512   4096    1   40.95 12.80%     0.095   320
ext3                          512   4096    1   45.03 13.99%     0.086   322
ext3rs                        512   4096    1   50.53 15.18%     0.077   333
ext3i                         512   4096    1   49.69 14.53%     0.078   342
reiser                        512   4096    1   29.56 12.08%     0.132   245
xfs                           512   4096    1   44.58 15.25%     0.087   292

ext2                          512   4096    2   22.36 13.21%     0.287   169
ext3                          512   4096    2   45.94 23.48%     0.108   196
ext3rs                        512   4096    2   46.29 23.57%     0.119   196
ext3i                         512   4096    2   46.96 23.83%     0.111   197
reiser                        512   4096    2   23.05 14.89%     0.252   155
xfs                           512   4096    2   55.98 30.65%     0.064   183

ext2                          512   4096    4   45.39 55.10%     0.155    82
ext3                          512   4096    4   59.16 48.85%     0.103   121
ext3rs                        512   4096    4   54.35 46.83%     0.215   116
ext3i                         512   4096    4   65.81 55.53%     0.119   119
reiser                        512   4096    4   26.35 32.38%     0.369    81
xfs                           512   4096    4   71.81 66.22%     0.113   108

Random Reads
                              File  Blk   Num                   Avg     CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----
ext2                          512   4096    1  119.05 40.37%     0.031   295
ext3                          512   4096    1  134.78 37.08%     0.028   363
ext3rs                        512   4096    1   25.18 8.377%     0.154   301
ext3i                         512   4096    1  144.45 48.98%     0.026   295
reiser                        512   4096    1   33.53 13.51%     0.115   248
xfs                           512   4096    1   83.14 27.66%     0.045   301

ext2                          512   4096    2   34.28 19.08%    -0.290   180
ext3                          512   4096    2  239.35 168.4%    -0.549   142
ext3rs                        512   4096    2  257.29 167.9%    -0.376   153
ext3i                         512   4096    2  174.08 126.9%    -1.885   137
reiser                        512   4096    2   45.32 25.80%    -0.477   176
xfs                           512   4096    2   26.27 16.80%    -0.762   156

ext2                          512   4096    4  138.70 173.9%    -1.166    80
ext3                          512   4096    4  159.41 141.7%    -1.310   112
ext3rs                        512   4096    4   89.80 87.91%    -0.091   102
ext3i                         512   4096    4  135.86 122.5%    -3.192   111
reiser                        512   4096    4  109.81 153.8%    -0.673    71
xfs                           512   4096    4   32.64 39.26%    -1.949    83

Sequential Writes
                              File  Blk   Num                   Avg     CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----
ext2                          512   4096    1   55.15 37.13%     0.030   149
ext3                          512   4096    1   35.24 43.82%     0.106    80
ext3rs                        512   4096    1   34.24 42.86%     0.125    80
ext3i                         512   4096    1   43.54 32.07%     0.028   136
reiser                        512   4096    1   51.67 84.37%     0.063    61
xfs                           512   4096    1   27.32 21.85%     0.057   125

ext2                          512   4096    2   18.76 34.45%     0.111    54
ext3                          512   4096    2   28.82 88.31%     0.236    33
ext3rs                        512   4096    2   30.63 91.98%     0.218    33
ext3i                         512   4096    2   56.24 112.1%     0.018    50
reiser                        512   4096    2   18.31 85.35%     0.173    21
xfs                           512   4096    2   34.29 67.42%     0.213    51

ext2                          512   4096    4   15.92 54.67%     0.559    29
ext3                          512   4096    4   41.36 243.4%     0.137    17
ext3rs                        512   4096    4   45.44 275.5%     0.197    16
ext3i                         512   4096    4   55.94 208.8%     0.020    27
reiser                        512   4096    4   20.47 176.9%     0.491    12
xfs                           512   4096    4   53.60 207.4%     0.056    26

Random Writes
                              File  Blk   Num                   Avg     CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----
ext2                          512   4096    1    0.73 0.565%     0.016   129
ext3                          512   4096    1    1.01 0.733%     0.018   137
ext3rs                        512   4096    1    1.01 0.742%     0.018   136
ext3i                         512   4096    1    0.84 0.611%     0.015   137
reiser                        512   4096    1    0.74 0.531%     0.114   138
xfs                           512   4096    1    1.40 1.048%     0.018   134

ext2                          512   4096    2    1.21 2.248%     0.021    54
ext3                          512   4096    2    1.29 2.549%     0.021    51
ext3rs                        512   4096    2    1.20 2.448%     0.021    49
ext3i                         512   4096    2    0.74 1.572%     0.018    47
reiser                        512   4096    2    1.28 2.325%     0.021    55
xfs                           512   4096    2    1.08 2.056%     0.020    52

ext2                          512   4096    4    1.04 3.760%     0.028    28
ext3                          512   4096    4    0.76 2.758%     0.029    28
ext3rs                        512   4096    4    0.80 3.052%     0.027    26
ext3i                         512   4096    4    0.76 2.879%     0.024    26
reiser                        512   4096    4    1.13 3.854%     0.023    29
xfs                           512   4096    4    0.79 2.432%     0.025    32



thanks, Alex

