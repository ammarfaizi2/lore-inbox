Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSJUBzW>; Sun, 20 Oct 2002 21:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264691AbSJUBzW>; Sun, 20 Oct 2002 21:55:22 -0400
Received: from packet.digeo.com ([12.110.80.53]:4350 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264690AbSJUBzV>;
	Sun, 20 Oct 2002 21:55:21 -0400
Message-ID: <3DB35FF0.1E967894@digeo.com>
Date: Sun, 20 Oct 2002 19:01:20 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll ...
References: <3DB34F39.C2923F7B@digeo.com> <Pine.LNX.4.44.0210201853460.959-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 02:01:21.0115 (UTC) FILETIME=[C04F3AB0:01C278A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Sun, 20 Oct 2002, Andrew Morton wrote:
> 
> > +                       if (ep->eventcnt || !timeout)
> > +                               break;
> > +                       if (signal_pending(current)) {
> > +                               res = -EINTR;
> > +                               break;
> > +                       }
> > +
> > +                       set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +                       write_unlock_irqrestore(&ep->lock, flags);
> > +                       timeout = schedule_timeout(timeout);
> >
> > You should set current->state before performing the checks.
> 
> Why this Andrew ?
> 

Well I'm assuming that you don't want to sleep if, say,
ep->eventcnt is non-zero.  The code is currently (simplified):

	add_wait_queue(...);
	if (ep->eventcnt)
		break;
	/* window here */
	set_current_state(TASK_INTERRUPTIBLE);
	schedule();

If another CPU increments eventcnt and sends this task a wakeup in that
window, it is missed and we still sleep.  The conventional fix for that
is:

	add_wait_queue(...);
	set_current_state(TASK_INTERRUPTIBLE);
	if (ep->eventcnt)
		break;
	/* harmless window here */
	schedule();

So if someone delivers a wakeup in the "harmless window" then this task
still calls schedule(), but the wakeup has turned the state from
TASK_INTERRUPTIBLE into TASK_RUNNING, so the schedule() doesn't actually
take this task off the runqueue.  This task will zoom straight through the
schedule() and will then loop back and notice the incremented ep->eventcnt.

So it is important that the waker increment eventcnt _before_ delivering
the wake_up, too.
