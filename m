Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318897AbSH1Pqe>; Wed, 28 Aug 2002 11:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318881AbSH1PmQ>; Wed, 28 Aug 2002 11:42:16 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:4483 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318884AbSH1PlJ>; Wed, 28 Aug 2002 11:41:09 -0400
Date: Wed, 28 Aug 2002 16:45:20 +0100
Message-Id: <200208281545.g7SFjK314342@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 6/8] 2.4.20-pre4/ext3: Performance fix for O_SYNC behaviour
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unconditional mark_inode_dirty() which was being done on O_SYNC
inodes, as that is a major performance hit if we are updating files in place
and don't need an inode timestamp update to hit the journal (Linux really
implements O_DATASYNC instead of O_SYNC).

Cater for the data=journal case by forcing a commit after the write if needed;
also do this for IS_SYNC() case.  (Simply setting the inode dirty before the
write is not sufficient in the data=journal case --- the write might get split
over multiple transactions and there is no guarantee that later transactions
would get flushed.)

Add a bit of documentation around the ext3_file_write --- the interactions
between the various sync modes and the core VFS (especially
generic_osync_inode) are subtle.

--- linux-ext3-2.4merge/fs/ext3/file.c.=K0007=.orig	Tue Aug 27 23:17:59 2002
+++ linux-ext3-2.4merge/fs/ext3/file.c	Tue Aug 27 23:19:57 2002
@@ -61,19 +61,52 @@
 static ssize_t
 ext3_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
+	int ret, err;
 	struct inode *inode = file->f_dentry->d_inode;
 
-	/*
-	 * Nasty: if the file is subject to synchronous writes then we need
-	 * to force generic_osync_inode() to call ext3_write_inode().
-	 * We do that by marking the inode dirty.  This adds much more
-	 * computational expense than we need, but we're going to sync
-	 * anyway.
-	 */
-	if (IS_SYNC(inode) || (file->f_flags & O_SYNC))
-		mark_inode_dirty(inode);
+	ret = generic_file_write(file, buf, count, ppos);
 
-	return generic_file_write(file, buf, count, ppos);
+	/* Skip file flushing code if there was an error, or if nothing
+	   was written. */
+	if (ret <= 0)
+		return ret;
+	
+	/* If the inode is IS_SYNC, or is O_SYNC and we are doing
+           data-journaling, then we need to make sure that we force the
+           transaction to disk to keep all metadata uptodate
+           synchronously. */
+
+	if (file->f_flags & O_SYNC) {
+		/* If we are non-data-journaled, then the dirty data has
+                   already been flushed to backing store by
+                   generic_osync_inode, and the inode has been flushed
+                   too if there have been any modifications other than
+                   mere timestamp updates.
+		   
+		   Open question --- do we care about flushing
+		   timestamps too if the inode is IS_SYNC? */
+		if (!ext3_should_journal_data(inode))
+			return ret;
+
+		goto force_commit;
+	}
+
+	/* So we know that there has been no forced data flush.  If the
+           inode is marked IS_SYNC, we need to force one ourselves. */
+	if (!IS_SYNC(inode))
+		return ret;
+	
+	/* Open question #2 --- should we force data to disk here too?
+           If we don't, the only impact is that data=writeback
+           filesystems won't flush data to disk automatically on
+           IS_SYNC, only metadata (but historically, that is what ext2
+           has done.) */
+	
+force_commit:
+	err = ext3_force_commit(inode->i_sb);
+	if (err) 
+		return err;
+	return ret;
 }
 
 struct file_operations ext3_file_operations = {
