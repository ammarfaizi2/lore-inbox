Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBHOy3>; Thu, 8 Feb 2001 09:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbRBHOyK>; Thu, 8 Feb 2001 09:54:10 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:19473 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129098AbRBHOx7>; Thu, 8 Feb 2001 09:53:59 -0500
Date: Thu, 8 Feb 2001 15:52:35 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010208001513.B189@bug.ucw.cz>
Message-ID: <Pine.LNX.3.96.1010208145857.24587C-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So you consider inability to select() on regular files _feature_?

select on files is unimplementable. You can't do background file IO the
same way you do background receiving of packets on socket. Filesystem is
synchronous. It can block. 

> It can be a pretty serious problem with slow block devices
> (floppy). It also hurts when you are trying to do high-performance
> reads/writes. [I know it hurt in userspace sherlock search engine --
> kind of small altavista.]
> 
> How do you write high-performance ftp server without threads if select
> on regular file always returns "ready"?

No, it's not really possible on Linux. Use SYS$QIO call on VMS :-)

You can emulate asynchronous IO with kernel threads like FreeBSD and some
commercial Unices do, but you still need as many (possibly kernel) threads
as many requests you are servicing. 

> > Remember: in the end you HAVE to wait somewhere. You're always going to be
> > able to generate data faster than the disk can take it. SOMETHING
> 
> Userspace wants to _know_ when to stop. It asks politely using
> "select()".

And how do you want to wait for other select()ed events if you are blocked
in wait_for_buffer in get_block (former bmap)?

Making real async IO would require to rewrite all filesystems and whole
VFS _from_scratch_. It won't happen.

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
