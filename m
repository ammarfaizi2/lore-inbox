Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSEINdp>; Thu, 9 May 2002 09:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSEINdp>; Thu, 9 May 2002 09:33:45 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:62168 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S312169AbSEINdm>; Thu, 9 May 2002 09:33:42 -0400
Date: Thu, 9 May 2002 08:32:46 -0500
From: David Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200205091332.g49DWjS4001942@kleikamp.austin.ibm.com>
To: akpm@zip.com.au, torvalds@transmeta.com
Subject: [BK PATCH] [2.5.14] Fix JFS file system corruption
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
This patch should apply cleanly to your bitkeeper tree.

Andrew,
I haven't done anything about the deadlock yet.  This fix took
priority since it can completely destroy the root fs.  In fact I
had to reinstall after doing so.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.550, 2002-05-09 07:40:45-05:00, shaggy@kleikamp.austin.ibm.com
  JFS: Flush dirty metadata to disk when remounting from read-write
  to read-only.  Also fix umount ordering to make sure metadata is
  written before journal closed.
  
  With Andrew Morton's recent changes, JFS is no longer writing much
  of its dirty metadata when remounting from read-write to read-only.
  This causes severe file system corruption.  A JFS root file system
  will be corrupted on shutdown.
  
  This patch fixes the problem by explicitly writing the dirty metadata
  before the journal is closed.  It also fixes the ordering so that
  the dirty metadata is completely written before the journal is closed
  for the normal unmount case as well.


 jfs_logmgr.c |   47 ++++++++++++++++++++++++++++++-----------------
 jfs_logmgr.h |    1 +
 jfs_umount.c |   45 +++++++++++++++++++++++++++++++--------------
 3 files changed, 62 insertions(+), 31 deletions(-)


diff -Nru a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
--- a/fs/jfs/jfs_logmgr.c	Thu May  9 08:13:46 2002
+++ b/fs/jfs/jfs_logmgr.c	Thu May  9 08:13:46 2002
@@ -1386,6 +1386,35 @@
 
 
 /*
+ * NAME:	lmLogWait()
+ *
+ * FUNCTION:	wait for all outstanding log records to be written to disk
+ */
+void lmLogWait(log_t *log)
+{
+	int i;
+
+	jFYI(1, ("lmLogWait: log:0x%p\n", log));
+
+	if (log->cqueue.head || !list_empty(&log->synclist)) {
+		/*
+		 * If there was very recent activity, we may need to wait
+		 * for the lazycommit thread to catch up
+		 */
+
+		for (i = 0; i < 800; i++) {	/* Too much? */
+			current->state = TASK_INTERRUPTIBLE;
+			schedule_timeout(HZ / 4);
+			if ((log->cqueue.head == NULL) &&
+			    list_empty(&log->synclist))
+				break;
+		}
+	}
+	assert(log->cqueue.head == NULL);
+	assert(list_empty(&log->synclist));
+}
+
+/*
  * NAME:	lmLogShutdown()
  *
  * FUNCTION:	log shutdown at last LogClose().
@@ -1411,23 +1440,7 @@
 
 	jFYI(1, ("lmLogShutdown: log:0x%p\n", log));
 
-	if (log->cqueue.head || !list_empty(&log->synclist)) {
-		/*
-		 * If there was very recent activity, we may need to wait
-		 * for the lazycommit thread to catch up
-		 */
-		int i;
-
-		for (i = 0; i < 800; i++) {	/* Too much? */
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(HZ / 4);
-			if ((log->cqueue.head == NULL) &&
-			    list_empty(&log->synclist))
-				break;
-		}
-	}
-	assert(log->cqueue.head == NULL);
-	assert(list_empty(&log->synclist));
+	lmLogWait(log);
 
 	/*
 	 * We need to make sure all of the "written" metapages
diff -Nru a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
--- a/fs/jfs/jfs_logmgr.h	Thu May  9 08:13:46 2002
+++ b/fs/jfs/jfs_logmgr.h	Thu May  9 08:13:46 2002
@@ -489,6 +489,7 @@
 }
 
 extern int lmLogOpen(struct super_block *sb, log_t ** log);
+extern void lmLogWait(log_t * log);
 extern int lmLogClose(struct super_block *sb, log_t * log);
 extern int lmLogSync(log_t * log, int nosyncwait);
 extern int lmLogQuiesce(log_t * log);
diff -Nru a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
--- a/fs/jfs/jfs_umount.c	Thu May  9 08:13:46 2002
+++ b/fs/jfs/jfs_umount.c	Thu May  9 08:13:46 2002
@@ -64,15 +64,11 @@
 	 *
 	 * if mounted read-write and log based recovery was enabled
 	 */
-	if ((log = sbi->log)) {
+	if ((log = sbi->log))
 		/*
-		 * close log: 
-		 *
-		 * remove file system from log active file system list.
+		 * Wait for outstanding transactions to be written to log: 
 		 */
-		log = sbi->log;
-		rc = lmLogClose(sb, log);
-	}
+		lmLogWait(log);
 
 	/*
 	 * close fileset inode allocation map (aka fileset inode)
@@ -113,6 +109,14 @@
 	sbi->ipimap = NULL;
 
 	/*
+	 * Make sure all metadata makes it to disk before we mark
+	 * the superblock as clean
+	 */
+	filemap_fdatawait(sbi->direct_inode->i_mapping);
+	filemap_fdatawrite(sbi->direct_inode->i_mapping);
+	filemap_fdatawait(sbi->direct_inode->i_mapping);
+
+	/*
 	 * ensure all file system file pages are propagated to their
 	 * home blocks on disk (and their in-memory buffer pages are 
 	 * invalidated) BEFORE updating file system superblock state
@@ -120,10 +124,16 @@
 	 * consistent state) and log superblock active file system 
 	 * list (to signify skip logredo()).
 	 */
-	if (log)		/* log = NULL if read-only mount */
+	if (log) {		/* log = NULL if read-only mount */
 		rc = updateSuper(sb, FM_CLEAN);
 
-
+		/*
+		 * close log: 
+		 *
+		 * remove file system from log active file system list.
+		 */
+		rc = lmLogClose(sb, log);
+	}
 	jFYI(0, ("	UnMount JFS Complete: %d\n", rc));
 	return rc;
 }
@@ -132,8 +142,9 @@
 int jfs_umount_rw(struct super_block *sb)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
+	log_t *log = sbi->log;
 
-	if (!sbi->log)
+	if (!log)
 		return 0;
 
 	/*
@@ -141,13 +152,19 @@
 	 *
 	 * remove file system from log active file system list.
 	 */
-	lmLogClose(sb, sbi->log);
+	lmLogWait(log);
 
+	/*
+	 * Make sure all metadata makes it to disk
+	 */
 	dbSync(sbi->ipbmap);
 	diSync(sbi->ipimap);
+	filemap_fdatawait(sbi->direct_inode->i_mapping);
+	filemap_fdatawrite(sbi->direct_inode->i_mapping);
+	filemap_fdatawait(sbi->direct_inode->i_mapping);
 
-	sbi->log = 0;
+	updateSuper(sb, FM_CLEAN);
+	sbi->log = NULL;
 
-	return updateSuper(sb, FM_CLEAN);
-       
+	return lmLogClose(sb, log);
 }

===================================================================


This BitKeeper patch contains the following changesets:
1.550
## Wrapped with gzip_uu ##


begin 664 bkpatch1793
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
)":.AL&#&$P``
`
end
