Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318189AbSHMPzw>; Tue, 13 Aug 2002 11:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318190AbSHMPzw>; Tue, 13 Aug 2002 11:55:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55044 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318189AbSHMPzv>; Tue, 13 Aug 2002 11:55:51 -0400
Date: Tue, 13 Aug 2002 09:01:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <20020813164415.A11554@infradead.org>
Message-ID: <Pine.LNX.4.44.0208130852450.7291-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Christoph Hellwig wrote:
> 
> First the name souns horrible.  What about spawn_thread or create_thread
> instead?  it's not our good old clone and not a lookalike, it's some
> pthreadish monster..

This one definitely isn't a pthread-specific problem. The old UNIX fork()  
semantics for <pid> returning really are fairly broken, since the notion
of returning the pid in a local register is inherently racy for _anything_
that wants to maintain a list of its children and needs to access the list 
in the SIGCHLD handler.

(Simple explanation: imagine a child that exits so quickly that the parent
hasn't even had time to do the "store pid into the array" before the
parent is already signalled with SIGCHLD. Yes, this happens, and yes, it's
a real problem. It wasn't that long ago that bash would _crash_ on this).

With a system call like this, the parent can
 - allocate the new child information block first
 - do the fork with the pid pointer pointing into the child information 
   block.
 - when SIGCHLD for that child comes in, all state will have been set up 
   with no races.

Note how this isn't even thread-specific: it very much would work with a
regular fork-like approach and a standard shell.

> > with the help of this syscall glibc's next-generation pthreads code
> 
> have you discussed this code with IBM's pthread group?  I think we don't
> want to add a new syscall that is only useful to glibc..

I agree that the name is a bit ugly, but this is a system call that I 
actually think is fundamentally useful (ie I can see how it would be 
totally usable quite outside any specific library implementation issues).

Talking it over with the IBM threading guys is still worthwhile, though. 
There may be _other_ information that the IBM guys have problems with, and 
it could easily be that the interface we really want is even more generic.

		Linus

