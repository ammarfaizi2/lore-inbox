Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264325AbUEDMQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUEDMQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 08:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbUEDMQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 08:16:29 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:31184 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264325AbUEDMQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 08:16:26 -0400
Subject: Re: [PATCH][SELINUX] Re-open descriptors closed on exec by SELinux
	to /dev/null
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040503144130.42ba1fda.akpm@osdl.org>
References: <1083603014.7446.197.camel@moss-spartans.epoch.ncsc.mil>
	 <20040503144130.42ba1fda.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1083672952.19086.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 May 2004 08:15:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 17:41, Andrew Morton wrote:
> Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> >
> > +/* Create an open file that refers to the null device.
> > +   Derived from the OpenWall LSM. */
> > +struct file *open_devnull(void) 
> > +{
> > +	struct inode *inode;
> > +	struct dentry *dentry;
> > +	struct file *file = NULL;
> > +	struct inode_security_struct *isec;
> > +	dev_t dev;
> > +
> > +	inode = new_inode(current->fs->rootmnt->mnt_sb);
> > +	if (!inode)
> > +		goto out;
> > +
> > +	dentry = dget(d_alloc_root(inode));
> > +	if (!dentry)
> > +		goto out_iput;
> > +
> > +	file = get_empty_filp();
> > +	if (!file)
> > +		goto out_dput;
> > +
> > +	dev = MKDEV(MEM_MAJOR, 3); /* null device */
> > +
> > +	inode->i_uid = current->fsuid;
> > +	inode->i_gid = current->fsgid;
> > +	inode->i_blksize = PAGE_SIZE;
> > +	inode->i_blocks = 0;
> > +	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> > +	inode->i_state = I_DIRTY; /* so that mark_inode_dirty won't touch us */
> > +
> > +	isec = inode->i_security;
> > +	isec->sid = SECINITSID_DEVNULL;
> > +	isec->sclass = SECCLASS_CHR_FILE;
> > +	isec->initialized = 1;
> > +
> > +	file->f_flags = O_RDWR;
> > +	file->f_mode = FMODE_READ | FMODE_WRITE;
> > +	file->f_dentry = dentry;
> > +	file->f_vfsmnt = mntget(current->fs->rootmnt);
> > +	file->f_pos = 0;
> > +
> > +	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, dev);
> > +	if (inode->i_fop->open(inode, file))
> > +		goto out_fput;
> > +
> > +out:
> > +	return file;
> > +out_fput:
> > +	mntput(file->f_vfsmnt);
> > +	put_filp(file);
> > +out_dput:	
> > +	dput(dentry);
> > +out_iput:	
> > +	iput(inode);
> > +	file = NULL;
> > +	goto out;
> > +}
> 
> That seems to be a heck of a lot of code to get a file* which refers to
> /dev/null.  I guess calling flip_open("/dev/null") is a bit grubby, but are
> you sure there's no simpler way?

Not that I know of.  Perhaps Al has a suggestion?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

