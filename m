Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288977AbSAZBEt>; Fri, 25 Jan 2002 20:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288978AbSAZBEh>; Fri, 25 Jan 2002 20:04:37 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:45830 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288977AbSAZBET>; Fri, 25 Jan 2002 20:04:19 -0500
Message-ID: <3C51FF0C.D3B1E2F7@zip.com.au>
Date: Fri, 25 Jan 2002 16:57:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com> <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 25 Jan 2002, David Howells wrote:
> >
> >  * improves base syscall latency by approximately 5.4% (dual PIII) or 3.6%
> >    (dual Athlon) as measured by lmbench's "lat_syscall null" command against
> >    the vanilla kernel.
> 
> Looking at the code, I suspect that 99.9% of this "improvement" comes from
> one thing, and one thing only: you removed the "cli" in the system call
> return path.

Before the cli was in the stock kernel, I had added it in the
low-latency patch.  Careful testing showed that it added
13 machine cycles to a system call on a P3.

> ...
> 
>  - this "atomically return to user mode and test flags" thing needs to be
>    discussed. I'm personally inclined to think that that "cli" is really
>    needed, but 5% on simple system calls is a strong argument.

Correctness first, please.  I bet there are many ways in
which we can speed the kernel up by more than 13*n_syscalls.

<thinks of one>

On Intel hardware an open-coded duff-device memcpy is faster
than copy_to_user for all alignments except mod32->mod32.
Sometimes up to 25% faster.  

<thinks of another>

	p = malloc(4096)
	read(fd, p, 4096)

the kernel memsets the faulted-in page to zero and then
immediately copies the pagecache data onto it.  Removal
of the memset speeds up read() by ~10%.

<thinks of another>

	s/inline//g

<thinks of another>

	ext[23] directory inode allocation policy (aargh
	it's horrid)

<thinks of another>

	page pre-zeroing in the idle thread.

There are many ways of speeding up the kernel.  Let's
concentrate on the biggies.

> NOTE! There are potentially other ways to do all of this, _without_ losing
> atomicity. For example, you can move the "flags" value into the slot saved
> for the CS segment (which, modulo vm86, will always be at a constant
> offset on the stack), and make CS=0 be the work flag. That will cause the
> CPU to trap atomically at the "iret".

Ingo's low-latency patch put markers around the critical code section,
and inspected the return EIP on the way back out of the interrupt.
If it falls inside the racy region, do special stuff.

-
