Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263183AbTCTBD0>; Wed, 19 Mar 2003 20:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbTCTBD0>; Wed, 19 Mar 2003 20:03:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59783 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263183AbTCTBDY>; Wed, 19 Mar 2003 20:03:24 -0500
Date: Wed, 19 Mar 2003 20:18:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ed Vance <EdV@macrolink.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DEF@EXCHANGE>
Message-ID: <Pine.LNX.4.53.0303191959110.1386@chaos>
References: <11E89240C407D311958800A0C9ACF7D1A33DEF@EXCHANGE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Ed Vance wrote:

> On Wed, Mar 19, 2003 2:32 PM, Richard B. Johnson wrote:
> > On Wed, 19 Mar 2003, Ed Vance wrote:
> > [SNIPPED...]
> >
> > > Hi Richard,
> > >
> > > The following patch to serial.c in 2.4.20 is a brute-force addition
> > > of a hang-up delay of 0.5 sec just before close returns to the user,
> > > if the hupcl flag is set. Please try this to determine if there are
> > > any other issues with the remote login. If it works, I'll write a
> > > better patch that does not duplicate other delays, etc.
> > >
> > > Cheers,
> > > Ed
> > >
> >
> > Well, it's the "right church, but wrong pew". As soon as anything
> > closes STDIO_FILENO, **bang** the modem hangs up. NotGood(tm)!
> > So as long as I just execute the shell which was exec'ed ...
> > getty...rlogin...bash never called close. However, `ls` on my
> > machine is `color-ls` when it calls exit(0)... well you get
> > the idea! I can log in, but can't actually execute anything that
> > terminates, closing STDIO_FILENO...
> >
> >
> Hi Richard,
>
> Bummer! Do you think that each of those events was a "last close"
> of the port? Doesn't bash hold the port open while the `color-ls`
> runs?
>
> Since the path only delays (doesn't change modem control), these
> closes must have been hidden by quick reopens. Does the unmodified
> agetty set the baud rate to zero to hangup, or was that your change?
> I was thinking that I could move the delay to the code that
> disconnects when baud rate zero is set.
>
> your thoughts?
>
> Cheers,
> Ed

I'm pretty sure somebody had that port open all the while.
If you are looking for the 'last close' they may be a problem
with when it happens, i.e., the driver may not get closes in
"order".

I think the only "safe" thing is to delay returning from
the hangup caused by any reason (including baud-rate of zero).
Otherwise, some non-delayed path may do another open()
followed by a close() while you are sleeping in close().

That way, all previous logic that was destroyed by faster
CPUs, gets restored by simply slowing the rate at which
the DTR line can toggle.

As I have shown, I can "fix" the problem external to the
kernel, but it's "unclean". Any program should be be able
to, using tcsetattr() or its underlying ioctl(), be able
to set baud-rate to B0, then immediately to some rate and have
the modem-control lead (DTR) actually toggle. It doesn't
happen right now. Programs that I (we) write in the future
could of course usleep() between subsequent calls, but with
the fast fork() that we have now, one task hanging up
closing the terminal, followed by init starting another,
isn't slow enough to hang up the modem either.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

