Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268510AbTGLVNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 17:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268513AbTGLVNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 17:13:09 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:50571 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268510AbTGLVNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 17:13:07 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 14:20:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0206@foo21.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <20030712211941.GD15643@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307121415060.4720@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk>
 <20030712205114.GC15643@srv.foo21.com> <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com>
 <20030712211941.GD15643@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Eric Varsanyi wrote:

> > > The problem with all the level triggered schemes (poll, select, epoll w/o
> > > EPOLLET) is that they call every driver and poll status for every call into
> > > the kernel. This appeared to be killing my app's performance and I verified
> > > by writing some simple micro benchmarks.
> >
> > Look this is false for epoll. Given N fds inside the set and M hot/ready
> > fds, epoll scale O(M) and not O(N) (like poll/select). There's a huge
> > difference, expecially with real loads.
>
> Apologies, I did not benchmark epoll level triggered, just select.
> The man page claimed epoll in level triggered mode was just a better
> interface so I assumed it had to call each driver to check status.

It is not neither better nor worse. For sure it is more close to what
existing apps do, and it is easier to understand.



> Reading thru it I see (I think) the clever trick of just repolling things
> that have already triggered (basically polling just for the trailing
> edge after having seen a leading edge async), cool!
>
> If it seems unpopular/unwise to add the extra poll event to show read EOF
> using this level triggered mode would likely do the job for my app (the
> extra polls every time for un-consumed events will be nothing compared to
> calling every fd's poll every time).

Even if it is true that you can drop an extra read(), having the RDHUP
event will cost exactly zero extra CPU cycles inside the kernel, and one
changed line of code (plus arch definitions in asm/poll.h). To me, it
looks acceptable. Let's see what DaveM think about it.



- Davide

