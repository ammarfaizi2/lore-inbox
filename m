Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVBDWLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVBDWLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbVBDWJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:09:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29075 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266666AbVBDVjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:39:11 -0500
Date: Fri, 4 Feb 2005 21:39:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 3
Message-ID: <20050204213909.GA26241@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Zanussi <zanussi@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
	Robert Wisniewski <bob@watson.ibm.com>,
	Tim Bird <tim.bird@AM.SONY.COM>, karim@opersys.com
References: <16899.55393.651042.627079@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16899.55393.651042.627079@tut.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the filesystem path especially relayfs_create_entry and the functions
called by it seem overly complex, probably because copying from ramfs
which allows namespace operations from userland.  See the totally untested
code below for how it could be done more cleanly.

What I really dislike is the code for automatically creating complex
hiearchies.  What kinds of hierachies does LTT use?  It shouldn't be
more than subsystem/{stream1, stream2, ..., streamN}, right?  In that
case I think we could leave it to the user to take of that himself.



static struct inode *relayfs_get_inode(struct super_block *sb, int mode)
{
	struct inode * inode = new_inode(sb);

	if (!inode)
		return NULL;

	inode->i_mode = mode;
	inode->i_uid = 0;
	inode->i_gid = 0;
	inode->i_blksize = PAGE_CACHE_SIZE;
	inode->i_blocks = 0;
	inode->i_mapping->backing_dev_info = &relayfs_backing_dev_info;
	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;

	switch (mode & S_IFMT) {
	case S_IFREG:
		inode->i_fop = &relayfs_file_operations;
		break;
	case S_IFDIR:
		inode->i_op = &simple_dir_inode_operations;
		inode->i_fop = &simple_dir_operations;
		/*
		 * directory inodes start off with i_nlink == 2 (for "." entry)
		 */
		inode->i_nlink++;
		break;
	default:
		break;
	}

	return inode;
}

/**
 *	relayfs_create_entry - create a relayfs directory or file
 *	@name: the name of the file to create
 *	@parent: parent directory
 *	@dentry: result dentry
 *	@mode: mode
 *	@data: data to associate with the file
 *
 *	Creates a file or directory with the specifed permissions.
 */
static int relayfs_create_entry(const char *name, struct dentry *parent,
				struct dentry **dentry, int mode, void *data)
{
	struct qstr qname;
	struct dentry *d;
	struct inode *inode;
	int error = 0;

	BUG_ON(!S_ISREG(mode) || !S_ISDIR(mode));

	error = simple_pin_fs("relayfs", &relayfs_mount, &relayfs_mount_count);
	if (error) {
		printk(KERN_ERR "Couldn't mount relayfs: errcode %d\n", error);
		return error;
	}

	qname.name = name;
	qname.len = strlen(name);
	qname.hash = full_name_hash(name, qname.len);

	if (parent == NULL)
		if (relayfs_mount && relayfs_mount->mnt_sb)
			parent = relayfs_mount->mnt_sb->s_root;

	if (parent == NULL) {
		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
 		return -EINVAL;
	}

	parent = dget(parent);
	down(&parent->d_inode->i_sem);
	d = lookup_hash(&qname, parent);
	if (IS_ERR(d)) {
		error = PTR_ERR(d);
		goto release_mount;
	}

	if (d->d_inode) {
		error = -EEXIST;
		goto release_mount;
	}

	inode = relayfs_get_inode(parent->d_inode->i_sb, mode);
	if (!inode) {
		error = -ENOSPC;
		goto release_mount;
	}

	d_instantiate(d, inode);
	dget(d);	/* Extra count - pin the dentry in core */

	if (mode & S_IFREG)
		d->d_inode->u.generic_ip = data;
	else
		parent->d_inode->i_nlink++;

	error = 0;
	goto exit;
	
release_mount:		
	simple_release_fs(&relayfs_mount, &relayfs_mount_count);

exit:
	*dentry = d;
	up(&parent->d_inode->i_sem);
	dput(parent);

	return error;
}

