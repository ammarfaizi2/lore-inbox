Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTDHN4w (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTDHN4w (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:56:52 -0400
Received: from angband.namesys.com ([212.16.7.85]:6032 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S261449AbTDHN4v (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 09:56:51 -0400
Date: Tue, 8 Apr 2003 18:08:20 +0400
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: reiserfs: fixup transaction size check for old filesystems [RESEND]
Message-ID: <20030408180820.A17667@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   It turned out that recently introduced additional journal check
   breaks journal replays on filesystems created with old reiserfs
   tools that did not write journal parameters into superblock.

   Please pull from bk://thebsh.namesys.com/bk/reiser3-linux-2.4-jcheck-fix

Diffstat:
 journal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1101  -> 1.1102 
#	fs/reiserfs/journal.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/08	green@angband.namesys.com	1.1102
# reiserfs: Fix recenly introduced journal sanity check that breaks replay on old filesystems.
#   This fixes recently introduced transaction length check. Our
#   initial checks missed the case of filesystem created with old
#   reiserfsprogs that do not write max transaction length into
#   superblock. Zeroes were written there, so all transactions were
#   considered invalid.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Tue Apr  8 18:02:07 2003
+++ b/fs/reiserfs/journal.c	Tue Apr  8 18:02:07 2003
@@ -1401,7 +1401,7 @@
 		     *newest_mount_id) ;
       return -1 ;
     }
-    if ( le32_to_cpu(desc->j_len) > sb_journal_trans_max(SB_DISK_SUPER_BLOCK(p_s_sb)) ) {
+    if ( le32_to_cpu(desc->j_len) > JOURNAL_TRANS_MAX ) {
       reiserfs_warning("journal-2018: Bad transaction length %d encountered, ignoring transaction\n", le32_to_cpu(desc->j_len));
       return -1 ;
     }
