Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTJLGF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 02:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbTJLGF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 02:05:27 -0400
Received: from adsl-67-67-9-206.dsl.okcyok.swbell.net ([67.67.9.206]:39640
	"HELO homer.d-oh.org") by vger.kernel.org with SMTP id S263424AbTJLGFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 02:05:21 -0400
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: ReiserFS patch for updating ctimes of renamed files
Date: Sun, 12 Oct 2003 01:05:19 -0500
Message-ID: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran into some trouble trying to do incremental backups with GNU tar
(using --listed-incremental) where renaming a file in between backups would
cause the file to disappear upon restoration.  When investigating the issue
I discovered that this doesn't happen on ext2, ext3, and tmpfs filesystems
but only on ReiserFS filesystems.  I also noticed that for example ext3
updates the affected file's ctime upon rename whereas ReiserFS doesn't, so
I'm thinking this causes tar to believe that the file existed before the
first backup was taking under the new name, and as a result it doesn't back
it up during the second backup.  So I believe ReiserFS needs to update
ctimes for renamed files in order for incremental GNU tar backups to work
reliably.

I made some changes to the reiserfs_rename function that I *think* should
fix the problem.  However, I don't know much about ReiserFS's internals, and
I haven't been able to test them out to see if things work now since I can't
afford to deal with potential FS corruption with my current Linux box.

I included a patch below against the 2.4.22 kernel with my changes.  Would
somebody mind taking a look at this to see if I did things right here (and
perhaps wouldn't mind testing it out either)?  If it works then I (and I'm
sure others who've experienced the same problem) would like to see the
changes applied to the next 2.4.x (and 2.6.x?) release.

Thanks a lot.

Alex

--- fs/reiserfs/namei.c.orig    Mon Aug 25 06:44:43 2003
+++ fs/reiserfs/namei.c Sun Oct 12 00:39:05 2003
@@ -1207,6 +1207,8 @@
     journal_mark_dirty (&th, old_dir->i_sb, old_de.de_bh);
     old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
     new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
+    old_inode->i_ctime = CURRENT_TIME;
+    reiserfs_update_sd (&th, old_inode);

     if (new_dentry_inode) {
        // adjust link number of the victim

