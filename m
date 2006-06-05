Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751014AbWFEU0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWFEU0p (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWFEU0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:26:45 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:43484 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751014AbWFEU0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:26:44 -0400
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
From: Arjan van de Ven <arjan@linux.intel.com>
To: Jan Kara <jack@suse.cz>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060605200652.GC24342@atrey.karlin.mff.cuni.cz>
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu>
	 <1149528339.3111.114.camel@laptopd505.fenrus.org>
	 <200606051920.k55JKQGx003031@turing-police.cc.vt.edu>
	 <20060605193552.GB24342@atrey.karlin.mff.cuni.cz>
	 <1149537156.3111.123.camel@laptopd505.fenrus.org>
	 <20060605200652.GC24342@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 22:26:23 +0200
Message-Id: <1149539183.3111.126.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     - acquires dqio_sem, calls filesystem specific quota writing
>       function - e.g. ext3_quota_write()
>     - this function acquires i_mutex for quota file
> 
> I think this is the type of circle your checker has found.

ok since you know this doesn't deadlock the patch below (concept; akpm
please don't apply yet) ought to describe this special locking situation
to lockdep; I would really appreciate someone who does use quota to test
this out and see if it works....

---
 fs/dquot.c          |    2 +-
 fs/ext2/super.c     |    2 +-
 fs/ext3/super.c     |    2 +-
 fs/reiserfs/super.c |    2 +-
 fs/ufs/super.c      |    2 +-
 include/linux/fs.h  |    7 ++++++-
 6 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6.17-rc5-mm3/fs/dquot.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/dquot.c
+++ linux-2.6.17-rc5-mm3/fs/dquot.c
@@ -1475,7 +1475,7 @@ static int vfs_quota_on_inode(struct ino
 		goto out_file_init;
 	}
 	mutex_unlock(&dqopt->dqio_mutex);
-	mutex_unlock(&inode->i_mutex);
+	mutex_unlock_non_nested(&inode->i_mutex);
 	set_enable_flags(dqopt, type);
 
 	add_dquot_ref(sb, type);
Index: linux-2.6.17-rc5-mm3/fs/ext2/super.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/ext2/super.c
+++ linux-2.6.17-rc5-mm3/fs/ext2/super.c
@@ -1157,7 +1157,7 @@ static ssize_t ext2_quota_write(struct s
 	struct buffer_head tmp_bh;
 	struct buffer_head *bh;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_QUOTA);
 	while (towrite > 0) {
 		tocopy = sb->s_blocksize - offset < towrite ?
 				sb->s_blocksize - offset : towrite;
Index: linux-2.6.17-rc5-mm3/fs/ext3/super.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/ext3/super.c
+++ linux-2.6.17-rc5-mm3/fs/ext3/super.c
@@ -2614,7 +2614,7 @@ static ssize_t ext3_quota_write(struct s
 	struct buffer_head *bh;
 	handle_t *handle = journal_current_handle();
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_QUOTA);
 	while (towrite > 0) {
 		tocopy = sb->s_blocksize - offset < towrite ?
 				sb->s_blocksize - offset : towrite;
Index: linux-2.6.17-rc5-mm3/fs/reiserfs/super.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/reiserfs/super.c
+++ linux-2.6.17-rc5-mm3/fs/reiserfs/super.c
@@ -2204,7 +2204,7 @@ static ssize_t reiserfs_quota_write(stru
 	size_t towrite = len;
 	struct buffer_head tmp_bh, *bh;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_QUOTA);
 	while (towrite > 0) {
 		tocopy = sb->s_blocksize - offset < towrite ?
 		    sb->s_blocksize - offset : towrite;
Index: linux-2.6.17-rc5-mm3/fs/ufs/super.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/ufs/super.c
+++ linux-2.6.17-rc5-mm3/fs/ufs/super.c
@@ -1269,7 +1269,7 @@ static ssize_t ufs_quota_write(struct su
 	size_t towrite = len;
 	struct buffer_head *bh;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_QUOTA);
 	while (towrite > 0) {
 		tocopy = sb->s_blocksize - offset < towrite ?
 				sb->s_blocksize - offset : towrite;
Index: linux-2.6.17-rc5-mm3/include/linux/fs.h
===================================================================
--- linux-2.6.17-rc5-mm3.orig/include/linux/fs.h
+++ linux-2.6.17-rc5-mm3/include/linux/fs.h
@@ -563,12 +563,17 @@ struct inode {
  * 0: the object of the current VFS operation
  * 1: parent
  * 2: child/target
+ * 3: quota file
+ *
+ * The locking order between these types is
+ * parent -> child -> normal -> quota
  */
 enum inode_i_mutex_lock_type
 {
 	I_MUTEX_NORMAL,
 	I_MUTEX_PARENT,
-	I_MUTEX_CHILD
+	I_MUTEX_CHILD,
+	I_MUTEX_QUOTA
 };
 
 /*

