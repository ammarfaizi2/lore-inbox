Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266651AbSISMyD>; Thu, 19 Sep 2002 08:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSISMyD>; Thu, 19 Sep 2002 08:54:03 -0400
Received: from dp.samba.org ([66.70.73.150]:42724 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266651AbSISMyB>;
	Thu, 19 Sep 2002 08:54:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Thu, 19 Sep 2002 12:44:47 +0200."
             <Pine.LNX.4.44.0209191134360.28515-100000@serv> 
Date: Thu, 19 Sep 2002 22:51:58 +1000
Message-Id: <20020919125906.21DEA2C22A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209191134360.28515-100000@serv> you write:
> Hi,
> 
> On Thu, 19 Sep 2002, Rusty Russell wrote:
> 
> > > I agree that the module load mechanism could be simplified, but why do yo
u
> > > want to do it in the kernel?
> >
> > Count the total lines of code in the kernel.  It's less than it was
> > before.  Even for ia64, it's around the same IIRC.
> 
> That's not really difficult.

I know, I've done it for 5 architectures.

> > Now add the userspace code, and it's obviously far simpler.  Not to
> > mention not having to worry about problems like insmod dying between
> > the two system calls...
> 
> A dying insmod is not really a problem. Removing the module after the
> create call isn't a problem (I think that was already possible in my
> version). Your current relocation code can be easily moved to userspace. I
> agree that it can be far simpler, but doing two instead of one system call
> doesn't really add any complexity.

Of course it does.  Logically there should be a lock between the two
operations: it's effectively an upcall to userspace, and that's messy.

> > I'm all for keeping things out of the kernel, but you can take things
> > too far.  I was originally reluctant, but the beauty and simplicity of
> > doing it in-kernel changed my mind.
> 
> Compared to the complexity of the current insmod I can I agree. On the
> other hand with my module layout, I could load a module with ld and a few
> lines of shell script (only the system calls are a bit tricky).

Do that on sparc64, x86_64 or ppc64 and I'll be really impressed.  And
of course, good luck fitting libbfd into busybox!

> > > Most of the module related changes are rather cosmetic. You still have to
> > > spread try_module_get() calls all over the kernel, one has to call it
> > > before calling a function which might sleep, this means we will add it
> > > everywhere just to be save.
> >
> > Yes.  It should be added everywhere.  One idea is to mark interfaces
> > which are "safe", and if a module uses something else, refuse to
> > unload it.
> 
> Now we get to the interesting part, cleaning up the module code is rather
> simple to do, but getting everything else safe will be a bit more work and
> how nicely it's done depends very much on which interfaces the module code
> offers.

Yes, see latest patchball (to follow).

> > > What makes it worse is that it's not generally usable, a per object
> > > reference count can also be used for module management, but the
> > > module count can't be used for object management. This means for
> > > modules with more dynamic interfaces, they have to do twice as much
> > > work.
> >
> > Yes, you force reference counts in everything, whether you've got
> > modules (or module unloading) or not.  You *do not* want to do this,
> > for performance reasons if nothing else.
> 
> What else is try_module_get()? What is your problem with reference counts?

Incrementing and decrementing a reference count for every network
protocol (think: one for IPv4, one for TCP) is going to do terrible
things for performance.  Now, if we *only* do it when IPv4 is a
module, *and* we use bigrefs (which take about a page each 8(), it's
not so bad.

> Let's look again at the fs example I posted earlier:
> 
> static int __init init_fs(void)
> {
>         inode_cachep = kmem_cache_create(...);
>         if (!inode_cachep)
>                 return -ENOMEM;
>         return register_filesystem(&fs_type);
> }
> 
> static int __exit exit_fs(void)
> {
>         int err;
>         err = unregister_filesystem(&fs_type);
>         if (err)
>                 return err;
>         kmem_cache_destroy(inode_cachep);
>         inode_cachep = NULL;
>         return 0;
> }
> 
> Is this difficult to understand? I'n in doubt of this.

This still has the init problem (well, not this example but...)

Try doing this with IPv4, or LSM.

If every single object in the kernel is reference counted, *yes* you
can do this.  But they're not, and they will never be.  Changing them
over to use try_module_get() is feasible, though.

Of course, we could just say "you can't unload those module then!" and
all those problems disappear.  You can see why I was so tempted 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
