Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTAWNxB>; Thu, 23 Jan 2003 08:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTAWNxB>; Thu, 23 Jan 2003 08:53:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:2689 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265255AbTAWNxA>; Thu, 23 Jan 2003 08:53:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 23 Jan 2003 06:07:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
In-Reply-To: <20030122080322.GB3466@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Jamie Lokier wrote:

> So you would like it to round up the timeout like poll(), select(),
> and io_getevents() do?  Fair enough, for the sake of consistency!
>
> sys_poll() says:
>
> 	if (timeout) {
> 		/* Careful about overflow in the intermediate values */
> 		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
> 			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
> 		else /* Negative or overflow */
> 			timeout = MAX_SCHEDULE_TIMEOUT;
> 	}
>
> sys_io_getevents() does something more complicated in a function
> called set_timeout(), but it essentially comes to the same thing.  It
> takes a value in nanseconds (which I prefer, btw, for future usefulness).

>From a mathematical point of view this is a ceil(v)+1, so this is wrong.
It should be :

t = (t * HZ + 999) / 1000;

The +999 already gives you the round up. Different is if we want to be
sure to sleep at least that amount of jiffies ( the rounded up ), in that
case since the timer tick might arrive immediately after we go to sleep by
making us to lose immediately a jiffie, we need another +1. Anyway I'll do
the round up. Same for the overflow check.


> And that the prototypes for ep_poll() and sys_epoll_wait() be changed
> to take a "long timeout" instead of an "int", just like sys_poll().

I don't see why. The poll(2) timeout is an int.


> ps.  sys_* system-call functions should never return "int".  They
> should always return "long" or a pointer - even if the user-space
> equivalent returns "int".  Take a look at sys_open() for an example.
> Technical requirement of the system call return path on 64-bit targets.

True, I'll change it.



- Davide

