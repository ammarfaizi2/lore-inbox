Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVCJSPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVCJSPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVCJSKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:10:47 -0500
Received: from mivlgu.ru ([81.18.140.87]:36492 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S262782AbVCJRvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:51:09 -0500
Date: Thu, 10 Mar 2005 20:50:54 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lookup traps, for compact autofs/devfs functionality
Message-ID: <20050310175054.GD28568@master.mivlgu.local>
References: <200411060738.iA67cMI02836@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <200411060738.iA67cMI02836@freya.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 05, 2004 at 11:38:22PM -0800, Adam J. Richter wrote:
> 	The following patch implements a facility for invoking a user
> level helper program whenever a program attempts to access a
> nonexistent file on a given tmpfs file system.  It can provide
> functionality like autofs or devfs.  At 1708 bytes of object code, it
> should result in smaller implementations when it can be used, and
> may avoid some potential recursion problems.  A patch that shrinks
> devfs by much more than the size of this facility depends on it,
> so I would like to get it into the kernel soon.

What's the status of this patch - do you still plan to push it into
the kernel?

> 	Documentation/filesystems/lookup-trap.txt provides cookbook
> examples of how to use lookup traps with scripts or short C programs
> to for a variety of uses.  For example, here a way to create a create
> a simple automounter for remote file systems:
>=20
> 	% cat > /usr/sbin/tmpfs-automount
> 	#!/bin/sh
> 	mkdir $3
> 	mount -t nfs $3:/ $1/$3
> 	^D
> 	% chmod a+x /usr/sbin/tmpfs-automount
> 	% mkdir /auto
> 	% mount -t tmpfs -o helper=3D"/usr/sbin/tmpfs-automount /auto" x /auto
>=20
>=20
> 	I will soon post a small devfs replacement based on this
> facility.  The lookup traps and the devfs patch are an evolution of
> the shrunken devfs reimplementation that I posted almost two years
> ago, which I have been running continuously on a number of computers
> ever since, although the use of tmpfs is only a few days old.
>=20
> 	The implementation is small.  The total increase in object
> code size on x86 is 1708 bytes (mm/shmem.o change + fs/userhelper.o +
> fs/lookuptrap.o), and I've made it a configuration option, so people
> who don't want it will only be victimized by 180 object bytes of
> changes I had to make outside of the ifdef's to mm/shmem.c (those
> changes are counted in those 1708 byte tally, by the way).
>=20
> 	By line count, if you don't count the Documentation
> subdirectory, the devfs replacement and lookup traps taken together
> are actually a net reduction of more than 1800 lines of code from the
> kernel.  The lookup traps patch taken by itself is a net increase of
> 533 lines of code, most of which is in two files outside the tmpfs
> sources to facilitate possible use by other file systems.  In
> comparison, fs/autofs/*.[ch] is more than triple that line count.
>=20
> 	Over the past few days, I have posted earlier versions of
> these patches on linux-fsdevel, originally under the name "trapfs."
> This latest patch incorporate feedback expressed by a few people on
> that list.  Greg Kroah-Hartmann prefered the facility being a tmpfs
> option, which I saw some advantages to as well.  Mike Waychison and
> Matthew Wilcox got me to take a harder look at a user level race
> condition that I mentioned in the original posting, which eventually
> led to an apparent solution that is incorporated into this version.
>=20
> 	Finally, I should mention a limitation and couple of
> deficiencies that I'm aware of with respect to lookup traps to save
> everyone some discussion time.
>=20
> 	1. As Mike Waychison pointed out, this facility in tmpfs
> cannot be used to trap accesses to the root of a file system or create
> directories and then trap accesses when a program attempts to "cd" in.
> Such functionality could provide a more consistent and informative
> user interface for an automatic mounter of a small to moderate number
> of remote file systems, in the style of autofs.  The good news is that
> this patch provides a facility in fs/userhelper.c that could be called
> by another file system to provide functionality on
> inode_operations->follow_link() events similar to what this patch does
> for inode_operations->lookup() under tmpfs, hopefully allowing such an
> implementation to be smaller.
>=20
> 	2. Like sysfs and ramfs, tmpfs uses a struct inode and a
> struct dentry for every file system node, consuming something like 500
> bytes per node.  A backing store patch similar to the sysfs backing
> store patch could dramatically reduce the memory used by the
> tmpfs-based devfs, implementation.  the devfs application of ,
> although devfs file systems tend to have fewer nodes, since they are
> created on demand, and devfs memory consumption pales in comparison to
> sysfs.  I think that at some point in the future, it might be useful
> to implement some kind of release of struct inode's for device files
> at least, similar to the "sysfs backing store" patch that is supposed
> to be on its way into the stock kernel.
>=20
> 	3. Until the trapfs helper exits, it is impossible to
> control-C out of the access that invoked the helper.  This is a
> deficiency of the synchronous call_usermodehelper interface.  Every
> kernel facility that uses call_usermodehelper has this problem.  There
> are a number of ways to fix synchronous call_usermodehelper, and I
> surely expect trapfs to use whatever solution is implemented.
>=20
> 	Any feedback would be welcome.
>=20
>                     __     ______________=20
> Adam J. Richter        \ /
> adam@yggdrasil.com      | g g d r a s i l
>=20
>=20
> --- linux-2.6.10-rc1-bk14/include/linux/shmem_fs.h	2004-10-18 14:54:55.00=
0000000 -0700
> +++ linux/include/linux/shmem_fs.h	2004-11-05 23:24:20.000000000 -0800
> @@ -1,8 +1,10 @@
>  #ifndef __SHMEM_FS_H
>  #define __SHMEM_FS_H
> =20
> +#include <linux/config.h>
>  #include <linux/swap.h>
>  #include <linux/mempolicy.h>
> +#include <linux/fsuserhelper.h>
> =20
>  /* inode in-kernel data */
> =20
> @@ -22,11 +24,15 @@
>  };
> =20
>  struct shmem_sb_info {
> +	int limited;		/* 0 =3D ignore max_blocks and max_inodes */
>  	unsigned long max_blocks;   /* How many blocks are allowed */
>  	unsigned long free_blocks;  /* How many are left for allocation */
>  	unsigned long max_inodes;   /* How many inodes are allowed */
>  	unsigned long free_inodes;  /* How many are left for allocation */
>  	spinlock_t    stat_lock;
> +#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
> +	char *helper_shell_command;
> +#endif
>  };
> =20
>  static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
> @@ -34,4 +40,6 @@
>  	return container_of(inode, struct shmem_inode_info, vfs_inode);
>  }
> =20
> +extern int __init init_tmpfs(void); /* early initialization for devfs */

Adding this hook probably belongs to the devfs-replacement patch,
which would be applied on top of the lookup-trap patch.

> +
>  #endif
> --- linux-2.6.10-rc1-bk14/include/linux/fsuserhelper.h	1969-12-31 16:00:0=
0.000000000 -0800
> +++ linux/include/linux/fsuserhelper.h	2004-11-05 23:24:21.000000000 -0800
> @@ -0,0 +1,15 @@
> +#ifndef _LINUX_FS_HELPER
> +#define _LINUX_FS_HELPER
> +
> +#include <linux/dcache.h>
> +#include <linux/rwsem.h>
> +
> +/*
> +  Note: call_fs_helper releases and retakes dentry->d_parent->d_inode->i=
_sem.
> +*/

