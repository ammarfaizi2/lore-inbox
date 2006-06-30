Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWF3AT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWF3AT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWF3ATp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:19:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:5056 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964779AbWF3ATD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:19:03 -0400
Subject: [RFC][Update][Patch 13/16] 48 bit on-disk i_file_acl support
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:18:57 -0700
Message-Id: <1151626742.6601.83.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we are planning to support 48-bit block numbers for ext3,
we need to support 48-bit block numbers for extended attributes.
In the short term, we can do this by reuse (on-disk) 16-bit
padding (linux2.i_pad1 currently used only by "hurd") as high 
order bits for xattr. This patch basically does that.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>


---

 linux-2.6.17-ming/fs/ext3/inode.c         |    8 ++++++++
 linux-2.6.17-ming/include/linux/ext3_fs.h |    6 ++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff -puN fs/ext3/inode.c~ext3_48bit_i_file_acl fs/ext3/inode.c
--- linux-2.6.17/fs/ext3/inode.c~ext3_48bit_i_file_acl	2006-06-28 16:47:11.921203527 -0700
+++ linux-2.6.17-ming/fs/ext3/inode.c	2006-06-28 16:47:11.932202265 -0700
@@ -2641,6 +2641,10 @@ void ext3_read_inode(struct inode * inod
 	ei->i_frag_size = raw_inode->i_fsize;
 #endif
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
+	if ((sizeof(sector_t) > 4) &&
+	    (EXT3_SB(inode->i_sb)->s_es->s_creator_os != EXT3_OS_HURD))
+		ei->i_file_acl |=
+			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
 	if (!S_ISREG(inode->i_mode)) {
 		ei->i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
 	} else {
@@ -2774,6 +2778,10 @@ static int ext3_do_update_inode(handle_t
 	raw_inode->i_frag = ei->i_frag_no;
 	raw_inode->i_fsize = ei->i_frag_size;
 #endif
+	if ((sizeof(sector_t) > 4) &&
+	    (EXT3_SB(inode->i_sb)->s_es->s_creator_os != EXT3_OS_HURD))
+		raw_inode->i_file_acl_high =
+			cpu_to_le16((__u64)ei->i_file_acl >> 32);
 	raw_inode->i_file_acl = cpu_to_le32(ei->i_file_acl);
 	if (!S_ISREG(inode->i_mode)) {
 		raw_inode->i_dir_acl = cpu_to_le32(ei->i_dir_acl);
diff -puN include/linux/ext3_fs.h~ext3_48bit_i_file_acl include/linux/ext3_fs.h
--- linux-2.6.17/include/linux/ext3_fs.h~ext3_48bit_i_file_acl	2006-06-28 16:47:11.925203068 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs.h	2006-06-28 16:47:11.934202036 -0700
@@ -285,7 +285,7 @@ struct ext3_inode {
 		struct {
 			__u8	l_i_frag;	/* Fragment number */
 			__u8	l_i_fsize;	/* Fragment size */
-			__u16	i_pad1;
+			__u16	l_i_file_acl_high;
 			__le16	l_i_uid_high;	/* these 2 fields    */
 			__le16	l_i_gid_high;	/* were reserved2[0] */
 			__u32	l_i_reserved2;
@@ -301,7 +301,7 @@ struct ext3_inode {
 		struct {
 			__u8	m_i_frag;	/* Fragment number */
 			__u8	m_i_fsize;	/* Fragment size */
-			__u16	m_pad1;
+			__u16	m_i_file_acl_high;
 			__u32	m_i_reserved2[2];
 		} masix2;
 	} osd2;				/* OS dependent 2 */
@@ -315,6 +315,7 @@ struct ext3_inode {
 #define i_reserved1	osd1.linux1.l_i_reserved1
 #define i_frag		osd2.linux2.l_i_frag
 #define i_fsize		osd2.linux2.l_i_fsize
+#define i_file_acl_high	osd2.linux2.l_i_file_acl_high
 #define i_uid_low	i_uid
 #define i_gid_low	i_gid
 #define i_uid_high	osd2.linux2.l_i_uid_high
@@ -335,6 +336,7 @@ struct ext3_inode {
 #define i_reserved1	osd1.masix1.m_i_reserved1
 #define i_frag		osd2.masix2.m_i_frag
 #define i_fsize		osd2.masix2.m_i_fsize
+#define i_file_acl_high	osd2.masix2.m_i_file_acl_high
 #define i_reserved2	osd2.masix2.m_i_reserved2
 
 #endif /* defined(__KERNEL__) || defined(__linux__) */

_


