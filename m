Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSBMNuT>; Wed, 13 Feb 2002 08:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSBMNuK>; Wed, 13 Feb 2002 08:50:10 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:37098 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S282843AbSBMNt7>; Wed, 13 Feb 2002 08:49:59 -0500
Date: Wed, 13 Feb 2002 08:55:03 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: Re: [patch] get_request starvation fix
Message-ID: <20020213135503.GA23639@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tiobench measurements using 2048 MB worth of files on ext2 fs.
K6-2 475 mhz with 384 MB RAM and IDE disk.
Sorted by test, number of threads, then kernel.
Read, write, and seek rates in MB/sec. 
Latency in milliseconds.
Percent of requests that took longer than 2 and 10 seconds.

2.4.18-pre9-am1 = make_request, read_latency2, and low-latency patches.
2.4.18-pre9-am2 = make_request, read_latency2, and sync_livelock patches.

On sequential reads, kernels with make_request and read_latency2
reduce max latency from around 500 seconds down 2-8 seconds.
Fairness to requests is vastly improved.  Throughput looks better too.

Sequential Reads Num                   Avg      Maximum    Lat%     Lat% 
Kernel           Thr  Rate  (CPU%)   Latency    Latency     >2s     >10s 
---------------- ---  ---------------------------------------------------
2.4.18-pre9       32   9.18 12.19%    34.739  545388.95  0.00304  0.00304
2.4.18-pre9-ac1   32  11.48 30.08%    25.736  289601.71  0.00839  0.00839
2.4.18-pre9-am1   32   9.25 11.97%    40.103    2251.30  0.00000  0.00000
2.4.18-pre9-am2   32   9.32 12.11%    39.917    2206.14  0.00000  0.00000

2.4.18-pre9       64   8.83 11.81%    59.045  484270.65  0.02689  0.02651
2.4.18-pre9-ac1   64  10.37 27.12%    49.460  293425.91  0.04273  0.04196
2.4.18-pre9-am1   64   9.53 13.42%    77.737    3840.97  0.00000  0.00000
2.4.18-pre9-am2   64   9.52 13.15%    77.873    3951.99  0.00000  0.00000

2.4.18-pre9      128   8.44 10.92%   109.317  572551.72  0.08507  0.07534
2.4.18-pre9-ac1  128   9.28 24.08%   104.159  333550.33  0.13599  0.13523
2.4.18-pre9-am1  128   9.55 15.38%   153.480    7939.48  0.66070  0.00000
2.4.18-pre9-am2  128   9.59 15.72%   153.244    7648.12  0.80833  0.00000

On random reads, the make_request and read_latency2 patches help a lot at 
128 threads.  Max latency and % of high latency requests is greatly reduced.

Random Reads     Num                   Avg      Maximum    Lat%     Lat% 
Kernel           Thr  Rate  (CPU%)   Latency    Latency     >2s     >10s 
---------------- ---  ---------------------------------------------------
2.4.18-pre9       32   0.57 1.580%   549.367    1523.39  0.00000  0.00000
2.4.18-pre9-ac1   32   0.53 2.226%   660.193    2966.26  0.00000  0.00000
2.4.18-pre9-am1   32   0.58 1.479%   623.361    1693.90  0.00000  0.00000
2.4.18-pre9-am2   32   0.58 1.501%   619.679    1727.47  0.00000  0.00000

2.4.18-pre9       64   0.61 2.031%  1016.205    2618.34  0.00000  0.00000
2.4.18-pre9-ac1   64   0.56 2.579%  1160.377   72621.35  0.35283  0.32763
2.4.18-pre9-am1   64   0.61 1.711%  1145.865    2865.21  0.00000  0.00000
2.4.18-pre9-am2   64   0.62 1.978%  1135.097    2792.76  0.00000  0.00000

2.4.18-pre9      128   0.61 1.699%  1569.812   53372.49  4.48589  4.41029
2.4.18-pre9-ac1  128   0.55 2.701%  1862.139   75417.90  5.54435  5.21673
2.4.18-pre9-am1  128   0.63 2.511%  2152.480    4710.51  0.00000  0.00000
2.4.18-pre9-am2  128   0.63 2.525%  2145.578    4709.85  0.00000  0.00000

On the write tests, 2.4.18-pre9-ac1 has the best latency numbers.

Sequential Write Num                   Avg      Maximum    Lat%     Lat% 
Kernel           Thr  Rate  (CPU%)   Latency    Latency     >2s     >10s 
---------------- ---  ---------------------------------------------------
2.4.18-pre9       32  13.18 35.47%    26.155   33677.84  0.48867  0.00324
2.4.18-pre9-ac1   32  13.66 36.82%    24.738    9008.30  0.03567  0.00000
2.4.18-pre9-am1   32  15.27 53.94%    21.236   39604.59  0.37098  0.00400
2.4.18-pre9-am2   32  15.17 53.66%    21.492   41358.77  0.37155  0.00496

2.4.18-pre9       64  13.47 44.74%    46.296   46673.56  0.76332  0.03968
2.4.18-pre9-ac1   64  11.91 32.45%    55.355   12051.19  0.22926  0.00000
2.4.18-pre9-am1   64  14.57 52.16%    43.430   51274.83  0.75874  0.05665
2.4.18-pre9-am2   64  14.78 53.76%    42.685   54281.45  0.63266  0.07457

2.4.18-pre9      128  12.78 42.55%    91.421   60494.19  1.20201  0.26531
2.4.18-pre9-ac1  128  10.15 27.63%   122.921   15371.80  1.29719  0.00000
2.4.18-pre9-am1  128  13.72 47.73%    83.373   69739.68  1.16043  0.22126
2.4.18-pre9-am2  128  14.17 52.81%    80.642   67952.87  1.10722  0.23041


Random Writes    Num                   Avg      Maximum    Lat%     Lat% 
Kernel           Thr  Rate  (CPU%)   Latency    Latency     >2s     >10s 
---------------- ---  ---------------------------------------------------
2.4.18-pre9       32   0.60 1.323%     1.915     576.55  0.00000  0.00000
2.4.18-pre9-ac1   32   0.61 1.296%     0.311     481.93  0.00000  0.00000
2.4.18-pre9-am1   32   0.71 2.411%     1.696     624.95  0.00000  0.00000
2.4.18-pre9-am2   32   0.73 2.804%     1.567     711.59  0.00000  0.00000

2.4.18-pre9       64   0.65 1.547%     1.552     558.61  0.00000  0.00000
2.4.18-pre9-ac1   64   0.64 1.457%     0.214      88.78  0.00000  0.00000
2.4.18-pre9-am1   64   0.74 2.649%     1.014     522.44  0.00000  0.00000
2.4.18-pre9-am2   64   0.75 2.647%     1.035     557.22  0.00000  0.00000

2.4.18-pre9      128   0.70 1.823%     1.664     785.13  0.00000  0.00000
2.4.18-pre9-ac1  128   0.67 1.926%     0.339     398.63  0.00000  0.00000
2.4.18-pre9-am1  128   0.76 2.716%     1.527     845.77  0.00000  0.00000
2.4.18-pre9-am2  128   0.75 2.828%     1.371     886.19  0.00000  0.00000

More tests on more kernels at
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
-- 
Randy Hron

