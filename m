Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUELQxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUELQxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUELQxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:53:45 -0400
Received: from linuxhacker.ru ([217.76.32.60]:13012 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265129AbUELQx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:53:26 -0400
Date: Wed, 12 May 2004 19:53:27 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org, mason@suse.com,
       reiserfs-dev@namesys.com
Subject: [PATCH] [2.4] Make reiserfs not to crash on oom during mount
Message-ID: <20040512165327.GA73000@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Thanks to Stanford guys, a case where reiserfs would try to dereference
   NULL pointer if memory allocation fail during mount process was
   identified.

   The patch is below.

Bye,
    Oleg

===== fs/reiserfs/journal.c 1.31 vs edited =====
--- 1.31/fs/reiserfs/journal.c	Tue Jun 24 10:30:22 2003
+++ edited/fs/reiserfs/journal.c	Wed May 12 19:40:48 2004
@@ -198,6 +198,9 @@
 static void cleanup_bitmap_list(struct super_block *p_s_sb,
                                 struct reiserfs_list_bitmap *jb) {
   int i;
+  if (jb->bitmaps == NULL)
+	return ;
+
   for (i = 0 ; i < SB_BMAP_NR(p_s_sb) ; i++) {
     if (jb->bitmaps[i]) {
       free_bitmap_node(p_s_sb, jb->bitmaps[i]) ;
@@ -2064,8 +2067,11 @@
     INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
     INIT_LIST_HEAD (&SB_JOURNAL(p_s_sb)->j_prealloc_list);
 
-    reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
-				   SB_BMAP_NR(p_s_sb)) ;
+    if (reiserfs_allocate_list_bitmaps(p_s_sb,
+				       SB_JOURNAL(p_s_sb)->j_list_bitmap, 
+				       SB_BMAP_NR(p_s_sb)))
+	goto free_and_return ;
+
     allocate_bitmap_nodes(p_s_sb) ;
 
     /* reserved for journal area support */
