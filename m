Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUDWT4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUDWT4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUDWT4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:56:00 -0400
Received: from ns.suse.de ([195.135.220.2]:9120 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261205AbUDWTz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:55:57 -0400
Subject: [PATCH] 1/1 reiserfs: ignore prepared and locked buffers
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1082750262.12989.204.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 15:57:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mason@suse.com

block_write_full_page might see and lock clean metadata buffers, which leads
to bogus vs-12339 messages.  Change the message to ignore bh locked.

Index: linux.mm/fs/reiserfs/do_balan.c
===================================================================
--- linux.mm.orig/fs/reiserfs/do_balan.c	2004-04-23 14:08:22.436537699 -0400
+++ linux.mm/fs/reiserfs/do_balan.c	2004-04-23 14:09:05.089418397 -0400
@@ -1343,7 +1343,8 @@ static void check_internal_node (struct 
 
 static int locked_or_not_in_tree (struct buffer_head * bh, char * which)
 {
-  if ( buffer_locked (bh) || !B_IS_IN_TREE (bh) ) {
+  if ( (!reiserfs_buffer_prepared(bh) && buffer_locked (bh)) || 
+        !B_IS_IN_TREE (bh) ) {
     reiserfs_warning ("vs-12339: locked_or_not_in_tree: %s (%b)\n", which, bh);
     return 1;
   } 


