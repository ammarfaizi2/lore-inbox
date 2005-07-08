Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVGHQxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVGHQxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVGHQxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:53:14 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:59916 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262710AbVGHQvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:51:55 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       mike@waychison.com, bfields@fieldses.org
In-reply-to: <1120839568.30164.88.camel@localhost> (message from Ram on Fri,
	08 Jul 2005 09:19:29 -0700)
Subject: Re: [RFC PATCH 1/8] share/private/slave a subtree
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
	 <E1Dqttu-0004kx-00@dorka.pomaz.szeredi.hu> <1120839568.30164.88.camel@localhost>
Message-Id: <E1Dqw4W-0004sT-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 08 Jul 2005 18:51:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > + * recursively change the type of the mountpoint.
> > > + */
> > > +static int do_change_type(struct nameidata *nd, int flag)
> > > +{
> > > +	struct vfsmount *m, *mnt;
> > > +	struct vfspnode *old_pnode = NULL;
> > > +	int err;
> > > +
> > > +	if (!(flag & MS_SHARED) && !(flag & MS_PRIVATE)
> > > +			&& !(flag & MS_SLAVE))
> > > +		return -EINVAL;
> > > +
> > > +	if ((err = _do_make_mounted(nd, &mnt)))
> > > +		return err;
> > 
> > 
> > Why does this opertation do any mounting?  If it's a type change, it
> > should just change the type of something already mounted, no?
> 
> apart from changing types, it has to create a new vfsmount if one
> does not exist at that point. 

Why?

I think it would be more logical to either

  - return -EINVAL if it's not a mountpoint

  - change the type of the mount even if it's not a mountpoint

Is there some reason the user can't do the 'bind dir dir' manually if
needed?


> > > +/*
> > > + * Walk the pnode tree for each pnode encountered.  A given pnode in the tree
> > > + * can be returned a minimum of 2 times.  First time the pnode is encountered,
> > > + * it is returned with the flag PNODE_DOWN. Everytime the pnode is encountered
> > > + * after having traversed through each of its children, it is returned with the
> > > + * flag PNODE_MID.  And finally when the pnode is encountered after having
> > > + * walked all of its children, it is returned with the flag PNODE_UP.
> > > + *
> > > + * @context: provides context on the state of the last walk in the pnode
> > > + * 		tree.
> > > + */
> > > +static int inline
> > > +pnode_next(struct pcontext *context)
> > > +{
> > 
> > Is such a generic traversal function really needed?  Why?
> 
> Yes. I found it useful to write generic code without having to worry
> about the details of the traversal being duplicated everywhere.  Do you
> have better suggestion? This function is the equivalent of next_mnt()
> for traversing pnode trees.

I'm just wondering, why do you need to return 2/3 times per node.  Are
all these traversal points needed by propagation operations?  Why?

Some notes (maybe outside the code) explaining the mechanism of the
propagations would be nice.  Without these it's hard to understand the
design decisions behind such an implementation.

> > 
> > > +struct vfsmount *
> > > +pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
> > > +{
> > 
> > Again a header comment would be nice, on what exactly this function
> > does.  Also the implementation is really cryptic, but I can't even
> > start to decipher without knowing what it's supposed to do.
> 
> yes. this function takes care of traversing the propogation tree and
> creating a child vfsmount for dentries in each vfsmount encountered.
> In other words it calls do_make_mounted() for each vfsmount that belongs
> to the propogation tree.

So it just does the propagated 'bind dir dir'?

Why not use the generic propagated bind routine (defined in a later
patch I presume) for this? 

Miklos
