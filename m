Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRDKRgo>; Wed, 11 Apr 2001 13:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132684AbRDKRge>; Wed, 11 Apr 2001 13:36:34 -0400
Received: from t2.redhat.com ([199.183.24.243]:9214 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S132683AbRDKRgY>; Wed, 11 Apr 2001 13:36:24 -0400
To: Andrew Morton <andrewm@uow.edu.au>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
In-Reply-To: Your message of "Wed, 11 Apr 2001 09:56:09 PDT."
             <3AD48CA9.CA03B85D@uow.edu.au>
Date: Wed, 11 Apr 2001 18:36:23 +0100
Message-ID: <17325.987010583@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I think that's a very good approach.  Sure, it's suboptimal when there
> are three or more waiters (and they're the right type and order).  But
> that never happens.  Nice design idea.

Cheers.

> These numbers are infinity :)

I know, but I think Linus may be happy with the resolution for the moment. It
can be extended later by siphoning off excess quantities of waiters into a
separate counter (as is done now) and by making the access count use a larger
part of the variable.

Unfortunately, managing the count and siphoned-off count together is tricky.

> You need sterner testing stuff :)  I hit the BUG at the end of rwsem_wake()
> in about a second running rwsem-4.  Removed the BUG and everything stops
> in D state.
>
> Grab rwsem-4 from
> ...

Will do.

> It's very simple.  But running fully in-kernel shortens the
> code paths enormously and allows you to find those little
> timing windows.

I thought I'd got them all by using an activity counter incremented by both
read and write lockers.

> - rwsemdebug(FMT, ...) doesn't compile with egcs-1.1.2.  Need
> to remove the comma.

This is tricky... you get all sorts of horrible warnings with gcc-2.96 if you
remove the comma. What I've done is now ANSI-C99 compliant, but egcs is not.

> - The comments in down_write and down_read() are inaccurate.
> RWSEM_ACTIVE_WRITE_BIAS is 0xffff0001, not 0x00010001

Done.

> - It won't compile when WAITQUEUE_DEBUG is turned on. I
> guess you knew that.

Currently putting in separate debugging stuff for rwsems.

> - The comments above the functions in semaphore.h need
> updating.

Done. (BTW in the latest patch, they're actually split out into separate
header files as per Linus's suggestion).

> - What on earth does __xg() do?  (And why do people write
> code like that without explaining why?  Don't answer this
> one).

Stolen from the xchg() macro/function, but I'm not sure what it does. Plus I
don't use it now.

> - Somewhat offtopic: the `asm' statements in semaphore.c
> are really dangerous.

Now all got .text in.

