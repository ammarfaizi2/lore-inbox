Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSL2Atc>; Sat, 28 Dec 2002 19:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbSL2Atc>; Sat, 28 Dec 2002 19:49:32 -0500
Received: from crack.them.org ([65.125.64.184]:54946 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S265643AbSL2Atb>;
	Sat, 28 Dec 2002 19:49:31 -0500
Date: Sat, 28 Dec 2002 19:59:13 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address space
Message-ID: <20021229005913.GA25970@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
References: <200212282024.PAA03372@ccure.karaya.com> <Pine.LNX.4.44.0212281227510.25566-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212281227510.25566-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 12:50:53PM -0800, Linus Torvalds wrote:
> 
> On Sat, 28 Dec 2002, Jeff Dike wrote:
> > 
> > > What are the semantics the host code wants/needs, 
> > 
> > 1 - Multiple address spaces per process
> > 2 - Ability to make a child switch between address spaces
> > 3 - Ability to manipulate a child's address space (i.e. mmap, munmap, mprotect
> >     on an address space which is not current->mm)
> 
> Well, #3 falls under "ptrace()" as far as I'm concerned, I don't really 
> want to expose things through /proc (or /dev, which is even _worse_).
> 
> We used to have things that could be done with /proc/<pid>/mem, and it was 
> a total security disaster. It was removed in the 2.3.x series because of 
> that.

FWIW, GDB also would like to have #3.  We can do without it; GDB
already supports calling functions in the inferior by a stack or code
trampoline, so we could just make the child call mprotect; but it would
be faster and simpler to have a ptrace op for it.  HP/UX had, among
other things, TT_PROC_SET_MPROTECT and TT_PROC_GET_MPROTECT; I don't
think we have a system call equivalent to GET_MPROTECT right now.

Of course, without more comprehensive kernel support doing
protection-based watchpoints this way is murder for perfomance, almost
as bad as just doing it by single-stepping.  You need to disable them
at every syscall entry, which means that you can't have multiple
threads running in userspace while one thread is in a syscall, or you
might miss a watchpoint event.

It would be ideal to have some way to set the permissions such that
accesses from inside the kernel succeeded and from userspace failed
(i.e. render it temporarily a kernel page; but not exactly; we'd want
things like "normally writeable; currently writeable by the kernel;
still currently readable by userspace" for a normal watchpoint).
I don't know if that's practical without impacting MM performance. 

Suggestions welcome; I haven't really started to work on this yet
although it's creeping up my list of important debugger projects. 
PowerPC MMUs have a mechanism that could be used for this but I don't
know if other architectures do.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
