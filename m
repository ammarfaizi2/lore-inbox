Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVG0UeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVG0UeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVG0UdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:33:13 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52902 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262314AbVG0Uao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:30:44 -0400
Subject: Re: [PATCH 3/7] shared subtree
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Avantika Mathur <mathurav@us.ibm.com>, mike@waychison.com,
       janak@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DxrL8-0001kG-00@dorka.pomaz.szeredi.hu>
References: <20050725224417.501066000@localhost>
	 <20050725225908.031752000@localhost>
	 <E1DxrL8-0001kG-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1122496239.5037.104.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 27 Jul 2005 13:30:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 12:13, Miklos Szeredi wrote:
> > @@ -54,7 +55,7 @@ static inline unsigned long hash(struct 
> >  
> >  struct vfsmount *alloc_vfsmnt(const char *name)
> >  {
> > -	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
> > +	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL);
> >  	if (mnt) {
> >  		memset(mnt, 0, sizeof(struct vfsmount));
> >  		atomic_set(&mnt->mnt_count,1);
> 
> Please make whitespace changes a separate patch.

 I tried to remove trailing whitespaces in the current code
whereever I found them. Ok will them a separate patch.


> 
> > @@ -128,11 +162,71 @@ static void attach_mnt(struct vfsmount *
> >  {
> >  	mnt->mnt_parent = mntget(nd->mnt);
> >  	mnt->mnt_mountpoint = dget(nd->dentry);
> > -	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
> > +	mnt->mnt_namespace = nd->mnt->mnt_namespace;
> > +	list_add_tail(&mnt->mnt_hash,
> > +			mount_hashtable+hash(nd->mnt, nd->dentry));
> >  	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
> >  	nd->dentry->d_mounted++;
> >  }
> 
> Why list_add_tail()?  This changes user visible behavior, and seems
> unnecessary.

Yes. I was about to send out a mail questioning the existing behavior. I
will start a seperate thread questioning the current behavoir. My plan
was to discuss the current behavior before making this change. I thought
I had reverted this change. But it slipped in. 

> 
> > +static void attach_prepare_mnt(struct vfsmount *mnt, struct nameidata *nd)
> > +{
> > +	mnt->mnt_parent = mntget(nd->mnt);
> > +	mnt->mnt_mountpoint = dget(nd->dentry);
> > +	nd->dentry->d_mounted++;
> > +}
> > +
> > +
> 
> You shouldn't add unnecessary newlines.  There are a lot of these,
> please audit all your patches.

ok. sure.

> 
> > +void do_attach_commit_mnt(struct vfsmount *mnt)
> > +{
> > +	struct vfsmount *parent = mnt->mnt_parent;
> > +	BUG_ON(parent==mnt);
> 
> 	BUG_ON(parent == mnt);
> 
> > +	if(list_empty(&mnt->mnt_hash))
> 
> 	if (list_empty(&mnt->mnt_hash))
> 
> > +		list_add_tail(&mnt->mnt_hash,
> > +			mount_hashtable+hash(parent, mnt->mnt_mountpoint));
> > +	if(list_empty(&mnt->mnt_child))
> > +		list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
> > +	mnt->mnt_namespace = parent->mnt_namespace;
> > +	list_add_tail(&mnt->mnt_list, &mnt->mnt_namespace->list);
> > +}
> 
> Etc.  Maybe you should run Lindent on your changes, but be careful not
> to change existing code, even if Lindent would do that!

sure :)

> 
> > @@ -191,7 +270,7 @@ static void *m_start(struct seq_file *m,
> >  	struct list_head *p;
> >  	loff_t l = *pos;
> >  
> > -	down_read(&n->sem);
> > +	down_read(&namespace_sem);
> >  	list_for_each(p, &n->list)
> >  		if (!l--)
> >  			return list_entry(p, struct vfsmount, mnt_list);
> 
> This should be a separate patch.  You can just take the one from the
> detached trees patch-series.

ok. in fact these changes were motivated by that patch.

> 
> > +/*
> > + * abort the operations done in attach_recursive_mnt(). run through the mount
> > + * tree, till vfsmount 'last' and undo the changes.  Ensure that all the mounts
> > + * in the tree are all back in the mnt_list headed at 'source_mnt'.
> > + * NOTE: This function is closely tied to the logic in
> > + * 'attach_recursive_mnt()'
> > + */
> > +static void abort_attach_recursive_mnt(struct vfsmount *source_mnt, struct
> > +		vfsmount *last, struct list_head *head) { struct vfsmount *p =
> > +	source_mnt, *m; struct vfspnode *src_pnode;
> 
> If you want to do proper error handling, instead of doing rollback, it
> seems better to first do anything that can fail (allocations), then do
> the actual attaching, which cannot fail.  It isn't nice to have
> transient states on failure.

yes. it does exactly what you said. In the prepare stage it does not
touch any of the existing vfstree or the pnode tree.

All it does it builds a new vfstree and pnode tree, does the necessary
changes to them. And if everthing is successful, it glues the new tree
to the existing tree (which is the commit phase), and if the prepare
stage fails allocating memory or any other reason, it goes and destroys
the new trees (in the abort phase).

Offcourse in the prepare state, it does increase the reference count of
the vfsmounts to which the new tree will be attached. This is to ensure
that the vfsmounts have not disappeared by the time we reach the commit
phase.  I think we are talking the same thing, and the code behaves
exactly as you said.


> 
> > + /*
> > + * This operation is equivalent of mount --bind dir dir
> > + * create a new mount at the dentry, and unmount all child mounts
> > + * mounted on top of dentries below 'dentry', and mount them
> > + * under the new mount.
> > +  */
> > +struct vfsmount *do_make_mounted(struct vfsmount *mnt, struct dentry *dentry)
> 
> Why is this needed?  I thought we agreed, that this can be removed.

yes we agreed on returning EINVAL when a directory is attempted to made
shared/private/slave/unclonnable.   But this is a different case.

lets say  /mnt is a mountpoint having a vfsmount (say A). 
now if you run 
	mount --bind /mnt/a  /tmp
this operation succeeds currently. 

now lets say /mnt is a mountpoint having a vfsmount which is shared.
now if you run
	mount --bind /mnt/a /tmp

we now have a mount at /tmp which gets propogation from mounts under
/mnt/a. right?
but /mnt/a is not a mountpoint at all.  if we need to track and
propogate mounts/unmounts under /tmp or /mnt/a we need to have a mount
at /mnt/a. WHich means we have to implicitly make /mnt/a as a
mountpoint. Or the other solution is to return -EINVAL.

But returning -EINVAL is inconsistent with the standard behavior of
	mount --bind 
the standard behavior allows bind mounts from any directory; need not be
a mountpoint. 

We had this exact discussion about the behavior with Mike Waychison, Al
Viro and Bruce Fields. Mike suggested the above implemented behavior.

RP



> 
> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

