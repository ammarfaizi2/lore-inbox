Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbUDBBMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUDBBMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:12:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40938 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263460AbUDBBM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:12:26 -0500
Date: Fri, 2 Apr 2004 02:12:25 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [willy@debian.org: [Ext2-devel] Solving the timestamp problem]
Message-ID: <20040402011225.GH16469@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Perhaps I should have given this a wider distribution to begin with...

----- Forwarded message from Matthew Wilcox <willy@debian.org> -----

From: Matthew Wilcox <willy@debian.org>
To: ext2-devel@lists.sourceforge.net
User-Agent: Mutt/1.4.1i
Subject: [Ext2-devel] Solving the timestamp problem
Date: Thu, 1 Apr 2004 21:34:10 +0100


In reference to http://www.ussg.iu.edu/hypermail/linux/kernel/0404.0/0193.html
we need to store more precise timestamps in ext2.  But where?

Today, we need 10 bits more per timestamp (I guess we don't need to store
dtime more precisely), so we could get away with taking i_reserved1 for
this purpose and combining atime/mtime/ctime subsecond portions into
those 10 bits.  I don't particularly favour this approach.

Looking ahead a bit, we're going to need a few more bits for increasing
the year beyond 2038 (we're just over halfway there from 1970, and I plan
to retire shortly after 2038 so I'd like this to be fixed earlier ;-)
Adding even two more bits for increasing the time gives us a range of
1698 to 2242 which is quite enough for my taste (I do hope we're not
still using *file systems* in 2242).

We're going to need more precision sooner though.  10 bits aren't going
to be enough for cpus in a few years time.

So I propose allocating 16 bits extra for each timestamp (14 bits
for precision and 2 bits for range) taking osd2.linux2.l_i_pad1 and
osd1.linux1.l_i_reserved1.  The code in ext2 to handle this should be
quite straightforward (compiled, not tested):


Index: fs/ext2/inode.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/ext2/inode.c,v
retrieving revision 1.6
diff -u -p -r1.6 inode.c
--- a/fs/ext2/inode.c	27 Jan 2004 18:45:51 -0000	1.6
+++ b/fs/ext2/inode.c	1 Apr 2004 20:32:00 -0000
@@ -1033,6 +1033,12 @@ void ext2_set_inode_flags(struct inode *
 		inode->i_flags |= S_DIRSYNC;
 }
 
+static inline void ext2_readtime(struct timespec *ts, u32 time, u16 time2)
+{
+	ts->tv_sec = le32_to_cpu(time) | ((le16_to_cpu(time2) & 0xc000) << 18);
+	ts->tv_nsec = (le16_to_cpu(time2) & 0x3fff) << 16;
+}
+
 void ext2_read_inode (struct inode * inode)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
@@ -1057,10 +1063,9 @@ void ext2_read_inode (struct inode * ino
 	}
 	inode->i_nlink = le16_to_cpu(raw_inode->i_links_count);
 	inode->i_size = le32_to_cpu(raw_inode->i_size);
-	inode->i_atime.tv_sec = le32_to_cpu(raw_inode->i_atime);
-	inode->i_ctime.tv_sec = le32_to_cpu(raw_inode->i_ctime);
-	inode->i_mtime.tv_sec = le32_to_cpu(raw_inode->i_mtime);
-	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
+	ext2_readtime(&inode->i_atime, raw_inode->i_atime, raw_inode->i_atime2);
+	ext2_readtime(&inode->i_mtime, raw_inode->i_mtime, raw_inode->i_mtime2);
+	ext2_readtime(&inode->i_ctime, raw_inode->i_ctime, raw_inode->i_ctime2);
 	ei->i_dtime = le32_to_cpu(raw_inode->i_dtime);
 	/* We now have enough fields to check if the inode was active or not.
 	 * This is needed because nfsd might try to access dead inodes
@@ -1142,6 +1147,13 @@ bad_inode:
 	return;
 }
 
+static u16 ext2_writetime2(struct timespec *ts)
+{
+	u16 result = ((ts->tv_sec >> 16) >> 16) << 14;
+	result |= ts->tv_nsec >> 16;
+	return result;
+}
+
 static int ext2_update_inode(struct inode * inode, int do_sync)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
@@ -1188,6 +1200,9 @@ static int ext2_update_inode(struct inod
 	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
+	raw_inode->i_atime2 = cpu_to_le16(ext2_writetime2(&inode->i_atime));
+	raw_inode->i_ctime2 = cpu_to_le16(ext2_writetime2(&inode->i_ctime));
+	raw_inode->i_mtime2 = cpu_to_le16(ext2_writetime2(&inode->i_mtime));
 
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
Index: include/linux/ext2_fs.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/ext2_fs.h,v
retrieving revision 1.1
diff -u -p -r1.1 ext2_fs.h
--- a/include/linux/ext2_fs.h	29 Jul 2003 17:02:11 -0000	1.1
+++ b/include/linux/ext2_fs.h	1 Apr 2004 20:32:00 -0000
@@ -222,7 +222,8 @@ struct ext2_inode {
 	__u32	i_flags;	/* File flags */
 	union {
 		struct {
-			__u32  l_i_reserved1;
+			__u16  l_i_ctime2;
+			__u16  l_i_mtime2;
 		} linux1;
 		struct {
 			__u32  h_i_translator;
@@ -240,7 +241,7 @@ struct ext2_inode {
 		struct {
 			__u8	l_i_frag;	/* Fragment number */
 			__u8	l_i_fsize;	/* Fragment size */
-			__u16	i_pad1;
+			__u16	l_i_atime2;
 			__u16	l_i_uid_high;	/* these 2 fields    */
 			__u16	l_i_gid_high;	/* were reserved2[0] */
 			__u32	l_i_reserved2;
@@ -265,7 +266,9 @@ struct ext2_inode {
 #define i_size_high	i_dir_acl
 
 #if defined(__KERNEL__) || defined(__linux__)
-#define i_reserved1	osd1.linux1.l_i_reserved1
+#define i_ctime2	osd1.linux1.l_i_ctime2
+#define i_mtime2	osd1.linux1.l_i_mtime2
+#define i_atime2	osd2.linux2.l_i_atime2
 #define i_frag		osd2.linux2.l_i_frag
 #define i_fsize		osd2.linux2.l_i_fsize
 #define i_uid_low	i_uid

----- End forwarded message -----

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
