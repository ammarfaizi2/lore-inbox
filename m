Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267885AbUGaBij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267885AbUGaBij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 21:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUGaBij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 21:38:39 -0400
Received: from waste.org ([209.173.204.2]:19587 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267888AbUGaBid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 21:38:33 -0400
Date: Fri, 30 Jul 2004 20:38:26 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] vprintk for ext2 errors
Message-ID: <20040731013826.GX16310@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill error_buf madness in ext2

Signed-off-by: Matt Mackall <mpm@selenic.com>

 tiny-mpm/fs/ext2/super.c |   45 +++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff -puN fs/ext2/super.c~kill-ext2-error-buff fs/ext2/super.c
--- tiny/fs/ext2/super.c~kill-ext2-error-buff	2004-03-20 12:14:47.000000000 -0600
+++ tiny-mpm/fs/ext2/super.c	2004-03-20 12:14:47.000000000 -0600
@@ -37,8 +37,6 @@ static void ext2_sync_super(struct super
 static int ext2_remount (struct super_block * sb, int * flags, char * data);
 static int ext2_statfs (struct super_block * sb, struct kstatfs * buf);
 
-static char error_buf[1024];
-
 void ext2_error (struct super_block * sb, const char * function,
 		 const char * fmt, ...)
 {
@@ -52,16 +50,17 @@ void ext2_error (struct super_block * sb
 			cpu_to_le16(le16_to_cpu(es->s_state) | EXT2_ERROR_FS);
 		ext2_sync_super(sb, es);
 	}
-	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
-	va_end (args);
-	if (test_opt (sb, ERRORS_PANIC))
-		panic ("EXT2-fs panic (device %s): %s: %s\n",
-		       sb->s_id, function, error_buf);
-	printk (KERN_CRIT "EXT2-fs error (device %s): %s: %s\n",
-		sb->s_id, function, error_buf);
-	if (test_opt (sb, ERRORS_RO)) {
-		printk ("Remounting filesystem read-only\n");
+
+	va_start(args, fmt);
+	printk(KERN_CRIT "EXT2-fs error (device %s): %s: ",sb->s_id, function);
+	vprintk(fmt, args);
+	printk("\n");
+	va_end(args);
+
+	if (test_opt(sb, ERRORS_PANIC))
+		panic("EXT2-fs panic from previous error\n");
+	if (test_opt(sb, ERRORS_RO)) {
+		printk("Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
 	}
 }
@@ -79,12 +78,13 @@ NORET_TYPE void ext2_panic (struct super
 		mark_buffer_dirty(sbi->s_sbh);
 		sb->s_dirt = 1;
 	}
-	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
-	va_end (args);
+	va_start(args, fmt);
+	printk(KERN_CRIT "EXT2-fs error (device %s): %s: ",sb->s_id, function);
+	vprintk(fmt, args);
+	printk("\n");
+	va_end(args);
 	sb->s_flags |= MS_RDONLY;
-	panic ("EXT2-fs panic (device %s): %s: %s\n",
-	       sb->s_id, function, error_buf);
+	panic("EXT2-fs panic forced\n");
 }
 
 void ext2_warning (struct super_block * sb, const char * function,
@@ -92,11 +92,12 @@ void ext2_warning (struct super_block * 
 {
 	va_list args;
 
-	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
-	va_end (args);
-	printk (KERN_WARNING "EXT2-fs warning (device %s): %s: %s\n",
-		sb->s_id, function, error_buf);
+	va_start(args, fmt);
+	printk(KERN_WARNING "EXT2-fs warning (device %s): %s: ",
+	       sb->s_id, function);
+	vprintk(fmt, args);
+	printk("\n");
+	va_end(args);
 }
 
 void ext2_update_dynamic_rev(struct super_block *sb)

_


-- 
Mathematics is the supreme nostalgia of our time.
