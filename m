Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264622AbUEJL25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbUEJL25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEJL25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:28:57 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:53657 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264622AbUEJL2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:28:52 -0400
Message-ID: <409F6741.19A29C20@melbourne.sgi.com>
Date: Mon, 10 May 2004 21:28:01 +1000
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
References: <16521.5104.489490.617269@laputa.namesys.com>
		<16529.56343.764629.37296@cse.unsw.edu.au>
		<409634B9.8D9484DA@melbourne.sgi.com>
		<16534.54704.792101.617408@cse.unsw.edu.au> <16542.63130.911881.340894@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> > > *   Logic bug in d_splice_alias() forgets to clear the DCACHE_DISCONNECTED
> > >     flag when a lookup connects a disconnected dentry.  Fix is (relative
> > >     to Neil's patch):
> >
> Ok, I've reviewed the code and thought about it some more.
> 
> This was intentional and the patch to clear DCACHE_DISCONNECTED is not
> needed and possibly wrong.
> 
> DCACHE_DISCONNECTED *doesn't* mean that the entries isn't connected,
> but only that it might not be.

Agreed.  After reading your comments below the semantics of the flag
make sense: was once disconnected and may or may not still be depending
on lazy clearing by the expfs.c code).  My dentry state checking code
was wrong.

Of course I now have an issue with the misleading name ;-)

> In knfsd, we build a patch from the bottom up, and the dentry at the
> bottom is not "connected" until the top is finally connected to the
> root.  If DCACHE_DISCONNECTED were to mean precisely that the dentry
> isn't connected, then at that point were we finally connect a path we
> would have to walk down the path (which could possibly branch)
> clearing all the DCACHE_DISCONNECTED flags, and this clearly isn't a
> good idea.

Yes, with you so far.  Lazy clearing is good.

> nfsd and exportfs should be the only bits of code that cares if
> DCACHE_DISCONNECTED is set or not, and they will clear it if
> appropriate.

Ok, I've thought about this for a while and I see where you're coming
from: you don't want DCACHE_DISCONNECTED disappearing out from
underneath find_exported_dentry() as a side effect of either the lookups
it does or unrelated local lookups from other processes.  The cost
is that the flag potentially lingers when it could have been cleared
out earlier (as my patch tried to do), but this is better than subtle
logic failures down the track.

> A more significant measure is "IS_ROOT". When we call d_splice_alias,
> it should look for an IS_ROOT alias to consider splicing in rather
> than a DCACHE_DISCONNECTED alias, as a DCACHE_DISCONNECTED alias might
> already be spliced into some other path (if it is for a file with
> multiple links).
> 
> The follow patch should resolve all of this, and a few other things.
> IT:
> 
>  - moves DCACHE_DISCONNECTED into d_vfs_flags and uses dcache_lock to
>    make sure that setting the flag doesn't tread on some other flag
>    in the same field.

What I'm wondering is, do we still need DCACHE_DISCONNECTED at all?
Perhaps the uses of it could be replaced with combinations of checks
of IS_ROOT() and (d == d->d_sb->s_root) ?

>  - introduces "d_get_alias" which is similar to "d_find_alias", but is
>    less choosy: any alias will do.
>  - uses d_get_alias in d_alloc_anon and d_splice_alias to try to use a
>    pre-exisiting alias if possible.
>  - Only splices in a pre-exisiting alias if it was IS_ROOT.  There can
>    now only be one of these per inode, and if there is one, there will
>    be no other alias.
>  - introduces d_move_locked which does the same as d_move, but without
>    getting dcache_lock first (it must already be held).  This is
>    needed to be able to atomically test IS_ROOT, and then convert the
>    dentry to non IS_ROOT before anyone else gets to test IS_ROOT.
> 
> Comments and testing results very welcome.

The changes look good but I think the invariants you describe above
should go in a comment.

I will try to do some testing in the next couple of days.

> -void d_move(struct dentry * dentry, struct dentry * target)
> +static void d_move_locked(struct dentry * dentry, struct dentry * target)
>  {
>  	if (!dentry->d_inode)
>  		printk(KERN_WARNING "VFS: moving negative dcache entry\n");
>[...]
> +
> +void d_move(struct dentry * dentry, struct dentry * target)
> +{
> +       if (!dentry->d_inode)
> +               printk(KERN_WARNING "VFS: moving negative dcache entry\n");
> +

Do you need two copies of this check in the same path?


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
