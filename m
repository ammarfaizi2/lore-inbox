Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVBOTuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVBOTuE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVBOTtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:49:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:11905 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261844AbVBOToY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:44:24 -0500
Date: Tue, 15 Feb 2005 11:44:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pty is losing bytes
In-Reply-To: <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0502151129210.5570@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Feb 2005, Linus Torvalds wrote:
> 
> On Tue, 15 Feb 2005, Andreas Schwab wrote:
> >
> > Recent kernel are losing bytes on a pty. 
> 
> Great catch.
> 
> I think it may be a n_tty line discipline bug, brought on by the fact that
> the PTY buffering is now 4kB rather than 2kB. 4kB is also the
> N_TTY_BUF_SIZE, and if n_tty has some off-by-one error, that would explain 
> it.
> 
> Does the problem go away if you change the default value of "chunk" (in 
> drivers/char/tty_io.c:do_tty_write) from 4096 to 2048? If so, that means 
> that the pty code has _claimed_ to have written 4kB, and only ever wrote 
> 4kB-1 bytes. That in turn implies that "ldisc.receive_room()" disagrees 
> with "ldisc.receive_buf()".

Ok, I just tried this myself, and yes, the change from 4kB chunks to 2kB 
chunks seems to fix your PTY test code.

However, then when I start looking at n_tty_receive_room() and 
n_tty_receive_buf(), my stomach gets a bit queasy. I have this horrid 
feeling that I had something to do with the mess, but I'm going to lash 
out and blame somebody else, like tytso, for most of it. That's some _old_ 
code, regardless (gone through a lot of "let's fix up that detail", but 
not a lot of "boy, I bet we could fix it entirely").

We should get rid of the separate "how much room do you have to write" and 
"do the write" stuff, and just make "receive_buf()" able to write partial 
results. As it is, if (as it seems to be the case) n_tty_receive_room() 
claims to have more room than "n_tty_receive_buf()" can actually fill, 
then the tty layer will never know that somebody lied, and that characters
got dropped on the floor.

This bug was apparently hidden just because the PTY layer used the flip 
buffers as it's staging area, and that happens to be 2kB in size. That, 
in turn, is only half of what the actual N_TTY_BUF_SIZE is, so a single
call could never fill up N_TTY_BUF_SIZE, even if characters were expanded 
(ie LF -> CRLF translation etc).

I'd love for somebody to try to take a look at where n_tty goes wrong, but 
I think that for now I'll just make the fix be the cheezy "limit tty 
chunks to 2kB". It's worked for a decade, it can work for a bit longer ;)

Who here feels they know n_tty and have a strong stomach?  Raise your 
hands now. Don't be shy.

		Linus
