Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268362AbRG3GGa>; Mon, 30 Jul 2001 02:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268359AbRG3GGV>; Mon, 30 Jul 2001 02:06:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39822 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S268351AbRG3GGD>;
	Mon, 30 Jul 2001 02:06:03 -0400
Date: Mon, 30 Jul 2001 02:05:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org
Subject: [CFT] initramfs patch
Message-ID: <Pine.GSO.4.21.0107300137550.16140-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	Folks, IMO initramfs (aka. late boot in userland) is suitable
for testing.

Patches are on ftp.math.psu.edu/pub/viro, namespaces-a-S8-pre2 and
initramfs-a-S8-pre2 (the latter is against 2.4.8-pre2 + namespaces).

It is supposed to be a drop-in replacement - any boot setup that works
with vanilla 2.4 should work with it, initrd or not, with or without devfs,
with loading from floppies, etc.

In other words, if you boot normally with 2.4 and something breaks with
initramfs - I want to know about that.

Stuff that went in userland: choosing and mounting root, unpacking/loading
initrd, running /linuxrc, handling nfsroot, finding and starting final
init - basically, everything after do_basic_setup().

The thing unpacks cpio archive (currently - linked into the kernel image)
on root ramfs and execs /init. After that we are in userland code. Said
code (source in init/init.c and init/nfsroot.c) emulates the vanilla
2.4 behaviour. You can replace it with your own - that's just the default
that gives (OK, is supposed to give) a backwards-compatible behaviour.

Thing that had not gone into the userland, but should be there: ipconfig.c.
If somebody feels like writing a userland equivalent - I'd be very
grateful to see it. Currently it's still in the kernel.

Another thing that is definitely needed is less crude RPC (for nfsroot).
Currently it's _very_ quick-and-dirty.

At that stage I'm mostly interested in bug reports regarding the cases
when behaviour differs from the vanilla tree. I _know_ that we need more
elegant way to add initial archive to the kernel image. That's a
separate issue and I'd rather deal with that once userland implementation
of late-boot is decently debugged.

Right now it's x86-only, but that's the matter of adding minimal replacement
of crt1.o for other platforms (i.e. code that picks argc, argv and envp
and calls main() - 7 lines of assembler for x86 and probably about the
same on other platforms). Equivalents of arch/i386/kernel/start.S (see
the patch) are welcome.

It should be pretty safe to debug, for a change - it either gets to
starting /sbin/init (in which case we are done and safe) or it breaks
before any local fs is mounted r/w.

Linus, I'm not putting these patches in the posting - each of them is
above 100Kb and that's way beyond any sane l-k limits. If you want
to get them in email - tell and I'll send them. And yes, I'm going
to split this stuff in small chunks when it will come to submitting
it.
								Al

