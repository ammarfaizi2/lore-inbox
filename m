Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293548AbSCCKIw>; Sun, 3 Mar 2002 05:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293549AbSCCKIP>; Sun, 3 Mar 2002 05:08:15 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:43270 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S293551AbSCCJ5B>; Sun, 3 Mar 2002 04:57:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 6
Date: Sun, 3 Mar 2002 04:57:05 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095625Z293042-31624+5@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the sixth of 13 patches.

	As a continuation of patch 5 this changes all of the tracking to bytes. and 
adds those supporting functions.




diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sat Mar  2 19:34:16 2002
+++ linux-2.5/fs/dquot.c	Sat Mar  2 19:33:06 2002
@@ -972,7 +972,7 @@
 			continue;
 		dquot_incr_space(dquot[cnt], number);
 	}
-	inode->i_blocks += number >> 9;
+	inode_add_bytes(inode, number);
 	/* NOBLOCK End */
 	ret = QUOTA_OK;
 warn_put_all:
@@ -1040,7 +1040,7 @@
 		dquot_decr_space(dquot, number);
 		dqputduplicate(dquot);
 	}
-	inode->i_blocks -= number >> 9;
+	inode_sub_bytes(inode, number);
 	unlock_kernel();
 	/* NOBLOCK End */
 }
@@ -1103,7 +1103,7 @@
 		}
 	}
 	/* NOBLOCK START: From now on we shouldn't block */
-	space = ((qsize_t)inode->i_blocks) << 9;
+	space = inode_get_bytes(inode);
 	/* Build the transfer_from list and check the limits */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		/* The second test can fail when quotaoff is in progress... */
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/inode.c linux-2.5/fs/inode.c
--- linux-2.5-linus/fs/inode.c	Sat Mar  2 16:40:20 2002
+++ linux-2.5/fs/inode.c	Sat Mar  2 19:33:52 2002
@@ -100,6 +100,7 @@
 		atomic_set(&inode->i_writecount, 0);
 		inode->i_size = 0;
 		inode->i_blocks = 0;
+		inode->i_bytes = 0;
 		inode->i_generation = 0;
 		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
 		inode->i_pipe = NULL;
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/fs.h 
linux-2.5/include/linux/fs.h
--- linux-2.5-linus/include/linux/fs.h	Sat Mar  2 19:34:16 2002
+++ linux-2.5/include/linux/fs.h	Sat Mar  2 19:32:22 2002
@@ -426,6 +426,7 @@
 	unsigned long		i_blksize;
 	unsigned long		i_blocks;
 	unsigned long		i_version;
+	unsigned short          i_bytes;
 	struct semaphore	i_sem;
 	struct inode_operations	*i_op;
 	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
@@ -485,6 +486,39 @@
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
+
+static inline void inode_add_bytes(struct inode *inode, loff_t bytes)
+{
+	inode->i_blocks += bytes >> 9;
+	bytes &= 511;
+	inode->i_bytes += bytes;
+	if (inode->i_bytes >= 512) {
+		inode->i_blocks++;
+		inode->i_bytes -= 512;
+	}
+}
+
+static inline void inode_sub_bytes(struct inode *inode, loff_t bytes)
+{
+	inode->i_blocks -= bytes >> 9;
+	bytes &= 511;
+	if (inode->i_bytes < bytes) {
+		inode->i_blocks--;
+		inode->i_bytes += 512;
+	}
+	inode->i_bytes -= bytes;
+}
+
+static inline loff_t inode_get_bytes(struct inode *inode)
+{
+	return (((loff_t)inode->i_blocks) << 9) + inode->i_bytes;
+}
+
+static inline void inode_set_bytes(struct inode *inode, loff_t bytes)
+{
+	inode->i_blocks = bytes >> 9;
+	inode->i_bytes = bytes & 511;
+}
 
 struct file {
 	struct list_head	f_list;
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quotaops.h 
linux-2.5/include/linux/quotaops.h
--- linux-2.5-linus/include/linux/quotaops.h	Sat Mar  2 19:34:18 2002
+++ linux-2.5/include/linux/quotaops.h	Sat Mar  2 19:32:22 2002
@@ -70,7 +70,7 @@
 		}
 	}
 	else
-		inode->i_blocks += nr >> 9;
+		inode_add_bytes(inode, nr);
 	unlock_kernel();
 	return 0;
 }
@@ -94,7 +94,7 @@
 		}
 	}
 	else
-		inode->i_blocks += nr >> 9;
+		inode_add_bytes(inode, nr);
 	unlock_kernel();
 	return 0;
 }
@@ -127,7 +127,7 @@
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_space(inode, nr);
 	else
-		inode->i_blocks -= nr >> 9;
+		inode_sub_bytes(inode, nr);
 	unlock_kernel();
 }
 
@@ -177,7 +177,7 @@
 extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, 
qsize_t nr)
 {
 	lock_kernel();
-	inode->i_blocks += nr >> 9;
+	inode_add_bytes(inode, nr);
 	unlock_kernel();
 	return 0;
 }
@@ -192,7 +192,7 @@
 extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t 
nr)
 {
 	lock_kernel();
-	inode->i_blocks += nr >> 9;
+	inode_add_bytes(inode, nr);
 	unlock_kernel();
 	return 0;
 }
@@ -207,7 +207,7 @@
 extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t 
nr)
 {
 	lock_kernel();
-	inode->i_blocks -= nr >> 9;
+	inode_sub_bytes(inode, nr);
 	unlock_kernel();
 }
 
@@ -222,8 +222,8 @@
 #define DQUOT_PREALLOC_BLOCK_NODIRTY(inode, nr)	
DQUOT_PREALLOC_SPACE_NODIRTY(inode, ((qsize_t)(nr)) << 
(inode)->i_sb->s_blocksize_bits)
 #define DQUOT_PREALLOC_BLOCK(inode, nr)	DQUOT_PREALLOC_SPACE(inode, 
((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
 #define DQUOT_ALLOC_BLOCK_NODIRTY(inode, nr) 
DQUOT_ALLOC_SPACE_NODIRTY(inode, ((qsize_t)(nr)) << 
(inode)->i_sb->s_blocksize_bits)
-#define DQUOT_ALLOC_BLOCK(inode, nr) DQUOT_ALLOC_SPACE(inode, 
fs_to_dq_blocks(nr, ((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
+#define DQUOT_ALLOC_BLOCK(inode, nr) DQUOT_ALLOC_SPACE(inode, 
((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
 #define DQUOT_FREE_BLOCK_NODIRTY(inode, nr) DQUOT_FREE_SPACE_NODIRTY(inode, 
((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
-#define DQUOT_FREE_BLOCK(inode, nr) DQUOT_FREE_SPACE(inode, 
fs_to_dq_blocks(nr, ((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
+#define DQUOT_FREE_BLOCK(inode, nr) DQUOT_FREE_SPACE(inode, ((qsize_t)(nr)) 
<< (inode)->i_sb->s_blocksize_bits)
 
 #endif /* _LINUX_QUOTAOPS_ */
