Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWCILAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWCILAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWCILA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:00:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:138 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751821AbWCILA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:00:27 -0500
Date: Thu, 9 Mar 2006 12:00:25 +0100
From: Jan Blunck <jblunck@suse.de>
To: Balbir Singh <balbir@in.ibm.com>
Cc: akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de, neilb@suse.de,
       dev@openvz.org, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (updated patch)
Message-ID: <20060309110025.GE4243@hasse.suse.de>
References: <20060308145105.GA4243@hasse.suse.de> <20060309063330.GA23256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060309063330.GA23256@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, Balbir Singh wrote:

> > +/*
> > + * If we slept on waiting for other prunes to finish, there maybe are
> > + * some dentries the d_lru list that we have "overlooked" the last
> > + * time we called select_parent(). Therefor lets restart in this case.
> > + */
> >  void shrink_dcache_parent(struct dentry * parent)
> >  {
> >  	int found;
> > +	struct super_block *sb = parent->d_sb;
> >  
> > + again:
> >  	while ((found = select_parent(parent)) != 0)
> >  		prune_dcache(found);
> > +
> > +	/* If we are called from generic_shutdown_super() during
> > +	 * umount of a filesystem, we want to check for other prunes */
> > +	if (!sb->s_root && wait_on_prunes(sb))
> > +		goto again;
> >  }
> 
> cosmetic - could we do this with a do { } while() loop instead of a goto?
> 
> I think though that after select_parent(), wait_on_prunes() can sleep just
> once, so we do not need a goto. Just calling wait_on_prunes() should
> fix the race. For all the dentries missed in the race, wait_on_parent()
> will ensure that they are dput() by prune_one_dentry() before wait_on_parent()
> returns.
> 
> But, I do not have anything against the goto, so this patch should be just
> fine.
> 

No. Think about a dentry which parent isn't unhashed. This parent will end up
on the lru-list after the wait_on_prunes(). Therefore we have to do the
select_parent()/prune_dcache() again to get rid of all dentries.

And I missed the "goto vs. do...while()" against my colleagues here, too ;)
I'll send a followup.

> >  	if (root) {
> >  		sb->s_root = NULL;
> > -		shrink_dcache_parent(root);
> >  		shrink_dcache_anon(&sb->s_anon);
> > +		shrink_dcache_parent(root);
> >  		dput(root);
> 
> This change might conflict with the NFS patches in -mm.
> 

Hmm, right. Andrew, if you want a rediff against -mm just tell me. I'm
actually diff'ing against lates linux-2.6.git.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
