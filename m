Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRCWCOO>; Thu, 22 Mar 2001 21:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRCWCOF>; Thu, 22 Mar 2001 21:14:05 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:4848 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129436AbRCWCN4>; Thu, 22 Mar 2001 21:13:56 -0500
Message-ID: <3ABAB12D.CE7FA890@uow.edu.au>
Date: Fri, 23 Mar 2001 02:13:01 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: frey@cxau.zko.dec.com
CC: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel_thread vs. zombie
In-Reply-To: <008901c0b33c$ab1f51a0$90600410@SCHLEPPDOWN>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Frey wrote:
> 
> >>  - When started during boot (low PID (9)) It becomes a zombie
> >>  - When started from a process that quits after sending the ioctl,
> >>    it is correctly "garbage collected".
> >>  - When started from a process that stays around, it becomes
> >>    a zombie too
> 
> >Take a look at kernel/kmod.c:call_usermodehelper().  Copy it.
> >
> >This will make your thread a child of keventd.  This takes
> >care of things like chrootedness, uids, cwds, signal masks,
> >reaping children, open files, and all the other crud which
> >you can accidentally inherit from your caller.
> >
> So depending on the state of the caller daemonize() will not really
> put us into the background as we want.

Well, kernel_thread() will put you in the background, in the
sense that it creates an async thread.  But you inherit
heaps of stuff from the parent.  daemonize() cleans up
some of those things, but it can't clean up everything.

Kernel threads *need* to run in a well-understood and
sensible environment.  We went through a lot of fun late
last year when there was a sudden proliferation of kernel
threads and quite a few things were subtly broken.

Things like kernel threads blocking signals because that's
what their user-space parent happened to do.  Things like
user-space applications receiving a surprise SIGCHLD from
the kernel as a consequence of some system call which they
happened to have executed some while beforehand.

One approach would be to tromp through your task state setting
everything back where you want it.  That's quite complex.  Plus
there's the issue of who reaps the thread when it exits.

So I think it's reasonable to use keventd as `kinit', if you like.
Something which knows how to launch and reap kernel daemons, and
which provides a known environment to them.

A kernel API function (`kernel_daemon'?) which does all this
boilerplate is needed, I think.

-
