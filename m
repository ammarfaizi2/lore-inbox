Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSJPOOp>; Wed, 16 Oct 2002 10:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSJPOOp>; Wed, 16 Oct 2002 10:14:45 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:34438 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262500AbSJPOOo>; Wed, 16 Oct 2002 10:14:44 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Oct 2002 07:28:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Charles 'Buck' Krasic" <krasic@acm.org>
cc: John Gardiner Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <xu4lm4zf6ew.fsf@brittany.cse.ogi.edu>
Message-ID: <Pine.LNX.4.44.0210160618190.1548-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Oct 2002, Charles 'Buck' Krasic wrote:

>
> John Gardiner Myers <jgmyers@netscape.com> writes:
>
> > The epoll API is deficient--it is subtly error prone and it forces
> > work on user space that is better done in the kernel.  That the API
> > is specified in a deficient way does not make it any less deficient.
>
> You can argue that any API is subtly error prone.  The whole sockets
> API is that way.  That's why the W. Richard Stevens network
> programming books are such gems.  That's why having access to kernel
> source is invaluable.  You have to pay attention to details to avoid
> errors.
>
> With /dev/epoll, it is perfectly feasible to write user level
> wrapper libraries that help avoid the potential pitfalls.
>
> I think it was Dan Kegel who has already mentioned one.
>
> I've written one myself, and I'm very confident in it.  I've written a
> traffic generator application on top of my library that stresses the
> Linux kernel protocol stack to the extreme.  It generates the
> proverbial 10k cps, saturates gigabit networks, etc.
>
> It has no problem running over /dev/epoll.
>
> IMHO, the code inside my wrapper library for the epoll case is
> significantly easier to understand than the code for the case that
> uses the legacy poll() interface.
>
> If /dev/epoll were so error prone as you say it is, I think I would
> have noticed it.

The /dev/epoll usage is IMHO very simple. Once the I/O fd is created you
register it with POLLIN|POLLOUT and you leave it inside the monitor set
until it is needed ( mainly until you close() it ). It is not necessary to
continuosly switch the event mask from POLLIN and POLLOUT. An hypothetical
syscall API should look like :

int sys_epoll_create(int maxfds);
void sys_epoll_close(int epd);
int sys_epoll_addfd(int epd, int fd, int evtmask);
int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);

with the option ( if benchmarks will give positive results ) like Ben
suggested, of using the AIO event collector instead of sys_epoll_wait().




- Davide




