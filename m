Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUECVkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUECVkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUECVkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:40:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:3979 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264085AbUECVjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:39:10 -0400
Date: Mon, 3 May 2004 14:41:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] Re-open descriptors closed on exec by SELinux
 to /dev/null
Message-Id: <20040503144130.42ba1fda.akpm@osdl.org>
In-Reply-To: <1083603014.7446.197.camel@moss-spartans.epoch.ncsc.mil>
References: <1083603014.7446.197.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@epoch.ncsc.mil> wrote:
>
> +/* Create an open file that refers to the null device.
> +   Derived from the OpenWall LSM. */
> +struct file *open_devnull(void) 
> +{
> +	struct inode *inode;
> +	struct dentry *dentry;
> +	struct file *file = NULL;
> +	struct inode_security_struct *isec;
> +	dev_t dev;
> +
> +	inode = new_inode(current->fs->rootmnt->mnt_sb);
> +	if (!inode)
> +		goto out;
> +
> +	dentry = dget(d_alloc_root(inode));
> +	if (!dentry)
> +		goto out_iput;
> +
> +	file = get_empty_filp();
> +	if (!file)
> +		goto out_dput;
> +
> +	dev = MKDEV(MEM_MAJOR, 3); /* null device */
> +
> +	inode->i_uid = current->fsuid;
> +	inode->i_gid = current->fsgid;
> +	inode->i_blksize = PAGE_SIZE;
> +	inode->i_blocks = 0;
> +	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> +	inode->i_state = I_DIRTY; /* so that mark_inode_dirty won't touch us */
> +
> +	isec = inode->i_security;
> +	isec->sid = SECINITSID_DEVNULL;
> +	isec->sclass = SECCLASS_CHR_FILE;
> +	isec->initialized = 1;
> +
> +	file->f_flags = O_RDWR;
> +	file->f_mode = FMODE_READ | FMODE_WRITE;
> +	file->f_dentry = dentry;
> +	file->f_vfsmnt = mntget(current->fs->rootmnt);
> +	file->f_pos = 0;
> +
> +	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, dev);
> +	if (inode->i_fop->open(inode, file))
> +		goto out_fput;
> +
> +out:
> +	return file;
> +out_fput:
> +	mntput(file->f_vfsmnt);
> +	put_filp(file);
> +out_dput:	
> +	dput(dentry);
> +out_iput:	
> +	iput(inode);
> +	file = NULL;
> +	goto out;
> +}

That seems to be a heck of a lot of code to get a file* which refers to
/dev/null.  I guess calling flip_open("/dev/null") is a bit grubby, but are
you sure there's no simpler way?

