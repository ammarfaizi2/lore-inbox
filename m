Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWCCOsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWCCOsI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 09:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWCCOsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 09:48:06 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:55468 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751133AbWCCOsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 09:48:05 -0500
Date: Fri, 3 Mar 2006 07:48:04 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/5] Optimise d_find_alias()
Message-ID: <20060303144804.GJ1598@parisc-linux.org>
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> <25676.1141385408@warthog.cambridge.redhat.com> <20060303034552.5fcedc49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303034552.5fcedc49.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 03:45:52AM -0800, Andrew Morton wrote:
> David Howells <dhowells@redhat.com> wrote:
> >  struct dentry * d_find_alias(struct inode *inode)
> >   {
> >  -	struct dentry *de;
> >  -	spin_lock(&dcache_lock);
> >  -	de = __d_find_alias(inode, 0);
> >  -	spin_unlock(&dcache_lock);
> >  +	struct dentry *de = NULL;
> >  +	if (!list_empty(&inode->i_dentry)) {
> >  +		spin_lock(&dcache_lock);
> >  +		de = __d_find_alias(inode, 0);
> >  +		spin_unlock(&dcache_lock);
> >  +	}
> >   	return de;
> >   }
> 
> How can we get away without a barrier?

We'd have to be synchronised higher up in order to care, I think.

The condition we're testing is !list_empty(&inode->i_dentry)
which will presumably be optimised by the compiler into
inode->i_dentry.next != &inode->i_dentry -- IOW determined by a single
load.

Both false negatives and false positives are interesting, so we're
concerned with any write from another CPU that changes inode->i_dentry.next 
d_instantiate() looks like a good candidate for analysing races.

CPU1				CPU2

d_instantiate()
spin_lock(&dcache_lock);
				
				d_find_alias()
				if (!list_empty(&inode->i_dentry)) {
list_add(&entry->d_alias, &inode->i_dentry);
spin_unlock(&dcache_lock);
					spin_lock(&dcache_lock);
					__d_find_alias()
					spin_unlock(&dcache_lock);
				}

I don't see how putting a barrier in helps determine whether the
list_add is before or after the load for list_empty.  So I think it's
a  benign race.  If it returns NULL, it's the same as the case where
d_instantiate() is called after __d_find_alias() returns.  If
list_empty() is false, grabbing the dcache_lock means we'll find the
list really is empty after all.

So it's not a correctness thing, it's a question of how many times we
lose the race, and what the performance penalty is for doing so (and what
the performance penalty is for ensuring we lose the race less often).
And I don't know the answer to that.
