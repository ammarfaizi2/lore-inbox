Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWJJIcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWJJIcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWJJIcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:32:15 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:44013 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965103AbWJJIcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:32:14 -0400
Date: Tue, 10 Oct 2006 11:32:13 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: sct@redhat.com, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: [PATCH] ext3: fsid for statvfs
Message-ID: <Pine.LNX.4.64.0610101131001.10574@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Update ext3_statfs to return an FSID that is a 64 bit XOR of the 128 bit
filesystem UUID as suggested by Andreas Dilger. See the following Bugzilla
entry for details:

  http://bugzilla.kernel.org/show_bug.cgi?id=136

Cc: Andreas Dilger <adilger@clusterfs.com>
Cc: Stephen Tweedie <sct@redhat.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/ext3/super.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: 2.6/fs/ext3/super.c
===================================================================
--- 2.6.orig/fs/ext3/super.c
+++ 2.6/fs/ext3/super.c
@@ -2385,6 +2385,7 @@ static int ext3_statfs (struct dentry * 
 	struct ext3_super_block *es = sbi->s_es;
 	ext3_fsblk_t overhead;
 	int i;
+	u64 fsid;
 
 	if (test_opt (sb, MINIX_DF))
 		overhead = 0;
@@ -2431,6 +2432,10 @@ static int ext3_statfs (struct dentry * 
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = percpu_counter_sum(&sbi->s_freeinodes_counter);
 	buf->f_namelen = EXT3_NAME_LEN;
+	fsid = le64_to_cpup((void *)es->s_uuid) ^
+	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
+	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
+	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
 	return 0;
 }
 
