Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264734AbSKDOxi>; Mon, 4 Nov 2002 09:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264736AbSKDOxh>; Mon, 4 Nov 2002 09:53:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264734AbSKDOxS>; Mon, 4 Nov 2002 09:53:18 -0500
Date: Mon, 4 Nov 2002 06:59:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: benh@kernel.crashing.org
cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
In-Reply-To: <20021104080838.19142@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0211040638000.771-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Nov 2002 benh@kernel.crashing.org wrote:
>
> >Note that "should work" does not necessarily mean "does work". For
> >example, in the IDE world, some of the generic packet command stuff is
> >only understood by ide-cd.c, and the generic IDE layer doesn't necessarily
> >understand it even if you have a disk that speaks ATAPI. I think Jens will 
> >fix that wart.
> 
> Which is why, IMHO (am I repeating myself ? :) that command has to
> be sent down the queue by the _lowest_ level device driver, that
> is ide-cd, ide-disk, etc...

I would agree with you, but for the fact that:

 - I really think we want to have the drivers try to translate SCSI
   commands _anyway_.

 - that request queue is _damn_important_ in also acting as a 
   synchronization barrier.

The thing is, many of these commands might well be things user space wants 
to do as well, and you have two choices:

 - add an ioctl for each kind of command you want to do, and let the 
   low-level driver do it.

   Oh, and btw, we've largely done it this way in the past, and they have 
   pretty much _all_ gotten the synchronization wrong.

 - add one generic ioctl (already done), which pushes a SCSI command down 
   the pipe, and let the pipe be the synchronization, and cause the switch
   to be at run-time.

The thing is, you need to have a case statement for the ioctl, and you 
need to have a case statement for the command byte to parse it. And the 
SCSI command vs ioctl has a number of advantages:

 - you can think of the SCSI command as an ioctl with a standard 
   numbering and automatic synchronization with the queue.

 - a lot of devices can use the raw command as-is, with no case statements 
   or translation what-so-ever.

Anyway, this is why I'd much rather have higher layers use a standardized
queue packet (a SCSI command) to inform lower-level drivers about special
events, rather than have the lower levels decide on their own command set
and have specialized ways to try to tell them to use that specialized
command some other way (a bdev "ops" structure would probably be the way
we'd go).

So assuming that drivers will accepts commands down the request queue 
anyway (because it's the only sane way to push them down and get any kind 
of reasonable ordering), then that would make it a waste of time and extra 
complexity to _also_ have another interface to push special commands. 
Especially as that other interface would end up being almost certainly 
broken wrt synchronization (proof: look at the current mess).

		Linus

