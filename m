Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUBITgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 14:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUBITgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 14:36:44 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:57774 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265334AbUBITgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 14:36:42 -0500
Subject: Re: Does anyone still care about BSD ptys?
From: Albert Cahalan <albert@users.sf.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4027BFE7.5040100@zytor.com>
References: <1076334541.27234.140.camel@cube>  <4027BFE7.5040100@zytor.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076347137.27234.166.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Feb 2004 12:18:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-09 at 12:14, H. Peter Anvin wrote:
> Albert Cahalan wrote:
> > 
> > The BSD-style ptys are used all the time for
> > serial port emulation. The SysV-style ones are
> > useless for this, since they don't have a fixed
> > mapping from master to slave. You might make a
> > symlink from /dev/testbox to /dev/ptyp0, then
> > configure gdb to use /dev/testbox for remote
> > debugging. Then you start a remserial process
> > to connect /dev/ttyp0 with port 7455 on some
> > terminal server, and on the terminal server you
> > have remserial connect port 7455 to /dev/C7.
> > Now, whenever you run gdb, you're debugging
> > a test box over a serial line connected to the
> > terminal server. With SysV-style ttys, you
> > can't set up your config as nicely. The above
> > would likely have a few extra symlinks BTW.
> 
> Eh?!  Have your server process create the appropriate symlinks... 
> problem solved.

1. That isn't what existing software does.

2. The symlinks couldn't be in /dev without
running as root. Using /tmp isn't going to
work if you're emulating serial ports for
something that will tack a /dev on the front,
unless users will put up with "../tmp/foo".

I should mention here that the SysV pty stuff
is nearly 100% undocumented in the man pages.
I get nothing for pts, pty, grantpt...

> > In your use of the larger dev_t, please keep
> > the first 2047 or 2048 ptys as they are today.
> > Let the last major use the full 20-bit minor,
> > while restricting the first 7 minors to 8 bits.
> > This avoids breaking userspace software.
> 
> No bloody way in hell.  However, unless I have a strong reason to the 
> contrary I'll keep them on major 136, so your little formula should 
> still woprk.

I'm glad that my formula will work. I doubt I'm
the only one to be mapping from number to name
though. Other software, and older procps releases,
won't handle pty 256 through 2047 after you make
your proposed change.

If you insist though, increase the procps release
requirement to 3.2.0 with your patch please.

> > For example, due to the lack of /proc/*/tty links,
> > procps uses min+(maj-136)*256 to guess the number
> > of a SysV-style pty. A 32-bit dev_t will be handled
> > correctly by procps 3.2 if you extend the pty usage
> > as explained above.
> 
> > Adding /proc/*/tty links solves the problem as
> > well, subject to a linux-2.7.0 version check.
> 
> Presumably it should be: subject to an existence check.

That too of course, since there might not be a
tty at all. Also, depending on implementation,
some processes started in early boot might not
have a tty name in spite of having a tty.

The version check avoids trying a link that is
known to not exist on current kernels. For a long
time now I've been moving the version. :-(


