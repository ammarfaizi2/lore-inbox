Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272764AbRI0MtY>; Thu, 27 Sep 2001 08:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272736AbRI0MtP>; Thu, 27 Sep 2001 08:49:15 -0400
Received: from mail.anu.edu.au ([150.203.2.7]:31144 "EHLO mail.anu.edu.au")
	by vger.kernel.org with ESMTP id <S272717AbRI0Ms6>;
	Thu, 27 Sep 2001 08:48:58 -0400
Message-ID: <3BB31F99.941813DD@anu.edu.au>
Date: Thu, 27 Sep 2001 22:46:17 +1000
From: Robert Cohen <robert.cohen@anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BENCH] Problems with IO throughput and fairness with 2.4.10 and 
 2.4.9-ac15
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the recent flurry of changes in the Linux kernel VM subsystems I
decided to do a bit of benchmarking.
The benchmark is a test of file server performance. I originally did
this test about a year ago with fairly dismal results, so I thought I'd
see how much things had improved.

The good news, things have improved. The bad news, they're still not
good.

The test consists a linux server acting a file server (using netatalk)
and 5 macintosh clients.The clients each write a 30 Meg file and read it
back. Each client repeats this 10 times.Total amount of IO in the test
1.5 Gigs written, 1.5 Gigs read.

The tests were done with the following kernels

2.4.10: stock 2.4.10 kernel
2.4.10-aa1: 2.4.10 with Andreas patch aa1 including his vm-tweaks-1
2.4.10-p: 2.4.10 with Robert Loves preempt patch
2.4.9-ac15: Alans latest
2.4.9-ac15-al: 2.4.9-ac15 with Riks Aging+Launder patch

2.4.9-ac15 didnt fare too well, but Riks patch resolved these problems
so I will leave 2.4.9-ac15 out of the discussion.


The hardware was a UP P-II 266 with 256 Megs of memory using SCSI disks
on a Adaptec wide controller. The clients and server were all connected
to a 100 Mbit switch.
The hardware is nothing special, but disks and LAN are all capable of
pushing 10 MB/s of bandwidth.

In the test, the clients are each accessing 30 Meg files. With 5
clients, thats a file working set of 150 Megs of disk space being
accessed. With 256 Megs of memory, all the files can fit in memory. I
don't consider this to be a realistic test of file server behaviour
since if all your files on a file server can fit in memory you bought
too much memory :-). 

So for all the tests, the file server memory was limited to 128 Megs via
LILO except for a baseline test with 256 Megs.

The features of a file server that I consider important are obviously
file serving througput. But also fairness in that all clients should get
an equal share of the bandwidth. So for the tests, I report the time
that the last client finishes the run which indicates total throughput,
and the time the first client finishes which ideally should be not too
much before the last client.


Summary of the results
======================

In the baseline test with 256 Megs of memory, all the kernels performed
flawlessly. Close to 10 MB/s of thoughput was achieved evenly spread
between the clients.

In the real test with 128 Megs of memory, things didnt go as well. All
the kernels performed similarly but none were satisfactory. The problem
I saw was that all the clients would start out getting fairly bad
throughput of only a few MB/sec total amongst all the machines. This is
accompanied by heavy seeking of the disk (based on the sound).
Then one of the clients would "get in the groove". The good client gets
the full 10 MB/s of bandwidth and the rest are completely starved. The
good client zooms through to the finish with the rest of the clients
only just started. Once the good client finished, the disks seek madly
for a while with poor throughput until another client "gets in the
groove". 
Once you are down to 2 or 3 clients left, things settle down because the
files all fit in memory again.

Overall, the total throughput is not that bad, but the fact that it
achieves this by starving clients to let one client at a time proceed is
completely unacceptable for a file server.

Note: this is not an accurate benchmark in that the run times are not
highly repeatable. This means it can't be used for fine tuning kernels.
But at the moment, I am not concerned with fine tuning but a huge gaping
hole in linux file serving performance. And its probably true that the
non repeatability indicates a problem in itself. With a well tuned 
kernel, results should be much more repeatable.


