Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbULZKt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbULZKt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 05:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbULZKt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 05:49:59 -0500
Received: from 210-192-132-157.adsl.ttn.net ([210.192.132.157]:1190 "EHLO
	tpe.accusys.com.tw") by vger.kernel.org with ESMTP id S261272AbULZKty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 05:49:54 -0500
From: "josephl" <josephl@tpe.accusys.com.tw>
To: linux-kernel@vger.kernel.org
Subject: Question about sys_fsync() of memory-mapped pages and private buffers
Date: Sun, 26 Dec 2004 18:47:00 +0800
Message-Id: <20041226184700.M56915@tpe.accusys.com.tw>
X-Mailer: Open WebMail 1.63 20020411
X-OriginatingIP: 220.135.20.137 (josephl)
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I'm sorry I posted this question for several times.

I have some questions about syncing of memory-mapped pages and private 
buffers of files. I cannot not find answer elsewhere on the web and hope 
some real kernel developers could help me.

1. Why should sys_fsync() call filemap_fdatawrite()? Isn't it redundant in
   kernel 2.6? since do_writepages() -> mpage_writepages() will walk the 
   list of dirty pages of the given address space and writepage() all of 
   them, and, both filemap_fdatawrite() andfile->f_op->fsync() (ext2, for 
   example) eventually call do_writepages() function.

   (In Linux 2.4, filemap_fdatasync() is necessary because ext2_sync_file()
    doesn't take care of dirty memory-mapped pages. It only deals with
    dirty buffers listed in the inode)

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
   indirect blocks of an address_space, which is called by 
   ext2_sync_file()<-sys_fsync(). How do these buffers got sync'ed at 
   sys_sync()? I don't find code writing out these private buffers.

   Is it because that these buffers' pages are tagged dirty in radix_tree 
   and are written out via sync_inodes(). If so,this should apply for
   ext2_sync_file(), ie. sync_mapping_buffers() is not necessary.

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
 sync_inodes(0);  /* All mappings, inodes and their blockdevs
*/
 DQUOT_SYNC(NULL);
 sync_supers();  /* Write the superblocks */
 sync_filesystems(0); /* Start syncing the filesystems */
 sync_filesystems(wait); /* Waitingly sync the filesystems */
 sync_inodes(wait); /* Mappings, inodes and blockdevs, again. */
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

