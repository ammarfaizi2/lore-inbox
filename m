Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264691AbSJUCDo>; Sun, 20 Oct 2002 22:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264692AbSJUCDo>; Sun, 20 Oct 2002 22:03:44 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:7559 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264691AbSJUCDn>; Sun, 20 Oct 2002 22:03:43 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 20 Oct 2002 19:18:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll ...
In-Reply-To: <3DB35FF0.1E967894@digeo.com>
Message-ID: <Pine.LNX.4.44.0210201915490.959-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Andrew Morton wrote:

> Well I'm assuming that you don't want to sleep if, say,
> ep->eventcnt is non-zero.  The code is currently (simplified):
>
> 	add_wait_queue(...);
> 	if (ep->eventcnt)
> 		break;
> 	/* window here */
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	schedule();
>
> If another CPU increments eventcnt and sends this task a wakeup in that
> window, it is missed and we still sleep.  The conventional fix for that
> is:
>
> 	add_wait_queue(...);
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	if (ep->eventcnt)
> 		break;
> 	/* harmless window here */
> 	schedule();
>
> So if someone delivers a wakeup in the "harmless window" then this task
> still calls schedule(), but the wakeup has turned the state from
> TASK_INTERRUPTIBLE into TASK_RUNNING, so the schedule() doesn't actually
> take this task off the runqueue.  This task will zoom straight through the
> schedule() and will then loop back and notice the incremented ep->eventcnt.
>
> So it is important that the waker increment eventcnt _before_ delivering
> the wake_up, too.

It's true ... but the window is pretty small there :) Anyway it makes the
code more correct and I changed it. I have the new patch with your
suggestions ready and I will post as sonn as it'll pass a few tests.



- Davide


