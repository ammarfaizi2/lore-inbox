Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSJaPhT>; Thu, 31 Oct 2002 10:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJaPhT>; Thu, 31 Oct 2002 10:37:19 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:63920 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262708AbSJaPhR>;
	Thu, 31 Oct 2002 10:37:17 -0500
Date: Thu, 31 Oct 2002 15:41:12 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021031154112.GB27801@bjl1.asuk.net>
References: <20021031005259.GA25651@bjl1.asuk.net> <Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ps. I thought I should explain what bothers me most about epoll at the
moment.  It's good at what it does, but it's so very limited in what
it supports.

I have a high performance server application in mind, that epoll is
_almost_ perfect for but not quite.

Davide, you like coroutines, so perhaps you will appreciate a web
server that serves a mixture of dynamic and static content, using
coroutines and user+kernel threading in a carefully balanced way.
Dynamic content is cached, accurately (taking advantage of nanosecond
mtimes if possible), yet served as fast as static pages (using a
clever cache validation method), and is built from files (read using
aio to improve throughput) and subrequests to other servers just like
a proxy.  Data is served zero-copy using sendfile and /dev/shm.

A top quality server like that, optimised for performance, has to
respond to these events:

	- network accept()
	- read/write/exception on sockets and pipes
	- timers
	- aio
	- futexes
	- dnotify events 

See how epoll only helps with the first two?  And this is the very
application space that epoll could _almost_ be perfect for.

Btw, it doesn't _have_ to be a web server.  Enterprise scale Java
runtimes, database servers, spider clients, network load generators,
proxies, even humble X servers - also have very similar requirements.

There are several scalable and fast event queuing mechanisms in the
kernel now: rt-signals, aio and epoll, yet each of them is limited by
only keeping track of a few kinds of possible event.

Technically, it's possible to use them all together.  If you want to
react to all the kinds of events I listed above, you have to.  But
it's mighty ugly code to use them all at once, and it's certainly not
the "lean and mean" event loop that everyone aspires to.

By adding yet another mechanism without solving the general problem,
epoll just makes the mighty ugly userspace more ugly.  (But it's
probably worth using - socket notifcation through rt-signals has its
own problems).

I would very much like to see a general solution to the problem of all
different kinds of events being queued to userspace efficiently,
through one mechanism ("to bind them all...").  Every piece of this puzzle
has been written already, they're just not joined up very well.

I'm giving this serious thought now, if anyone wants to offer input.

-- Jamie

ps. Alan, you mentioned something about futexes being suitable.
Was that a vague notion, or do you have a clear idea in mind?

(A nice way to collect events from a _set_ of futexes might be just the thing.)
