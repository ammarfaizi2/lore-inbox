Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUDCVoI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 16:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUDCVoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 16:44:08 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:44934 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261988AbUDCVoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 16:44:04 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 3 Apr 2004 13:44:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Ben Mansell <ben@zeus.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition? (was: epoll
 reporting events when it hasn't been asked to)
In-Reply-To: <20040402184035.GA653@mail.shareable.org>
Message-ID: <Pine.LNX.4.44.0404031334440.2122-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Jamie Lokier wrote:

> None of select, poll or epoll allow a program to ignore POLLERR while
> checking POLLIN or POLLOUT.  So at least epoll is consistent with the
> other two.
> 
> It is possible to ignore POLLHUP conditions with select(), but not
> poll() or epoll.  For sockets at least, POLLHUP should indicate the
> socket is fully closed, so that reading and writing will both fail.
> Thus it makes sense that POLLHUP is not ignorable, although curiously
> select() only treats POLLHUP as an _input_ condition, so it won't wake
> something that's waiting only for output readiness.  poll() will
> always wake even if you're only waiting for POLLOUT.
> 
> POLLERR is set by UDP sockets with a pending error condition, and that
> will be reported whether you read or write to the socket (except in
> some perverse conditions where MSG_MORE has been used - then app state
> machines could get confused).  So it's appropriate for a POLLIN or
> POLLOUT waiter to be woken when there's a POLLERR condition.
> 
> Summary: epoll is consistent with poll().  I'm not sure why poll() and
> select() treat POLLHUP differnently.  A poll() for POLLOUT will be
> woken by a POLLHUP condition, yet a select() for output will _not_ be
> woken by a POLLHUP condition.

The issue here was a little bit different. On the contrary to poll(2), 
with epoll and fd in resident inside the interest set, and epoll allows 
you to set the interest event mask to 0. In such condition, epoll does 
report POLLHUP and POLLERR events of the 0 masked fd, and this was the 
original Ben's argoument. Looking at poll(2) though, it seems that it does 
the same thing if you set the event mask to 0. So epoll is coherent with 
poll(2) in this. I personally believe that an application should handle 
those exceptional events in any case, by simply removing the fd from the 
epoll set (and lazily freeing the associated userspace data structures).
So, if no big argouments will come against this, I'd rather prefer to keep 
such behaviour. OTOH the patch would be trivial (one or two lines) , so 
there will be no design problems in doing this.



- Davide


