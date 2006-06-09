Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWFIBYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWFIBYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWFIBYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:24:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:36274 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965103AbWFIBYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:24:01 -0400
Subject: [RFC 12/13] extents and 48bit ext3: 48 bit on-disk i_file_acl
	support
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 08 Jun 2006 18:23:58 -0700
Message-Id: <1149816239.4066.75.camel@dyn9047017069.beaverton.ibm.com>
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

 linux-2.6.16-ming/fs/ext3/inode.c         |    8 ++++++++
 linux-2.6.16-ming/include/linux/ext3_fs.h |    6 ++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff -puN fs/ext3/inode.c~ext3_48bit_i_file_acl fs/ext3/inode.c
--- linux-2.6.16/fs/ext3/inode.c~ext3_48bit_i_file_acl	2006-06-08 16:30:09.669400945 -0700
+++ linux-2.6.16-ming/fs/ext3/inode.c	2006-06-08 16:49:31.720882123 -0700
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
--- linux-2.6.16/include/linux/ext3_fs.h~ext3_48bit_i_file_acl	2006-06-08 16:30:09.673400489 -0700
+++ linux-2.6.16-ming/include/linux/ext3_fs.h	2006-06-08 16:49:31.730880987 -0700
@@ -289,7 +289,7 @@ struct ext3_inode {
 		struct {
 			__u8	l_i_frag;	/* Fragment number */
 			__u8	l_i_fsize;	/* Fragment size */
-			__u16	i_pad1;
+			__u16	l_i_file_acl_high;
 			__le16	l_i_uid_high;	/* these 2 fields    */
 			__le16	l_i_gid_high;	/* were reserved2[0] */
 			__u32	l_i_reserved2;
@@ -305,7 +305,7 @@ struct ext3_inode {
 		struct {
 			__u8	m_i_frag;	/* Fragment number */
 			__u8	m_i_fsize;	/* Fragment size */
-			__u16	m_pad1;
+			__u16	m_i_file_acl_high;
 			__u32	m_i_reserved2[2];
 		} masix2;
 	} osd2;				/* OS dependent 2 */
@@ -319,6 +319,7 @@ struct ext3_inode {
 #define i_reserved1	osd1.linux1.l_i_reserved1
 #define i_frag		osd2.linux2.l_i_frag
 #define i_fsize		osd2.linux2.l_i_fsize
+#define i_file_acl_high	osd2.linux2.l_i_file_acl_high
 #define i_uid_low	i_uid
 #define i_gid_low	i_gid
 #define i_uid_high	osd2.linux2.l_i_uid_high
@@ -339,6 +340,7 @@ struct ext3_inode {
 #define i_reserved1	osd1.masix1.m_i_reserved1
 #define i_frag		osd2.masix2.m_i_frag
 #define i_fsize		osd2.masix2.m_i_fsize
+#define i_file_acl_high	osd2.masix2.m_i_file_acl_high
 #define i_reserved2	osd2.masix2.m_i_reserved2
 
 #endif /* defined(__KERNEL__) || defined(__linux__) */

_


