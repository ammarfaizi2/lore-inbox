Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130484AbRCDLT4>; Sun, 4 Mar 2001 06:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRCDLTq>; Sun, 4 Mar 2001 06:19:46 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:30453 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130484AbRCDLT0>; Sun, 4 Mar 2001 06:19:26 -0500
Message-ID: <3AA224D2.17CC8905@uow.edu.au>
Date: Sun, 04 Mar 2001 22:19:46 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [prepatches] removal of console_lock
In-Reply-To: <3AA21FA5.BA370402@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> > - Major revamp of printk(). The approach taken in printk() is to try
> >   to acquire the (new) console_sem. If we succeed, the output is
> >   placed into the log buffer and is printed to the consoles. If we fail
> >   to acquire the semaphore we just buffer the output in the log buffer
> >   and the current holder of the console_sem will do the printing for us
> >   prior to releasing console_sem.
> 
> Is down_trylock reliable under load?

I'm not aware of any problems.  It's only really used in one
place at present - when networking interrupt context wants to
acquire a socket's semaphore.  Oh.  That seems to have disappeared.

I've tested it pretty hard on SMP with zillions of printk()s from
interrupt context in parallel with `cat lots_of_stuff'.

> I remember 2 or 3 bug reports than disappeared after down_trylock was
> removed.
> The last one was this week.
> 
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg31919.html

That was different.  The parport code was leaving the semaphore in
a downed state when it shouldn't have.

But you're right - it's not well-proven code.  I'll go stare
angrily at it for a while.  Of course, there are about ten
different implementations...

-