Detailed result
===============

Here are the timing runs for each kernel. Times are Minutes:seconds. I
did two runs for each. 
Vmstat 5 outputs are available at
http://tltsu.anu.edu.au/~robert/linux_logs/ 
But none of the vmstat output shows any obvious problems. None of the
kernels used much swap.
And I didnt see any problems with daemons like kswapd chewing time.


Baseline run with 256 Megs
Run 1     First finished 4:05       Last finished: 4:18

Notes: this indicates best case performance


linux-2.4.10:
Run 1     First finished 2:15       Last finished: 5:36
Run 2     First finished 1:41       Last finished: 6:36


Linux-2.4.10-aa1
Run 1     First finished 3:38       Last finished: 8:40
Run 2     First finished 1:35       Last finished: 7:07

Notes: slightly worse than straight 2.4.10


Linux-2.4.10-p
Run 1     First finished 1:39       Last finished: 8:33
Run 2     First finished 1:46       Last finished: 6:10

Notes: no better than 2.4.10, of course the preempt kernel is not
advertised as a server OS but since the problems observed are primarily
fairness problems, I hoped it might help.


Linux-2.4.9-ac15-al
Run 1     First finished 2:00       Last finished: 5:30
Run 2     First finished 1:45       Last finished: 5:07


Notes: this has slightly better behaviour than 2.4.10 in that 2 clients
tend to "get in the groove" at a time and finish early and then another
2 etc.


Analysis
========

In the baseline test with 256 Megs, since all the files fit in page
cache, there is no reading at all. Only writing. The VM seems to handle
this flawlessly.

In the 128 Meg tests, reads start happening as well as writes since
things get flushed out of the page cache.
The VM doesnt cope with this as well. The symptom of heavy seeking with
poor throughput that is seen in this test I associate with poor elevator
performance. If the elevator doesnt group requests enough you get disk
behaviour like "small read, seek, small read, seek" instead of grouping
things into large reads or multiple reads between seeks. 


The problem where one client gets all the bandwidth has to be some kind
of livelock.
Normally I might suspect that the locked out process have been swapped
out, but in this case no swap is being used. I suspose their process
pages could have been flushed to make space for page cache pages.
But this would show up in an incease page cache size in vmstat. Which
doesnt seem to be the case.

 Ironically I believe this is associated with the elevator sorting
requests too aggressively.
All the file data for the processes that are locked out must be flushed
out of page cache, and the locked process can't get enough reads
scheduled to make any progress. Disk operations are coming in for the
"good" process fast enough to keep the disk busy, these are sorted to
the top by the elevator since they are near the current head position.
And noone else gets to make any progress.



It has been suggested that the problems might be specific to netatalk. 
However I have been unable to find anything that would indicates that
netatalk is doing anything odd. Stracing the file server processes shows
that they are just doing 8k reads and writes. The files are not opened
O_SYNC and the file server process arent doing any fsync calls. This is
supported by the fact that the performance is fine with 256 Megs of
memory.

I have been unable to find any non networked test that demonstates the
same problems.
Tests such as 5 simultaneous bonnie runs or a tiotest with 5 threads
that are superficially doing the same things don't see the same
problems.

What I believe is the cause is that since we have 5 clients fighting for
network bandwidth, the packets from each client are coming in
interleaved. So the granularity of operations that the server does is
very fine.
In a local test such as 5 bonnies, each process gets to have a full time
slice accessing its file before the next file is accessed. Which leads
to a much greater granularity.
So I supposed a modified version of tiotest that does a sched_yeild
after each read or write might see the same problems. But I havent
tested this theory.


If anyone has tests they would like me to do, or any patches they would
like me to try please let me know.



--
Robert Cohen
Unix Support, TLTSU
Australian National University
Ph: 612 58389	robert.cohen@anu.edu.au
