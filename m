Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSFRWUy>; Tue, 18 Jun 2002 18:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317647AbSFRWUx>; Tue, 18 Jun 2002 18:20:53 -0400
Received: from hera.cwi.nl ([192.16.191.8]:25583 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317641AbSFRWUh>;
	Tue, 18 Jun 2002 18:20:37 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 19 Jun 2002 00:19:53 +0200 (MEST)
Message-Id: <UTC200206182219.g5IMJru27250.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: [PATCH+discussion] symlink recursion
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As promised below an implementation of nonrecursive symlink resolution.

First a small remark or question.
Unless I overlook something, a path_release is missing in:

--- namei.c~    Sun Jun  9 07:28:50 2002
+++ namei.c     Wed Jun 19 00:00:36 2002
@@ -2074,8 +2074,10 @@
         * bloody create() on broken symlinks. Furrfu...
         */
        name = __getname();
-       if (!name)
+       if (!name) {
+               path_release(nd);
                return -ENOMEM;
+       }
        strcpy(name, nd->last.name);
        nd->last.name = name;
        return 0;


Al?

The source below is a fragment that shows the implementation
of link_path_walk. I give it as source since a patch would
be unreadable. I advise nobody to try it out, and have not
done so myself. Nevertheless, this, or something very close to it,
could replace the present code.
It is a straightforward transformation of the existing code,
so does exactly the same if I made no mistake - but after two
hours of tricky editing there is bound to be a flaw somewhere.
Will check more carefully later.

The state shown below is such that the isomorphism with the existing code
is still very visible. Further transformation would make the code slightly
more efficient.

> you still have recursion to eliminate and
> that's where the hell will begin.

Al, as you can see, no hell. Almost the same code as we had,
only slightly differently arranged.

[Here there is a kmalloc when a link is followed.
Some futher transformation avoids the kmalloc when during path resolution
the recursion depth stays below 2, that is, when we never need to resolve
a symlink during symlink resolution. More improvements are possible.
I do not think this would be measurably slower than what we have.]

[The astute reader will remark that link_path_walk() is only 80% of the
story, since open_namei() has a do_follow_link_nocount().
There are various ways to handle that, there is no essential problem.]

Andries

-------------------------------
struct path {
	struct vfsmount *mnt;
	struct dentry *dentry;
};

struct link_work {
	const char *name;
	struct path next, pinned;
	unsigned int flags;
	struct page *page_to_free;
	const char *link_to_free;
	struct link_work *lw_next;
};

static inline void
free_page_and_link(struct link_work *alw) {
	struct page *page;

	page = alw->page_to_free;
	if (page) {
		kunmap(page);
		page_cache_release(page);
	}
	kfree (alw->link_to_free);
}

static int do_link_item(struct link_work **lw, struct nameidata *nd)
{
	const char *name;
	struct inode *inode;
	struct path next;
	unsigned long hash;
	struct qstr this;
	unsigned int c;
	int err;

	name = (*lw)->name;
	inode = nd->dentry->d_inode;

	err = exec_permission_lite(inode);
	if (err == -EAGAIN) {
		unlock_nd(nd);
		err = permission(inode, MAY_EXEC);
		lock_nd(nd);
	}
	if (err)
		goto error_return;

	this.name = name;
	c = *(const unsigned char *)name;

	hash = init_name_hash();
	do {
		name++;
		hash = partial_name_hash(c, hash);
		c = *(const unsigned char *)name;
	} while (c && (c != '/'));
	this.len = name - (const char *) this.name;
	this.hash = end_name_hash(hash);

	/* remove trailing slashes? */
	if (!c)
		goto last_component;
	while (*++name == '/');
	if (!*name)
		goto last_with_slashes;
	(*lw)->name = name;

	/*
	 * "." and ".." are special - ".." especially so because it has
	 * to be able to know about the current root directory and
	 * parent relationships.
	 */
	if (this.name[0] == '.') switch (this.len) {
	default:
		break;
	case 2:	
		if (this.name[1] != '.')
			break;
		follow_dotdot(&nd->mnt, &nd->dentry);
		inode = nd->dentry->d_inode;
		/* fallthrough */
	case 1:
		return 0;
	}

	/*
	 * See if the low-level filesystem might want
	 * to use its own hash..
	 */
	if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
		err = nd->dentry->d_op->d_hash(nd->dentry, &this);
		if (err < 0)
			goto error_return;
	}
	/* This does the actual lookups.. */
	err = do_lookup(nd, &this, &next, &((**lw).pinned),
			LOOKUP_CONTINUE);
	if (err)
		goto error_return;
	/* Check mountpoints.. */
	follow_mount(&next.mnt, &next.dentry);

	err = -ENOENT;
	inode = next.dentry->d_inode;
	if (!inode)
		goto error_return;
	err = -ENOTDIR; 
	if (!inode->i_op)
		goto error_return;

	if (inode->i_op->prepare_follow_link)
		goto nonlast_is_symlink;

	nd->mnt = next.mnt;
	nd->dentry = next.dentry;

	/* err = -ENOTDIR */
	if (!inode->i_op->lookup)
		goto error_return;
	return 0;

 error_return:
	unlock_nd(nd);
	path_release(nd);
	return err;

 last_with_slashes:
	(*lw)->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 last_component:
	(*lw)->name = NULL;

	if ((*lw)->flags & LOOKUP_PARENT)
		goto lookup_parent;

	if (this.name[0] == '.') switch (this.len) {
	default:
		break;
	case 2:	
		if (this.name[1] != '.')
			break;
		follow_dotdot(&nd->mnt, &nd->dentry);
		inode = nd->dentry->d_inode;
		/* fallthrough */
	case 1:
		return 0;
	}

	if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
		err = nd->dentry->d_op->d_hash(nd->dentry, &this);
		if (err < 0)
			goto error_return;
	}
	err = do_lookup(nd, &this, &next, &((**lw).pinned), 0);
	if (err)
		goto error_return;
	follow_mount(&next.mnt, &next.dentry);
	inode = next.dentry->d_inode;
	if (((*lw)->flags & LOOKUP_FOLLOW)
	    && inode && inode->i_op
	    && inode->i_op->prepare_follow_link)
		goto last_is_symlink;

	nd->mnt = next.mnt;
	nd->dentry = next.dentry;

	err = -ENOENT;
	if (!inode)
		goto error_return;
	if ((*lw)->flags & LOOKUP_DIRECTORY) {
		err = -ENOTDIR; 
		if (!inode->i_op || !inode->i_op->lookup)
			goto error_return;
	}
	return 0;

 lookup_parent:
	nd->last = this;
	nd->last_type = LAST_NORM;
	if (this.name[0] == '.') {
		if (this.len == 1)
			nd->last_type = LAST_DOT;
		else if (this.len == 2 && this.name[1] == '.')
			nd->last_type = LAST_DOTDOT;
	}
	return 0;

 nonlast_is_symlink:
	(*lw)->flags |= LOOKUP_DIRECTORY;

 last_is_symlink:
	mntget(next.mnt);
	dget_locked(next.dentry);
	unlock_nd(nd);

	if (current->link_count >= 5 ||
	    current->total_link_count >= 40)
		goto loop;

	if (need_resched()) {
		current->state = TASK_RUNNING;
		schedule();
	}

	current->link_count++;
	current->total_link_count++;

	/* err = do_follow_link_nocount(lw, next.dentry, nd); */
	{
		struct dentry *dentry = next.dentry;
		const char *link = NULL;
		struct page *page = NULL;
		char *name;
		struct link_work *alw;

		UPDATE_ATIME(dentry->d_inode);
		err = dentry->d_inode->i_op->prepare_follow_link(dentry, nd,
								 &link, &page);
		(*lw)->page_to_free = page;
		(*lw)->link_to_free = NULL;
		if (nd->flags & LOOKUP_KFREE_NEEDED) {
			nd->flags &= ~LOOKUP_KFREE_NEEDED;
			(*lw)->link_to_free = link;
		}

		if (nd->flags & LOOKUP_FOLLOW_DONE) {
			nd->flags &= ~LOOKUP_FOLLOW_DONE;
			goto follow_done;
		}
		if (err)
			goto follow_done;

		/* err = __vfs_follow_link(lw, nd, link); */

		if (IS_ERR(link))
			goto fail;

		if (*link == '/') {
			path_release(nd);
			if (!walk_init_root(link, nd))
				/* weird __emul_prefix() stuff did it */
				goto out;
			while (*link == '/')
				link++;
			if (!*link)
				goto follow_done;
		}
		lock_nd(nd);

		/* set up for recursive call */
		(*lw)->next = next;
		alw = kmalloc(sizeof(struct link_work), GFP_USER);
		if (alw == NULL) {
			path_release(nd);
			err = -ENOMEM;
			goto follow_done;
		}
		alw->name = link;
		alw->flags = LOOKUP_FOLLOW;
		alw->pinned = (struct path) {NULL, NULL};
		alw->lw_next = *lw;
		*lw = alw;
		return 0;	/* res = link_path_walk(link, nd); */

	out:
		if (current->link_count || err || nd->last_type != LAST_NORM)
			goto follow_done;

		/*
		 * If it is an iterative symlinks resolution in open_namei() we
		 * have to copy the last component. And all that crap because
		 * of bloody create() on broken symlinks. Furrfu...
		 */
		name = __getname();
		if (!name) {
			path_release(nd);
			err = -ENOMEM;
			goto follow_done;
		}
		strcpy(name, nd->last.name);
		nd->last.name = name;
		goto follow_done;
	fail:
		path_release(nd);
		err = PTR_ERR(link);

	follow_done:
		free_page_and_link(*lw);
	}

	current->link_count--;
	goto noloop;

 loop:
	path_release(nd);
	err = -ELOOP;

 noloop:
	dput(next.dentry);
	mntput(next.mnt);
	if (err)
		return err;
	lock_nd(nd);

	err = -ENOENT;
	inode = nd->dentry->d_inode;
	if (!inode)
		goto error_return;
	if ((*lw)->flags & LOOKUP_DIRECTORY) {
		err = -ENOTDIR; 
		if (!inode->i_op || !inode->i_op->lookup)
			goto error_return;
	}
	return 0;
}

