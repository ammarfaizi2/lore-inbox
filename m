Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTEFDOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTEFDOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:14:22 -0400
Received: from CPE-203-51-35-173.nsw.bigpond.net.au ([203.51.35.173]:2688 "EHLO
	didi") by vger.kernel.org with ESMTP id S262354AbTEFDOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:14:14 -0400
Date: Tue, 6 May 2003 13:26:31 +1000
From: Nick Piggin <piggin@cyberone.com.au>
To: linux-kernel@vger.kernel.org
Cc: piggin@cyberone.com.au, akpm@digeo.com
Subject: [BENCHMARKS] AS scheduler
Message-ID: <20030506032631.GA287@didi>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@digeo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Here are a few benchmarks with the rq-dyn patch in. Most differences are
probably due to larger queues. Regressions in Contest io_load, improvement
in OraSim. tiobench shows random IO and streaming write throughput gains
and general improvement in latency.

Right now it appears AS is only really beaten by deadline when using
big TCQ windows. The cause seems to be that deadline will stuff as
many requests into the disk as possible, allowing a massive rescheduling
window, while AS is more selective. Now AS schedules quite well, so I'm
inclined to think that some deadline+TCQ improvements are at the expense
of fairness, although the AS scheduler definitely has room for
improvement.


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=all_results


Cat kernel source during seq read
65-mm4-dl - 0.03user 0.13system 5:21.39elapsed
65-mm4-as - 0.02user 0.14system 0:14.50elapsed
69-mm1-as - 0.01user 0.11system 0:14.23elapsed

Cat kernel source during seq write
65-mm4-dl - 0.03user 0.14system 14:06.45elapsed
65-mm4-as - 0.02user 0.14system 0:16.33elapsed
69-mm1-as - 0.02user 0.12system 0:19.50elapsed

ls -lr kernel source during seq read
65-mm4-dl - 0.18user 0.31system 0:24.32elapsed
65-mm4-as - 0.19user 0.32system 0:09.39elapsed
69-mm1-as - 0.17user 0.33system 0:10.21elapsed

ls -lr kernel source during seq write
65-mm4-dl - 0.23user 0.34system 1:13.90elapsed
65-mm4-as - 0.18user 0.32system 0:05.49elapsed
69-mm1-as - 0.18user 0.32system 0:05.82elapsed 

Contest
no_load:
Kernel     [runs]	Time	CPU%	Loads	LCPU%	Ratio
65-mm4-dl      1	69	95.7	0.0	0.0	1.00
65-mm4-as      1	69	95.7	0.0	0.0	1.00
69-mm1-as      1	69	95.7	0.0	0.0	1.00
io_load:
Kernel     [runs]	Time	CPU%	Loads	LCPU%	Ratio
65-mm4-dl      1	149	46.3	121.0	22.8	2.16
65-mm4-as      1	100	70.0	81.2	22.0	1.45
69-mm1-as      1	122	56.6	73.8	16.8	1.77
read_load:
Kernel     [runs]	Time	CPU%	Loads	LCPU%	Ratio
65-mm4-dl      1	91	78.0	12.8	6.6	1.32
65-mm4-as      1	100	72.0	15.6	8.0	1.45
69-mm1-as      1	110	64.5	18.4	7.3	1.59
list_load:
Kernel     [runs]	Time	CPU%	Loads	LCPU%	Ratio
65-mm4-dl      1	87	78.2	5.0	18.4	1.26
65-mm4-as      1	94	72.3	6.0	19.1	1.36
69-mm1-as      1	93	72.0	6.0	19.4	1.35

tiobench

Unit information
================
File size = 1024MB
Blk Size  = 4096B

Sequential Reads
                Num                   Avg      Maximum     Lat%  Lat%   CPU
Identifier      Thr   Rate  (CPU%)  Latency    Latency     >2s   >10s   Eff
--------------- ---  ------ ------ --------- -----------  ----- ------ -----
65-mm4-dl     1   48.21 11.09%     0.080       36.49   0.00  0.00   435
65-mm4-dl     4   11.47 2.500%     1.358       86.84   0.00  0.00   459
65-mm4-dl    16   13.18 3.049%     4.704      311.43   0.00  0.00   432
65-mm4-dl   256   10.32 2.489%    58.877    69755.23   0.09  0.07   414
65-mm4-as     1   49.23 11.52%     0.078       28.10   0.00  0.00   427
65-mm4-as     4   39.56 9.461%     0.387      217.46   0.00  0.00   418
65-mm4-as    16   37.81 8.902%     1.571      929.76   0.00  0.00   425
65-mm4-as   256   33.10 7.822%    17.405    26072.15   0.25  0.05   423
69-mm1-as     1   49.54 12.81%     0.078       35.14   0.00  0.00   387
69-mm1-as     4   37.74 8.592%     0.398      285.66   0.00  0.00   439
69-mm1-as    16   36.38 8.247%     1.639      970.25   0.00  0.00   441
69-mm1-as   256   34.16 8.897%    18.615    12700.17   0.33  0.01   384
Random Reads
65-mm4-dl     1    0.59 0.488%     6.647       23.35   0.00  0.00   120
65-mm4-dl     4    0.59 0.178%    26.003       96.85   0.00  0.00   332
65-mm4-dl    16    0.67 0.327%    88.082      403.66   0.00  0.00   206
65-mm4-dl   256    0.61 0.480%  1064.411    16058.51   3.02  2.68   127
65-mm4-as     1    0.57 0.504%     6.829       28.33   0.00  0.00   113
65-mm4-as     4    0.63 0.584%    23.283      220.36   0.00  0.00   108
65-mm4-as    16    0.63 0.624%    87.513      596.26   0.00  0.00   101
65-mm4-as   256    0.85 0.852%   659.708    14613.03  13.15  1.04    99
69-mm1-as     1    0.58 0.578%     6.777       22.33   0.00  0.00   100
69-mm1-as     4    0.63 0.258%    23.826      149.64   0.00  0.00   244
69-mm1-as    16    0.67 0.393%    83.469      832.59   0.00  0.00   170
69-mm1-as   256    0.87 0.478%   719.347     6396.50  16.12  0.00   181

Sequential Writes
65-mm4-dl     1   42.85 20.66%     0.082      992.45   0.00  0.00   207
65-mm4-dl     4   43.04 20.94%     0.291     1104.10   0.00  0.00   205
65-mm4-dl    16   37.10 17.68%     1.188     6594.20   0.02  0.00   210
65-mm4-dl   256   29.38 14.76%    15.689    30675.42   0.17  0.06   199
65-mm4-as     1   44.15 21.43%     0.080     1025.37   0.00  0.00   206
65-mm4-as     4   40.94 19.79%     0.299     1087.51   0.00  0.00   207
65-mm4-as    16   35.62 16.89%     1.220     5965.63   0.02  0.00   211
65-mm4-as   256   28.20 14.15%    16.388    33732.92   0.17  0.06   199
69-mm1-as     1   42.40 19.64%     0.084     1067.87   0.00  0.00   216
69-mm1-as     4   47.81 23.50%     0.275     2027.28   0.00  0.00   203
69-mm1-as    16   46.36 26.59%     1.013     2389.64   0.00  0.00   174
69-mm1-as   256   44.87 45.00%     8.772    22170.39   0.15  0.00   100

Random Writes
65-mm4-dl     1    0.81 0.467%     0.033       32.69   0.00  0.00   174
65-mm4-dl     4    0.79 0.509%     0.934       75.36   0.00  0.00   155
65-mm4-dl    16    0.81 0.484%     3.573      518.44   0.00  0.00   166
65-mm4-dl   256    0.99 0.561%    48.837     7073.10   0.60  0.00   176
65-mm4-as     1    0.82 0.472%     0.034       32.15   0.00  0.00   174
65-mm4-as     4    0.81 0.518%     0.818      137.50   0.00  0.00   156
65-mm4-as    16    0.79 0.516%     4.735      476.85   0.00  0.00   153
65-mm4-as   256    0.94 0.524%    79.319     7416.65   0.96  0.00   179
69-mm1-as     1    1.04 0.539%     0.102       28.27   0.00  0.00   193
69-mm1-as     4    1.07 0.554%     0.768      105.72   0.00  0.00   193
69-mm1-as    16    1.13 0.566%     2.912      376.10   0.00  0.00   200
69-mm1-as   256    1.07 0.577%    40.617     9585.90   0.23  0.00   185

OraSim (bigger is better)
65-mm4-dl - 132, 144
65-mm4-as - 129, 140
69-mm1-as - 158, 161

nickbench (IO rate is total combined throughput)
Bench 2 - 2 threads, streaming reader and streaming writer
65-mm4-dl - IO Rate: 33.36 MB/s, Reads per write: 0.08
65-mm4-as - IO Rate: 42.19 MB/s, Reads per write: 2.08
69-mm1-as - IO Rate: 43.29 MB/s, Reads per write: 2.40

Bench 3 - 2 threads, streaming readers
65-mm4-dl - IO Rate: 12.64 MB/s, Reads per read: 0.95
65-mm4-as - IO Rate: 45.56 MB/s, Reads per read: 1.00
69-mm1-as - IO Rate: 44.34 MB/s, Reads per read: 0.97

Bench 4 - 2 threads, streaming writers
65-mm4-dl - IO Rate: 38.59 MB/s, Writes per write: 1.45
65-mm4-as - IO Rate: 40.64 MB/s, Writes per write: 1.68
69-mm1-as - IO Rate: 37.65 MB/s, Writes per write: 0.80

Bench 5 - 1 thread, read then write each block of 1 file
65-mm4-dl - IO Rate: 40.24 MB/s, CPU time per byte: 4732.421875 us/B
65-mm4-as - IO Rate: 45.30 MB/s, CPU time per byte: 5238.281250 us/B
69-mm1-as - IO Rate: 44.10 MB/s, CPU time per byte: 4991.429688 us/B

Bench 6 - 4 threads, streaming readers
65-mm4-dl - IO Rate: 11.87 MB/s, Greatest unfairness between 4 readers: 0.95
65-mm4-as - IO Rate: 44.89 MB/s, Greatest unfairness between 4 readers: 0.95
69-mm1-as - IO Rate: 44.84 MB/s, Greatest unfairness between 4 readers: 0.94

--opJtzjQTFsWo+cga--
