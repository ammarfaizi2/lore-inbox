Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVI2Rfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVI2Rfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVI2Rfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:35:30 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:48091 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S932262AbVI2Rfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:35:30 -0400
Message-ID: <433C25D9.9090602@sm.sony.co.jp>
Date: Fri, 30 Sep 2005 02:35:21 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH 2/2][FAT]
 miss-sync issues on sync mount (miss-sync on utime))
References: <43288A84.2090107@sm.sony.co.jp> <87oe6uwjy7.fsf@devron.myhome.or.jp>
In-Reply-To: <87oe6uwjy7.fsf@devron.myhome.or.jp>
Content-Type: multipart/mixed;
 boundary="------------090202080209030501050909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090202080209030501050909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I revise a previous patch. Now checking dirty flag is done
at vfs layer, as OGAWA-san said. I realized ext2_sync_inode()
is good for syncing inode without it's data. I moved it to vfs layer
and rename it to sync_inode_wodata().

The first patch attached here is changes on vfs layer.
Second patch attached at the next mail is changes on ext2 fs.


OGAWA Hirofumi wrote:
> "Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:
> 
> 
>>+	if ( (!error) && IS_SYNC(inode)) {
>>+		error = write_inode_now(inode, 1);
>>+	}
> 
> 
> We don't need to sync the data pages at all here. And I think it is
> not right place for doing this.  If we need this, since we need to see
> O_SYNC for fchxxx() VFS would be right place to do it.
> 
> But, personally, I'd like to kill the "-o sync" stuff for these
> independent meta data rather. Then...

-- 
Hiroyuki Machida		machida@sm.sony.co.jp		


--------------090202080209030501050909
Content-Type: text/plain;
 name="fs-sync-attr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs-sync-attr.patch"


This patch adds inode-sync after attribute changes, if needed.

* fs-sync-attr.patch for 2.6.13

 fs/fs-writeback.c      |   19 +++++++++++++++++++
 fs/open.c              |   12 ++++++++++++
 include/linux/fs.h     |    1 +
 4 files changed, 32 insertions(+)

Signed-off-by: Hiroyuki Machida <machdia@sm.sony.co.jp>

--- linux-2.6.13/fs/fs-writeback.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-sync-attr/fs/fs-writeback.c	2005-09-29 12:56:21.052335295 +0900
@@ -593,6 +593,25 @@ int sync_inode(struct inode *inode, stru
 EXPORT_SYMBOL(sync_inode);
 
 /**
+ * sync_inode_wodata - sync(write and wait) inode to disk, without it's data.
+ * @inode: the inode to sync
+ *
+ * sync_inode_wodata() will write an inode  then wait.  It will also
+ * correctly update the inode on its superblock's dirty inode lists 
+ * and will update inode->i_state.
+ *
+ * The caller must have a ref on the inode.
+ */
+int sync_inode_wodata(struct inode *inode)
+{
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL, /* wait */
+		.nr_to_write = 0,/* no data to be written */
+	};
+	return sync_inode(inode, &wbc);
+}
+
+/**
  * generic_osync_inode - flush all dirty data for a given inode to disk
  * @inode: inode to write
  * @mapping: the address_space that should be flushed
diff -upr linux-2.6.13/fs/open.c linux-2.6.13-sync-attr/fs/open.c
--- linux-2.6.13/fs/open.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-sync-attr/fs/open.c	2005-09-30 01:29:45.279437136 +0900
@@ -207,6 +207,8 @@ int do_truncate(struct dentry *dentry, l
 
 	down(&dentry->d_inode->i_sem);
 	err = notify_change(dentry, &newattrs);
+	if (!err && IS_SYNC(dentry->d_inode))
+		sync_inode_wodata(dentry->d_inode);
 	up(&dentry->d_inode->i_sem);
 	return err;
 }
@@ -394,6 +396,8 @@ asmlinkage long sys_utime(char __user * 
 	}
 	down(&inode->i_sem);
 	error = notify_change(nd.dentry, &newattrs);
+	if (!error && IS_SYNC(inode))
+		sync_inode_wodata(inode);
 	up(&inode->i_sem);
 dput_and_out:
 	path_release(&nd);
@@ -447,6 +451,8 @@ long do_utimes(char __user * filename, s
 	}
 	down(&inode->i_sem);
 	error = notify_change(nd.dentry, &newattrs);
+	if (!error && IS_SYNC(inode))
+		sync_inode_wodata(inode);
 	up(&inode->i_sem);
 dput_and_out:
 	path_release(&nd);
@@ -620,6 +626,8 @@ asmlinkage long sys_fchmod(unsigned int 
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
 	err = notify_change(dentry, &newattrs);
+	if (!err && IS_SYNC(inode))
+		sync_inode_wodata(inode);
 	up(&inode->i_sem);
 
 out_putf:
@@ -654,6 +662,8 @@ asmlinkage long sys_chmod(const char __u
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
 	error = notify_change(nd.dentry, &newattrs);
+	if (!error && IS_SYNC(inode))
+		sync_inode_wodata(inode);
 	up(&inode->i_sem);
 
 dput_and_out:
@@ -692,6 +702,8 @@ static int chown_common(struct dentry * 
 		newattrs.ia_valid |= ATTR_KILL_SUID|ATTR_KILL_SGID;
 	down(&inode->i_sem);
 	error = notify_change(dentry, &newattrs);
+	if (!error && IS_SYNC(inode))
+		sync_inode_wodata(inode);
 	up(&inode->i_sem);
 out:
 	return error;
diff -upr linux-2.6.13/include/linux/fs.h linux-2.6.13-sync-attr/include/linux/fs.h
--- linux-2.6.13/include/linux/fs.h	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-sync-attr/include/linux/fs.h	2005-09-30 01:29:06.278507000 +0900
@@ -1082,6 +1082,7 @@ static inline void file_accessed(struct 
 }
 
 int sync_inode(struct inode *inode, struct writeback_control *wbc);
+int sync_inode_wodata(struct inode *inode);
 
 /**
  * struct export_operations - for nfsd to communicate with file systems

--------------090202080209030501050909--
