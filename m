Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTBJDDp>; Sun, 9 Feb 2003 22:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTBJDDp>; Sun, 9 Feb 2003 22:03:45 -0500
Received: from dial-ctb0312.webone.com.au ([210.9.243.12]:23556 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261286AbTBJDDo>;
	Sun, 9 Feb 2003 22:03:44 -0500
Message-ID: <3E4718D9.4030805@cyberone.com.au>
Date: Mon, 10 Feb 2003 14:13:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Con Kolivas <ckolivas@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>The only way to get the minimal possible latency and maximal fariness is
>my new stochastic fair queueing idea.
>
Sounds nice. I would like to see per process disk distribution.

>
>
>The troughput/latency curve has only a few points where the throughput
>incrase while latency decrease. The miniumum latency doesn't necessairly
>mean minimal throughput as maxmium latency doesn't necessairly imply
>maximal throughput.
>
>But clearly maximum throughput likely implys not minium latency and the
>other way around.
>
>I described my idea to Jens a few days ago and he's working on it right
>now AFIK, incidentally he had an equivalent idea in the past and he had
>some old code that he's starting with.  For the details on how it works
>you can read the stochastic fair queueing in the network packet
>scheduler (net/sched/sch_sfq.c).
>
>The design I proposed is to have multiple I/O queues, where to apply the
>elevator, and to choose the queue in function of the task->pid that is
>sumbitting the bh/bio. You'll have to apply an hash to the pid and you
>probably want a perturbation timer that will change the hash function
>every 30 sec or so. Plus I want a special queue for everything
>asynchronoys. So that the asynchronoys queue will be elevated and
>reordered like today since it's not latency critical. I suggeted Jens to
>differentiate it by checking current->mm, all the async stuff is
>normally submitted by the kernel daemons. A more finegrined way is to
>add a bitflag that you have to set between the bh lock and the submit_bh
>and that will be cleared by unlock_buffer (or equivalent one for the bio
>in 2.5). But the current->mm will take care of async-io with keventd too
>so it should be just fine (modulo the first aio submit but it's a minor
>issue).
>
>Then the lowlevel drivers will pick requests from these queues in round
>robin (other variations may be possible too, like two requests per queue
>or stuff like that, but 1 request per queue should give an unbelieveable
>responsiveness to the system, something that we never experienced before).
>
However dependant reads can not merge with each other obviously so
you could end up say submitting 4K reads per process.

>
>
>This stochastic fair queueing I/O scheduling algorithm will be the best
>for desktop/multimedia, i.e. when your priority is that xmms or mplayer
>never skips no matter how many cp /dev/zero . you're running in
>background. Or also for a multiuser system. There is no other possible
>definitive fix IMHO. The only other possible fix would be to reduce the
>I/O queue to say 512kbytes and to take advantage of the FIFO behaviour
>of the queue wakeups, I tried that, it works so well, you can trivially
>test it with my elevator-lowlatency by just changing a line, but the
>problem is 512k is a too small I/O pipeline, i.e. it is not enough to
>guarantee the maximal throughput during contigous I/O. 2M of queue is
>the miniumum for using at best 100Mbyte arrays like my raid box.
>
But your solution also does nothing for sequential IO throughput in
the presence of more than one submitter. Two sequential readers on
different parts of the disk for example. Submit 128K request (4ms),
seek (5ms), submit 128K request (4ms), so your 30MB/s disk gets
less than 15MB/s here. Same with writes.

I think you should be giving each process a timeslice, that way you
don't need to try to account for request size or seek vs IO time and
is easily tunable. This should solve the above problem with say 50ms
timeslices.

It also does little to help dependant reads vs writes or streaming
reads.

For reads, anticipatory scheduling can be very helpful in theory
however it remains to be seen if I can make it work without adding
too much complexity. Your fair queueing should go nicely on top
if I can make it work. I do like your idea though!

Nick

