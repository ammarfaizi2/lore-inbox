Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVGRHHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVGRHHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVGRHHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:07:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:14467 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261559AbVGRHHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:09 -0400
Message-Id: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:11 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 0/8] shared subtree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enclosed 8 patches that implement shared subtree functionality as
detailed in Al Viro's RFC found at http://lwn.net/Articles/119232/

I have incorporated all the comments received earlier in first round.  Thanks
to Miklos and Pekka for the valuable comments.  Also I have optimized lots of
code, especially in pnode.c . Code is unit tested. However the code in its
current form does not handle ENOMEM error gracefully. I am working on it. 

The incremental patches provide the following functionality:

1) shared_private_slave.patch : Provides the ability to mark a subtree as
shared or private or slave.
        
2) unclone.patch : provides the ability to mark a subtree as unclonable.  NOTE:
this feature is an addition to Al Viro's RFC, to solve the vfsmount explosion.
The problem is  detailed here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0502.0/0468.html

3) rbind.patch : this patch adds the ability to propagate binds/rbinds across
vfsmounts.

4) move.patch : this patch provides the ability to move a
shared/private/slave/unclonable subtree to some other mount-point. It also
provides the same feature to pivot_root()

5) umount.patch: this patch provides the ability to propagate unmounts.

6) namespace.patch: this patch provides ability to clone a namespace, with
propagation set to vfsmounts in the new namespace.

7) automount.patch: this patch provides the automatic propagation for
mounts/unmounts done through automounter.

8) pnode_opt.patch: this patch optimizes the redundant code in pnode.c .

Looking forward for comments, 
RP
-----------------------------------------------------------------------

CHANGES DONE IN RESPONSE TO COMMENTS RECEIVED IN 1ST ROUND,


response to Pekka J Enberg Comments:


>>Inlining the patches to email would be greatly appreciated. Here are
>>some comments.

done

> +int
> +_do_make_mounted(struct nameidata *nd, struct vfsmount **mnt)

>>Use two underscores to follow naming conventions.

Yes done. In fact this function is renamed as make_mounted because
that seemed to make more sense. But in general throughout the patches
I have changed all newly introduced function that start with one
underscore to two underscores.


> Index: 2.6.12/fs/pnode.c
> ===================================================================
> --- /dev/null
> +++ 2.6.12/fs/pnode.c
> @@ -0,0 +1,362 @@
> +
> +#define PNODE_MEMBER_VFS  0x01
> +#define PNODE_SLAVE_VFS   0x02

>>Enums, please.

done


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

>>Redundant cast.

yes. removed.

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

>>Redundant cast.

yes removed.

