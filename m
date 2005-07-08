Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVGHRwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVGHRwI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVGHRwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:52:08 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:196 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262733AbVGHRwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:52:05 -0400
Subject: Re: [RFC PATCH 1/8] share/private/slave a subtree
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       mike@waychison.com, bfields@fieldses.org
In-Reply-To: <E1Dqw4W-0004sT-00@dorka.pomaz.szeredi.hu>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
	 <E1Dqttu-0004kx-00@dorka.pomaz.szeredi.hu>
	 <1120839568.30164.88.camel@localhost>
	 <E1Dqw4W-0004sT-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1120845120.30164.139.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 10:52:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 09:51, Miklos Szeredi wrote:
> > > > + * recursively change the type of the mountpoint.
> > > > + */
> > > > +static int do_change_type(struct nameidata *nd, int flag)
> > > > +{
> > > > +	struct vfsmount *m, *mnt;
> > > > +	struct vfspnode *old_pnode = NULL;
> > > > +	int err;
> > > > +
> > > > +	if (!(flag & MS_SHARED) && !(flag & MS_PRIVATE)
> > > > +			&& !(flag & MS_SLAVE))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if ((err = _do_make_mounted(nd, &mnt)))
> > > > +		return err;
> > > 
> > > 
> > > Why does this opertation do any mounting?  If it's a type change, it
> > > should just change the type of something already mounted, no?
> > 
> > apart from changing types, it has to create a new vfsmount if one
> > does not exist at that point. 
> 
> Why?
> 
> I think it would be more logical to either
> 
>   - return -EINVAL if it's not a mountpoint
> 
>   - change the type of the mount even if it's not a mountpoint
> 
> Is there some reason the user can't do the 'bind dir dir' manually if
> needed?

The reason why I implemented that way, is to less confuse the user and
provide more flexibility. With my implementation, we have the ability
to share any part of the tree, without bothering if it is a mountpoint
or not. The side effect of this operation is, it ends up creating 
a vfsmount if the dentry is not a mountpoint.

so when a user says
      mount --make-shared /tmp/abc
the tree under /tmp/abc becomes shared. 
With your suggestion either the user will get -EINVAL or the tree
under / will become shared. The second behavior will be really
confusing. I am ok with -EINVAL. 


Also there is another reason why I used this behavior. Lets say /mnt
is a mountpoint and Say a user does
		mount make-shared /mnt 

and then does 
                mount --bind /mnt/abc  /mnt1

NOTE: we need propogation to be set up between /mnt/abc and /mnt1 and
propogation can only be set up for vfsmounts.  In this case /mnt/abc 
is not a mountpoint. I have two choices, either return -EINVAL
or create a vfsmount at that point. But -EINVAL is not consistent
with standard --bind behavior. So I chose the later behavior.

Now that we anyway need this behavior while doing bind mounts from
shared trees, I kept the same behavior for --make-shared.


> 
> 
> > > > +/*
> > > > + * Walk the pnode tree for each pnode encountered.  A given pnode in the tree
> > > > + * can be returned a minimum of 2 times.  First time the pnode is encountered,
> > > > + * it is returned with the flag PNODE_DOWN. Everytime the pnode is encountered
> > > > + * after having traversed through each of its children, it is returned with the
> > > > + * flag PNODE_MID.  And finally when the pnode is encountered after having
> > > > + * walked all of its children, it is returned with the flag PNODE_UP.
> > > > + *
> > > > + * @context: provides context on the state of the last walk in the pnode
> > > > + * 		tree.
> > > > + */
> > > > +static int inline
> > > > +pnode_next(struct pcontext *context)
> > > > +{
> > > 
> > > Is such a generic traversal function really needed?  Why?
> > 
> > Yes. I found it useful to write generic code without having to worry
> > about the details of the traversal being duplicated everywhere.  Do you
> > have better suggestion? This function is the equivalent of next_mnt()
> > for traversing pnode trees.
> 
> I'm just wondering, why do you need to return 2/3 times per node.  Are
> all these traversal points needed by propagation operations?  Why?

yes. It becomes highly necessary when we do mounts in shared
vfsmounts.  The mount has to be propogated to all the slave pnodes
as well as the member and slave mounts.  And in the processs of
propogation a new pnode propogation tree has to be created that
sets up the propogation for all the new child mounts.

The construction of the new child propogation tree during the process of
traversal of the parent's propogation tree, necessitates the need
for encountering the same pnode multiple times in different contexts.

Moreover I tried to abstract the propogation tree traversal as much
as possible so that all kinds of mount operations just have to
concentrate on the core operation instead of the details of the
traversal. pnode_opt.patch has most of these abstraction. 


> Some notes (maybe outside the code) explaining the mechanism of the
> propagations would be nice.  Without these it's hard to understand the
> design decisions behind such an implementation.

Ok. I will make a small writeup on the mechanism.


> 
> > > 
> > > > +struct vfsmount *
> > > > +pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
> > > > +{
> > > 
> > > Again a header comment would be nice, on what exactly this function
> > > does.  Also the implementation is really cryptic, but I can't even
> > > start to decipher without knowing what it's supposed to do.
> > 
> > yes. this function takes care of traversing the propogation tree and
> > creating a child vfsmount for dentries in each vfsmount encountered.
> > In other words it calls do_make_mounted() for each vfsmount that belongs
> > to the propogation tree.
> 
> So it just does the propagated 'bind dir dir'?

yes.
> 
> Why not use the generic propagated bind routine (defined in a later
> patch I presume) for this? 

It does that by calling the generic tree traversal routine(in the
pnode_opt.patch) . The tree traversal is taken care by pnode_traverse()
and the core functionality of calling do_make_mounted() is through
this mechanism.

RP


> Miklos

