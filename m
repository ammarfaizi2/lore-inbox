Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTALRB2>; Sun, 12 Jan 2003 12:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTALRB2>; Sun, 12 Jan 2003 12:01:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63244 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267254AbTALRB0>; Sun, 12 Jan 2003 12:01:26 -0500
Date: Sun, 12 Jan 2003 09:05:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <20030112092706.GN30025@kroah.com>
Message-ID: <Pine.LNX.4.44.0301120856020.12667-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Jan 2003, Greg KH wrote:
> 
> But this is really the first it's been mentioned, I can't see holding up
> 2.6 for this.  It's a 2.7 job at the earliest, unless someone wants to
> step up and do it right now...

Hmm.. The tty layer still depends on the kernel lock, and we're clearly 
not changing that at this point any more.

I don't see what the fundamental problem is, it sounds like there's just
some part that got the lock yanked, probably as part of the normal VFS
kernel-lock-avoidance patches. Looking at tty_io.c (which pretty much
drives everything else), it does seem to take the lock _most_ of the time,
including read and write time.

The only place that looked like it _really_ didn't get the kernel lock was
apparently tty_open(), which is admittedly a fairly important part of it ;)

Alan, do you have a test-load? Might be worth just renaming "tty_open()" 
to "do_tty_open()", and then do a

	tty_open(..)
	{
		lock_kernel();
		retval = do_tty_open(..);
		unlock_kernel();
		return retval;
	}

thing.

Quite frankly, very little has changed in the 2.5.x tty layer (serial
stuff, yes, tty no), so its locking should work basically as well as 2.4.x
does. Except for infrastructure changes like the VFS lock removal (where
2.4.x will hold the kernel lock itself over open, 2.5.x won't).

Yeah, preemption has this tendency to show locking problems more easily,
and it could clearly be the case that it's broken in 2.4.x too but
basically impossible to trigger. But the _simple_ explanation is that
tty_open() (and perhaps some other cases like ioctl) just missed the
kernel lock.

		Linus

