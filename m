Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRALK2k>; Fri, 12 Jan 2001 05:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbRALK2U>; Fri, 12 Jan 2001 05:28:20 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:14598 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129511AbRALK2R>; Fri, 12 Jan 2001 05:28:17 -0500
Date: Fri, 12 Jan 2001 10:27:34 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        List Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: <24827.979266656@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.30.0101121005140.19393-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Keith Owens wrote:

> People need to realise that the problem is initialisation order,
> nothing more, nothing less.  You have to determine and document the
> startup requirements for your code.

This is true. But I'd also agree with the implication which you probably
didn't mean to make there - that initialisation order is a problem. :)

Where an init ordering is required, it must be documented and the
Makefiles set up accordingly. But I believe that we should also try to
avoid requiring such ordering where possible, too.


> It is no wonder that people have problems getting the initialisation
> order correct.

True. And while that situation continues, I desire to avoid the issue
completely by not having any dependencies on init order.

> I want to completely remove this multi layered method for setting
> initialisation order and go back to basics.  I want the programmer to
> say "initialise E and F after G, H and I".  The kernel build system
> works out the directed graph of initialisation order then controls the
> execution of startup code to satisfy this graph.

But the fewer such constraints there are, the better. We don't want
everyone starting to impose unnecessary link order restrictions instead of
thinking about the code a little more and just eliminating them
completely.

> A typical graph would have scsi disk depends on scsi host adaptor group
> which depends on pci.

No. sd will happily take over any existing devices when as and when they
arrive. It doesn't have to be loaded last. Likewise, in theory at least,
host adaptor drivers using the new PCI driver code would respond correctly
to the PCI code being initialised (and calling their ->probe routine)
later, although that doesn't happen now.

Why have these dependencies where they're not necessary?

> Within the scsi host adaptor group you might need to initialise one
> driver before another, so just declare the few inter-driver
> dependencies.

And there are few. And there should _remain_ few. We shouldn't start
imposing link order restrictions on other code which doesn't really need
it.

> Most of the objects have fairly simple execution dependencies, e.g.
> all file systems depend on core fs code having already executed.

Er... Why? They call register_filesystem() which uses a lock which is
staticly initialised. Don't order stuff for the sake of it. If there are
filesystems which _do_ require the VFS to be initialised first, those
filesystems can be marked as such. I'm not aware of any.

> [1] vfat is one obvious exception, it needs dos first.  Also the first
>     few built in file systems must execute in a defined order because
>     that in turn controls the probe order for mount.  But this order
>     should be explicitly declared, not as a side effect of the line
>     order in fs/Makefile.

If the fat_inode_hashtable were staticly initialised, that one wouldn't be
necessary either. But unfortunately that would be quite ugly.

I don't want to get involved in the link order stuff. I would very much
like to avoid having such dependencies. All I want is weak symbols. I
want to call a function directly if it's present, and if not I want to
attempt to load its module. Without having my probe module have a hard
dependency on _all_ the submodules it may decide to ask for.

get_module_symbol() did that for me, and was perfectly acceptable. I
needed to use EXPORT_SYMBOL_NOVERS to export the functions for the
individual command sets. Big deal.

inter_module_get() almost does that for me, but it imposes link order
dependencies, which I want to avoid because I think in this case they're
not necessary. All I want is a way to staticly add entries to the
inter_module_xxx tables at compile time, because I _have_ done the
analysis, and I'm saying that's when they should be made available.

Alternatively, show me how to get weak symbols actually working on all
architectures, and I'll forget the whole thing and be happy.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
