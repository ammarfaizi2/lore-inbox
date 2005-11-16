Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVKPH5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVKPH5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVKPH5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:57:51 -0500
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:40113 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030209AbVKPH5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:57:50 -0500
Message-ID: <437AE67B.6040405@namesys.com>
Date: Tue, 15 Nov 2005 23:57:47 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, vs <vs@thebsh.namesys.com>
Subject: [Fwd: [PATCH 1/8] reiser4-add-crc-sendfile.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070704090404050200070204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070704090404050200070204
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------070704090404050200070204
Content-Type: message/rfc822;
 name="[PATCH 1/8] reiser4-add-crc-sendfile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 1/8] reiser4-add-crc-sendfile.patch"

Return-Path: <vs@tribesman.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24391 invoked from network); 15 Nov 2005 17:00:09 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO tribesman.namesys.com) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:00:09 -0000
Received: by tribesman.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 512)
	id 24DA971D992; Tue, 15 Nov 2005 19:59:46 +0300 (MSK)
Date: Tue, 15 Nov 2005 19:59:46 +0300
To: reiser@namesys.com
Subject: [PATCH 1/8] reiser4-add-crc-sendfile.patch
Message-ID: <437A1402.mail7J81Q5E1P@tribesman.namesys.com>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1HOPP1H49V-=-1PCY51JIWA-CUT-HERE-P0PKI199JD-=-1KKUTP511E"
From: vs@tribesman.namesys.com (Vladimir Saveliev)

This is a multi-part message in MIME format.

--1HOPP1H49V-=-1PCY51JIWA-CUT-HERE-P0PKI199JD-=-1KKUTP511E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

.

--1HOPP1H49V-=-1PCY51JIWA-CUT-HERE-P0PKI199JD-=-1KKUTP511E
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reiser4-add-crc-sendfile.patch"


From: Edward Shishkin <edward@namesys.com>

This patch adds sendfile method for cryptcompress files.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/plugin/file/cryptcompress.c |   35 +++++++++++++++++++++++++++++++--
 fs/reiser4/plugin/file/file.h          |    2 +
 fs/reiser4/plugin/object.c             |    3 +-
 3 files changed, 37 insertions(+), 3 deletions(-)

diff -puN fs/reiser4/plugin/file/cryptcompress.c~reiser4-add-crc-sendfile fs/reiser4/plugin/file/cryptcompress.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/cryptcompress.c~reiser4-add-crc-sendfile	2005-11-15 16:58:35.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/cryptcompress.c	2005-11-15 17:08:26.000000000 +0300
@@ -3670,8 +3670,8 @@ int capturepage_cryptcompress(struct pag
 /* plugin->u.file.mmap */
 int mmap_cryptcompress(struct file *file, struct vm_area_struct *vma)
 {
-	return -ENOSYS;
-	//return generic_file_mmap(file, vma);
+	//return -ENOSYS;
+	return generic_file_mmap(file, vma);
 }
 
 /* plugin->u.file.release */
@@ -3834,6 +3834,37 @@ int setattr_cryptcompress(struct dentry 
 	return result;
 }
 
+/* sendfile_cryptcompress - sendfile of struct file_operations */
+ssize_t
+sendfile_cryptcompress(struct file *file, loff_t *ppos, size_t count,
+		       read_actor_t actor, void *target)
+{
+	reiser4_context *ctx;
+	ssize_t result;
+	struct inode *inode;
+	cryptcompress_info_t *info;
+
+	inode = file->f_dentry->d_inode;
+	ctx = init_context(inode->i_sb);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+	/*
+	 * generic_file_sndfile may want to call update_atime. Grab space for
+	 * stat data update
+	 */
+	result = reiser4_grab_space(estimate_update_common(inode),
+				    BA_CAN_COMMIT);
+	if (result)
+		goto exit;
+	info = cryptcompress_inode_data(inode);
+	down_read(&info->lock);
+	result = generic_file_sendfile(file, ppos, count, actor, target);
+	up_read(&info->lock);
+ exit:
+	reiser4_exit_context(ctx);
+	return result;
+}
+
 static int
 save_len_cryptcompress_plugin(struct inode *inode, reiser4_plugin * plugin)
 {
diff -puN fs/reiser4/plugin/file/file.h~reiser4-add-crc-sendfile fs/reiser4/plugin/file/file.h
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/file.h~reiser4-add-crc-sendfile	2005-11-15 16:58:35.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/file.h	2005-11-15 16:58:35.000000000 +0300
@@ -169,6 +169,8 @@ ssize_t read_cryptcompress(struct file *
 ssize_t write_cryptcompress(struct file *, const char __user *buf, size_t write_amount,
 			    loff_t * off);
 int mmap_cryptcompress(struct file *, struct vm_area_struct *);
+ssize_t sendfile_cryptcompress(struct file *file, loff_t *ppos, size_t count,
+			       read_actor_t actor, void *target);
 
 /* address space operations */
 extern int readpage_cryptcompress(struct file *, struct page *);
diff -puN fs/reiser4/plugin/object.c~reiser4-add-crc-sendfile fs/reiser4/plugin/object.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/object.c~reiser4-add-crc-sendfile	2005-11-15 16:58:35.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/object.c	2005-11-15 16:58:35.000000000 +0300
@@ -306,7 +306,7 @@ file_plugin file_plugins[LAST_FILE_PLUGI
 			.write = write_cryptcompress,
 			.mmap = mmap_cryptcompress,
 			.fsync = sync_common,
-			.sendfile = sendfile_common
+			.sendfile = sendfile_cryptcompress
 		},
 		.as_ops = {
 			.writepage = reiser4_writepage,
@@ -331,6 +331,7 @@ file_plugin file_plugins[LAST_FILE_PLUGI
 		.owns_item = owns_item_common,
 		.can_add_link = can_add_link_common,
 		.detach = dummyop,
+		.bind = dummyop,
 		.safelink = safelink_common,
 		.estimate = {
 			.create = estimate_create_common,

_

--1HOPP1H49V-=-1PCY51JIWA-CUT-HERE-P0PKI199JD-=-1KKUTP511E--



--------------070704090404050200070204--
