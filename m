Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSEZQsm>; Sun, 26 May 2002 12:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316221AbSEZQsk>; Sun, 26 May 2002 12:48:40 -0400
Received: from [195.39.17.254] ([195.39.17.254]:49819 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316217AbSEZQsU>;
	Sun, 26 May 2002 12:48:20 -0400
Date: Sun, 26 May 2002 18:43:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Anders Gustafsson <andersg@0x63.nu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: alloc_struct()? Re: [RFC/PATCH] lvm sanitation in 2.5
Message-ID: <20020526164327.GB269@elf.ucw.cz>
In-Reply-To: <20020523011519.GA8521@h55p111.delphi.afb.lu.se> <Pine.GSO.4.21.0205222153040.4507-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > I have started cleaning up lvm. The following patch contains the first
> > steps. It disables a lot of functionallity but the basic things are
> > there, I'm actually running a kernel with this patch right now, with
> > /home and /var on lvm. The vg_t/lv_t..-structures are now available in
> > to versions, one exported to userspace (and that should remain
> > constant through versions) and one used in kernelspace containing
> > stuff that should not be exposed to userspace (struct block_device,
> > kdev_t and such). (this also allows more flexibillity making changes
> > in the driver without changing the userspace interface). Should i
> > finish this patch? Would davej accept it?
> 
> That's _very_ nice to see.  I don't know about -dj, but it's definitely
> a step in right direction for the main tree.
> 
> Other things that need to be done:
> 
> a) propagate struct block_device * on the kernel side.  It's not a trivial
> change - unlike kdev_t struct block_device * might leak.  So you will need
> to add proper refcounting to uses in lvm*.c and from my fighting with
> lvm code I can say that it won't be easy.
> 
> b) check all copy_{from,to}_user() in lvm for buffer overruns.  The damn thing
> is choke-full of them - e.g. it happily assumes that
> 	n = <get a number from userland>;
> 	p = (struct foo *)kmalloc(n * sizeof(struct foo), ...);
> 	if (!p)
> 		return -ENOMEM;
> 	for (i = 0; i<n; i++) {
> 		copy_from_user(p+i, user_p+i, sizeof(struct foo));
> 		...
> 	}
> is OK.  It isn't - if value of n is slightly above 2^32/sizeof(struct foo)
> you will get fairly small argument of kmalloc() (multiplication is done
> modulo 2^32) and kmalloc() succeeds, allocating <small amount> instead of
> 4Gb + <small amount> assumed by the loop below.


Maybe p = alloc_struct(n, struct foo, GFP_WHATEVER) (and then using
this macro) is right way to tackle this problem?. Or maybe even
alloc_struct(p, n, GFP_WHATEVER)?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
