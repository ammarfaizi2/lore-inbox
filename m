Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262491AbSJ3AUu>; Tue, 29 Oct 2002 19:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJ3AUu>; Tue, 29 Oct 2002 19:20:50 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:10923 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262491AbSJ3AUt>;
	Tue, 29 Oct 2002 19:20:49 -0500
Date: Wed, 30 Oct 2002 00:26:44 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: John Gardiner Myers <jgmyers@netscape.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021030002644.GB22170@bjl1.asuk.net>
References: <3DBEE645.3020808@netscape.com> <Pine.LNX.4.44.0210291237240.1457-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210291237240.1457-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) "issuing a command to an IDE disk" == "using read/write until EAGAIN"
> 2) "adding yourself on the IDE disk wait queue" == "calling sys_epoll_wait()"

That is quite a good analogy.  epoll is like a waitqueue - which is
also like a futex.  To use a waitqueue properly you have do these
things in the order shown:

	1. Set the task state to stopped.
	2. Register yourself on the waitqueue.
	3. Check the condition.
	4. If condition is not met, schedule.

With epoll it is very similar.  To wait for a condition on a file
descriptor, such as readability, you must do these things in the order
shown:

	1. Register your interest using epoll_ctl.
	2. Check the condition by actually calling read().
	3. If the condition is not met (i.e. read() returned EAGAIN),
	   call epoll_wait (i.e. equivalent to schedule).

With epoll, you can optimise by registering interest just once.  In
other words, steps 2 and 3 may be repeated without repeating step 1.

And if you are concerned about starvation -- that is, one of your file
descriptors always has new data so others don't get a chance to be
serviced -- don't be.  You don't have to completely read one fd until
you see EGAIN.  All that matters is that until you see the EAGAIN,
your user space data structure should have a flag that says the fd is
still readable, so another epoll event is not expected or required for
that fd.

-- Jamie
