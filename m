Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSIERx5>; Thu, 5 Sep 2002 13:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSIERx5>; Thu, 5 Sep 2002 13:53:57 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:32906 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317946AbSIERxy>; Thu, 5 Sep 2002 13:53:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Oleg Drokin <green@namesys.com>
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Date: Thu, 5 Sep 2002 12:58:27 -0500
X-Mailer: KMail [version 1.4]
Cc: "David S. Miller" <davem@redhat.com>, szepe@pinerecords.com,
       mason@suse.com, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
References: <3D76A6FF.509@namesys.com> <200209051109.12291.shaggy@austin.ibm.com> <20020905201337.A4698@namesys.com>
In-Reply-To: <20020905201337.A4698@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209051258.27366.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the JFS patch.  When I first saw this thread I didn't expect that
the result would be increasing the max. number of links.  :^)

Note that I made JFS_LINK_MAX the maximum supported by JFS,
and VFS_LINK_MAX as the number limited by the size of nlink_t.
VFS_LINK_MAX could be moved to fs.h if other file systems are
to use it in the same way.

I borrowed reiserfs's *_INODE_NLINK macros, but made them inline functions.

(I don't usually send patches from kmail.  I hope it doesn't screw up the formatting.)

===== fs/jfs/jfs_filsys.h 1.1 vs edited =====
--- 1.1/fs/jfs/jfs_filsys.h	Fri May 31 08:19:24 2002
+++ edited/fs/jfs/jfs_filsys.h	Thu Sep  5 11:01:55 2002
@@ -125,7 +125,13 @@
 #define MAXBLOCKSIZE		4096
 #define	MAXFILESIZE		((s64)1 << 52)
 
-#define JFS_LINK_MAX		65535	/* nlink_t is unsigned short */
+/*
+ * The max link count in struct inode is limited to the size of nlink_t.
+ * The JFS inode uses an unsigned 32-bit int, so we can really go higher
+ */
+#define JFS_LINK_MAX	0xffffffff	/* real limit */
+#define VFS_LINK_MAX	((((nlink_t) -1) > 0) ? (nlink_t) ~0 : \
+			 ((1u << (sizeof (nlink_t) * 8 - 1)) -1))
 
 /* Minimum number of bytes supported for a JFS partition */
 #define MINJFS			(0x1000000)
===== fs/jfs/jfs_imap.c 1.6 vs edited =====
--- 1.6/fs/jfs/jfs_imap.c	Wed Sep  4 11:11:52 2002
+++ edited/fs/jfs/jfs_imap.c	Thu Sep  5 10:52:53 2002
@@ -3035,7 +3035,15 @@
 	jfs_ip->mode2 = le32_to_cpu(dip->di_mode);
 
 	ip->i_mode = le32_to_cpu(dip->di_mode) & 0xffff;
-	ip->i_nlink = le32_to_cpu(dip->di_nlink);
+
+	jfs_ip->nlink_real = le32_to_cpu(dip->di_nlink);
+	if (jfs_ip->nlink_real <= VFS_LINK_MAX)
+		ip->i_nlink = jfs_ip->nlink_real;
+	else if (S_ISDIR(ip->i_mode))
+		ip->i_nlink = 1;
+	else
+		ip->i_nlink = VFS_LINK_MAX;
+
 	ip->i_uid = le32_to_cpu(dip->di_uid);
 	ip->i_gid = le32_to_cpu(dip->di_gid);
 	ip->i_size = le64_to_cpu(dip->di_size);
@@ -3089,7 +3097,7 @@
 	dip->di_gen = cpu_to_le32(ip->i_generation);
 	dip->di_size = cpu_to_le64(ip->i_size);
 	dip->di_nblocks = cpu_to_le64(PBLK2LBLK(ip->i_sb, ip->i_blocks));
