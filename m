Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271629AbRIBP3f>; Sun, 2 Sep 2001 11:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271634AbRIBP3Z>; Sun, 2 Sep 2001 11:29:25 -0400
Received: from ns.caldera.de ([212.34.180.1]:45471 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271629AbRIBP3Q>;
	Sun, 2 Sep 2001 11:29:16 -0400
Date: Sun, 2 Sep 2001 17:28:47 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix vfs_permission
Message-ID: <20010902172847.A11520@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch fixes a bug in vfs_permission that always allowed
root to exetue anything.  With the patch at least one x bit must be set.
The new behaviour is the one found in other UNIX derivates.

That patch has proven stable in -ac for a few weeks, please apply,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/namei.c linux/fs/namei.c
--- ../master/linux-2.4.10-pre3/fs/namei.c	Fri Jul 20 21:39:56 2001
+++ linux/fs/namei.c	Sun Sep  2 17:04:44 2001
@@ -139,35 +139,55 @@
 }
 
 /*
- *	permission()
+ *	vfs_permission()
  *
  * is used to check for read/write/execute permissions on a file.
  * We use "fsuid" for this, letting us set arbitrary permissions
  * for filesystem access without changing the "normal" uids which
  * are used for other things..
  */
-int vfs_permission(struct inode * inode,int mask)
+int vfs_permission(struct inode * inode, int mask)
 {
-	int mode = inode->i_mode;
+	umode_t			mode = inode->i_mode;
 
-	if ((mask & S_IWOTH) && IS_RDONLY(inode) &&
-		 (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
-		return -EROFS; /* Nobody gets write access to a read-only fs */
-
-	if ((mask & S_IWOTH) && IS_IMMUTABLE(inode))
-		return -EACCES; /* Nobody gets write access to an immutable file */
+	if (mask & MAY_WRITE) {
+		/*
+		 * Nobody gets write access to a read-only fs.
+		 */
+		if (IS_RDONLY(inode) &&
+		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
+			return -EROFS;
+
+		/*
+		 * Nobody gets write access to an immutable file.
+		 */
+		if (IS_IMMUTABLE(inode))
+			return -EACCES;
+	}
 
 	if (current->fsuid == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
 
-	if (((mode & mask & S_IRWXO) == mask) || capable(CAP_DAC_OVERRIDE))
+	/*
+	 * If the DACs are ok we don't need any capability check.
+	 */
+	if (((mode & mask & (MAY_READ|MAY_WRITE|MAY_EXEC)) == mask))
 		return 0;
 
-	/* read and search access */
-	if ((mask == S_IROTH) ||
-	    (S_ISDIR(inode->i_mode)  && !(mask & ~(S_IROTH | S_IXOTH))))
+	/*
+	 * Read/write DACs are always overridable.
+	 * Executable DACs are overridable if at least one exec bit is set.
+	 */
+	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+
+	/*
+	 * Searching includes executable on directories, else just read.
+	 */
+	if (mask == MAY_READ || (S_ISDIR(inode->i_mode) && !(mask & MAY_WRITE)))
 		if (capable(CAP_DAC_READ_SEARCH))
 			return 0;
 
