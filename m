Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVG0UGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVG0UGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVG0T4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:56:34 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:53259 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262466AbVG0Tzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:55:53 -0400
To: linuxram@us.ibm.com
CC: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, mathurav@us.ibm.com,
       mike@waychison.com, janak@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050725225907.007405000@localhost> (message from Ram Pai on
	Mon, 25 Jul 2005 15:44:18 -0700)
Subject: Re: [PATCH 1/7] shared subtree
References: <20050725224417.501066000@localhost> <20050725225907.007405000@localhost>
Message-Id: <E1DxrzJ-0001uo-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Jul 2005 21:54:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int do_make_shared(struct vfsmount *mnt)
> +{
> +	int err=0;
> +	struct vfspnode *old_pnode = NULL;
> +	/*
> +	 * if the mount is already a slave mount,
> +	 * allocate a new pnode and make it
> +	 * a slave pnode of the original pnode.
> +	 */
> +	if (IS_MNT_SLAVE(mnt)) {
> +		old_pnode = mnt->mnt_pnode;
> +		pnode_del_slave_mnt(mnt);
> +	}
> +	if(!IS_MNT_SHARED(mnt)) {
> +		mnt->mnt_pnode = pnode_alloc();
> +		if(!mnt->mnt_pnode) {
> +			pnode_add_slave_mnt(old_pnode, mnt);
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +		pnode_add_member_mnt(mnt->mnt_pnode, mnt);
> +	}
> +	if(old_pnode)
> +		pnode_add_slave_pnode(old_pnode, mnt->mnt_pnode);
> +	set_mnt_shared(mnt);
> +out:
> +	return err;
> +}

This is an example, where having struct pnode just complicates things.
If there was no struct pnode, this function would be just one line:
setting the shared flag.

> +static kmem_cache_t * pnode_cachep;
> +
> +/* spinlock for pnode related operations */
> + __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
> +
> +enum pnode_vfs_type {
> +	PNODE_MEMBER_VFS = 0x01,
> +	PNODE_SLAVE_VFS = 0x02
> +};
> +
> +void __init pnode_init(unsigned long mempages)
> +{
> +	pnode_cachep = kmem_cache_create("pnode_cache",
> +                       sizeof(struct vfspnode), 0,
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
> +}
> +
> +struct vfspnode * pnode_alloc(void)
> +{
> +	struct vfspnode *pnode =  kmem_cache_alloc(pnode_cachep, GFP_KERNEL);
> +	INIT_LIST_HEAD(&pnode->pnode_vfs);
> +	INIT_LIST_HEAD(&pnode->pnode_slavevfs);
> +	INIT_LIST_HEAD(&pnode->pnode_slavepnode);
> +	INIT_LIST_HEAD(&pnode->pnode_peer_slave);
> +	pnode->pnode_master = NULL;
> +	pnode->pnode_flags = 0;
> +	atomic_set(&pnode->pnode_count,0);
> +	return pnode;
> +}
> +
> +void inline pnode_free(struct vfspnode *pnode)
> +{
> +	kmem_cache_free(pnode_cachep, pnode);
> +}
> +
> +/*
> + * __put_pnode() should be called with vfspnode_lock held
> + */
> +void __put_pnode(struct vfspnode *pnode)
> +{
> +	struct vfspnode *tmp_pnode;
> +	do {
> +		tmp_pnode = pnode->pnode_master;
> +		list_del_init(&pnode->pnode_peer_slave);
> +		BUG_ON(!list_empty(&pnode->pnode_vfs));
> +		BUG_ON(!list_empty(&pnode->pnode_slavevfs));
> +		BUG_ON(!list_empty(&pnode->pnode_slavepnode));
> +		pnode_free(pnode);
> +		pnode = tmp_pnode;
> +		if (!pnode || !atomic_dec_and_test(&pnode->pnode_count))
> +			break;
> +	} while(pnode);
> +}
> +

All these are really unnecessary IMO.

> +/*
> + * merge 'pnode' into 'peer_pnode' and get rid of pnode
> + * @pnode: pnode the contents of which have to be merged
> + * @peer_pnode: pnode into which the contents are merged
> + */
> +int pnode_merge_pnode(struct vfspnode *pnode, struct vfspnode *peer_pnode)
> +{
> +	struct vfspnode *slave_pnode, *pnext;
> +	struct vfsmount *mnt, *slave_mnt, *next;
> +
> +	list_for_each_entry_safe(slave_pnode,  pnext,
> +			&pnode->pnode_slavepnode, pnode_peer_slave) {
> +		slave_pnode->pnode_master = peer_pnode;
> +		list_move(&slave_pnode->pnode_peer_slave,
> +				&peer_pnode->pnode_slavepnode);
> +		put_pnode_locked(pnode);
> +		get_pnode(peer_pnode);
> +	}
> +
> +	list_for_each_entry_safe(slave_mnt,  next,
> +			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
> +		slave_mnt->mnt_pnode = peer_pnode;
> +		list_move(&slave_mnt->mnt_pnode_mntlist,
> +				&peer_pnode->pnode_slavevfs);
> +		put_pnode_locked(pnode);
> +		get_pnode(peer_pnode);
> +	}
> +
> +	list_for_each_entry_safe(mnt, next,
> +			&pnode->pnode_vfs, mnt_pnode_mntlist) {
> +		mnt->mnt_pnode = peer_pnode;
> +		list_move(&mnt->mnt_pnode_mntlist,
> +				&peer_pnode->pnode_vfs);
> +		put_pnode_locked(pnode);
> +		get_pnode(peer_pnode);
> +	}
> +	return 0;
> +}

Much overcomplication.  It would just be a list_splice(), if there was
no struct pnode.


> +static void empty_pnode(struct vfspnode *pnode) { struct vfsmount *slave_mnt,
> +	*next; struct vfspnode *master_pnode, *slave_pnode, *pnext;
> +
> +	if ((master_pnode = pnode->pnode_master)) {
> +		pnode->pnode_master = NULL;
> +		list_del_init(&pnode->pnode_peer_slave);
> +		pnode_merge_pnode(pnode, master_pnode);
> +		put_pnode_locked(master_pnode);
> +	} else {
> +		list_for_each_entry_safe(slave_mnt, next,
> +			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
> +			list_del_init(&slave_mnt->mnt_pnode_mntlist);
> +			set_mnt_private(slave_mnt);
> +			put_pnode_locked(pnode);
> +		}
> +		list_for_each_entry_safe(slave_pnode,  pnext,
> +			&pnode->pnode_slavepnode, pnode_peer_slave) {
> +			slave_pnode->pnode_master = NULL;
> +			list_del_init(&slave_pnode->pnode_peer_slave);
> +			put_pnode_locked(pnode);
> +		}
> +	}
> +}
> +

Unnecessary.

> +static int pnode_next(struct pcontext *context)
> +{
> +	struct vfspnode *pnode = context->pnode;
> +	struct vfspnode	*master_pnode=context->master_pnode;
> +	struct list_head *next;
> +
> +	if (!pnode) {
> +		BUG_ON(!context->start);
> +		get_pnode(context->start);
> +		context->pnode = context->start;
> +		context->master_pnode = NULL;
> +		context->level = 0;
> +		return 1;
> +	}
> +
> +	spin_lock(&vfspnode_lock);
> +	next = pnode->pnode_slavepnode.next;
> +	if (next == &pnode->pnode_slavepnode) {
> +		while (1) {
> +			int flag;
> +
> +			if (pnode == context->start) {
> +				put_pnode_locked(pnode);
> +				spin_unlock(&vfspnode_lock);
> +				BUG_ON(context->level != 0);
> +				return 0;
> +			}
> +
> +			next = pnode->pnode_peer_slave.next;
> +			flag = (next != &pnode->pnode_master->pnode_slavepnode);
> +			put_pnode_locked(pnode);
> +
> +			if (flag)
> +				break;
> +
> +			pnode = master_pnode;
> +			master_pnode = pnode->pnode_master;
> +			context->level--;
> +		}
> +	} else {
> +		master_pnode = pnode;
> +		context->level++;
> +	}
> +
> +	pnode = list_entry(next, struct vfspnode, pnode_peer_slave);
> +	get_pnode(pnode);
> +
> +	context->pnode = pnode;
> +	context->master_pnode = master_pnode;
> +	spin_unlock(&vfspnode_lock);
> +	return 1;
> +}
> +
> +/*
> + * skip the rest of the tree, cleaning up
> + * reference to pnodes held in pnode_next().
> + */
> +static void pnode_end(struct pcontext *context)
> +{
> +	struct vfspnode *p = context->pnode;
> +	struct vfspnode *start = context->start;
> +
> +	do {
> +		put_pnode(p);
> +	} while (p != start && (p = p->pnode_master));
> +	return;
> +}
> +
> +/*
> + * traverse the pnode tree and at each pnode encountered, execute the
> + * pnode_fnc(). For each vfsmount encountered call the vfs_fnc().
> + *
> + * @pnode: pnode tree to be traversed
> + * @in_data: input data
> + * @out_data: output data
> + * @pnode_func: function to be called when a new pnode is encountered.
> + * @vfs_func: function to be called on each slave and member vfs belonging
> + * 		to the pnode.
> + */
> +static int pnode_traverse(struct vfspnode *pnode,
> +		void *in_data,
> +		void **out_data,
> +		int (*pnode_pre_func)(struct vfspnode *,
> +			void *, void **, va_list),
> +		int (*pnode_post_func)(struct vfspnode *,
> +			void *, va_list),
> +		int (*vfs_func)(struct vfsmount *,
> +			enum pnode_vfs_type, void *,  va_list),
> +		...)
> +{
> +	va_list args;
> +	int ret = 0, level;
> +	void *my_data, *data_from_master;
> +     	struct vfspnode *master_pnode;
> +     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
> +	struct pcontext context;
> +	static void *p_array[PNODE_MAX_SLAVE_LEVEL];
> +
> +	context.start = pnode;
> +	context.pnode = NULL;
> +	/*
> +	 * determine whether to process vfs first or the
> +	 * slave pnode first
> +	 */
> +	while (pnode_next(&context)) {
> +		level = context.level;
> +
> +		if (level >= PNODE_MAX_SLAVE_LEVEL)
> +			goto error;
> +
> +		pnode = context.pnode;
> +		master_pnode = context.master_pnode;
> +
> +		if (master_pnode) {
> +			data_from_master = p_array[level-1];
> +			my_data = NULL;
> +		} else {
> +			data_from_master = NULL;
> +			my_data = in_data;
> +		}
> +
> +		if (pnode_pre_func) {
> +			va_start(args, vfs_func);
> +			if((ret = pnode_pre_func(pnode,
> +				data_from_master, &my_data, args)))
> +				goto error;
> +			va_end(args);
> +		}
> +
> +		// traverse member vfsmounts
> +		spin_lock(&vfspnode_lock);
> +		list_for_each_entry_safe(member_mnt,
> +			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
> +
> +			spin_unlock(&vfspnode_lock);
> +			va_start(args, vfs_func);
> +			if ((ret = vfs_func(member_mnt,
> +				PNODE_MEMBER_VFS, my_data, args)))
> +				goto error;
> +			va_end(args);
> +			spin_lock(&vfspnode_lock);
> +		}
> +		list_for_each_entry_safe(slave_mnt, t_m,
> +			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
> +
> +			spin_unlock(&vfspnode_lock);
> +			va_start(args, vfs_func);
> +			if ((ret = vfs_func(slave_mnt, PNODE_SLAVE_VFS,
> +				my_data, args)))
> +				goto error;
> +			va_end(args);
> +			spin_lock(&vfspnode_lock);
> +		}
> +		spin_unlock(&vfspnode_lock);
> +
> +		if (pnode_post_func) {
> +			va_start(args, vfs_func);
> +			if((ret = pnode_post_func(pnode,
> +				my_data, args)))
> +				goto error;
> +			va_end(args);
> +		}
> +
> +		p_array[level] = my_data;
> +	}
> +out:
> +	if (out_data)
> +		*out_data = p_array[0];
> +	return ret;
> +error:
> +	va_end(args);
> +	pnode_end(&context);
> +	goto out;
> +}
> 

And this is the worst part.  As I said earlier, void pointers and
variable argument functions have no place in this kind of code.

I think you could get rid of all these if you'd implement a simple
iterator function which returns the traversed vfsmounts.  That's
another big argument for getting rid of struct pnode: you could do
iteration simply by holding onto a vfsmount pointer, instead of having
to do a two level iteration, once over pnodes, then over vfsmounts.

> +extern spinlock_t vfspnode_lock;
> +extern void __put_pnode(struct vfspnode *);
> +
> +static inline struct vfspnode *
> +get_pnode(struct vfspnode *pnode)
> +{
> +	if (!pnode)
> +		return NULL;
> +	atomic_inc(&pnode->pnode_count);
> +	return pnode;
> +}
> +
> +static inline void
> +put_pnode(struct vfspnode *pnode)
> +{
> +	if (!pnode)
> +		return;
> +	if (atomic_dec_and_lock(&pnode->pnode_count, &vfspnode_lock)) {
> +		__put_pnode(pnode);
> +		spin_unlock(&vfspnode_lock);
> +	}
> +}

Unnecessary.

> +#define MNT_PRIVATE	0x10  /* if the vfsmount is private, by default it is private*/

If by default it's private, why is this flag needed?

Miklos
