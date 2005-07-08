Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVGHLSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVGHLSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVGHLSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:18:22 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:24877 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262494AbVGHLRc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:17:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQ9Xjy+5ZmxBK6DSYoCr0bziXzN9WQCUmk05ikKYEqHyL9XH3k40SzjltnAKDsqMdqK1rPBaibXkTNSY2FYyXRJWoL/bRppDh0xjIGQreuLabW+1RrmiAcBPuGMDH/cEDerlbHeIFVBhHyTqnWbFH0VjJMSMQYe5HOWaMvKMWoI=
Message-ID: <84144f0205070804171d7c9726@mail.gmail.com>
Date: Fri, 8 Jul 2005 14:17:31 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Ram <linuxram@us.ibm.com>
Subject: Re: [RFC PATCH 1/8] share/private/slave a subtree
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <1120817463.30164.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost>
	 <1120817463.30164.43.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/05, Ram <linuxram@us.ibm.com> wrote:
> This patch adds the shared/private/slave support for VFS trees.

Inlining the patches to email would be greatly appreciated. Here are
some comments.

> +int
> +_do_make_mounted(struct nameidata *nd, struct vfsmount **mnt)

Use two underscores to follow naming conventions.

> Index: 2.6.12/fs/pnode.c
> ===================================================================
> --- /dev/null
> +++ 2.6.12/fs/pnode.c
> @@ -0,0 +1,362 @@
> +
> +#define PNODE_MEMBER_VFS  0x01
> +#define PNODE_SLAVE_VFS   0x02

Enums, please.

