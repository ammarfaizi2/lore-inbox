Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275381AbRJKCHl>; Wed, 10 Oct 2001 22:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274833AbRJKCHc>; Wed, 10 Oct 2001 22:07:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:20444 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275841AbRJKCHQ>;
	Wed, 10 Oct 2001 22:07:16 -0400
Date: Wed, 10 Oct 2001 22:07:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: [RFC] behaviour of stat() variants (was Re: 2.4.11: mount flag noexec
 still broken for VFAT partition)
In-Reply-To: <9q2rhn$77i$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110102146320.21168-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 10 Oct 2001, H. Peter Anvin wrote:

> flags.  Files and directories have syntesized attributes of
> (0777 & ~umask); noexec is supposed to modify that to (0666 & ~umask)
> for files but not directories.
> 
> That has been the Linux behaviour since the 0.x days.

It looks like a horrible kludge, but it can be restored.  Actually, that
brings another issue: stat(2) and friends.

We've got a lot of stat(2) versions.  9 in fs/stat.c are only a small part
of that - there is a plenty in arch/*.  They were mostly copied from
fs/stat.c and by now bitrot gave a lot of breakage - especially in handling
large UIDs and large files.  I have a preliminary patch that cleans that
stuff up and makes very nice tricks possible for filesystems, but it needs
sorting this out - I'm not too happy about guessing the intended behaviour
for dozens of broken stat() versions.  Below is the list (from -ac - one
for Linus' tree is a subset) and I would really like to hear comments from
the maintainers.

I've put here only stat() variants - corresponding l- and f- versions should
obviously behave the same way.  I've written down the current behaviour
(there may be a couple of places where I've been wrong - it had been a
lot of digging through include/asm-*/{stat,types}.h).  What I would like
to see is _intended_ behaviour of these beasts.  Notation:  UID - 16
is "folds to 16 bit", 32 - "stores 32bit value into apparently 32bit field",
truncated - the rest (32 bits into 16 bit field or blindly truncate to
16 bit and store the result).  Size - 64 is "64 bit field", LFS - "stores
into 32bit field if withing limits, -EOVERFLOW otherwise", truncated -
"blindly truncate to 32 bits and store the result".

Some of these are _obviously_ bogus - e.g. on x86-64 _all_ variants of
stat() fold UIDs to 16 bits, on ppc64 all variants available to 64bit
binaries blindly truncate the file sizes to 32 bits, etc.

Folks, please post the intended behaviour for these functions.  Preferably
as corrections to the list below...

function	UID	size

alpha:
sys_newstat	32	64
arm:
sys_newstat	16	LFS
sys_stat64	32	64
cris, i386, m68k, ppc, sh:
sys_stat	16	LFS
sys_newstat	16	LFS
sys_stat64	32	64
sparc:
sys_newstat	16	LFS
sys_stat64	32	64
mips:
sys_stat	32	LFS
sys_newstat	32	LFS
sys_stat64	32	64
irix_xstat	32	LFS
sparc64:
sys_newstat	32	64
sys32_newstat	16	truncated
sys_stat64	32	64
solaris_stat	32	truncated
solaris_stat64	32	64
ppc64:
sys_stat	truncated truncated
sys_newstat	truncated truncated
sys32_stat	16	truncated
sys32_newstat	16	truncated
sys_stat64	32	64
mips64:
sys_stat	32	64
sys_newstat	32	64
sys32_newstat	32	truncated
ia64:
sys_newstat	32	64
sys32_newstat	truncated truncated
ia64_oldstat	16	truncated
x86_64:
sys_newstat	16	64
sys32_newstat	16	truncated
sys32_stat64	16	64
parisc:
sys_newstat	32	64/LFS
hpux_stat64	32	64/LFS
s390:
sys_newstat	16	LFS
sys_stat64	32	64
s390x:
sys_newstat	32	64
sys32_newstat	16	truncated
sys32_stat64	32	64

