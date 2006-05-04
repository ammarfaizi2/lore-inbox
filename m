Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWEDOiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWEDOiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWEDOiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:38:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:31057 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751400AbWEDOiC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:38:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MuSghQfkPtmmD000byqR9uiUp7mQqabZxxw/jXfu97wBUTvV/FaVEfUS7PqP19BCQgHfwI+S9rxOrnhoooGlO26QLcUFiIR/3llcVFuqYn5krb5qpfkakxnL348Mw40ppitK3BqBK+qyxrNjh5QWxVKwkqmUloNpFsYI12LTLFQ=
Message-ID: <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com>
Date: Thu, 4 May 2006 17:37:54 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Phillip Hellewell" <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <20060504033829.GE28613@hellewell.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033829.GE28613@hellewell.homeip.net>
X-Google-Sender-Auth: 876d26d95c650439
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

Some comments below.

On 5/4/06, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> +kmem_cache_t *ecryptfs_inode_info_cache;

Please use struct kmem_cache instead of the typedef.

> +static struct inode *ecryptfs_alloc_inode(struct super_block *sb) {

Formatting

> +       struct ecryptfs_inode_info *ecryptfs_inode = NULL;

Redundant initialization

> +       struct inode *inode = NULL;
> +
> +       ecryptfs_printk(KERN_DEBUG, "Enter; sb = [%p]\n", sb);
> +       ecryptfs_inode = kmem_cache_alloc(ecryptfs_inode_info_cache,
> +                                         SLAB_KERNEL);
> +       if (unlikely(!ecryptfs_inode)) {
> +               ecryptfs_printk(KERN_WARNING,
> +                               "Failed to allocate new inode\n");
> +               goto out;

No need to log it, just return NULL here

> +       }
> +       ecryptfs_init_crypt_stat(&(ecryptfs_inode->crypt_stat));
> +       inode = &(ecryptfs_inode->vfs_inode);

Bogus parenthesis, twice. Inode is a redundant local variable, btw.

> +out:
> +       ecryptfs_printk(KERN_DEBUG, "Exit; inode = [%p]\n", inode);
> +       return inode;
> +}
> +
> +/**
> + * This is used during the final destruction of the inode.
> + * All allocation of memory related to the inode, including allocated
> + * memory in the crypt_stat struct, will be released here.
> + * There should be no chance that this deallocation will be missed.
> + */
> +static void ecryptfs_destroy_inode(struct inode *inode) {

Formatting

> +       struct ecryptfs_crypt_stat *crypt_stat;
> +
> +       ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]\n", inode);
> +       crypt_stat = &(ECRYPTFS_INODE_TO_PRIVATE(inode))->crypt_stat;
> +       ecryptfs_destruct_crypt_stat(crypt_stat);
> +       kmem_cache_free(ecryptfs_inode_info_cache,
> +                       ECRYPTFS_INODE_TO_PRIVATE(inode));

Better to introduce a local variable for CRYPTFS_INODE_TO_PRIVATE.
More readable and smaller kernel text that way.

> +       ecryptfs_printk(KERN_DEBUG, "Exit\n");
> +}
> +
> +/**
> + * Set up the ecryptfs inode.
> + */
> +static void ecryptfs_read_inode(struct inode *inode)
> +{
> +       ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]\n", inode);
> +       /* This is where we setup the self-reference in the vfs_inode's
> +        * u.generic_ip. That way we don't have to walk the list again. */
> +       ECRYPTFS_INODE_TO_PRIVATE_SM(inode) =
> +               list_entry(inode, struct ecryptfs_inode_info, vfs_inode);
> +       ECRYPTFS_INODE_TO_LOWER(inode) = NULL;

Hmm, ugly, please make the setters explicit instead.

> +       inode->i_version++;
> +       inode->i_op = &ecryptfs_main_iops;
> +       inode->i_fop = &ecryptfs_main_fops;
> +       inode->i_mapping->a_ops = &ecryptfs_aops;
> +       ecryptfs_printk(KERN_DEBUG, "Exit\n");
> +}
> +
> +
> +/**
> + * This is called through iput_final().
> + * This is function will replace generic_drop_inode. The end result of which
> + * is we are skipping the check in inode->i_nlink, which we do not use.
> + */
> +static void ecryptfs_drop_inode(struct inode *inode) {

Formatting

> +       generic_delete_inode(inode);
> +}
> +
> +/**
> + * Final actions when unmounting a file system.
> + * This will handle deallocation and release of our private data.
> + */
> +static void ecryptfs_put_super(struct super_block *sb)
> +{
> +       struct ecryptfs_sb_info *sb_info = ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb);

