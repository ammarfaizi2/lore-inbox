Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270540AbTGNF7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270542AbTGNF7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:59:47 -0400
Received: from mail.webmaster.com ([216.152.64.131]:62188 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S270540AbTGNF7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:59:43 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: "Davide Libenzi" <davidel@xmailserver.org>,
       "Eric Varsanyi" <e0206@foo21.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
Date: Sun, 13 Jul 2003 23:14:28 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEHHEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030714015122.GC22769@mail.jlokier.co.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:

> > 	This is really just due to bad coding in 'poll', or more
> > precisely very bad
> > for this case. For example, why is it allocating a wait queue
> > buffer if the
> > odds that it will need to wait are basically zero? Why is it adding file
> > descriptors to the wait queue before it has determined that it needs to
> > wait?

> Pfeh!  That's just tweaking.

	Nonetheless, it's embarassing for Linux that performance shoots up if you
replace a normal call to 'poll' with a sleep followed by a call to 'poll'
with a zero wait. But that's peripheral to my point.

> If you really want to optimise 'poll', maintain a per-task event
> interest set like epoll does (you could use the epoll infrastructure),
> and on each call to 'poll' just apply the differences between the
> interest set and whatever is passed to poll.
>
> That would actually reduce the number of calls to per-fd f_op->poll()
> methods to O(active), making the internal overhead of 'poll' and
> 'select' comparable with epoll.
>
> I'd not be surprised if someone has done it already.  I heard of a
> "scalable poll" patch some years ago.
>
> That leaves the overhead of the API, which is O(interested) but it is
> a much lower overhead factor than the calls to f_op->poll().

	Definitely, the API will always guarantee performance is O(n). If you're
interested in ultimate scalability, you can never exceed O(n) with 'poll'.
But my point is that you can never exceed O(n) with any discovery
implementation because the number of sockets to be discovered scales at
O(n), and you have to do something per socket.

	This doesn't change the fact that 'epoll' outperforms 'poll' at every
conceivable situation. It also doesn't change the fact that edge-based
triggering allows some phenomenal optimizations in multi-threaded code. It
also doesn't change the fact that Linux's 'poll' implementation is not so
good for the high-load, busy server case.

	All I'm trying to say is that the argument that 'epoll' scales at a better
order than 'poll' is bogus. They both scale at O(n) where 'n' is the number
of connections you have. No conceivable implementation could scale any
better.

	DS


