Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274633AbRITU2H>; Thu, 20 Sep 2001 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274635AbRITU15>; Thu, 20 Sep 2001 16:27:57 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:65072 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S274633AbRITU1m> convert rfc822-to-8bit; Thu, 20 Sep 2001 16:27:42 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Roger Larsson <roger.larsson@norran.net>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <andrea@suse.de>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20010920063132Z274334-761+10736@vger.kernel.org>
In-Reply-To: <1000939458.3853.17.camel@phantasy> 
	<20010920063132Z274334-761+10736@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 16:27:47 -0400
Message-Id: <1001017681.6218.116.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 02:31, Dieter Nützel wrote:
> Here are some results for 2.4.10-pre12 (Andrea's VM :-)
> 
> Athlon II 1 GHz (0.18 µm)
> MSI MS-6167 Rev 1.0B (Irongate C4)
> 640 MB PC100-2-2-2 SDRAM
> IBM DDYS 18 GB U160 (on AHA-2940UW)
> ReiserFS 3.6 on all partitions
> 
> Sound driver is the new kernel one for SB Live! (not ALSA).
> No swap used during whole test.

Good. I use that sound driver too (I was the one who updated it and
caused the commotion back in 2.4.9 :)

I am interested if you see any different times if you switch to ALSA,
though.

> 2.4.10-pre12 + patch-rml-2.4.10-pre12-preempt-kernel-1 + 
> patch-rml-2.4.10-pre12-preempt-stats-1
> 
> Hope my numbers help to find the right reason for the hiccups.
> ReiserFS seems _NOT_ to be the culprit for this.
> Maybe the scheduler it self?

The scheduler does hold some spinlocks.  So does VM.  I am working on
some ideas to tackle the highest of the worst-case spinlocks. Stay
tuned.

> KDE-2.2.1 noatun running MP3/Ogg-Vorbis
>
> time ./dbench 16
> Throughput 29.3012 MB/sec (NB=36.6265 MB/sec  293.012 MBit/sec)
> 7.450u 28.830s 1:13.10 49.6%    0+0k 0+0io 511pf+0w
> load: 1140
> 
> Worst 20 latency times of 5583 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>   5664  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
> <snip>

5ms is not an issue at all, especially for a worst case spinlock... no
problem here.

> time ./dbench 40
> Throughput 24.664 MB/sec (NB=30.83 MB/sec  246.64 MBit/sec)
> 18.690u 77.980s 3:35.09 44.9%   0+0k 0+0io 1111pf+0w
> load: 3734
> 
> Worst 20 latency times of 7340 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>   9313  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
> <snip>

We are getting higher, but still not an issue.  I'll theorize below why
I think it is increasing...

> time ./dbench 48
> Throughput 24.5409 MB/sec (NB=30.6761 MB/sec  245.409 MBit/sec)
> 22.080u 97.560s 4:19.19 46.1%   0+0k 0+0io 1311pf+0w
> load: 4622
> 
> Worst 20 latency times of 10544 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>  12831        BKL        1    30/inode.c         c016cdf1    52/inode.c
>  10869   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
> <snip>

Now we are above what I consider perfect (10ms), but I still am not
concenrned until 15-20ms times.  The list I am compiling is of much
higher problems, so you are fine here too.

The reason I think it jumps during the higher threaded dbenchs is for
the obvious reason - more I/O.  This is causing more seeks and longer
tranversing of the I/O queue.

> KDE-2.2.1 noatun running MP3/Ogg-Vorbis
> 
> Worst 20 latency times of 2252 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>    237        BKL        0  2763/buffer.c        c01410aa   697/sched.c
> <snip>

0.2ms is ideal for any system :)


> Renice -20 both artsd prozesses (the KDE-2.2.1 noatun sound daemon)
> help a little bit but there are still some hiccups (1~3 sec)
> remaining.

You see 1-3second skips in the audio? With the 0.2ms latencies? Grr,
odd.

> But the system is very responsive (mouse, keyboard).
> 
> time ./dbench 16
> Throughput 30.8602 MB/sec (NB=38.5752 MB/sec  308.602 MBit/sec)
> 7.490u 29.350s 1:09.44 53.0%    0+0k 0+0io 511pf+0w
> 
> Worst 20 latency times of 5851 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>   5518  spin_lock        1  1376/sched.c         c0114db3  1380/sched.c
> <snip>
>
> time ./dbench 48
> Throughput 22.85 MB/sec (NB=28.5626 MB/sec  228.5 MBit/sec)
> 21.840u 98.560s 4:38.30 43.2%   0+0k 0+0io 1311pf+0w
> 
> Worst 20 latency times of 8664 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>  11179  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
> <snip>

Still OK.

Thanks for the feedback.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

