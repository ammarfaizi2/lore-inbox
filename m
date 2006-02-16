Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWBPSpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWBPSpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWBPSpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:45:24 -0500
Received: from igw1.br.ibm.com ([32.104.18.24]:6058 "EHLO mailgw1.br.ibm.com")
	by vger.kernel.org with ESMTP id S1030419AbWBPSpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:45:22 -0500
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       adobriyan@gmail.com
Subject: [PATCH][RESEND] ext3: Properly report backup block present in a group
Date: Thu, 16 Feb 2006 16:44:53 -0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602161644.53746.glommer@br.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of a patch I sent on Jan 20th. Andrew, could you 
please consider applying it ?
 
In filesystems with the meta block group flag on, ext3_bg_num_gdb()
fails to report the correct number of blocks used to store the group
descriptor backups in a given group. It happens because meta_bg
follows a different logic from the original ext3 backup placement
in groups multiples of 3, 5 and 7.

Signed-off-by: Glauber de Oliveira Costa <glommer@br.ibm.com>

---

 fs/ext3/balloc.c |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

1164cfd9b1b413f6c4b86bac11006ba2b933ccb1
diff --git a/fs/ext3/balloc.c b/fs/ext3/balloc.c
index 6250fcd..8bf87b0 100644
--- a/fs/ext3/balloc.c
+++ b/fs/ext3/balloc.c
@@ -1499,6 +1499,25 @@ int ext3_bg_has_super(struct super_block
        return 1;
 }
 
+static unsigned long ext3_bg_num_gdb_meta(struct super_block *sb, int group)
+{
+       unsigned long metagroup = group / EXT3_DESC_PER_BLOCK(sb);
+       unsigned long first = metagroup * EXT3_DESC_PER_BLOCK(sb);
+       unsigned long last = first + EXT3_DESC_PER_BLOCK(sb) - 1;
+
+       if (group == first || group == first + 1 || group == last)
+               return 1;
+       return 0;
+}
+
+static unsigned long ext3_bg_num_gdb_nometa(struct super_block *sb, int 
group)
+{
+       if 
(EXT3_HAS_RO_COMPAT_FEATURE(sb,EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER)&&
+           !ext3_group_sparse(group))
+               return 0;
+       return EXT3_SB(sb)->s_gdb_count;
+}
+
 /**
  *     ext3_bg_num_gdb - number of blocks used by the group table in group
  *     @sb: superblock for filesystem
@@ -1510,9 +1529,15 @@ int ext3_bg_has_super(struct super_block
  */
 unsigned long ext3_bg_num_gdb(struct super_block *sb, int group)
 {
-       if 
(EXT3_HAS_RO_COMPAT_FEATURE(sb,EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER)&&
-           !ext3_group_sparse(group))
-               return 0;
-       return EXT3_SB(sb)->s_gdb_count;
+       unsigned long first_meta_bg = 
+               le32_to_cpu(EXT3_SB(sb)->s_es->s_first_meta_bg);
+       unsigned long metagroup = group / EXT3_DESC_PER_BLOCK(sb);
+
+       if (!EXT3_HAS_INCOMPAT_FEATURE(sb,EXT3_FEATURE_INCOMPAT_META_BG)
+                       || metagroup < first_meta_bg)
+               return ext3_bg_num_gdb_nometa(sb,group);
+       
+       return ext3_bg_num_gdb_meta(sb,group);
+
 }
 
-- 
1.0.4
