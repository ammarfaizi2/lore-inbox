Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbSJ2EuP>; Mon, 28 Oct 2002 23:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSJ2EuP>; Mon, 28 Oct 2002 23:50:15 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:49310 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261578AbSJ2EuO>; Mon, 28 Oct 2002 23:50:14 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 21:06:00 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029015139.GB18727@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210282042170.1002-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Jamie Lokier wrote:

> Davide Libenzi wrote:
> Oh I agree this is an acceptable limitation.  Just wondering whether I
> can safely depend on an fd being a socket/pipe being sufficient?
> I.e. does it work on a non-IP socket, a packet socket, an IPX socket
> etc?

Yes, by plugging the sk_wake_async() that is called from std ->data_ready
and ->write_space of generic socket support, all sockets types are
supported. Well, I should say "should" instead of "are" because I never
tested it with sockets different from TCP/IP :)


> It would be good if epoll would at least refuse to register fds that
> it can't handle, returning EINVAL for them.  If it's as simple as
> socket+pipe, that's a trivial test in ep_insert.

This can be certainly implemented if many of you feel that it could be
usefull. The clean way to understand if a file* is of a given type would
be to make the "struct file_operations" of the compatible files ( sockets
and pipes ) to be non-static and to use something like :

if (f->f_op == ...)

to test the target file type. I'm already doing this to verify the epoll
file descriptor coherence.



> I've just read the /dev/epoll patch.  I think it makes sense, in the
> long run, to share infrastructure with that other event notification
> subsystem - sigio.  The two should really be interchangable interfaces
> to the same underlying event notification system - not one interface
> handling some fds and the other handling different fds.

IMHO sys_epoll is going to be a replacement for rt-signals, because it
scales better, it collapses events and does not have the overflowing queue
problem.



> (Ideally, though, with the new waitqueue wakeup callback functions
> that were needed for aio the old fd poll mechanism can be made to
> generate events - which epoll and sigio and aio and poll() could all
> use - full circle back to a beautiful and harmonious unix world once
> more.)

The sys_epoll interface was coded to use the existing infrastructure w/out
adding any legacy code added to suite the implementation. Basically,
besides the few lines added to fs/pipe.c to support pipes ( rt-signal did
not support them ), the hook lays inside sk_wake_async().



- Davide




