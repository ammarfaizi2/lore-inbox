Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWEFWEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWEFWEx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 18:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWEFWEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 18:04:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21731 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932089AbWEFWEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 18:04:52 -0400
Date: Sat, 6 May 2006 23:04:51 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: minixfs bitmaps and associated lossage
Message-ID: <20060506220451.GQ27946@ftp.linux.org.uk>
References: <44560796.8010700@gmail.com> <20060506162956.GO27946@ftp.linux.org.uk> <20060506163737.GP27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506163737.GP27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Warning: text below is a mild example of software coproarchaeology,
so if you are easily squicked by tangled mess of bugs and dumb lossage,
well... you've been warned.

	This particular clusterfsck had begun when AST decided to
store the metadata in host-endian order.  All of it; inode numbers
in directories, block numbers in inodes and indirect blocks, etc.
Ugly as it was, it would be more or less straightforward, if not
for one trap - the bitmaps.

	The rest of metadata had obvious element sizes, so it was hard
to get wrong.  However, for bitmaps it was arbitrary.  And it does
matter - mapping an array of bits to array of big-endian 16bit and
to array of big-endian 32bit gives different results.  We get either
	8-15, 0-7, 24-31, 16-23, ...
or
	24-31, 16-23, 8-15, 0-7, ...
resp.  For little-endian we get the same thing, though.  AST had chosen
to make it an array of 16-bit host-endian.

	Linux had minixfs support from the very beginning, but it started
on little-endian hosts, so that issue had been happily ignored - le16
or le32, you get the same result.  The second architecture to be merged
also had been little-endian (alpha), so it didn't cause any new problems.
fs/minix/inode.c used clear_bit(), etc. for bitmap access, which assumes
array of unsigned long in host-endian.

	Then it had hit the fan, but nobody cared - sparc merge was 1.1.77,
but I'm not sure if minix even existed on sparc at that point.  And it
sure as hell was not a concern with respect to sharing fs.  Same for mips
merge in 1.1.82 and ppc one in 1.3.45.

	The next one was m68k in 1.3.94.  And there it became serious - m68k
boxen with both minix and Linux on them did exist.  So behaviour of mainline
minixfs was a real problem - it would eat filesystems if it would ever build
and run.  m68k tree had that fixed, though, by providing minix_test_bit()
et.al. that did the right thing.  As always with m68k, "fixed" and "cared
to put the fix into mainline" had been rather... loosely coupled events.

	When the fix did go into the mainline (2.1.17), it had created an
interesting situation:
	* i386 and alpha: minix_test_bit() and friends added as wrappers
	* m68k: added, do the right thing.
	* sparc, mips and ppc: helpers absent, won't build with CONFIG_MINIX_FS

The real trouble was that the only non-trivial implementation had not been
documented - not even to say what it does and why it's needed.  So when the
folks on other platforms started to fix the breakage, results had been ugly:
	- sparc: blindly defined as on i386 - i.e. host-endian 32bit (== be32).
Compiles, still broken.
	- mips: defined as on i386 with bloody misguiding comment:
* FIXME: These assume that Minix uses the native byte/bitorder.
It _does_ use the native byte order.  It's chunk size that doesn't match
the native word size.  Overall: be32.
	- ppc: perhaps due to the second-hand confusion induced by mips
comment, perhaps independently, ppc went with _little-endian_ 32bit.
	- sparc64: blindly copied as on i386.  That meant yet another variant:
host-endian 64bit (== be64).

After that it went uglier and uglier.  Little-endian architectures were
still all right, but big-endian had done everything except the correct
behaviour.  Some did like ppc and used little-endian bitmaps.  Some did
be32.  Some be64.  The _ONLY_ big-endian that does the right thing is
m68k.  Everything else is using layouts that never would be recognized
by minix - on any platform.  Again, we are paying for the lack of
description of original minix_..._bit() family - and for the original
mess in minix fs layout.

	Minix recognizes two layouts:
16bit values	32bit values	bitmaps
01		0123		01234567...
10		3210		10325476...
	Little-endian architectures on Linux follow the first variant.
m68k follows the second one.  ppc, parisc and big-endian arm and frv do
10		3210		01234567...
The rest of 32bit big-endian goes with
10		3210		32107654...
and 64bit big-endian do
10		3210		76543210...

	In effect, we've got three new layouts, thanks to aforementioned
lossage.  But it gets even funnier: filesystem has to be created, after
all.  And _that_ is not just broken, it's broken differently.  We have:
	little-endian:	layout 1 (correct)
	m68k:		layout 2 (correct)
	everything else:layout 3
Of course, native minix mkfs always creates (1) or (2) and native minix
fsck gets quite unhappy with anything else.  Amusingly enough, debian
util-linux has mkfs.minix and fsck.minix excluded on sparc, so the
problem _was_ noticed and duly papered over.

	Recently all that crap got "regularized" kernel-side.  About the
only effect was the loss of some warnings along the lines of "something's
fishy here".

	So...  What the hell can we do?  Layouts (4) and (5) are clearly
broken and _never_ worked - there's nothing that would manage to create
such filesystem.  So these are obvious candidates for switching - either
to (2) (correct) or to (3) (broken, but at least match util-linux fsck.minix
and mkfs.minix on such platforms).  The question being, what do we do with
(3) (big-endian metadata, little-endian bitmaps) and what do we do with
Linux fsck.minix?  Aside of repeating the mantra, that is ("All Software
Sucks, All Hardware Sucks")...
