Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274990AbTHFJjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274989AbTHFJjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:39:19 -0400
Received: from angband.namesys.com ([212.16.7.85]:57258 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S274990AbTHFJjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:39:00 -0400
Date: Wed, 6 Aug 2003 13:38:58 +0400
From: Oleg Drokin <green@namesys.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6] reiserfs: fix locking in reiserfs_remount
Message-ID: <20030806093858.GF14457@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    Since reiserfs_remount can be called without BKL held, we better take BKL in there.
    Please apply the below patch. It is against 2.6.0-test2

Bye,
    Oleg

===== fs/reiserfs/super.c 1.66 vs edited =====
--- 1.66/fs/reiserfs/super.c	Sat Jun 21 00:16:06 2003
+++ edited/fs/reiserfs/super.c	Tue Aug  5 12:22:10 2003
@@ -761,6 +761,7 @@
   if (!reiserfs_parse_options(s, arg, &mount_options, &blocks, NULL))
     return -EINVAL;
   
+  reiserfs_write_lock(s);
   handle_attrs(s);
 
   /* Add options that are safe here */
@@ -778,17 +779,22 @@
 
   if(blocks) {
     int rc = reiserfs_resize(s, blocks);
-    if (rc != 0)
+    if (rc != 0) {
+      reiserfs_write_unlock(s);
       return rc;
+    }
   }
 
   if (*mount_flags & MS_RDONLY) {
     /* remount read-only */
-    if (s->s_flags & MS_RDONLY)
+    if (s->s_flags & MS_RDONLY) {
       /* it is read-only already */
+      reiserfs_write_unlock(s);
       return 0;
+    }
     /* try to remount file system with read-only permissions */
     if (sb_umount_state(rs) == REISERFS_VALID_FS || REISERFS_SB(s)->s_mount_state != REISERFS_VALID_FS) {
+      reiserfs_write_unlock(s);
       return 0;
     }
 
@@ -800,8 +806,10 @@
     s->s_dirt = 0;
   } else {
     /* remount read-write */
-    if (!(s->s_flags & MS_RDONLY))
+    if (!(s->s_flags & MS_RDONLY)) {
+        reiserfs_write_unlock(s);
 	return 0; /* We are read-write already */
+    }
 
     REISERFS_SB(s)->s_mount_state = sb_umount_state(rs) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
@@ -824,6 +832,7 @@
   if (!( *mount_flags & MS_RDONLY ) )
     finish_unfinished( s );
 
+  reiserfs_write_unlock(s);
   return 0;
 }
 
