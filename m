Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292329AbSCIB3p>; Fri, 8 Mar 2002 20:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSCIB3g>; Fri, 8 Mar 2002 20:29:36 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:55217 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292329AbSCIB31>; Fri, 8 Mar 2002 20:29:27 -0500
Date: Fri, 08 Mar 2002 17:30:55 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Paul Menage <pmenage@ensim.com>
cc: Hanna Linder <hannal@us.ibm.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre3 Fast Walk Dcache
Message-ID: <30770000.1015637455@w-hlinder.des>
In-Reply-To: <E16jRuZ-00076W-00@pmenage-dt.ensim.com>
In-Reply-To: <E16jRuZ-00076W-00@pmenage-dt.ensim.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, March 08, 2002 13:28:23 -0800 Paul Menage <pmenage@ensim.com> wrote:

> 
> 1) You're missing parentheses in cached_lookup_nd() and path_lookup():
> 
	Oops. Operator precedence strikes again. They are in 
	cached_lookup_nd() and link_path_walk(). I have made 
	the changes. 

> 2) Since cached_lookup_nd() calls __d_lookup() and hence
> __dget_locked(), it's not clear how you actually avoid incrementing the
> d_count values of the dentries, other than the root/cwd dentries. Can
> you explain the logic in a little more detail?

	The frequency with which root/cwd dentries are in any given path 
	probably cause the majority of the cacheline bouncing of d_count.
	So the logic there is clear. However, you make a good point and
	I'm looking at this.

> 3) If you replace walk_init_root() and path_lookup() with something
> like the following, you can pull the ugliness of walk_init_root() out
> of path_lookup(). Basically, make walk_init_root() recognise
> LOOKUP_LOCKED and take the dcache_lock rather than grabbing refcounts. 
> walk_init_root() drops the LOOKUP_LOCKED flag if necessary while
> calling __emul_lookup_dentry() to avoid additional complexity. If
> walk_init_root() returns 0, then the dcache lock wasn't taken,
> regardless of whether the nd.flags had LOOKUP_LOCKED set.
> 
> static inline int
> walk_init_root(const char *name, struct nameidata *nd)
> {
> 	unsigned int flags = nd->flags;
> 	read_lock(&current->fs->lock);
> 	if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
> 
> 		if(flags & LOOKUP_LOCKED)
> 			nd->flags &= ~LOOKUP_LOCKED;
> 
> 		nd->mnt = mntget(current->fs->altrootmnt);
> 		nd->dentry = dget(current->fs->altroot);

	The first reaction I have is that it breaks the consistancy 
	between a flag and what the flag represents. Having the dcache_lock
	held without the LOOKUP_LOCKED flag in this part of the code might
	cause deadlocks or lead to hard-to-maintain code. 

	I appreciate you taking the time to provide such thoughtful and
	deatailed comments and I will look at the whole patch again with 
	these comments in mind. Next week expect a new and improved
	version!

	Thanks.

	Hanna





