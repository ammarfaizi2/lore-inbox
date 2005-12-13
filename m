Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVLMSDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVLMSDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVLMSDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:03:00 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:49026 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030187AbVLMSC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:02:58 -0500
Date: Tue, 13 Dec 2005 10:03:15 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrinks dentry struct
Message-ID: <20051213180315.GB14158@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <121a28810511282317j47a90f6t@mail.gmail.com> <20051129000916.6306da8b.akpm@osdl.org> <438C7218.8030109@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438C7218.8030109@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 04:22:00PM +0100, Eric Dumazet wrote:
> Hi Andrew
> 
> Could you add this patch to mm ?
> 
> Thank you
> 
> [PATCH] shrinks dentry struct
> 
> Some long time ago, dentry struct was carefully tuned so that on 32 bits 
> UP, sizeof(struct dentry) was exactly 128, ie a power of 2, and a multiple 
> of memory cache lines.
> 
> Then RCU was added and dentry struct enlarged by two pointers, with nice 
> results for SMP, but not so good on UP, because breaking the above tuning 
> (128 + 8 = 136 bytes)
> 
> This patch reverts this unwanted side effect, by using an union (d_u), 
> where d_rcu and d_child are placed so that these two fields can share their 
> memory needs.
> 
> At the time d_free() is called (and d_rcu is really used), d_child is known 
> to be empty and not touched by the dentry freeing.
> 
> Lockless lookups only access d_name, d_parent, d_lock, d_op, d_flags (so 
> the previous content of d_child is not needed if said dentry was unhashed 
> but still accessed by a CPU because of RCU constraints)
> 
> As dentry cache easily contains millions of entries, a size reduction is 
> worth the extra complexity of the ugly C union.

Looks sound to me!  Some opportunities for simplification below.

(Please accept my apologies for the delay -- some diversions turned out
to be more consuming than I had expected.)

							Thanx, Paul

> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
> 

