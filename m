Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264735AbTFLFJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 01:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264736AbTFLFJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 01:09:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8976 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264735AbTFLFJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 01:09:01 -0400
Date: Wed, 11 Jun 2003 22:22:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First casuality of hlist poisoning in 2.5.70
In-Reply-To: <16103.48257.400430.785367@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0306112206430.29133-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jun 2003, Trond Myklebust wrote:
> 
>   This patch removes the Oops that occurs when either the source or
> the target of a d_move() operation is unhashed. It is currently
> triggered by the NFS sillyrename code.

Btw, thinking more about this, the patch can't be right.

> +		if (!hlist_unhashed(&dentry->d_hash))
> +			hlist_del_rcu(&dentry->d_hash);

This leaves the d_hash pointers as crapola.

> +		if (!hlist_unhashed(&target->d_hash)) {
> +			hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
> +			dentry->d_vfs_flags &= ~DCACHE_UNHASHED;
> +		} else
> +			dentry->d_vfs_flags |= DCACHE_UNHASHED;

And this will fix it only if target is hashed.

So either the patch depends on the target being hashed (and if so, it just 
shouldn't have the test, or have a BUG_ON() instead), or the patch is 
buggy.

I have this suspicion that the logical patch would be something like this:

	if (hlist_unhashed(&target->d_hash)) {
		/* Unhash the dentry too */
		__d_drop(dentry);
	} else {
		/* Rehash the dentry onto the same hash as the target */
		hlist_del_rcu(&dentry->d_hash);
		hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
		dentry->d_vfs_flags &= ~DCACHE_UNHASHED;   
	}

At least this would make slightly more sense than the patch.

HOWEVER, I actually suspect that the target really _cannot_ be unhashed, 
and that the test makes no sense, and the sequence should just be

	/* Rehash the dentry onto the same hash as the target */
	hlist_del_rcu(&dentry->d_hash);
	hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
	dentry->d_vfs_flags &= ~DCACHE_UNHASHED;

this is actually identical to what we have right now, except for one small 
detail: the current 2.5.x tree does not clear the DCACHE_UNHASHED bit in 
d_move().

Also, if a unhashed dentry really is ok, then I think the test for 

        /* Move the dentry to the target hash queue, if on different bucket */
        if (dentry->d_bucket != target->d_bucket) {
		...

should really be something like

	if (!d_hashed(dentry) || dentry->d_bucket != target->d_bucket) {
		...

because otherwise the dentry may well share the same bucket as the target, 
but if it wasn't hashed before, it won't be hashed after either. 

But I suspect that neither dentry nor target should really ever be
unhashed by the time we call d_move(). That's reinforced by the fact that
it looks like a unhashed dentry in d_move() would have been a silent bug
previously - staying unhashed if it just shared the bucket.

Al, I'll be really happy having you go over this code too. And whatever we 
decide is right (enforcing hashedness or whatever), we should assert it, 
because clearly d_move() has been a bit too subtle for us so far.

		Linus

