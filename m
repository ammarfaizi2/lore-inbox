Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUCJUjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbUCJUjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:39:05 -0500
Received: from mail.shareable.org ([81.29.64.88]:63369 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262810AbUCJUjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:39:01 -0500
Date: Wed, 10 Mar 2004 20:38:57 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] different proposal for mq_notify(SIGEV_THREAD)
Message-ID: <20040310203857.GA7341@mail.shareable.org>
References: <404B2C46.90709@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404B2C46.90709@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Problem:
> - high resource usage: one fd for each pending notification.
> - complex user space.
> 
> New proposal:
> mq_notify(SIGEV_THREAD) receives two additional parameters:
> - a 16-byte cookie.
> - a file descriptor of a special notify file. The notify file is similar 
> to a pipe. The main difference is that writing to it mustn't block, 
> therefore the buffer handling differs.
> If the event happens, then the kernel "writes" the cookie to the notify 
> file.
> User space reads the cookie and calls the notification function.
> 
> Problems:
> - More complexity in kernel.
> - How should the notify fd be created? Right now it's mq_notify with 
> magic parameters, probably a char device in /dev is the better approach.

Wouldn't it make more sense to use epoll for this?

At the moment, async futexes use one fd per futex, and you want to
wait for multiple ones you have to use select, poll or epoll.

If you want to collect from multiple event sources through a single
fd, you can use epoll.  That seems remarkeably similar to what you're
proposing for mq_notify().

The difference is that your proposal eliminates those fds.
But there is no reason that I can see why mq_notify() should be
optimised in this way and futexes not.

If you have a cookie mechanism especially for mq events, why not for
futexes, aio completions, timers, signals (especially child
terminations) and dnotify events as well?

> I think that the added complexity is not worth the effort if the notify 
> fd is only used for posix message queues. Are there other users that 
> could use the notify file? How is SIGEV_THREAD implemented for aio and 
> timers?

Presently, futexes, aio completions, timers, signals and dnotify
events could all usefully use a notify file.  Not just for
SIGEV_THREAD, either.

-- Jamie
