Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263403AbSJOTCn>; Tue, 15 Oct 2002 15:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSJOTCm>; Tue, 15 Oct 2002 15:02:42 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:32913 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263403AbSJOTCl>; Tue, 15 Oct 2002 15:02:41 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 12:16:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <20021015150201.K14596@redhat.com>
Message-ID: <Pine.LNX.4.44.0210151213170.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Benjamin LaHaise wrote:

> On Tue, Oct 15, 2002 at 12:00:30PM -0700, Davide Libenzi wrote:
> > Something like this might work :
> >
> > int sys_epoll_create(int maxfds);
> > void sys_epoll_close(int epd);
> > int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);
> >
> > where sys_epoll_wait() return the number of events available, 0 for
> > timeout, -1 for error.
>
> There's no reason to make epoll_wait a new syscall -- poll events can
> easily be returned via the aio_complete mechanism (with the existing
> aio_poll experiment as a possible means for doing so).

Ben, one of the reasons of the /dev/epoll speed is how it returns events
and how it collapses them. A memory mapped array is divided by two and
while the user consumes events in one set, the kernel fill the other one.
The next wait() will switch the pointers. There is no copy from kernel to
user space. Doing :

int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);

the only data the kernel has to copy to userspace is the 4(8) bytes for
the "pevts" pointer.



- Davide


