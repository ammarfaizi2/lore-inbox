Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286427AbRLTW0J>; Thu, 20 Dec 2001 17:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286424AbRLTWZ7>; Thu, 20 Dec 2001 17:25:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34807 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S286421AbRLTWZs>; Thu, 20 Dec 2001 17:25:48 -0500
Message-ID: <3C22654D.7FC80713@mvista.com>
Date: Thu, 20 Dec 2001 14:25:17 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <Pine.LNX.4.40.0112201252450.1622-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> I'd like to have some comments about RT tasks implementation in a SMP
> system because POSIX it's not clear about how the priority rules apply to
> multiprocessor systems.
> The Balanced Multi Queue Scheduler ( BMQS, http://www.xmailserver.org/linux-patches/mss-2.html )
> i'm working on tries to keep CPU schedulers the more independent as
> possible and currently implements two kind of RT tasks, local one and
> global ones.
> Local RT tasks apply POSIX priority rules inside the local CPU, that means
> that an RT task running on CPU0 cannot preempt another task ( being it
> normal or RT ) on CPU1. This keeps schedulers interlocking very low
> because of the very fast path in reschedule_idle() ( no multi lock
> acquisition, CPU queue loops, etc...).
> Global RT tasks, that live in a separate run queue, have the ability to
> preempt remote CPU and this can lead ( in the unfortunate case that the
> last CPU running the RT task is running another RT task ) to an higher
> cost in reschedule_idle().
> The check for a global RT task selection is done in a very fast way before
> checking the local queue :
> 
>     if (!list_empty(&runqueue_head(RT_QID)))
>         goto rt_queue_select;
> rt_queue_select_back:
> 
> and this does not affect the scheduler latency at all.
> On the contrary, by having a separate queue for global RT tasks, can
> improve it in high run queue load cases.
> The local/global RT task selection is done with setscheduler() with a new
> ( or'ed ) flag SCHED_RTGLOBAL, and this means that the default is RT task
> local.
> I'd like to have comments on this before jumping to the next Scheduler
> issue ( balancing mode ).
> 
My understanding of the POSIX standard is the the highest priority
task(s) are to get the cpu(s) using the standard calls.  If you want to
deviate from this I think the standard allows extensions, but they IMHO
should be requested, not the default, so I would turn your flag around
to force LOCAL, not GLOBAL.

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
