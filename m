Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbRGKQqT>; Wed, 11 Jul 2001 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbRGKQqJ>; Wed, 11 Jul 2001 12:46:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24148 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267350AbRGKQqF>; Wed, 11 Jul 2001 12:46:05 -0400
Date: Wed, 11 Jul 2001 18:41:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: ralf@gnu.ai.mit.edu, linux-mips@fnet.fr, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: optimised rw-semaphores for MIPS/MIPS64
Message-ID: <20010711184114.I3496@athlon.random>
In-Reply-To: <2508.994860047@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2508.994860047@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Wed, Jul 11, 2001 at 03:00:47PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 03:00:47PM +0100, David Howells wrote:
> Hello Ralf,
> 
> I've produced an inline-assembly optimised Read/Write Semaphore patch for MIPS
> against linux-2.4.7-pre6 (rwsem.diff). David Woodhouse has tested it.

I don't understand why you keep writing code on top of your
mathematically slower rwsem framework.

the C version is much much slower, measured several times.

The asm version has a inferior slow path design that force you having to
do slower and quite tricky stuff in the up_write fast path. This is your
up_write fast path:

		"  movl      %2,%%edx\n\t"
LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
		"  jnz       2f\n\t" /* jump if the lock is being waited upon */

Plus you also clobber %dx in the up_write fast path which I don't need
to.

This is my up_write fast path:

	__asm__ __volatile__(LOCK "subl %2, %0\n\t"
			     "js 2f\n"

Also the design of my xadd slow path looks more readable to me but ok,
I'm biased about that, let's only care about the number of cycles you
have to spend on the fast paths as measure of the goodness of the
algorithm.

I'd suggest arch maintainers to port their rwsem asm optimized fast
paths on top of this patch and to submit me patches:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre5aa1/00_rwsem-14

I also recommend Linus to include the above patch into mainline (it will
reject on the alpha since in pre6 there is the asm optimized version on
top of the slower framework, you can simply temporary disable the asm
optimized version in alpha/config.in and it will compile just fine).

I have an old one from Ivan for alpha which I can just integrate after
auditing and comparison with the one in pre6, the port of the others
should be fairly easy too.

If arch maintainers will do it and it will be included in mainline this
would save me some work and would make the kernel faster.  If it won't
be included again for whatever reason (I got no reply last times) I will
just spend a day on it and I'll port all ports on top of the new code
myself and I'll maintain the faster rwsem in my tree for all archs in
the kernel (possibly with the exception of the ones that are not
converted to the xchgadd asm version yet) as I did so far for x86.

Andrea
