Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317893AbSHOXyC>; Thu, 15 Aug 2002 19:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317891AbSHOXyC>; Thu, 15 Aug 2002 19:54:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13967 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317888AbSHOXx7>;
	Thu, 15 Aug 2002 19:53:59 -0400
Date: Fri, 16 Aug 2002 01:58:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151652020.15744-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208160152260.6466-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:

> > we could skip the 'clear' bit if this is the last release of the mm.
> 
> Ahhah, but you miss the point.
> 
> The fork()'ed child may clone on its own, and then exit. [...]

i was actually thinking about exactly this scenario when suggesting this.  
The fork()ed child might as well end up being a 'thread' that exits and
thus needs to clear up after itself, right?

> [...] In which case we sure as heck don't want the original child to
> modify the VM that it now shares with a subthread.

in what way is clone() utilized? if it's via any threading library then
the fork()-ed process has its own thread state, which must be freed when
exiting. So it's something like:

	thread X
	fork()		===============>  thread Y
					  clone() ===========>  thread Z

so we at this point have the original thread X, a new thread Y that was
created via the fork(), and thread Z. Thread Y and Z share the same V. If
now thread Y exits:

					   exit()

then we'd sure expect for Z's sake to free Y's thread state, right?  
Otherwise there would be a resource leak.

[ but it's getting late here and i might miss something :) ]

	Ingo

