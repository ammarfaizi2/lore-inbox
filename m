Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267012AbRGILOZ>; Mon, 9 Jul 2001 07:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbRGILOF>; Mon, 9 Jul 2001 07:14:05 -0400
Received: from mail.zmailer.org ([194.252.70.162]:47880 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S267009AbRGILNy>;
	Mon, 9 Jul 2001 07:13:54 -0400
Date: Mon, 9 Jul 2001 14:15:28 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Ernest N. Mamikonyan" <ernest@newton.physics.drexel.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: increasing the TASK_SIZE
Message-ID: <20010709141528.A18653@mea-ext.zmailer.org>
In-Reply-To: <3B44DA51.10D3F0C0@newton.physics.drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B44DA51.10D3F0C0@newton.physics.drexel.edu>; from ernest@newton.physics.drexel.edu on Thu, Jul 05, 2001 at 05:21:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 05:21:21PM -0400, Ernest N. Mamikonyan wrote:
> I was wondering how I can increase the process address space, TASK_SIZE
> (PAGE_OFFSET), in the current kernel. It looks like the 3 GB value is
> hardcoded in a couple of places and is thus not trivial to alter. Is
> there any good reason to limit this value at all, why not just have it
> be the same as the max addressable space (64 GB)? We have an ix86 SMP
> box with 4 GB of RAM and want to be able to allocate all of it to a
> single program (physics simulation). I would greatly appreciate any help
> on this.

	It is marginally possible to increase that up so much
	that you get about 3.8-3.9 GB for usermode process.
	(I use k=1024, M=k*k, G=k*k*k)

	It is absolutely impossible to get it into anything above
	the 4.0 GB limit.   This hard limit is buried inside the i386
	(and all of its successors) memory addressing, and mapping
	hardware.  There is a choke-point of 32 address bits along
	the way, which prevents going above 4.0 GB most effectively.

	With considerable infrastructural work(*) it MIGHT be possible
	to go very near the 4.0 GB limit for userspace, but I am not
	an expert here.   The crux is at the supervisor/interrupt mode
	stack memory mapping.  As far as I understand, in i386 we
	must have the supervisor stack (and 'struct task') mapped
	into the same address space as the usermode.  Only the memory
	protection prevents the usermode to access that data.
	Also parts of kernel code must be in that address space + parts
	of kernel data related into MMU control.

	(*) Supervisor (kernel) mode must have the stack, and switch-
	around code + some datasets in its access space when transition
	into the kernel space is done (and reversed).  Accessing user-
	space from kernel can then be done via kmap() (-like) windows.
	Of course this is considerably much slower than the current method
	where each user-space has 1/4 of its total address space allocated
	for kernel internal use.

	To get most out of your box, you need to run your problem as much
	as possible at separate processors and with separate contexts.
	That way you will get most out of your SMP setup.
	(Consider your box as a small Beowulf-cluster.)

	Of course problems where you run e.g. PVM, you will need fast
	communication in between processes, and nothing would beat single
	shared memory space.   You might be able to get that by having
	e.g. SHM segments used for PVM's IPC task.
	Linux doesn't support user semaphores in SHM in scheduling sense,
	though.  You can, of course, do CPU burning spin-locks for shared
	memory area access.  The best would, IMO, be a hybride of using
	SHM for transfering large amounts of data in between processes,
	and something alike PF_UNIX sockets for signaling that there is
	some new data available.

	In _usual_ case you can ignore such details, and use your favourite
	clustering library, like PVM.

> Thanks a great deal,
> Ernie
> 
> PS. Please `CC' me the answer!
> Ernest N. Mamikonyan     E-Mail: ernest@newton.physics.drexel.edu
> Philadelphia, PA  19104  Web: www.physics.drexel.edu/research/astro

/Matti Aarnio
