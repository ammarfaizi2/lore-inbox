Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbUKAMRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbUKAMRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUKAMRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:17:41 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:51394 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S261765AbUKAMPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:15:52 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][2.4 PATCH] A restricted /dev filesystem.
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Message-Id: <200411012114.IIG42981.tSSMNOFVtPMYFGLOJ@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Mon, 1 Nov 2004 21:15:47 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Purpose:

  Ensure that device files in /dev directory are never faked.
  For example, the cracker who got root privileges can't do like
  'rm -f /dev/null; mknod /dev/null b 8 0'.

  Making root-fs read-only will improve security.
  But since some device files in /dev needs to be chown()/chmod()-able,
  some special technique is required to make root-fs read-only.

  Devfs is a nice choice, but devfs can't ensure the bindings between
  filenames and their device numbers (i.e. /dev/null may be 'block-8-0',
  which should be 'char-1-3'.)

  So I want a filesystem that can ensure the bindings.
  And here is my work, but since I'm a newbie developing a new filesystem,
  I'm afraid there are some bugs, especially locking related bugs.
  So, could someone please check the code?
  I made this code based on /usr/src/linux-2.4.27/fs/ramfs/inode.c .

Code Name:

  SYAORAN (Simple Yet All-important Object Realizing Abiding Nexus)

