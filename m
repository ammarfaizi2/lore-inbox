Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRJPJLH>; Tue, 16 Oct 2001 05:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRJPJK6>; Tue, 16 Oct 2001 05:10:58 -0400
Received: from mail.anu.edu.au ([150.203.2.7]:50678 "EHLO mail.anu.edu.au")
	by vger.kernel.org with ESMTP id <S275843AbRJPJKm>;
	Tue, 16 Oct 2001 05:10:42 -0400
Message-ID: <3BCBF8E1.9BDDB3B1@anu.edu.au>
Date: Tue, 16 Oct 2001 19:07:45 +1000
From: Robert Cohen <robert.cohen@anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Bench] New benchmark showing fileserver problem in 2.4.12
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently been reporting on problems with file server performance
in recent 2.4 kernels.
Since the setup I was using is difficult for most people to reproduce
(it involved 5 mac clients) I have taken the time to find a benchmark
that more or less reproduces the problems in a more accessible manner.

The original benchmark involved a number of file server clients writing
to  the server.

The new benchmark involves two programs "send" and "receive". Send
generates data on standard out.
Receive takes data from stdin and writes it to a file. They are setup to
do this for a number of repetitions.
When "receive" reaches the end of the file it seeks back to the
beginning and rewrites the file.
I think it may be significant that the file is not truncated, it is
overwritten.

Send and Receive are designed to run over an rsh pipe. The programs take
2
parameters "file_size" and the number of repetitions. The same
parameters
should be given to each program.

To duplicate the activity of the original benchmark, I run 5 copies each
using files of 30 Megs:
./send 30 10 | rsh server ./receive 30 10 &

Since its a networked benchmark you need at least 2 linux machines on
100 Meg (or faster) network.
Originally I thought I might need to run the "send" programs on separate
machines, but testing indicates that I get the same problems running all
the "send"'s on one machine and the "receives" on another.
I have to admit I used a solaris box to run the sends on since I don't
have 2 linux machines here but I can't see why that would make any
difference.


The source code for send is at http://tltsu.anu.edu.au/~robert/send.c
Receive is at http://tltsu.anu.edu.au/~robert/receive.c

In order to produce the problem, the collective filesize has to be
bigger than the memory in the server.
In this example the collective filesize is 5*30=150 Megs.

You can see the problems most clearly by running vmstat while the
program runs.

So if I run it against a server with 256 Megs of memory, there are  no
problems. The run takes about 6 minutes to complete.
A vmstat output is available at
http://tltsu.anu.edu.au/~robert/linux_logs/sr-256

If I run it against a server with 128 Megs of memory, the throughput as
shown by the "bo" stat starts out fine but the page cache usage rises
while the files are written. When the page cache tops out, the "bo"
figure drops sharply. At this point we get reads happening as shown by
"bi" even though the program does no reads. I presume that pages evicted
from page cache need to be read back into page cache before they can be
modified by writes.

With 128 Megs of memory, the benchmark takes about 30 minutes to run. So
its 5 times slower
than with 256 Megs. Given that the system isnt actually getting any
benefit out of the page cache since the files are never read back in, I
would have hoped there wouldnt be much difference.
A vmstat output for a 128 Meg run is at
http://tltsu.anu.edu.au/~robert/linux_logs/sr-128.


I can reproduce the problems with 256 Megs of memory by running 5
clients with 60 Meg files instead of 30 Meg files.

I get similar results with the following kernels

2.4.10-ac11 with Rik's Hog patch.
2.4.12-ac3
2.4.11-pre6

With an aa kernel 2.4.13pre2-aa1, once the page cache fills up, we
start getting "order 0 allocation" fails. The mem killer kicks in and
kills one of the receives (even though it only allocates 8k of memory
:-(  ). The remaining clients then show similar throughput problems.

The problem does not occur when the sends and receives are run on the
same machine connected by pipes. This seems to indicate that its an
interaction between the memory usage by the page cache and the memory
usage by the network subsystem.

Also the problem is not as pronounced if I test with 1 client accessing
150 Megs rather than 5 clients accessing 30 Megs each.

--
Robert Cohen
Unix Support
TLTSU
Australian National University
Ph: 612 58389
