Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSGTRLX>; Sat, 20 Jul 2002 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSGTRLX>; Sat, 20 Jul 2002 13:11:23 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:27099 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317446AbSGTRLW>; Sat, 20 Jul 2002 13:11:22 -0400
Date: Sat, 20 Jul 2002 09:13:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.19-rc1-jam1
Message-ID: <20020720131301.GA23215@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea put many pieces of read_latency2 in -aa.  One thing 
I'd like to see -jam try is nr_requests = 256 in 
drivers/block/ll_rw_blk.c.  

Andrew's read_latency2 had nr_request set to 1024 for most
machines.  nr_request max is 128 in -marcelo, -aa and -jam.

When dbench process count is 64, the original read_latency2 
helped throughput. 

dbench 64 ext2              Average       High        Low
2.4.19-pre7                  146.00     160.24     103.17 MB/sec
2.4.19-pre7-rl               151.41     155.75     137.63

dbench 64 reiserfs
2.4.19-pre7                   67.86      68.94      66.70
2.4.19-pre7-rl                70.49      71.11      69.96

dbench 64 ext3
2.4.19-pre7                   81.84      89.13      64.81
2.4.19-pre7-rl                81.73      85.28      73.01

It helped a little on ext2 for dbench 192.

dbench 192 ext2             Average       High        Low
2.4.19-pre7                  113.99     119.63     107.52 MB/sec
2.4.19-pre7-rl               115.59     120.17     111.55

But for reiserfs and ext3, it hurt on dbench 192.

dbench 192 ext3
2.4.19-pre7                   60.24      61.03      58.54
2.4.19-pre7-rl                32.08      32.82      31.59

dbench 192 reiserfs
2.4.19-pre7                   49.35      50.63      48.65
2.4.19-pre7-rl                27.30      28.13      26.55


On tiobench, the original read_latency2 made max latency drop from 
457 seconds down to 2 seconds when there were 64 threads.  
Throughput went up too.

Sequential Reads ext2

                   Num              Maximum
Kernel             Thr  MB/sec      Latency (seconds)
-----------------  ---  --------------------
2.4.19-pre7         64   31.68         457.5
2.4.19-pre7-rl      64   35.77           2.1
                                 
At 256 threads, read_latency2 also dropped latency and
improved throughput.  

2.4.19-pre7        256   33.18         752.4
2.4.19-pre7-rl     256   36.51         134.0

ext3 and reiserfs did not have sequential read throughput 
regressions with read_latency2 for tiobench.  

Up to more modern times.

At 64 threads, ac2 has low maximum latency (ac has read_latency2 
with nr_requests = 1024).

                   Num              Maximum
Kernel             Thr  MB/sec      Latency (seconds)
-----------------  ---  --------------------
2.4.19-pre10-ac2    64   30.19           1.5
2.4.19-pre10-jam3   64   40.69          29.5
2.4.19-rc1          64   32.86         342.3
2.4.19-rc1-aa2      64   40.72          31.4
2.5.26              64   23.11         561.8

At 256 threads, it's a different story.  -aa and -jam have the 
lowest max latency numbers, but they are still high.

                   Num              Maximum
Kernel             Thr  MB/sec      Latency (seconds)
-----------------  ---  --------------------
2.4.19-pre10-ac2   256   29.66        1083.4
2.4.19-pre10-jam3  256   40.35         108.0
2.4.19-rc1         256   32.67         855.9
2.4.19-rc1-aa2     256   40.57         129.5
2.5.26             256   22.23        1135.0

queue_nr_requests is 256 in 2.5.26.  

dbench ext2 64 processes       Average      High         Low
2.5.26                         220.13       231.97       194.40 MB/sec

dbench ext2 192 processes      Average      High         Low
2.5.26                         185.87       210.57       152.97

It's Andrew's other magic that makes dbench so high in 2.5.26,
but I wonder if nr_request = 256 would improve latency/throughput 
in -aa and -jam without regressing dbench 192 on ext3/reiserfs.
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

