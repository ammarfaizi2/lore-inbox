Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAJX7r>; Wed, 10 Jan 2001 18:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRAJX71>; Wed, 10 Jan 2001 18:59:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:64052 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129511AbRAJX7P>; Wed, 10 Jan 2001 18:59:15 -0500
Date: Thu, 11 Jan 2001 00:59:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010111005924.L29093@athlon.random>
In-Reply-To: <20010110163158.F19503@athlon.random> <200101102209.f0AM9N803486@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101102209.f0AM9N803486@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Jan 10, 2001 at 10:09:22PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 10:09:22PM +0000, Russell King wrote:
> Andrea Arcangeli writes:
> > Furthmore
> > the cast of data to a struct should work on all architectures as far as C is
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > concerned (if you then run alignment problems then it's your mistake).
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> WRONG WRONG WRONG WRONG WRONG.  You are *SO* wrong.
> 
> C explicitly allows this behaviour.  The fact that most processors can load
> unaligned data without any trouble is merely co-incidence and leads to BAD
> programming techniques, like this one illusatrated above.
> 
> Therefore, it is BAD code which needs to be fixed.  Now, on ARM, all
> structures are defined by the ABI to be aligned to a 32-bit word.  End
> of story.  No other story will do.  Finito.  Capisco?
> 
> Yes, you can get around them by taking an alignment abort, but that is REALLY
> REALLY expensive.  Eg, instead of a load taking 1 cycle, it turns into around
> 500 cycles, just to decode the instruction by hand, calculate the addresses,
> calculate the side effects and implement them.

Sure, also alpha and sparc faults on misaligned accesses (on alpha we're nicer
because we emulate them in kernel most of the time). I'm not missing those
alignment issues.

Read again and you'll see that what I said isn't that ARM is broken because
doesn't handle misaligned accesses. What I said is that I can write this C
code:

	int x[2], * p = (int *) (((char *) &x)+1);
	main()
	{
		*p = 0;
	}

This is legal C code. Try compiling this on sparc that bus error on the above
code. The cast works. Works fine. Compiler is happy.

Then when you execute the code the asm will happen to derefernce a misaligned
and it breaks at runtime.

But it's _not_ the cast that is wrong. It's the _usage_ of the cast that is
wrong, and it's your mistake not C's mistake or cast's mistake (and with "your"
I didn't mean Russell's, you obviously care about those issues ;).

Infact the usage of the same below cast will work fine on ARM and sparc too,
but now incidentally on an address that is properly aligned:

	int x[2], * p = (int *) (((char *) &x)+4);
	main()
	{
		*p = 0;
	}

Is it clear now what I said? Capito? ;)

> So, if we can get away with a little BETTER coding technique, then that is
> FAR FAR better than thaning a 499 cycle penalty.

I never suggest you should emulate this in kernel.

> Oh, and did I mention that x86 also has a performance penalty for unaligned
> loads as well?

I know.

> > So for now I backed it out. If you want to push it in again then implement
> > it right and make an mount backwards compatible nfs_fh type for the
> > nfs_mount_data.
> 
> This is pretty gawling, especially as the fix was posted to the NFS
> development list and not one person complained that it would break any APIs.

They missed it.

> I'd like the NFS developers to look at this.  Yes, I'm delegating it.  Why?

No problem, AFIK Andi will take care of it and he will implement the right fix.

However I'd _love_ to see the EIP where you get the fault, I currently don't
see the line of code that is crashing your ARM and I know this code doesn't
segfault on ARM.

        struct x {
                unsigned short x;
                unsigned char c[64];
        };
 
        main()
        {
                struct x x;
                x.x = 0;
		bzero(x.c, 64);	
        }

> And yes, APIs shouldn't break in a major kernel release.  Its a shame some
> API broke in 2.2.18.

What broke in 2.2.18?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
