Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282483AbRLWO2h>; Sun, 23 Dec 2001 09:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286896AbRLWO23>; Sun, 23 Dec 2001 09:28:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3797 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282981AbRLWO2R>;
	Sun, 23 Dec 2001 09:28:17 -0500
Date: Sun, 23 Dec 2001 09:28:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple
 streams file)
In-Reply-To: <3C25A06D.7030408@zytor.com>
Message-ID: <Pine.GSO.4.21.0112230849550.23300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Dec 2001, H. Peter Anvin wrote:

> a) Several different formats; <cpio.h> only documents one of them; I 
> have only found info on that one so some of these things may not apply.

--format=newc and yes, some of them do not apply

> b) No obvious ways to handle hard links, that doesn't require you 
> keeping a table of the inode numbers already seen (at least for which 
> c_nlink > 1) and hard link to them on the decompression side.  Since we 
> have an assymetric setup, it seems like its done at the wrong end.

See below.

> c) The use of TRAILER!!! as an end-of-archive marker (first, it's a 
> valid name, and second, there shouldn't be a need for an end-of-archive 
> marker in this application as long as each individual file is 
> self-terminating thus returning the dearchiver to its ground state.  If 
> we stick with cpio, I would like these entries to have no effect.

No problem.
 
> d) c_rdev, c_uid, c_gid, c_dev, and c_ino are too small, at least in the 
> <cpio.h> format.

32 bits each (and it's major/minor both for dev and rdev, so in effect it's
64 bits).

> e) The use of octal ASCII numbers is somewhat ugly.

hexadecimal, not octal.
 
> f) No ctime, no atime.

For populating root?

> It seems to me that this application doesn't really have a particular 
> need for backward compatibility, nor for the I/O blocking stuff of 
> tar/cpio.  I would certainly be willing to write a set of portable 
> utilities to create an archive in a custom format, if that would be more 
> desirable.  We'd still use gzip for compression, of course, and have the 
> buffer composed as a combination of ".rfs" and ".rfs.gz" files, 
> separated by zero-padding.
> 
> What I'm talking about would probably still look a lot like the cpio 
> header, but probably would use bigendian binary (bigendian because it 
> allows the use of the widely portable htons() and htonl() macros), have 
> explicit support for hard links, and not require a trailer block.

As for the hardlinks...  I'm not sure.  All it takes in uncpio.c is
~30 lines of sparse C.

Trailer block can (and will) be silently ignored by unpacking side.
"TRAILER!!! is a valid name" is true, but hardly serious.

I doubt that extra utilities are worth the effort.  Said that, layout
of the damn thing is nowhere near the top of the list of things that
worry me - as long as it's well-defined, can be handled from userland
and can be easily unpacked I'm OK with it.  What _does_ worry me, though
	* we either need mini-libc of our own or uclibc becomes mandatory
for build (glibc is out of question, dietlibc doesn't support quite a few
architectures we need).
	* getting sane Makefile for init/*
	* getting rid of /{LINUX,DOS} kludge in UMSDOS (code relies on
ROOT_DEV, which adds a lot of PITA)
	* devfs=only needing in effect a search over entire devfs tree (and
yes, that's what it was doing all along)
	* RAID autoconf code (seriously entangled with regular parts of
md.c).

Frankly, holy wars over layout of archive look rather pointless.  _That_
is trivial to change at any point until the moment when it hits the main
tree.  Getting late-boot code clean is the real problem.

