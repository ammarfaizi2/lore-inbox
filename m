Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276701AbRJGWG1>; Sun, 7 Oct 2001 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276702AbRJGWGR>; Sun, 7 Oct 2001 18:06:17 -0400
Received: from cs181196.pp.htv.fi ([213.243.181.196]:36485 "EHLO
	cs181196.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S276701AbRJGWGC>; Sun, 7 Oct 2001 18:06:02 -0400
Message-ID: <3BC0D1C9.63C7F218@welho.com>
Date: Mon, 08 Oct 2001 01:06:01 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Context switch times
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com> <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de> <3BC05D2E.94F05935@welho.com> <20011007162439.P748@nightmaster.csn.tu-chemnitz.de> <3BC067BB.73AF1EB5@welho.com> <3BC0982A.84ECBE7B@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> On the face of it this only seems unfair.  I think what we want to do is
> to allocate the cpu resources among competing tasks as dictated by their
> NICE values.  If each task gets its allotted share it should not matter
> if one of them is monopolizing one cpu.  This is not to say that things
> will work out this way, but to say that this is not the measure, nor the
> thing to look at.

I'm not sure I fully understood what you're driving at, but surely "each
task getting its allotted share" implies that the tasks are correctly
balanced across CPUs? I take your point that if you're only interested
in the total completion time of certain set of tasks, it doesn't matter
how they are divided among CPUs as long as each CPU is crunching at
maximum capacity. However, if you're interested in the completion time
of a particular task (or if the task is mostly CPU bound but with
occasional interaction with the user), you need to provide fairness all
the way through the scheduling process. This, IMHO, implies balancing
the tasks across CPUs.

How the balance is determined is another issue, though. I basically
proposed summing the time slices consumed by tasks executing on a single
CPU and using that as the comparison value. Davide Libenzi, on the other
hand, simply proposed using the number of tasks.

I would contend that if you can evenly divide a particular load across
multiple CPUs, you can then run a pre-emptive scheduler on each CPUs run
queue independently, without regard for the other CPUs, and still come
out with high CPU utilization and reasonable completion times for all
tasks. This has the major advantage of limiting spinlock contention to
the load balancer, instead of risking it at every schedule().

> I suggest that, using the "recalculate tick" as a measure of time (I
> know it is not very linear)

I'll take your word for it as I'm not very familiar with the current
scheduler. The main thing is to do the rebalancing periodically and to
have a reliable way of estimating the loading (not utilization) of each
CPU.

> when a cpu finds itself with nothing to do
> (because all its tasks have completed their slices or blocked) and other
> cpus have tasks in their queues it is time to "shop" for a new task to
> run.

This again has the problem that you only look for new tasks if you have
nothing to do. While this would work if you only look at the total
completion time of a set of tasks, it does nothing to ensure fair
scheduling for a particular task.

>  This would then do load balancing just before each "recalculate
> tick".
> Of course, the above assumes that each cpu has its own run queue.
> 
> George

Regards,

	MikaL
