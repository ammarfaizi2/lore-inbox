Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbQKDGYE>; Sat, 4 Nov 2000 01:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132489AbQKDGXy>; Sat, 4 Nov 2000 01:23:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64775 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132484AbQKDGXp>; Sat, 4 Nov 2000 01:23:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Re: Negative scalability by removal of 
 lock_kernel()?(Was:Strange performance behavior of 2.4.0-test9)
Date: 3 Nov 2000 22:23:15 -0800
Organization: Transmeta Corporation
Message-ID: <8u0a0j$eol$1@penguin.transmeta.com>
In-Reply-To: <39FD8D0B.B6C0C772@uow.edu.au> <Pine.LNX.4.21.0010301518290.18636-100000@twinlark.arctic.org> <3A0399CD.8B080698@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A0399CD.8B080698@uow.edu.au>,
Andrew Morton  <andrewm@uow.edu.au> wrote:
>
>neither flock() nor fcntl() serialisation are effective
>on linux 2.2 or linux 2.4.  This is because the file
>locking code still wakes up _all_ waiters.  In my testing
>with fcntl serialisation I have seen a single Apache
>instance get woken and put back to sleep 1,500 times
>before the poor thing actually got to service a request.

Indeed.

flock() is the absolute worst case, and always has been.  I guess nobody
every actually bothered to benchmark it.

>For kernel 2.2 I recommend that Apache consider using
>sysv semaphores for serialisation. They use wake-one. 
>
>For kernel 2.4 I recommend that Apache use unserialised
>accept.

No.

Please use unserialized accept() _always_, because we can fix that. 

Even 2.2.x can be fixed to do the wake-one for accept(), if required. 
It's not going to be any worse than the current apache config, and
basically the less games apache plays, the better the kernel can try to
accomodate what apache _really_ wants done.  When playing games, you
hide what you really want done, and suddenly kernel profiles etc end up
being completely useless, because they no longer give the data we needed
to fix the problem. 

Basically, the whole serialization crap is all about the Apache people
saying the equivalent of "the OS does a bad job on something we consider
to be incredibly important, so we do something else instead to hide it".

And regardless of _what_ workaround Apache does, whether it is the sucky
fcntl() thing or using SysV semaphores, it's going to hide the real
issue and mean that it never gets fixed properly.

And in the end it will result in really really bad performance. 

Instead, if apache had just done the thing it wanted to do in the first
place, the wake-one accept() semantics would have happened a hell of a
lot earlier. 

Now it's there in 2.4.x. Please use it. PLEASE PLEASE PLEASE don't play
games trying to outsmart the OS, it will just hurt Apache in the long run.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