> --- linux-2.6.15-rc3/include/linux/dcache.h	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/include/linux/dcache.h	2005-11-29 12:04:54.000000000 +0100
> @@ -95,14 +95,19 @@
>  	struct qstr d_name;
>  
>  	struct list_head d_lru;		/* LRU list */
> -	struct list_head d_child;	/* child of parent list */
> +	/*
> +	 * d_child and d_rcu can share memory
> +	 */
> +	union {
> +		struct list_head d_child;	/* child of parent list */
> +	 	struct rcu_head d_rcu;
> +	} d_u;
>  	struct list_head d_subdirs;	/* our children */
>  	struct list_head d_alias;	/* inode alias list */
>  	unsigned long d_time;		/* used by d_revalidate */
>  	struct dentry_operations *d_op;
>  	struct super_block *d_sb;	/* The root of the dentry tree */
>  	void *d_fsdata;			/* fs-specific data */
> - 	struct rcu_head d_rcu;
>  	struct dcookie_struct *d_cookie; /* cookie, if any */
>  	int d_mounted;
>  	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
> --- linux-2.6.15-rc3/fs/dcache.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/dcache.c	2005-11-29 15:07:10.000000000 +0100
> @@ -71,7 +71,7 @@
>  
>  static void d_callback(struct rcu_head *head)
>  {
> -	struct dentry * dentry = container_of(head, struct dentry, d_rcu);
> +	struct dentry * dentry = container_of(head, struct dentry, d_u.d_rcu);
>  
>  	if (dname_external(dentry))
>  		kfree(dentry->d_name.name);
> @@ -86,7 +86,7 @@
>  {
>  	if (dentry->d_op && dentry->d_op->d_release)
>  		dentry->d_op->d_release(dentry);
> - 	call_rcu(&dentry->d_rcu, d_callback);
> + 	call_rcu(&dentry->d_u.d_rcu, d_callback);
>  }
>  
>  /*
> @@ -193,7 +193,7 @@
>    			list_del(&dentry->d_lru);
>    			dentry_stat.nr_unused--;
>    		}
> -  		list_del(&dentry->d_child);
> +  		list_del(&dentry->d_u.d_child);
>  		dentry_stat.nr_dentry--;	/* For d_free, below */
>  		/*drops the locks, at that point nobody can reach this dentry */
>  		dentry_iput(dentry);
> @@ -367,7 +367,7 @@
>  	struct dentry * parent;
>  
>  	__d_drop(dentry);
> -	list_del(&dentry->d_child);
> +	list_del(&dentry->d_u.d_child);
>  	dentry_stat.nr_dentry--;	/* For d_free, below */
>  	dentry_iput(dentry);
>  	parent = dentry->d_parent;
> @@ -518,7 +518,7 @@
>  resume:
>  	while (next != &this_parent->d_subdirs) {
>  		struct list_head *tmp = next;
> -		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
> +		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
>  		next = tmp->next;
>  		/* Have we found a mount point ? */
>  		if (d_mountpoint(dentry))
> @@ -532,7 +532,7 @@
>  	 * All done at this level ... ascend and resume the search.
>  	 */
>  	if (this_parent != parent) {
> -		next = this_parent->d_child.next; 
> +		next = this_parent->d_u.d_child.next; 
>  		this_parent = this_parent->d_parent;
>  		goto resume;
>  	}
> @@ -569,7 +569,7 @@
>  resume:
>  	while (next != &this_parent->d_subdirs) {
>  		struct list_head *tmp = next;
> -		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
> +		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
>  		next = tmp->next;
>  
>  		if (!list_empty(&dentry->d_lru)) {
> @@ -610,7 +610,7 @@
>  	 * All done at this level ... ascend and resume the search.
>  	 */
>  	if (this_parent != parent) {
> -		next = this_parent->d_child.next; 
> +		next = this_parent->d_u.d_child.next; 
>  		this_parent = this_parent->d_parent;
>  #ifdef DCACHE_DEBUG
>  printk(KERN_DEBUG "select_parent: ascending to %s/%s, found=%d\n",
> @@ -753,12 +753,12 @@
>  		dentry->d_parent = dget(parent);
>  		dentry->d_sb = parent->d_sb;
>  	} else {
> -		INIT_LIST_HEAD(&dentry->d_child);
> +		INIT_LIST_HEAD(&dentry->d_u.d_child);
>  	}
>  
>  	spin_lock(&dcache_lock);
>  	if (parent)
> -		list_add(&dentry->d_child, &parent->d_subdirs);
> +		list_add(&dentry->d_u.d_child, &parent->d_subdirs);
>  	dentry_stat.nr_dentry++;
>  	spin_unlock(&dcache_lock);
>  
> @@ -1310,8 +1310,8 @@
>  	/* Unhash the target: dput() will then get rid of it */
>  	__d_drop(target);
>  
> -	list_del(&dentry->d_child);
> -	list_del(&target->d_child);
> +	list_del(&dentry->d_u.d_child);
> +	list_del(&target->d_u.d_child);
>  
>  	/* Switch the names.. */
>  	switch_names(dentry, target);
> @@ -1322,15 +1322,15 @@
>  	if (IS_ROOT(dentry)) {
>  		dentry->d_parent = target->d_parent;
>  		target->d_parent = target;
> -		INIT_LIST_HEAD(&target->d_child);
> +		INIT_LIST_HEAD(&target->d_u.d_child);
>  	} else {
>  		do_switch(dentry->d_parent, target->d_parent);
>  
>  		/* And add them back to the (new) parent lists */
> -		list_add(&target->d_child, &target->d_parent->d_subdirs);
> +		list_add(&target->d_u.d_child, &target->d_parent->d_subdirs);
>  	}
>  
> -	list_add(&dentry->d_child, &dentry->d_parent->d_subdirs);
> +	list_add(&dentry->d_u.d_child, &dentry->d_parent->d_subdirs);
>  	spin_unlock(&target->d_lock);
>  	spin_unlock(&dentry->d_lock);
>  	write_sequnlock(&rename_lock);
> @@ -1568,7 +1568,7 @@
>  resume:
>  	while (next != &this_parent->d_subdirs) {
>  		struct list_head *tmp = next;
> -		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
> +		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
>  		next = tmp->next;
>  		if (d_unhashed(dentry)||!dentry->d_inode)
>  			continue;
> @@ -1579,7 +1579,7 @@
>  		atomic_dec(&dentry->d_count);
>  	}
>  	if (this_parent != root) {
> -		next = this_parent->d_child.next; 
> +		next = this_parent->d_u.d_child.next; 
>  		atomic_dec(&this_parent->d_count);
>  		this_parent = this_parent->d_parent;
>  		goto resume;
> --- linux-2.6.15-rc3/fs/autofs4/autofs_i.h	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/autofs4/autofs_i.h	2005-11-29 12:04:54.000000000 +0100
> @@ -209,7 +209,7 @@
>  	struct dentry *child;
>  	int ret = 0;
>  
> -	list_for_each_entry(child, &dentry->d_subdirs, d_child)
> +	list_for_each_entry(child, &dentry->d_subdirs, d_u.d_child)
>  		if (simple_positive(child))
>  			goto out;
>  	ret = 1;
> --- linux-2.6.15-rc3/fs/autofs4/expire.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/autofs4/expire.c	2005-11-29 12:04:54.000000000 +0100
> @@ -105,7 +105,7 @@
>  	next = this_parent->d_subdirs.next;
>  resume:
>  	while (next != &this_parent->d_subdirs) {
> -		struct dentry *dentry = list_entry(next, struct dentry, d_child);
> +		struct dentry *dentry = list_entry(next, struct dentry, d_u.d_child);
>  
>  		/* Negative dentry - give up */
>  		if (!simple_positive(dentry)) {
> @@ -138,7 +138,7 @@
>  	}
>  
>  	if (this_parent != top) {
> -		next = this_parent->d_child.next;
> +		next = this_parent->d_u.d_child.next;
>  		this_parent = this_parent->d_parent;
>  		goto resume;
>  	}
> @@ -163,7 +163,7 @@
>  	next = this_parent->d_subdirs.next;
>  resume:
>  	while (next != &this_parent->d_subdirs) {
> -		struct dentry *dentry = list_entry(next, struct dentry, d_child);
> +		struct dentry *dentry = list_entry(next, struct dentry, d_u.d_child);
>  
>  		/* Negative dentry - give up */
>  		if (!simple_positive(dentry)) {
> @@ -199,7 +199,7 @@
>  	}
>  
>  	if (this_parent != parent) {
> -		next = this_parent->d_child.next;
> +		next = this_parent->d_u.d_child.next;
>  		this_parent = this_parent->d_parent;
>  		goto resume;
>  	}
> @@ -238,7 +238,7 @@
>  	/* On exit from the loop expire is set to a dgot dentry
>  	 * to expire or it's NULL */
>  	while ( next != &root->d_subdirs ) {
> -		struct dentry *dentry = list_entry(next, struct dentry, d_child);
> +		struct dentry *dentry = list_entry(next, struct dentry, d_u.d_child);
>  
>  		/* Negative dentry - give up */
>  		if ( !simple_positive(dentry) ) {
> @@ -302,7 +302,7 @@
>  			expired, (int)expired->d_name.len, expired->d_name.name);
>  		spin_lock(&dcache_lock);
>  		list_del(&expired->d_parent->d_subdirs);
> -		list_add(&expired->d_parent->d_subdirs, &expired->d_child);
> +		list_add(&expired->d_parent->d_subdirs, &expired->d_u.d_child);
>  		spin_unlock(&dcache_lock);
>  		return expired;
>  	}
> --- linux-2.6.15-rc3/fs/autofs4/inode.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/autofs4/inode.c	2005-11-29 12:04:54.000000000 +0100
> @@ -91,7 +91,7 @@
>  	next = this_parent->d_subdirs.next;
>  resume:
>  	while (next != &this_parent->d_subdirs) {
> -		struct dentry *dentry = list_entry(next, struct dentry, d_child);
> +		struct dentry *dentry = list_entry(next, struct dentry, d_u.d_child);
>  
>  		/* Negative dentry - don`t care */
>  		if (!simple_positive(dentry)) {
> @@ -117,7 +117,7 @@
>  	if (this_parent != sbi->root) {
>  		struct dentry *dentry = this_parent;
>  
> -		next = this_parent->d_child.next;
> +		next = this_parent->d_u.d_child.next;
>  		this_parent = this_parent->d_parent;
>  		spin_unlock(&dcache_lock);
>  		DPRINTK("parent dentry %p %.*s",
> --- linux-2.6.15-rc3/fs/coda/cache.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/coda/cache.c	2005-11-29 12:05:21.000000000 +0100
> @@ -93,7 +93,7 @@
>  	spin_lock(&dcache_lock);
>  	list_for_each(child, &parent->d_subdirs)
>  	{
> -		de = list_entry(child, struct dentry, d_child);
> +		de = list_entry(child, struct dentry, d_u.d_child);

The above list_entry() could be combined with the earlier list_for_each()
using list_for_each_entry().

>  		/* don't know what to do with negative dentries */
>  		if ( ! de->d_inode ) 
>  			continue;
> --- linux-2.6.15-rc3/fs/libfs.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/libfs.c	2005-11-29 14:58:51.000000000 +0100
> @@ -93,16 +93,16 @@
>  			loff_t n = file->f_pos - 2;
>  
>  			spin_lock(&dcache_lock);
> -			list_del(&cursor->d_child);
> +			list_del(&cursor->d_u.d_child);
>  			p = file->f_dentry->d_subdirs.next;
>  			while (n && p != &file->f_dentry->d_subdirs) {
>  				struct dentry *next;
> -				next = list_entry(p, struct dentry, d_child);
> +				next = list_entry(p, struct dentry, d_u.d_child);

Should be possible to combine the list_entry() and the while() into
list_for_each_entry().

>  				if (!d_unhashed(next) && next->d_inode)
>  					n--;
>  				p = p->next;
>  			}
> -			list_add_tail(&cursor->d_child, p);
> +			list_add_tail(&cursor->d_u.d_child, p);
>  			spin_unlock(&dcache_lock);
>  		}
>  	}
> @@ -126,7 +126,7 @@
>  {
>  	struct dentry *dentry = filp->f_dentry;
>  	struct dentry *cursor = filp->private_data;
> -	struct list_head *p, *q = &cursor->d_child;
> +	struct list_head *p, *q = &cursor->d_u.d_child;
>  	ino_t ino;
>  	int i = filp->f_pos;
>  
> @@ -153,7 +153,7 @@
>  			}
>  			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
>  				struct dentry *next;
> -				next = list_entry(p, struct dentry, d_child);
> +				next = list_entry(p, struct dentry, d_u.d_child);

Ditto...

>  				if (d_unhashed(next) || !next->d_inode)
>  					continue;
>  
> @@ -261,7 +261,7 @@
>  	int ret = 0;
>  
>  	spin_lock(&dcache_lock);
> -	list_for_each_entry(child, &dentry->d_subdirs, d_child)
> +	list_for_each_entry(child, &dentry->d_subdirs, d_u.d_child)
>  		if (simple_positive(child))
>  			goto out;
>  	ret = 1;
> --- linux-2.6.15-rc3/fs/ncpfs/dir.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/ncpfs/dir.c	2005-11-29 14:59:31.000000000 +0100
> @@ -365,7 +365,7 @@
>  	spin_lock(&dcache_lock);
>  	next = parent->d_subdirs.next;
>  	while (next != &parent->d_subdirs) {
> -		dent = list_entry(next, struct dentry, d_child);
> +		dent = list_entry(next, struct dentry, d_u.d_child);

Ditto...

>  		if ((unsigned long)dent->d_fsdata == fpos) {
>  			if (dent->d_inode)
>  				dget_locked(dent);
> --- linux-2.6.15-rc3/fs/ncpfs/ncplib_kernel.h	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/ncpfs/ncplib_kernel.h	2005-11-29 14:59:31.000000000 +0100
> @@ -196,7 +196,7 @@
>  	spin_lock(&dcache_lock);
>  	next = parent->d_subdirs.next;
>  	while (next != &parent->d_subdirs) {
> -		dentry = list_entry(next, struct dentry, d_child);
> +		dentry = list_entry(next, struct dentry, d_u.d_child);

Ditto...

>  
>  		if (dentry->d_fsdata == NULL)
>  			ncp_age_dentry(server, dentry);
> @@ -218,7 +218,7 @@
>  	spin_lock(&dcache_lock);
>  	next = parent->d_subdirs.next;
>  	while (next != &parent->d_subdirs) {
> -		dentry = list_entry(next, struct dentry, d_child);
> +		dentry = list_entry(next, struct dentry, d_u.d_child);

Ditto...

>  		dentry->d_fsdata = NULL;
>  		ncp_age_dentry(server, dentry);
>  		next = next->next;
> --- linux-2.6.15-rc3/fs/smbfs/cache.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/fs/smbfs/cache.c	2005-11-29 14:59:47.000000000 +0100
> @@ -66,7 +66,7 @@
>  	spin_lock(&dcache_lock);
>  	next = parent->d_subdirs.next;
>  	while (next != &parent->d_subdirs) {
> -		dentry = list_entry(next, struct dentry, d_child);
> +		dentry = list_entry(next, struct dentry, d_u.d_child);

Ditto...

>  		dentry->d_fsdata = NULL;
>  		smb_age_dentry(server, dentry);
>  		next = next->next;
> @@ -100,7 +100,7 @@
>  	spin_lock(&dcache_lock);
>  	next = parent->d_subdirs.next;
>  	while (next != &parent->d_subdirs) {
> -		dent = list_entry(next, struct dentry, d_child);
> +		dent = list_entry(next, struct dentry, d_u.d_child);

Ditto...

>  		if ((unsigned long)dent->d_fsdata == fpos) {
>  			if (dent->d_inode)
>  				dget_locked(dent);
> --- linux-2.6.15-rc3/kernel/cpuset.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/kernel/cpuset.c	2005-11-29 15:01:01.000000000 +0100
> @@ -304,7 +304,7 @@
>  	spin_lock(&dcache_lock);
>  	node = dentry->d_subdirs.next;
>  	while (node != &dentry->d_subdirs) {
> -		struct dentry *d = list_entry(node, struct dentry, d_child);
> +		struct dentry *d = list_entry(node, struct dentry, d_u.d_child);

Ditto...

>  		list_del_init(node);
>  		if (d->d_inode) {
>  			d = dget_locked(d);
> @@ -316,7 +316,7 @@
>  		}
>  		node = dentry->d_subdirs.next;
>  	}
> -	list_del_init(&dentry->d_child);
> +	list_del_init(&dentry->d_u.d_child);
>  	spin_unlock(&dcache_lock);
>  	remove_dir(dentry);
>  }
> --- linux-2.6.15-rc3/drivers/usb/core/inode.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/drivers/usb/core/inode.c	2005-11-29 12:04:54.000000000 +0100
> @@ -186,7 +186,7 @@
>  
>  	down(&bus->d_inode->i_sem);
>  
> -	list_for_each_entry(dev, &bus->d_subdirs, d_child)
> +	list_for_each_entry(dev, &bus->d_subdirs, d_u.d_child)
>  		if (dev->d_inode)
>  			update_dev(dev);
>  
> @@ -203,7 +203,7 @@
>  
>  	down(&root->d_inode->i_sem);
>  
> -	list_for_each_entry(bus, &root->d_subdirs, d_child) {
> +	list_for_each_entry(bus, &root->d_subdirs, d_u.d_child) {
>  		if (bus->d_inode) {
>  			switch (S_IFMT & bus->d_inode->i_mode) {
>  			case S_IFDIR:
> @@ -319,7 +319,7 @@
>  	spin_lock(&dcache_lock);
>  
>  	list_for_each(list, &dentry->d_subdirs) {
> -		struct dentry *de = list_entry(list, struct dentry, d_child);
> +		struct dentry *de = list_entry(list, struct dentry, d_u.d_child);

The list_entry() and list_for_each() could be combined.

>  		if (usbfs_positive(de)) {
>  			spin_unlock(&dcache_lock);
>  			return 0;
> --- linux-2.6.15-rc3/net/sunrpc/rpc_pipe.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/net/sunrpc/rpc_pipe.c	2005-11-29 15:01:01.000000000 +0100
> @@ -492,7 +492,7 @@
>  repeat:
>  	spin_lock(&dcache_lock);
>  	list_for_each_safe(pos, next, &parent->d_subdirs) {
> -		dentry = list_entry(pos, struct dentry, d_child);
> +		dentry = list_entry(pos, struct dentry, d_u.d_child);
>  		spin_lock(&dentry->d_lock);
>  		if (!d_unhashed(dentry)) {
>  			dget_locked(dentry);
> --- linux-2.6.15-rc3/security/selinux/selinuxfs.c	2005-11-29 04:51:27.000000000 +0100
> +++ linux-2.6.15-rc3-ed/security/selinux/selinuxfs.c	2005-11-29 15:01:09.000000000 +0100
> @@ -889,7 +889,7 @@
>  	spin_lock(&dcache_lock);
>  	node = de->d_subdirs.next;
>  	while (node != &de->d_subdirs) {
> -		struct dentry *d = list_entry(node, struct dentry, d_child);
> +		struct dentry *d = list_entry(node, struct dentry, d_u.d_child);

The list_entry() and while() could be combined.

>  		list_del_init(node);
>  
>  		if (d->d_inode) {

