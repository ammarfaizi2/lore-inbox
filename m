Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbQKLWbD>; Sun, 12 Nov 2000 17:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131377AbQKLWax>; Sun, 12 Nov 2000 17:30:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31504 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131341AbQKLWas>; Sun, 12 Nov 2000 17:30:48 -0500
Date: Sun, 12 Nov 2000 23:30:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001112233043.C11857@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org> <20001112163705.A4933@athlon.random> <m1bsvlauic.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bsvlauic.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Nov 12, 2000 at 11:57:15AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 11:57:15AM -0700, Eric W. Biederman wrote:
> Nope you rely on cs & ds as well.  cs is just a duh the codes running
> so it must be valid.  But ds is needed for lgdt.

Right. The ds just needs to be valid as cs and ss needs to be valid
as well (for obvious reasons I didn't even mentioned cs needs to be valid).
i386 instead has the dependency to have the selectors in desc.h to be the same
as used by the decompression code, we only need valid ones instead. I think
relying on the decompression code to provide sane segment selectors isn't as
ugly as being dependent on its own private gdt layout.

If I don't want to rely on the ds to be valid to do the lgdt, then I need to
rely on even more stuff dependent on the decompression as i386 does infact,
see? I just prefer to require the decompression code to provide a sane ds/ss
(and cs). I know decompression code returns valid ds/ss and I think current
requirement is the cleaner one and I don't see any problem in doing that.

> I need to retract this a bit.  You are still building a compressed image,

Sure, not compressed images aren't supported (not sure it even worth to support
uncompressed images in the long run as those machines will have _enough_ memory
to decompress the kernel, even my dragonball based PDA has btw :). And
anyways at this point in time what we really care is that a bzImage boots from
floppy at the moment and that works just fine (definitely not by luck).

> Nope.  Though I suspect we should do the switch to 64bit mode in
> setup.S and not have these issues pollute head.S at all.

Only point of head.S is to switch to 64bit with minimal pagetable setup in
place and then to jump in kernel virtual address space to run 64bit C code.

If we do the switch to 64bit in setup.S then we have to change the
decompression code and then the decompression code wouldn't work anymore with
other x86 bootloaders that are not been changed in their "setup.S". So
I'd cosndier it a very bad thing.

Also current head.S has much less pollution than the i386 one IMHO as it's been
rewritten to do only the minimal stuff in asm and a new head64.c is been
created to fixup all the rest in C so that's readable and maintainable and I
hope you enjoy this too ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
