Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAQAEK>; Tue, 16 Jan 2001 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135183AbRAQAEB>; Tue, 16 Jan 2001 19:04:01 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:6411 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129790AbRAQADo>; Tue, 16 Jan 2001 19:03:44 -0500
Date: Tue, 16 Jan 2001 16:03:42 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: [patch] sendpath() support, 2.4.0-test3/-ac9
In-Reply-To: <Pine.LNX.4.30.0101161016250.673-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0101161556480.12389-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Ingo Molnar wrote:

>
> On Mon, 15 Jan 2001, dean gaudet wrote:
>
> > > just for kicks i've implemented sendpath() support.
> > >
> > > _syscall4 (int, sendpath, int, out_fd, char *, path, off_t *, off, size_t, size)
> >
> > hey so how do you implement transmit timeouts with sendpath() ?
> > (i.e. drop the client after 30 seconds of no progress.)
>
> well this problem is not unique to sendpath(), sendfile() has it as well.

hrm?  with sendfile() i just send 32k or 64k at a time and use alarm()
or non-blocking/select() to implement timeouts.

with sendpath() i can do the same thing but i'm gonna pay a path lookup
each time... and there's no guarantee that i'm getting the same file each
time.

> in TUX i've added per-socket connection timers, and i believe something
> like this should be done in Apache as well - timers are IMO not a good
> enough excuse for avoiding event-based IO models and using select() or
> poll().

i wasn't suggesting avoiding sendfile/sendpath -- i just couldn't see how
to use sendpath() effectively.

explain per-socket connection timers.  are they available to the userland?

at least with the apache-2.0 i/o stuff i should be able to support
kernel-based timers.  apache-2.0 uses non-blocking/poll() to implement
timeouts -- does write() or sendfile() until there's an EWOULDBLOCK then
it calls poll()  waiting for write/timeout.  with kernel supported
timeouts i could just block in the write() and that'd be fine by me.

1.2 used alarm() ... 1.3 communicates each child's activity to the parent
through the scoreboard and the parent occasionally wakes up and sends
SIGALRM to children that are past their timeout.  (that let me get rid of
a few syscalls.)

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
