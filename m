Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWCNToE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWCNToE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 14:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWCNToE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 14:44:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:62346 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751259AbWCNToC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 14:44:02 -0500
Subject: [PATCH] JFS: Take logsync lock before testing mp->lsn
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603141132430.3618@g5.osdl.org>
References: <20060314184751.C76408318F@kleikamp.dyn.webahead.ibm.com>
	 <Pine.LNX.4.64.0603141132430.3618@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 13:44:00 -0600
Message-Id: <1142365440.9993.22.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 11:33 -0800, Linus Torvalds wrote:
> 
> On Tue, 14 Mar 2006, Dave Kleikamp wrote:
> >
> > I'd really like the first of these patches (first in the list, but the most
> > recent) to make it into 2.6.16.  All of these patches have been tested in
> > -mm, so I'm confident that they won't break anything.  If you don't want to
> > pick up all of them, I could send you just the one patch.
> 
> At this point in the game, I'd rather take just individual patches known 
> to fix particular bugs..

Okay, I'll just send it the old-fashioned way, and clean up my git tree
after you pick it up.

> It's ok if the patches come in through a git tree, but the particular git 
> tree you pointed to has other diffs that definitely look like fine 
> cleanups, but still they're just cleanups.
> 
> 		Linus

JFS: Take logsync lock before testing mp->lsn

This fixes a race where lsn could be cleared before taking the lock

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 4fb3ed1..c161c98 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -532,10 +532,10 @@ dbUpdatePMap(struct inode *ipbmap,
 
 		lastlblkno = lblkno;
 
+		LOGSYNC_LOCK(log, flags);
 		if (mp->lsn != 0) {
 			/* inherit older/smaller lsn */
 			logdiff(diffp, mp->lsn, log);
-			LOGSYNC_LOCK(log, flags);
 			if (difft < diffp) {
 				mp->lsn = lsn;
 
@@ -548,20 +548,17 @@ dbUpdatePMap(struct inode *ipbmap,
 			logdiff(diffp, mp->clsn, log);
 			if (difft > diffp)
 				mp->clsn = tblk->clsn;
-			LOGSYNC_UNLOCK(log, flags);
 		} else {
 			mp->log = log;
 			mp->lsn = lsn;
 
 			/* insert bp after tblock in logsync list */
-			LOGSYNC_LOCK(log, flags);
-
 			log->count++;
 			list_add(&mp->synclist, &tblk->synclist);
 
 			mp->clsn = tblk->clsn;
-			LOGSYNC_UNLOCK(log, flags);
 		}
+		LOGSYNC_UNLOCK(log, flags);
 	}
 
 	/* write the last buffer. */
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 87dd86c..b62a048 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -2844,11 +2844,11 @@ diUpdatePMap(struct inode *ipimap,
 	 */
 	lsn = tblk->lsn;
 	log = JFS_SBI(tblk->sb)->log;
+	LOGSYNC_LOCK(log, flags);
 	if (mp->lsn != 0) {
 		/* inherit older/smaller lsn */
 		logdiff(difft, lsn, log);
 		logdiff(diffp, mp->lsn, log);
-		LOGSYNC_LOCK(log, flags);
 		if (difft < diffp) {
 			mp->lsn = lsn;
 			/* move mp after tblock in logsync list */
@@ -2860,17 +2860,15 @@ diUpdatePMap(struct inode *ipimap,
 		logdiff(diffp, mp->clsn, log);
 		if (difft > diffp)
 			mp->clsn = tblk->clsn;
-		LOGSYNC_UNLOCK(log, flags);
 	} else {
 		mp->log = log;
 		mp->lsn = lsn;
 		/* insert mp after tblock in logsync list */
-		LOGSYNC_LOCK(log, flags);
 		log->count++;
 		list_add(&mp->synclist, &tblk->synclist);
 		mp->clsn = tblk->clsn;
-		LOGSYNC_UNLOCK(log, flags);
 	}
+	LOGSYNC_UNLOCK(log, flags);
 	write_metapage(mp);
 	return (0);
 }

-- 
David Kleikamp
IBM Linux Technology Center

