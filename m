Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSHBRWA>; Fri, 2 Aug 2002 13:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSHBRV7>; Fri, 2 Aug 2002 13:21:59 -0400
Received: from mnh-1-27.mv.com ([207.22.10.59]:45572 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S316610AbSHBRV5>;
	Fri, 2 Aug 2002 13:21:57 -0400
Message-Id: <200208021828.NAA02466@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accelerating user mode linux 
In-Reply-To: Your message of "Fri, 02 Aug 2002 05:50:03 -0400."
             <200208020950.g729o3K28069@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 13:28:18 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@redhat.com said:
> Its not a veto. I was trying to avoid having to add any more branches
> to the fast paths in the kernel.  

Unless I'm missing something, a test for altmm and a branch to out of line
mm switching should be about three instructions on x86 including a correctly
predicted branch not taken in the non-altmm case.

> The remaining sigreturn question is
> "how do you get into 'user' mode the first time"

Last night I told you it was by building a signal frame by hand and returning
through it.  That's no longer true.  Now, every UML thread (except the idle
thread, which I think can be reasonable expected not to try to enter userspace)
is in a host signal handler when in the kernel.

All entrances to userspace happen by returning through that signal frame.
Special userspace returns (exec and fork et al) fiddle the sigcontext in
that frame beforehand.  Normal system calls stuff the return value in the
appropriate slot in the sigcontext before returning, as well.

So, there's nothing special about entering userspace for the first time.
Everything is under a signal frame, so any time something needs to enter
userspace, it just returns through it.

> This switches to the altmm (creating one if it doesnt exist as a copy
> of the current mm)

About this business of creating a UML kernel address space for each UML
user thread - I prefer to have a single kernel address space to which all
signals are delivered.

This has the slight disadvantage that the process address space isn't directly
accessible, but I can live with that.  A virt_to_phys translation isn't too
painful.

A single separate kernel address space has the following attractions for me:
	there are some cases where 3G of KVA would be very useful
	it would make the UML kernel completely invisible to processes, which
is important for honeypots
	apps which consume huge amounts of VM might run on the host, but
crap out inside a UML

This raises the question of how the process address spaces are created.  For
a variety of reasons unrelated to altmm (which I can go into if anyone's
interested), I want address spaces to be separate user-visible objects.  

You'd create a new empty one by opening /proc/new-mm or something and get
back a file descriptor as a handle to it.  mmap/munmap/mprotect would be
extended to take a file descriptor pointing to the address space to be
changed.

So, altmm would look like this:

When it starts up, UML would call sigaltmm, passing a descriptor to its own 
address space and register its signal handlers with a new flag, SA_IN_MM.

sigaction would have an mm field in which this descriptor would be put (and
would contain -1 in the non-altmm case).

The sigcontext would have an extra int in it which would be the descriptor
of the address space to which sigreturn will return.

Like now, UML would arrange that everything is under a host signal handler.
When it enters userspace it would change the address space fd in the sigcontext
if necessary.

Does this sound sane?

				Jeff


