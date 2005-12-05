Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVLEG1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVLEG1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 01:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVLEG1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 01:27:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:40857 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751340AbVLEG1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 01:27:23 -0500
Date: Mon, 5 Dec 2005 11:54:39 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       viro@ftp.linux.org.uk
Subject: Re: [RFC] Updates to sysfs_create_subdir()
Message-ID: <20051205062439.GA4123@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net> <20051128204950.GC17740@kroah.com> <Pine.LNX.4.50.0511300759170.28582-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0511300759170.28582-100000@monsoon.he.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(cc-ing Al for his views)

On Wed, Nov 30, 2005 at 09:05:41AM -0800, Patrick Mochel wrote:
> 
> On Mon, 28 Nov 2005, Greg KH wrote:
> 
> > On Wed, Nov 23, 2005 at 01:56:29PM -0800, Patrick Mochel wrote:
> > >
> > > The patch below addresses this issue by parsing the subdirectory name and
> > > creating any parent directories delineated by a '/'.
> >

well, creating directory hierarchy for attributes in one shot could be 
useful in some cases, but is it worth putting more fuel to race conditions
in sysfs? I am afraid that there could be extra efforts also needed for 
userspace to manage the namespace collisions in sysfs. 

Nested attributes will not be straight forward. With this scheme do all
attributes in the attrbiute tree belong to same kobject?

> > Generally I never liked parsing stuff like this in the kernel (proc and
> > devfs both do this).  That being said, I do see the need to make subdirs
> > like this easier.
> 
> Heh, just because proc and devfs did it doesn't mean it's inherently
> evil..
> 
I don't like the current approach and agree with Greg about the path walking
code. IMO, leave the path walking for VFS to handle. The same goal of
creating the directory hierarchy for a given path name can be achieved
using __user_walk(). Though it will introduce new purpose of path walking
but it will save us from everybody writing path walking code. As of now
the __user_walk() gets to the bottom most path component and returns the 
inode. With a new lookup flag, lets say LOOKUP_CREATE_DIR, it could 
allow ->lookup() to keep creating direcotries for each path component walked.


> > But what about cleanups?  If I create an attribute group "foo/baz/x/" and
> > then remove it, will the subdirectories get cleaned up too?  What about
> > if I had created a group "foo/baz/y/" after the "x" one?  Or just
> > "foo/baz"?
> 
> The patch I sent previously did not include a way to cleanup the
> subdirectories, but it's pretty straightforward and covered by this patch.
> Basically, it adds a new refcount to struct sysfs_dirent (->s_refs) that
> is incremented when a subdirectory is created and decremented when the
> subdirectory is removed. When it reaches 0, that directory itself can be
> removed.
> 
> Note that it's a bit hacky in sysfs_remove_group(), since we need the
> bottom-most dentry a priori. 

well, it is buggy and racy. The patch is obviously untested. I don't 
think a separate ref count is needed here. There are already two ref 
counts (one with dentry, and one with sysfs_dirent).

> I'm not sure the best way to do this off the
> top of my head, and ideas?
> 
I am not clear, what are the semantics being decided for removal. I mean
whether remove the last component, or remove whatever is possible?

