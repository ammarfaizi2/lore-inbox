Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTCEXOm>; Wed, 5 Mar 2003 18:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTCEXOm>; Wed, 5 Mar 2003 18:14:42 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:44703 "EHLO
	dyn9-47-17-83.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id <S266292AbTCEXOj>; Wed, 5 Mar 2003 18:14:39 -0500
Message-ID: <3E668187.B43B85F7@us.ibm.com>
Date: Wed, 05 Mar 2003 15:00:23 -0800
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: bcrl@redhat.com, akpm@digeo.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC][Patch] Retry based aio read for filesystems
References: <20030305144754.A1600@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:

> For the last few days I've been playing with prototyping
> a particular flavour of a retry based implementation for
> filesystem aio read.

Hi Suparna,

I ran an aio-enabled version of fsx on your patches and no errors were
reported.  I plan on using gcov to determine the test coverage I
obtained.

I also did a quick performance test using wall time to compare sync and
async read operations with your patches applied.  For the sync case I
ran
10 processes in parallel, each reading 1GB in 1MB chunks from a
per-process
dedicated device.  I compared that to a single aio process iteratively
calling
io_submit/io_getevents for up to 10 iocbs/events where each iocb
specified a
1MB read to its dedicated device until 1GB was read.  Whew!

The result was that wall time for the sync and async testcases were
consistently identical, i.e., 1m30s:

# sync_test
start time:  Wed Mar  5 14:02:05 PST 2003
end time:    Wed Mar  5 14:03:35 PST 2003

# aio_test
start time:  Wed Mar  5 13:52:04 PST 2003
end time:    Wed Mar  5 13:53:34 PST 2003

syncio vmstat:
  procs                      memory      swap          io
system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 4  6  2   3324   3888  11356 3668848   0    0 151296    0 2216  2395  0
100  0
 4  6  1   3324   3888  11368 3668820   0    0 151744    5 2216  2368  0
100  0
 1  9  1   3324   3952  11368 3668860   0    0 151209    1 2213  2356  0
100  0
 5  5  1   3324   3940  11344 3668864   0    2 148948    3 2215  2387  0
100  0
 1  9  1   3348   3936  11264 3668968   0    6 150767    7 2209  2345  0
100  0
 6  4  1   3480   3920  11192 3669364   0   33 151456   33 2218  2340  0
100  0
 4  6  2   3568   3896  11316 3669352   0   21 151887   21 2218  2385  0
100  0
 7  3  1   3704   3820  11364 3669428  31   34 148687   35 2222  2344
1  99  0

aio vmstat:
  procs                      memory      swap          io
system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 2  0  1   4016   4040  11192 3669644   0   17 133152    25 2073   502
0 40 60
 1  0  1   4016   4104  11196 3669716   0    0 132288     1 2073   537
0 40 60
 2  0  2   4016   4104  11196 3669764   0    0 132416     0 2067   511
0 40 60
 1  0  1   4016   4104  11200 3669788   0    0 133088     1 2075   523
0 41 59
 1  0  1   4016   5576  11200 3668240   0    0 132384     0 2066   526
0 40 60
 1  0  1   4036   4092  11200 3669756   0    5 135116     5 2094   492
0 46 54
 1  0  1   4180   4016  11192 3669944   0   36 135968    40 2111   499
0 46 54
 2  0  2   4180   4060  11176 3669832   0    0 137152     0 2119   463
1 46 53
 1  0  1   4180   7060  11180 3666980   0    0 136384     2 2107   498
0 44 56


-Janet