You probably want to rename ECRYPTFS_SUPERBLOCK_TO_PRIVATE to
ecryptfs_sb or similar.

> +
> +       ecryptfs_printk(KERN_DEBUG, "Enter\n");
> +       mntput(sb_info->lower_mnt);
> +       key_put(sb_info->mount_crypt_stat.global_auth_tok_key);
> +       kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
> +       ECRYPTFS_SUPERBLOCK_TO_PRIVATE_SM(sb) = NULL;
> +       ecryptfs_printk(KERN_DEBUG, "Exit\n");
> +}
> +
> +/**
> + * Get the filesystem statistics. Currently, we let this pass right through
> + * to the lower filesystem and take no action ourselves.
> + */
> +static int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
> +{
> +       int rc = 0;

Redundant initialization

> +
> +       ecryptfs_printk(KERN_DEBUG, "Enter\n");
> +       rc = vfs_statfs(ECRYPTFS_SUPERBLOCK_TO_LOWER(sb), buf);
> +       ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
> +       return rc;
> +}
> +
> +/**
> + * Called to ask filesystem to change mount options. Not implemented;
> + * returns -ENOSYS every time.
> + */
> +static int ecryptfs_remount_fs(struct super_block *sb, int *flags, char *data)
> +{
> +       ecryptfs_printk(KERN_DEBUG, "Enter\n");
> +       ecryptfs_printk(KERN_DEBUG, "Exit\n");
> +       return -ENOSYS;
> +}

Any reason you want to keep this around?

> +
> +/**
> + * Called by iput() when the inode reference count reached zero
> + * and the inode is not hashed anywhere.  Used to clear anything
> + * that needs to be, before the inode is completely destroyed and put
> + * on the inode free list. We use this to drop out reference to the
> + * lower inode.
> + */
> +static void ecryptfs_clear_inode(struct inode *inode)
> +{
> +       ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]; i_ino = [0x%.16x]\n",
> +                       inode, inode->i_ino);
> +       iput(ECRYPTFS_INODE_TO_LOWER(inode));
> +       ecryptfs_printk(KERN_DEBUG, "Exit\n");
> +}
> +
> +/**
> + * Called in do_umount() if the MNT_FORCE flag was used and this
> + * function is defined.  See comment in linux/fs/super.c:do_umount().
> + * Used only in nfs, to kill any pending RPC tasks, so that subsequent
> + * code can actually succeed and won't leave tasks that need handling.
> + */
> +static void ecryptfs_umount_begin(struct vfsmount *vfsmnt, int flags)
> +{
> +       struct vfsmount *lower_mnt;
> +       struct super_block *lower_sb;
> +
> +       ecryptfs_printk(KERN_DEBUG, "Enter\n");
> +       lower_mnt = ECRYPTFS_SUPERBLOCK_TO_PRIVATE(vfsmnt->mnt_sb)->lower_mnt;
> +       lower_sb = lower_mnt->mnt_sb;
> +       if (lower_sb->s_op->umount_begin)
> +               lower_sb->s_op->umount_begin(lower_mnt, flags);
> +       ecryptfs_printk(KERN_DEBUG, "Exit\n");
> +}
> +
> +/**
> + * Prints the directory we are currently mounted over
> + *
> + * @return Zero on success; non-zero otherwise
> + */
> +static int ecryptfs_show_options(struct seq_file *m, struct vfsmount *mnt)
> +{
> +       struct super_block *sb = mnt->mnt_sb;
> +       int rc = 0;
> +       char *tmp = NULL;
> +       char *path;
> +
> +       ecryptfs_printk(KERN_DEBUG, "Enter\n");
> +       tmp = (char *)__get_free_page(GFP_KERNEL);
> +       if (!tmp) {
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> +       path = d_path(ECRYPTFS_DENTRY_TO_LOWER(sb->s_root),
> +                     ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb)->lower_mnt, tmp,
> +                     PAGE_SIZE);

Use of local variables probably would clean that up

> +       seq_printf(m, ",dir=%s", path);
> +       free_page((unsigned long)tmp);
> +out:
> +       ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
> +       return rc;
> +}
> +
> +struct super_operations ecryptfs_sops = {
> +       .alloc_inode = ecryptfs_alloc_inode,
> +       .destroy_inode = ecryptfs_destroy_inode,
> +       .read_inode = ecryptfs_read_inode,
> +       .drop_inode = ecryptfs_drop_inode,
> +       .put_super = ecryptfs_put_super,
> +       .statfs = ecryptfs_statfs,
> +       .remount_fs = ecryptfs_remount_fs,
> +       .clear_inode = ecryptfs_clear_inode,
> +       .umount_begin = ecryptfs_umount_begin,
> +       .show_options = ecryptfs_show_options
> +};
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
