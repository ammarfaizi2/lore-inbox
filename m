Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135430AbRARMeg>; Thu, 18 Jan 2001 07:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135429AbRARMeQ>; Thu, 18 Jan 2001 07:34:16 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:35087 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S135307AbRARMeK>; Thu, 18 Jan 2001 07:34:10 -0500
Message-ID: <3A66E4D3.B2BEFCBB@uow.edu.au>
Date: Thu, 18 Jan 2001 23:42:59 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@suse.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: console spin_lock
In-Reply-To: <Pine.LNX.4.21.0101171514050.266-100000@euclid.oak.suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Simmons wrote:
> ...
> By you saying couldn't be acquired from interrupt context do you mean
> from a process context or do you mean it failed to aquire it while in
> the interrupt context?

Actually, printk() must always use __down_trylock().

> > - Get rid of console_tasklet.  Do it in process context callback
> >   or just do it synchronously.
> 
> What about multidesktop systems? I have vgacon and mdacon working fine
> along each other. Each one has their own tasklet to allow them to work
> independent of each other. Meaning no race condition when both VC switch
> at the same time.

Ah.  Thanks. That stuff was actually design-from-memory :)  I'll take
a closer look when I have something other than a clockwork computer.
 
> > Assumption:
> > - Once the system is up and running, it's always safe to
> >   call down() when in_interrupt() returns false - probably
> >   not the case in parts of the exit path - tough.
> 
> Don't forget the idle_task case as well. exit path?

This statement of mine was grade-A bollocks.  printk cannot of
course call down().  It needs to use __down_trylock and buffer
it up if it fails. (faster, too!)

The subtler problem will be interrupt-capable drivers which
do a bare spin_lock() to serialise wrt their interrupt routines,
relying upon interrupts being disabled.  They'll be deadlocky
and will need changing.  That's trivial to find and fix though.

Anyway, this was just a heads-up that I'll be looking at
this stuff.  Please allow me a week or so to provide
some substance.  I read that the fbdev developers have
been seeking a fix for this for some time, so it seems
worth some effort.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
