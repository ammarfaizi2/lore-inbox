Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265138AbSJaDFd>; Wed, 30 Oct 2002 22:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSJaDFd>; Wed, 30 Oct 2002 22:05:33 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:31133 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265138AbSJaDFb>; Wed, 30 Oct 2002 22:05:31 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 30 Oct 2002 19:21:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <3DC0904B.1070009@netscape.com>
Message-ID: <Pine.LNX.4.44.0210301834540.1452-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, John Gardiner Myers wrote:

> You posted code which you claimed was "even more cleaner and simmetric"
> (sic) because it fell through to the do_use_fd() code instead of putting
> the do_use_fd() code in an else clause.  A callback scheme is akin to
> the if/else structure.  To adapt the first code to a callback scheme,
> the accept callback has to somehow arrange to call the do_use_fd()
> callback before returning to the event loop.  This requirement is subtle
> and asymmetric.

A callback scheme can be _trivially_ implemented use the current epoll.
I'm sure you know exactly how to do it, so I'm not spending more time
explaining it to you.



> Basically, you spawn off another coroutine.  That complicates the "fall
> through to do_use_fd()" logic in the first code by requiring an external
> facility not required by the second code.  The second code could simply
> have the accept code loop until EAGAIN.

No it does not, you always fall through do_use_fd(). It's that simple.



> Epoll creates a new callback mechanism and plugs into this new callback
> mechansim.  It adds a new set of notification hooks which feed into this
> new callback mechansim.  The end result is that there is one set of
> notification hooks for classic poll and another set for epoll.  When
> epoll is not being used, the poll and socket code makes an additional
> set of checks to see that nobody has registered interest through the new
> callback mechanism.

Where epoll hooks has nothing to do with ->f_po->poll()



> > It fits _exactly_
> >the rt-signal hooks. One of the design goals for me was to add almost
> >nothing on the main path. You can lookup here for a quick compare between
> >aio poll and epoll for a test where events delivery efficency does matter
> >( pipetest ) :
> >
> This is a comparison of the cost of using epoll to the cost of using aio
> in one particular situation.  It is irrelevant to the point I was making.

See, I believe numbers talks. And it does make a pretty clear point
indeed.



> My understanding of the efficiency of the epoll event notification
> subsystem is:
>
> 1) Unlike the current aio poll, it amortizes the cost of interest
> registration/deregistration across multiple events for a given connection.

Yep


> 2) It declares multithreaded use out of scope, making optimizations that
> are only appropriate for use by single threaded callers.

It's not single threaded. It can be used in multithreaded environment if
the one that code the app has a minimal idea of what he's doing. Like
everything else. You cannot use a FILE* wildly sharing it randomly inside
a multithreaded app, and expecting to receive coherent results. Like 95%
of the APIs. Can those APIs be used in a multithreaded environment ? You bet,
with care, like everything that uses freakin' threads.




- Davide






