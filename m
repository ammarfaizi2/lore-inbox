Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319196AbSIMNqj>; Fri, 13 Sep 2002 09:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319589AbSIMNqj>; Fri, 13 Sep 2002 09:46:39 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:11918 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319196AbSIMNqi>;
	Fri, 13 Sep 2002 09:46:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 15:53:26 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209131131210.28515-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0209131131210.28515-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pqsx-00089B-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 12:35, Roman Zippel wrote:
> Hi,
> 
> On Fri, 13 Sep 2002, Rusty Russell wrote:
> 
> > > I'm aware of the init problem, what I described was the core problem,
> > > which prevents any further cleanup.
> >
> > I don't think of either of them as core, they are two problems.
> 
> Your init problem is easily solvable for try_inc_mod_count() users, just
> add a check for MOD_INITIALIZING, so it will fail during module init. On
> the other hand forcing everyone to use try_inc_mod_count is a serious
> problem.

Well now.  We agree about that, do we not?  I go on to conclude that it
is better to leave the job of monitoring module activity and determining
quiescence up to the module itself, do we agree about that as well?

> Actually I consider removing the start/stop methods, if one can't get it
> right without them, one won't get it right with them either and it's easy
> enough to add them later again.

Exactly my feeling.

> The exit function should always be called after the init function (even if
> it failed, I don't do it in the patch, that's a bug). The fs init/exit
> would like this then:

Perhaps, but if so, the module itself should call the exit function in 
its failure path itself.  Doing the full exit whether it needs to be
done or not is wasteful and opens up new DoS opportunities.

In the example you give below you must rely on register_filesystem
tolerating unregistering a nonexistent filesystem.  That's sloppy at
best, and you will have to ensure *every* helper used by ->exit is
similarly sloppy.

> static int __init init_fs(void)
> {
> 	inode_cachep = kmem_cache_create(...);
> 	if (!inode_cachep)
> 		return -ENOMEM;
> 	return register_filesystem(&fs_type);
> }
> 
> static int __exit exit_fs(void)
> {
> 	int err;
> 	err = unregister_filesystem(&fs_type);
> 	if (err)
> 		return err;
> 	kmem_cache_destroy(inode_cachep);
> 	inode_cachep = NULL;
> 	return 0;
> }

-- 
Daniel
