Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280956AbRKTHa3>; Tue, 20 Nov 2001 02:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280953AbRKTHaV>; Tue, 20 Nov 2001 02:30:21 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:45510 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S280949AbRKTHaF>; Tue, 20 Nov 2001 02:30:05 -0500
Date: Tue, 20 Nov 2001 02:32:40 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O tests using elvtune to improve interactive performance
Message-ID: <20011120023240.B1509@earthlink.net>
In-Reply-To: <138.49c8e42.29247804@aol.com> <20011117030611.A214@earthlink.net> <20011119080922.S11826@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011119080922.S11826@suse.de>; from axboe@suse.de on Mon, Nov 19, 2001 at 08:09:22AM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 08:09:22AM +0100, Jens Axboe wrote:
> Interesting tests, thanks. I wonder if you could be convinced to do
> bonnie++ and dbench tests with the same read_latency values used? Also,
> -- 
> Jens Axboe

Jens,

I'm sure this isn't what you had in mind, but ...  :)

Kernel:	2.4.15-pre6

Test:	dbench 775 on 5 partitions.  Time ls -l on big directories.
	Test with read_latency to 8192 (default) and 32.

Summary: Load average of 775 and console IRC clients perform great.
	Lower read latency reduces throughput, but big directory listings
	are faster.

This is really a crazy test, but it's a testament to the amazing work 
of the kernel hackers.

I was looking for the I/O load that makes interactive response poor.  
There are a couple growfiles tests in the Linux Test Project that
do that with a load average of less than 5.  dbench is different.
The dbench load the kernel can handle is remarkable.

Hardware:
1 Athlon 1333
1 GB RAM
1 GB swap
1 40 GB IDE disk

A reasonable test may be dbench 36 or 144, which return:
Throughput 90.636 MB/sec (NB=113.295 MB/sec  906.36 MBit/sec)  8 procs
Throughput 56.0331 MB/sec (NB=70.0413 MB/sec  560.331 MBit/sec)  36 procs
Throughput 25.7869 MB/sec (NB=32.2336 MB/sec  257.869 MBit/sec)  144 procs

Instead, I figured out roughly how many simultaneous dbench processes would 
run with the amount of free disk space I have. 

8:01pm  up 53 min, 12 users,  load average: 779.12, 778.68, 737.68

I had 3 console irc sessions up. Occasionally there was a very slight
delay. "ls -l" on the other hand was very slow on big directories; timings 
are below.

Summary:
read latency=8192 compared to read latency=32

dbench 50	10% more throughput
dbench 50	 6% more throughput
dbench 75	22% more throughput
dbench 150	25% more throughput
dbench 450	24% more throughput
ls -l time	48% longer

ls times are interspersed with dbench results in chronologic order.

read_latency = 8192
-------------------
/usr/share/man/man3			real    30m48.908s

# /home/dbench$ ./dbench 50 completes
Throughput 1.91472 MB/sec (NB=2.39339 MB/sec  19.1472 MBit/sec)  50 procs

# /usr/local/dbench$ ./dbench 50 completes
Throughput 1.84434 MB/sec (NB=2.30543 MB/sec  18.4434 MBit/sec)  50 procs

# /dbench$ ./dbench 75 completes
Throughput 2.50039 MB/sec (NB=3.12548 MB/sec  25.0039 MBit/sec)  75 procs

/usr/src/linux ls -laR			real    10m11.953s

# /usr/src/sources/d/dbench$ ./dbench 150 completes
Throughput 3.51881 MB/sec (NB=4.39852 MB/sec  35.1881 MBit/sec)  150 procs

/usr/X11R6/lib/X11/fonts/75dpi		real    28m22.315s
/usr/X11R6/lib/X11/fonts/100dpi		real    12m27.915s

# /opt/dbench$ ./dbench 450 completes
Throughput 4.64194 MB/sec (NB=5.80242 MB/sec  46.4194 MBit/sec)  450 procs


read_latency = 32
-----------------
/usr/share/man/man3			real    10m8.684s

# /home/dbench$ ./dbench 50 completes
Throughput 1.74518 MB/sec (NB=2.18147 MB/sec  17.4518 MBit/sec)  50 procs

# /usr/local/dbench$ ./dbench 50 completes
Throughput 1.73985 MB/sec (NB=2.17481 MB/sec  17.3985 MBit/sec)  50 procs

/usr/src/linux ls -laR			real    5m57.340s

# /dbench$ ./dbench 75 completes
Throughput 2.0441 MB/sec (NB=2.55513 MB/sec  20.441 MBit/sec)  75 procs

/usr/X11R6/lib/X11/fonts/75dpi		real    13m32.822s

# /usr/src/sources/d/dbench$ ./dbench 150 completes
Throughput 2.8047 MB/sec (NB=3.50587 MB/sec  28.047 MBit/sec)  150 procs

/usr/X11R6/lib/X11/fonts/100dpi		real    14m14.336s

# /opt/dbench$ ./dbench 450 completes
Throughput 3.74463 MB/sec (NB=4.68079 MB/sec  37.4463 MBit/sec)  450 procs


Filesystems (test not running)
-----------
Filesystem    Type     Size  Used Avail Use% Mounted on
/dev/hda12 reiserfs    4.2G  1.2G  3.0G  27% /
/dev/hda11 reiserfs     15G  3.9G   11G  26% /opt
/dev/hda5  reiserfs     10G  5.6G  4.9G  53% /usr/src
/dev/hda6  reiserfs    5.2G  3.4G  1.8G  64% /home
/dev/hda8  reiserfs    2.1G  200M  1.8G  10% /usr/local

Conclusion:
Load average 775!
Box is solid.
IRC clients perform great.
Total throughput goes down as load goes up.


It may have made more sense to do a shorter test with less processes and more
values for read_latency, but it turned out this way.  Hopefully it's entertaining, 
nonetheless. :)

-- 
Randy Hron

