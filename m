Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbTDCN4H>; Thu, 3 Apr 2003 08:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263391AbTDCN4H>; Thu, 3 Apr 2003 08:56:07 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:20808 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263365AbTDCN4F>;
	Thu, 3 Apr 2003 08:56:05 -0500
Date: Thu, 3 Apr 2003 16:07:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [benchmarks] on recent kernels
Message-ID: <20030403140727.GJ18253@dualathlon.random>
References: <20030401232950.GA3318@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401232950.GA3318@rushmore>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you so much again for those so helpful benchmark results.

just a few comments.

On Tue, Apr 01, 2003 at 06:29:50PM -0500, rwhron@earthlink.net wrote:
> File create/delete and VM system latencies in microseconds - smaller is better
> ----------------------------------------------------------------------------
>                          0K       0K       1K       1K       4K       4K     Mmap     Prot    Page
> kernel                 Create   Delete   Create   Delete   Create   Delete   Latency  Fault   Fault
> ------------------------------  -------  -------  -------  -------  -------  -------  ------  ------
> 2.4.21-pre5-ac3           63.5     15.4    139.7     27.0    146.7     27.0     2630    1.34     5.2
> 2.4.21-pre5-akpm          64.1     14.1    139.5     24.3    144.3     24.3     2541    0.99     5.4
> 2.4.21-pre5               64.8     13.5    134.8     24.8    140.5     25.0     2593    0.84     5.1
> 2.5.66-mjb1               72.4     14.4    154.3     27.8    158.6     27.8     3621    0.66     8.8
> 2.5.66                    78.2     15.1    161.0     27.9    166.9     27.9     3887    0.78     8.6
> 2.5.66-ac1                83.4     16.7    166.9     34.3    170.8     34.3     3942    1.25    15.2
> 2.5.66-mm1                89.3     17.0    182.3     35.4    188.0     35.4     4413    0.91     9.5
> 2.4.21-pre5aa2            89.7     14.2    165.3     27.3    174.3     27.3     2480    1.05     5.9
> 2.4.21-pre5-jam1          91.4     14.0    167.7     27.9    172.5     27.9     2508    0.84     6.0
> 2.2.23                   141.3     21.7    207.5     27.5    215.4     27.4    64369    0.89  1246.0

the reason my tree is slower in create is intentional: I drop the
negative dentries after unlink to better preserve the working set, and
to release IMHO worthless cache in smart way. I don't think it's common
to unlink and open immediatly back. the other kernels do better here
because they optimize for unlike + open. Of course also in my tree the
first open failure will trigger the reallocation of the negative dentry.

> 2.5.x has lower cpu utilization for sequential block reads.
> 
>                   ---------------------Sequential Output--------------------
>                   -----Per Char-----  ------Block-------  -----Rewrite------
> Kernel            MB/sec  %CPU   Eff  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff
> 2.4.21-pre5aa2      3.80  98.0  3.88   22.46  85.7 26.21    9.86  52.0 18.96
> 2.4.21-pre5-jam1    3.77  98.0  3.85   21.99  87.0 25.28    9.81  53.3 18.40
> 2.4.21-pre5         3.76  98.0  3.84   21.43  87.0 24.63    9.62  44.7 21.55
> 2.4.21-pre5-akpm    3.76  98.0  3.84   21.31  87.7 24.31    8.88  34.7 25.61
> 2.4.21-pre5-ac3     3.76  98.0  3.84   21.21  86.7 24.47    9.54  44.3 21.52
> 2.5.66-mjb1         3.69  97.0  3.81   20.96  87.0 24.09    7.97  32.3 24.64
> 2.5.66              3.66  97.0  3.78   20.55  85.0 24.18    7.37  31.7 23.27
> 2.5.66-mm1          3.68  97.0  3.80   20.48  85.0 24.10    7.85  28.0 28.05
> 2.5.66-ac1          3.63  97.0  3.74   20.43  83.7 24.42    7.80  33.3 23.39
> 2.2.23              2.96  73.7  4.02    9.85  59.3 16.60    4.47  87.3  5.11
> 
>                   -----------Sequential Input-----------   ------Random-----
>                   -----Per Char-----  ------Block-------   ------Seeks------
> Kernel            MB/sec  %CPU   Eff  MB/sec  %CPU   Eff    /sec  %CPU   Eff
> 2.4.21-pre5aa2      3.92  95.7  4.09   21.26  77.3 27.49     140   1.7  8402
> 2.4.21-pre5-jam1    3.92  96.3  4.07   21.93  82.0 26.74     136   1.7  8150
> 2.4.21-pre5         4.01  97.0  4.13   18.30  66.7 27.45     144   1.7  8656
> 2.4.21-pre5-akpm    3.86  94.0  4.11   17.19  52.3 32.85     141   2.0  7038
> 2.4.21-pre5-ac3     4.01  98.0  4.09   18.40  66.3 27.74     138   1.7  8270
> 2.5.66-mjb1         4.00  99.0  4.04   15.00  16.3 91.84     126   3.0  4210
> 2.5.66              3.94  98.3  4.01   14.24  17.0 83.76     137   3.0  4574
> 2.5.66-mm1          3.92  98.0  4.00   14.58  16.7 87.46     154   3.0  5140
> 2.5.66-ac1          3.98  99.0  4.02   14.64  16.3 89.65     134   4.0  3344
> 2.2.23              3.05  96.7  3.15    9.62  77.3 12.43     133   1.0 13329

the improvement for read contigous of my tree versus the others is
nothing here, scsi really shows the difference between my tree and
all others including 2.5. IDE is capable of 64k dma only, so the
difference is not huge in the above results. On scsi a plain bonnie
approches a 100% improvement on some high end hardware as you also can
see in bigbox.html.

thanks,

Andrea
