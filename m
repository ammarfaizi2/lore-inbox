Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRJKKpe>; Thu, 11 Oct 2001 06:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276018AbRJKKpZ>; Thu, 11 Oct 2001 06:45:25 -0400
Received: from mail.anu.edu.au ([150.203.2.7]:47272 "EHLO mail.anu.edu.au")
	by vger.kernel.org with ESMTP id <S275990AbRJKKpP>;
	Thu, 11 Oct 2001 06:45:15 -0400
Message-ID: <3BC5778D.F5375F45@anu.edu.au>
Date: Thu, 11 Oct 2001 20:42:21 +1000
From: Robert Cohen <robert.cohen@anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Bench] Updated results on IO fairness and throughput in 2.4.11p6 due to 
 page cache contention
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have continued testing various kernels. The problems I reported a week
or 2 ago are unchanged.
That report can be found at
http://marc.theaimsgroup.com/?l=linux-kernel&m=100159517326725&w=2

I have now tested with kernels up to
2.4.11pre6
2.4.11pre6aa1
2.4.10-ac11 with Rik's Hog patch.

I havent tried 2.4.11 or 2.4.12 but the changelogs show no VM changes
from 2.4.11pre6

I believe I have a slightly better understanding of the problem now.
I believe its a page cache contention problem.
There is a slightly different test that shows it a little more clearly.

The test consists of 5 Mac clients via netatalk writing a 30 Meg file
repeatedly.
After each run they seek back to the start of the file and rewrite.
Note the test in the previous message involved both writing and reading.
In this test the clients are writing only.
The file systems on the server are ext2.

First test is with 256 megs of memory.
Vmstat 5 output for a test against a server running 2.4.11pre6 with 256
megs of memory is
http://tltsu.anu.edu.au/~robert/linux_logs/2.4.11p6-write-256

In this test the server performs extremely well. Throughput is high.
Fairness is good with the clients finishing within seconds of each
other. As you would expect there is only writing out going on. No blocks
are being read from disk.

Second test is with 128 Megs of memory.
Vmstat 5 output for a test against a server running 2.4.11pre6 with 128
megs of memory is
http://tltsu.anu.edu.au/~robert/linux_logs/2.4.11p6-write-128

Here throughput is generally bad. There is a period of higher throughput
at the start when one client races away leaving all the others starved.
After that the throughput drops of to not much more than  1/10 of the
previous test.
There is also a certain amount of reading in of blocks which I don't
entirely understand. Even though only writes are being done by the
clients.

The situation here is that there are 5 clients writing 30 Meg files. So
there are 150 Megs of files being written and only about 100 Megs of
memory available for the page cache.
So not all the files can be mapped into the page cache at the same time.
For each write, if that portion of the file is currently mapped into the
page cache, the write can go through immediately. If it is not currently
mapped into the page cache, something has to be evicted.

The problem is that for some reason, almost all the blocks in the page
cache are pinned with blocks being freed at a relatively slow rate. So
for a write, a space can't be found in the page cache and the write
blocks.

If a client manages to get all the blocks representing its file mapped
into the page cache at the same time then that client can race ahead.
Its blocks are unlikely to be evicted since they have been recently used
and we get the unfair behaviour I have been seeing.

The real question is why are the blocks pinned in the page cache. And
why are they being released at such a slow rate.
Do any of the MM guru's have any suggestions?
Is it due to write throttling?

--
Robert Cohen
Unix Support
TLTSU
Australian National University
Ph: 612 58389
