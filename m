Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbULYKFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbULYKFA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 05:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULYKFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 05:05:00 -0500
Received: from 210-192-132-157.adsl.ttn.net ([210.192.132.157]:53407 "EHLO
	tpe.accusys.com.tw") by vger.kernel.org with ESMTP id S261484AbULYKEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 05:04:54 -0500
Message-Id: <200412251000.iBPA0LB07787@tpe.accusys.com.tw>
Reply-To: <josephl@tpe.accusys.com.tw>
From: "Hao-Ran Liu" <josephl@accusys.com.tw>
To: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
Subject: sys_fsync() and sys_sync() question
Date: Sat, 25 Dec 2004 18:04:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcTpkxWRkDAEat5RRa6MrZjv6EyP9gA1HD3A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I read kernel 2.6.9 page cache code and have some questions.
Please help ..

1. Why should sys_fsync() call filemap_fdatawrite()? Isn't it redundant in
kernel 2.6?
   since do_writepages() -> mpage_writepages() will walk the list of dirty
pages of the
   given address space and writepage() all of them, and, both
filemap_fdatawrite() and
   file->f_op->fsync() (ext2, for example) eventually call do_writepages()
function.

-----------------------------
asmlinkage long sys_fsync(unsigned int fd)
{
	struct file * file;
	struct address_space *mapping;
	int ret, err;

	ret = -EBADF;
	file = fget(fd);
	if (!file)
		goto out;

	mapping = file->f_mapping;

	ret = -EINVAL;
	if (!file->f_op || !file->f_op->fsync) {
		/* Why?  We can still call filemap_fdatawrite */
		goto out_putf;
	}

	/* We need to protect against concurrent writers.. */
	down(&mapping->host->i_sem);
	current->flags |= PF_SYNCWRITE;
	ret = filemap_fdatawrite(mapping);
	err = file->f_op->fsync(file, file->f_dentry, 0);
	if (!ret)
		ret = err;
	err = filemap_fdatawait(mapping);
	if (!ret)
		ret = err;
	current->flags &= ~PF_SYNCWRITE;
	up(&mapping->host->i_sem);

out_putf:
	fput(file);
out:
	return ret;
}
-----------------------------


2. for ext2, the purpose of sync_mapping_buffers() is to write out all
indirect blocks of 
   an address_space, which is called by ext2_sync_file()<-sys_fsync(). How
do these 
   buffers got sync'ed at sys_sync()? I don't find code writing out these
private buffers.
   If sync_mapping_buffers() is not needed for sys_sync(), then this should
apply for 
   ext2_sync_file().

-----------------------------
int ext2_sync_file(struct file *file, struct dentry *dentry, int datasync)
{
	struct inode *inode = dentry->d_inode;
	int err;
	int ret;

	ret = sync_mapping_buffers(inode->i_mapping);
	if (!(inode->i_state & I_DIRTY))
		return ret;
	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
		return ret;

	err = ext2_sync_inode(inode);
	if (ret == 0)
		ret = err;
	return ret;
}

static void do_sync(unsigned long wait)
{
	wakeup_bdflush(0);
	sync_inodes(0);		/* All mappings, inodes and their blockdevs
*/
	DQUOT_SYNC(NULL);
	sync_supers();		/* Write the superblocks */
	sync_filesystems(0);	/* Start syncing the filesystems */
	sync_filesystems(wait);	/* Waitingly sync the filesystems */
	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
	if (!wait)
		printk("Emergency Sync complete\n");
	if (unlikely(laptop_mode))
		laptop_sync_completion();
}

asmlinkage long sys_sync(void)
{
	do_sync(1);
	return 0;
}
-----------------------------



Thank you,
Hao-Ran Liu





