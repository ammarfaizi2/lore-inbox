Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319466AbSIMKcQ>; Fri, 13 Sep 2002 06:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319468AbSIMKcQ>; Fri, 13 Sep 2002 06:32:16 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:773 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319466AbSIMKcO>; Fri, 13 Sep 2002 06:32:14 -0400
Date: Fri, 13 Sep 2002 12:35:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, Daniel Phillips <phillips@arcor.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface 
In-Reply-To: <20020913015502.1D43F2C070@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209131131210.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Rusty Russell wrote:

> > I'm aware of the init problem, what I described was the core problem,
> > which prevents any further cleanup.
>
> I don't think of either of them as core, they are two problems.

Your init problem is easily solvable for try_inc_mod_count() users, just
add a check for MOD_INITIALIZING, so it will fail during module init. On
the other hand forcing everyone to use try_inc_mod_count is a serious
problem.

> > able to answer is: Are there any objects/references belonging to the
> > module? It's a simple yes/no question. If a module can't answer that, it
> > likely has more problem than just module unloading.
>
> Ah, we're assuming you insert synchronize_kernel() between the call
> to stop and the call to exit?
>
> In which case *why* do you check the use count *inside* exit_affs_fs?
> Why not get exit_module() to do "if (mod->usecount() != 0) return
> -EBUSY; else mod->exit();"?
>
> There's the other issue of symmetry.  If you allocate memory, in
> start, do you clean it up in stop or exit?  Similarly for other
> resources: you call mod->exit() every time start fails, so that is
> supposed to check that mod->start() succeeded?

Actually I consider removing the start/stop methods, if one can't get it
right without them, one won't get it right with them either and it's easy
enough to add them later again.
The exit function should always be called after the init function (even if
it failed, I don't do it in the patch, that's a bug). The fs init/exit
would like this then:

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

> I disagree with pushing the count into the filesystem structure: it
> changes nothing except hide the fact that you're only keeping
> reference counts for the sake of the module.  Filesystems are low
> performance impact, but other subsystems really don't want that atomic
> inc and dec for every access.

As I already said before, it doesn't has to be an atomic reference count.

> 	if (down_interruptible(&module_mutex))
> 		return -EINTR;

I really don't like that the global module lock is held during calls to
the driver, e.g. it makes it impossible to request further modules during
module load.

> This works better for my in ip_conntrack, since ideally the usage
> count is a count of the number of packets we're tracking, which is
> under control of the outside world, so I wanted an "rmmod -f".

The ip_conntrack problem is a variation of the LSM problem and both are a
problem of the driver not of the module code.
Basically you have to wait long enough until no new package can call to
the module. This means after removing the hooks, you have to check how
much packages are busy and wait for them to be processed.

bye, Roman