static int
do_link_tail(struct link_work **lw, struct nameidata *nd) {
	int err = 0;
	char *name;
	struct path next;
	struct inode *inode;

	if (current->link_count || err || nd->last_type != LAST_NORM)
		goto follow_done;

	name = __getname();
	if (!name) {
		path_release(nd);
		err = -ENOMEM;
		goto follow_done;
	}
	strcpy(name, nd->last.name);
	nd->last.name = name;

 follow_done:
	free_page_and_link(*lw);

	current->link_count--;

	next = (*lw)->next;
	dput(next.dentry);
	mntput(next.mnt);
	if (err)
		return err;
	lock_nd(nd);

	err = -ENOENT;
	inode = nd->dentry->d_inode;
	if (!inode)
		goto error_return;
	if ((*lw)->flags & LOOKUP_DIRECTORY) {
		err = -ENOTDIR; 
		if (!inode->i_op || !inode->i_op->lookup)
			goto error_return;
	}
	return 0;

 error_return:
	unlock_nd(nd);
	path_release(nd);
	return err;
}

static void
do_bad_link_tail(struct link_work *alw) {
	struct path next;

	free_page_and_link(alw);
	current->link_count--;
	next = alw->next;
	dput(next.dentry);
	mntput(next.mnt);
}

/*
 * Name resolution.
 *
 * This is the basic name resolution function, turning a pathname
 * into the final dentry.
 *
 * We expect 'base' to be positive and a directory.
 *
 * nd is locked by caller, we unlock, and upon error also release
 */
