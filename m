Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272217AbRHWEmu>; Thu, 23 Aug 2001 00:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272219AbRHWEmk>; Thu, 23 Aug 2001 00:42:40 -0400
Received: from UNASSIGNED.SKYNETWEB.COM ([64.23.55.10]:32019 "HELO
	mx.webmailstation.com") by vger.kernel.org with SMTP
	id <S272217AbRHWEm1> convert rfc822-to-8bit; Thu, 23 Aug 2001 00:42:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
Organization: AcademSoft
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: Problems with kernel-2.2.19-6.2.7 from RH update for 6.2
Date: Thu, 23 Aug 2001 11:32:47 +0700
X-Mailer: KMail [version 1.3.5]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200108220053.EAA01602@mops.inr.ac.ru>
In-Reply-To: <200108220053.EAA01602@mops.inr.ac.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010823014559.38E6D1FD74@mx.webmailstation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> connect() is used to complete asynchronously started connect.
>
> While connection is not complete connect() returns EALREADY.
> When connection is established, it succeeds. If connection fails,
> it returns an error (the same, which you get with getsockopt()).
> So, right way is to repeat connect() after poll() returned POLLOUT,
> it will either complete connection or return an error to you.

:-))) You will never think it works like this. And you is the first one fro 
whom I hear this.

> Actually, this classic interface is very ugly. Seems, it is the only place,
> where O_NONBLOCK is used not to do something nonblocking, but to start
> an asynchronous operation. And all these terrible unique error codes:
> EINPROGRESS, EALREADY suck. Thank to bsd people, who preferred ugly
> hacks instead of developing some AIO interface. :-)
> It is so ugly (it is the only place where kernel has to maintain history
> of user syscalls in addition to tcp state), that it is even offending
> that people do not use it; it means that it simply pollutes kernel. :-)

> > the combination which works. Actually thttpd also uses this (if I am
> > not mistaken).
>
> Where? httpd does not connect().

For read/write. Although it is incorrect to compare as thttpd is serving more 
than one connect.

> If they do this after accept(), it is really silly. Pure useless syscall.
>
> > The problem here is that I need to tune timeout for: each connection,
> > and for
> > connect, and read/write separately. If you could give me an advise how
> > to do this more effective, I would be really glad.
>
> I see. If tuning is goal, it is right way. Amount of syscalls is the same
> as with alarm, but logic is cleaner.

Logic with alarms will not work in multithreaded case.

> Though, with read/write SO_RCVTIMEO/SO_SNDTIMEO is preferred.
> Unfortunately, linux-2.2 seems to be the only OS not implemented this.
> [ I am not sure about Solaris though. ]
>
> In linux-2.4 they work for connect/accept too: SO_SNDTIMEO for
> connect, SO_RCVTIMEO for accept.

I assume that using SO_RCVTIME/SO_SNDTIME would be better in terms of 
performance. Maybe it worse of it to upgrade to 2.4.x, and rewrite network 
layer to use sync IP... I will think about it. How many times better it would 
be (approximately)? if we assume that I have lots of connects which transfers 
small amount of data in each (1-2K).

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
