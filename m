Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277349AbRJELPI>; Fri, 5 Oct 2001 07:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277350AbRJELO7>; Fri, 5 Oct 2001 07:14:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63505 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277349AbRJELOn>; Fri, 5 Oct 2001 07:14:43 -0400
Date: Fri, 5 Oct 2001 13:15:07 +0200
From: Jan Kara <jack@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Quota fix
Message-ID: <20011005131507.G18477@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'm sending you a patch which should fix the problems in ext2 quota
initialization which were also in vanilla 2.4.9 kernels. Please apply.
Another patch which fixes the problems in UFS and UDF will follow in next
mail.

								Honza
---------------------------------------------------------------------
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.10-ac3/fs/dquot.c linux-2.4.10-ac3-fix/fs/dquot.c
--- linux-2.4.10-ac3/fs/dquot.c	Wed Oct  3 23:38:38 2001
+++ linux-2.4.10-ac3-fix/fs/dquot.c	Thu Oct  4 12:25:37 2001
@@ -1200,27 +1200,11 @@
 	dqstats.drops++;
 }
 
-/* Check whether this inode is quota file */
-static inline int is_quotafile(struct inode *inode)
-{
-	int cnt;
-	struct quota_info *dqopt = sb_dqopt(inode->i_sb);
-	struct file **files;
-
-	if (!dqopt)
-		return 0;
-	files = dqopt->files;
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (files[cnt] && files[cnt]->f_dentry->d_inode == inode)
-			return 1;
-	return 0;
-}
-
 static int dqinit_needed(struct inode *inode, short type)
 {
 	int cnt;
 
-	if (is_quotafile(inode))
+	if (IS_NOQUOTA(inode))
 		return 0;
 	if (type != -1)
 		return inode->i_dquot[type] == NODQUOT;
@@ -1635,8 +1619,7 @@
 	qid_t id = 0;
 	short cnt;
 
-	/* We don't want to have quotas on quota files - nasty deadlocks possible */
-	if (is_quotafile(inode))
+	if (IS_NOQUOTA(inode))
 		return;
 	/* Build list of quotas to initialize... We can block here */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -2037,7 +2020,9 @@
 	error = -EINVAL;
 	if (inode->i_size == 0 || !check_quotafile(f, type))
 		goto out_f;
-	dquot_drop(inode);	/* We don't want quota on quota files - open might initialize the other quota type... */
+	/* We don't want quota on quota files */
+	dquot_drop(inode);
+	inode->i_flags |= S_NOQUOTA;
 
 	dqopt->files[type] = f;
 	if (read_quotafile_info(sb, type) < 0)	/* Read header from file - OK? */
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.10-ac3/fs/ext2/ialloc.c linux-2.4.10-ac3-fix/fs/ext2/ialloc.c
--- linux-2.4.10-ac3/fs/ext2/ialloc.c	Wed Oct  3 23:38:38 2001
+++ linux-2.4.10-ac3-fix/fs/ext2/ialloc.c	Thu Oct  4 12:35:49 2001
@@ -458,6 +458,7 @@
 	unlock_super (sb);
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
+		inode->i_flags |= S_NOQUOTA;
 		inode->i_nlink = 0;
 		iput(inode);
 		return ERR_PTR(-EDQUOT);
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.10-ac3/include/linux/fs.h linux-2.4.10-ac3-fix/include/linux/fs.h
--- linux-2.4.10-ac3/include/linux/fs.h	Thu Oct  4 11:49:27 2001
+++ linux-2.4.10-ac3-fix/include/linux/fs.h	Thu Oct  4 12:21:34 2001
@@ -130,6 +130,7 @@
 #define S_APPEND	8	/* Append-only file */
 #define S_IMMUTABLE	16	/* Immutable file */
 #define S_DEAD		32	/* removed, but still open directory */
+#define S_NOQUOTA	64	/* Inode is not counted in quota */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -151,6 +152,7 @@
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
 
 #define IS_QUOTAINIT(inode)	((inode)->i_flags & S_QUOTA)
+#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.10-ac3/include/linux/quotaops.h linux-2.4.10-ac3-fix/include/linux/quotaops.h
--- linux-2.4.10-ac3/include/linux/quotaops.h	Thu Oct  4 12:30:27 2001
+++ linux-2.4.10-ac3-fix/include/linux/quotaops.h	Thu Oct  4 12:42:33 2001
@@ -43,7 +43,7 @@
 	if (!inode->i_sb)
 		BUG();
 	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb))
+	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
 	unlock_kernel();
 }
@@ -147,7 +147,7 @@
 static inline int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
 {
 	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb)) {
+	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode)) {
 		inode->i_sb->dq_op->initialize(inode, -1);
 		if (inode->i_sb->dq_op->transfer(inode, iattr) == NO_QUOTA) {
 			unlock_kernel();
