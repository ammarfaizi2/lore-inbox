Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319341AbSHQE60>; Sat, 17 Aug 2002 00:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319343AbSHQE60>; Sat, 17 Aug 2002 00:58:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59140 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319341AbSHQE6Z>; Sat, 17 Aug 2002 00:58:25 -0400
Date: Fri, 16 Aug 2002 22:04:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <Pine.LNX.4.44.0208162134440.2497-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208162156090.2539-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Linus Torvalds wrote:
> 
> I suspect that you are used to the traditional UNIX "process" notion,
> where a "process" has exactly one file table, and has exactly one set of
> signals, one set of semaphores etc. In that setup it can be quite
> convenient to map these into the VM address space at magical addresses.

Btw, at this point I should say that that doesn't mean that I'm _against_
a per-VM kmap table, I'm just pointing out that it's not a trivial issue.

Andrea and I talked about exactly this at OLS, because Andrea would have
liked to use it for handling the generic_file_write() kmap case without
having to worry about running out of kmap's and the deadlocks we used to
have in that space (before the atomic user copy approach).

And the thing is, you _can_ use a per-VM kmap setup, but it really only
moves the problem from a global kmap space ("everybody shares the same
VM") into a slightly smaller subset of it, a global thread kmap ("all
threads share the same VM").

So at least in that particular case, by moving it from a global space to a
per-VM space, the DoS wrt generic_file_write() didn't actually go away. It
just had to be triggered slightly differently (ie using lots of threads).

There may be other cases where this is ok. Moving to a per-VM kmap space
may not _fix_ some fundamental scalability problem, but it might move it
further out and make it a non-issue under normal load. Which is why I
don't think the idea is fundamentally flawed, I just wanted to point out
some of the traps to people since we've already almost fallen into some of
them..

		Linus

