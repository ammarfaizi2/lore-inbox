Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277472AbRJERtu>; Fri, 5 Oct 2001 13:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277527AbRJERtl>; Fri, 5 Oct 2001 13:49:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15855 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S277472AbRJERtX>; Fri, 5 Oct 2001 13:49:23 -0400
Message-ID: <3BBDF290.E3988F49@mvista.com>
Date: Fri, 05 Oct 2001 10:49:04 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I don't quite agree with you that it doesn't matter.  A lot of tests
> > (volanomark, other silly things) show that the current scheduler jumps
> > processes from CPU to CPU on SMP boxes far too easily, in addition to the
> > lengthy duration of run queue processing when loaded down.  Yes, these
> > applications are leaving too many runnable processes around, but that's
> > the way some large app server loads behave.  And right now it makes linux
> > look bad compared to other OSes.
> 
> The current scheduler is completely hopeless by the time you hit 3
> processors and a bit flaky on two. Its partly the algorithm and partly
> implementation
> 
> #1      We schedule tasks based on a priority that has no cache
>         consideration
> 
> #2      We have an O(tasks) loop refreshing priority that isnt needed
>         (Montavista fix covers this)
> 
> #3      We have an O(runnable) loop which isnt ideal
> 
> #4      On x86 we are horribly cache pessimal. All the task structs are
>         on the same cache colour. Multiple tasks waiting for the same event
>         put their variables (like the wait queue) on the same cache line.
> 
> The poor cache performance greatly comes from problem 1. Because we prioritize
> blindly on CPU usage with a tiny magic constant fudge factor we are
> executing totally wrong task orders. Instead we need to schedule for cache
> optimal behaviour, and the moderator is the fairness requirement, not the
> other way around.
> 
> The classic example is two steady cpu loads and an occasionally waking
> client (like an editor)
> 
> We end up scheduling [A, B are the loads,  C is the editor)
> 
> A C B C A C B C A C B C A
> 
> whenever a key is hit we swap CPU hog because the priority balanced shifted.
> Really we should have scheduled something looking more like
> 
> A C A C A C B C B C B C B
> 
> I would argue there are two needed priorities
> 
> 1.      CPU usage based priority - the current one
> 
> 2.      Task priority.
> 
> Task priority being set to maximum when a task sleeps and then bounded by
> a function of max(task_priorty, fn(cpupriority)) so that tasks fall down
> priority levels as their cpu usage in the set of time slices. This causes
> tasks that are CPU hogs to sit at the bottom of the pile with the same low
> task_priority meaning they run for long bursts and don't get pre-empted and
> switched with other hogs through each cycle of the scheduler.

Let me see if I have this right.  Task priority goes to max on any (?)
sleep regardless of how long.  And to min if it doesn't sleep for some
period of time.  Where does the time slice counter come into this, if at
all?  

For what its worth I am currently updating the MontaVista scheduler so,
I am open to ideas.

George
> 
> This isnt idle speculation - I've done some minimal playing with this but
> my initial re-implementation didnt handle SMP at all and I am still not 100%
> sure how to resolve SMP or how SMP will improve out of the current cunning
> plan.
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
