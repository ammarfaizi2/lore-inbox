Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSJHSr6>; Tue, 8 Oct 2002 14:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbSJHSr6>; Tue, 8 Oct 2002 14:47:58 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:60681 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261299AbSJHSrm>; Tue, 8 Oct 2002 14:47:42 -0400
Date: Tue, 8 Oct 2002 19:53:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021008195322.A14585@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17yymK-00021n-00@think.thunk.org>; from tytso@mit.edu on Tue, Oct 08, 2002 at 02:08:20PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 02:08:20PM -0400, tytso@mit.edu wrote:
> 
> This is the third of four patches which add extended attribute support
> to the ext2 and ext3 filesystems.  Please comment and bleed.
> 
> This patch adds extended attribute support to the ext3 filesystem.  This
> uses the generic extended attribute patch which was developed by Andreas
> Gruenbacher and the XFS team.  As a result, the user space utilities
> which work for XFS will also work with these patches.

JFS also already supports that API..

> +CONFIG_EXT3_FS_XATTR
> +  Extended attributes are name:value pairs associated with inodes by
> +  the kernel or by users (see the attr(5) manual page, or visit
> +  <http://acl.bestbits.at/> for details).
> +
> +  If unsure, say N.

No need for a help text if you set it always to true.
Even better: remove the option if it's always set..

> +
> +Ext3 extended attribute block sharing
> +CONFIG_EXT3_FS_XATTR_SHARING
> +  This options enables code for sharing identical extended attribute
> +  blocks among multiple inodes.
> +
> +  Usually, say Y.
> +
> +Ext3 extended user attributes
> +CONFIG_EXT3_FS_XATTR_USER
> +  This option enables extended user attributes on ext3. Processes can
> +  associate extended user attributes with inodes to store additional
> +  information such as the character encoding of files, etc. (see the
> +  attr(5) manual page, or visit <http://acl.bestbits.at/> for details).
> +
> +  If unsure, say N.
> +

I think user xattrs should be implied automatically like xfs and jfs do.

>  CONFIG_JBD
>    This is a generic journaling layer for block devices.  It is
>    currently used by the ext3 file system, but it could also be used to
> diff -Nru a/fs/Config.in b/fs/Config.in
> --- a/fs/Config.in	Tue Oct  8 13:52:30 2002
> +++ b/fs/Config.in	Tue Oct  8 13:52:30 2002
> @@ -27,6 +27,11 @@
>  dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS $CONFIG_EXPERIMENTAL
>  
>  tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
> +if [ "$CONFIG_EXT3_FS" != "n" ] ; then
> +  define_tristate CONFIG_EXT3_FS_XATTR $CONFIG_EXT3_FS
> +  define_bool CONFIG_EXT3_FS_XATTR_SHARING y
> +  define_bool CONFIG_EXT3_FS_XATTR_USER y
> +fi

Have you actually tried to compile this modular?  AFACIS this would
make fs/ext3/xattr.o it's own module which can't work.
Just remove the CONFIG_EXT3_FS_XATTR option and use three-space indents
in Config.in's while we're at it :)

> diff -Nru a/fs/ext3/Makefile b/fs/ext3/Makefile
> --- a/fs/ext3/Makefile	Tue Oct  8 13:52:30 2002
> +++ b/fs/ext3/Makefile	Tue Oct  8 13:52:30 2002
> @@ -7,4 +7,8 @@
>  ext3-objs    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
>  		ioctl.o namei.o super.o symlink.o
>  
> +export-objs += xattr.o
> +obj-$(CONFIG_EXT3_FS_XATTR) += xattr.o
> +obj-$(CONFIG_EXT3_FS_XATTR_USER) += xattr_user.o

I think this should be

ifneq($(CONFIG_EXT3_FS_XATTR))
ext3-objs += xattr.o
endif
ifneq($(CONFIG_EXT3_FS_XATTR_USER))
ext3-objs += xattr_user.o
endif

Why do I get the feeling you blindly took a 2.4 patch and just
got it compile built-in? :)

> +#ifdef CONFIG_EXT3_FS_XATTR_USER
> +		if (!strcmp (this_char, "user_xattr"))
> +			set_opt (*mount_options, XATTR_USER);

If we really want a user_xattr mount option I'd suggest
taking it into VFS.  But IMHO it's rather useless, just don't
access them if you don't want to.

> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
> +# define mark_buffer_dirty(bh) mark_buffer_dirty(bh, 1)
> +#endif

2.2 compat code in new 2.5 filesystem features?

> +DECLARE_MUTEX(ext3_xattr_sem);
> +
> +static inline void
> +ext3_xattr_lock(void)
> +{
> +	down(&ext3_xattr_sem);
> +}
> +
> +static inline void
> +ext3_xattr_unlock(void)
> +{
> +	up(&ext3_xattr_sem);
> +}

What about just directly taking that lock?

> +#ifdef OLD_QUOTAS

Do you really want to keep around the praehistoric quota code?

> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,18)

More old compat code - not even usefull for any recent 2.4

> +#ifdef __KERNEL__

I thought the time of shared headers was long gone.  Do you use
an exact copy of this in e2fsprogs or is this just junk?

> +extern int ext3_setxattr(struct dentry *, const char *, void *, size_t, int);
> +extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t);
> +extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
> +extern int ext3_removexattr(struct dentry *, const char *);
> +
> +extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
> +extern int ext3_xattr_list(struct inode *, char *, size_t);
> +extern int ext3_xattr_set(handle_t *handle, struct inode *, int, const char *, const void *, size_t, int);
> +
> +extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
> +extern void ext3_xattr_put_super(struct super_block *);

All other function prototypes inside ext3 are in ext3_fs.h, do we really
need a new header for xattr ones?

Also please get rid of the registration API for xattr handlers - this
is inside a single module so hardconding them in the inode operations
won't hurt.  the additional lock for the registration OTOH may hurt and
it looks really overengineered.
