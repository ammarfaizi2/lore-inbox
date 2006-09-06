Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWIFRfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWIFRfr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWIFRfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:35:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:40109 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751782AbWIFRfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:35:46 -0400
Subject: [PATCH] ext3_getblk should handle HOLE correctly
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>,
       Will Simoneau <simoneau@ele.uri.edu>, cmm@us.ibm.com
Content-Type: text/plain
Date: Wed, 06 Sep 2006 10:39:06 -0700
Message-Id: <1157564346.23501.49.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Its been reported that ext3_getblk() is not doing the right thing
and triggering following WARN():

BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
 <c01c5140> ext3_getblk+0x98/0x2a6  <c03b2806> md_wakeup_thread
+0x26/0x2a
 <c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0x1ae
 <c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0x107
 <c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1e7
 <c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
 <c01c7986> ext3_setattr+0xc3/0x240  <c0120f66> current_fs_time
+0x52/0x6a
 <c017320e> notify_change+0x2bd/0x30d  <c0159246> chown_common+0x9c/0xc5
 <c02a222c> strncpy_from_user+0x3b/0x68  <c0167fe6> do_path_lookup
+0xdf/0x266
 <c016841b> __user_walk_fd+0x44/0x5a  <c01592b9> sys_chown+0x4a/0x55
 <c015a43c> vfs_write+0xe7/0x13c  <c01695d4> sys_mkdir+0x1f/0x23
 <c0102a97> syscall_call+0x7/0xb 

Looking at the code, it looks like its not handle HOLE correctly.
It ends up returning -EIO. Here is the patch to fix it.

If we really want to be paranoid, we can allow return values
0 (HOLE), 1 (we asked for one block) and return -EIO for
more than 1 block. But I really don't see a reason for
doing it - all we need is the block# here. (doesn't matter
how many blocks are mapped).

Thanks,
Badari

ext3_get_blocks_handle() returns number of blocks it mapped.
It returns 0 in case of HOLE. ext3_getblk() should handle
HOLE properly (currently its dumping warning stack and
returning -EIO).

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Acked-by: Mingming Cao <cmm@us.ibm.com>
---
 fs/ext3/inode.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.18-rc5/fs/ext3/inode.c
===================================================================
--- linux-2.6.18-rc5.orig/fs/ext3/inode.c	2006-08-27 20:41:48.000000000 -0700
+++ linux-2.6.18-rc5/fs/ext3/inode.c	2006-09-05 15:32:57.000000000 -0700
@@ -1009,11 +1009,12 @@ struct buffer_head *ext3_getblk(handle_t
 	buffer_trace_init(&dummy.b_history);
 	err = ext3_get_blocks_handle(handle, inode, block, 1,
 					&dummy, create, 1);
-	if (err == 1) {
+	/*
+	 * ext3_get_blocks_handle() returns number of blocks
+	 * mapped. 0 in case of a HOLE.
+	 */
+	if (err > 0) {
 		err = 0;
-	} else if (err >= 0) {
-		WARN_ON(1);
-		err = -EIO;
 	}
 	*errp = err;
 	if (!err && buffer_mapped(&dummy)) {


