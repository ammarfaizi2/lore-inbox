Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTBIOgi>; Sun, 9 Feb 2003 09:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTBIOgi>; Sun, 9 Feb 2003 09:36:38 -0500
Received: from [195.223.140.107] ([195.223.140.107]:34689 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267274AbTBIOgg>;
	Sun, 9 Feb 2003 09:36:36 -0500
Date: Sun, 9 Feb 2003 15:46:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <ckolivas@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030209144622.GB31401@dualathlon.random>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030209133013.41763.qmail@web41404.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only way to get the minimal possible latency and maximal fariness is
my new stochastic fair queueing idea.

The troughput/latency curve has only a few points where the throughput
incrase while latency decrease. The miniumum latency doesn't necessairly
mean minimal throughput as maxmium latency doesn't necessairly imply
maximal throughput.

But clearly maximum throughput likely implys not minium latency and the
other way around.

I described my idea to Jens a few days ago and he's working on it right
now AFIK, incidentally he had an equivalent idea in the past and he had
some old code that he's starting with.  For the details on how it works
you can read the stochastic fair queueing in the network packet
scheduler (net/sched/sch_sfq.c).

The design I proposed is to have multiple I/O queues, where to apply the
elevator, and to choose the queue in function of the task->pid that is
sumbitting the bh/bio. You'll have to apply an hash to the pid and you
probably want a perturbation timer that will change the hash function
every 30 sec or so. Plus I want a special queue for everything
asynchronoys. So that the asynchronoys queue will be elevated and
reordered like today since it's not latency critical. I suggeted Jens to
differentiate it by checking current->mm, all the async stuff is
normally submitted by the kernel daemons. A more finegrined way is to
add a bitflag that you have to set between the bh lock and the submit_bh
and that will be cleared by unlock_buffer (or equivalent one for the bio
in 2.5). But the current->mm will take care of async-io with keventd too
so it should be just fine (modulo the first aio submit but it's a minor
issue).

Then the lowlevel drivers will pick requests from these queues in round
robin (other variations may be possible too, like two requests per queue
or stuff like that, but 1 request per queue should give an unbelieveable
responsiveness to the system, something that we never experienced before).

This stochastic fair queueing I/O scheduling algorithm will be the best
for desktop/multimedia, i.e. when your priority is that xmms or mplayer
never skips no matter how many cp /dev/zero . you're running in
background. Or also for a multiuser system. There is no other possible
definitive fix IMHO. The only other possible fix would be to reduce the
I/O queue to say 512kbytes and to take advantage of the FIFO behaviour
of the queue wakeups, I tried that, it works so well, you can trivially
test it with my elevator-lowlatency by just changing a line, but the
problem is 512k is a too small I/O pipeline, i.e. it is not enough to
guarantee the maximal throughput during contigous I/O. 2M of queue is
the miniumum for using at best 100Mbyte arrays like my raid box.

Also the elevator-lowlatency patch right now has an unplug race that can
hang the box under some workload, it's not a fatal bug (i.e. no risk of
corruption and hard to trigger) and I need to fix it, like I need to
limit the number of requests too or the seeking workloads get huge
latencies with no throughput advantage (very well shown by tiobench in
the great bigbox.html effort from Randy).

The stochastic fair queueing will allow us to keep a rasonable sized
queue to avoid hurting workloads like bonnie, while still providing
the maximum possible fariness across different tasks.

However it has to be optional, I suggested to use the b_max ioctl
(currently unused) to select the scheduler mode, because dbench and
other workloads really want the max reodering task-against-task to get
the maximal throughput, not matter how long a certain dbench task is
delayed. It is really up to the user to choose the I/O scheduling
algorithm, just like it happens today in the network stack. Desktop
users will want the stochastic fair queuing, people running workloads
ala dbench must avoid it.

the stochastic fair queueing will also make the anticipatory scheduling
a very low priority to have. Stochasting fair queueing will be an order
of magnitude more important than anticipatory scheduling IMHO.

Andrea
