Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUFSSDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUFSSDK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 14:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUFSSDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 14:03:10 -0400
Received: from outmx004.isp.belgacom.be ([195.238.2.101]:26247 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264388AbUFSSCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 14:02:55 -0400
Subject: [PATCH 2.6.7] ext3 s_dirt for r/w
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-mUAHo1amTXNsj60AHlq1"
Message-Id: <1087668287.2472.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 19 Jun 2004 20:04:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mUAHo1amTXNsj60AHlq1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here is a patch setting s_dirt for read-write filesystems in ext3_init
(doing it in create_journal seems troublesome IMHO).

PS: untested

Regards,
FabF

--=-mUAHo1amTXNsj60AHlq1
Content-Disposition: attachment; filename=s_dirt1.diff
Content-Type: text/x-patch; name=s_dirt1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/super.c edited/fs/super.c
--- orig/fs/super.c	2004-06-16 07:20:03.000000000 +0200
+++ edited/fs/super.c	2004-06-19 19:58:19.895637880 +0200
@@ -1569,7 +1569,10 @@
 		ext3_count_free_inodes(sb));
 	percpu_counter_mod(&sbi->s_dirs_counter,
 		ext3_count_dirs(sb));
-
+	if (!(sb->s_flags & MS_RDONLY)) {
+		mark_buffer_dirty(sbi->s_sbh);
+		sb->s_dirt = 1;
+	}
 	return 0;
 
 failed_mount3:
@@ -1841,7 +1844,6 @@
 	EXT3_SET_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL);
 
 	es->s_journal_inum = cpu_to_le32(journal_inum);
-	sb->s_dirt = 1;
 
 	/* Make sure we flush the recovery flag to disk. */
 	ext3_commit_super(sb, es, 1);

--=-mUAHo1amTXNsj60AHlq1--

