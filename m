Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVEYFSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVEYFSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 01:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVEYFSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 01:18:14 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:31578 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262272AbVEYFRZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 01:17:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OuQEFgAnzgqct5SSGNAKXRQrX0Rve4yljBR4YfclKV3JBHPxZII681rIySLAk2q8DyjQzKgmNUhQe9ObUhtO0tsjdbJGsjHF5OmSdNzPRVttRXIZ0Ps5vj/GKkdcUMRdfMuuvvvzTuBaC79l9nlIneTYHfBNlD77r60P9N1nWow=
Message-ID: <84144f02050524221757820a18@mail.gmail.com>
Date: Wed, 25 May 2005 08:17:23 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "ericvh@gmail.com" <ericvh@gmail.com>
Subject: Re: [RFC][patch 4/7] v9fs: VFS superblock operations (2.0-rc6)
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi
In-Reply-To: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some more comments follow.

On 5/24/05, ericvh@gmail.com <ericvh@gmail.com> wrote:
> +static int __init init_v9fs(void)
> +{
> +	int error;
> +
> +	v9fs_error_init();
> +
> +	printk(KERN_INFO "Installing v9fs 9P2000 file system support\n");
> +
> +	if ((error = register_filesystem(&v9fs_fs_type))) {
> +		printk(KERN_ERR "Could not register v9fs\n");
> +		return error;
> +	}
> +
> +	v9fs_rpcreq_slab = kmem_cache_create("v9fs_rpcreq_info",
> +					     sizeof(struct v9fs_rpcreq), 0,
> +					     SLAB_HWCACHE_ALIGN, NULL, NULL);
> +
> +	if (!v9fs_rpcreq_slab) {
> +		eprintk(KERN_WARNING, "Couldn't allocate v9fs_rpcreq cache\n");
> +		return -1;

Module initialization fails and you don't do unregister_filesystem. Please
shuffle the code so that you do all other initialization _before_ calling
register_filesystem. And don't forget to release the slab on error.

> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * v9fs_init - shutdown module
> + *
> + */
> +
> +static void __exit exit_v9fs(void)
> +{
> +	struct list_head *p, *n;
> +	struct v9fs_slab *s;
> +
> +	list_for_each_safe(p, n, &v9fs_slab_list) {
> +		s = list_entry(p, struct v9fs_slab, list);
> +		kmem_cache_destroy(s->slab);
> +		list_del(&s->list);
> +	}
> +
> +	kmem_cache_destroy(v9fs_rpcreq_slab);
> +	unregister_filesystem(&v9fs_fs_type);

This looks racy. You should unregister the filesystem before releasing its
resources.

> +}
> +
> +module_init(init_v9fs)
> +module_exit(exit_v9fs)
> +
> +MODULE_AUTHOR("Eric Van Hensbergen <ericvh@gmail.com>");
> +MODULE_AUTHOR("Ron Minnich <rminnich@lanl.gov>");
> +MODULE_LICENSE("GPL");

> Index: fs/9p/vfs_super.c
> ===================================================================
> --- /dev/null  (tree:0bf32353105286a5624aeea862d35a4bbae09851)
> +++ 178666ee376655ef8ec19a2ffc0490241b428110/fs/9p/vfs_super.c  (mode:100644)
> +static struct super_block *v9fs_get_sb(struct file_system_type
> +				       *fs_type, int flags,
> +				       const char *dev_name, void *data)
> +{
> +	struct super_block *sb = NULL;
> +	struct v9fs_fcall *fcall = NULL;
> +	struct inode *inode = NULL;
> +	struct dentry *root = NULL;
> +	struct v9fs_session_info *v9ses = NULL;
> +	struct v9fs_fid *root_fid = NULL;
> +	int mode = S_IRWXUGO | S_ISVTX;
> +	uid_t uid = current->fsuid;
> +	gid_t gid = current->fsgid;
> +	int stat_result = 0;
> +	int newfid = 0;
> +
> +	dprintk(DEBUG_VFS, " \n");
> +
> +	v9ses = kmalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);
> +	if (!v9ses)
> +		return ERR_PTR(-ENOMEM);
> +	memset(v9ses, 0, sizeof(struct v9fs_session_info));

Please consider using kcalloc().

> +
> +	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
> +		dprintk(DEBUG_ERROR, "problem initiating session\n");
> +		sb = ERR_PTR(newfid);
> +		goto free_session;
> +	}
> +
> +	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
> +
> +	sb->s_maxbytes = MAX_LFS_FILESIZE;
> +	sb->s_blocksize =
> +	    v9fs_block_bits(v9ses->maxdata, &sb->s_blocksize_bits);
> +	sb->s_magic = V9FS_WIRE_MAGIC;
> +	sb->s_op = &v9fs_super_ops;

Please consider extracting these to a v9fs_fill_super() function to follow
the style set by other filesystems.

> +
> +	sb->s_flags |=
> +	    MS_ACTIVE | MS_SYNCHRONOUS | MS_DIRSYNC | MS_NODIRATIME |
> +	    MS_NOATIME;
> +
> +	inode = v9fs_get_inode(sb, S_IFDIR | mode);
> +	if ((!inode) || IS_ERR(inode)) {
> +		sb = ERR_PTR(-EINVAL);

It is a good idea to return the same error (to propagate the error code)
but in this case it seems a lot simpler to make v9fs_get_inode always return
NULL on failure. You are being bit too defensive in your programming for
the kernel in other places as well.

> +
> +/**
> + * v9fs_kill_super - Kill Superblock
> + * @s: superblock
> + * 
> + */
> +
> +static void v9fs_kill_super(struct super_block *s)
> +{
> +	struct v9fs_session_info *v9ses =
> +	    (struct v9fs_session_info *)s->s_fs_info;

Redundant cast.

		Pekka