> +
> +static kmem_cache_t * pnode_cachep;
> +
> +/* spinlock for pnode related operations */
> + __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
> +
> +
> +static void
> +pnode_init_fn(void *data, kmem_cache_t *cachep, unsigned long flags)
> +{
> +	struct vfspnode *pnode = (struct vfspnode *)data;

Redundant cast.

> +	INIT_LIST_HEAD(&pnode->pnode_vfs);
> +	INIT_LIST_HEAD(&pnode->pnode_slavevfs);
> +	INIT_LIST_HEAD(&pnode->pnode_slavepnode);
> +	INIT_LIST_HEAD(&pnode->pnode_peer_slave);
> +	pnode->pnode_master = NULL;
> +	pnode->pnode_flags = 0;
> +	atomic_set(&pnode->pnode_count,0);
> +}
> +
> +void __init
> +pnode_init(unsigned long mempages)
> +{
> +	pnode_cachep = kmem_cache_create("pnode_cache",
> +                       sizeof(struct vfspnode), 0,
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, pnode_init_fn, NULL);
> +}
> +
> +
> +struct vfspnode *
> +pnode_alloc(void)
> +{
> +	struct vfspnode *pnode =  (struct vfspnode *)kmem_cache_alloc(
> +			pnode_cachep, GFP_KERNEL);

Redundant cast.

> +struct inoutdata {

Wants a better name.

> +	void *my_data; /* produced and consumed by me */
> +	void *in_data; /* produced by master, consumed by slave */
> +	void *out_data; /* produced by slave, comsume by master */
> +};
> +
> +struct pcontext {
> +	struct vfspnode *start;
> +	int 	flag;
> +	int 	traversal;
> +	int	level;
> +	struct vfspnode *master_pnode;
> +	struct vfspnode *pnode;
> +	struct vfspnode *slave_pnode;
> +};
> +
> +
> +#define PNODE_UP 1
> +#define PNODE_DOWN 2
> +#define PNODE_MID 3

Enums, please.

> +
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

Rather large function to be an inline.

> +{
> +	int traversal = context->traversal;
> +	int ret=0;
> +	struct vfspnode *pnode = context->pnode,
> +			*slave_pnode=context->slave_pnode,
> +			*master_pnode=context->master_pnode;

Add a separate declaration for each variable. The above is hard to read.

> +	struct list_head *next;
> +
> +	spin_lock(&vfspnode_lock);
> +	/*
> +	 * the first traversal will be on the root pnode
> +	 * with flag PNODE_DOWN
> +	 */
> +	if (!pnode) {
> +		context->pnode = get_pnode(context->start);
> +		context->master_pnode = NULL;
> +		context->traversal = PNODE_DOWN;
> +		context->slave_pnode = NULL;
> +		context->level = 0;
> +		ret = 1;
> +		goto out;
> +	}
> +
> +	/*
> +	 * if the last traversal was PNODE_UP, than the current
> +	 * traversal is PNODE_MID on the master pnode.
> +	 */
> +	if (traversal == PNODE_UP) {
> +		if (!master_pnode) {
> +			/* DONE. return */
> +			put_pnode(pnode);
> +			ret = 0;

Using goto out and dropping the else branch would make this more readable.

> +		} else {
> +			context->traversal = PNODE_MID;
> +			context->level--;
> +			context->pnode = master_pnode;
> +			put_pnode(slave_pnode);
> +			context->slave_pnode = pnode;
> +			context->master_pnode = (master_pnode ?
> +				master_pnode->pnode_master : NULL);
> +			ret = 1;
> +		}
> +	} else {
> +		if(traversal == PNODE_MID) {

Missing space before parenthesis.

> +			next = slave_pnode->pnode_peer_slave.next;
> +		} else {
> +			next = pnode->pnode_slavepnode.next;
> +		}

Please drop the extra braces.

> +		put_pnode(slave_pnode);
> +		context->slave_pnode = NULL;
> +		/*
> +		 * if the last traversal was PNODE_MID or PNODE_DOWN, and the
> +		 * master pnode has some slaves to traverse, the current
> +		 * traversal will be PNODE_DOWN on the slave pnode.
> +		 */
> +		if ((next != &pnode->pnode_slavepnode) &&
> +			(traversal == PNODE_DOWN || traversal == PNODE_MID)) {
> +			context->traversal = PNODE_DOWN;
> +			context->level++;
> +			context->pnode = get_pnode(list_entry(next,
> +				struct vfspnode, pnode_peer_slave));
> +			context->master_pnode = pnode;
> +			ret = 1;
> +		} else {
> +			/*
> +			 * since there are no more children, the current traversal
> +			 * is PNODE_UP on the same pnode
> +			 */
> +			context->traversal = PNODE_UP;
> +			ret = 1;

Would probably make more sense to check if
(next == &pnode->pnode_slavepnode && traversal == PNODE_UP) and use goto out to
get rid of the else branch.

> +		}
> +	}
> +out:
> +	spin_unlock(&vfspnode_lock);
> +	return ret;
> +}
> +
> +

> +static void
> +_pnode_disassociate_mnt(struct vfsmount *mnt)

Two underscores, please.

> +struct vfsmount *
> +pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
> +{
> +	struct vfsmount *child_mnt;
> +	int ret=0,traversal,level;

Spaces, please.

> +     	struct vfspnode *slave_pnode, *master_pnode, *child_pnode, *slave_child_pnode;
> +     	struct vfsmount *slave_mnt, *member_mnt, *t_m;

Formatting damage.

> +	struct pcontext context;
> +	static struct inoutdata p_array[PNODE_MAX_SLAVE_LEVEL];
> +
> +	context.start = pnode;
> +	context.pnode = NULL;
> +
> +	while(pnode_next(&context)) {

Missing space before parenthesis.

> +		traversal = context.traversal;
> +		level = context.level;
> +		pnode = context.pnode;
> +		slave_pnode = context.slave_pnode;
> +		master_pnode = context.master_pnode;
> +
> +		if (traversal == PNODE_DOWN ) {

Use switch statement here.

> +			if (master_pnode) {
> +				child_pnode = (struct vfspnode *)p_array[level-1].in_data;

Redundant cast.

> +			} else {
> +				child_pnode = NULL;
> +			}

Extra braces.

> +			while (!(child_pnode = pnode_alloc()))
> +				schedule();

This looks dangerous. Why this must not fail and in other places you 
return -ENOMEM?

> +			p_array[level].my_data = (void *)child_pnode;

Redundant cast.

> +			p_array[level].in_data = NULL;
> +
> +		} else if(traversal == PNODE_MID) {
> +
> +			child_pnode = (struct vfspnode *)p_array[level].my_data;

Redundant cast.

> +			slave_child_pnode = p_array[level+1].out_data;
> +			pnode_add_slave_pnode(child_pnode, slave_child_pnode);
> +
> +		} else if(traversal == PNODE_UP) {
> +			child_pnode = p_array[level].my_data;
> +			spin_lock(&vfspnode_lock);
> +			list_for_each_entry_safe(member_mnt,
> +				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
> +				spin_unlock(&vfspnode_lock);
> +				if (!(child_mnt = do_make_mounted(mnt, dentry))) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +				spin_lock(&vfspnode_lock);
> +				pnode_add_member_mnt(child_pnode, child_mnt);
> +			}
> +			list_for_each_entry_safe(slave_mnt,
> +				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
> +				spin_unlock(&vfspnode_lock);
> +				if (!(child_mnt = do_make_mounted(mnt, dentry))) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +				spin_lock(&vfspnode_lock);
> +				pnode_add_slave_mnt(child_pnode, child_mnt);
> +			}
> +			spin_unlock(&vfspnode_lock);
> +			p_array[level].out_data = child_pnode;
> +		}
> +	}
> +
> +out:
> +	if (ret)
> +		return NULL;
> +
> +	child_mnt = lookup_mnt(mnt, dentry, dentry);
> +	mntput(child_mnt);
> +	return child_mnt;
> +}
> Index: 2.6.12/include/linux/fs.h
> ===================================================================
> --- 2.6.12.orig/include/linux/fs.h
> +++ 2.6.12/include/linux/fs.h
> @@ -102,6 +102,9 @@ extern int dir_notify_enable;
>  #define MS_MOVE		8192
>  #define MS_REC		16384
>  #define MS_VERBOSE	32768
> +#define MS_PRIVATE	262144
> +#define MS_SLAVE	524288
> +#define MS_SHARED	1048576

The expression (1<<bit) would make more sense here.

> Index: 2.6.12/include/linux/pnode.h
> ===================================================================
> --- /dev/null
> +++ 2.6.12/include/linux/pnode.h
> @@ -0,0 +1,78 @@
> +/*
> + *  linux/fs/pnode.c
> + *
> + * (C) Copyright IBM Corporation 2005.
> + *	Released under GPL v2.
> + *
> + */
> +#ifndef _LINUX_PNODE_H
> +#define _LINUX_PNODE_H
> +#ifdef __KERNEL__

No need for the above. Kernel headers are not supposed to be included by
userspace.

> +
> +#include <linux/list.h>
> +#include <linux/mount.h>
> +#include <linux/spinlock.h>
> +#include <asm/atomic.h>
> +
> +struct vfspnode {
> +	struct list_head pnode_vfs; 	 /* list of vfsmounts anchored here */
> +	struct list_head pnode_slavevfs; /* list of slave vfsmounts */
> +	struct list_head pnode_slavepnode;/* list of slave pnode */
> +	struct list_head pnode_peer_slave;/* going through master's slave pnode
> +					    list*/
> +	struct vfspnode	 *pnode_master;	  /* master pnode */
> +	int 		 pnode_flags;
> +	atomic_t 	 pnode_count;
> +};
> +#define PNODE_MAX_SLAVE_LEVEL 10
> +#define PNODE_DELETE  0x01
> +#define PNODE_SLAVE   0x02

Enums, please.

> +
> +#define IS_PNODE_DELETE(pn)  ((pn->pnode_flags&PNODE_DELETE)==PNODE_DELETE)
> +#define IS_PNODE_SLAVE(pn)  ((pn->pnode_flags&PNODE_SLAVE)==PNODE_SLAVE)
> +#define SET_PNODE_DELETE(pn)  pn->pnode_flags |= PNODE_DELETE
> +#define SET_PNODE_SLAVE(pn)  pn->pnode_flags |= PNODE_SLAVE

Static inline functions are preferred over #define.

> +
> +extern spinlock_t vfspnode_lock;
> +extern void __put_pnode(struct vfspnode *);
> +
> +static inline struct vfspnode *
> +get_pnode(struct vfspnode *pnode)
> +{
> +	if (!pnode)
> +		return NULL;

Can pnode really be NULL here? Looking at the callers in this patch, it can't.
Please remember that you should do NULL checks like this only when it makes
sense from API point of view to call the function with NULL.

> Index: 2.6.12/include/linux/mount.h
> ===================================================================
> --- 2.6.12.orig/include/linux/mount.h
> +++ 2.6.12/include/linux/mount.h
> @@ -16,9 +16,33 @@
>  #include <linux/spinlock.h>
>  #include <asm/atomic.h>
>  
> -#define MNT_NOSUID	1
> -#define MNT_NODEV	2
> -#define MNT_NOEXEC	4
> +#define MNT_NOSUID	0x01
> +#define MNT_NODEV	0x02
> +#define MNT_NOEXEC	0x04
> +#define MNT_PRIVATE	0x10  /* if the vfsmount is private, by default it is private*/
> +#define MNT_SLAVE	0x20  /* if the vfsmount is a slave mount of its pnode */
> +#define MNT_SHARED	0x40  /* if the vfsmount is a slave mount of its pnode */
> +#define MNT_PNODE_MASK	0xf0  /* propogation flag mask */
> +
> +#define IS_MNT_SHARED(mnt) (mnt->mnt_flags&MNT_SHARED)
> +#define IS_MNT_SLAVE(mnt) (mnt->mnt_flags&MNT_SLAVE)
> +#define IS_MNT_PRIVATE(mnt) (mnt->mnt_flags&MNT_PRIVATE)
> +
> +#define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SHARED))
> +#define CLEAR_MNT_PRIVATE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_PRIVATE))
> +#define CLEAR_MNT_SLAVE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SLAVE))
> +
> +//TOBEDONE WRITE BETTER MACROS. ..

Please use static inline functions instead.

> +#define SET_MNT_SHARED(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_SHARED),\
> +				CLEAR_MNT_PRIVATE(mnt), \
> +				CLEAR_MNT_SLAVE(mnt))
> +#define SET_MNT_PRIVATE(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_PRIVATE), \
> +				CLEAR_MNT_SLAVE(mnt), \
> +				CLEAR_MNT_SHARED(mnt), \
> +				mnt->mnt_pnode = NULL)
> +#define SET_MNT_SLAVE(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_SLAVE), \
> +				CLEAR_MNT_PRIVATE(mnt), \
> +				CLEAR_MNT_SHARED(mnt))