> +struct inoutdata {

>>Wants a better name.

This datastructure is gone after optimizing pnode.c


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

>>Enums, please.

These #defines are gone after the optimizations and cleanup.

> +
> +/*
> + * Walk the pnode tree for each pnode encountered.  A given pnode in the tree
> + * can be returned a minimum of 2 times.  First time the pnode is encountered,
> + * it is returned with the flag PNODE_DOWN. Every time the pnode is encountered
> + * after having traversed through each of its children, it is returned with the
> + * flag PNODE_MID.  And finally when the pnode is encountered after having
> + * walked all of its children, it is returned with the flag PNODE_UP.
> + *
> + * @context: provides context on the state of the last walk in the pnode
> + * 		tree.
> + */
> +static int inline
> +pnode_next(struct pcontext *context)

>>Rather large function to be an inline.

yes. done.

> +{
> +	int traversal = context->traversal;
> +	int ret=0;
> +	struct vfspnode *pnode = context->pnode,
> +			*slave_pnode=context->slave_pnode,
> +			*master_pnode=context->master_pnode;

>>Add a separate declaration for each variable. The above is hard to read.

yes done.

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

>> Using goto out and dropping the else branch would make this more readable.

This code is also gone after optimization and cleanups.


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

>> Missing space before parenthesis.

Yes ensured that throughout the patches. Hope I have not missed any.


> +			next = slave_pnode->pnode_peer_slave.next;
> +		} else {
> +			next = pnode->pnode_slavepnode.next;
> +		}

>> Please drop the extra braces.

Yes done.


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

>> Would probably make more sense to check if
>> (next == &pnode->pnode_slavepnode && traversal == PNODE_UP) and use goto out to
>> get rid of the else branch.

Again after code-cleanup and optimization, this code is gone.

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

>> Two underscores, please.

Yes. Did it!

> +struct vfsmount *
> +pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
> +{
> +	struct vfsmount *child_mnt;
> +	int ret=0,traversal,level;

>> Spaces, please.

Yes done.


> +     	struct vfspnode *slave_pnode, *master_pnode, *child_pnode, *slave_child_pnode;
> +     	struct vfsmount *slave_mnt, *member_mnt, *t_m;

>> Formatting damage.

Yep. Done


> +	while(pnode_next(&context)) {

>> Missing space before parenthesis.

Done


> +		traversal = context.traversal;
> +		level = context.level;
> +		pnode = context.pnode;
> +		slave_pnode = context.slave_pnode;
> +		master_pnode = context.master_pnode;
> +
> +		if (traversal == PNODE_DOWN ) {

>> Use switch statement here.

yep! did it.

> +			if (master_pnode) {
> +				child_pnode = (struct vfspnode *)p_array[level-1].in_data;

>> Redundant cast.

done.

> +			} else {
> +				child_pnode = NULL;
> +			}

>> Extra braces.

done

> +			while (!(child_pnode = pnode_alloc()))
> +				schedule();

>> This looks dangerous. Why this must not fail and in other places you 
>> return -ENOMEM?

I have changed it to return -ENOMEM. But its not perfect yet. The
code is not graceful returning. It leaves around some data-structures.
I am working on this last aspect currently.


> +			p_array[level].my_data = (void *)child_pnode;

>> Redundant cast.

Yes. done.

> +			child_pnode = (struct vfspnode *)p_array[level].my_data;

>> Redundant cast.

Yes. done.

> +#define MS_PRIVATE	262144
> +#define MS_SLAVE	524288
> +#define MS_SHARED	1048576

>> The expression (1<<bit) would make more sense here.

Yes. done.


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

>> No need for the above. Kernel headers are not supposed to be included by
>> userspace.

Removed it.

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

>> Enums, please.

I have left it as is for now. These defines can also go. I will fix
them.


> +
> +#define IS_PNODE_DELETE(pn)  ((pn->pnode_flags&PNODE_DELETE)==PNODE_DELETE)
> +#define IS_PNODE_SLAVE(pn)  ((pn->pnode_flags&PNODE_SLAVE)==PNODE_SLAVE)
> +#define SET_PNODE_DELETE(pn)  pn->pnode_flags |= PNODE_DELETE
> +#define SET_PNODE_SLAVE(pn)  pn->pnode_flags |= PNODE_SLAVE

>> Static inline functions are preferred over #define.

done

> +
> +extern spinlock_t vfspnode_lock;
> +extern void __put_pnode(struct vfspnode *);
> +
> +static inline struct vfspnode *
> +get_pnode(struct vfspnode *pnode)
> +{
> +	if (!pnode)
> +		return NULL;

>> Can pnode really be NULL here? Looking at the callers in this patch, it can't.
>> Please remember that you should do NULL checks like this only when it makes
>> sense from API point of view to call the function with NULL.

Yes there are cases where it they can be called with null. If I don't
have these checks, than the check has to be done in the caller. So I chose
it here.

> +//TOBEDONE WRITE BETTER MACROS. ..
>>Please use static inline functions instead.

yes done.


Response to Miklos comments follows:

> -struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
> +struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry, struct dentry *root)
>  {

>> How about changing it to inline and calling it __lookup_mnt_root(),
>> and calling it from lookup_mnt() (which could keep the old signature)
>> and lookup_mnt_root().  That way the compiler can optimize away the
>> root check for the plain lookup_mnt() case, and there's no need to
>> modify callers of lookup_mnt().

Yes. DOne.

>  
> +struct vfsmount *do_make_mounted(struct vfsmount *mnt, struct dentry *dentry)
> +{

>> What does this function do?  Can we have a header comment?

Yes added a header.

> +int
> +_do_make_mounted(struct nameidata *nd, struct vfsmount **mnt)
> +{

>> Ditto.

Added a header.

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


>> Why does this opertation do any mounting?  If it's a type change, it
>> should just change the type of something already mounted, no?

Ok. Now it returns -EINVAL.


> +		case MS_SHARED:
> +			SET_MNT_PRIVATE(m);
....
> +			break;
> +

>> Can this be split into three functions?

Yes split them into 3 functions.


> +static int inline
> +pnode_next(struct pcontext *context)
> +{

>> Is such a generic traversal function really needed?  Why?

As I said in my earlier mail, this function is equivalent of next_mnt
for traversing vfsmount tree.
I have optimized this function as well as pnode_traverse(). Hopefully you
may find the new code palatable.


> +struct vfsmount *
> +pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
> +{

>>Again a header comment would be nice, on what exactly this function
>>does.  Also the implementation is really cryptic, but I can't even
>>start to decipher without knowing what it's supposed to do.

Yes. added a header comment.


> +static inline struct vfspnode *
> +get_pnode_n(struct vfspnode *pnode, size_t n)
> +{

>> Seems to be unused throughout the patch series

True removed.


>  
> +
>  static inline struct vfsmount *mntget(struct vfsmount *mnt)

>> Please don't add empty lines.

Yes done.
-----------------------------------------------------------------------
