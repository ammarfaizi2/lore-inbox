Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbTBOXWJ>; Sat, 15 Feb 2003 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTBOXWI>; Sat, 15 Feb 2003 18:22:08 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:60046 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265402AbTBOXWG>; Sat, 15 Feb 2003 18:22:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 15 Feb 2003 15:39:14 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.44.0302151202020.11840-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.50.0302151520290.1891-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302151202020.11840-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Linus Torvalds wrote:

>
> On Fri, 14 Feb 2003, Davide Libenzi wrote:
> > >
> > > Some of it can be pulled in. However, the way the dynamic inode allocation
> > > works, different kinds of inodes _have_ to have different superblocks,
> > > since that's the level where the inode allocation and caching works. So
> > > the fake inodes for a pipe, for example, are _not_ the same as the fake
> > > inodes for the sigfd's. So not all of it is shared.
> >
> > Superblocks will be different, but their "fake" functionality can be
> > shared. A few parameters like file system name, file system magic number,
> > root name, ... will be able to do the trick :
> >
> > fakefs_t fakefs_create(chat const *root, char const *name, unsigned long magic);
> > struct inode *fakefs_new_inode(fakefs_t fkfs);
> > void fakefs_close(fakefs_t fkfs);
>
> I'd love to see this. I agree that a fair amount of this should be
> shareable with the pipe and socket code, for example. But I would call it
> "virtual" instead of "fake", since there is nothing fake about the inode.
> A pipe inode is one of the most fundamental and basic things in UNIX, it's
> not "fake" just because it doesn't live on a harddisk.

Would something like the folowing work for all those cases ( not tested
and even compiled ) ...



- Davide




#define VIRTFS_NAME_MAX 128
#define VIRTFS_ROOT_MAX 128


typedef struct virtfs {
	char name[VIRTFS_NAME_MAX];
	char root[VIRTFS_ROOT_MAX];
	unsigned long magic;
	struct vfsmount *mnt;
	struct file_system_type fst;
	struct dentry_operations dop;
} *virtfs_t;





static int virtfs_delete_dentry(struct dentry *dentry) {

	return 1;
}


static struct super_block *virtfs_get_sb(struct file_system_type *fs_type,
					 int flags, char *dev_name, void *data) {
	virtfs_t vfs = container_of(fs_type, struct virtfs, fst);

	return get_sb_pseudo(fs_type, vfs->root, NULL, vfs->magic);
}


virtfs_t virtfs_create(char const *root, char const *name, unsigned long magic) {
	int error;
	virtfs_t vtfs;

	if (!(vtfs = kmalloc(sizeof(struct virtfs), GFP_KERNEL)))
		return ERR_PTR(-ENOMEM);

	memset(vtfs, 0, sizeof(*vtfs));
	strncpy(vtfs->root, root, sizeof(vtfs->root) - 1);
	strncpy(vtfs->name, name, sizeof(vtfs->name) - 1);
	vtfs->magic = magic;
	vtfs->fst.name = vtfs->name;
	vtfs->fst.get_sb = virtfs_get_sb;
	vtfs->fst.kill_sb = kill_anon_super;
	vtfs->dop.d_delete = virtfs_delete_dentry;

	error = register_filesystem(&vtfs->fst);
	if (error)
		goto eexit_1;

	vtfs->mnt = kern_mount(&vtfs->fst);
	error = PTR_ERR(vtfs->mnt);
	if (IS_ERR(vtfs->mnt))
		goto eexit_2;

	return vtfs;

eexit_2:
	unregister_filesystem(&vtfs->fst);
eexit_1:
	kfree(vtfs);
	return ERR_PTR(error);
}


int virtfs_new_file(virtfs_t vtfs, struct inode **ninode, struct file **nfile) {
	int error;
	struct qstr this;
	struct dentry *dentry;
	struct inode *inode;
	struct file *file;
	char name[32];

	error = -ENFILE;
	file = get_empty_filp();
	if (!file)
		goto eexit_1;

	inode = new_inode(vtfs->mnt);
	error = PTR_ERR(inode);
	if (IS_ERR(inode))
		goto eexit_2;

	error = -ENOMEM;
	sprintf(name, "[%lu]", inode->i_ino);
	this.name = name;
	this.len = strlen(name);
	this.hash = inode->i_ino;
	dentry = d_alloc(vtfs->mnt->mnt_sb->s_root, &this);
	if (!dentry)
		goto eexit_3;
	dentry->d_op = &vtfs->dop;
	d_add(dentry, inode);
	file->f_vfsmnt = mntget(vtfs->mnt);
	file->f_dentry = dget(dentry);

	*nfile = file;
	*ninode = inode;

	return 0;
eexit_3:
	iput(inode);
eexit_2:
	put_filp(file);
eexit_1:
	return error;
}


void virtfs_close(virtfs_t vtfs) {

	unregister_filesystem(&vtfs->fst);
	mntput(vtfs->mnt);
	kfree(vtfs);
}

