Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316540AbSEPCBj>; Wed, 15 May 2002 22:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSEPCBj>; Wed, 15 May 2002 22:01:39 -0400
Received: from [195.223.140.120] ([195.223.140.120]:13132 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316540AbSEPCBi>; Wed, 15 May 2002 22:01:38 -0400
Date: Thu, 16 May 2002 04:01:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516020134.GC1025@dualathlon.random>
In-Reply-To: <20020515212733.GA1025@dualathlon.random> <Pine.LNX.4.44L.0205151929430.32261-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 07:30:18PM -0300, Rik van Riel wrote:
> On Wed, 15 May 2002, Andrea Arcangeli wrote:
> 
> > Only in 2.4.19pre8aa3: 00_ext3-register-filesystem-lifo-1
> >
> > 	Make sure to always try mounting with ext3 before ext2 (otherwise
> > 	it's impossible to mount the real rootfs with ext3 if ext3 is a module
> > 	loaded by an initrd and ext2 is linked into the kernel).
> 
> Funny, I've been doing this for months.
> 
> Maybe you should look into pivot_mount(2) and pivot_mount(8)
> some day ?

I'm not sure if you really understood what the problem is from my
description above because your kind suggestion doesn't make sense to me.

First of all there's no pivot_mount but there's only pivot_root (never
mind, it is clear you meant pivot_root).

Secondly pivot_root has nothing to do with handle_initrd.

Go read init/do_mounts.c::handle_initrd. There are only two ways:

1) you specified rootfstype=ext3, then the real rootfs will be
   mounted as ext3 and not as ext2, but the initrd must also
   be mountable by ext3 and that's not the case normally (the same
   rootfstype will apply to both the initrd and the real root fs,
   the fact rootfstype applies to both doesn't make sense but
   that's another issue and I don't want to be forced to use
   rootfstype anyways, I don't like having to pass an argument for
   something that can be done at runtime by the kernel).
2) you didn't specified rootfstype=, in such case ext2 will be
   tried first because it got registered first because ext2 is linked
   into the kernel and ext3 is a module

That's all, and that's an autodetection bug because ext3 must be always
tried first, there's no point at all to try to mount with ext2 before
ext3 (of course unless rootfstype= is specified).

If it works for you it means you regularly reboot with SYSRQ+B (or
some workaround on those lines), and so ext2 doesn't mount
and in turn ext3 is later tried. otherwise if ext2 mounts cleanly ext3
is _never_ tried and you cannot mount ext3 as rootfs without my patch
that enforces the ordering.

Make sure to check with /proc/mounts that your rootfs is really using
ext3 and not ext2, or you may not notice.

If it works for you it's probably because ext2 is a module too, or maybe
more simply because ext3 is linked into the kernel.

Andrea
