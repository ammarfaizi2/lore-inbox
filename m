Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293338AbSB1R13>; Thu, 28 Feb 2002 12:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293519AbSB1RYq>; Thu, 28 Feb 2002 12:24:46 -0500
Received: from h24-80-72-10.vn.shawcable.net ([24.80.72.10]:46596 "EHLO
	linisoft.localdomain") by vger.kernel.org with ESMTP
	id <S293502AbSB1RVu>; Thu, 28 Feb 2002 12:21:50 -0500
Message-ID: <3C7E68F1.5D59A1F4@linisoft.com>
Date: Thu, 28 Feb 2002 09:29:21 -0800
From: Reza Roboubi <reza@linisoft.com>
Organization: Linisoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Masoud Sharbiani <masouds@oeone.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Async IO using threads
In-Reply-To: <3C7CBB39.A6FC444@linisoft.com> <3C7D1964.2060903@oeone.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masoud,

First let me thank you for reading and running my test code on your
system.  I greatly appreciate that.  It's so good to see a man with hard
numbers as opposed to just "speaches."  Your response has been extremely
helpful.  

> PS: make sure you are not running your IDE drive in PIO mode.

This one line tip of yours was probably more helpful to me than many
hours of heart-bleeding M$ support can be to some people.

You reminded me that long ago,  due to system instability, I had turned
down some of my  BIOS features.  They could have caused the kernel to
set my hda settings conservatively.  Turns out, that not  only dma was
off, but also "multiple read" was set to one.   But the dma did the
major change:

> a raw device. after creating file (64Mega bytes) and flushing read cache
> (writing another huge file with DD on same filesystem), this is what
> happened:
> A normal read test (for speed measurements).
> [root@masouds1 bsd]# time cat mytest > /dev/null
> 
> real    0m1.771s
> user    0m0.020s
> sys     0m0.280s
> ---

I got:

[root in ~]$ time cat /scratch0/big  > /dev/null
0.53user 3.12system 0:09.35elapsed 39%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (25214major+14minor)pagefaults 0swaps

This is probably much better than I had before (big = 102 MB).


> So, 1.7 sec. total time to read data from file.
> Now, I flushed cache again and ran your test program:
> [root@masouds1 bsd]# ./async
> useful CPU work         1 at time(secs, micro-secs) 1014831058 173783
> useful CPU work     80848 at time(secs, micro-secs) 1014831059 776664
> useful CPU work   1216070 at time(secs, micro-secs) 1014831069 786353
> 

I get:
[root in /home/reza/backup/tmpwork/tests/linux_timings]$ ./async.out 
useful CPU work         1 at time(secs, micro-secs) 1014905754 12224
useful CPU work    240204 at time(secs, micro-secs) 1014905758 8111
useful CPU work   1082083 at time(secs, micro-secs) 1014905768 15236

(using raw, NOT cache)

This is 0.63% efficiency.  It is beautiful.   Note that this answers my 
basic question, that I had known all along anyways:  Making my code
complex to take advantage of multi-threading is most certainly worth it.

Now, I did the test again, this time using fifos for doing the "real
work", this is less efficient, and gives about 0.45% of  the CPU back
during another thread's read(2).

Intuition suggests that this can still be better, because I also did
tests for memcpy and thread context switching under Linux, and Linux is
very efficient in these areas (my machine can do roughly 400k context
switches in the 4 seconds it took to read that ~50MB  chunk (see test
above)) This appeasr to be excellent performance (on the micro second
scale anyways).  And one might figure that the CPU does not need 55% of
it's power sustaining a few inter-thread context switches and copies
during read(large_chunk).  But my tests are small chunks of code.  when
things get large, as they are in the kernel, I can see constant factors
like TLB updates and such adding up.  

I can see how valuable it would be to put aside some time and study the
ide driver source, and the kernel in general.  At least  when one  wants
something specific, like the Google servers, one probably can find ways
to tailor the kernel and get more out of it.  Maybe much more for
something real specific.  No WONDER Google would choose Linux.  It is
impossible to customize any closed source os that way.  

In any case, for any more questions in this regard, the source code and
the LK archives should be my reference.  But your great help got me
beautifully into the order of magnitude I wanted.  

Thank you so much, again.

-- 
Reza
