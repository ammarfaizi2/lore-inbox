Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTJYOnE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 10:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTJYOnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 10:43:04 -0400
Received: from adsl-68-90-157-172.dsl.okcyok.swbell.net ([68.90.157.172]:3201
	"HELO homer.d-oh.org") by vger.kernel.org with SMTP id S262198AbTJYOnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 10:43:01 -0400
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: "Hans Reiser" <reiser@namesys.com>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@zip.com.au>,
       <vs@thebsh.namesys.com>, "jw schultz" <jw@pegasys.ws>,
       "Anton Ertl" <anton@mips.complang.tuwien.ac.at>
Subject: RE: ReiserFS patch for updating ctimes of renamed files
Date: Sat, 25 Oct 2003 09:42:58 -0500
Message-ID: <JIEIIHMANOCFHDAAHBHOAENFDAAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3F8BB699.3070404@namesys.com>
Importance: Normal
x-mimeole: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

I updated my patch to include Andrew's suggestion of eliminating extra calls
to CURRENT_TIME.  I also finally got a chance to test it out, and it seems
to work.  After applying this patch, ctime gets updated after a rename, and
GNU tar now backs things up properly.  I also could not detect any
filesystem corruption after doing some renames.

Alex

--- fs/reiserfs/namei.c.orig    Mon Aug 25 06:44:43 2003
+++ fs/reiserfs/namei.c Fri Oct 24 17:16:33 2003
@@ -1205,8 +1205,11 @@

     mark_de_hidden (old_de.de_deh + old_de.de_entry_num);
     journal_mark_dirty (&th, old_dir->i_sb, old_de.de_bh);
-    old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
-    new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
+    ctime = CURRENT_TIME;
+    old_dir->i_ctime = old_dir->i_mtime = ctime;
+    new_dir->i_ctime = new_dir->i_mtime = ctime;
+    old_inode->i_ctime = ctime;
+    reiserfs_update_sd (&th, old_inode);

     if (new_dentry_inode) {
        // adjust link number of the victim
@@ -1215,7 +1218,6 @@
        } else {
            new_dentry_inode->i_nlink--;
        }
-       ctime = CURRENT_TIME;
        new_dentry_inode->i_ctime = ctime;
        savelink = new_dentry_inode->i_nlink;
     }

