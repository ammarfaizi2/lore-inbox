Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288102AbSBIBwL>; Fri, 8 Feb 2002 20:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291479AbSBIBwC>; Fri, 8 Feb 2002 20:52:02 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:26004 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S288102AbSBIBvk>; Fri, 8 Feb 2002 20:51:40 -0500
Date: Fri, 8 Feb 2002 20:56:18 -0500
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] get_request starvation fix
Message-ID: <20020209015618.GA2457@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 10:29:37AM -0800, Andrew Morton wrote:
> > > Here's a patch which addresses the get_request starvation problem.
> > 
> > Looks like a tremendously important patch.  Thanks!
> 
> hmm.  Dunno.  I don't think it's very common to hit get_request
> starvation.  Only for dbenchy things, I suspect.  Still, it's
> good to have a design which addresses nasty corner cases.

It really works!  

tiobench sequential reads with 32 threads went from max latency of
193 seconds down to 7 seconds with your make_request, read-latency2
and low-latency patches.  (2.4.18-pre9-am1)  The % of high latency
requests also went down.

K6-2 475 mhz with 384 MB ram and reiserfs on IDE disks.
Average of 3 runs.
Total File size = 1024 MB.  (individual file size = 1024 / num-threads)
Read, write, and seek rates in MB/sec. 
Latency in milliseconds.
Percent of requests that took longer than 2 and 10 seconds.

Sequential       Num                   Avg     Maximum  Lat%   Lat%  CPU
Reads            Thr  Rate   (CPU%)  Latency   Latency   >2s   >10s  Eff
                 --- ---------------------------------------------------
2.4.18-pre9-am1    8   8.94  13.33%   10.402   1785.52  0.000  0.000  67
2.4.18-pre9        8   8.85  13.22%   10.537   1954.27  0.000  0.000  67
2.4.18-pre9-am1   16   8.98  13.70%   30.827   4023.09  0.000  0.000  66
2.4.18-pre9       16   8.91  13.60%   31.122   4072.67  0.000  0.000  65
2.4.18-pre9-am1   32   9.00  14.16%   70.834   7032.45  0.000  0.000  64
2.4.18-pre9       32   8.87  13.89%   66.135 193590.10  0.030  0.023  64
                             
                             
Random           Num                  Avg      Maximum  Lat%   Lat%  CPU
Reads            Thr Rate  ( CPU%)  Latency    Latency   >2s   >10s  Eff
                 --- ---------------------------------------------------
2.4.18-pre9-am1    8  0.69 1 .828%  132.242     473.73  0.000  0.000  38
2.4.18-pre9        8  0.71 2 .156%  128.869     510.38  0.000  0.000  33
2.4.18-pre9-am1   16  0.72 2 .154%  371.288    1410.13  0.000  0.000  33
2.4.18-pre9       16  0.74 2 .025%  364.871    1397.82  0.000  0.000  36
2.4.18-pre9-am1   32  0.74 2 .229%  816.605    2996.07  0.000  0.000  33
2.4.18-pre9       32  0.75 2 .163%  734.035    2841.97  0.000  0.000  35
                             
Sequential       Num                   Avg     Maximum  Lat%   Lat%  CPU 
Writes           Thr  Rate   (CPU%)  Latency   Latency   >2s   >10s  Eff 
                 --- --------------------------------------------------- 
2.4.18-pre9-am1    8  11.45  52.33%    7.651  15095.52  0.058  0.000  22 
2.4.18-pre9        8   9.23  40.84%    9.021  12351.12  0.040  0.000  23
2.4.18-pre9-am1   16  11.48  54.57%   22.253  41922.53  0.214  0.000  21 
2.4.18-pre9       16   9.46  41.71%   26.374  28280.18  0.212  0.000  23
2.4.18-pre9-am1   32  11.37  55.91%   52.917  75331.67  0.679  0.004  20 
2.4.18-pre9       32   9.50  42.55%   61.944  60970.74  0.770  0.005  22
                             
                             
Random           Num                   Avg     Maximum  Lat%   Lat%  CPU
Writes           Thr  Rate   (CPU%)  Latency   Latency   >2s   >10s  Eff
                 --- ---------------------------------------------------
2.4.18-pre9-am1    8   0.62  2.393%    1.786    330.56  0.000  0.000  26
2.4.18-pre9        8   0.50  1.216%    1.700    333.32  0.000  0.000  41
2.4.18-pre9-am1   16   0.65  2.527%    4.533    996.54  0.000  0.000  26
2.4.18-pre9       16   0.52  1.267%    4.228   1236.08  0.000  0.000  41
2.4.18-pre9-am1   32   0.65  2.530%    7.980   1907.91  0.000  0.000  26
2.4.18-pre9       32   0.53  1.343%    7.818   2509.73  0.000  0.000  39


> > Do you have a patch for dbench too? :)
> 
> /bin/rm?

Good one.  It would be helpful though, if you've already done the work.
-- 
Randy Hron