Specifications:

  No regular files allowed. (since I think /dev needn't to keep regular files.)
  No hardlinks allowed. (since I think hardlinks are unused for /dev .)
  "Files which are created at mount time" and "files which can be created/deleted
  after mount time" are given via a config file using "mount -o" option.
  Modified part starts with '/***** SYAORAN start. *****/'
  and ends with '/***** SYAORAN end. *****/' .

Config File Format:

  There are 10 elements that describes an entry.

    'filename' is a fullpath seen from the mount point, but no leading / .
    'permission' is specified in an octal format, between 000 and 777.
    'uid' and 'gid' are specified in a decimal format.
    'may_create' is a boolean flag that controls whether the entry can be created after mount.
    'may_delete' is a boolean flag that controls whether the entry can be deleted after mount.
    'type' is a character that specifies the device type, one of 'd' (dir), 'f' (fifo), 's' (socket), 'c' (char-dev), 'b' (blk-dev), 'l' (symlink).
    'symlink_data' is an initial content that is used when creating a symlink at mount time.
    'major' and 'minor' are device's major/minor number specified in a decimal format.

  Lines are separeted by '\n', and all chars that matches "(unsigned char) c <= ' '" are treated as delimiters.
  The permission, uid, gid are ignored for symlinks.

Usage:

  gcc -Wall -O3 -D__KERNEL__ -DMODULE -I/usr/src/linux-2.4.27/include/ -c syaoran.c
  insmod syaoran.o
  mkdir -p /mnt/test/
  mount -t syaoran -o /root/syaoran.conf none /mnt/test/

Regards....

---
     Tetsuo Handa


---------- Example of config file ( /root/syaoran.conf ) ----------

#filename	permission	uid	gid	may_create	may_delete	type	[	symlink_data	|	major	minor	]
pts		755	0	0	0	0	d
shm		755	0	0	0	0	d
fd		777	0	0	0	0	l	/proc/self/fd
stdin	777	0	0	0	0	l	/proc/self/fd/0
stdout	777	0	0	0	0	l	/proc/self/fd/1
stderr	777	0	0	0	0	l	/proc/self/fd/2
null	666	0	0	0	0	c	1	3
zero	666	0	0	0	0	c	1	5
random	644	0	0	0	0	c	1	8
urandom	644	0	0	0	0	c	1	9
tty		666	0	0	0	0	c	5	0
tty0	600	0	0	0	0	c	4	0
tty1	600	0	0	0	0	c	4	1
tty2	600	0	0	0	0	c	4	2
tty3	600	0	0	0	0	c	4	3
tty4	600	0	0	0	0	c	4	4
tty5	600	0	0	0	0	c	4	5
tty6	600	0	0	0	0	c	4	6
tty7	600	0	0	0	0	c	4	7
tty8	600	0	0	0	0	c	4	8
cdrom	777	0	0	1	1	l	/dev/scd0
mouse	777	0	0	1	1	l	psaux
console	600	0	0	1	0	c	5	1
fd0	660	0	19	0	0	b	2	0
fd1	660	0	19	0	0	b	2	1
fd2	660	0	19	0	0	b	2	2
fd3	660	0	19	0	0	b	2	3
hda		660	0	6	0	0	b	3	0
hda1	660	0	6	0	0	b	3	1
hda2	660	0	6	0	0	b	3	2
hda3	660	0	6	0	0	b	3	3
hda5	660	0	6	0	0	b	3	5
hda6	660	0	6	0	0	b	3	6
hda7	660	0	6	0	0	b	3	7
hda8	660	0	6	0	0	b	3	8
hda9	660	0	6	0	0	b	3	9
hda10	660	0	6	0	0	b	3	10
hda11	660	0	6	0	0	b	3	11
initctl	600	0	0	1	1	p
log		666	0	0	1	1	s
rtc		644	0	0	0	0	c	10	135
ptmx	666	0	0	0	0	c	5	2
ram	777	0	0	1	1	l	/dev/ram0
ram0	660	0	6	0	0	b	1	0
ram1	660	0	6	0	0	b	1	1
sda		660	0	6	0	0	b	8	0
initrd	660	0	6	1	0	b	1	250
psaux	600	0	0	0	0	c	10	1
apm_bios	600	0	0	0	0	c	10	134
cpu		755	0	0	0	0	d
cpu/0	755	0	0	0	0	d
cpu/0/microcode	600	0	0	0	0	c	10	184
ttyS0	660	0	14	0	0	c	4	64
ttyS1	660	0	14	0	0	c	4	65
ttyS2	660	0	14	0	0	c	4	66
ttyS3	660	0	14	0	0	c	4	67
ptal-printd	777	0	0	1	1	l	/var/run/ptal-printd
gpmctl	700	0	0	1	1	s
scd0	660	0	6	0	0	b	11	0

---------- Source Code ----------

/*
 *   Restricted /dev filesystem. [EXPERIMENTAL]
 *
 *    based on /usr/src/linux-2.4.27/fs/ramfs/inode.c
 *
 */

/*
 * Resizable simple ram filesystem for Linux.
 *
 * Copyright (C) 2000 Linus Torvalds.
 *               2000 Transmeta Corp.
 *
 * Usage limits added by David Gibson, Linuxcare Australia.
 * This file is released under the GPL.
 */

/*
 * NOTE! This filesystem is probably most useful
 * not as a real filesystem, but as an example of
 * how virtual filesystems can be written.
 *
 * It doesn't get much simpler than this. Consider
 * that this file implements the full semantics of
 * a POSIX-compliant read-write filesystem.
 *
 * Note in particular how the filesystem does not
 * need to implement any data structures of its own
 * to keep track of the virtual data: using the VFS
 * caches is sufficient.
 */

#include <linux/module.h>
#include <linux/fs.h>
#include <linux/pagemap.h>
#include <linux/init.h>
#include <linux/string.h>
#include <linux/locks.h>

#include <asm/uaccess.h>

/***** SYAORAN start. *****/
static void syaoran_put_super(struct super_block *sb);
static int Syaoran_Initialize(struct super_block *sb, void *data);
static void MakeInitialNodes(struct super_block *sb);
static int MayCreateNode(struct dentry *dentry, int mode, int dev);
static int MayDeleteNode(struct dentry *dentry);
/***** SYAORAN end. *****/

/* some random number */
#define SYAORAN_MAGIC	0x2F646576  /* = '/dev' */

static struct super_operations syaoran_ops;
static struct address_space_operations syaoran_aops;
static struct file_operations syaoran_file_operations;
static struct inode_operations syaoran_dir_inode_operations;

static int syaoran_statfs(struct super_block *sb, struct statfs *buf)
{
	buf->f_type = SYAORAN_MAGIC;
	buf->f_bsize = PAGE_CACHE_SIZE;
	buf->f_namelen = NAME_MAX;
	return 0;
}

/*
 * Lookup the data. This is trivial - if the dentry didn't already
 * exist, we know it is negative.
 */
static struct dentry * syaoran_lookup(struct inode *dir, struct dentry *dentry)
{
	if (dentry->d_name.len > NAME_MAX)
		return ERR_PTR(-ENAMETOOLONG);
	d_add(dentry, NULL);
	return NULL;
}

/*
 * Read a page. Again trivial. If it didn't already exist
 * in the page cache, it is zero-filled.
 */
static int syaoran_readpage(struct file *file, struct page * page)
{
	if (!Page_Uptodate(page)) {
		memset(kmap(page), 0, PAGE_CACHE_SIZE);
		kunmap(page);
		flush_dcache_page(page);
		SetPageUptodate(page);
	}
	UnlockPage(page);
	return 0;
}

static int syaoran_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
{
	void *addr = kmap(page);
	if (!Page_Uptodate(page)) {
		memset(addr, 0, PAGE_CACHE_SIZE);
		flush_dcache_page(page);
		SetPageUptodate(page);
	}
	SetPageDirty(page);
	return 0;
}

static int syaoran_commit_write(struct file *file, struct page *page, unsigned offset, unsigned to)
{
	struct inode *inode = page->mapping->host;
	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;

	kunmap(page);
	if (pos > inode->i_size)
		inode->i_size = pos;
	return 0;
}

struct inode *syaoran_get_inode(struct super_block *sb, int mode, int dev)
{
	struct inode * inode = new_inode(sb);

	if (inode) {
		inode->i_mode = mode;
		inode->i_uid = current->fsuid;
		inode->i_gid = current->fsgid;
		inode->i_blksize = PAGE_CACHE_SIZE;
		inode->i_blocks = 0;
		inode->i_rdev = NODEV;
		inode->i_mapping->a_ops = &syaoran_aops;
		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
		switch (mode & S_IFMT) {
		default:
			init_special_inode(inode, mode, dev);
			break;
		case S_IFREG:
			inode->i_fop = &syaoran_file_operations;
			break;
		case S_IFDIR:
			inode->i_op = &syaoran_dir_inode_operations;
			inode->i_fop = &dcache_dir_ops;
			break;
		case S_IFLNK:
			inode->i_op = &page_symlink_inode_operations;
			break;
		}
	}
	return inode;
}

/*
 * File creation. Allocate an inode, and we're done..
 */
static int syaoran_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
{
	/***** SYAORAN start. *****/
	if (MayCreateNode(dentry, mode, dev) < 0) return -EPERM;
	/***** SYAORAN end. *****/
	struct inode * inode = syaoran_get_inode(dir->i_sb, mode, dev);
	int error = -ENOSPC;

	if (inode) {
		if (dir->i_mode & S_ISGID) {
			inode->i_gid = dir->i_gid;
			if (S_ISDIR(mode))
				inode->i_mode |= S_ISGID;
		}
		d_instantiate(dentry, inode);
		dget(dentry);		/* Extra count - pin the dentry in core */
		error = 0;
	}
	return error;
}

static int syaoran_mkdir(struct inode * dir, struct dentry * dentry, int mode)
{
	return syaoran_mknod(dir, dentry, mode | S_IFDIR, 0);
}

static int syaoran_create(struct inode *dir, struct dentry *dentry, int mode)
{
	return syaoran_mknod(dir, dentry, mode | S_IFREG, 0);
}

/*
 * Link a file..
 */
static int syaoran_link(struct dentry *old_dentry, struct inode * dir, struct dentry * dentry)
{
	/***** SYAORAN start. *****/
	return -EPERM;                /* No hardlinks allowed. */
	/***** SYAORAN end. *****/
	struct inode *inode = old_dentry->d_inode;

	if (S_ISDIR(inode->i_mode))
		return -EPERM;

	inode->i_nlink++;
	atomic_inc(&inode->i_count);	/* New dentry reference */
	dget(dentry);		/* Extra pinning count for the created dentry */
	d_instantiate(dentry, inode);
	return 0;
}

static inline int syaoran_positive(struct dentry *dentry)
{
	return dentry->d_inode && !d_unhashed(dentry);
}

/*
 * Check that a directory is empty (this works
 * for regular files too, they'll just always be
 * considered empty..).
 *
 * Note that an empty directory can still have
 * children, they just all have to be negative..
 */
static int syaoran_empty(struct dentry *dentry)
{
	struct list_head *list;

	spin_lock(&dcache_lock);
	list = dentry->d_subdirs.next;

	while (list != &dentry->d_subdirs) {
		struct dentry *de = list_entry(list, struct dentry, d_child);

		if (syaoran_positive(de)) {
			spin_unlock(&dcache_lock);
			return 0;
		}
		list = list->next;
	}
	spin_unlock(&dcache_lock);
	return 1;
}

/*
 * This works for both directories and regular files.
 * (non-directories will always have empty subdirs)
 */
static int syaoran_unlink(struct inode * dir, struct dentry *dentry)
{
	/***** SYAORAN start. *****/
	if (MayDeleteNode(dentry) < 0) return -EPERM;
	/***** SYAORAN end. *****/
	int retval = -ENOTEMPTY;
	if (syaoran_empty(dentry)) {
		struct inode *inode = dentry->d_inode;

		inode->i_nlink--;
		dput(dentry);			/* Undo the count from "create" - this does all the work */
		retval = 0;
	}
	return retval;
}

#define syaoran_rmdir syaoran_unlink

/*
 * The VFS layer already does all the dentry stuff for rename,
 * we just have to decrement the usage count for the target if
 * it exists so that the VFS layer correctly free's it when it
 * gets overwritten.
 */
static int syaoran_rename(struct inode * old_dir, struct dentry *old_dentry, struct inode * new_dir,struct dentry *new_dentry)
{
	/***** SYAORAN start. *****/
	struct inode *inode = old_dentry->d_inode;
	if (!inode || MayDeleteNode(old_dentry) < 0 || MayCreateNode(new_dentry, inode->i_mode, inode->i_rdev) < 0) return -EPERM;
	/***** SYAORAN end. *****/
	int error = -ENOTEMPTY;

	if (syaoran_empty(new_dentry)) {
		struct inode *inode = new_dentry->d_inode;
		if (inode) {
			inode->i_nlink--;
			dput(new_dentry);
		}
		error = 0;
	}
	return error;
}

static int syaoran_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
{
	int error;

	error = syaoran_mknod(dir, dentry, S_IFLNK | S_IRWXUGO, 0);
	if (!error) {
		int l = strlen(symname)+1;
		struct inode *inode = dentry->d_inode;
		error = block_symlink(inode, symname, l);
	}
	return error;
}

static int syaoran_sync_file(struct file * file, struct dentry *dentry, int datasync)
{
	return 0;
}

static struct address_space_operations syaoran_aops = {
	readpage:	syaoran_readpage,
	writepage:	fail_writepage,
	prepare_write:	syaoran_prepare_write,
	commit_write:	syaoran_commit_write
};

static struct file_operations syaoran_file_operations = {
	read:		generic_file_read,
	write:		generic_file_write,
	mmap:		generic_file_mmap,
	fsync:		syaoran_sync_file,
};

static struct inode_operations syaoran_dir_inode_operations = {
	create:		syaoran_create,
	lookup:		syaoran_lookup,
	link:		syaoran_link,
	unlink:		syaoran_unlink,
	symlink:	syaoran_symlink,
	mkdir:		syaoran_mkdir,
	rmdir:		syaoran_rmdir,
	mknod:		syaoran_mknod,
	rename:		syaoran_rename,
};

static struct super_operations syaoran_ops = {
	statfs:		syaoran_statfs,
	put_inode:	force_delete,
	/***** SYAORAN start. *****/
	put_super:  syaoran_put_super,
	/***** SYAORAN end. *****/
};

static struct super_block *syaoran_read_super(struct super_block * sb, void * data, int silent)
{
	struct inode * inode;
	struct dentry * root;

	sb->s_blocksize = PAGE_CACHE_SIZE;
	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
	sb->s_magic = SYAORAN_MAGIC;
	sb->s_op = &syaoran_ops;
	/***** SYAORAN start. *****/
	if (Syaoran_Initialize(sb, data) < 0) return NULL;
	/***** SYAORAN end. *****/
	inode = syaoran_get_inode(sb, S_IFDIR | 0755, 0);
	if (!inode)
		return NULL;

	root = d_alloc_root(inode);
	if (!root) {
		iput(inode);
		return NULL;
	}
	sb->s_root = root;
	/***** SYAORAN start. *****/
	MakeInitialNodes(sb);
	/***** SYAORAN end. *****/
	return sb;
}

static DECLARE_FSTYPE(syaoran_fs_type, "syaoran", syaoran_read_super, FS_LITTER);

static int __init init_syaoran_fs(void)
{
	return register_filesystem(&syaoran_fs_type);
}

static void __exit exit_syaoran_fs(void)
{
	unregister_filesystem(&syaoran_fs_type);
}

module_init(init_syaoran_fs)
module_exit(exit_syaoran_fs)

MODULE_LICENSE("GPL");

/***** SYAORAN start. *****/

#if !defined(lock_kernel)
#include <asm/smplock.h>
#endif
extern void *kmalloc(size_t, int);
extern void kfree(const void *);

/* Similar to lookup_create(). */
static struct dentry *lookup_create2(const char *name, struct dentry *base, int is_dir) {
	unsigned long hash;
	struct qstr this;
	unsigned int c;
	struct dentry *dentry = ERR_PTR(-EACCES);
	int len = name ? strlen(name) : 0;
	this.name = name;
	this.len = len;
	down(&base->d_inode->i_sem);
	if (!len) goto fail;
	hash = init_name_hash();
	while (len--) {
		c = * (const unsigned char *) name++;
		if (c == '/' || c == '\0') goto fail;
		hash = partial_name_hash(c, hash);
	}
	this.hash = end_name_hash(hash);
	dentry = lookup_hash(&this, base);
	if (IS_ERR(dentry)) goto fail;
	if (!is_dir && this.name[this.len] && !dentry->d_inode) goto enoent;
	return dentry;
 enoent:
	dput(dentry);
	dentry = ERR_PTR(-ENOENT);
 fail:
	return dentry;
}

/* mkdir() used at mount time. */
static int fs_mkdir(const char *pathname, struct dentry *base, int mode, uid_t user, gid_t group) {
	struct dentry *dentry = lookup_create2(pathname, base, 1);
	int error = PTR_ERR(dentry);
	if (!IS_ERR(dentry)) {
		error = vfs_mkdir(base->d_inode, dentry, mode);
		if (!error) {
			lock_kernel();
			dentry->d_inode->i_uid = user;
			dentry->d_inode->i_gid = group;
			unlock_kernel();
		}
		dput(dentry);
	}
	up(&base->d_inode->i_sem);
	return error;
}

/* mknod() used at mount time. */
static int fs_mknod(const char *filename, struct dentry *base, int mode, dev_t dev, uid_t user, gid_t group) {
	switch (mode & S_IFMT) {
	case S_IFCHR: case S_IFBLK: case S_IFIFO: case S_IFSOCK:
		break;
	default:
		return -EPERM;
	}
	struct dentry *dentry = lookup_create2(filename, base, 0);
	int error = PTR_ERR(dentry);
	if (!IS_ERR(dentry)) {
		error = vfs_mknod(base->d_inode, dentry, mode, dev);
		if (!error) {
			lock_kernel();
			dentry->d_inode->i_uid = user;
			dentry->d_inode->i_gid = group;
			unlock_kernel();
		}
		dput(dentry);
	}
	up(&base->d_inode->i_sem);
	return error;
}

/* symlink() used at mount time. */
static int fs_symlink(const char *pathname, struct dentry *base, char *oldname) {
	struct dentry *dentry = lookup_create2(pathname, base, 0);
	int error = PTR_ERR(dentry);
	if (!IS_ERR(dentry)) {
		error = vfs_symlink(base->d_inode, dentry, oldname);
		dput(dentry);
	}
	up(&base->d_inode->i_sem);
	return error;
}

/* Format a line. Compress multiple delimiters. */
static void NormalizeLine(unsigned char *buffer) {
	unsigned char *sp = buffer, *dp = buffer;
	int first = 1;
	while (*sp && *sp <= ' ') sp++;
	while (*sp) {
		if (!first) *dp++ = ' ';
		first = 0;
		while (*sp > ' ') *dp++ = *sp++;
		while (*sp && *sp <= ' ') sp++;
	}
	*dp = '\0';
}

/* strdup() */
static char *strdup(const char *str) {
	char *cp;
	int len = str ? strlen(str) + 1 : 0;
	if ((cp = kmalloc(len, GFP_KERNEL)) != NULL) memmove(cp, str, len);
	return cp;
}

typedef struct {
	char *name;         /* Pathname under the mount point, excluding the beggining / . */
	mode_t mode;        /* Mode and permission                                         */
	uid_t uid;          /* User                                                        */
	gid_t gid;          /* Group                                                       */
	kdev_t kdev;        /* Device number                                               */
	char *symlink_data; /* Symlink's content                                           */
	int may_create;     /* Can this file created after mount?                          */
	int may_delete;     /* Can this file deleted after mount?                          */
} DEVLIST;

struct syaoran_sb_info {
	DEVLIST *entry;            /* entry's list.                        */
	unsigned int entry_count;  /* entry[0] ... entry[entry_count - 1]  */
	unsigned int buffer_size;  /* kmalloc()'ed size for entry[]        */
	int initialize_done;       /* mount operation finished?            */
};

/* Add file info to the entry[]. */
static int RegisterNodeInfo(char *buffer, struct super_block *sb) {
	enum {
		ARG_FILENAME     = 0,
		ARG_PERMISSION   = 1,
		ARG_UID          = 2,
		ARG_GID          = 3,
		ARG_MAY_CREATE   = 4,
		ARG_MAY_DELETE   = 5,
		ARG_DEV_TYPE     = 6,
		ARG_SYMLINK_DATA = 7,
		ARG_DEV_MAJOR    = 7,
		ARG_DEV_MINOR    = 8,
		MAX_ARG          = 9
	};
	char *args[MAX_ARG];
	int i;
	int error = -EINVAL;
	memset(args, 0, sizeof(args));
	args[0] = buffer;
	for (i = 1; i < MAX_ARG; i++) {
		args[i] = strchr(args[i - 1] + 1, ' ');
		if (!args[i]) break;
		*args[i]++ = '\0';
	}
	/*
	printk("<%s> <%s> <%s> <%s> <%s> <%s> <%s> <%s> <%s>\n", args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
	*/
	if (!args[ARG_FILENAME] || !args[ARG_PERMISSION] || !args[ARG_UID] || !args[ARG_GID]
		|| !args[ARG_DEV_TYPE] || !args[ARG_MAY_CREATE] || !args[ARG_MAY_DELETE]) goto out;
	mode_t perm; uid_t uid; gid_t gid; unsigned short int major = 0, minor = 0; int may_create, may_delete;
	if (sscanf(args[ARG_PERMISSION], "%ho", &perm) != 1 || !(perm <= 0777) || sscanf(args[ARG_UID], "%u", &uid) != 1
		|| sscanf(args[ARG_GID], "%u", &gid) != 1 || sscanf(args[ARG_MAY_CREATE], "%d", &may_create) != 1 
		|| sscanf(args[ARG_MAY_DELETE], "%d", &may_delete) != 1 || *(args[ARG_DEV_TYPE] + 1)) goto out;
	switch (*args[ARG_DEV_TYPE]) {
	case 'c':
		perm |= S_IFCHR;
		if (!args[ARG_DEV_MAJOR] || sscanf(args[ARG_DEV_MAJOR], "%hu", &major) != 1
			|| !args[ARG_DEV_MINOR] || sscanf(args[ARG_DEV_MINOR], "%hu", &minor) != 1) goto out;
		break;
	case 'b':
		perm |= S_IFBLK;
		if (!args[ARG_DEV_MAJOR] || sscanf(args[ARG_DEV_MAJOR], "%hu", &major) != 1
			|| !args[ARG_DEV_MINOR] || sscanf(args[ARG_DEV_MINOR], "%hu", &minor) != 1) goto out;
		break;
	case 'l':
		perm |= S_IFLNK;
		if (!args[ARG_SYMLINK_DATA]) goto out;
		break;
	case 'd':
		perm |= S_IFDIR;
		break;
	case 's':
		perm |= S_IFSOCK;
		break;
	case 'p':
		perm |= S_IFIFO;
		break;
	default:
		goto out;
	}
	error = -ENOMEM;
	struct syaoran_sb_info *info = (struct syaoran_sb_info *) sb->u.generic_sbp;
	if (!info->entry) {
		if ((info->entry = kmalloc(PAGE_SIZE, GFP_KERNEL)) == NULL) goto out;
		info->buffer_size = PAGE_SIZE;
		info->entry_count = 0;
	}
	if ((info->entry_count + 1) * sizeof(DEVLIST) > info->buffer_size) {
		if ((buffer = kmalloc(info->buffer_size * 2, GFP_KERNEL)) == NULL) goto out;
		info->buffer_size *= 2;
		memmove(buffer, info->entry, info->entry_count * sizeof(DEVLIST));
		info->entry = (DEVLIST *) buffer;
	}
	DEVLIST *entry = &info->entry[info->entry_count];
	memset(entry, 0, sizeof(*entry));
	entry->symlink_data = NULL;
	if (S_ISLNK(perm)) {
		if ((entry->symlink_data = strdup(args[ARG_SYMLINK_DATA])) == NULL) goto out;
	}
	if ((entry->name = strdup(args[ARG_FILENAME])) == NULL) {
		kfree(entry->symlink_data);
		goto out;
	}
	entry->mode = perm;
	entry->uid = uid;
	entry->gid = gid;
	entry->kdev = S_ISCHR(perm) || S_ISBLK(perm) ? MKDEV(major, minor) : 0;
	entry->may_create = may_create;
	entry->may_delete = may_delete;
	info->entry_count++;
	/*
	printk("Entry added.\n");
	*/
	error = 0;
 out: ;
	return error;
}

/* Free the entry[]. */
static void syaoran_put_super(struct super_block *sb) {
	if (!sb) return;
	struct syaoran_sb_info *info = (struct syaoran_sb_info *) sb->u.generic_sbp;
	if (!info) return;
	int i;
	for (i = 0; i < info->entry_count; i++) {
		DEVLIST *entry = &info->entry[i];
		kfree(entry->name); entry->name = NULL;
		kfree(entry->symlink_data); entry->symlink_data = NULL;
		/*
		printk("Entry removed.\n");
		*/
	}
	kfree(info->entry); info->entry = NULL;
	info->buffer_size = 0;
	info->entry_count = 0;
	kfree(info);
	sb->u.generic_sbp = NULL;
	printk("syaoran_put_super: Unused memory freed.\n");
}

/* Read a config file. */
static int ReadConfigFile(struct file *file, struct super_block *sb) {
	char *buffer;
	int error = -ENOMEM;
	if (!file) return -EINVAL;
	if ((buffer = kmalloc(PAGE_SIZE, GFP_KERNEL)) != NULL) {
		int avail_len = 0;
		int len;
		unsigned long offset = 0;
		memset(buffer, 0, PAGE_SIZE);
		while ((len = kernel_read(file, offset, buffer + avail_len, PAGE_SIZE - avail_len - 1)) > 0) {
			char *cp;
			avail_len += len;
			offset += len;
			while ((cp = memchr(buffer, '\n', avail_len)) != NULL) {
				*cp = '\0';
				NormalizeLine((unsigned char *) buffer);
				if (RegisterNodeInfo(buffer, sb) == -ENOMEM) goto out;
				cp++; len = cp - buffer;
				avail_len -= len;
				memmove(buffer, cp, avail_len);
			}
		}
		kfree(buffer);
		error = 0;
	}
 out: ;
	return 0;
}

/* Create a file at mount time. */
static void MakeNode(DEVLIST *entry, struct dentry *root) {
	struct dentry *base = dget(root);
	char *filename = entry->name;
	unsigned long hash;
	struct qstr this;
	unsigned int c;
	goto start;
	while ((c = * (unsigned char *) filename) != '\0') {
		if (c == '/') {
			this.len = filename - (char *) this.name;
			*filename = '\0'; filename++;
			this.hash = end_name_hash(hash);
			struct dentry *new_base;
			down(&base->d_inode->i_sem);
			new_base = lookup_hash(&this, base);
			up(&base->d_inode->i_sem);
			dput(base);
			if (IS_ERR(new_base)) {
				/* printk("'%s' not found. (1)\n", this.name); */
				return;
			} else if (!new_base->d_inode) {
				dput(new_base);
				/* printk("'%s' not found. (2)\n", this.name); */
				return;
			}
			/* printk("'%s' found.\n", this.name); */
			base = new_base;
		start: ;
			this.name = filename;
			hash = init_name_hash();
		} else {
			filename++;
			hash = partial_name_hash(c, hash);
		}
	}
	filename = (char *) this.name;
	mode_t perm = entry->mode;
	uid_t uid = entry->uid;
	gid_t gid = entry->gid;
	if (S_ISLNK(perm)) {
		fs_symlink(filename, base, entry->symlink_data);
	} else if (S_ISDIR(perm)) {
		fs_mkdir(filename, base, perm ^ S_IFDIR, uid, gid);
	} else if (S_ISSOCK(perm) || S_ISFIFO(perm)) {
		fs_mknod(filename, base, perm, 0, uid, gid);
	} else if (S_ISCHR(perm) || S_ISBLK(perm)) {
		fs_mknod(filename, base, perm, entry->kdev, uid, gid);
	}
	dput(base);
}

/* Create files at mount time according to entry[]. */
static void MakeInitialNodes(struct super_block *sb) {
	if (!sb) return;
	struct syaoran_sb_info *info = (struct syaoran_sb_info *) sb->u.generic_sbp;
	if (!info) return;
	int i;
	for (i = 0; i < info->entry_count; i++) {
		MakeNode(&info->entry[i], sb->s_root);
	}
	info->initialize_done = 1;
}

/* Open a config file and read. */
static int Syaoran_Initialize(struct super_block *sb, void *data) {
	int error = -EINVAL;
	if (data) {
		struct file *f = filp_open((char *) data, O_RDONLY, 0600);
		if (!IS_ERR(f)) {
			if (f->f_dentry->d_inode->i_size > 0) {
				if ((sb->u.generic_sbp = kmalloc(sizeof(struct syaoran_sb_info), GFP_KERNEL)) != NULL) {
					memset(sb->u.generic_sbp, 0, sizeof(struct syaoran_sb_info));
					printk("Reading '%s'\n", (char *) data);
					if (ReadConfigFile(f, sb) == 0) error = 0;
				}
			}
			filp_close(f, NULL);
		}
	}
	return error;
}

/* Based on __d_path(), but doesn't go over mount point. */
static char *GetAbsolutePath(struct dentry *dentry, char *buffer, int buflen) {
	char * end = buffer+buflen;
	char * retval;
	int namelen;
	
	*--end = '\0';
	buflen--;
	
	/* Get '/' right */
	retval = end-1;
	*retval = '/';
	
	for (;;) {
		if (IS_ROOT(dentry)) break;
		struct dentry *parent = dentry->d_parent;
		namelen = dentry->d_name.len;
		buflen -= namelen + 1;
		if (buflen < 0) return ERR_PTR(-ENAMETOOLONG);
		end -= namelen;
		memcpy(end, dentry->d_name.name, namelen);
		*--end = '/';
		retval = end;
		dentry = parent;
	}
	namelen = dentry->d_name.len;
	buflen -= namelen;
	if (buflen >= 0) {
		retval -= namelen-1;/* hit the slash */
		memcpy(retval, dentry->d_name.name, namelen);
	} else
		retval = ERR_PTR(-ENAMETOOLONG);
	return retval;
}

/* Based on sys_getcwd(). Get an absolute pathname. */
static int realpath_from_dentry(struct dentry *dentry, char *newname, int newname_len) {
	int error;
	char *page;
	char *cwd = NULL;
	struct dentry *d_dentry;
	if (!dentry || !newname || newname_len <= 0) return -EINVAL;
	if (!current->fs) {
		printk("realpath: current->fs == NULL for pid=%d\n", current->pid);
		return -ENOENT;
	}
	page = (char *) kmalloc(PAGE_SIZE, GFP_KERNEL);
	if (!page) return -ENOMEM;
	d_dentry = dget(dentry);
	error = -ENOENT;
	/* CRITICAL SECTION START */
	spin_lock(&dcache_lock);
	if (IS_ROOT(d_dentry) || !list_empty(&d_dentry->d_hash)) cwd = GetAbsolutePath(d_dentry, page, PAGE_SIZE);
	spin_unlock(&dcache_lock);
	/* CRITICAL SECTION END */
	if (cwd) {
		if (!IS_ERR(cwd)) {
			unsigned long len = PAGE_SIZE + page - cwd;
			if (len <= newname_len) {
				memmove(newname, cwd, len);
				error = 0;
			} else {
				error = -ERANGE;
			}
		} else {
			error = PTR_ERR(cwd);
		}
	}
	dput(d_dentry);
	kfree(page);
	return error;
}

/* Check whether a file with specified attributes are permitted to create. */
static int MayCreateNode(struct dentry *dentry, int mode, int dev) {
	switch (mode & S_IFMT) {
	case S_IFCHR: case S_IFBLK: case S_IFIFO: case S_IFSOCK: case S_IFDIR: case S_IFLNK:
		break;
	default:
		return -EPERM;
	}
	struct syaoran_sb_info *info = (struct syaoran_sb_info *) dentry->d_sb->u.generic_sbp;
	if (!info) {
		printk("MayCreateNode: dentry->d_sb->u.generic_sbp == NULL\n");
		return -EPERM;
	}
	if (!info->initialize_done) return 0;
	int error = -EPERM;
	char *filename = kmalloc(PAGE_SIZE, GFP_KERNEL);
	if (!filename) return -ENOMEM;
	memset(filename, 0, PAGE_SIZE);
	if (realpath_from_dentry(dentry, filename, PAGE_SIZE - 1) == 0) {
		int i;
		for (i = 0; i < info->entry_count; i++) {
			DEVLIST *entry = &info->entry[i];
			if ((mode & S_IFMT) != (entry->mode & S_IFMT)) continue;
			if ((S_ISBLK(mode) || S_ISCHR(mode)) && dev != entry->kdev) continue;
			if (strcmp(entry->name, filename + 1)) continue;
			if (entry->may_create) error = 0;
			break;
		}
	}
	kfree(filename);
	return error;
}

/* Check whether a file with specified attributes are permitted to delete. */
static int MayDeleteNode(struct dentry *dentry) {
	struct syaoran_sb_info *info = (struct syaoran_sb_info *) dentry->d_sb->u.generic_sbp;
	if (!info) {
		printk("MayDeleteNode: dentry->d_sb->u.generic_sbp == NULL\n");
		return -EPERM;
	}
	if (!dentry->d_inode) return -ENOENT;
	const mode_t mode = dentry->d_inode->i_mode;
	const kdev_t dev = dentry->d_inode->i_rdev;
	int error = -EPERM;
	char *filename = kmalloc(PAGE_SIZE, GFP_KERNEL);
	if (!filename) return -ENOMEM;
	memset(filename, 0, PAGE_SIZE);
	if (realpath_from_dentry(dentry, filename, PAGE_SIZE - 1) == 0) {
		int i;
		for (i = 0; i < info->entry_count; i++) {
			DEVLIST *entry = &info->entry[i];
			if ((mode & S_IFMT) != (entry->mode & S_IFMT)) continue;
			if ((S_ISBLK(mode) || S_ISCHR(mode)) && dev != entry->kdev) continue;
			if (strcmp(entry->name, filename + 1)) continue;
			if (entry->may_delete) error = 0;
			break;
		}
	}
	kfree(filename);
	return error;
}

/***** SYAORAN end. *****/
