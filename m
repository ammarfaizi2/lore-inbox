Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTGMXED (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270440AbTGMXED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:04:03 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:61063 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270438AbTGMXEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:04:00 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 16:11:21 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: David Schwartz <davids@webmaster.com>
cc: Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.55.0307131610100.15022@bigblue.dev.mcafeelabs.com>
References: <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, David Schwartz wrote:

>
> > Let's look at what the poll code does :
> >
> > 1) It has to allocate the kernel buffer for events
> >
> > 2) It has to copy it from userspace
> >
> > 3) It has to allocate wait queue buffer calling get_free_page (possibly
> > 	multiple times when we talk about decent fds numbers)
> >
> > 4) It has to loop calling N times f_op->poll() that in turn will add into
> > 	the wait queue getting/releasing IRQ locks
> >
> > 5) Loop another M loop to copy events to userspace
> >
> > 6) Call kfree() for all blocks allocated
> >
> > 7) Call poll_freewait() that will go with another N loop to unregister
> > 	poll waits, that in turn will do another N IRQ locks
>
> 	This is really just due to bad coding in 'poll', or more precisely very bad
> for this case. For example, why is it allocating a wait queue buffer if the
> odds that it will need to wait are basically zero? Why is it adding file
> descriptors to the wait queue before it has determined that it needs to
> wait?
>
> 	As load increases, more and more calls to 'poll' require no waiting. Yet
> 'poll' is heavily optimized for the 'no or low load' case. That's why 'poll'
> doesn't scale on Linux.

However you implement poll(2) you have "at least" to do one iteration
among the interest set, and hence your implementation will be O(N).



- Davide