This comment style (which is used in your patch all over the place)
does not match the style used in the rest of the kernel.

> +extern void call_fs_helper(char **comand_str_ptr,

Typo: command_str_ptr (and in the actual definition this parameter is
named "command_ptr").

> +			   struct rw_semaphore *command_rwsem,
> +			   const char *event,
> +			   struct dentry *dentry);
> +
> +#endif /* _LINUX_FS_HELPER */
> --- linux-2.6.10-rc1-bk14/include/linux/lookuptrap.h	1969-12-31 16:00:00.=
000000000 -0800
> +++ linux/include/linux/lookuptrap.h	2004-11-05 23:24:22.000000000 -0800
> @@ -0,0 +1,12 @@
> +#ifndef _LINUX_LOOKUPTRAP_H
> +#define _LINUX_LOOKUPTRAP_H
> +
> +#include <linux/fs.h>
> +#include <linux/dcache.h>
> +
> +extern struct dentry *trapping_lookup(struct inode *dir,
> +				      struct dentry *dentry,
> +				      struct nameidata *nd,
> +				      char **shell_command_ptr);
> +
> +#endif /* _LINUX_LOOKUPTRAP_H */
> --- linux-2.6.10-rc1-bk14/mm/shmem.c	2004-11-04 23:32:44.000000000 -0800
> +++ linux/mm/shmem.c	2004-11-05 23:24:23.000000000 -0800
> @@ -14,6 +14,9 @@
>   * Copyright (c) 2004, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
>   * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
>   *
> + * User level helper for directory lookups:
> + * Copyright (C) 2004 Adam J. Richter, Yggdrasil Computing, Inc.
> + *
>   * This file is released under the GPL.
>   */
> =20
> @@ -46,6 +49,8 @@
>  #include <linux/mempolicy.h>
>  #include <linux/namei.h>
>  #include <linux/xattr.h>
> +#include <linux/lookuptrap.h>
> +#include <linux/parser.h>
>  #include <asm/uaccess.h>
>  #include <asm/div64.h>
>  #include <asm/pgtable.h>
> @@ -135,7 +140,20 @@
> =20
>  static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
>  {
> +#ifdef CONFIG_TMPFS
>  	return sb->s_fs_info;
> +#else
> +	return NULL;		/* compiler optimization */
> +#endif
> +}
> +
> +static inline int shmem_have_quotas(struct shmem_sb_info *sb_info)
> +{
> +#ifdef CONFIG_TMPFS
> +	return sb_info->limited;
> +#else
> +	return 0;		/* sb_info will be NULL. */
> +#endif
>  }
> =20
>  /*
> @@ -194,7 +212,8 @@
>  static void shmem_free_blocks(struct inode *inode, long pages)
>  {
>  	struct shmem_sb_info *sbinfo =3D SHMEM_SB(inode->i_sb);
> -	if (sbinfo) {
> +
> +	if (shmem_have_quotas(sbinfo)) {
>  		spin_lock(&sbinfo->stat_lock);
>  		sbinfo->free_blocks +=3D pages;
>  		inode->i_blocks -=3D pages*BLOCKS_PER_PAGE;
> @@ -357,7 +376,7 @@
>  		 * page (and perhaps indirect index pages) yet to allocate:
>  		 * a waste to allocate index if we cannot allocate data.
>  		 */
> -		if (sbinfo) {
> +		if (shmem_have_quotas(sbinfo)) {
>  			spin_lock(&sbinfo->stat_lock);
>  			if (sbinfo->free_blocks <=3D 1) {
>  				spin_unlock(&sbinfo->stat_lock);
> @@ -678,7 +697,7 @@
>  			spin_unlock(&shmem_swaplist_lock);
>  		}
>  	}
> -	if (sbinfo) {
> +	if (shmem_have_quotas(sbinfo)) {
>  		BUG_ON(inode->i_blocks);
>  		spin_lock(&sbinfo->stat_lock);
>  		sbinfo->free_inodes++;
> @@ -1081,7 +1100,7 @@
>  	} else {
>  		shmem_swp_unmap(entry);
>  		sbinfo =3D SHMEM_SB(inode->i_sb);
> -		if (sbinfo) {
> +		if (shmem_have_quotas(sbinfo)) {
>  			spin_lock(&sbinfo->stat_lock);
>  			if (sbinfo->free_blocks =3D=3D 0 ||
>  			    shmem_acct_block(info->flags)) {
> @@ -1269,7 +1288,7 @@
>  	struct shmem_inode_info *info;
>  	struct shmem_sb_info *sbinfo =3D SHMEM_SB(sb);
> =20
> -	if (sbinfo) {
> +	if (shmem_have_quotas(sbinfo)) {
>  		spin_lock(&sbinfo->stat_lock);
>  		if (!sbinfo->free_inodes) {
>  			spin_unlock(&sbinfo->stat_lock);
> @@ -1598,7 +1617,7 @@
>  	buf->f_type =3D TMPFS_MAGIC;
>  	buf->f_bsize =3D PAGE_CACHE_SIZE;
>  	buf->f_namelen =3D NAME_MAX;
> -	if (sbinfo) {
> +	if (shmem_have_quotas(sbinfo)) {
>  		spin_lock(&sbinfo->stat_lock);
>  		buf->f_blocks =3D sbinfo->max_blocks;
>  		buf->f_bavail =3D buf->f_bfree =3D sbinfo->free_blocks;
> @@ -1650,6 +1669,19 @@
>  	return shmem_mknod(dir, dentry, mode | S_IFREG, 0);
>  }
> =20
> +#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
> +static struct dentry * shmem_lookup(struct inode *dir,
> +				    struct dentry *dentry,
> +				    struct nameidata *nd)
> +{
> +	struct shmem_sb_info *sbinfo =3D SHMEM_SB(dir->i_sb);
> +
> +	return trapping_lookup(dir, dentry, nd, &sbinfo->helper_shell_command);
> +}
> +#else
> +# define shmem_lookup simple_lookup
> +#endif
> +
>  /*
>   * Link a file..
>   */
> @@ -1663,7 +1695,7 @@
>  	 * but each new link needs a new dentry, pinning lowmem, and
>  	 * tmpfs dentries cannot be pruned until they are unlinked.
>  	 */
> -	if (sbinfo) {
> +	if (shmem_have_quotas(sbinfo)) {
>  		spin_lock(&sbinfo->stat_lock);
>  		if (!sbinfo->free_inodes) {
>  			spin_unlock(&sbinfo->stat_lock);
> @@ -1688,7 +1720,7 @@
> =20
>  	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode)) {
>  		struct shmem_sb_info *sbinfo =3D SHMEM_SB(inode->i_sb);
> -		if (sbinfo) {
> +		if (shmem_have_quotas(sbinfo)) {
>  			spin_lock(&sbinfo->stat_lock);
>  			sbinfo->free_inodes++;
>  			spin_unlock(&sbinfo->stat_lock);
> @@ -1840,7 +1872,7 @@
>  #endif
>  };
> =20
> -static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid=
_t *gid, unsigned long *blocks, unsigned long *inodes)
> +static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid=
_t *gid, unsigned long *blocks, unsigned long *inodes, substring_t *helper)
>  {
>  	char *this_char, *value, *rest;
> =20
> @@ -1894,6 +1926,9 @@
>  			*gid =3D simple_strtoul(value,&rest,0);
>  			if (*rest)
>  				goto bad_val;
> +		} else if (!strcmp(this_char,"helper")) {
> +			helper->from =3D value;
> +			helper->to =3D value + strlen(value);
>  		} else {
>  			printk(KERN_ERR "tmpfs: Bad mount option %s\n",
>  			       this_char);
> @@ -1909,32 +1944,73 @@
> =20
>  }
> =20
> +#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
> +static int
> +maybe_replace_from_substr(char **target, substring_t *substr)
> +{
> +	char *str;
> +
> +	if (substr->from =3D=3D NULL)
> +		return 0;
> +
> +	if (substr->from =3D=3D substr->to)
> +		str =3D NULL;
> +	else {
> +		str =3D match_strdup(substr);
> +		if (!str)
> +			return -ENOMEM;
> +	}
> +	kfree(*target);
> +	*target =3D str;
> +	return 0;
> +}
> +#endif /* CONFIG_TMPFS_LOOKUP_TRAPS */
> +
>  static int shmem_remount_fs(struct super_block *sb, int *flags, char *da=
ta)
>  {
>  	struct shmem_sb_info *sbinfo =3D SHMEM_SB(sb);
>  	unsigned long max_blocks =3D 0;
>  	unsigned long max_inodes =3D 0;
> +	substring_t helper_str;
> =20
> -	if (sbinfo) {
> +	if (shmem_have_quotas(sbinfo)) {
>  		max_blocks =3D sbinfo->max_blocks;
>  		max_inodes =3D sbinfo->max_inodes;
>  	}
> -	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inode=
s))
> +	helper_str.from =3D NULL;
> +	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inode=
s, &helper_str))
>  		return -EINVAL;
> +
> +#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
> +	if (maybe_replace_from_substr(&sbinfo->helper_shell_command,
> +				      &helper_str) !=3D 0)
> +		return -ENOMEM;
> +#endif
> +
>  	/* Keep it simple: disallow limited <-> unlimited remount */
> -	if ((max_blocks || max_inodes) =3D=3D !sbinfo)
> +	if ((max_blocks || max_inodes) !=3D shmem_have_quotas(sbinfo))
>  		return -EINVAL;

At this point helper_shell_command was already changed.  Having a
possibility that a failed remount might still change some filesystem
parameters does not seem good.

> +
>  	/* But allow the pointless unlimited -> unlimited remount */
> -	if (!sbinfo)
> +	if (!max_blocks && !max_inodes)
>  		return 0;
> +
>  	return shmem_set_size(sbinfo, max_blocks, max_inodes);
>  }
> -#endif
> +#endif /* CONFIG_TMPFS */
> =20
>  static void shmem_put_super(struct super_block *sb)
>  {
> -	kfree(sb->s_fs_info);
> -	sb->s_fs_info =3D NULL;
> +#ifdef CONFIG_TMPFS
> +	struct shmem_sb_info *sb_info =3D SHMEM_SB(sb);
> +
> +# ifdef CONFIG_TMPFS_LOOKUP_TRAPS=09
> +	kfree(sb_info->helper_shell_command);
> +# endif
> +	kfree(sb_info);
> +#endif

#ifdef inside functions are generally frowned upon; you have two
nested ones here :(

> +
> +	sb->s_fs_info =3D NULL;	/* FIXME.  Is this line necessary? */
>  }
> =20
>  #ifdef CONFIG_TMPFS_XATTR
> @@ -1954,14 +2030,17 @@
>  	int err =3D -ENOMEM;
> =20
>  #ifdef CONFIG_TMPFS
> +	substring_t helper_str;
>  	unsigned long blocks =3D 0;
>  	unsigned long inodes =3D 0;
> +	struct shmem_sb_info *sbinfo;
> =20
>  	/*
>  	 * Per default we only allow half of the physical ram per
>  	 * tmpfs instance, limiting inodes to one per page of lowmem;
>  	 * but the internal instance is left unlimited.
>  	 */
> +	helper_str.from =3D NULL;

This line divides apart the comment and the code it was attached to.

>  	if (!(sb->s_flags & MS_NOUSER)) {
>  		blocks =3D totalram_pages / 2;
>  		inodes =3D totalram_pages - totalhigh_pages;
> @@ -1969,24 +2048,32 @@
>  			inodes =3D blocks;
> =20
>  		if (shmem_parse_options(data, &mode,
> -					&uid, &gid, &blocks, &inodes))
> +					&uid, &gid, &blocks, &inodes,
> +					&helper_str))
>  			return -EINVAL;
>  	}
> =20
> -	if (blocks || inodes) {
> -		struct shmem_sb_info *sbinfo;
> -		sbinfo =3D kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
> -		if (!sbinfo)
> -			return -ENOMEM;
> -		sb->s_fs_info =3D sbinfo;
> -		spin_lock_init(&sbinfo->stat_lock);
> -		sbinfo->max_blocks =3D blocks;
> -		sbinfo->free_blocks =3D blocks;
> -		sbinfo->max_inodes =3D inodes;
> -		sbinfo->free_inodes =3D inodes;
> -	}
> +	sbinfo =3D kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
> +	if (!sbinfo)
> +		return -ENOMEM;
> +
> +	sbinfo->limited =3D (blocks || inodes);
> +	sb->s_fs_info =3D sbinfo;
> +	spin_lock_init(&sbinfo->stat_lock);
> +	sbinfo->max_blocks =3D blocks;
> +	sbinfo->free_blocks =3D blocks;
> +	sbinfo->max_inodes =3D inodes;
> +	sbinfo->free_inodes =3D inodes;
> +
> +# ifdef CONFIG_TMPFS_LOOKUP_TRAPS
> +	sbinfo->helper_shell_command =3D NULL;
> +	if (maybe_replace_from_substr(&sbinfo->helper_shell_command,
> +				      &helper_str) !=3D 0)
> +		return -ENOMEM;

Leak of sbinfo.

> +# endif
> +
>  	sb->s_xattr =3D shmem_xattr_handlers;
> -#endif
> +#endif /* CONFIG_TMPFS */
> =20
>  	sb->s_maxbytes =3D SHMEM_MAX_BYTES;
>  	sb->s_blocksize =3D PAGE_CACHE_SIZE;
> @@ -2088,7 +2175,7 @@
>  static struct inode_operations shmem_dir_inode_operations =3D {
>  #ifdef CONFIG_TMPFS
>  	.create		=3D shmem_create,
> -	.lookup		=3D simple_lookup,
> +	.lookup		=3D shmem_lookup,
>  	.link		=3D shmem_link,
>  	.unlink		=3D shmem_unlink,
>  	.symlink	=3D shmem_symlink,
> @@ -2192,9 +2279,15 @@
>  };
>  static struct vfsmount *shm_mnt;
> =20
> -static int __init init_tmpfs(void)
> +/* init_tmpfs is exported so that devfs can get an earlier initialization
> +   if necessary. */
> +int __init init_tmpfs(void)

Again, making this function non-static belongs to another patch where
it will actually be used.

>  {
>  	int error;
> +	static int initialized;	/* =3D 0 */

__initdata (but as noted above, these additions should not be in this
patch anyway).

> +
> +	if (initialized)
> +		return 0;
> =20
>  	error =3D init_inodecache();
>  	if (error)
> @@ -2215,6 +2308,7 @@
>  		printk(KERN_ERR "Could not kern_mount tmpfs\n");
>  		goto out1;
>  	}
> +	initialized =3D 1;
>  	return 0;
> =20
>  out1:
> @@ -2310,3 +2404,5 @@
>  	vma->vm_ops =3D &shmem_vm_ops;
>  	return 0;
>  }
> +EXPORT_SYMBOL(shmem_lock);
> +EXPORT_SYMBOL(shmem_nopage);

What do you need this for?  These symbols are not used anythere in the
patch.

> --- linux-2.6.10-rc1-bk14/fs/Kconfig	2004-11-04 23:32:39.000000000 -0800
> +++ linux/fs/Kconfig	2004-11-05 23:24:24.000000000 -0800
> @@ -940,6 +940,23 @@
> =20
>  	  If unsure, say N.
> =20
> +config TMPFS_LOOKUP_TRAPS
> +	bool "tmpfs lookup trapping"
> +	depends on TMPFS
> +	help
> +	  This facility allows you to configure a tmpfs file system to
> +	  invoke a user level helper program whenever an attempt is made
> +	  to access a nonexistent file, enabling these helper programs
> +	  to define file systems are filled in on demand.  There
> +	  is a version of devfs that requires it, and it can be
> +	  used to implement certain types of automatic mounting
> +	  of other file systems.  It is a daemonless and, perhaps
> +	  consequently, smaller (under 2kB object on x86) alternative
> +	  to autofs for certain uses, although it cannot be used as a
> +	  replacement in all cases, and it is not available as a loadable
> +	  module (because tmpfs isn't).  For examples and more information,
> +	  please see <file:Documentations/filesystems/lookup-trap.txt>.
> +
>  config TMPFS_SECURITY
>  	bool "tmpfs Security Labels"
>  	depends on TMPFS_XATTR
> --- linux-2.6.10-rc1-bk14/fs/Makefile	2004-11-04 23:32:39.000000000 -0800
> +++ linux/fs/Makefile	2004-11-05 23:24:25.000000000 -0800
> @@ -44,6 +44,10 @@
>  obj-y				+=3D devpts/
> =20
>  obj-$(CONFIG_PROFILING)		+=3D dcookies.o
> +
> +ifdef CONFIG_TMPFS_LOOKUP_TRAPS
> +  obj-$(CONFIG_TMPFS)		+=3D lookuptrap.o userhelper.o
> +endif

Just obj-$(CONFIG_TMPFS_LOOKUP_TRAPS) will do - it depends on
CONFIG_TMPFS anyway, no need to duplicate this logic in Makefile.

>  =20
>  # Do not add any filesystems before this line
>  obj-$(CONFIG_REISERFS_FS)	+=3D reiserfs/
> --- linux-2.6.10-rc1-bk14/fs/lookuptrap.c	1969-12-31 16:00:00.000000000 -=
0800
> +++ linux/fs/lookuptrap.c	2004-11-05 23:24:26.000000000 -0800
> @@ -0,0 +1,190 @@
> +/*
> +  struct dentry *trapping_lookup(struct inode *dir,
> +				 struct dentry *dentry,
> +				 struct nameidata *nd,
> +				 char **shell_command_ptr)
> +
> +  trapping_lookup() is an alternative to simple_lookup() (from libfs.c),
> +  that adds the ability to invoke a user level helper program when
> +  an attempt is made to access a nonexistant file.  It invokes the
> +  command via call_fs_helper() from fs/helper.c.
> +
> +  trapping_lookup takes one parameter in addition to the parameters
> +  that an inode_operations->lookup method requires.  This paratmer,
> +  shell_command_ptr is the address of a pointer to a string containing
> +  the command to be executed trapping_lookup will always take a
> +  read lock on superblock->s_umount, so it is multiprocessor-safe for yo=
ur
> +  file system's superblock mount and remount routines to modify that
> +  address, since mount and remount will take a write lock on
> +  superblock->s_umount.
> +
> +  See tmpfs in mm/shmem.c for an example of use of trapping_lookup.
> +
> +  trapping_lookup() is the only symbol exported from this file.
> +
> +
> +  Written by Adam J. Richter
> +  Copyright (C) 2004 Yggdrasil Computing, Inc.
> +
> +  This program is free software; you can redistribute it and/or modify
> +  it under the terms of the GNU General Public License as published by
> +  the Free Software Foundation; either version 2 of the License, or
> +  (at your option) any later version.
> +
> +  This program is distributed in the hope that it will be useful,
> +  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +  GNU General Public License for more details.
> +
> +  You should have received a copy of the GNU General Public License
> +  along with this program; if not, write to the Free Software
> +  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
> + */

Most other files use this format for the initial comment:

  - one-line description of the file
  - copyright notice
  - GPL boilerplate (if present at all)
  - more verbose description if needed

> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/dcache.h>
> +#include <linux/wait.h>
> +#include <linux/fsuserhelper.h>
> +
> +static inline int want_to_trap(struct nameidata *nd)
> +{
> +	return (nd !=3D NULL);
> +}
> +
> +
> +/*
> + * Retaining negative dentries for an in-memory filesystem just wastes
> + * memory and lookup time: arrange for them to be deleted immediately.
> + */
> +static int always_delete_dentry(struct dentry *dentry)
> +{
> +	return 1;
> +}
> +
> +/* Force revalidation of all negative dentries.  Note that this routine
> +   only gets called when some other routine has a reference to the dentry
> +   or the dentry has an inode.  Otherwise, unused negative dentries
> +   are immediately dropped, because of always_delete_dentry.  Apparently,
> +   the only time blocking_dentry_valid ends up being called with an empty
> +   inode is when a trapped reference is blocking on the user level helpe=
r.
> +*/
> +static int blocking_dentry_valid(struct dentry *dentry,
> +				 struct nameidata *nd)
> +{
> +	struct wait_queue_head *queue_head;
> +	struct semaphore *parent_inode_sem;
> +	DEFINE_WAIT(my_wait);
> +
> +	if (dentry->d_inode !=3D NULL)
> +		return 1;
> +
> +	if (!want_to_trap(nd))
> +		return 0;
> +
> +	/* FIXME? I think there is no need to use dget_parent or
> +	   to take dcache_lock here, because dentry->d_parent never
> +	   changes and the dentry holds a reference to its parent,
> +	   and dentry->d_parent holds a reference to
> +	   dentry->d_d_parent->d_inode. Right??? -AJR 2004.11.05 */
> +	parent_inode_sem =3D &dentry->d_parent->d_inode->i_sem;
> +
> +	down(parent_inode_sem);
> +
> +	queue_head =3D dentry->d_fsdata;
> +	if (!queue_head) {
> +		up(parent_inode_sem);
> +		return (dentry->d_inode !=3D NULL);
> +	}
> +
> +	prepare_to_wait(queue_head, &my_wait, TASK_INTERRUPTIBLE);
> +	up(parent_inode_sem);
> +	schedule();
> +	finish_wait(queue_head, &my_wait);
> +
> +	/* At this point, maybe the queue was woken up or maybe we got a
> +	   signal.  There is no need to check, because we just return
> +	   in either case. */
> +
> +	return (dentry->d_inode !=3D NULL);
> +=09
> +}
> +
> +
> +static struct dentry_operations trapping_dentry_ops =3D {
> +	.d_delete =3D	always_delete_dentry,
> +	.d_revalidate =3D	blocking_dentry_valid,
> +};
> +
> +struct dentry *
> +trapping_lookup(struct inode *dir,
> +		struct dentry *dentry,
> +		struct nameidata *nd,
> +		char **shell_command_ptr)
> +{
> +	/*
> +	  We must do d_add before call_fs_helper to prevent
> +	  a duplicate dentry from being created if the helper
> +	  program attempts to access the same file name in /dev.
> +	  If simple_lookup returns non-NULL, then that is to an error
> +	  like a malformed file name, so we do not invoke trapfs_event.
> +	  If the file is not found but there was no other error,
> +	  simple_lookup returns NULL, and that is the only case
> +	  in which we want to generate a notification.
> +
> +	  We also filter out the final path element of mknod, mkdir
> +	  and symlink, because invoking the helper for mknod and mkdir
> +	  could lead to deadlock when trapfs loads a device driver
> +	  kernel module than.  One would think that the way to filter
> +	  would be to look at nd->flags to check that LOOKUP_CREATE
> +	  is set and LOOKUP_OPEN is clear, but instead, the vfs
> +	  layers passed nd=3D=3DNULL in these cases via a routine
> +	  called lookup_create (without any leading underscores),
> +	  so we filter out the case where nd =3D=3D NULL.
> +
> +	  Filtering out nd=3D=3DNULL has the unintented side-effect of
> +	  filtering out the final path component of arguments to
> +	  rmdir, unlink and rename (both source and destination).
> +	  For rmdir, unlink, and the source arguement to rename,
> +	  that's fine, since nobody cares about attempts to remove
> +	  nonexistant files.  We're probably also OK skipping the
> +	  notifications with regard to the destination argument to
> +	  rename, although that is less clear.
> +	*/
> +
> +	struct dentry		*result;
> +	wait_queue_head_t	queue_head;
> +	struct dentry		*new;
> +
> +	if (!want_to_trap(nd))
> +		return simple_lookup(dir, dentry, nd);
> +
> +	if (dentry->d_name.len > NAME_MAX)
> +		return ERR_PTR(-ENAMETOOLONG);
> +
> +	init_waitqueue_head(&queue_head);
> +
> +	dentry->d_fsdata =3D &queue_head;
> +	dentry->d_op =3D &trapping_dentry_ops;
> +
> +	d_add(dentry, NULL);
> +
> +	call_fs_helper(shell_command_ptr, &dir->i_sb->s_umount, "LOOKUP",
> +		       dentry);
> +
> +	new =3D d_lookup(dentry->d_parent, &dentry->d_name);
> +
> +	if (new !=3D dentry) /* also handles new=3D=3DNULL */
> +		result =3D new;
> +	else {
> +		dput(new);
> +		result =3D NULL;
> +	}
> +
> +	wake_up(&queue_head);
> +	dentry->d_fsdata =3D NULL; /* Yes, we really can call wake_up() first.*/
> +
> +	return result;
> +}
> +
> +EXPORT_SYMBOL_GPL(trapping_lookup);

Currently tmpfs cannot be modular, therefore the export is unneeded.
If more users of this function will appear, EXPORT_SYMBOL_GPL could be
easily added.

> --- linux-2.6.10-rc1-bk14/fs/userhelper.c	1969-12-31 16:00:00.000000000 -=
0800
> +++ linux/fs/userhelper.c	2004-11-05 23:24:27.000000000 -0800
> @@ -0,0 +1,190 @@
> +/*
> +  helper.c -- Invoke user level helper command for a struct dentry.
> +
> +  Written by Adam J. Richter
> +  Copyright (C) 2004 Yggdrasil Computing, Inc.
> +
> +  This program is free software; you can redistribute it and/or modify
> +  it under the terms of the GNU General Public License as published by
> +  the Free Software Foundation; either version 2 of the License, or
> +  (at your option) any later version.
> +
> +  This program is distributed in the hope that it will be useful,
> +  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +  GNU General Public License for more details.
> +
> +  You should have received a copy of the GNU General Public License
> +  along with this program; if not, write to the Free Software
> +  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/ctype.h>
> +#include <linux/fsuserhelper.h>
> +
> +static int path_len (struct dentry *de, struct dentry *root)
> +{
> +	int len =3D 0;
> +	while (de !=3D root) {
> +		len +=3D de->d_name.len + 1;	/* count the '/' */
> +		de =3D de->d_parent;
> +	}
> +	return len;		/* -1 because we omit the leading '/',
> +				   +1 because we include trailing '\0' */
> +}
> +
> +static int write_path_from_mnt (struct dentry *de, char *path, int bufle=
n)
> +{
> +	struct dentry *mnt_root =3D de->d_parent->d_inode->i_sb->s_root;
> +	int len;
> +	char *path_orig =3D path;
> +
> +	if (de =3D=3D NULL || de =3D=3D mnt_root)
> +		return -EINVAL;
> +
> +	spin_lock(&dcache_lock);
> +	len =3D path_len(de, mnt_root);
> +	if (len > buflen) {
> +		spin_unlock(&dcache_lock);
> +		return -ENAMETOOLONG;
> +	}
> +
> +	path +=3D len - 1;
> +	*path =3D '\0';
> +
> +	for (;;) {
> +		path -=3D de->d_name.len;
> +		memcpy(path, de->d_name.name, de->d_name.len);
> +		de =3D de->d_parent;
> +		if (de =3D=3D mnt_root)
> +			break;
> +		*(--path) =3D '/';
> +	}
> +	=09
> +	spin_unlock(&dcache_lock);
> +
> +	BUG_ON(path !=3D path_orig);
> +
> +	return 0;
> +}
> +
> +static inline int
> +calc_argc(const char *str_in, int *str_len)
> +{
> +	const char *str =3D str_in;
> +	int argc =3D 0;
> +	while (*str) {
> +		while (*str =3D=3D ' ' || *str =3D=3D '\t')
> +			str++;
> +		argc++;
> +		while (*str !=3D ' ' && *str !=3D '\t' && *str)
> +			str++;
> +	}
> +	*str_len =3D str - str_in;
> +	return argc;
> +}
> +
> +static char **
> +gen_argv(char *str_in, int argc_extra, int *argc_out)
> +{
> +	int argc;
> +	char **argv;
> +	char *str_out;
> +	int str_len;
> +
> +	if (!str_in)
> +		return NULL;
> +
> +	while (*str_in =3D=3D ' ' || *str_in =3D=3D '\t')
> +		str_in++;
> +
> +	if (*str_in =3D=3D '\0')
> +		return NULL;
> +
> +	argc =3D calc_argc(str_in, &str_len);
> +
> +	argv =3D kmalloc(((argc + argc_extra) * sizeof(char*)) + str_len + 1,
> +		       GFP_KERNEL);
> +	if (!argv)
> +		return NULL;
> +
> +	str_out =3D (char*) (argv + argc + argc_extra);
> +
> +	argc =3D 0;
> +	while (*str_in) {
> +		argv[argc++] =3D str_out;
> +
> +		while (*str_in !=3D ' ' && *str_in !=3D '\t' && *str_in)
> +			*(str_out++) =3D *(str_in++);
> +
> +		*(str_out++) =3D '\0';
> +
> +		while (*str_in =3D=3D ' ' || *str_in =3D=3D '\t')
> +			str_in++;
> +	}
> +	*argc_out =3D argc;
> +	return argv;
> +}
> +
> +/*
> +  Warning: dentry_usermodehelper releases and retakes
> +  dentry->d_parent->d_inode->i_sem.  It must be called with this
> +  semaphore already held.
> +
> +  command_p is a pointer to a single string.  It is *not* in argv format.
> +  Instead, elements are separated by spaces.
> +*/
> +void call_fs_helper(char **command_ptr,
> +		    struct rw_semaphore *command_rwsem,
> +		    const char *event,
> +		    struct dentry *dentry)
> +{
> +	char path[64];

Having such arbitrary limits on the path length is bad.

> +	int argc;
> +	char **argv;
> +	struct semaphore *parent_inode_sem =3D &dentry->d_parent->d_inode->i_se=
m;
> +
> +	if (write_path_from_mnt(dentry, path, sizeof(path)) =3D=3D 0) {
> +
> +		/*
> +		  FIXME.  We would not need the extra memory allocation,
> +		  string copying, error branch and lines of source code
> +		  due to err_strdup(), and we could put gen_argv

What is err_strdup()?

> +		  into the set_fs_helper, if call_usermodehelper

set_fs_helper also does not seem to exist.

> +		  and execve had a callback to inform us when
> +		  execve was done copying argv and envp.  With
> +		  such a facility, we could just hold helper->rw_sem

helper->rw_sem should be command_rwsem, right?

> +		  up to that point, without having to make a copy of the
> +		  argument (which we currently do) or hold the semaphore
> +		  until the helper process exits (which would cause a
> +		  deadlock if a helper process ever tried to change
> +		  the helper string of a file system, especially since
> +		  there is not such a thing as rw_down_read_interruptible
> +		  that would make the deadlock breakable).
> +		*/
> +
> +		up(parent_inode_sem);
> +
> +		down_read(command_rwsem);
> +		argv =3D gen_argv(*command_ptr, 3, &argc);
> +		up_read(command_rwsem);
> +
> +		if (argv !=3D NULL) {
> +			static char *envp[] =3D
> +				{"PATH=3D/bin:/sbin:/usr/bin:/usr/sbin",
> +				 "HOME=3D/", NULL };
> +
> +			argv[argc++] =3D (char*) event;
> +			argv[argc++] =3D path;
> +			argv[argc] =3D NULL;
> +
> +			call_usermodehelper(argv[0], argv, envp, 1);
> +			kfree(argv);
> +		}
> +
> +		down(parent_inode_sem);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(call_fs_helper);

Again, this export is not needed now.

> --- linux-2.6.10-rc1-bk14/Documentation/filesystems/lookup-trap.txt	1969-=
12-31 16:00:00.000000000 -0800
> +++ linux/Documentation/filesystems/lookup-trap.txt	2004-11-05 23:24:28.0=
00000000 -0800
> @@ -0,0 +1,436 @@
> +User's Guide To Trapping Directory Lookup Operations in Tmpfs
> +Version 0.2
> +
> +
> +1. INSTRUCTIONS FOR THE IMPATIENT
> +
> +	% modprobe tmpfs
> +	% mount -t tmpfs -o helper=3D/path/to/helper/program whatever /mnt
> +	% ls /mnt/foo
> +	# Notice that "/path/to/helper/program LOOKUP foo" was executed.
> +
> +
> +2. OVERVIEW (from the Kconfig help)
> +
> +	Tmpfs now allows user level programs to implement file systems
> +that are filled in on demand.  This feature works by invoking a
> +configurable helper program on attempts to open() or stat() a
> +nonexistent file.  The access waits until the helper finishes, so the
> +helper can install the missing file if desired.
> +
> +	Using this facility, a shell script or small C program can
> +implement a file system that automatically mounts remote file systems
> +or creates device files on demand, similar to autofs or devfs,
> +respectively.  Tmpfs is, however, daemonless and, perhaps
> +consequently, smaller than either of these, and may avoid some
> +recursion problems.
> +
> +	Tmpfs might also be useful for debugging programs where you
> +want to trap the first access a particular file or perhaps in
> +automatic installation of missing command or libraries by specifying a
> +tmpfs file system in certain search paths.
> +
> +	This access trapping facility is designed to be easily ported
> +to other file systems.  Kernel developers should examine the following
> +source files for more information:
> +
> +	include/linux/fsuserhelper
> +	include/linux/lookuptrap.h
> +	fs/lookuptrap.c
> +	fs/userhelper.c
> +	mm/shmem.c (for an example of tmpfs using trapping_lookup)
> +
> +
> +3. GETTING STARTED
> +
> +3.1 MOUNTING THE FILE SYSTEM
> +
> +	First, build and boot a kernel with tmpfs either compiled in
> +or built as a module.  If you compile tmpfs as a module, you may have
> +to load it, although, since the module name ("tmpfs.ko") and the file
> +system name ("tmpfs") match, that may be unnecessary if you've
> +configured modprobe automatically.

It is impossible to compile tmpfs as a module (at least for now).

> +
> +	% modprobe tmpfs
> +
> +	Now let's mount a tmpfs file system on /mnt.
> +
> +	% mount -t tmpfs blah /mnt
> +
> +	The file system will behave exactly like a ramfs file system.
> +In fact, tmpfs is derived from ramfs.  You can create files,
> +directories, symbolic links and device nodes in it, and they will
> +exist only in the computer's main memory.  The contents of the file
> +system will disappear as soon as you unmount it.
> +
> +	If you mount multiple instances of tmpfs, you will get
> +separate file systems.
> +
> +
> +3.2. THE HELPER PROGRAM
> +
> +	What distinguishes tmpfs from ramfs is that it can invoke a
> +user level helper program when an attempt is made to open or stat a
> +nonexistent file for the first time (if the name is not already in the
> +dcache).  The user level program is set with the "helper" mount
> +option.  It is possible to set, clear or change the helper command at
> +any time, so let's go back to our example and put a helper command on
> +the tmpfs file system that we mounted on /mnt:
> +
> +	% mount -o remount,helper=3D/tmp/helper /mnt
> +
> +	If you use the file system in /mnt now, nothing appears to have
> +changed.  Now let's put a simple shell script in /tmp/helper:
> +
> +	% cat > /tmp/helper
> +	#!/bin/sh
> +	echo "$*" > /dev/console
> +	^D
> +	% chmod a+x /tmp/helper
> +
> +	Now you should see console messages like "LOOKUP foo" when you
> +try to access the file /mnt/foo for the first time.
> +
> +	You can also pass arguments to the helper program by using
> +spaces in the helper mount option, like so:
> +
> +	% mount -o remount,helper=3D'/tmp/helper my_argument' /mnt
> +
> +	If you do this, your console messages will start to look
> +something like "my_argument LOOKUP foo".  The arguments that
> +you specify come before "LOOKUP foo" to facilitate the use of
> +command interpreters, like, say, helper=3D'/usr/bin/perl handler.pl'.
> +Arguments also make it easy to pass things like the mount point or
> +configuration files, which should make it easier to write facilities
> +that work on multiple mount points.
> +
> +	You can also deactivate the helper at any time, like so:
> +
> +	mount -o remount,helper=3D'' /mnt
> +
> +4. PRACTICAL EXAMPLES
> +
> +4.1 AN NFS AUTOMOUNTER
> +
> +	% cat > /usr/sbin/tmpfs-automount
> +	#!/bin/sh
> +	topdir=3D$1
> +	host=3D${3%/*}
> +	dir=3D$topdir/$host
> +	mkdir $dir
> +	mount -t nfs $host:/ $dir
> +	^D
> +	% chmod a+x /usr/sbin/tmpfs-automount
> +	% mkdir /auto
> +	% mount -t tmpfs -o helper=3D"/usr/sbin/tmpfs-automount /auto" x /auto
> +
> +	Notice how we pass the additional argument "/auto" to the
> +tmpfs-automount command.
> +
> +	If you want automatic unmount after a timeout, you'll probably
> +want to do something a little more elaborate, perhaps with a script that
> +runs from cron.
> +
> +
> +4.2 DEMAND LOADING OF DEVICE DRIVERS
> +
> +	A version of devfs that uses tmpfs is under development and
> +running on the system I am using to write this document, but I am
> +still cleaning it up.  Here is how it should work, although I have
> +not yet actually tried devfs_helper on it.
> +
> +	The devfs_helper program was originally written for a stripped down
> +rewrite of devfs, from which tmpfs is derived.  It can read your
> +/etc/devfs.conf file (the file previously used to configured
> +devfsd) and load modules specified by "LOOKUP" commands.  Other
> +devfs.conf command are ignored.
> +
> +	% ftp ftp.yggdrasil.com
> +	login: anonymous
> +	password; guest
> +	ftp> cd /pub/dist/device_control/devfs
> +	ftp> get devfs_helper-0.2.tar.gz
> +	.....
> +	ftp> quit
> +	% tar xfpvz devfs_helper-0.2.tar.gz
> +	% cd devfs_helper-0.2
> +	% make
> +	% make install
> +	% mkdir /tmp/tmpdev
> +	% mount -t devfs /tmp/tmpdev
> +	% cp -apRx /dev/* /tmpdev/
> +	% mount -t devfs -o helper=3D/sbin/devfs_helper blah /dev
> +	% mount -t msods /dev/floppy/0 /mnt
> +
> +	The above example should load the floppy.ko kernel module
> +if you have a a line in your /etc/devfs.conf file like this:
> +
> +	LOOKUP	floppy		EXECUTE modprobe floppy
> +
> +
> +	You should also be able to use execfs in this fashion to get

And what is execfs?

> +automatic loading of kernel modules on non-devfs systems, although
> +you'll need something like udev the larger udev to create the

"udev the larger udev"?

> +device files once the device drivers are registered.
> +
> +
> +4.3 DEBUGGING A PROGRAM TRYING TO ACCESS A FILE
> +
> +	% cat > /tmp/call-sleep
> +	#!/bin/sh
> +	sleep 30
> +	^D
> +	% mount -t tmpfs -o helper=3D/tmp/call-sleep foo /mnt
> +	% mv .bashrc .bashrc-
> +	% ln -s /mnt/whatever .bashrc
> +	% gdb /bin/sh
> +	GNU gdb 5.2
> +	[blah blah blah]
> +	(gdb) run
> +	[program eventually hangs.  Switch to another terminal session.  You
> +         cannot control-C out of it, a tmpfs bug from call_usermodehelpe=
r.]
> +	% ps axf
> +	[Find the process under gdb.  Let say it's pid 1152.]
> +	% kill -SEGV 1152
> +	% ps auxww | grep sleep
> +	[Find the sleeping tmpfs helper.  Let's say it's pid 1120.]
> +	% kill -9 1120
> +	[Now back at the first session, running gdb on /bin/sh.]
> +	Program received signal SIGSEGV, Segmentation fault.
> +	0xb7f303d4 in __libc_open () at __libc_open:-1
> +	-1      __libc_open: No such file or directory.
> +        	in __libc_open
> +		(gdb) where
> +	#0  0xb7f303d4 in __libc_open () at __libc_open:-1
> +	#1  0xb7f8b4c0 in __DTOR_END__ () from /lib/libc.so.6
> +	#2  0x080921ef in _evalfile (filename=3D0x80dc788 "/tmp/junk/.bashrc", =
flags=3D9)
> +	    at evalfile.c:85
> +	#3  0x08092635 in maybe_execute_file (
> +	    fname=3D0xfffffffe <Address 0xfffffffe out of bounds>,=20
> +	    force_noninteractive=3D1) at evalfile.c:218
> +	#4  0x08059fe8 in run_startup_files () at shell.c:1019
> +	#5  0x08059849 in main (argc=3D1, argv=3D0xbfffebc4, env=3D0xbfffebcc) =
at shell.c:581
> +	#6  0xb7e88e02 in __libc_start_main (main=3D0x8059380 <main>, argc=3D1,=
=20
> +	    ubp_av=3D0xbfffebc4, init=3D0x805897c <_init>,=20
> +	    fini=3D0xb80005ac <_dl_debug_mask>, rtld_fini=3D0x8000, stack_end=
=3D0x0)
> +	    at ../sysdeps/generic/libc-start.c:129
> +
> +
> +4.4 AUTOMATIC LOADING OF MISSING PROGRAMS
> +
> +	% cat > /usr/sbin/missing-program
> +	#!/bin/sh
> +	my-automatic-network-downloader $2
> +	^D
> +	% chmod a+x /usr/sbin/missing-program
> +	% mount -t tmpfs -o helper=3D/usr/sbin/my-automatic-installer /mnt
> +	% PATH=3D$PATH:/mnt:$PATH
> +	# We include $PATH a second time so that the program can be
> +	# found after it is installed.
> +	% kdevelop		# Or some other program you don't have...
> +
> +	...or maybe something like this...
> +
> +	% cat > /usr/sbin/missing-program
> +	#!/bin/sh
> +	export DISPLAY=3D:0
> +	konqueror http://www.google.com/search?q=3D"download+$2" &
> +	^D
> +	% chmod a+x /usr/sbin/missing-program
> +	% mount -t tmpfs -o helper=3D/usr/sbin/missing-program glorp /mnt
> +	% xhost localhost
> +	% PATH=3D$PATH:/mnt
> +	% kdevelop
> +
> +4.4.1 AUTOMATIC LOADING OF MISSING LIBRARIES
> +
> +	Same as above, but with this line:
> +	% LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/mnt:$LD_LIBRARY_PATH
> +
> +4.5  ADVANCED EXAMPLE: Generating plain files
> +
> +	Doing automatic generation of plain files (as opposed to
> +directories, device files and symbolic links) requires more care,
> +because the helper program's attempt to open a file for writing
> +will itself invoke another instance of the user level handler.
> +
> +	One approach, perhaps the only one, is to define some temporary
> +file name pattern that your user handler knows to ignore, create the
> +file with a temporary name that matches that pattern, and then
> +rename the temporary file to the real file name, since rename
> +operations are not trapped (and if renames ever are trapped in future,

Misplaced comma.

> +releases you could filter out renames where the source matched the
> +tempary file pattern).
> +
> +	[FIXME. This example is untested!  --Adam Richter, 2004.11.03]
> +
> +
> +	% cat > /usr/sbin/my-decrypter
> +	#!/bin/sh
> +	encrypted_dir=3D$2
> +	decrypted_dir=3D$3
> +	key=3D$4
> +	# $5 is "LOOKUP"
> +	filename=3D$6
> +
> +	case $target in ( tmp/* ) ; exit ;; esac
> +	tmpfile=3D$decrypted_dir/$$
> +	decrypt --key $key < $encrypted_dir/$filename > $tmpfile
> +	mv $tmpfile $decrypted_dir/$filename
> +	^D
> +	% chmod a+x /usr/sbin/my-decrypter
> +	% mount -t tmpfs -o \
> +	   helper=3D'/usr/sbin/my-decrypter /cryptdir /mnt key' x /mnt
> +	% cat /mnt/my-secret-file
> +	....
> +
> +	If you want to make the temporary directory completely
> +inaccessible from the public directory, you can create two mount
> +points, where the public directory for the file system is actually
> +a subdirectory of a larger hidden directory, like so:
> +
> +	% mount -t tmpfs /some/place/hidden
> +	% chmod go-rwx /someplace/hidden
> +	% mkdir /some/place/hidden/mirror
> +	% mount --bind /some/place/hidden/mirror /public
> +
> +	Now you can set up a helper program that operates in some
> +other directory of /some/place/hidden, and then renames the
> +resultant files into /some/place/hidden/mirror.
> +
> +
> +4.5.1 A WARNING ABOUT SYMBOLIC LINKS AND THE GNU "ln -s" COMMAND
> +
> +	If your helper program invoke the shell command "ln" to create
> +symbolic links, you may need to use "filter and rename" technique that
> +was described above for plain files, or one of several other
> +workarounds listed below.  If you helper program just uses the
> +symlink() system call directly, you don't have to worry about this.
> +
> +	What is the problem, exactly?  The problem is that although
> +symlink system calls are not trapped, the "ln" command from version
> +5.2.1 of the GNU coreutils package (latest version as of this writing)
> +does a stat system call on the target before doing the symlink,
> +because it is specified to behave differently if the destination path
> +exists and is a directory.  stat, unlink symlink, is trapped, in order
> +to support automatic creation of files in case a program stats a file
> +before deciding whether to open it, and for things like "ls
> +/auto/fileserver1.mycompany.com/".  Consequently, a user level helper
> +shell script that simply does "ln -s whatever $target_file_name" will
> +deadlock (which can be broken by interrupting the child helper
> +program).
> +
> +	There are several possible solutions to this problem.
> +
> +	1. You can use a simpler symlink program, such as ssln,
> +	   instead of "ln -s".
> +
> +	2. If the final path element of the symlink's contents is
> +	   the same as the final path element of the symlink's name,
> +	   then you can just specify the directory name as the second
> +	   argument to "ln -s".  In other words, change
> +
> +			ln -s foo/bar /the/target/bar
> +			...to...
> +			ln -s foo/bar /the/target
> +
> +	3. You can use the same filtering techniques for symlink
> +	   as discussed for plain files in the previous section
> +	   (create them with speical temporary names that your helper
> +	   program knows to ignore and then rename them into place).
> +
> +	4. Invoke perl to do the symlink, if you know you have it available:
> +
> +			perl -e 'symlink("contents", "target");'
> +
> +	5. You can port shell script to C or perl or some other
> +	   language that gives you direct access to the symlink()
> +	   system call.
> +
> +
> +	Perhaps, in the future, the GNU ln command could be changed so
> +that, when it is called with exactly two file names, it would try to
> +do the symlink() and then check if the target is a directory only if
> +the symlink attempt failed.
> +
> +
> +4.6. OTHER USES?
> +
> +     I would be interested in hearing about any other uses that you up
> +with for tmpfs, especially if I can include them in this document.
> +
> +5. SERIALIZATION
> +
> +	Note that many instances of the user level helper program
> +can potentially be running at the same time.  It is up to "you",
> +the implementor of the helper program to determine what sort of
> +serialization you need and implement it.  A simple solution to
> +enforce complete serialization would be to have every instance
> +of the helper program take an exclusive flock on some common
> +file.
> +
> +6. KERNEL DEVELOPER ANSWERS ABOUT IMPLEMENTATION DECISIONS
> +
> +6.1 Q:  Why doesn't tmpfs provide REGISTER and UNREGISTER events when
> +        new nodes are created or deleted from the file system, as the
> +	mini-devfs implementation from which is derived did?
> +
> +    A:  {,UN}REGISTER in Richard Gooch's implementation of devfs enabled
> +        things like automatically setting permissions and sound settings
> +	on your sound device when the driver was loaded, even if
> +	the loading of the driver had not been caused by devfs.
> +	For tmpfs-based devfs, I expect to implement that in
> +	a more complex way by shadowing the real devfs file system
> +	and creating {,UN}REGISTER events as updates are propagated
> +	from the real devfs to /dev.  The advantages of this would be
> +	that module initialization would not be blockable by a user
> +	level program, and events like a device quickly appearing and
> +	disappearing could be coalesced (i.e., ignored in this case).
> +
> +	I'm not convinced that {,UN}REGISTER has to go, but I haven't
> +	seen any compelling uses for it, and I know it's politically
> +	easier to add a feature than to remove one, especially if anyone
> +	has developed a dependence on it and does not want to port.  So,
> +	I'm starting out with tmpfs not providing {,UN}REGISTER events.
> +
> +6.2 Q:	Why isn't this facility implemented as an overlay file system?  I=
'd
> +	like to be able to apply it to, say, /dev, without having
> +	to start out with /dev being a devfs file system.  I could
> +	also demand load certain facilities based on accesses to /proc.
> +
> +    A:	There are about two dozen routines in inode_operations and
> +	file_operations that would require pass-through versions, and
> +	they are not as trivial as you might think because of
> +	locking issues involved in going through the vfs layer again.
> +	Also, currently, tmpfs, like ramfs and sysfs, use a struct
> +	inode and a struct dentry in kernel low memory for every
> +	existing node in the file system, about half a kilobyte
> +	per entry.  So, tmpfs would need to be converted to allow
> +	inode structures to be released if it were to overlay
> +	potentially large directory trees.  Also there are issues
> +	related to the underlying file system changing "out from
> +	under" tmpfs.  Perhaps in the future this an be implemented.
> +
> +
> +6.3. Q: Why isn't tmpfs a built-in kernel facility that can be
> +	applied to any file, like dnotify?  That would also have
> +	the above advantages and could eliminate the mount complexity
> +	of overlays.
> +
> +     A:	I thought about defining a separating inode->directory_operations
> +	from inode->inode_operations. Since all of those operations that
> +	I want to intercept are called with inode->i_sem held, it
> +	follows that it would be SMP-safe to change an inode->dir_ops
> +	pointer dynamically, which would allow stacking of inode
> +	operations.  This approach could be used to remove the special
> +	case code that is used to implement dnotify.  But what happens
> +	when the inode is freed?  It would be necessary to intercept
> +	the victim superblock's superblock_operations.drop_inode
> +	routine, which could get pretty messy, especially, if, for
> +	example, more than one trap was being used on the same file
> +	system.  Perhaps if drop_inode were moved to struct
> +	inode_operations this would be easier.
> +
> +
> +Adam J. Richter (adam@yggdrasil.com)
> +2004.11.02
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCMIj+W82GfkQfsqIRAlpHAJ99uWD5pHIY1XJ0BCLHx67bI0B4vACglblQ
Pvio4q5XAprmv86nPSMoTTw=
=Iexa
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
