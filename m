Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUHAF66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUHAF66 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 01:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUHAF66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 01:58:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34782 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265214AbUHAF6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 01:58:46 -0400
Subject: Re: [Jackit-devel] Re: Statistical methods for latency profiling
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: jackit-devel <jackit-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <1091330650.20819.163.camel@mindpipe>
References: <1091251357.1677.116.camel@mindpipe>
	 <20040801025538.GY5414@waste.org>  <1091330650.20819.163.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1091339954.20819.243.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 01:59:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 23:24, Lee Revell wrote:

> I will have some numbers soon.

Here is the histogram from running 500000 cycles (~5 minutes), with
max_sectors_kb -> 64, normal desktop usage.  Kernel is 2.6.8-rc2-M5, set
to 1:3, with all irqs threaded except the sound card.

Delay   Count
-----   -----
6       2257
7       3210
8       797
9       717
10      283
11      219
12      235
13      250
14      263
15      320
16      334
17      287
18      268
19      260
20      223
21      155
22      109
23      90
24      41
25      19
26      3
27      4
28      1
29      3
30      1
31      2
32      5
33      3
34      1
35      7
36      1
37      3
38      4
39      1
40      5
41      8
42      2
43      1
44      1
47      1
48      1
52      2
62      1
79      1
100     1

The next three tests were done with iozone -a running.

Delay   Count
-----   -----
6       21
7       203
8       595
9       1756
10      1643
11      957
12      618
13      507
14      532
15      540
16      523
17      423
18      400
19      424
20      418
21      293
22      202
23      119
24      71
25      38
26      20
27      8
28      7
29      2
30      1
31      1
32      4
33      4
34      7
35      6
36      1
37      2
38      5
39      7
40      3
41      4
42      4
43      1
44      2
47      1
48      1
50      1
53      1
54      1
57      1
59      1
63      1
69      1
70      2
79      1
91      1
92      1
93      1
100     1
101     1
107     1
109     1
113     1
118     1
123     1
131     1
143     1
145     1
146     1
157     1
161     1

So stressing the filesystem moves the center to the right a bit, from
6-7 to 9-10, and *drastically* lengthens the 'tail'.

These numbers suggest to me that a lot of the latencies from 47 usecs
and up are caused by one code path, because they are so uniformly
distributed over the upper part of the histogram.  The prime suspect of
course being the ide io completions.  I tested this theory by lowering
max_sectors_kb from 64 to 32:

Delay   Count
-----   -----
6       3
7       427
8       742
9       1583
10      3429
11      2010
12      614
13      203
14      200
15      275
16      267
17      177
18      104
19      50
20      55
21      36
22      22
23      21
24      22
25      29
26      26
27      9
28      2
29      3
30      1
32      2
33      2
34      2
35      1
36      1
37      2
41      1
42      1
43      1
48      1
65      1
70      1
71      4
72      3
73      6
74      3
75      1
76      1
77      3
78      2
79      4
80      2
81      3
82      3
83      3
84      3
85      2
86      2
87      4
88      4
90      1
91      1
92      3
94      3
96      2
101     2
102     3
103     1
106     1
111     1
112     1
122     1
132     1

Finally, 16:

Delay   Count
-----   -----
6       420
7       1463
8       652
9       1444
10      2365
11      1111
12      537
13      265
14      232
15      241
16      253
17      218
18      173
19      181
20      233
21      188
22      125
23      76
24      55
25      23
26      9
27      15
28      6
29      2
30      2
31      6
32      5
33      9
34      8
35      4
36      2
37      5
38      2
39      1
40      2
41      3
42      3
43      2
45      1
47      1
49      1
51      3
52      1
53      1
54      1
55      1
56      1
57      1
59      2
60      2
61      2
62      2
63      1
64      1
66      2
67      2
68      3
69      1
71      1
72      3
74      2
75      1
76      2
77      1
78      2
79      1
80      1
81      2
82      1
84      1
85      3
86      1
87      1
89      1
90      2
92      1
100     1
101     1

These numbers all point to the ide sg completion code as the only 
thing on the system generating latencies over ~42 usecs.

I have sent the patch separately to jackit-devel so as not to clutter
LKML with unrelated patches.

Lee

