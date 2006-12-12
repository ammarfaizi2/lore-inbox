Return-Path: <linux-kernel-owner+w=401wt.eu-S932358AbWLLUgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWLLUgw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWLLUgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:36:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351AbWLLUgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:36:51 -0500
Message-ID: <457F12CA.9050907@redhat.com>
Date: Tue, 12 Dec 2006 15:36:26 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: Jeff Layton <jlayton@redhat.com>
CC: linux@horizon.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ensure unique i_ino in filesystems without permanent
References: <20061212194708.8359.qmail@science.horizon.com> <457F0BB1.4090806@redhat.com>
In-Reply-To: <457F0BB1.4090806@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
> linux@horizon.com wrote:
> >> Doh! Thanks for explaining that. Here's a respun patch with your 
> suggestion
> >> incorporated. Seems to build correctly without stdbool.h. In fact, 
> I don't see
> >> a stdbool.h in Linus' tree as of this morning. Are you sure that 
> it's needed?
> >
> > include/linux/types.h:36:typedef _Bool                   bool;
> >
> > It's already in there.  And <linux/stddef.h> has false and true.
> >
> > Sorry; I write more user-level code.
> >
> > The'd be built-in, except that C99 didn't want to add a kewords that
> > might conflict with existing code.
>
> Ok, that makes sense. Though I just found a bug that I missed. I 
> forgot to change the
> EXPORT_SYMBOL in libfs.c. This should fix it:
>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
>
> --- linux-2.6/fs/debugfs/inode.c.super
> +++ linux-2.6/fs/debugfs/inode.c
> @@ -107,7 +107,7 @@ static int debug_fill_super(struct super
>  {
>      static struct tree_descr debug_files[] = {{""}};
>
> -    return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
> +    return registered_fill_super(sb, DEBUGFS_MAGIC, debug_files);
>  }
>
>  static int debug_get_sb(struct file_system_type *fs_type,
> --- linux-2.6/fs/fuse/control.c.super
> +++ linux-2.6/fs/fuse/control.c
> @@ -163,7 +163,7 @@ static int fuse_ctl_fill_super(struct su
>      struct fuse_conn *fc;
>      int err;
>
> -    err = simple_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
> +    err = registered_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
>      if (err)
>          return err;
>
> --- linux-2.6/fs/libfs.c.super
> +++ linux-2.6/fs/libfs.c
> @@ -215,7 +215,7 @@ int get_sb_pseudo(struct file_system_typ
>      s->s_op = ops ? ops : &default_ops;
>      s->s_time_gran = 1;
>      root = new_inode(s);
> -    if (!root)
> +    if (!root || iunique_register(root, 0))
>          goto Enomem;
>      root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
>      root->i_uid = root->i_gid = 0;
> @@ -356,7 +356,8 @@ int simple_commit_write(struct file *fil
>      return 0;
>  }
>

If iunique_register() fails, does not this create a memory leak
because root will need to get iput()'d?

> -int simple_fill_super(struct super_block *s, int magic, struct 
> tree_descr *files)
> +int __simple_fill_super(struct super_block *s, int magic,
> +            struct tree_descr *files, bool registered)
>  {
>      static struct super_operations s_ops = {.statfs = simple_statfs};
>      struct inode *inode;
> @@ -380,6 +381,12 @@ int simple_fill_super(struct super_block
>      inode->i_op = &simple_dir_inode_operations;
>      inode->i_fop = &simple_dir_operations;
>      inode->i_nlink = 2;
> +    /*
> +     * set this as high as a 32 bit val as possible to avoid collisions.
> +     * This is also well above the highest value that iunique_register
> +         * will assign to an inode
> +     */
> +    inode->i_ino = 0xffffffff;
>      root = d_alloc_root(inode);
>      if (!root) {
>          iput(inode);
> @@ -394,12 +401,15 @@ int simple_fill_super(struct super_block
>          inode = new_inode(s);
>          if (!inode)
>              goto out;
> +        if (!registered)
> +            inode->i_ino = i;
> +        else if (iunique_register(inode, 0))
> +            goto out;

Does this not create a memory leak as well?

    Thanx...

       ps

>          inode->i_mode = S_IFREG | files->mode;
>          inode->i_uid = inode->i_gid = 0;
>          inode->i_blocks = 0;
>          inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
>          inode->i_fop = files->ops;
> -        inode->i_ino = i;
>          d_add(dentry, inode);
>      }
>      s->s_root = root;
> @@ -618,7 +628,7 @@ EXPORT_SYMBOL(simple_dir_inode_operation
>  EXPORT_SYMBOL(simple_dir_operations);
>  EXPORT_SYMBOL(simple_empty);
>  EXPORT_SYMBOL(d_alloc_name);
> -EXPORT_SYMBOL(simple_fill_super);
> +EXPORT_SYMBOL(__simple_fill_super);
>  EXPORT_SYMBOL(simple_getattr);
>  EXPORT_SYMBOL(simple_link);
>  EXPORT_SYMBOL(simple_lookup);
> --- linux-2.6/include/linux/fs.h.super
> +++ linux-2.6/include/linux/fs.h
> @@ -1879,10 +1879,35 @@ extern const struct file_operations simp
>  extern struct inode_operations simple_dir_inode_operations;
>  struct tree_descr { char *name; const struct file_operations *ops; 
> int mode; };
>  struct dentry *d_alloc_name(struct dentry *, const char *);
> -extern int simple_fill_super(struct super_block *, int, struct 
> tree_descr *);
> +extern int __simple_fill_super(struct super_block *s, int magic,
> +                struct tree_descr *files, bool registered);
>  extern int simple_pin_fs(struct file_system_type *, struct vfsmount 
> **mount, int *count);
>  extern void simple_release_fs(struct vfsmount **mount, int *count);
>
> +/*
> + * Fill a superblock with a standard set of fields, and add the 
> entries in the
> + * "files" struct. Assign i_ino values to the files sequentially. 
> This function
> + * is appropriate for filesystems that need a particular i_ino value 
> assigned
> + * to a particular "files" entry.
> + */
> +static inline int simple_fill_super(struct super_block *s, int magic,
> +                    struct tree_descr *files)
> +{
> +    return __simple_fill_super(s, magic, files, false);
> +}
> +
> +/*
> + * Just like simple_fill_super, but does an iunique_register on the 
> inodes
> + * created for "files" entries. This function is appropriate when you 
> don't
> + * need a particular i_ino value assigned to each files entry, and 
> when the
> + * filesystem will have other registered inodes.
> + */
> +static inline int registered_fill_super(struct super_block *s, int 
> magic,
> +                        struct tree_descr *files)
> +{
> +    return __simple_fill_super(s, magic, files, true);
> +}
> +
>  extern ssize_t simple_read_from_buffer(void __user *, size_t, loff_t 
> *, const void *, size_t);
>
>  #ifdef CONFIG_MIGRATION
> --- linux-2.6/security/inode.c.super
> +++ linux-2.6/security/inode.c
> @@ -130,7 +130,7 @@ static int fill_super(struct super_block
>  {
>      static struct tree_descr files[] = {{""}};
>
> -    return simple_fill_super(sb, SECURITYFS_MAGIC, files);
> +    return registered_fill_super(sb, SECURITYFS_MAGIC, files);
>  }
>
>  static int get_sb(struct file_system_type *fs_type,
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

