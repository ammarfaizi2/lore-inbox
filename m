Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRH1Bdm>; Mon, 27 Aug 2001 21:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270075AbRH1Bdd>; Mon, 27 Aug 2001 21:33:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3597 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270073AbRH1BdQ> convert rfc822-to-8bit; Mon, 27 Aug 2001 21:33:16 -0400
Date: Mon, 27 Aug 2001 21:05:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010828010850Z270025-760+6645@vger.kernel.org>
Message-ID: <Pine.LNX.4.21.0108272103560.7385-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Aug 2001, Dieter Nützel wrote:

> [-]
> > In the real-world case we observed the readahead was actually being
> > throttled by the ftp clients.  IO request throttling on the file read
> > side would not have prevented cache from overfilling.  Once the cache
> > filled up, readahead pages started being dropped and reread, cutting
> > the server throughput by a factor of 2 or so.  On the other hand,
> > performance with no readahead was even worse.
> [-]
> 
> Are you like some numbers?

Note that increasing readahead size on -ac and stock tree will affect the
system in a different way since the VM has different logics on drop
behind.

Could you please try the same tests with the stock tree? (2.4.10-pre and
2.4.9)

> 
> I've generated some max-readahead numbers (dbench-1.1 32 clients) with 
> 2.4.8-ac11,  2.4.8-ac12 (+ memory.c fix) and 2.4.8-ac12 (+ memory.c fix + low 
> latency)
> 
> system:
> Athlon I 550
> MSI MS-6167 Rev 1.0B, AMD Irongate C4 (without bypass)
> 640 MB PC100-2-2-2 SDRAM
> AHA-2940UW
> IBM U160 DDYS 18 GB, 10.000 rpm (in UW mode)
> all filesystems ReiserFS 3.6.25
> 
> * readahead do not show dramatic differences
> * killall -STOP kupdated DO
> 
> Yes, I know it is dangerous to stop kupdated but my disk show heavy thrashing 
> (seeks like mad) since 2.4.7ac4. killall -STOP kupdated make it smooth and 
> fast, again.
> 
> Could it be that kupdated and kreiserfsd do concurrent (double) work?
> The numbers for context switches are more than double with kupdated than 
> without it. Without kupdated the system feels very smooth and snappy.
> Low latency patch push this even further.
> 
> Regards,
> 	Dieter
> 
> 
> 2.4.8-ac11
> 
> max-readahead 511
> Throughput 22.4059 MB/sec (NB=28.0073 MB/sec  224.059 MBit/sec)
> 24.780u 78.010s 3:09.54 54.2%   0+0k 0+0io 911pf+0w
> 
> max-readahead 31 (default)
> Throughput 19.7815 MB/sec (NB=24.7269 MB/sec  197.815 MBit/sec)
> 24.690u 73.630s 3:34.55 45.8%   0+0k 0+0io 911pf+0w
> 
> max-readahead 15
> Throughput 20.5266 MB/sec (NB=25.6583 MB/sec  205.266 MBit/sec)
> 25.430u 77.090s 3:26.79 49.5%   0+0k 0+0io 911pf+0w
> 
> max-readahead 7
> Throughput 19.7186 MB/sec (NB=24.6483 MB/sec  197.186 MBit/sec)
> 24.950u 77.820s 3:35.23 47.7%   0+0k 0+0io 911pf+0w
> 
> max-readahead 3
> Throughput 21.1795 MB/sec (NB=26.4743 MB/sec  211.795 MBit/sec)
> 26.020u 79.290s 3:20.45 52.5%   0+0k 0+0io 911pf+0w
> 
> max-readahead 0
> Throughput 19.3769 MB/sec (NB=24.2211 MB/sec  193.769 MBit/sec)
> 25.070u 77.550s 3:39.00 46.8%   0+0k 0+0io 911pf+0w
> 
> killall -STOP kupdated
> retry with the 2 best cases
> 
> max-readahead 3
> Throughput 34.6985 MB/sec (NB=43.3731 MB/sec  346.985 MBit/sec)
> 24.230u 81.930s 2:02.75 86.4%   0+0k 0+0io 911pf+0w
> 
> max-readahead 511 (it is repeatable, see below)
> Throughput 32.3584 MB/sec (NB=40.448 MB/sec  323.584 MBit/sec)
> 24.190u 86.130s 2:11.55 83.8%   0+0k 0+0io 911pf+0w
> 
> Throughput 33.28 MB/sec (NB=41.6 MB/sec  332.8 MBit/sec)
> 25.220u 84.260s 2:07.93 85.5%   0+0k 0+0io 911pf+0w
> 
> After (heavy) work:
> Throughput 25.3106 MB/sec (NB=31.6383 MB/sec  253.106 MBit/sec)
> 25.370u 84.420s 2:47.91 65.3%   0+0k 0+0io 911pf+0w
> 
> After reboot:
> Throughput 31.2373 MB/sec (NB=39.0466 MB/sec  312.373 MBit/sec)
> 25.500u 83.810s 2:16.26 80.2%   0+0k 0+0io 911pf+0w
> 
> After reboot:
> Throughput 30.0666 MB/sec (NB=37.5833 MB/sec  300.666 MBit/sec)
> 25.020u 83.770s 2:21.50 76.8%   0+0k 0+0io 911pf+0w
> 
> 
> 
> 2.4.8-ac12
> 
> max-readahead 31 (default)
> Throughput 19.4526 MB/sec (NB=24.3157 MB/sec  194.526 MBit/sec)
> 24.840u 79.490s 3:38.16 47.8%   0+0k 0+0io 911pf+0w
> 
> max-readahead 511
> Throughput 21.5307 MB/sec (NB=26.9134 MB/sec  215.307 MBit/sec)
> 25.000u 77.520s 3:17.20 51.9%   0+0k 0+0io 911pf+0w
> 
> killall -STOP kupdated
> 
> max-readahead 31 (default)
> Throughput 28.5728 MB/sec (NB=35.7159 MB/sec  285.728 MBit/sec)
> 24.750u 88.250s 2:28.85 75.9%   0+0k 0+0io 911pf+0w
> 
> max-readahead 511
> Throughput 29.5127 MB/sec (NB=36.8908 MB/sec  295.127 MBit/sec)
> 25.610u 86.730s 2:24.14 77.9%   0+0k 0+0io 911pf+0w
> 
> 
> 
> 2.4.8-ac12 + The Right memory.c fix
> 
> max-readahead 31 (default)
> Throughput 22.0905 MB/sec (NB=27.6131 MB/sec  220.905 MBit/sec)
> 25.340u 77.700s 3:12.24 53.5%   0+0k 0+0io 911pf+0w
> 
> killall -STOP kupdated
> 
> max-readahead 31 (default)
> Throughput 29.2189 MB/sec (NB=36.5236 MB/sec  292.189 MBit/sec)
> 25.750u 82.090s 2:25.57 74.0%   0+0k 0+0io 911pf+0w
> 
> 
> 
> 2.4.8-ac12 + The Right memory.c fix + low latency patch
> 
> max-readahead 31 (default)
> Throughput 20.3505 MB/sec (NB=25.4381 MB/sec  203.505 MBit/sec)
> 25.430u 75.250s 3:28.58 48.2%   0+0k 0+0io 911pf+0w
> 
> killall -STOP kupdated
> 
> max-readahead 31 (default)
> Throughput 29.25 MB/sec (NB=36.5625 MB/sec  292.5 MBit/sec)
> 24.600u 86.370s 2:25.42 76.3%   0+0k 0+0io 911pf+0w
> 
> max-readahead 511
> Throughput 30.0372 MB/sec (NB=37.5465 MB/sec  300.372 MBit/sec)
> 25.590u 75.910s 2:21.64 71.6%   0+0k 0+0io 911pf+0w
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

