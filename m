Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135429AbRDMGqG>; Fri, 13 Apr 2001 02:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbRDMGpr>; Fri, 13 Apr 2001 02:45:47 -0400
Received: from tantale.fifi.org ([216.15.47.52]:57492 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S135426AbRDMGpj>;
	Fri, 13 Apr 2001 02:45:39 -0400
To: Jason Gunthorpe <jgg@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lost O_NONBLOCK (Bug?)
In-Reply-To: <Pine.LNX.3.96.1010409223803.3856M-100000@wakko.deltatee.com>
From: Philippe Troin <phil@fifi.org>
Date: 12 Apr 2001 23:45:36 -0700
In-Reply-To: <Pine.LNX.3.96.1010409223803.3856M-100000@wakko.deltatee.com>
Message-ID: <87wv8p70xb.fsf@tantale.fifi.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gunthorpe <jgg@debian.org> writes:

> I've run into the following weird behavior on my system with 2.4.0. I have
> the following code:

Apt I guess ? It has a very strange behavior when backgrounded...

> if (fork() == 0)
> {
>     int Flags,dummy;
>     if ((Flags = fcntl(STDIN_FILENO,F_GETFL,dummy)) < 0)
>         _exit(100);
>     if (fcntl(STDIN_FILENO,F_SETFL,Flags | O_NONBLOCK) < 0)
>          _exit(100);
>     while (read(STDIN_FILENO,&dummy,1) == 1);
>     if (fcntl(STDIN_FILENO,F_SETFL,Flags & (~(long)O_NONBLOCK)) < 0)
>          _exit(100);
>  
>     // exec something
> }
> 
> Which works fine, unless the parent process was backgrounded by the shell
> (^Z then bg).  If that is the case then the O_NONBLOCK seems to be lost. I
> straced this: 
> 
> fcntl(0, F_GETFL)                       = 0x2 (flags O_RDWR)
> fcntl(0, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
> read(0, 0xbfffea38, 1)                  = ? ERESTARTSYS (To be restarted)
> --- SIGTTIN (Stopped (tty input)) ---
> --- SIGTTIN (Stopped (tty input)) ---
> read(0, 0xbfffea38, 1)                  = ? ERESTARTSYS (To be restarted)
> --- SIGTTIN (Stopped (tty input)) ---
> --- SIGTTIN (Stopped (tty input)) ---
> [.. etc, again and again in a tight loop ..]
> --- SIGTTIN (Stopped (tty input)) ---
> --- SIGTTIN (Stopped (tty input)) ---
> read(0,
> 
> The last read was after the process was forgrounded. The read waits
> forever, the non-block flag seems to have gone missing. It is also a
> little odd I think that it repeated to get SIGTTIN which was never
> actually delivered to the program.. Shouldn't SIGTTIN suspend the process?

Strace can perturbate signal delivery, especially for terminal-related
signals, I wouldn't trust it...

O_NONBLOCK is not lost... Attempting to read from the controlling tty
even from a O_NONBLOCK descriptor will trigger SIGTTIN.

>From the code, it looks like you're trying to flush stdin before
exec'ing.

Why not use tcflush(STDIN_FILENO, TCIFLUSH) rather than using
O_NONBLOCK ?

This will not prevent SIGGTTIN from getting sent... You could catch it
or just ignore it...

But why would you want to flush stdin if you're in the background ?
Why not using:

  if (fork()==0)
  {
    if (tcgetpgrp(STDIN_FILENO) == getpgrp())
    {
      /* We're the foreground process of the controlling tty */
      tcflush(STDIN_FILENO, TCIFLUSH);
    }

    exec(...);
  }

Here you just don't care flushing stdin if you're not the foreground
process (which is the *right* thing to do).

There's a race condition if the process is backgrounded between the
tcgetgrp() and the tcflush(), but you'll have to leave with it...

Phil.
