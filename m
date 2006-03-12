Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWCLV6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWCLV6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWCLV6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:58:36 -0500
Received: from cantor2.suse.de ([195.135.220.15]:19635 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932272AbWCLV6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:58:35 -0500
From: Neil Brown <neilb@suse.de>
To: Jan Blunck <jblunck@suse.de>
Date: Mon, 13 Mar 2006 08:57:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17428.39221.861124.797480@cse.unsw.edu.au>
Cc: Kirill Korotaev <dev@openvz.org>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
In-Reply-To: message from Jan Blunck on Friday March 10
References: <20060309165833.GK4243@hasse.suse.de>
	<441060D2.6090800@openvz.org>
	<17425.2594.967505.22336@cse.unsw.edu.au>
	<441138B7.9060809@sw.ru>
	<20060310105950.GL4243@hasse.suse.de>
	<17425.26668.678359.918399@cse.unsw.edu.au>
	<20060310123153.GN4243@hasse.suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 10, jblunck@suse.de wrote:
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

No you don't.
sb->s_root is set precisely twice for any filesystem.
Once when the filesystem is mounted, typically in the fill_super
function, and once in generic_shutdown_super where it is set to NULL.

There is no need to lock against the first change as the sb is not
globally visible until after s_root is set.  So for the present
purpose we only need to worry about the second change.

For this, the current usage of dcache_lock is enough to remove any
possible race.  generic_shutdown_super sets s_root to NULL and then
takes dcache_lock (via wait_for_prunes) before it cares if anyone has
noticed the NULL or not.  prune_dcache holds dcache_lock while testing
for NULL.  So there is no room for a race.

s_umount is sometimes taken before testing s_root.  This is always
because the sb has just been found on the list of all superblocks, and
so the thread doesn't hold a proper reference to it.  In our case
we are holding a dentry which in turn holds a real reference to the
superblock.

So I stand by my patch - s_root can be safely tested here.

NeilBrown
