Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276010AbRJGBVT>; Sat, 6 Oct 2001 21:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJGBVA>; Sat, 6 Oct 2001 21:21:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39933 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S275994AbRJGBUu>; Sat, 6 Oct 2001 21:20:50 -0400
Message-ID: <3BBFADDC.3FDE31E7@mvista.com>
Date: Sat, 06 Oct 2001 18:20:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <E15pdSv-0007qX-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Let me see if I have this right.  Task priority goes to max on any (?)
> > sleep regardless of how long.  And to min if it doesn't sleep for some
> > period of time.  Where does the time slice counter come into this, if at
> > all?
> >
> > For what its worth I am currently updating the MontaVista scheduler so,
> > I am open to ideas.
> 
> The time slice counter is the limit on the amount of time you can execute,
> the priority determines who runs first.
> 
> So if you used your cpu quota you will get run reluctantly. If you slept
> you will get run early and as you use time slice count you will drop
> priority bands, but without pre-emption until you cross a band and there
> is another task with higher priority.
> 
> This damps down task thrashing a bit, and for the cpu hogs it gets the
> desired behaviour - which is that the all run their full quantum in the
> background one after another instead of thrashing back and forth

If I understand this, you are decreasing the priority of a task that is
running as it consumes its slice.  In the current way of doing things
this happens and is noticed when the scheduler gets called.  A task can
loose its place by being preempted by some quick I/O bound task.  I.e. A
and B are cpu hogs with A having the cpu, if task Z comes along and runs
for 100 micro seconds, A finds itself replace by B, where as if Z does
not come along, A will complete its slice.  It seems to me that A should
be first in line after Z and not bumped just because it has used some of
its slice.  This would argue for priority being set at slice renewal
time and left alone until the task blocks or completes its slice.

George
