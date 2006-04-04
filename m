Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWDDBBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWDDBBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 21:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWDDBBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 21:01:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:37557 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964931AbWDDBBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 21:01:53 -0400
From: Neil Brown <neilb@suse.de>
To: balbir@in.ibm.com
Date: Tue, 4 Apr 2006 10:59:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17457.50445.138103.748844@cse.unsw.edu.au>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Jan Blunck" <jblunck@suse.de>, "Kirill Korotaev" <dev@openvz.org>,
       olh@suse.de
Subject: Re: [PATCH] Fix dcache race during umount
In-Reply-To: message from Balbir Singh on Monday April 3
References: <20060403133804.27986.patches@notabene>
	<1060403034001.28030@suse.de>
	<661de9470604031112j3bf81a21r7066c67f62f1de63@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday April 3, balbir@in.ibm.com wrote:
> Hi, Neil,
> 
> >
> > Cc: Jan Blunck <jblunck@suse.de>
> > Cc: Kirill Korotaev <dev@openvz.org>
> > Cc: olh@suse.de
> > Cc: bsingharora@gmail.com
> 
> Could you please make this balbir@in.ibm.com

Sure.

> 
> >
> > Signed-off-by: Neil Brown <neilb@suse.de>
> >
> <snip>
> -               /* If the dentry was recently referenced, don't free it. */
> -               if (dentry->d_flags & DCACHE_REFERENCED) {
> -                       dentry->d_flags &= ~DCACHE_REFERENCED;
> -                       list_add(&dentry->d_lru, &dentry_unused);
> -                       dentry_stat.nr_unused++;
> -                       spin_unlock(&dentry->d_lock);
> -                       continue;
> +               if (!(dentry->d_flags & DCACHE_REFERENCED) &&
> +                   (!sb || dentry->d_sb == sb)) {
> 
> Comments for the condition please. Something like
> 
> /*
>  * If the dentry is not DCACHED_REFERENCED, it is time to move it to LRU list,
>  * provided the super block is NULL (which means we are trying to reclaim memory
>  * or this dentry belongs to the same super block that we want to shrink.
>  */

Ok, thanks.  However it isn't time to "move it to the LRU list" but
rather time to "move it from the LRU list, out of the cache all
together, and through it away".

> 
> One side-effect of this check I see is
> 
> Earlier, all prune_dcache() calls would prune the dentry cache. This
> condition will cause dentries belonging only those super blocks being
> shrink'ed to be freed up. shrink_dcache_memory() will have to do the
> additional work of freeing dentries (especially for file systems like
> sysfs, procfs, etc). But the good thing is it should make the per
> super block operations faster (like unmount). IMO, this is the correct
> behaviour, but I am not sure of the side-effects.
> 

Hmm... yes, but there is a worse side-effect I think. If
shrink_dcache_memory finds a dentry that it cannot free, it will move
it to the head of the LRU, so unmount will not be able to find it so
easily, and will end up moving it back down to the tail.  I don't
think this can livelock, but it is unpleasant.

Rather than move these entries to the head of the list, I'd like to
leave them at the tail, and try to skip over entries that we might not
be able to free.



> +                       if (sb) {
> +                               prune_one_dentry(dentry);
> +                               continue;
> +                       }
> > +                       /* Need to avoid race with generic_shutdown_super */
> > +                       if (down_read_trylock(&dentry->d_sb->s_umount) &&
> > +                           dentry->d_sb->s_root != NULL) {
> 
> There is a probable bug here. What if down_read_trylock() succeeds and
> dentry->d_sb->s_root == NULL? We still need to do an up_read before we
> move on.

Oops, yes.  Thanks for that!

> The comment would be better put as
> 
> /*
>  * If we are able to acquire the umount semaphore, then the super
> block cannot be unmounted
>  * while we are pruning this dentry. This helps avoid a race condition
> that is caused due to
>  * intermediate reference counts held by the children of the dentry in
> prune_one_dentry().
>  * This leads to select_dcache_parent() ignoring those dentries,
> leaving behind non-dput
>  * dentries. The unmount happens before prune_one_dentry() can dput
> the dentries.
>  */

Well, I've beefed up the comment, but I would rather focus on the
prune_one_dentry holding an inode rather than holding a dentry.  I
think that problem is clearer and it comes to the same thing.

Patch to follow.

Thanks,
NeilBrown
