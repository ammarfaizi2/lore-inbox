Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271093AbSISKkG>; Thu, 19 Sep 2002 06:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271105AbSISKkG>; Thu, 19 Sep 2002 06:40:06 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:49418 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S271093AbSISKkE>; Thu, 19 Sep 2002 06:40:04 -0400
Date: Thu, 19 Sep 2002 12:44:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: kaos@ocs.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020919020654.9B68E2C04C@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209191134360.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Sep 2002, Rusty Russell wrote:

> > I agree that the module load mechanism could be simplified, but why do you
> > want to do it in the kernel?
>
> Count the total lines of code in the kernel.  It's less than it was
> before.  Even for ia64, it's around the same IIRC.

That's not really difficult.

> Now add the userspace code, and it's obviously far simpler.  Not to
> mention not having to worry about problems like insmod dying between
> the two system calls...

A dying insmod is not really a problem. Removing the module after the
create call isn't a problem (I think that was already possible in my
version). Your current relocation code can be easily moved to userspace. I
agree that it can be far simpler, but doing two instead of one system call
doesn't really add any complexity.

> I'm all for keeping things out of the kernel, but you can take things
> too far.  I was originally reluctant, but the beauty and simplicity of
> doing it in-kernel changed my mind.

Compared to the complexity of the current insmod I can I agree. On the
other hand with my module layout, I could load a module with ld and a few
lines of shell script (only the system calls are a bit tricky).

> > Most of the module related changes are rather cosmetic. You still have to
> > spread try_module_get() calls all over the kernel, one has to call it
> > before calling a function which might sleep, this means we will add it
> > everywhere just to be save.
>
> Yes.  It should be added everywhere.  One idea is to mark interfaces
> which are "safe", and if a module uses something else, refuse to
> unload it.

Now we get to the interesting part, cleaning up the module code is rather
simple to do, but getting everything else safe will be a bit more work and
how nicely it's done depends very much on which interfaces the module code
offers.

> > What makes it worse is that it's not generally usable, a per object
> > reference count can also be used for module management, but the
> > module count can't be used for object management. This means for
> > modules with more dynamic interfaces, they have to do twice as much
> > work.
>
> Yes, you force reference counts in everything, whether you've got
> modules (or module unloading) or not.  You *do not* want to do this,
> for performance reasons if nothing else.

What else is try_module_get()? What is your problem with reference counts?
First of all only people _exporting_ symbols have to think about module
races, most drivers should just use interfaces, which are module safe.
Let's look again at the fs example I posted earlier:

static int __init init_fs(void)
{
        inode_cachep = kmem_cache_create(...);
        if (!inode_cachep)
                return -ENOMEM;
        return register_filesystem(&fs_type);
}

static int __exit exit_fs(void)
{
        int err;
        err = unregister_filesystem(&fs_type);
        if (err)
                return err;
        kmem_cache_destroy(inode_cachep);
        inode_cachep = NULL;
        return 0;
}

Is this difficult to understand? I'n in doubt of this.
This is simple resource management, everyone writing kernel code has to do
this anyway, adding modules to this picture doesn't change it much. As
long as you have control over all your objects, you also know easily
whether it's safe to unload or not, but only the driver knows this, the
module code can only guess or it has to be told explicitely via
try_module_get().

bye, Roman

