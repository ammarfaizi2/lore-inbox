Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSFKQy7>; Tue, 11 Jun 2002 12:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSFKQy6>; Tue, 11 Jun 2002 12:54:58 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:57872 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317184AbSFKQy4>; Tue, 11 Jun 2002 12:54:56 -0400
Date: Tue, 11 Jun 2002 17:54:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Double quote patches part one: drivers 1/2
Message-ID: <20020611175446.E3665@flint.arm.linux.org.uk>
In-Reply-To: <20020611114344.B3081@flint.arm.linux.org.uk> <20020611084758.B1346@flint.arm.linux.org.uk> <Pine.LNX.4.44.0206110422110.24261-100000@hawkeye.luckynet.adm> <20020611114344.B3081@flint.arm.linux.org.uk> <5812.1023808616@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 04:16:56PM +0100, David Woodhouse wrote:
> Or were you _really_ advocating the kind of development methodology which

Not at all.  You can sometimes sanely re-organise and optimise your C
code to produce better assembly without affecting its readability too
much.

> Tweaking your code and sacrificing chickens until you happen to get the
> output you want is no substitute for fixing the compiler.

"Fixing the compiler" for ARM would entail getting a degree in compiler
design, and rewriting GCC from scratch.  GCC *really* isn't suited to
ARM CPUs at all.  It sucks.  The fact that earlier GCC versions sucked
less is the really interesting thing here...

GCC 3.1 is a hard compiler to find stuff wrong with (unlike previous
versions - well done gcc people!)  However, here's a good example of a
bit of madvise_fixup_start, built for Xscale with a 5-stage instruction
pipeline with branch prediction.

It's from mm/filemap.c, setup_read_behaviour (inline function inside
madvise_fixup_start).

1. The C code:

        VM_ClearReadHint(vma);
        switch(behavior) {
                case MADV_SEQUENTIAL:
                        vma->vm_flags |= VM_SEQ_READ;
                        break;
                case MADV_RANDOM:
                        vma->vm_flags |= VM_RAND_READ;
                        break;
                default:
                        break;
        }

2. GCC 3.1 output with -O2 on ARM:

        ldr     r3, [r4, #20]
        cmp     r6, #1
        bic     r3, r3, #98304
        str     r7, [r4, #8]
        str     r3, [r4, #20]
        beq     .L803			<=== branch if equal
        cmp     r6, #2
        orreq   r3, r3, #32768
        beq     .L811			<=== branch if equal
.L806:
        ldr     r0, [r4, #56]
...
        b       .L809
.L811:
        str     r3, [r4, #20]
        b       .L806			<=== unconditional branch
.L803:
        orr     r3, r3, #65536
        b       .L811			<=== unconditional branch

   This gives the following instruction path lengths:
	neither:	10 (no branches)
	first:		11 (3 branches)
	second:		12 (2 branches)

   -Os doesn't make much difference.

3. My human-based optimised output for ARM is:

        ldr     r3, [r4, #20]
        cmp     r6, #1
        bic     r3, r3, #98304
        str     r7, [r4, #8]
        orreq   r3, r3, #65536
        beq     .L806			<=== branch if equal
        cmp     r6, #2
        orreq   r3, r3, #32768
.L806:
        str     r3, [r4, #20]
        ldr     r0, [r4, #56]
...
        b       .L809

   This gives the following instruction path lengths:
	neither:	10 (no branches)
	first:		8  (3 branches)
	second:		10 (2 branches)

Any way you look at it, the above has got to be better.

We can probably get something very close to (3) out of gcc by doing
something like:

	unsigned long flags;

	flags = vma->vm_flags & ~(VM_SEQ_READ|VM_RAND_READ);
        switch(behavior) {
                case MADV_SEQUENTIAL:
                        flags |= VM_SEQ_READ;
                        break;
                case MADV_RANDOM:
                        flags |= VM_RAND_READ;
                        break;
                default:
                        break;
        }
	vma->vm_flags = flags;

No gotos required.  So, what about VM_ClearReadHint()?  It turns out
that its only used in once place - setup_read_behaviour().  Now, with
the above, we end up with the following output from the same version
of gcc with -O2:

        ldr     r3, [r4, #20]
        cmp     r6, #1
        bic     r3, r3, #98304
        str     r7, [r4, #8]
        orreq   r3, r3, #65536
        beq     .L801
        cmp     r6, #2
        orreq   r3, r3, #32768
.L801:
        ldr     r0, [r4, #56]
        str     r3, [r4, #20]

All I've shown above is how GCC can miss some optimisations its easy
for a human to see, and there are some simple ways to rewrite C code
to allow GCC to make those optimisations.  But hey - that's nothing
new.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

