Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSBXO4c>; Sun, 24 Feb 2002 09:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289551AbSBXO4N>; Sun, 24 Feb 2002 09:56:13 -0500
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:50561 "EHLO
	goose.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289484AbSBXO4G>; Sun, 24 Feb 2002 09:56:06 -0500
Date: Sun, 24 Feb 2002 10:00:44 -0500
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, jamagallon@able.es
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
Message-ID: <20020224150044.GA11858@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Random Writes
> >                   Num                 Avg      Maximum     Lat%    Lat%  CPU
> > Kernel            Thr Rate  (CPU%)  Latency    Latency      >2s    >10s  Eff
> > ----------------- --- ------------------------------------------------------
> > 2.4.18-rc2        128  0.67  1.87%    1.334     777.23  0.00000  0.00000  36
> > 2.4.18-rc2-jam1   128  0.80  5.72%    0.190       3.68  0.00000  0.00000  14
> > 2.4.18rc2aa2      128  0.61  1.39%   61.796   72674.58  0.32761  0.32761  44
> 
> Holy cow!  Are you sure these numbers are right?

Max latency for random writes at 128 threads varies widely.  The numbers
above happen to hit on the widest variation.

Random Writes
                  Num                 Avg      Maximum     Lat%    Lat%  CPU
Kernel            Thr Rate  (CPU%)  Latency    Latency      >2s    >10s  Eff
----------------- --- ------------------------------------------------------
2.4.17-rmap12e    128  0.71  5.19%    1.689     981.25  0.00000  0.00000  14
2.4.17-rmap12f    128  0.71  4.97%    0.975     917.19  0.00000  0.00000  14
2.4.18-pre9       128  0.70  1.82%    1.664     785.13  0.00000  0.00000  38
2.4.18-pre9-ac1   128  0.67  1.93%    0.339     398.63  0.00000  0.00000  35
2.4.18-pre9-ac3   128  0.71  5.09%    0.438     951.04  0.00000  0.00000  14
2.4.18-pre9-ac4   128  0.72  5.12%    0.191      11.63  0.00000  0.00000  14
2.4.18-pre9-am1   128  0.76  2.72%    1.527     845.77  0.00000  0.00000  28
2.4.18-pre9-am2   128  0.75  2.83%    1.371     886.19  0.00000  0.00000  27
2.4.18-pre9-mjc2  128  0.71  3.72%    0.220      12.10  0.00000  0.00000  19
2.4.18-rc1        128  0.68  1.81%    1.584     800.21  0.00000  0.00000  37
2.4.18-rc1-slb1   128  0.81  5.77%    0.192       5.25  0.00000  0.00000  14
2.4.18-rc2        128  0.67  1.87%    1.334     777.23  0.00000  0.00000  36
2.4.18-rc2-ac2    128  0.71  5.19%    0.340     555.11  0.00000  0.00000  14
2.4.18-rc2-jam1   128  0.80  5.72%    0.190       3.68  0.00000  0.00000  14
2.4.18-rc4-jam1   128  0.80  5.72%    5.025    6734.19  0.07560  0.00000  14
2.4.18rc2aa2      128  0.61  1.39%   61.796   72674.58  0.32761  0.32761  44
2.5.3-dj5-tio     128  0.75  2.17%    0.209       1.73  0.00000  0.00000  34
2.5.4-dj2         128  0.76  2.23%    0.206       1.83  0.00000  0.00000  34
2.5.4-dj3         128  0.75  2.30%    0.207       1.87  0.00000  0.00000  33
2.5.5             128  0.74  2.09%    0.197       1.97  0.00000  0.00000  35
2.5.5-dj1         128  0.76  2.26%    0.201       1.45  0.00000  0.00000  33
2.5.5-pre1        128  0.75  2.28%    0.197       2.64  0.00000  0.00000  33

> The increased throughput will be thanks to the boosted request
> queue size.
> 
> The (greatly) increased CPU load will also be due to browsing the eight-times
> larger request queue.  Plus we browse it a bit more than we used to.
> 
> The improvement in worst-case latency in both -aa and -jam will
> be due to the FIFO wait for requests.

Thanks for the insight there.

> But improvement by a factor of 20,000 sounds a little excessive :)
> And a maximum latency of three milliseconds would seem to indicate
> that the benchmark is *never* waiting on disk seek, and that
> perhaps the request queue is simply never filling up.  But that
> doesn't make sense.

I notice the 2.5.x kernels also have extremely low max latency on this test.

> What does the "latency" actually mean?  Is it the time spent
> in the kernel to issue a write(2)?

AFAICT, it's the time between when a request like write(2) is made,
and when it completes.  It doesn't appear to be actual time in kernel.
I'd rather hear from a more knowledgeable coder though.

> Something funny is happening, I suspect.  Guess I should go
> look at tiobench...

Cool.  I admire your work.

Below is a snippet of tiobench on random writes.  The rc4-jam1
included the entire patchset, whereas rc2-jam1 had patches with
the first two digits < 20.

Most notable is that jam1 had an unusual low max latency at 
16 threads, which didn't appear at 8, 32, 64, and 128.

Random Writes
                 Num                  Avg      Maximum     Lat%     Lat% CPU
Kernel           Thr  Rate  (CPU%)  Latency    Latency      >2s     >10s Eff
--------------------  ------------------------------------------------------
2.4.18-rc2-jam1    8   0.71  4.71%    0.190       3.53  0.00000  0.00000  15
2.4.18-rc4-jam1    8   0.71  4.61%    0.754    2242.97  0.02500  0.00000  15

2.4.18-rc2-jam1   16   0.72  4.76%    0.192       4.02  0.00000  0.00000  15
2.4.18-rc4-jam1   16   0.72  4.72%    0.196       5.09  0.00000  0.00000  15

2.4.18-rc2-jam1   32   0.77  5.13%    0.192       5.28  0.00000  0.00000  15
2.4.18-rc4-jam1   32   0.77  5.25%    8.268   13672.38  0.15000  0.00000  15

2.4.18-rc2-jam1   64   0.79  5.27%    0.190       3.63  0.00000  0.00000  15
2.4.18-rc4-jam1   64   0.78  5.30%   26.660   27314.64  0.50403  0.02520  15

2.4.18-rc2-jam1  128   0.80  5.72%    0.190       3.68  0.00000  0.00000  14
2.4.18-rc4-jam1  128   0.80  5.72%    5.025    6734.19  0.07560  0.00000  14

-- 
Randy Hron