-	dip->di_nlink = cpu_to_le32(ip->i_nlink);
+	dip->di_nlink = cpu_to_le32(jfs_ip->nlink_real);
 	dip->di_uid = cpu_to_le32(ip->i_uid);
 	dip->di_gid = cpu_to_le32(ip->i_gid);
 	/*
===== fs/jfs/jfs_incore.h 1.5 vs edited =====
--- 1.5/fs/jfs/jfs_incore.h	Mon Sep  2 05:48:42 2002
+++ edited/fs/jfs/jfs_incore.h	Thu Sep  5 10:12:09 2002
@@ -38,6 +38,7 @@
 	struct inode *inode;	/* pointer back to fs-independent inode */
 	int	fileset;	/* fileset number (always 16)*/
 	uint	mode2;		/* jfs-specific mode		*/
+	uint	nlink_real;	/* i_nlink is too short		*/
 	pxd_t   ixpxd;		/* inode extent descriptor	*/
 	dxd_t	acl;		/* dxd describing acl	*/
 	dxd_t	ea;		/* dxd describing ea	*/
===== fs/jfs/namei.c 1.9 vs edited =====
--- 1.9/fs/jfs/namei.c	Mon Aug 26 14:07:42 2002
+++ edited/fs/jfs/namei.c	Thu Sep  5 11:11:57 2002
@@ -44,6 +44,34 @@
 s64 commitZeroLink(tid_t, struct inode *);
 
 /*
+ * i_nlink accounting
+ * Keep track of real link count, while keeping i_nlink, which may be too
+ * small to hold the real value, sane.
+ */
+static inline void INC_INODE_NLINK(struct inode *inode)
+{
+	if (++JFS_IP(inode)->nlink_real <= VFS_LINK_MAX)
+		inode->i_nlink = JFS_IP(inode)->nlink_real;
+}
+static inline void DEC_INODE_NLINK(struct inode *inode)
+{
+	if (--JFS_IP(inode)->nlink_real <= VFS_LINK_MAX)
+		inode->i_nlink = JFS_IP(inode)->nlink_real;
+}
+/*
+ * Due to an optimazation in the find command (and other cases?),
+ * set i_nlink to one if i_nlink can't be correct.
+ */
+static inline void INC_DIR_INODE_NLINK(struct inode *inode)
+{
+	if (++JFS_IP(inode)->nlink_real <= VFS_LINK_MAX)
+		inode->i_nlink = JFS_IP(inode)->nlink_real;
+	else
+		inode->i_nlink = 1;
+}
+#define DEC_DIR_INODE_NLINK DEC_INODE_NLINK
+
+/*
  * NAME:	jfs_create(dip, dentry, mode)
  *
  * FUNCTION:	create a regular file in the parent directory <dip>
@@ -142,7 +170,7 @@
 	up(&JFS_IP(dip)->commit_sem);
 	up(&JFS_IP(ip)->commit_sem);
 	if (rc) {
-		ip->i_nlink = 0;
+		ip->i_nlink = JFS_IP(ip)->nlink_real = 0;
 		iput(ip);
 	}
 
@@ -185,7 +213,7 @@
 	jFYI(1, ("jfs_mkdir: dip:0x%p name:%s\n", dip, dentry->d_name.name));
 
 	/* link count overflow on parent directory ? */
-	if (dip->i_nlink == JFS_LINK_MAX) {
+	if (JFS_IP(dip)->nlink_real == JFS_LINK_MAX) {
 		rc = EMLINK;
 		goto out1;
 	}
@@ -245,7 +273,7 @@
 		goto out3;
 	}
 
-	ip->i_nlink = 2;	/* for '.' */
+	ip->i_nlink = JFS_IP(ip)->nlink_real = 2;	/* for '.' */
 	ip->i_op = &jfs_dir_inode_operations;
 	ip->i_fop = &jfs_dir_operations;
 	ip->i_mapping->a_ops = &jfs_aops;
@@ -256,7 +284,7 @@
 	d_instantiate(dentry, ip);
 
 	/* update parent directory inode */
-	dip->i_nlink++;		/* for '..' from child directory */
+	INC_DIR_INODE_NLINK(dip);	/* for '..' from child directory */
 	dip->i_ctime = dip->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dip);
 
