Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136591AbREAIQo>; Tue, 1 May 2001 04:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136592AbREAIQe>; Tue, 1 May 2001 04:16:34 -0400
Received: from pille.addcom.de ([62.96.128.34]:2322 "HELO pille.addcom.de")
	by vger.kernel.org with SMTP id <S136591AbREAIQY>;
	Tue, 1 May 2001 04:16:24 -0400
Date: Tue, 1 May 2001 10:16:44 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] [PATCH] automatic multi-part link rules (fwd)
In-Reply-To: <20010501013120.A15120@werewolf.able.es>
Message-ID: <Pine.LNX.4.33.0105010944370.24511-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, J . A . Magallon wrote:

> On 05.01 Keith Owens wrote:
> >
> > The patch appears to work but is it worth applying now?  The existing
> > 2.4 rules work fine and the entire kbuild system will be rewritten for
> > 2.5, including the case you identified here.  It struck me as a decent
> > change but for no benefit and, given that the 2.4 kbuild system is so
> > fragile, why not live with something we know works until 2.5 is
> > available?

Well, yes, that's an argument. However, I don't think it's hard to verify
that my patch works as well, it's about ten lines added to Rules.make.
It's particularly easy to verify that it doesn't change behavior for
objects listed in $(list-multi) at all.

> We will have to live with 2.4 until 2.6, 'cause 2.5 will not be stable.
> 2.4 will be the stable and non "brain damaged" kernel in distros.
> So every thing that can make 2.4 more clean, better. Think in 2.4.57,
> and we still are in 4. And feature backports, and new drivers...
> The 2.5 rewrite is not excuse. The knowledge on the actual state, yes.

Yes, 2.4 will be around for a long time from now. Of course, no
experimental changes should be done now, but cleanup patches are applied
all the time now. Or are you arguing that we shouldn't include patches
which fix the compiler warnings either, just because it's proven that the
current behavior works?

Anyway, I also have the additional argument that the patches fixes at
least theoretical bugs, because it adds flags handling for the link rules.
I don't know if it ever happens, but one can imagine a case where foo-objs
= foo1.o foo2.o, or foo-objs = foo1.o foo2.o foo3.o, respectively,
depending on some config option. So if you go from the latter config to
the former and rebuild, foo.o won't get relinked, you end up with the old
version.

Also, the patch allows you to rewrite e.g. fs/ext2/Makefile from
---
obj-y    := acl.o balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
                ioctl.o namei.o super.o symlink.o
obj-m    := $(O_TARGET)
---
to
---
obj-$(CONFIG_EXT2_FS)   += ext2.o

ext2-objs               := acl.o balloc.o bitmap.o dir.o file.o fsync.o \
                           ialloc.o inode.o ioctl.o namei.o super.o symlink.o
---

which fixes another fragile aspect of the current Makefiles, which you
complained about yourself: make SUBDIRS=fs/ext2 is currently broken w.r.t
to compilation flags.

--Kai




