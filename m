Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSEPCcm>; Wed, 15 May 2002 22:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSEPCcl>; Wed, 15 May 2002 22:32:41 -0400
Received: from [195.223.140.120] ([195.223.140.120]:17488 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316542AbSEPCcl>; Wed, 15 May 2002 22:32:41 -0400
Date: Thu, 16 May 2002 04:32:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516023238.GE1025@dualathlon.random>
In-Reply-To: <20020516020134.GC1025@dualathlon.random> <Pine.LNX.4.44L.0205152303500.32261-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 11:06:51PM -0300, Rik van Riel wrote:
> On Thu, 16 May 2002, Andrea Arcangeli wrote:
> > On Wed, May 15, 2002 at 07:30:18PM -0300, Rik van Riel wrote:
> > > On Wed, 15 May 2002, Andrea Arcangeli wrote:
> > >
> > > > Only in 2.4.19pre8aa3: 00_ext3-register-filesystem-lifo-1
> > > >
> > > > 	Make sure to always try mounting with ext3 before ext2 (otherwise
> > > > 	it's impossible to mount the real rootfs with ext3 if ext3 is a module
> > > > 	loaded by an initrd and ext2 is linked into the kernel).
> > >
> > > Funny, I've been doing this for months.
> > >
> > > Maybe you should look into pivot_mount(2) and pivot_mount(8)
> > > some day ?
> 
> > First of all there's no pivot_mount but there's only pivot_root (never
> > mind, it is clear you meant pivot_root).
> >
> > Secondly pivot_root has nothing to do with handle_initrd.
> >
> > Go read init/do_mounts.c::handle_initrd. There are only two ways:
> 
> There's a third way, which is used on the initrd of most
> distros:

I'm not using the full blown initrd of most distros that is aware of the
mistery of life and of all the kernel bugs out there too, my own dumb
linuxrc just says:

	echo hello world

and then returns, and ext3 gets mounted as ext2 and that's a kernel bug,
all other fs gets mounted correctly with my initrd, only ext3 gone wrong
until I fixed it.

> --- snip from linuxrc ----
> mount --ro -t $rootfs $rootdev /sysroot
> pivot_root /sysroot /sysroot/initrd
> ------
> 
> This way you can specify both the root fs and - if wanted -
> special mount options to the root fs. Then you pivot_root(2)
> to move the root fs to / and the (old) initrd to /initrd.

both lines are completly superflous, very misleading as well. I
recommend to drop such two lines from all the full blown bug-aware
linuxrc out there (of course after you apply the ordering fix to the
kernel).

About the "special mount options", now since 2.4.19pre if you try to
pass different flags to your mount in linuxrc and the kernel, you will
fail to mount the real root fs, if you want to pass the "if wanted
special mount options" they must be passed via the kernel parameter
only, they cannot be inside the linuxrc knowledge or the kernel mount
will fail.

> 
> The initscripts then umount /initrd, after which the initrd
> data gets freed.

you also need to call flushb /dev/ram0 to free the initrd memory after
umount /initrd, if you do it in userspace without using the automation
in do_mounts.c.

Andrea
