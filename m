Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVI2Rtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVI2Rtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVI2Rtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:49:31 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:40420 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S932279AbVI2Rtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:49:31 -0400
Message-ID: <433C2922.1000008@sm.sony.co.jp>
Date: Fri, 30 Sep 2005 02:49:22 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
CC: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Subject: [PATCH 2/2] replace ext2_sync_inode() with sync_inode_wodata(  (Re:
 [PATCH 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime))
References: <43288A84.2090107@sm.sony.co.jp> <87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>
In-Reply-To: <433C25D9.9090602@sm.sony.co.jp>
Content-Type: multipart/mixed;
 boundary="------------060506000600030100080008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060506000600030100080008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch replaces ext2_sync_inode() with sync_inode_wodata(), which is
introduced by fs-sync-attr.patch attached at
"[PATCH 1/2] miss-sync changes on attributes"

Machida, Hiroyuki wrote:
> 
> I revise a previous patch. Now checking dirty flag is done
> at vfs layer, as OGAWA-san said. I realized ext2_sync_inode()
> is good for syncing inode without it's data. I moved it to vfs layer
> and rename it to sync_inode_wodata().
> 
> The first patch attached here is changes on vfs layer.
> Second patch attached at the next mail is changes on ext2 fs.
> 
> 
> OGAWA Hirofumi wrote:
> 
>> "Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:
>>
>>
>>> +    if ( (!error) && IS_SYNC(inode)) {
>>> +        error = write_inode_now(inode, 1);
>>> +    }
>>
>>
>>
>> We don't need to sync the data pages at all here. And I think it is
>> not right place for doing this.  If we need this, since we need to see
>> O_SYNC for fchxxx() VFS would be right place to do it.
>>
>> But, personally, I'd like to kill the "-o sync" stuff for these
>> independent meta data rather. Then...
> 
> 
> 
> ------------------------------------------------------------------------

-- 
Hiroyuki Machida		machida@sm.sony.co.jp		


--------------060506000600030100080008
Content-Type: text/plain;
 name="ext2-inode-sync.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext2-inode-sync.patch"


This patch replaces ext2_sync_inode() with sync_inode_wodata().

* ext2-inode-sync.patch for 2.6.13

 ext2.h  |    1 -
 fsync.c |    2 +-
 inode.c |   11 +----------
 xattr.c |    2 +-

Signed-off-by: Hiroyuki Machida <machdia@sm.sony.co.jp>

 4 files changed, 3 insertions(+), 13 deletions(-)
--- linux-2.6.13/fs/ext2/ext2.h	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-sync-attr/fs/ext2/ext2.h	2005-09-29 12:56:15.942213423 +0900
@@ -127,7 +127,6 @@ extern void ext2_read_inode (struct inod
 extern int ext2_write_inode (struct inode *, int);
 extern void ext2_put_inode (struct inode *);
 extern void ext2_delete_inode (struct inode *);
-extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern void ext2_truncate (struct inode *);
diff -upr linux-2.6.13/fs/ext2/fsync.c linux-2.6.13-sync-attr/fs/ext2/fsync.c
--- linux-2.6.13/fs/ext2/fsync.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-sync-attr/fs/ext2/fsync.c	2005-09-30 01:31:54.492518751 +0900
@@ -44,7 +44,7 @@ int ext2_sync_file(struct file *file, st
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
 		return ret;
 
-	err = ext2_sync_inode(inode);
+	err = sync_inode_wodata(inode);
 	if (ret == 0)
 		ret = err;
 	return ret;
diff -upr linux-2.6.13/fs/ext2/inode.c linux-2.6.13-sync-attr/fs/ext2/inode.c
--- linux-2.6.13/fs/ext2/inode.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-sync-attr/fs/ext2/inode.c	2005-09-30 01:30:32.750569279 +0900
@@ -993,7 +993,7 @@ do_indirects:
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	if (inode_needs_sync(inode)) {
 		sync_mapping_buffers(inode->i_mapping);
-		ext2_sync_inode (inode);
+		sync_inode_wodata(inode);
 	} else {
 		mark_inode_dirty(inode);
 	}
@@ -1282,15 +1282,6 @@ int ext2_write_inode(struct inode *inode
 	return ext2_update_inode(inode, wait);
 }
 
-int ext2_sync_inode(struct inode *inode)
-{
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
-		.nr_to_write = 0,	/* sys_fsync did this */
-	};
-	return sync_inode(inode, &wbc);
-}
-
 int ext2_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = dentry->d_inode;
diff -upr linux-2.6.13/fs/ext2/xattr.c linux-2.6.13-sync-attr/fs/ext2/xattr.c
--- linux-2.6.13/fs/ext2/xattr.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-sync-attr/fs/ext2/xattr.c	2005-09-30 01:30:43.070815408 +0900
@@ -705,7 +705,7 @@ ext2_xattr_set2(struct inode *inode, str
 	EXT2_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
 	inode->i_ctime = CURRENT_TIME_SEC;
 	if (IS_SYNC(inode)) {
-		error = ext2_sync_inode (inode);
+		error = sync_inode_wodata(inode);
 		/* In case sync failed due to ENOSPC the inode was actually
 		 * written (only some dirty data were not) so we just proceed
 		 * as if nothing happened and cleanup the unused block */

--------------060506000600030100080008--
