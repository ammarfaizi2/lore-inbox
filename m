Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSLAIEX>; Sun, 1 Dec 2002 03:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSLAIEX>; Sun, 1 Dec 2002 03:04:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:13558 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261524AbSLAIEW>;
	Sun, 1 Dec 2002 03:04:22 -0500
Message-ID: <3DE9C43D.61FF79C5@digeo.com>
Date: Sun, 01 Dec 2002 00:11:41 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: data corrupting bug in 2.4.20 ext3, data=journal
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2002 08:11:42.0307 (UTC) FILETIME=[481BCB30:01C29911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4.20-pre5 an optimisation was made to the ext3 fsync function
which can very easily cause file data corruption at unmount time.  This
was first reported by Nick Piggin on November 29th (one day after 2.4.20 was
released, and three months after the bug was merged.  Unfortunate timing)

This only affects filesystems which were mounted with the `data=journal'
option.  Or files which are operating under `chattr -j'.  So most people
are unaffected.  The problem is not present in 2.5 kernels.

The symptoms are that any file data which was written within the thirty
seconds prior to the unmount may not make it to disk.   A workaround is
to run `sync' before unmounting.

The optimisation was intended to avoid writing out and waiting on the
inode's buffers when the subsequent commit would do that anyway. This
optimisation was applied to both data=journal and data=ordered modes.
But it is only valid for data=ordered mode.

In data=journal mode the data is left dirty in memory and the unmount
will silently discard it.

The fix is to only apply the optimisation to inodes which are operating
under data=ordered.



--- linux-akpm/fs/ext3/fsync.c~ext3-fsync-fix	Sat Nov 30 23:37:33 2002
+++ linux-akpm-akpm/fs/ext3/fsync.c	Sat Nov 30 23:39:30 2002
@@ -63,10 +63,12 @@ int ext3_sync_file(struct file * file, s
 	 */
 	ret = fsync_inode_buffers(inode);
 
-	/* In writeback mode, we need to force out data buffers too.  In
-	 * the other modes, ext3_force_commit takes care of forcing out
-	 * just the right data blocks. */
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)
+	/*
+	 * If the inode is under ordered-data writeback it is not necessary to
+	 * sync its data buffers here - commit will do that, with potentially
+	 * better IO merging
+	 */
+	if (!ext3_should_order_data(inode))
 		ret |= fsync_inode_data_buffers(inode);
 
 	ext3_force_commit(inode->i_sb);

_
