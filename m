Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbRGITbG>; Mon, 9 Jul 2001 15:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbRGITa5>; Mon, 9 Jul 2001 15:30:57 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:62474 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264754AbRGITaq>;
	Mon, 9 Jul 2001 15:30:46 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107091930.f69JUiZ290389@saturn.cs.uml.edu>
Subject: Re: increasing the TASK_SIZE
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Mon, 9 Jul 2001 15:30:44 -0400 (EDT)
Cc: ernest@newton.physics.drexel.edu (Ernest N. Mamikonyan),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010709141528.A18653@mea-ext.zmailer.org> from "Matti Aarnio" at Jul 09, 2001 02:15:28 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio writes:

> It is absolutely impossible to get it into anything above
> the 4.0 GB limit.   This hard limit is buried inside the i386
> (and all of its successors) memory addressing, and mapping
> hardware.  There is a choke-point of 32 address bits along
> the way, which prevents going above 4.0 GB most effectively.

Is is possible. It just won't perform well. You have to do
a paging-like trick on that choke point. You also need a
modified compiler that does LP64 on x86.

Use 13 bits of the segment register for the top of your address
space. Segments are 512 MB. Use the low 3 GB of the choke point
for greater compatibility with regular apps and kernel code.
Keep all but 6 segments invalid, so that faults can be used to
change the 512-MB windows through the choke point.

So that gets you 4 TB of address space. (8192 segments, each of
which is 512 MB) You may shrink the segments a bit to reduce your
fault rate, but giving up some of that nice address space.
Yes I'm aware that one must move page table chunks and invalidate
stuff while adjusting the segments -- that is part of the fun!

If you actually want arrays larger than 512 MB, well then your
performance gets even worse. The compiler has to do nasty stuff to
normalize your pointers after every pointer arithmetic operation.

Compiler: write a new back end
Libc: redo much of the assembly
Kernel: new fault handler, copy_to_user, copy_from_user...

You might need to use an IP32L64 compiler for the kernel. That
won't be nice for performance, but not too much of a disaster.
Maybe pointers get padding to carry bits through casts.

BTW Ernest, nobody does this. It would likely be just a toy
due to the bad performance. You really ought to get 64-bit
hardware or find some way to use multiple processes. Toys can
be fun though, and this one is nice for cleaning up 32-bit code.

