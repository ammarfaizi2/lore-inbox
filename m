Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSGRSNy>; Thu, 18 Jul 2002 14:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSGRSNy>; Thu, 18 Jul 2002 14:13:54 -0400
Received: from vega.ipal.org ([209.102.192.64]:57987 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S318288AbSGRSNv>;
	Thu, 18 Jul 2002 14:13:51 -0400
Date: Thu, 18 Jul 2002 13:16:51 -0500
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filter /proc/mounts based on process root dir
Message-ID: <20020718181651.GA29042@vega.ipal.net>
References: <E17PUOo-0003ol-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17PUOo-0003ol-00@pmenage-dt.ensim.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 01:37:22PM -0700, Paul Menage wrote:

| This patch causes /proc/mounts to only display entries for mountpoints
| within the current process root. This makes df and friends behave more
| nicely in a chroot jail or with rootfs.
| 
| Most of the logic in proc_check_root() is moved to a new function,
| is_namespace_subdir(), which checks whether the given mount/dentry
| refers to a subdirectory of the process root directory in the current
| namespace. show_vfsmount() now returns without adding an output line if
| is_namespace_subdir() returns false for a given mountpoint.

Has anyone managed to back-port this patch to 2.4.18 or 2.4.19?

I've run into an inconsistency that I can't figure out.  The variable
"vfsmnt" turns up undefined.  Normally I'd think that would be due to
it being added in the new base code.  But in this case the patch is
deleting it.  OK, so that could be because the older code has another
reference to it that the newer code doesn't have, so the patch didn't
account for that.  But in this case, there's more to it than that.

In this part of the patch:

| diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/proc/base.c linux-2.5.24-mounts/fs/proc/base.c
| --- linux-2.5.24/fs/proc/base.c	Tue Jun 18 19:11:46 2002
| +++ linux-2.5.24-mounts/fs/proc/base.c	Wed Jun 26 01:19:01 2002
| @@ -265,42 +265,19 @@
|  
|  static int proc_check_root(struct inode *inode)
|  {
| -	struct dentry *de, *base, *root;
| -	struct vfsmount *our_vfsmnt, *vfsmnt, *mnt;
| +	struct dentry *root;
| +	struct vfsmount *mnt;

The above deletes the definition of "vfsmnt".  Then 3 lines down from
here, there is code used for context which has "vfsmnt" in used.  So
if this patch applies, it would be causing "vfsmnt" to be undefined
and also expecting it to be used.  If all uses of "vfsmnt" are moved
to another file, I would think the line below, which references the
address of it in the call to proc_root_link() would also be moved.

Anyone know what's going on with this?

|  	int res = 0;
|  
|  	if (proc_root_link(inode, &root, &vfsmnt)) /* Ewww... */
|  		return -ENOENT;
| -	read_lock(&current->fs->lock);
| -	our_vfsmnt = mntget(current->fs->rootmnt);
| -	base = dget(current->fs->root);
| -	read_unlock(&current->fs->lock);
|  
| -	spin_lock(&dcache_lock);
| -	de = root;
| -	mnt = vfsmnt;
| +	if(!is_namespace_subdir(mnt, root))
| +		res = -EACCES;
|  
| -	while (vfsmnt != our_vfsmnt) {
| -		if (vfsmnt == vfsmnt->mnt_parent)
| -			goto out;
| -		de = vfsmnt->mnt_mountpoint;
| -		vfsmnt = vfsmnt->mnt_parent;
| -	}
| -
| -	if (!is_subdir(de, base))
| -		goto out;
| -	spin_unlock(&dcache_lock);
| -
| -exit:
| -	dput(base);
| -	mntput(our_vfsmnt);
|  	dput(root);
|  	mntput(mnt);
|  	return res;
| -out:
| -	spin_unlock(&dcache_lock);
| -	res = -EACCES;
| -	goto exit;
|  }
|  
|  static int proc_permission(struct inode *inode, int mask)

[remainder of patch snipped]

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
