Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSKBUSD>; Sat, 2 Nov 2002 15:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbSKBUSD>; Sat, 2 Nov 2002 15:18:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29858 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261393AbSKBUSB>;
	Sat, 2 Nov 2002 15:18:01 -0500
Date: Sat, 2 Nov 2002 15:24:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Aaron Lehmann <aaronl@vitelus.com>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>, hpa@zytor.com
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
In-Reply-To: <Pine.LNX.4.44.0211021049480.2413-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211021436200.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Linus Torvalds wrote:

> Note that the reason I personally really want initramfs is not to make the
> kernel boot image smaller, or the kernel sources smaller. That won't
> happen for a long time, since I suspect that we'll be carrying the
> initramfs user space with us for quite a while (eventually it will
> probably split up into a project of its own, but certainly for the
> forseeable future it would be very closely tied to the kernel).
> 
> The real advantage to me is two-fold:
[snip]

Let me add the third one: userland is more limited.  And no, that's not
a typo - and it's a good thing.  Userland has to use normal, regular
syscalls instead of poking its fingers into hell knows what parts of
kernel data structures.

Which means that it's more robust and that it doesn't stand in the way
of work on kernel.  90% of PITA with super.c used to be of that kind -
mounting root filesystem had been done with very ugly kludges and what's
more, these kludges got filtered down in the normal codepath.  Getting
rid of that took a _lot_ of very careful manipulations with the guts
of the thing.  And guess what?  There was no reason why all that black
magic would be necessary - current code uses normal, garden-variety
system calls.

In effect, we used to have special cases of mount(2), etc., with very
kludgy semantics.  They were not exposed to userland, but that didn't
make them less nasty or less painful to work with.  They still cluttered
the code, they still stood in the way of work on the thing and they still
were butt-ugly.

And that's what moving code to userland should prevent - it's much easier
to catch somebody bringing a patch with magical extension of system call
than to catch an attempt to sneak special-case code used only by kernel.

BTW, that's a thing we need to watch for - there obviously will be a lot
of patches moving stuff to userland and there will be a strong temptation
to add magic interfaces just for that.  _That_ should be prevented - it's
better to leave ugly crap as is than export the same crap to userland.
The point is to get the things cleaned up and make sure that they stay
clean, not to cement them in place by adding a magic ioctl/syscall/flag/whatnot.
We may very well end up extending existing interfaces, but we'd damn better
make sure that such additions make sense for generic use.

We have a lot of ugly crap that would be unnecessary if we had early
access to writable fs.  Basically, we got magic methods, magic codepaths,
etc. simply because the normal access to the functionality in question
required opened file descriptors.  Now we _do_ have a writable filesystem
mounted very early, so that cruft can be killed off.  And moving code
to userland acts as a filter - there we don't have access to magic, so
all such magic immediately shows up.  It could be done in the kernel
(and quite a few things had been done already), but move to userland
acts as a safeguard against reintroduction of magic crap.

