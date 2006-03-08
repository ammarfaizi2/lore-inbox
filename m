Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWCHCko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWCHCko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWCHCkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:40:43 -0500
Received: from mx1.suse.de ([195.135.220.2]:35538 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932196AbWCHCkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:40:43 -0500
From: Neil Brown <neilb@suse.de>
To: balbir@in.ibm.com
Date: Wed, 8 Mar 2006 13:39:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17422.17387.691138.193521@cse.unsw.edu.au>
Cc: Kirill Korotaev <dev@sw.ru>, Balbir Singh <bsingharora@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Kirill Korotaev <dev@openvz.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
In-Reply-To: message from Balbir Singh on Wednesday March 8
References: <17414.38749.886125.282255@cse.unsw.edu.au>
	<17419.53761.295044.78549@cse.unsw.edu.au>
	<661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com>
	<17420.59580.915759.44913@cse.unsw.edu.au>
	<440D2536.60005@sw.ru>
	<17422.9555.635650.460131@cse.unsw.edu.au>
	<20060308021731.GA29327@in.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 8, balbir@in.ibm.com wrote:
> > So: blending the better bits of various patches together, I've come up
> > with the following.  It still needs a changelog entry, but does anyone
> > want to ACK it ???
> 
> I think this patch is much more cleaner and refined.

Thanks.

> 
> From yesterdays comments I am beginning to wonder if it is enough to solve
> only the unmount race or should the fix be more generic to address the race
> between the shrinkers call to shrink_dcache_memory() and shrink_dcache_parent().
> 
> From what I understand of the race, the race occurs when dput of the
> parent fails to happen and because the referecne count is not 0,
> shrink_dcache_parent() skips over those dentries. The race occurs for
> the dentry and its ancestors above 

I think that in most cases, the race doesn't matter if
shrink_dcache_memory misses a dentry because someone else is holding a
temporary reference, it really doesn't matter.
Similarly most callers of shrink_dcache_parent are happy with a
best-effort.

Unmount is a special case because it wants to 'shrink' *all* of the
dentries for the filesystem.  In that case, someone holding a
transient reference s a bad thing.  In other cases it is, at best, a
minor inconvenience. 

> 
> I was wondering if the following would work (to solve the generic race)
> 
> Add a prune_mutex to the super-block. Hold on to it in prune_one_dentry()
> until we hit a parent dentry that is a mount point (d_mounted > 0) or
> the parent has a reference count > 1 or at the end of prune_one_dentry().
> This should ensure that for each super block dentry counts are consistent.
> Also get select_parent() to hold the super block's prune_mutex, so that it
> sees a consistent view of the super block.
> 
> Oh! now that I think about it, I think your solution looks like an
> elegant way to do the same thing. The only draw back is that it solves
> only the unmount race and there are some changes in generic_shutdown_super()
> which I do not understand.
> 

> > diff ./fs/super.c~current~ ./fs/super.c
> > --- ./fs/super.c~current~	2006-03-08 10:50:37.000000000 +1100
> > +++ ./fs/super.c	2006-03-08 11:02:12.000000000 +1100
> > @@ -81,6 +81,8 @@ static struct super_block *alloc_super(v
> >  		mutex_init(&s->s_dquot.dqio_mutex);
> >  		mutex_init(&s->s_dquot.dqonoff_mutex);
> >  		init_rwsem(&s->s_dquot.dqptr_sem);
> > +		s->s_prunes = 0;
> > +		init_waitqueue_head(&s->s_wait_prunes);
> >  		init_waitqueue_head(&s->s_wait_unfrozen);
> >  		s->s_maxbytes = MAX_NON_LFS;
> >  		s->dq_op = sb_dquot_ops;
> > @@ -231,6 +233,7 @@ void generic_shutdown_super(struct super
> >  
> >  	if (root) {
> >  		sb->s_root = NULL;
> > +		wait_on_prunes(sb);
> >  		shrink_dcache_sb(sb);
> 
> Hmm... in 2.6.16-rc5, I see
> 
> shrink_dcache_parent(root);
> shrink_dcache_anon(&sb->sb_anon);
> 
> without these calls, some dentries might not get moved to LRU list.
> 
> Am I missing something here?

I should have been more explicit that the patch was against
2.6.16-rc5-mm2.  This contains some dcache patches to allow nfs
filesystem to share superblocks, and one of the patches replaces the
calls to shrink_dcache_parent and shrink_dcache_anon with a single
call to a new function: shrink_dcache_sb.

Thanks for the feedback

NeilBrown

