Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271562AbSISQhz>; Thu, 19 Sep 2002 12:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271575AbSISQhz>; Thu, 19 Sep 2002 12:37:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5640 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271562AbSISQhy>; Thu, 19 Sep 2002 12:37:54 -0400
Date: Thu, 19 Sep 2002 09:43:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <20020919163542.GA14951@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Sep 2002, Andries Brouwer wrote:
> > 
> > Which means that if the tty is going away, it has to be removed from _all_ 
> > tasks, not just from the one session that happened to be the most recent 
> > one.
> 
> [POSIX 1003.1-2001]

Gaah. Good that somebody else has the energy to actually read the 
standards instead of just trying to desperately remember some dusty 
details..

> The controlling terminal is inherited by a child process during a fork()
> function call. A process relinquishes its controlling terminal when it creates
> a new session with the setsid() function; other processes remaining in the
> old session that had this terminal as their controlling terminal continue
> to have it.

Well, that certainly clinches the fact that the controlling terminal _can_ 
and does continue to be hold by processes outside the current session 
group.

I suspect that to handle controlling terminals efficiently (ie without
iterating over all tasks), the "current->tty" thing needs to be expanded
with a linked list of processes sharing the tty or something (probably
with the head of the list being in the tty structure itself).

On the other hand, I don't think it necessarily is a problem to walk all 
threads either - the controlling terminal changes should be rare, and this 
is O(n) rather than some quadratic or other behaviour.

Anyway, that seems to make Ingo's patch wrong for this case at least. 
Ingo?

		Linus

