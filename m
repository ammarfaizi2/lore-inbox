Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSKZSVK>; Tue, 26 Nov 2002 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266497AbSKZSVK>; Tue, 26 Nov 2002 13:21:10 -0500
Received: from mnh-1-18.mv.com ([207.22.10.50]:25348 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S266480AbSKZSVJ>;
	Tue, 26 Nov 2002 13:21:09 -0500
Message-Id: <200211261829.NAA02265@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1 
In-Reply-To: Your message of "26 Nov 2002 06:57:39 +0100."
             <p73u1i4ub3g.fsf@oldwotan.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Nov 2002 13:29:21 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ak@suse.de said:
> Can you quickly describe why you didn't use one host process per uml
> process ?  
> That would have avoided the need for a /proc/mm extension too I guess.

Yes, it would have.  And it was done that way during an intermediate stage
of the skas work.

There were a few reasons for /proc/mm -
	reduce host resource consumption - we still have the mm_struct and
page tables, but we do eliminate the kernel stack, task struct, and associated
data
	design cleanliness - a UP UML is inherently single-threaded, so it's
pointless to have many host processes when only one of them can be running.
A host process maps much more cleanly onto a UML processor than a UML process,
and a UML process maps much more cleanly onto a host address space than a
host process.
	code cleanliness - before /proc/mm, UML manipulated address spaces
through ptrace (PTRACE_M{MAP,UNMAP,PROTECT}).  This meant that a process needed
to be used as a handle for the address space.  Since there's no way of knowing
what process in an address space is still going to exist when you want to swap
it out, the UML mm_context was a list of task_structs.  This made for some
nasty-looking code to keep that list up-to-date.  It also made for some 
nasty-looking locking against races between swapout and a thread exiting.  Now,
the UML mm_context is an int which holds a /proc/mm file descriptor.  No lists,
no races, it doesn't get any simpler.

Some smaller reasons -
	With the address space manipulations in /proc/mm rather than ptrace,
it is possible that a cleaner interface can be found for it.  The current
/proc/mm write semantics are morally equivalent to the previous ptrace 
interface, but there is hope that something better can be found.  With ptrace,
there is no hope.

	scheduling fairness - when you have a single-threaded app (in the sense
that there is only one active thread at any given time) that's spreading its
work over many threads, the thread that wants to run will compete unfairly
in the scheduler with another single-threaded app that is honestly doing all
of its work in one thread.  The thread in the first app will have accumulated
much less time than the second app's thread, and so will have higher priority,
even though the two apps may have used the same amount of CPU.  With /proc/mm,
UML gets much closer to one host process per processor, but doesn't quite
make it.  There are two host processes, one running the kernel, one running
userspace.  I'm trying to think of a way of merging them.

	It's much nicer to look at ps or top on the host and see a few 
(currently four) processes per UML rather than, say, 100.

An unexpected benefit - UML is noticably faster with /proc/mm.  That knocked
~10% off its kernel build time.  With it doing a build about 40% slower than
the host, the 10% reduction in overall run time represents ~25% reduction in
UML's virtualization overhead.

				Jeff

