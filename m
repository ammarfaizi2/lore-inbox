Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751839AbWCJFLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWCJFLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 00:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWCJFLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 00:11:09 -0500
Received: from mx1.suse.de ([195.135.220.2]:42155 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751839AbWCJFLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 00:11:07 -0500
From: Neil Brown <neilb@suse.de>
To: Kirill Korotaev <dev@openvz.org>
Date: Fri, 10 Mar 2006 16:09:54 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17425.2594.967505.22336@cse.unsw.edu.au>
Cc: Jan Blunck <jblunck@suse.de>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory()
 race (3rd updated patch)]
In-Reply-To: message from Kirill Korotaev on Thursday March 9
References: <20060309165833.GK4243@hasse.suse.de>
	<441060D2.6090800@openvz.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 9, dev@openvz.org wrote:
> Andrew,
> 
> Acked-By: Kirill Korotaev <dev@openvz.org>

I'm afraid that I'm not convinced.

> > +static int wait_on_prunes(struct super_block *sb)
> > +{
> > +	DEFINE_WAIT(wait);
> > +	int prunes_remaining = 0;
> > +
> > +#ifdef DCACHE_DEBUG
> > +	printk(KERN_DEBUG "%s: waiting for %d prunes\n", __FUNCTION__,
> > +	       sb->s_prunes);
> > +#endif
> > +
> > +	spin_lock(&dcache_lock);
> > +	for (;;) {
> > +		prepare_to_wait(&sb->s_wait_prunes, &wait,
> > +				TASK_UNINTERRUPTIBLE);
> > +		if (!sb->s_prunes)
> > +			break;
> > +		spin_unlock(&dcache_lock);
> > +		schedule();
> > +		prunes_remaining = 1;
> > +		spin_lock(&dcache_lock);
> > +	}
> > +	spin_unlock(&dcache_lock);
> > +	finish_wait(&sb->s_wait_prunes, &wait);
> > +	return prunes_remaining;
> > +}

I don't think that a return value from wait_on_prunes is meaningful.
All it tells us is whether a prune_one_dentry finished before or after
wait_on_prunes takes the spin_lock.  This isn't very useful
information as it has no significance to upper levels.

So:

> > +		do {
> > +			shrink_dcache_parent(root);
> > +		} while(wait_on_prunes(sb));
> > +

Suppose shrink_dcache_parent misses on dentry because the inode was being
iput.  This iput completes immediately that
shrink_dcache_parent completes.  It decrements ->s_prunes and when
wait_on_prunes takes dcache_lock, ->s_prunes is zero so the loop
terminates, and the remaining dentries - the parents of the dentry
what was undergoing iput - don't get put.

I really think that we need to stop prune_one_dentry from being called
on dentries for a filesystem that is being unmounted.  With that code
currently in -git, that means passing a 'struct super_block *' into
prune_dcache so that it ignores any filesystem with ->s_root==NULL
unless that filesystem is the filesystem that was passed.

NeilBrown
