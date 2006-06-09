Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWFIBVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWFIBVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWFIBVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:21:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:33959 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965078AbWFIBVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:21:32 -0400
Subject: [RFC 2/13] extents and 48bit ext3: sector_t overflow check
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 08 Jun 2006 18:21:30 -0700
Message-Id: <1149816090.4066.62.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If ext3 fs system is larger than 2TB, and sector_t is a u32 (i.e.
CONFIG_LBD not defined in the kernel), the calculation of the disk
sector will overflow. Add check at ext3_fill_super() and
ext3_group_extend() to prevent mount/remount/resize >2TB ext3 filesystem
if sector_t size is 4 bytes.

Signed-Off-By: Mingming Cao<cmm@us.ibm.com>
Acked-by: Andreas Dilger <adilger@clusterfs.com>


---

 linux-2.6.16-ming/fs/ext3/resize.c |   10 ++++++++++
 linux-2.6.16-ming/fs/ext3/super.c  |   10 ++++++++++
 2 files changed, 20 insertions(+)

diff -puN fs/ext3/resize.c~ext3_check_sector_t_overflow fs/ext3/resize.c
--- linux-2.6.16/fs/ext3/resize.c~ext3_check_sector_t_overflow	2006-06-07 15:42:26.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/resize.c	2006-06-08 16:50:07.390825336 -0700
@@ -925,6 +925,16 @@ int ext3_group_extend(struct super_block
 	if (n_blocks_count == 0 || n_blocks_count == o_blocks_count)
 		return 0;
 
+	if (n_blocks_count > (sector_t)(~0ULL) >> (sb->s_blocksize_bits - 9)) {
+		printk(KERN_ERR "EXT3-fs: filesystem on %s"
+			" too large to resize to %lu blocks safely\n",
+			sb->s_id, n_blocks_count);
+		if (sizeof(sector_t) < 8)
+			ext3_warning(sb, __FUNCTION__,
+			"CONFIG_LBD not enabled\n");
+		return -EINVAL;
+	}
+
 	if (n_blocks_count < o_blocks_count) {
 		ext3_warning(sb, __FUNCTION__,
 			     "can't shrink FS - resize aborted");
diff -puN fs/ext3/super.c~ext3_check_sector_t_overflow fs/ext3/super.c
--- linux-2.6.16/fs/ext3/super.c~ext3_check_sector_t_overflow	2006-06-07 15:42:26.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/super.c	2006-06-08 16:50:07.394824881 -0700
@@ -1579,6 +1579,16 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
+	if (le32_to_cpu(es->s_blocks_count) >
+			(sector_t)(~0ULL) >> (sb->s_blocksize_bits - 9)) {
+		printk(KERN_ERR "EXT3-fs: filesystem on %s"
+			" too large to mount safely\n", sb->s_id);
+			if (sizeof(sector_t) < 8)
+			printk(KERN_WARNING
+				"EXT3-fs: CONFIG_LBD not enabled\n");
+			goto failed_mount;
+	}
+
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 
 	for (i = 0; i < db_count; i++) {

_


