Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSKFPmm>; Wed, 6 Nov 2002 10:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265728AbSKFPmm>; Wed, 6 Nov 2002 10:42:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265727AbSKFPmk>; Wed, 6 Nov 2002 10:42:40 -0500
Date: Wed, 6 Nov 2002 10:49:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christer Weinigel <christer@weinigel.se>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Willy Tarreau <willy@w.ods.org>,
       Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
In-Reply-To: <87d6pienvd.fsf@zoo.weinigel.se>
Message-ID: <Pine.LNX.3.95.1021106102138.202A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2002, Christer Weinigel wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > > On Tue, 2002-11-05 at 20:23, Richard B. Johnson wrote:
> > > > Hey, look. I can only warn. You do what you want. As far as I'm
> > > > concerned support stopped at Linux 2.4.19 when poll got trashed.
> > > > Nobody can use 2.4.19 or probably anything later unless they have
> > > > powerful CPUs that can spin with 1000 SIGPOLL signals per second.
> > 
> > Enable SIGPOLL on STDIN_FILENO and connect from the network as previously
> > shown. You will get 100% CPU time on the task with this enabled.
> 
> Can you please stop harping about this?  You have written essentially
> the same mail over and over again without adding any new information.
> 
> First of all, your problem has nothing to do with networking, the same
> thing will happen if you run your program from within screen, so it
> seems to have more to do with ptys and how both screen and telnetd
> sets them up.  
> 
> Second, it seems that your program does exactly what is expected.  Try
> applying this patch to your example program and see what happens:
> 
> diff -u ./polltest.c.orig ./polltest.c
> --- ./polltest.c.orig	Wed Nov  6 15:36:09 2002
> +++ ./polltest.c	Wed Nov  6 15:35:54 2002
> @@ -47,7 +47,7 @@
>  {
>      struct pollfd pf;
>      pf.fd = STDIN_FILENO;
> -    pf.events = POLLIN;
> +    pf.events = POLLIN | POLLOUT | POLLERR;
>      pf.revents = 0;
>      (void)poll(&pf, 1, 0);
>      if(pf.revents & POLLIN)
> 
> Each time you print the "POLLOUT = 3 POLLERR = 0" message, you fill up
> the write buffer, and each time the write queue empties you will get
> another SIGIO.  Now, this may not be what you want, but it seems to be
> entirely within specs.
> 
> If you remove the fprintf(stderr, "POLLOUT... from your signal handler
> you will not see the same effect as you are complaining about.  Your
> measurements are interfering with what you are trying to measure.
> 

No they are not. You can no longer `strace` because of the error reported.
`strace` will continually write the signal information to the screen
(forever) because every time it writes, another signal is generated.

All you did was get rid of the method used to show the error. User mode
code does not care, and should not care about kernel internals. Whether
or not some "write buffer" emptied is (and must not be) any concern to
the user. The user needs to know if a read or write to or from a device
will block. There are some other things a user might want to know such
as "out-of-band data", "hangups", and other protocol-specific things that
are signaled in the error bit.

A signal must be raised when conditions change.  Currently, a signal
is raised for every byte transmitted. This is a gross error and cannot
be interpreted as "entirely within specs".

If a task has attached the SIGIO signal, but the handler does nothing,
the handler still gets executed. It gets executed on every byte sent.
This makes output "cost" 100 percent of the CPU as seen on `top`. This
is simply wrong. There is no possible explaination that will make it
right.

Everybody, so far, who has answered this thread assumes that I don't
know what I am doing. In avery case, they modify the code to remove
the forcing function that I have used to make it so they can duplicate
the problem on their system. This is not productive and will not
fix the problem. The problem is real and needs to be fixed.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


