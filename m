Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261173AbRELEAC>; Sat, 12 May 2001 00:00:02 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261165AbRELD7t>; Fri, 11 May 2001 23:59:49 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49800 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261162AbRELD5s>;
	Fri, 11 May 2001 23:57:48 -0400
Date: Sat, 12 May 2001 04:54:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
Message-ID: <20010512045456.E8259@athlon.random>
In-Reply-To: <20010511162745.B18341@sistina.com> <E14yDyI-0000yE-00@the-village.bc.nu> <20010511171124.M30355@athlon.random> <15100.18375.367656.3591@pizda.ninka.net> <20010512032453.A8259@athlon.random> <15100.37367.477922.66043@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15100.37367.477922.66043@pizda.ninka.net>; from davem@redhat.com on Fri, May 11, 2001 at 06:29:27PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 06:29:27PM -0700, David S. Miller wrote:
> I think that's a bad decision, but it is your's.

Let me put it this way: after I get the first real life request from an
user with an useful case where a 32bit app needs to run the lvm ioctl it
will be truly easy to change my mind about that, I just don't expect to
get that request anytime soon because the only thing that runs the lvm
ioctl are the lvmtools, and I assume Andi thought the same when he
originally proposed not to support the lvm ioctl from the 32bit
userland. If you just have in mind something of useful that needs that
please let us know and we will definitely listen to you.

Of course not implementing the 32bit lvm ioctl emulation now, in any
case won't forbid us to implement it in the next 5 minutes, we can do
that anytime if/when we find the first useful case that needs that, it's
just a matter of cut and pasting from the ioctl32.c of sparc64 to the
x86-64 tree and then to spend one day of hacking and testing through
those pointer conversions, being aware that this work will break in the
next two weeks when a new lvm ioctl is added in the next lvm release, or
something like that, you _must_ know very well what the mainteinance of
that code means ;).

BTW, it would be nice if somebody would take care of unifying the
large sharable parts of the emulation code between
x86-64/sparc64/ia64/mips64, this was mentioned by Andi several times but
nothing is been done in that direction yet, they for large part do the
same things and somehow we duplicate efforts across all those ports (if
we exclude the regs maniuplation in the ELF_PLAT_DATA and friends that
can be localized easily). If we do that kind of sharing all the other
ports would probably get the 32bit emulation for the lvm ioctl for free
from the sparc64 effort for example.

> To me, either you support fully the 32-bit execution
> environment or you do not.  After all the work that
> myself and others have done for other platforms, there
> really is no need to cut corners in this area.
>
> My userland on sparc64 is %100 32-bit and everything works
> quite beautifully.

The sparc platform is a completly different matter, you cannot compare
sparc64 to x86-64, on sparc64 the 64bit userspace is a very recent thing
(just to make an example my sparc64 still runs only with the 32bit
userspace and I use the 64bit compiler only for the kernel, I don't know
if you have a total 64bit userspace either).  For sparc64 a 64bit-only
lvmtools would been a very nasty dependency and so for sparc64 it is
almost mandatory to support completly all the ioctls from the 32bit
userland.

On x86-64 the only reason for having a program 32bit is because it's
either binary only, or if you need to reduce the memory footprint and
you don't need more than 4G of address space [btw all the binaries
running in compatibility mode on the x86-64 kernel will get 4G of
address space, 1G more than with a ia32 kernel].  lvmtools are GPL'd and
the memory footprint of the lvmtools is absolutely worthless to
consider. So there's no point to compile the lvmtools 32bit, period.

And I think your "everything works quite beautifully" on sparc64 isn't
really the case if you upgrade to a recent lvm revision unless you fixup
all the 32bit ioctl emulation first, the reason we want "everything
works beautifully and always" is the main reason we try to avoid the lvm
ioctl 32bit emulation ;), at least with the current lvm user<->kernel
design.

Furthmore if somebody post a patch that implements the ioclt wrappers
even if there isn't an useful case that needs them, I will be glad to
checkin that code after adding a fat warning in the source that says it
can break anytime. the lvm ioctl can be run only by the administrator so
it won't be a security breach if they breaks when the drivers/md/lvm*
code gets updated and what I will do in my box will be to compile the
lvmtools with a plain `make` anyways, so my lvmtools will run 64bit
anyways and I will never test that wrappers myself (and after some time
they remains broken I will end putting an #if 0 /* FIXME */ around the
wrappers to avoid somebody getting bitten by that code).

So in short to me it sounds a good decision and also a no brainer one
that we can change anytime if we need to.

Andrea
