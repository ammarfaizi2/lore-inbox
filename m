Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSICPzS>; Tue, 3 Sep 2002 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSICPzS>; Tue, 3 Sep 2002 11:55:18 -0400
Received: from netrealtor.ca ([216.209.85.42]:3596 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316971AbSICPzM>;
	Tue, 3 Sep 2002 11:55:12 -0400
Date: Tue, 3 Sep 2002 11:58:37 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
Message-ID: <20020903115837.A10750@mark.mielke.cc>
References: <Pine.LNX.4.44.0209031220230.25506-100000@localhost.localdomain> <Pine.LNX.4.44.0209031322210.7658-100000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209031322210.7658-100000@boris.prodako.se>; from tori@ringstrom.mine.nu on Tue, Sep 03, 2002 at 02:23:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if it does not make sense to just give the process real time
priority? No scheduler will be excellent in all situations. I would not
consider a game, or game server, to be a standard application.

mark


On Tue, Sep 03, 2002 at 02:23:49PM +0200, Tobias Ringstrom wrote:
> On Tue, 3 Sep 2002, Ingo Molnar wrote:
> 
> > do you expect a task that uses up 50% CPU time over an extended period of
> > time to be rated 'interactive'?
> 
> Interactive is not the best word, but I would not expect a process like
> the one I described to be considedred a CPU hog.  It's a deadline driven
> semi realtime process.
> 
> > we might make the '50%' rule to be '100% / nr_running_avg', so that if
> > your task is the only one in the system then it gets rated interactive -
> > but i suspect it will still be rated a CPU hog if it keeps trying to use
> > up 50% of CPU time even during busier periods. I have tried the
> > (1/nr_running) rule in earlier incarnations of the scheduler, and it didnt
> > make much difference, but we obviously need a boundary case like yours to
> > see the differences.
> 
> I think the problem I have (that I loose a lot of performance to processes
> such as crond, httpd, etc.) is common to the whole class of semi-realtime
> processes, at least if they use >50% CPU.  This means that CPU intensive
> audio and video (e.g. DVD) playback programs might have the same problem.
> 
> I see three simple ways to solve the problem without changing the
> scheduler.  Either run the process with nice -20, use SCHED_RR, or use a
> dedicated server with no other processes (such as crond, httpd, etc).  
> The first two might be OK, but you need root privilegies to run renice and
> to change the scheduler policy.  The third one is not an option for all
> users, and definately not for the video playback case.
> 
> A problem is that this new scheduler behaviour will hit people running
> semi realtime processes as a regression when they switch to 2.6.  It would
> be nice to avoid that.
> 
> One solution might be to teach the scheduler how to detect these deadline
> driven semi-realtime processes, and not punish them.  It is not obvious to
> me how to do that.
> 
> Another much simpler solution that might work just as well is be to change
> the CPU utilization threshold from 50% to 90%.
> 
> You're the expert of course.  I'm only fumbling in the dark...  :-)
> 
> > (it could in theory make a difference in some rare cases, in which the
> > frequency of sampling resonates with internal timings of the application -
> > i asked for this only to make sure there are no interactions.)
> 
> I'll try it out and let you know if it does make a difference.
> 
> /Tobias
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

