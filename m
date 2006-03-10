Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWCJRRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWCJRRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWCJRRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:17:54 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:58055 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751874AbWCJRRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:17:53 -0500
Date: Fri, 10 Mar 2006 22:47:38 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jan Blunck <jblunck@suse.de>
Cc: Neil Brown <neilb@suse.de>, Kirill Korotaev <dev@openvz.org>,
       akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de,
       bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
Message-ID: <20060310171738.GA18687@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060309165833.GK4243@hasse.suse.de> <441060D2.6090800@openvz.org> <17425.2594.967505.22336@cse.unsw.edu.au> <441138B7.9060809@sw.ru> <20060310105950.GL4243@hasse.suse.de> <17425.26668.678359.918399@cse.unsw.edu.au> <20060310123153.GN4243@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310123153.GN4243@hasse.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 01:31:53PM +0100, Jan Blunck wrote:
> On Fri, Mar 10, Neil Brown wrote:
> 
> > -static void prune_dcache(int count)
> > +static void prune_dcache(int count, struct super_block *sb)
> >  {
> >  	spin_lock(&dcache_lock);
> >  	for (; count ; count--) {
> > @@ -417,8 +425,10 @@ static void prune_dcache(int count)
> >   			spin_unlock(&dentry->d_lock);
> >  			continue;
> >  		}
> > -		/* If the dentry was recently referenced, don't free it. */
> > -		if (dentry->d_flags & DCACHE_REFERENCED) {
> > +		/* If the dentry was recently referenced, or is for
> > +		 * a unmounting filesystem, don't free it. */
> > +		if ((dentry->d_flags & DCACHE_REFERENCED) ||
> > +		    (dentry->d_sb != sb && dentry->d_sb->s_root == NULL)) {
> >  			dentry->d_flags &= ~DCACHE_REFERENCED;
> >   			list_add(&dentry->d_lru, &dentry_unused);
> >   			dentry_stat.nr_unused++;
> 
> You have to down_read the rw-semaphore sb->s_umount since sb->s_root is
> protected by it :(

<snip>

Please do not beat me up for suggesting this. I was wondering if it
makes sense to add a PF_SHRINKER flag and set it in shrink_slab().
Use my solution, instead of PF_MEMALLOC check against PF_SHRINKER.

I think PF_SHRINKER might be a good idea, it might help us detect
races between the shrinker and other subsystems too - not only dcache.

It might be well worth adding in. If there is sufficient interest I can
send create and send out a patch.

Balbir 
