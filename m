Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272057AbRHVRXo>; Wed, 22 Aug 2001 13:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272054AbRHVRXi>; Wed, 22 Aug 2001 13:23:38 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:28167 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S272049AbRHVRXa>;
	Wed, 22 Aug 2001 13:23:30 -0400
Message-Id: <200108220053.EAA01602@mops.inr.ac.ru>
Subject: Re: Problems with kernel-2.2.19-6.2.7 from RH update for 6.2
To: dyp@perchine.com (Denis Perchine)
Date: Wed, 22 Aug 2001 04:53:24 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010820155450.777C91FD74@mx.webmailstation.com> from "Denis Perchine" at Aug 21, 1 01:52:04 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > BTW why do you use funny getsockopt instead of canonical non-blocking
> > connect?
> 
> Hmmm... If I know what canonical non-blocking connect is, I would use it =
> I=20
> think...

connect() is used to complete asynchronously started connect.

While connection is not complete connect() returns EALREADY.
When connection is established, it succeeds. If connection fails,
it returns an error (the same, which you get with getsockopt()).
So, right way is to repeat connect() after poll() returned POLLOUT,
it will either complete connection or return an error to you.

Actually, this classic interface is very ugly. Seems, it is the only place,
where O_NONBLOCK is used not to do something nonblocking, but to start
an asynchronous operation. And all these terrible unique error codes:
EINPROGRESS, EALREADY suck. Thank to bsd people, who preferred ugly
hacks instead of developing some AIO interface. :-)
It is so ugly (it is the only place where kernel has to maintain history
of user syscalls in addition to tcp state), that it is even offending
that people do not use it; it means that it simply pollutes kernel. :-)


> the combination which works. Actually thttpd also uses this (if I am not=20
> mistaken).

Where? httpd does not connect().

If they do this after accept(), it is really silly. Pure useless syscall.


> The problem here is that I need to tune timeout for: each connection, and=
>  for=20
> connect, and read/write separately. If you could give me an advise how to=
>  do=20
> this more effective, I would be really glad.

I see. If tuning is goal, it is right way. Amount of syscalls
is the same as with alarm, but logic is cleaner.

Though, with read/write SO_RCVTIMEO/SO_SNDTIMEO is preferred.
Unfortunately, linux-2.2 seems to be the only OS not implemented this.
[ I am not sure about Solaris though. ]

In linux-2.4 they work for connect/accept too: SO_SNDTIMEO for
connect, SO_RCVTIMEO for accept.

Alexey

