Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRIUGWl>; Fri, 21 Sep 2001 02:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRIUGWb>; Fri, 21 Sep 2001 02:22:31 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:37535 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S268861AbRIUGWS>; Fri, 21 Sep 2001 02:22:18 -0400
Message-ID: <3BAADC9A.EE129CF7@kegel.com>
Date: Thu, 20 Sep 2001 23:22:18 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] /dev/epoll update ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide wrote:
> If you need to request the current status of 
> a socket you've to f_ops->poll the fd.
> The cost of the extra read, done only for fds that are not "ready", is nothing
> compared to the cost of a linear scan with HUGE numbers of fds.

Hey, wait a sec, Davide... the whole point of the Solaris /dev/poll
is that you *don't* need to f_ops->poll the fd, I think.
And in fact, Solaris /dev/poll is insanely fast, way faster than O(N).

Consider this: what if we added to your patch logic to clear
the current read readiness bit for a fd whenever a read() on
that fd returned EWOULDBLOCK?  Then we're real close to having
the current readiness state for each fd, as the /dev/poll afficianados 
want.  Now, there's a lot more work that'd be needed, but maybe you
get the idea of where some of us are coming from.

Christopher K. St. John is requesting example code using /dev/epoll
that does not use coroutines.  Fair enough.  Christopher, take a look
at any program that uses the F_SETSIG/F_SETOWN/O_ASYNC/sigio stuff in the
2.4 kernel (for example, my Poller_sigio.cc at http://www.kegel.com/dkftpbench/dkftpbench-0.31.tar.gz )
and mentally replace the sigtimedwait() with Davide's ioctl, kinda.
The overhead of not knowing the initial poll state is at most one
or two system calls per fd over the life of the program, I think,
so it's not too bad.

- Dan
