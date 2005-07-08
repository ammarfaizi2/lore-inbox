Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVGHOc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVGHOc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVGHOc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:32:58 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:23301 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262674AbVGHOc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 10:32:56 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       mike@waychison.com, bfields@fieldses.org
In-reply-to: <1120817463.30164.43.camel@localhost> (message from Ram on Fri,
	08 Jul 2005 03:25:42 -0700)
Subject: Re: [RFC PATCH 1/8] share/private/slave a subtree
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
Message-Id: <E1Dqttu-0004kx-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 08 Jul 2005 16:32:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch adds the shared/private/slave support for VFS trees.

[...]

> -struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
> +struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry, struct dentry *root)
>  {

How about changing it to inline and calling it __lookup_mnt_root(),
and calling it from lookup_mnt() (which could keep the old signature)
and lookup_mnt_root().  That way the compiler can optimize away the
root check for the plain lookup_mnt() case, and there's no need to
modify callers of lookup_mnt().

[...]

>  
> +struct vfsmount *do_make_mounted(struct vfsmount *mnt, struct dentry *dentry)
> +{

What does this function do?  Can we have a header comment?

> +int
> +_do_make_mounted(struct nameidata *nd, struct vfsmount **mnt)
> +{

Ditto.

> +/*
> + * recursively change the type of the mountpoint.
> + */
> +static int do_change_type(struct nameidata *nd, int flag)
> +{
> +	struct vfsmount *m, *mnt;
> +	struct vfspnode *old_pnode = NULL;
> +	int err;
> +
> +	if (!(flag & MS_SHARED) && !(flag & MS_PRIVATE)
> +			&& !(flag & MS_SLAVE))
> +		return -EINVAL;
> +
> +	if ((err = _do_make_mounted(nd, &mnt)))
> +		return err;


Why does this opertation do any mounting?  If it's a type change, it
should just change the type of something already mounted, no?

> +		case MS_SHARED:
> +			/*
> +			 * if the mount is already a slave mount,
> +			 * allocated a new pnode and make it
> +			 * a slave pnode of the original pnode.
> +			 */
> +			if (IS_MNT_SLAVE(m)) {
> +				old_pnode = m->mnt_pnode;
> +				pnode_del_slave_mnt(m);
> +			}
> +			if(!IS_MNT_SHARED(m)) {
> +				m->mnt_pnode = pnode_alloc();
> +				if(!m->mnt_pnode) {
> +					pnode_add_slave_mnt(old_pnode, m);
> +					err = -ENOMEM;
> +					break;
> +				}
> +				pnode_add_member_mnt(m->mnt_pnode, m);
> +			}
> +			if(old_pnode) {
> +				pnode_add_slave_pnode(old_pnode,
> +						m->mnt_pnode);
> +			}
> +			SET_MNT_SHARED(m);
> +			break;
> +
> +		case MS_SLAVE:
> +			if (IS_MNT_SLAVE(m)) {
> +				break;
> +			}
> +			/*
> +			 * only shared mounts can
> +			 * be made slave
> +			 */
> +			if (!IS_MNT_SHARED(m)) {
> +				err = -EINVAL;
> +				break;
> +			}
> +			old_pnode = m->mnt_pnode;
> +			pnode_del_member_mnt(m);
> +			pnode_add_slave_mnt(old_pnode, m);
> +			SET_MNT_SLAVE(m);
> +			break;
> +
> +		case MS_PRIVATE:
> +			if(m->mnt_pnode)
> +				pnode_disassociate_mnt(m);
> +			SET_MNT_PRIVATE(m);
> +			break;
> +

Can this be split into three functions?

[...]

> +/*
> + * Walk the pnode tree for each pnode encountered.  A given pnode in the tree
> + * can be returned a minimum of 2 times.  First time the pnode is encountered,
> + * it is returned with the flag PNODE_DOWN. Everytime the pnode is encountered
> + * after having traversed through each of its children, it is returned with the
> + * flag PNODE_MID.  And finally when the pnode is encountered after having
> + * walked all of its children, it is returned with the flag PNODE_UP.
> + *
> + * @context: provides context on the state of the last walk in the pnode
> + * 		tree.
> + */
> +static int inline
> +pnode_next(struct pcontext *context)
> +{

Is such a generic traversal function really needed?  Why?

[...]

> +struct vfsmount *
> +pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
> +{

Again a header comment would be nice, on what exactly this function
does.  Also the implementation is really cryptic, but I can't even
start to decipher without knowing what it's supposed to do.

[...]

> +static inline struct vfspnode *
> +get_pnode_n(struct vfspnode *pnode, size_t n)
> +{

Seems to be unused throughout the patch series

> +	struct list_head mnt_pnode_mntlist;/* and going through their
> +					   pnode's vfsmount */
> +	struct vfspnode *mnt_pnode;	/* and going through their
> +					   pnode's vfsmount */
>  	atomic_t mnt_count;
>  	int mnt_flags;
>  	int mnt_expiry_mark;		/* true if marked for expiry */
> @@ -38,6 +66,7 @@ struct vfsmount
>  	struct namespace *mnt_namespace; /* containing namespace */
>  };
>  
> +
>  static inline struct vfsmount *mntget(struct vfsmount *mnt)

Please don't add empty lines.

Miklos
