Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTALR2U>; Sun, 12 Jan 2003 12:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbTALR2U>; Sun, 12 Jan 2003 12:28:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31754 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267329AbTALR2T>; Sun, 12 Jan 2003 12:28:19 -0500
Date: Sun, 12 Jan 2003 17:37:01 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112173701.A7506@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030112092706.GN30025@kroah.com> <Pine.LNX.4.44.0301120856020.12667-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301120856020.12667-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 12, 2003 at 09:05:16AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 09:05:16AM -0800, Linus Torvalds wrote:
> The only place that looked like it _really_ didn't get the kernel lock was
> apparently tty_open(), which is admittedly a fairly important part of it ;)

chrdev_open() kindly takes the BKL for tty_open() so there isn't an issue
here.

There were, however, parts of the code which were using the global-cli(),
and these merely got converted to local_irq_save() without (iirc) too much
auditing.  They're all marked with FIXME in my current sources.

One thing that regularly bugs me about our current tty implementation,
however, is the handling of SIGWINCH.  This is sent to the process group
rather than the session.  Take the following example:

- you're running an xterm, with a shell inside.
- you're running 3 ssh connections, 2 suspended, one running.
- you resize the xterm

The WINCH signal will be sent to just the one foreground ssh connection.

- you suspend the current ssh.

The shell believes that the terminal is the _old_ size.

- you resume one of the old ssh sessions.

Likewise, ssh doesn't believe the terminal has changed size.

My current "workaround" is to re-tweak the xterm size each time I resume
or suspend an old process.

POSIX (at least signal and general terminal interface sections) seems to
be rather quiet on the behaviour of WINCH.

Are there any reasons why we shouldn't send WINCH to the whole session
rather than just the pgrp associated with the tty?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

