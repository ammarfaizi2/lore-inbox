Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVBOU76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVBOU76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVBOU5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:57:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:41630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261892AbVBOU45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:56:57 -0500
Date: Tue, 15 Feb 2005 12:56:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
In-Reply-To: <je1xbhy3ap.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
 <je1xbhy3ap.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Feb 2005, Andreas Schwab wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > I think it may be a n_tty line discipline bug, brought on by the fact that
> > the PTY buffering is now 4kB rather than 2kB. 4kB is also the
> > N_TTY_BUF_SIZE, and if n_tty has some off-by-one error, that would explain 
> > it.
> 
> I've also seen more than one byte missing.  For example when sending a big
> chunk of bytes down the pty via an Emacs *shell* buffer up to 16 bytes are
> missing somewhere in the middle.

If it's NTTY (and I'm pretty certain it is - the generic tty code looks 
fine, the pty code itself is too simple for words), then I'd actually have 
expected more variability than a simple off-by-one. 

I'd have expected the problems to be due to character expansion, ie the
CR->LF thing etc, and that would have resulted in off-by-N, where N is the
number of expanded characters in a 4096 byte block. With XTAB, you could
even have each \t be expanded to 8 space characters on ECHO, and you could
lose a whole lot more than just one byte at the end.

That's clearly not the case, and I haven't looked into exactly what
termios settings "forkpty()" uses, so I suspect that it's something else
than pure expansion on write. There's a lot of things going on in a tty
driver: the character flow itself, the "backflow" in the form of ECHO, etc
etc.

Also, there's the interaction with "flushing" the buffer: we do a 
"flush_chars()" at regular intervals, and that will flush it to the next 
buffer, which may actually cause things to fit a lot better than they
would otherwise have fit. In fact, I'd not be at all surprised if this
thing was timing-dependent too, ie depended on how quickly the reader 
emptied the other side buffer.

The tty layer is pretty ugly, but in its defense, it has to be said that
tty handling _is_ one of the more complex parts of traditional UNIX, so 
the ugliness is at least partly due to the problem space, not just the 
fact that the code is old.

		Linus