> (I'd like to also move the sysfs_dirent declaration into fs/sysfs/sysfs.h,
> since they're really private and so that further modification of the
> declaration doesn't preclude a nearly-full recompile of the tree).
> 

ok.. please move the SYSFS_ defines also.

Thanks
Maneesh


> Thanks,
> 
> 
> 	Pat
> 
> diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
> index 59734ba..b6bf33d 100644
> --- a/fs/sysfs/dir.c
> +++ b/fs/sysfs/dir.c
> @@ -42,6 +42,7 @@ static struct sysfs_dirent * sysfs_new_d
>  		return NULL;
> 
>  	memset(sd, 0, sizeof(*sd));
> +	atomic_set(&sd->s_refs, 1);
>  	atomic_set(&sd->s_count, 1);
>  	INIT_LIST_HEAD(&sd->s_children);
>  	list_add(&sd->s_sibling, &parent_sd->s_children);
> @@ -70,6 +71,7 @@ int sysfs_make_dirent(struct sysfs_diren
>  	return 0;
>  }
> 
> +
>  static int init_dir(struct inode * inode)
>  {
>  	inode->i_op = &sysfs_dir_inode_operations;
> @@ -94,38 +96,134 @@ static int init_symlink(struct inode * i
>  }
> 
>  static int create_dir(struct kobject * k, struct dentry * p,
> -		      const char * n, struct dentry ** d)
> +		      struct dentry * dir)
>  {
>  	int error;
>  	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
> 
> -	down(&p->d_inode->i_sem);
> -	*d = lookup_one_len(n, p, strlen(n));
> -	if (!IS_ERR(*d)) {
> -		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
> +	error = sysfs_make_dirent(p->d_fsdata, dir, k, mode, SYSFS_DIR);
> +	if (!error) {
> +		error = sysfs_create(dir, mode, init_dir);
>  		if (!error) {
> -			error = sysfs_create(*d, mode, init_dir);
> -			if (!error) {
> -				p->d_inode->i_nlink++;
> -				(*d)->d_op = &sysfs_dentry_ops;
> -				d_rehash(*d);
> -			}
> +			p->d_inode->i_nlink++;
> +			dir->d_op = &sysfs_dentry_ops;
> +			d_rehash(dir);
>  		}
> -		if (error && (error != -EEXIST)) {
> -			sysfs_put((*d)->d_fsdata);
> -			d_drop(*d);
> +		dput(dir);
> +	}
> +	if (error && (error != -EEXIST)) {
> +		sysfs_put((dir)->d_fsdata);
> +		d_drop(dir);
> +	}
> +
> +	return error;
> +}
> +
> +static int make_one_dir(struct kobject * k, struct dentry * parent,
> +			char * name, struct dentry ** d)
> +{
> +	struct sysfs_dirent * parent_sd = parent->d_fsdata;
> +	struct dentry * dir;
> +	int error = 0;
> +
> +	down(&parent->d_inode->i_sem);
> +
> +	dir = lookup_one_len(name, parent, strlen(name));
> +
> +	if (!IS_ERR(dir)) {
> +		/*
> +		 * Check if directory does or does not exist.
> +		 * If it does, add a ref to the dirent and return that dentry.
> +		 * Otherwise go ahead and create it.
> +		 */
> +		if (!dir->d_inode)
> +			error = create_dir(k, parent, dir);
> +		else {
> +			struct sysfs_dirent * sd = dir->d_fsdata;
> +			atomic_inc(&sd->s_refs);
>  		}
> -		dput(*d);
>  	} else
> -		error = PTR_ERR(*d);
> -	up(&p->d_inode->i_sem);
> +		error = PTR_ERR(dir);
> +
> +	atomic_inc(&parent_sd->s_refs);
> +	up(&parent->d_inode->i_sem);
> +
> +	if (!error)
> +		*d = dir;
> +
>  	return error;
>  }
> 
> 
> +/**
> + *	sysfs_create_subdir - Create one or more subdirectories in sysfs
> + *	@k:	kobject that owns the ancestral directory.
> + *	@n:	Directory (or directories) to be added.
> + *	@d:	The dentry of the bottom-most directory.
> + *
> + *	This function creates one or more subdirectories in a kobject's
> + *	sysfs directory, which can be used to add attributes for that
> + *	kobject (in an organized fashion).
> + *
> + *	The algorithm is simple: it scans @n for '/', replaces each
> + *	occurence with a NULL character and creates a directory with the name
> + *	of that resulting string. It continues until it reaches the end of @n.
> + *
> + *	For example, if @k had a directory at /sys/devices/my-device/, and
> + *	this function was called with @n == "foo/bar/baz", the resulting
> + *	directory structure would look like:
> + *
> + *	/sys/devices/my-device/
> + *	`-- foo
> + *	    `-- bar
> + *	        `-- baz
> + *
> + *	And the dentry to 'baz' would be passed back in @d.
> + *
> + *	Note that this function and its helpers have recently been updated to
> + *	recognize when a subdirectory has already been created and to return
> + *	without an error. So, after the above example was finished, a caller
> + *	could call this function with the same @k and @n == "foo". A new
> + *	directory would not be created and the dentry for 'foo' would be
> + *	returned in @d.
> + */
> +
>  int sysfs_create_subdir(struct kobject * k, const char * n, struct dentry ** d)
>  {
> -	return create_dir(k,k->dentry,n,d);
> +	struct dentry * parent = k->dentry;
> +	struct dentry * dir;
> +	char * str, * s;
> +	char * next;
> +	int ret;
> +
> +	s = str = kstrdup(n, GFP_KERNEL);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	while ((next = strchr(str, '/'))) {
> +		*next++ = '\0';
> +
> +		/*
> +		 * Check if it's the end of the string anyway
> +		 */
> +		if (*next == '\0')
> +			break;
> +
> +		ret = make_one_dir(k, parent, str, &dir);
> +		if (ret)
> +			goto Done;
> +
> +		str = next;
> +		parent = dir;
> +	}
> +
> +	/*
> +	 * Make the final directory (where the files will go).
> +	 */
> +	ret = make_one_dir(k, parent, str, d);
> + Done:
> +	kfree(s);
> +	return ret;
>  }
> 
>  /**
> @@ -136,7 +234,8 @@ int sysfs_create_subdir(struct kobject *
> 
>  int sysfs_create_dir(struct kobject * kobj)
>  {
> -	struct dentry * dentry = NULL;
> +	const char * name = kobject_name(kobj);
> +	struct dentry * dir;
>  	struct dentry * parent;
>  	int error = 0;
> 
> @@ -149,9 +248,16 @@ int sysfs_create_dir(struct kobject * ko
>  	else
>  		return -EFAULT;
> 
> -	error = create_dir(kobj,parent,kobject_name(kobj),&dentry);
> +	down(&parent->d_inode->i_sem);
> +	dir = lookup_one_len(name, parent, strlen(name));
> +	if (!IS_ERR(dir))
> +		error = create_dir(kobj, parent, dir);
> +	else
> +		error = PTR_ERR(dir);
> +	up(&parent->d_inode->i_sem);
> +
>  	if (!error)
> -		kobj->dentry = dentry;
> +		kobj->dentry = dir;
>  	return error;
>  }
> 
> @@ -257,9 +363,58 @@ static void remove_dir(struct dentry * d
>  	dput(parent);
>  }
> 
> -void sysfs_remove_subdir(struct dentry * d)
> +static void remove_one_subdir(struct kobject * k, struct dentry * parent, char * name)
>  {
> -	remove_dir(d);
> +	struct sysfs_dirent * sd;
> +	struct dentry * dir;
> +
> +	dir = lookup_one_len(name, parent, strlen(name));
> +
> + do_parent:
> +	if (!IS_ERR(dir)) {
> +		sd = dir->d_fsdata;
> +
> +		if (atomic_dec_and_test(&sd->s_refs)) {
> +			remove_dir(dir);
> +
> +			dir = dir->d_parent;
> +			goto do_parent;
> +		}
> +	}
> +}
> +
> +
> +void sysfs_remove_subdir(struct kobject * k, const char * n)
> +{
> +	struct dentry * parent = k->dentry;
> +	struct dentry * dir;
> +	char * str, * s;
> +	char * next;
> +
> +	s = str = kstrdup(n, GFP_KERNEL);
> +	if (!s)
> +		return;
> +
> +	while ((next = strchr(str, '/'))) {
> +		*next++ = '\0';
> +
> +		/*
> +		 * Check if it's the end of the string anyway
> +		 */
> +		if (*next == '\0')
> +			break;
> +
> +		remove_one_subdir(k, parent, str);
> +
> +		str = next;
> +		parent = dir;
> +	}
> +
> +	/*
> +	 * Remove the final directory (where the files were).
> +	 */
> +	remove_one_subdir(k, parent, str);
> +	kfree(s);
>  }
> 
> 
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 122145b..c998c74 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -57,7 +57,7 @@ int sysfs_create_group(struct kobject *
>  	dir = dget(dir);
>  	if ((error = create_files(dir,grp))) {
>  		if (grp->name)
> -			sysfs_remove_subdir(dir);
> +			sysfs_remove_subdir(kobj, grp->name);
>  	}
>  	dput(dir);
>  	return error;
> @@ -68,15 +68,37 @@ void sysfs_remove_group(struct kobject *
>  {
>  	struct dentry * dir;
> 
> -	if (grp->name)
> -		dir = lookup_one_len(grp->name, kobj->dentry,
> -				strlen(grp->name));
> -	else
> +	if (grp->name) {
> +		struct dentry * parent = kobj->dentry;
> +		char * str, * s;
> +		char * next;
> +		s = str = kstrdup(grp->name, GFP_KERNEL);
> +
> +		if (!s)
> +			return;
> +
> +		while ((next = strchr(str, '/'))) {
> +			*next++ = '\0';
> +
> +			/*
> +			 * Check if it's the end of the string anyway
> +			 */
> +			if (*next == '\0')
> +				break;
> +
> +			dir = lookup_one_len(str, parent, strlen(str));
> +
> +			str = next;
> +			parent = dir;
> +		}
> +		dir = lookup_one_len(str, parent, strlen(str));
> +		kfree(s);
> +	} else
>  		dir = dget(kobj->dentry);
> 
> -	remove_files(dir,grp);
> +	remove_files(dir, grp);
>  	if (grp->name)
> -		sysfs_remove_subdir(dir);
> +		sysfs_remove_subdir(kobj, grp->name);
>  	/* release the ref. taken in this routine */
>  	dput(dir);
>  }
> diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
> index 3f8953e..72f7dc2 100644
> --- a/fs/sysfs/sysfs.h
> +++ b/fs/sysfs/sysfs.h
> @@ -12,7 +12,7 @@ extern int sysfs_add_file(struct dentry
>  extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
> 
>  extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
> -extern void sysfs_remove_subdir(struct dentry *);
> +extern void sysfs_remove_subdir(struct kobject *, const char *);
> 
>  extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
>  extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 392da5a..86c4264 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -66,6 +66,7 @@ struct sysfs_ops {
>  };
> 
>  struct sysfs_dirent {
> +	atomic_t		s_refs;
>  	atomic_t		s_count;
>  	struct list_head	s_sibling;
>  	struct list_head	s_children;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