static inline int
do_link_path_walk(struct link_work **lw, struct nameidata *nd)
{
	const char *name;
	int err = 0;

	(*lw)->pinned = (struct path) {NULL, NULL};

	name = (*lw)->name;
	while (*name == '/')
		name++;
	if (!*name)
		goto return_base;
	(*lw)->name = name;

	(*lw)->flags = nd->flags;

	/* At this point we know we have a real path component. */
	for(;;) {
		if ((*lw)->name)
			err = do_link_item(lw, nd);
		else if ((*lw)->lw_next) {
			struct link_work *alw = *lw;
			dput(alw->pinned.dentry);
			mntput(alw->pinned.mnt);
			*lw = alw->lw_next;
			kfree(alw);
			err = do_link_tail(lw, nd);
		} else
			break;
		if (err)
			goto return_err;
	}
	unlock_nd(nd);

return_err:
	while((*lw)->lw_next) {
		struct link_work *alw = *lw;
		dput(alw->pinned.dentry);
		mntput(alw->pinned.mnt);
		*lw = alw->lw_next;
		kfree(alw);
		do_bad_link_tail(*lw);
	}
	dput((*lw)->pinned.dentry);
	mntput((*lw)->pinned.mnt);
	return err;

return_base:
	unlock_nd(nd);
	return 0;
}

/* called in path_walk() and path_lookup() */
/* nd is locked by caller, we unlock */
static int
link_path_walk(const char * name, struct nameidata *nd)
{
	struct link_work slw;
	struct link_work *alw = &slw;
	slw.name = name;
	slw.lw_next = NULL;
	current->total_link_count = 0;
	return do_link_path_walk(&alw, nd);
}

/* called in __emul_lookup_dentry() and fs/nfsctl.c */
/* nd.{mnt,dentry,last_type,flags} are set */
int path_walk(const char * name, struct nameidata *nd)
{
	lock_nd(nd);
	return link_path_walk(name, nd);
}

