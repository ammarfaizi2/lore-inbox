Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbTGHBGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 21:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265948AbTGHBGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 21:06:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:11136 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265946AbTGHBGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 21:06:40 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 18:13:33 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
In-Reply-To: <20030708005226.GD12127@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307071802360.3531@bigblue.dev.mcafeelabs.com>
References: <20030707154823.GA8696@srv.foo21.com>
 <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
 <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
 <20030708003247.GB12127@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307071730190.3524@bigblue.dev.mcafeelabs.com>
 <20030708005226.GD12127@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Jamie Lokier wrote:

> The old code didn't need to do it, because the events were registered
> for all the fd values pointing to a single file *.  That's cool -
> that's exactly what anyone would expect.  The point of dup2() is that
> the fds are equivalent, and share state (such as seek pointer).
>
> Now you have two strange (IMHO unclean) behaviours, that an
> application programmer needs to be aware of:
>
>    1. Duplicate fds don't share registered event state.

That's no unclean. It is the purpose of the patch. You can do now :

	/* Remotely */
	dup2(3, 4);
	...
	evt.data.ptr = mydata0;
	evt.event = EPOLLIN | EPOLLET;
	epoll_ctl(epfd, EPOLL_CTL_ADD, 3, &evt);
	evt.data.ptr = mydata1;
	evt.event = EPOLLOUT | EPOLLET;
	epoll_ctl(epfd, EPOLL_CTL_ADD, 4, &evt);

And receive two different events for "mydata0" and "mydata1". That's what
you really link to.



>    2. When process A sends an fd to process B, the events will appear
>       in process B _iff_ the fd number in B happens to be the same
>       value as in process A.  (Without your patch, the events will always
>       appear in process B).
>
>       Furthermore, when process B dups the fd or passes it elsewhere,
>       events will appear if the new fd happens to be the same as the
>       original fd number in A.
>
>       The only correct application code in this case is to use
>       EPOLL_CTL_DEL in A and EPOLL_CTL_ADD in B, although it is
>       confusing because you'll have programs which _sometimes_ work
>       without that.

This is false. Internally it's the file* that is the sink for events. So
they will receive events as long as the originator file* is alive.



> Oh, and:
>
>    3. It's almost a memory leak.  Not quite because it's cleaned up
>       eventually.  But it looks and feels just like one.

This is false too. When the last user (file count) of the underneath file*
will drop it, it will be cleaned. This is not a memory leak in books where
I studied. Is like saying that :

int main() {
	int i;
	for (i = 0; i < 1000; i++)
		open(...);
	for (;;)
		sleep(1);
	return 0;
}

is a memory leak ;)



> I guess what I'm saying is that hashing on fd number is quite simply
> wrong.  The fundamental object is the file *, that's how its meant to be.

The architecture is all based on the file*, it is there that events shows
up. The (file*, fd) key is a constraint.



- Davide

