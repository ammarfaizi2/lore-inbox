Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292708AbSB0R2e>; Wed, 27 Feb 2002 12:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292295AbSB0R2O>; Wed, 27 Feb 2002 12:28:14 -0500
Received: from firewall.oeone.com ([216.191.248.101]:16908 "HELO
	mail.oeone.com") by vger.kernel.org with SMTP id <S292783AbSB0R1v>;
	Wed, 27 Feb 2002 12:27:51 -0500
Message-ID: <3C7D1964.2060903@oeone.com>
Date: Wed, 27 Feb 2002 12:37:40 -0500
From: Masoud Sharbiani <masouds@oeone.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011209
X-Accept-Language: en-us
MIME-Version: 1.0
To: Reza Roboubi <reza@linisoft.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Async IO using threads
In-Reply-To: <3C7CBB39.A6FC444@linisoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I tried your program on my system (P3 800MHz/256Meg ram, IDE harddrive 
with UDMA enabled, 2.4.17-rmap12f) with minor changes: I used a file 
instead of
a raw device. after creating file (64Mega bytes) and flushing read cache 
(writing another huge file with DD on same filesystem), this is what
happened:
A normal read test (for speed measurements).
[root@masouds1 bsd]# time cat mytest > /dev/null

real    0m1.771s
user    0m0.020s
sys     0m0.280s
---
So, 1.7 sec. total time to read data from file.
Now, I flushed cache again and ran your test program:
[root@masouds1 bsd]# ./async
useful CPU work         1 at time(secs, micro-secs) 1014831058 173783
useful CPU work     80848 at time(secs, micro-secs) 1014831059 776664
useful CPU work   1216070 at time(secs, micro-secs) 1014831069 786353

Between number 2 and 3, your program sleeps 10 seconds.  That would be 
121607 counters each second. Now, when reader-thread and worker-thread 
are both running, you get 80000 counts for 1.6 seconds where you should 
get 1.6 * 121607 = 194570. That is a 33% of CPU power.
and remember that lots of time is consumed during copying 64 megabytes 
of data to user buffer (let alone kernel moving it around and context 
switches).
So I believe there isn't a bug in recent version of Linux kernel. Unless 
I'm way off track!
Can you run same test I did and report results here?

Masoud
PS: make sure you are not running your IDE drive in PIO mode.




Reza Roboubi wrote:

>SUMMARY:
>
>Basically, I'm trying to do async io through a SCHED_FIFO thread with
>high priority reading the disk, and the other less prioritized thread
>doing "real" work.  But I can't get _nearly_ enough out of the CPU while
>reading the disk with the other thread.  It is just intolerably 
>inefficient and I _hope_ that I am making  a mistake. 
>Any ideas on how this should work are appreciated.
>
>MORE INFO (only if you must have it):
>
>I read much of the async io / kio discussion on the LK mailing list. 
>Finally
>Linus concluded that threading _is_ the way to go for now(2001 I
>believe).
>
>First, I have kernel 2.2.16  (RedHat 6.2).   If this has been corrected
>in the 2.4, then please let me know, but I think not.
>
>On my system, "raw" read()ing a large chunk of the /dev/hda5 partition
>shows that reading a page (4k) takes about 230000 clock "ticks" which is
>the cpu effort required for 23 context switches.  So I figure if the
>disk generates the "io available" interrupt once every 4k chunk  (this
>might be the bad assumption), then linux  has plenty time to do
>several switches between the interrupt handler, and the high priority
>SCHED_FIFO process, and the low priority SCHED_FIFO process, and still
>have time for plenty useful work at the user level, and time to get back
>to handle the io request.  During this read(), I should be able to use
>at _least_ 50% of my CPU.  But I get much less than 10 percent!!  Why??
>
>If there is anything that should be done to the kernel, please let me
>know  as I'd certainly be very willing to help.  How  exactly _does_
>this  scheduling and io thing work?  Is there some "jiffy" that _must_
>expire before Linux switches and lets my other thread do useful work? 
>If so,  then how do you shorten it?  Or is it that my IDE disk is very
>lousy?   Then what are the parameters I should consider in an IDE disk
>and how do I tell what I have??  Or is this simply a bad and pending
>Linux bug?
>(hard to believe)
>
>Or maybe my test code  is faulty (unlikely also.)
>
>(Test code at http://www.linisoft.com/test/async.c .)
>
>Please reply to me directly.
>
>Thanks in advance for any insight.
>



