Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279499AbRJXJwR>; Wed, 24 Oct 2001 05:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279504AbRJXJwI>; Wed, 24 Oct 2001 05:52:08 -0400
Received: from euston.inpharmatica.co.uk ([193.115.214.6]:53495 "EHLO
	sunsvr03.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S279499AbRJXJvt>; Wed, 24 Oct 2001 05:51:49 -0400
Message-ID: <3BD68F56.9090608@purplet.demon.co.uk>
Date: Wed, 24 Oct 2001 10:52:22 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Behavior of poll() within a module
In-Reply-To: <Pine.LNX.3.95.1011023095757.11227A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> ... results in one task getting the correct return value. Other tasks
> get 0 if they are awakened at all. With two tasks sleeping in user mode
> select(), both tasks seem to always be awakened. With three or more
> tasks waiting in select(), only one task gets awakened. I haven't
> been able to figure it out.

Ah, now there's a difference between the process being woken up
and poll/select returning. When an event happens the sleeping
processes all get woken up. One of them gets scheduled - which
means it continues from where it went to sleep in the kernel's
poll code. The first thing that does is scan the descriptors to
see if any events are outstanding. If they are poll() returns.
Otherwise the process goes back to sleep.

If the first process scheduled returns to user space and does a
read/write/whatever it can clear the event condition on the
descriptor. Then when other processes eventually get scheduled
they recheck the descriptor, find no interesting events, and
go back to sleep. Of course, if the first process returns then
has to wait for, say, a page to be faulted in a second process
may get scheduled, see the event, and also return to user space.
So you get one _or more_ processes returning from poll(). This is
why you should always use non-blocking I/O if there are multiple
processes doing poll/select on the same descriptors :-).

> Also, with no tasks sleeping in select(), debugging shows that the
> module poll() routine is entered, based upon some previous history.
> For instance, if a user-mode task never called select, but some
> event that would have awakened the task occurs, another task that
> calls select ends up returning immediately with a stale (weeks old)
> event.
> 
> Maybe there is some way to clear kernel history that could be
> accomplished during close()? 

There is no history. Poll is level based, not edge based. When you
call poll() the descriptor's poll function is polled to find the
current state. If there are no flags of interest set the process
sleeps. A wake up on the descriptor is simply an indication that
something _might_ have changed and sleeping processes should wake
up and invoke the descriptor's poll function to recheck the state.

If I followed what you were trying to do correctly I don't think
poll/select is the way to go. I think what you want is to have
an "event count" associated with the driver, incrementing on
each interrupt (or whatever changes state). Then use an ioctl
to for user space apps to track it. The app passes the last
event number it handled through the ioctl. If the driver event
number is greater it is returned otherwise the process is added
to the descriptor's wait_queue. Oh yeah, the interrupt should
call wake_up on the descriptor as well as increment the event
number :-).

				Mike

