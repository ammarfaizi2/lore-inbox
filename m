Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbTGLVE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268513AbTGLVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 17:04:59 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:55460 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S268511AbTGLVE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 17:04:57 -0400
Date: Sat, 12 Jul 2003 16:19:41 -0500
From: Eric Varsanyi <e0206@foo21.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030712211941.GD15643@srv.foo21.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk> <20030712205114.GC15643@srv.foo21.com> <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem with all the level triggered schemes (poll, select, epoll w/o
> > EPOLLET) is that they call every driver and poll status for every call into
> > the kernel. This appeared to be killing my app's performance and I verified
> > by writing some simple micro benchmarks.
> 
> Look this is false for epoll. Given N fds inside the set and M hot/ready
> fds, epoll scale O(M) and not O(N) (like poll/select). There's a huge
> difference, expecially with real loads.

Apologies, I did not benchmark epoll level triggered, just select.
The man page claimed epoll in level triggered mode was just a better
interface so I assumed it had to call each driver to check status.

Reading thru it I see (I think) the clever trick of just repolling things
that have already triggered (basically polling just for the trailing
edge after having seen a leading edge async), cool!

If it seems unpopular/unwise to add the extra poll event to show read EOF
using this level triggered mode would likely do the job for my app (the
extra polls every time for un-consumed events will be nothing compared to
calling every fd's poll every time). 

I guess my only argument would be that edge triggered mode isn't really
workable with TCP connections if there's no way to solve the ambiguity
between EOF and no data in buffer (at least w/o an extra syscall). I just
realized that the race you mention in the man page (reading data from
the 'next' event that hasn't been polled into user mode yet) will lead to
the same issue: how do you know if you got this event because you consumed
the data on the previous interrupt or if this is an EOF condition.

-Eric Varsanyi
