Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbTBQPQ5>; Mon, 17 Feb 2003 10:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267163AbTBQPQ4>; Mon, 17 Feb 2003 10:16:56 -0500
Received: from ext-nj2gw-2.online-age.net ([216.35.73.164]:8606 "EHLO
	ext-nj2gw-2.online-age.net") by vger.kernel.org with ESMTP
	id <S267132AbTBQPQz>; Mon, 17 Feb 2003 10:16:55 -0500
From: "Daniel Heater" <daniel.heater@gefanuc.com>
Date: Mon, 17 Feb 2003 09:26:27 -0600
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030217152626.GA275@gefhsvrootwitch>
Mail-Followup-To: heaterd1, Davide Libenzi <davidel@xmailserver.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com> <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Davide Libenzi (davidel@xmailserver.org) wrote:
> On Thu, 13 Feb 2003, Linus Torvalds wrote:
> 
> > > > One of the reasons for the "flags" field (which is not unused) was because
> > > > I thought it might have extensions for things like alarms etc.
> > >
> > > I was thinking more like :
> > >
> > > int timerfd(int timeout, int oneshot);
> >
> > It could be a separate system call, ...
> 
> I would personally like it a lot to have timer events available on
> pollable fds. Am I alone in this ?

I currently do something similar to this with a driver for an 82c54 timer,
and for a couple of of hardware timer implementations.

I create a fd for each timer in the device. write() sets the timer count.
read() reads back the current timer count. select() with the timer's fd
as the exceptionfd argument is used to poll for a timer expiration. With
this hardware, the count is automatically reloaded and continues counting.

With this interface, I can write a simple app that waits for any number of
events on file descriptors using select, but will also timeout periodically
to do some housekeeping data. I just switch on the file descriptor when I
come out of the select to decide what needs to be done.

This seems simpler to me in many cases where I can allow some drift in doing
the timeout housekeeping because the rest of the code need not be concerned
with getting preempted by a signal. ie. No need to lock data structures
because there is always only one thread of control.

daniel.