@@ -267,7 +295,7 @@
 	up(&JFS_IP(dip)->commit_sem);
 	up(&JFS_IP(ip)->commit_sem);
 	if (rc) {
-		ip->i_nlink = 0;
+		ip->i_nlink = JFS_IP(ip)->nlink_real = 0;
 		iput(ip);
 	}
 
@@ -351,7 +379,7 @@
 	/* update parent directory's link count corresponding
 	 * to ".." entry of the target directory deleted
 	 */
-	dip->i_nlink--;
+	DEC_DIR_INODE_NLINK(dip);
 	dip->i_ctime = dip->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dip);
 
@@ -373,7 +401,7 @@
 	JFS_IP(ip)->acl.flag = 0;
 
 	/* mark the target directory as deleted */
-	ip->i_nlink = 0;
+	ip->i_nlink = JFS_IP(ip)->nlink_real = 0;
 	mark_inode_dirty(ip);
 
 	rc = txCommit(tid, 2, &iplist[0], 0);
@@ -470,7 +498,7 @@
 	mark_inode_dirty(dip);
 
 	/* update target's inode */
-	ip->i_nlink--;
+	DEC_INODE_NLINK(ip);
 	mark_inode_dirty(ip);
 
 	/*
@@ -768,7 +796,7 @@
 	down(&JFS_IP(dir)->commit_sem);
 	down(&JFS_IP(ip)->commit_sem);
 
-	if (ip->i_nlink == JFS_LINK_MAX) {
+	if (JFS_IP(ip)->nlink_real == JFS_LINK_MAX) {
 		rc = EMLINK;
 		goto out;
 	}
@@ -790,7 +818,7 @@
 		goto out;
 
 	/* update object inode */
-	ip->i_nlink++;		/* for new link */
+	INC_INODE_NLINK(ip);
 	ip->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 	atomic_inc(&ip->i_count);
@@ -1004,7 +1032,7 @@
 	up(&JFS_IP(dip)->commit_sem);
 	up(&JFS_IP(ip)->commit_sem);
 	if (rc) {
-		ip->i_nlink = 0;
+		ip->i_nlink = JFS_IP(ip)->nlink_real = 0;
 		iput(ip);
 	}
 
@@ -1091,7 +1119,7 @@
 				goto out3;
 			}
 		} else if ((new_dir != old_dir) &&
-			   (new_dir->i_nlink == JFS_LINK_MAX)) {
+			   (JFS_IP(new_dir)->nlink_real == JFS_LINK_MAX)) {
 			rc = EMLINK;
 			goto out3;
 		}
@@ -1118,9 +1146,9 @@
 			      old_ip->i_ino, JFS_RENAME);
 		if (rc)
 			goto out4;
-		new_ip->i_nlink--;
+		DEC_INODE_NLINK(new_ip);
 		if (S_ISDIR(new_ip->i_mode)) {
-			new_ip->i_nlink--;
+			DEC_DIR_INODE_NLINK(new_ip);
 			assert(new_ip->i_nlink == 0);
 			tblk = tid_to_tblock(tid);
 			tblk->xflag |= COMMIT_DELETE;
@@ -1162,7 +1190,7 @@
 			goto out4;
 		}
 		if (S_ISDIR(old_ip->i_mode))
-			new_dir->i_nlink++;
+			INC_DIR_INODE_NLINK(new_dir);
 	}
 	/*
 	 * Remove old directory entry
@@ -1178,7 +1206,7 @@
 		goto out4;
 	}
 	if (S_ISDIR(old_ip->i_mode)) {
-		old_dir->i_nlink--;
+		DEC_DIR_INODE_NLINK(old_dir);
 		if (old_dir != new_dir) {
 			/*
 			 * Change inode number of parent for moved directory
@@ -1351,7 +1379,7 @@
 	up(&JFS_IP(ip)->commit_sem);
 	up(&JFS_IP(dir)->commit_sem);
 	if (rc) {
-		ip->i_nlink = 0;
+		ip->i_nlink = JFS_IP(ip)->nlink_real = 0;
 		iput(ip);
 	}
 


