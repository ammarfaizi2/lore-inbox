Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbSJHXZw>; Tue, 8 Oct 2002 19:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbSJHXVr>; Tue, 8 Oct 2002 19:21:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61963 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263215AbSJHXVP>; Tue, 8 Oct 2002 19:21:15 -0400
Date: Tue, 8 Oct 2002 16:28:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Alexander Viro <viro@math.psu.edu>, Patrick Mochel <mochel@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210081726540.32256-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0210081555030.1505-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Oct 2002, Kai Germaschewski wrote:
> 
> USB may be modular today, and so are many of the other potential users, so 
> we need to deal with that. But it's not only bus drivers, anyway. 
> New-style PCI drivers use pci_register_driver, where struct pci_driver 
> embeds struct device_driver. And the problems are exactly the same.

What problems? As far as I can see, this is fairly trivial to solve. 

But before I solve world hunger and this trivial problem, let's re-iterate 
why it has to be done this way:

 - a ref coutn should always be a count on a "data structure".

 - a reference count is always associated with the _lowest_ form of data 
   structure that is countable. If you reference count high-level 
   entities, then you always have to pass _those_ around, you cannot pass 
   any pointers to sub-structures around because they aren't counted and 
   thus aren't safe.

 - You can get from a high-level object to the lower level (trivially), 
   but you _cannot_ get from the lower level to the high-level simply 
   because the low levels don't even know what _kind_ of object the high
   level is (and if they did, they wouldn't be low-level any more).

The whole point of the devicefs layer is to be able to share a common
structure across any kind of device/driver, so the count has to be at that
level.

Agreed on all of this?

So we have two solutions:

 - don't bother with a common object at all.

   This fundamentally breaks the notion of having a unified device tree. 
   In other words, this isn't an acceptable approach.

 - get the counting right.

The "count right" thing isn't actually all that hard. Every _single_
example of trouble has been of a very simple type: higher layers haven't
been able to look at lower layer counts. And every single of those
examples are trivial to fix, and the only real trouble is finding them and
bothering to fix them.

We have two cases:

 - the high-level thing embeds the low-level thing in a 1:1 
   relationship (ie "struct pci_dev" vs "struct device")

   the high-level entity should avoid having any reference counts itself, 
   and just use the low-level refcount directly, and the low-level thing 
   has a "release()" thing it calls when the refcount goes to zero.

   This is the simple case.

   In particular, the module case could be _made_ into the simple case by 
   just initializing the module counter pointer into the "struct driver" 
   counter (nothing says that the module count has to be inside the 
   "struct module", we could easily make that a pointer to an atomic_t 
   without breaking much code).

 - the high-level thing has _multiple_ low-level things associated with 
   it, each of which have independent refcounts.

   This is, for example the current "module vs struct pci_driver" case,
   where a module might have multiple drivers, but even if it exports only
   one driver, a 1:1 relationship can always be considered just a special
   case of the more generic 1:n case.

Agreed? (Yeah, yeah, we also have the really messy m:n case, but if your 
dependency tree isn't a tree but a DAG, then I think you have more 
problems than you really want to have in the first place).

So let's see how we can solve the complex case, and realize that we
actually _have_ this very same complex case in several parts of the kernel
already. In particular, we have it in "struct dentry" - where the 1:m
relationship is the parent:child relationship.

The simplest way to handle it is to have each low-level entity increment 
the "parent" count for as long as it exists, and then the "release()" 
function de-allocates the memory _and_ it also decrements the count of the 
parent (and releases that if the count goes to zero). We do exactly this 
for dentries, for example (dput() - kill_it).

So in general this is _not_ a hard problem to solve in any way, shape, or
form. The problem with modules is really that the module count is badly
done, and module unloading is crap. This is why we've _always_ had
problems with module unloading, and why Rusty wants to disallow it
altogether.

But modules can already refuse to unload themselves, by just registering a 
"can_unload()" function. 

And that's the short-term answer: make modules that register a driver just 
register a can_unload() function too, and make that function verify that 
the driver count is 1.

You're done. Yes, module unloading is ugly, but don't blame driverfs for 
that.

		Linus

