Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSGOFT6>; Mon, 15 Jul 2002 01:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSGOFT5>; Mon, 15 Jul 2002 01:19:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13330 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317326AbSGOFT4>;
	Mon, 15 Jul 2002 01:19:56 -0400
Message-ID: <3D325DEB.A9920C12@zip.com.au>
Date: Sun, 14 Jul 2002 22:30:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Steve Lord <lord@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
References: <3D2CFF48.9EFF9C59@zip.com.au> <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> 
> Andrew Morton wanted me to do some benchmarking of large files on ext2
> filesystems rather than the usual block-device testing
> i've had some time to do this, here are the results.
> 
> one-line summary is that some results are better, some are worse; CPU usage
> is better in 2.5.25, but thoughput is sometimes
> worse.

Well thanks for doing this.  All rather strange though.

- You should definitely be seeing reduced CPU on writes through the
  pagecache.  A whole pile of gunk has disappeared from there.
  Here's what I get with 4x4gig files on 4xIDE disks:

for i in hde5 hdg5 hdi5 hdk5
do
	/usr/src/ext3/tools/write-and-fsync -m 4000 -f /mnt/$i/foo &
done

2.4.19-rc1+block_highmem 0.06s user 106.75s system 53% cpu 3:20.94 total
2.5.25                   0.03s user 78.37s system 40% cpu 3:14.82 total
2.5.25+some stuff        0.05s user 77.91s system 41% cpu 3:07.70 total
2.5.25+O_DIRECT          0.00s user 6.84s system 3% cpu 2:53.21 total


That's a 25% drop in CPU load for writes in 2.5.  Actually more, because
Andre's current 2.5 IDE drivers are using teeny requests and are measurably
slow.

That's how it should be, and it is strange that you're not showing
decreased CPU and increased throughput on writes.

- For reads through the pagecache you're showing good reduction in CPU
  and some increase in bandwidth.

When reading the above 4 files in parallel on the IDE setup I show:

for i in hde5 hdg5 hdi5 hdk5
do
	time /usr/src/ext3/tools/time-read -b 8192 -h 8192 /mnt/$i/foo &
done                

2.5.25:                      0.43s user 42.74s system 31% cpu 2:17.87 total
2.4.19-rc1+block-highmem:    0.37s user 54.48s system 40% cpu 2:16.17 total
2.4.19-rc1:                  0.63s user 129.21s system 76% cpu 2:49.66 total

A 25% drop in CPU load on buffered reads in 2.5.


Funny thing about your results is the presence of sched_yield(),
especially in the copy-from-pagecache-only load.  That test should
peg the CPU at 100% and definitely shouldn't be spending time in
default_idle.  So who is calling sched_yield()?  I think it has to be
your test app?

Be aware that the sched_yield() behaviour in 2.5 has changed a lot
wrt 2.4.  It has made StarOffice 5.2 completely unusable on a non-idle
system, for a start.  (This is a SO problem and not a kernel problem,
but it's a lesson).

-
