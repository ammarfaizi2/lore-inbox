Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSL1UMb>; Sat, 28 Dec 2002 15:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSL1UMb>; Sat, 28 Dec 2002 15:12:31 -0500
Received: from mnh-1-22.mv.com ([207.22.10.54]:19973 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265677AbSL1UMX>;
	Sat, 28 Dec 2002 15:12:23 -0500
Message-Id: <200212282024.PAA03372@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address space 
In-Reply-To: Your message of "Sat, 28 Dec 2002 11:34:03 PST."
             <Pine.LNX.4.44.0212281131480.2812-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 15:24:41 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com said:
> Pulled, but that /proc/mm crap has to go (it wasn't in this patch, or
> I  would have rejected it).  

Which is exactly why it's not in that patch.  I realize that it's a lousy
interface - I'm putting it out there because I don't really have any better 
ideas and I'm hoping other people do.

The next iteration of that patch will turn /proc/mm into /dev/mm, but that's
not really a great improvement.  It just improves things around the edges a
little.

> What are the semantics the host code wants/needs, 

1 - Multiple address spaces per process
2 - Ability to make a child switch between address spaces
3 - Ability to manipulate a child's address space (i.e. mmap, munmap, mprotect
on an address space which is not current->mm)

> and how can we
> implement a sane generic mechanism that doesn't involve opening magic
> files? 

Beats me.  My first suggestion was to add another file descriptor argument
to mmap et al which would represent the address space to be modified.  Alan
didn't like that idea too much.

That still requires getting the descriptor from somewhere.  The obvious
alternative to opening a magic file is a system call, new_mm() or something.

BTW, there is some attraction to being able to open /proc/<pid>/mm and getting
a handle on that process' address space.  UML doesn't need this, but I bet
there are people who could figure out how to put it to good use.

So, here are the alternatives that I know of.  Sane replacements are craved.

Creating a new, empty address space -
	open /proc/mm (current UML host patch)
or	system call new_mm()

Switch a child from one address to another -
	PTRACE_SWITCH_MM (current UML host patch)

Manipulate a child's address space -
	write a request struct to a /proc/mm fd (current UML host patch)
or	add another fd to the mmap et al calls

Some obvious extensions to this (which UML doesn't need)
	switch yourself from one address space to another
	open and change another process' existing address space - if we're
going with system calls instead of magic files, then get_mm(pid) would suffice
for the open.

				Jeff

