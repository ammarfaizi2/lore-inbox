Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVB1T4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVB1T4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVB1T4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:56:11 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12088
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261672AbVB1Tz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:55:57 -0500
Date: Mon, 28 Feb 2005 20:55:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: two pipe bugfixes
Message-ID: <20050228195556.GL8880@opteron.random>
References: <20050228042544.GA8742@opteron.random> <Pine.LNX.4.58.0502272143500.25732@ppc970.osdl.org> <20050228190437.GI8880@opteron.random> <Pine.LNX.4.58.0502281113380.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502281113380.25732@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 11:22:18AM -0800, Linus Torvalds wrote:
> I wonder. It migth just be a latent bug in python-twisted, rather than any 
> "designed behaviour".

Twisted is doing this for the process writer doRead operation:

    def doRead(self):
        """The only way this pipe can become readable is at EOF, because the
        child has closed it.
        """
        fd = self.fd
        r, w, x = select.select([fd], [fd], [], 0)
        if r and w:
            return CONNECTION_LOST

This apparently means it consider the connection lost when
POLLIN|POLLOUT are set at the same time (which will never happen anymore
with my patch and that was happening all the time with the new
optimizations). It could happen with 2.6.8 too infact, if the write
buffer was empty.

But it should never try to read a writeable fd as you said, so I'm not
so convinced that what broke twisted is really related to the above code
or something else, perhaps the above is an hack for some other OS.

The reactor never listens to writeable fds of course:

        mask = 0
        if reads.has_key(fd): mask = mask | select.POLLIN
        if writes.has_key(fd): mask = mask | select.POLLOUT
        if mask != 0:
            poller.register(fd, mask)
        else:
            if selectables.has_key(fd): del selectables[fd]

So if there's a breakage, that could be just the process protocol, and
not everything else (the process protocol is a protocol implementation
based on popen but it's asynchronous with poll and it works the same as
the networking protocols that uses sockets).

I will ask to the proper lists, this is getting offtopic for l-k.

> Equally arguably, POLLERR should _always_ be set if you select a
> write-only pipe for reading, and guess what? That would cause "select()"
> to return readable. It's true too: select returns whether a read() would
> return immediately, and it _would_ - with an error code.
> 
> The basic fact is that an application that asks whether the pipe that it
> opened for writing is readable is doing something stupid, and the old
> behaviour was at most surprising, but I'd argue it isn't really
> necessarily a _bug_.

My point is that if we're allowed to return "undefined" then we'd better
return -EINVAL instead ;)

> Of course, "surprising" is bad, even if it's not necessarily a bug. So 
> making the return value be "unsurprising" can in any case be considered an 
> improvement.

Agreed.

> I ended up editing it a bit more: the other bits (POLLHUP and POLLERR)  
> also really only make sense for only one side of the reader/writer
> schenario, so logically they should be grouped the same way.
>
> Of course, in those cases, you can't get the "wrong" answer anyway, since
> those only trigger if there are no readers or no writers (and if you're
> open as a reader, that in itself obviously guarantees that there _are_
> readers, and POLLERR cannot happen according to either the old or the new
> rules).
> 
> Anyway, I think I made the code look more logical while there.

Thanks, I'll check it in the next bk snapshot.
