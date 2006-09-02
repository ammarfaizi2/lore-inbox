Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWIBLmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWIBLmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 07:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWIBLmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 07:42:12 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:60502 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751071AbWIBLmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 07:42:11 -0400
Message-ID: <44F96DD0.30608@sw.ru>
Date: Sat, 02 Sep 2006 15:41:04 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Stephen Tweedie <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, devel@openvz.org
Subject: [PATCH] ext3: wrong error behavior
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------090209060903080509060206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090209060903080509060206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

SWsoft Virtuozzo/OpenVZ Linux kernel team has discovered that ext3 error
behavior was broken in linux kernels since 2.5.x versions by the following patch:

2002/10/31 02:15:26-05:00 tytso@snap.thunk.org
Default mount options from superblock for ext2/3 filesystems
http://linux.bkbits.net:8080/linux-2.6/gnupatch@3dc0d88eKbV9ivV4ptRNM8fBuA3JBQ

In case ext3 file system is mounted with errors=continue (EXT3_ERRORS_CONTINUE)
errors should be ignored when possible. However at present in case of any error
kernel aborts journal and remounts filesystem to read-only. Such behavior was
hit number of times and noted to differ from that of 2.4.x kernels.

This patch fixes this:
- do nothing in case of EXT3_ERRORS_CONTINUE,
- set EXT3_MOUNT_ABORT and call journal_abort() in all other cases
- panic() should be called after ext3_commit_super() to save
 sb marked as EXT3_ERROR_FS

Signed-off-by: Vasily Averin <vvs@sw.ru>
Ack-by:	Kirill Korotaev <dev@sw.ru>

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

--------------090209060903080509060206
Content-Type: text/plain;
 name="diff-ext3-errorbehaviour-20060902"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ext3-errorbehaviour-20060902"

--- linux-2.6.18-rc5/fs/ext3/super.c.orig	2006-09-02 12:54:01.000000000 +0400
+++ linux-2.6.18-rc5/fs/ext3/super.c	2006-09-02 13:10:02.000000000 +0400
@@ -159,20 +159,21 @@ static void ext3_handle_error(struct sup
 	if (sb->s_flags & MS_RDONLY)
 		return;
 
-	if (test_opt (sb, ERRORS_RO)) {
-		printk (KERN_CRIT "Remounting filesystem read-only\n");
-		sb->s_flags |= MS_RDONLY;
-	} else {
+	if (!test_opt (sb, ERRORS_CONT)) {
 		journal_t *journal = EXT3_SB(sb)->s_journal;
 
 		EXT3_SB(sb)->s_mount_opt |= EXT3_MOUNT_ABORT;
 		if (journal)
 			journal_abort(journal, -EIO);
 	}
+	if (test_opt (sb, ERRORS_RO)) {
+		printk (KERN_CRIT "Remounting filesystem read-only\n");
+		sb->s_flags |= MS_RDONLY;
+	}
+	ext3_commit_super(sb, es, 1);
 	if (test_opt(sb, ERRORS_PANIC))
 		panic("EXT3-fs (device %s): panic forced after error\n",
 			sb->s_id);
-	ext3_commit_super(sb, es, 1);
 }
 
 void ext3_error (struct super_block * sb, const char * function,

--------------090209060903080509060206--

-- 
VGER BF report: H 0.337468
