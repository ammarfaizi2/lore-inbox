Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbUAQGQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 01:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbUAQGQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 01:16:38 -0500
Received: from post.tau.ac.il ([132.66.16.11]:1258 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S265579AbUAQGQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 01:16:33 -0500
Date: Sat, 17 Jan 2004 08:13:54 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] reiserfs support for laptop_mode
Message-ID: <20040117061354.GB4768@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.2; VDF: 6.23.0.33; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using this since 2.4.22 and since laptop_mode is in the
kernel since 2.4.23-pre<something> and I haven't seen that anyone else
has implemented this so I decided to post it on the list in case anyone
is interested.
It a patch to modify the journal flush time of reiserfs to support
laptop_mode (same functionality as ext3 has already).
The times are taken from bdflush.

--- kernel-source-2.4.25-pre6/fs/reiserfs/journal.c	2003-08-25 14:44:43.000000000 +0300
+++ kernel-source-2.4.25-pre6.new/fs/reiserfs/journal.c	2003-10-20 03:35:58.000000000 +0200
@@ -58,6 +58,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/fs.h>
 
 /* the number of mounted filesystems.  This is used to decide when to
 ** start and kill the commit thread
@@ -2659,8 +2660,12 @@
   /* starting with oldest, loop until we get to the start */
   i = (SB_JOURNAL_LIST_INDEX(p_s_sb) + 1) % JOURNAL_LIST_COUNT ;
   while(i != start) {
-    if (SB_JOURNAL_LIST(p_s_sb)[i].j_len > 0 && ((now - SB_JOURNAL_LIST(p_s_sb)[i].j_timestamp) > SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) ||
-       immediate)) {
+    /* get_buffer_age() / HZ is used since the time returned by
+     * get_buffer_age is in sec * HZ and the journal time is taken in seconds.
+     */
+    if (SB_JOURNAL_LIST(p_s_sb)[i].j_len > 0 &&
+	((now - SB_JOURNAL_LIST(p_s_sb)[i].j_timestamp) > get_buffer_age() / HZ
+	 || immediate)) {
       /* we have to check again to be sure the current transaction did not change */
       if (i != SB_JOURNAL_LIST_INDEX(p_s_sb))  {
 	flush_commit_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + i, 1) ;
--- kernel-source-2.4.25-pre6/fs/reiserfs/procfs.c	2003-08-25 14:44:43.000000000 +0300
+++ kernel-source-2.4.25-pre6.new/fs/reiserfs/procfs.c	2003-10-20 03:36:11.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/fs.h>
 
 #if defined( REISERFS_PROC_INFO )
 
@@ -528,7 +529,11 @@
                         DJP( jp_journal_trans_max ),
                         DJP( jp_journal_magic ),
                         DJP( jp_journal_max_batch ),
-                        DJP( jp_journal_max_commit_age ),
+			/* get_buffer_age() / HZ is used since the
+			 * time returned by get_buffer_age is in sec * HZ
+			 * and the journal time is in seconds.
+			 */
+                        get_buffer_age()/HZ,
                         DJP( jp_journal_max_trans_age ),
 
  			JF( j_1st_reserved_block ),
--- kernel-source-2.4.25-pre6/fs/buffer.c	2003-12-12 01:35:46.000000000 +0200
+++ kernel-source-2.4.25-pre6.new/fs/buffer.c	2003-12-12 01:41:20.000000000 +0200
@@ -1128,6 +1128,12 @@
 }
 EXPORT_SYMBOL(get_buffer_flushtime);
 
+inline int get_buffer_age(void)
+{
+	return bdf_prm.b_un.age_buffer;
+}
+EXPORT_SYMBOL(get_buffer_age);
+
 /*
  * A buffer may need to be moved from one buffer list to another
  * (e.g. in case it is not shared any more). Handle this.
--- kernel-source-2.4.25-pre6/include/linux/fs.h	2003-12-12 01:45:20.000000000 +0200
+++ kernel-source-2.4.23-5-pre6.new/include/linux/fs.h	2003-12-12 01:45:42.000000000 +0200
@@ -1260,6 +1260,7 @@
 
 extern void set_buffer_flushtime(struct buffer_head *);
 extern inline int get_buffer_flushtime(void);
+extern inline int get_buffer_age(void);
 extern void balance_dirty(void);
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
