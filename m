Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315814AbSEWCTV>; Wed, 22 May 2002 22:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315823AbSEWCTU>; Wed, 22 May 2002 22:19:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48875 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315814AbSEWCTT>;
	Wed, 22 May 2002 22:19:19 -0400
Date: Wed, 22 May 2002 22:19:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Anders Gustafsson <andersg@0x63.nu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] lvm sanitation in 2.5
In-Reply-To: <20020523011519.GA8521@h55p111.delphi.afb.lu.se>
Message-ID: <Pine.GSO.4.21.0205222153040.4507-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 May 2002, Anders Gustafsson wrote:

> Hi,
> 
> I have started cleaning up lvm. The following patch contains the first
> steps. It disables a lot of functionallity but the basic things are
> there, I'm actually running a kernel with this patch right now, with
> /home and /var on lvm. The vg_t/lv_t..-structures are now available in
> to versions, one exported to userspace (and that should remain
> constant through versions) and one used in kernelspace containing
> stuff that should not be exposed to userspace (struct block_device,
> kdev_t and such). (this also allows more flexibillity making changes
> in the driver without changing the userspace interface). Should i
> finish this patch? Would davej accept it?

That's _very_ nice to see.  I don't know about -dj, but it's definitely
a step in right direction for the main tree.

Other things that need to be done:

a) propagate struct block_device * on the kernel side.  It's not a trivial
change - unlike kdev_t struct block_device * might leak.  So you will need
to add proper refcounting to uses in lvm*.c and from my fighting with
lvm code I can say that it won't be easy.

b) check all copy_{from,to}_user() in lvm for buffer overruns.  The damn thing
is choke-full of them - e.g. it happily assumes that
	n = <get a number from userland>;
	p = (struct foo *)kmalloc(n * sizeof(struct foo), ...);
	if (!p)
		return -ENOMEM;
	for (i = 0; i<n; i++) {
		copy_from_user(p+i, user_p+i, sizeof(struct foo));
		...
	}
is OK.  It isn't - if value of n is slightly above 2^32/sizeof(struct foo)
you will get fairly small argument of kmalloc() (multiplication is done
modulo 2^32) and kmalloc() succeeds, allocating <small amount> instead of
4Gb + <small amount> assumed by the loop below.

(as a sidenote, I have to say that I'm absolutely amazed by the number of
people who manage to fuck up on that one.  A lot of userland code and even
some places in kernels (including several Linux drivers, etc.) contain bugs
of that sort.  It's a _lot_ of buffer overruns - and in the code that is way
more decent than lvm or retchmail.  People, arithmetics is done modulo
2^(number of bits in integer type).  Product of two large numbers can be
small, ditto for sums, etc. and you need to check for overflows of that kind -
nobody else will do that for you).

c) eliminate kdev_t from as much code as possible.  Once (a) is done it will
get easier and will be possible to do piece-by-piece.

Right now the (a) (and, indeed, the unholy mess with copying kdev_t from
userland) is the worst problem.

