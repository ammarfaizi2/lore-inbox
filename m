Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261479AbTCYGYr>; Tue, 25 Mar 2003 01:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbTCYGYr>; Tue, 25 Mar 2003 01:24:47 -0500
Received: from CPE-203-51-35-166.nsw.bigpond.net.au ([203.51.35.166]:3200 "EHLO
	didi") by vger.kernel.org with ESMTP id <S261479AbTCYGYm>;
	Tue, 25 Mar 2003 01:24:42 -0500
Date: Tue, 25 Mar 2003 17:35:44 +1100
From: Nick Piggin <piggin@cyberone.com.au>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, axboe@suse.de, piggin@cyberone.com.au
Subject: [BENCHMARK] AS vs. DL schedulers
Message-ID: <20030325063544.GB332@didi>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@digeo.com,
	axboe@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,
Jens Axboe, Andrew Morton and I think that the IO scheduler we have been
working on is probably about ready to go into mainline. There are some
design issues with the elevator API and process IO statistics which are not
ideal, but we have agreed that now is not the time to redesign
interfaces.

Jens is looking into making the schedulers CONFIGurable and possibly
runtime selectable which should please everyone, though the present lack
of these features doesn't stop AS getting into 2.5 for testing. I would
hope AS gets a couple of revisions as the default elevator.

Here are some benchmarks.

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=all_results


Cat kernel source during seq read
DL - 0.03user 0.13system 5:21.39elapsed
AS - 0.02user 0.14system 0:14.50elapsed

Cat kernel source during seq write
DL - 0.03user 0.14system 14:06.45elapsed
AS - 0.02user 0.14system 0:16.33elapsed

ls -lr kernel source during seq read
DL - 0.18user 0.31system 0:24.32elapsed
AS - 0.19user 0.32system 0:09.39elapsed

ls -lr kernel source during seq write
DL - 0.23user 0.34system 1:13.90elapsed
AS - 0.18user 0.32system 0:05.49elapsed

Contest
no_load:
Kernel     [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.65-mm4-dl      1	69	95.7	0.0	0.0	1.00
2.5.65-mm4-as      1	69	95.7	0.0	0.0	1.00
io_load:
Kernel     [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.65-mm4-dl      1	149	46.3	121.0	22.8	2.16
2.5.65-mm4-as      1	100	70.0	81.2	22.0	1.45
read_load:
Kernel     [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.65-mm4-dl      1	91	78.0	12.8	6.6	1.32
2.5.65-mm4-as      1	100	72.0	15.6	8.0	1.45
list_load:
Kernel     [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.65-mm4-dl      1	87	78.2	5.0	18.4	1.26
2.5.65-mm4-as      1	94	72.3	6.0	19.1	1.36

tiobench
* note numbers at 256 threads are less dependant on the IO
  scheduler due to the small number of request slots available
  as default. Jens is looking into dynamically allocating requests.

Unit information
================
File size = 1024MB
Blk Size  = 4096B

Sequential Reads
                Num                   Avg      Maximum     Lat%  Lat%   CPU
Identifier      Thr   Rate  (CPU%)  Latency    Latency     >2s   >10s   Eff
--------------- ---  ------ ------ --------- -----------  ----- ------ -----
2.5.65-mm4-dl     1   48.21 11.09%     0.080       36.49   0.00  0.00   435
2.5.65-mm4-dl     4   11.47 2.500%     1.358       86.84   0.00  0.00   459
2.5.65-mm4-dl    16   13.18 3.049%     4.704      311.43   0.00  0.00   432
2.5.65-mm4-dl   256   10.32 2.489%    58.877    69755.23   0.09  0.07   414
2.5.65-mm4-as     1   49.23 11.52%     0.078       28.10   0.00  0.00   427
2.5.65-mm4-as     4   39.56 9.461%     0.387      217.46   0.00  0.00   418
2.5.65-mm4-as    16   37.81 8.902%     1.571      929.76   0.00  0.00   425
2.5.65-mm4-as   256   33.10 7.822%    17.405    26072.15   0.25  0.05   423

Random Reads
2.5.65-mm4-dl     1    0.59 0.488%     6.647       23.35   0.00  0.00   120
2.5.65-mm4-dl     4    0.59 0.178%    26.003       96.85   0.00  0.00   332
2.5.65-mm4-dl    16    0.67 0.327%    88.082      403.66   0.00  0.00   206
2.5.65-mm4-dl   256    0.61 0.480%  1064.411    16058.51   3.02  2.68   127
2.5.65-mm4-as     1    0.57 0.504%     6.829       28.33   0.00  0.00   113
2.5.65-mm4-as     4    0.63 0.584%    23.283      220.36   0.00  0.00   108
2.5.65-mm4-as    16    0.63 0.624%    87.513      596.26   0.00  0.00   101
2.5.65-mm4-as   256    0.85 0.852%   659.708    14613.03  13.15  1.04    99

Sequential Writes
2.5.65-mm4-dl     1   42.85 20.66%     0.082      992.45   0.00  0.00   207
2.5.65-mm4-dl     4   43.04 20.94%     0.291     1104.10   0.00  0.00   205
2.5.65-mm4-dl    16   37.10 17.68%     1.188     6594.20   0.02  0.00   210
2.5.65-mm4-dl   256   29.38 14.76%    15.689    30675.42   0.17  0.06   199
2.5.65-mm4-as     1   44.15 21.43%     0.080     1025.37   0.00  0.00   206
2.5.65-mm4-as     4   40.94 19.79%     0.299     1087.51   0.00  0.00   207
2.5.65-mm4-as    16   35.62 16.89%     1.220     5965.63   0.02  0.00   211
2.5.65-mm4-as   256   28.20 14.15%    16.388    33732.92   0.17  0.06   199

Random Writes
2.5.65-mm4-dl     1    0.81 0.467%     0.033       32.69   0.00  0.00   174
2.5.65-mm4-dl     4    0.79 0.509%     0.934       75.36   0.00  0.00   155
2.5.65-mm4-dl    16    0.81 0.484%     3.573      518.44   0.00  0.00   166
2.5.65-mm4-dl   256    0.99 0.561%    48.837     7073.10   0.60  0.00   176
2.5.65-mm4-as     1    0.82 0.472%     0.034       32.15   0.00  0.00   174
2.5.65-mm4-as     4    0.81 0.518%     0.818      137.50   0.00  0.00   156
2.5.65-mm4-as    16    0.79 0.516%     4.735      476.85   0.00  0.00   153
2.5.65-mm4-as   256    0.94 0.524%    79.319     7416.65   0.96  0.00   179

OraSim
DL - 132, 144
AS - 129, 140

nickbench (IO rate is total combined throughput)
Bench 2 - 2 threads, streaming reader and streaming writer
DL - IO Rate: 33.36 MB/s, Reads per write: 0.08
AS - IO Rate: 42.19 MB/s, Reads per write: 2.08

Bench 3 - 2 threads, streaming readers
DL - IO Rate: 12.64 MB/s, Reads per read: 0.95
AS - IO Rate: 45.56 MB/s, Reads per read: 1.00

Bench 4 - 2 threads, streaming writers
DL - IO Rate: 38.59 MB/s, Writes per write: 1.45
AS - IO Rate: 40.64 MB/s, Writes per write: 1.68

Bench 5 - 2 thread, read then write each block of 1 file
DL - IO Rate:     40.24 MB/s, CPU time per byte: 4732.421875 us/B
AS - IO Rate:     45.30 MB/s, CPU time per byte: 5238.281250 us/B

Bench 6 - 4 threads, streaming readers
DL - IO Rate: 11.87 MB/s, Greatest unfairness between 4 readers: 0.95
AS - IO Rate: 44.89 MB/s, Greatest unfairness between 4 readers: 0.95

--JP+T4n/bALQSJXh8--
