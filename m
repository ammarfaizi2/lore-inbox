Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276364AbRJGNtD>; Sun, 7 Oct 2001 09:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJGNsx>; Sun, 7 Oct 2001 09:48:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:29850 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S276364AbRJGNsr>;
	Sun, 7 Oct 2001 09:48:47 -0400
Message-ID: <3BC05D2E.94F05935@welho.com>
Date: Sun, 07 Oct 2001 16:48:30 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com> <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Sun, Oct 07, 2001 at 12:57:29PM +0300, Mika Liljeberg wrote:
> > For problems 1 and 2 I propose the following solution: Insert the the
> > load balancing routine itself as a (fake) task on each CPU and run it
> > when the CPU gets around to it. The load balancer should behave almost
> > like a CPU-bound task, scheduled on the lowest priority level with other
> > runnable tasks.
> 
> The idle-task might be (ab-)used for this, because it has perfect
> data for this.
> 
> T_SystemElapsed - T_IdleTaskRun = T_CPULoaded

The problem here is that the idle task doesn't get run at all if there
are runnable tasks. With a little bit of tweaking, the idle task context
could probably be used for this, I guess. However, I was thinking more
along the lines that the load balancer would not be a real task but just
a routine that would be executed in schedule() when the fake task comes
up (i.e. when the sceduler has done a "full rotation").

> Balancing could be done in schedule() itself, after checking this
> value for each CPU.

The point about separating the load balancer from the scheduler is that
you don't need to run it at every task switch. You can make the
scheduler very simple if you don't have to scan queues looking for
likely switchover candidates. This saves time in context switches.

One interesting property of the load balancer tasks would be that the
less heavily loaded CPUs would tend to execute the load balancer more
often, actively releaving the more heavily loaded CPUs, while those
would concentrate more on getting the job done. Come to think of it, it
could be coded in such a way that only the least loaded CPU would
execute the load balancing algorithm, while the others would simply
chalk up elapsed times.

> > The last bit is important: the load balancer should not
> > be allowed to starve but should be invoked approximately once every
> > "full rotation" of the scheduler.
> 
> If a artificial CPU-hog is used for this task, the idle task will
> never be run and power savings in the CPU are impossible.

Right. Obviously, if a CPU has no runnable tasks and the load balancer
can't acquire any from other CPUs, it should yield to the idle task
rather than hog the CPU.

	MikaL
