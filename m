Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVARUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVARUwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVARUwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 15:52:37 -0500
Received: from vivaldi.madbase.net ([81.173.6.10]:60890 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S261415AbVARUwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 15:52:34 -0500
Date: Tue, 18 Jan 2005 15:52:32 -0500 (EST)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: linux-kernel@vger.kernel.org, ext3-users@redhat.com, sct@redhat.com,
       akpm@osdl.org, adilger@clusterfs.com
Subject: [PATCH] ext3: commit superblock before panicking
Message-ID: <Pine.LNX.4.58.0501181509300.5957@vivaldi.madbase.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I have a problem with errors=panic on ext3. When a panic occurs, the
error event is not recorded anywhere. So after the reboot, e2fsck
doesn't kick in, the file system gets mounted again and the box panics
again...

Patch below moves the ERRORS_PANIC test down a bit so the journal is
aborted before panic() is called.

Eric


Signed-off-by: Eric Lammerts <eric@lammerts.org>

--- linux-2.6.10/fs/ext3/super.c.orig	2005-01-18 15:07:47.673128436 -0500
+++ linux-2.6.10/fs/ext3/super.c	2005-01-18 15:43:55.311501654 -0500
@@ -143,9 +143,6 @@
 	if (sb->s_flags & MS_RDONLY)
 		return;

-	if (test_opt (sb, ERRORS_PANIC))
-		panic ("EXT3-fs (device %s): panic forced after error\n",
-		       sb->s_id);
 	if (test_opt (sb, ERRORS_RO)) {
 		printk (KERN_CRIT "Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
@@ -156,6 +153,9 @@
 		if (journal)
 			journal_abort(journal, -EIO);
 	}
+	if (test_opt (sb, ERRORS_PANIC))
+		panic ("EXT3-fs (device %s): panic forced after error\n",
+		       sb->s_id);
 	ext3_commit_super(sb, es, 1);
 }

