Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278160AbRJWSQZ>; Tue, 23 Oct 2001 14:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278170AbRJWSQP>; Tue, 23 Oct 2001 14:16:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61314 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S278160AbRJWSQB>; Tue, 23 Oct 2001 14:16:01 -0400
Date: Tue, 23 Oct 2001 14:16:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Behavior of poll() within a module
In-Reply-To: <002601c15bec$ea4ed950$010411ac@local>
Message-ID: <Pine.LNX.3.95.1011023140753.16624A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Manfred Spraul wrote:

> From: "Richard B. Johnson" <root@chaos.analogic.com>
> > 
> > In this module, there isn't any read() or write() event that can
> > clear the poll mask. Instead, the sole purpose of poll is to tell
> > the user-mode caller that there is new status available as a result
> > of an interrupt. This is a module that controls a motor. It runs
> > <forever> on its own. It gets new parameters via an ioctl(). It
> > reports exceptions (like overload conditions) using the poll
> > mechanism.
> > 
> > The caller reads the cached status via an ioctl(). Any caller sleeping
> > in poll must be awakened as a result of the interrupt event. Any caller
> > can read the cached status at any time. If this was allowed to
> > clear the poll mask, only one caller would be awakened. 
> >
> Ugh.
> ->poll must never change any state. The kernel is free to call poll
> multiple times (common are once, twice and three times).

That's the problem. It calls poll even when there is not any user-mode
select/poll active.

> 
> Can you use a per-filp pollmask?

Yes. You've got it. Private data is a place to put the per-process
poll mask.

> * remove poll_active
> * remove poll_mask

Yes.

> * add event counters for every possible event.
>     poll_count_POLLIN, poll_count_POLLOUT, etc.
> * interrupt handler increases the counter.
> * ioctl() copies the value of the counters into
>     filp->private_data->event_handled_POLL{IN,OUT}
> * poll sets the pollmask if
>     filp->private_data->event_seen != info->poll_count
> 
Yes. May not actually need counters because each interrupt
will cache a status that can be read by anybody.

The struct file_pointer.private_data is the savior.

> If filps (file descriptors) are shared between apps, then I have no
> idea how to fix your design.
> 



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


