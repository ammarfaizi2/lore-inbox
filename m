Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSJ1WQa>; Mon, 28 Oct 2002 17:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSJ1WQE>; Mon, 28 Oct 2002 17:16:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:32916 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261608AbSJ1WNw>; Mon, 28 Oct 2002 17:13:52 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 14:29:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021028220809.GB27798@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, bert hubert wrote:

> On Mon, Oct 28, 2002 at 11:14:19AM -0800, Hanna Linder wrote:
>
> > 	The results of our testing show not only does the system call
> > interface to epoll perform as well as the /dev interface but also that epoll
> > is many times better than standard poll. No other implementations of poll
>
> Hanna,
>
> Sure that this works? The following trivial program doesn't work on stdinput
> when I'd expect it to. It just waits until the timeout passes end then
> returns 0. It also does not work on a file, which is to be expected,
> although 'select' returns with an immediate availability of data on a file
> according to SuS.
>
> Furthermore, there is some const weirdness going on, the ephttpd server has
> a different second argument to sys_epoll_wait.

sys_epoll, by plugging directly in the existing kernel architecture,
supports sockets and pipes. It does not support and there're not even
plans to support other devices like tty, where poll() and select() works
flawlessy. Since the sys_epoll ( and /dev/epoll ) fd support standard polling, you
can mix sys_epoll handling with other methods like poll() and the AIO's
POLL function when it'll be ready. For example, for devices that sys_epoll
intentionally does not support, you can use a method like :

        put_sys_epoll_fd_inside_XXX();
        ...
        wait_for_XXX_events();
        ...
        if (XXX_event_fd() == sys_epoll_fd) {
                sys_epoll_wait();
                for_each_sys_epoll_event {
                        handle_fd_event();
                }
        }




- Davide



