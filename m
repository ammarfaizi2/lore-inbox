Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130348AbRBHLhv>; Thu, 8 Feb 2001 06:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbRBHLhl>; Thu, 8 Feb 2001 06:37:41 -0500
Received: from [194.213.32.137] ([194.213.32.137]:9476 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130348AbRBHLha>;
	Thu, 8 Feb 2001 06:37:30 -0500
Message-ID: <20010208001513.B189@bug.ucw.cz>
Date: Thu, 8 Feb 2001 00:15:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010206230929.K2975@suse.de> <Pine.LNX.4.10.10102061421490.1825-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.10.10102061421490.1825-100000@penguin.transmeta.com>; from Linus Torvalds on Tue, Feb 06, 2001 at 02:26:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Reading write(2): 
> > > 
> > >        EAGAIN Non-blocking  I/O has been selected using O_NONBLOCK and there was
> > >               no room in the pipe or socket connected to fd to  write  the data
> > >               immediately.
> > > 
> > > I see no reason why "aio function have to block waiting for requests". 
> > 
> > That was my reasoning too with READA etc, but Linus seems to want that we
> > can block while submitting the I/O (as throttling, Linus?) just not
> > until completion.
> 
> Note the "in the pipe or socket" part.
>                  ^^^^    ^^^^^^
> 
> EAGAIN is _not_ a valid return value for block devices or for regular
> files. And in fact it _cannot_ be, because select() is defined to always
> return 1 on them - so if a write() were to return EAGAIN, user space would
> have nothing to wait on. Busy waiting is evil.

So you consider inability to select() on regular files _feature_?

It can be a pretty serious problem with slow block devices
(floppy). It also hurts when you are trying to do high-performance
reads/writes. [I know it hurt in userspace sherlock search engine --
kind of small altavista.]

How do you write high-performance ftp server without threads if select
on regular file always returns "ready"?
 

> Remember: in the end you HAVE to wait somewhere. You're always going to be
> able to generate data faster than the disk can take it. SOMETHING

Userspace wants to _know_ when to stop. It asks politely using
"select()".
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
