Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267888AbUGaBkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267888AbUGaBkx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 21:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267894AbUGaBkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 21:40:53 -0400
Received: from waste.org ([209.173.204.2]:32131 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267888AbUGaBkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 21:40:19 -0400
Date: Fri, 30 Jul 2004 20:40:15 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] vprintk for ext3 errors
Message-ID: <20040731014015.GY16310@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill error_buf madness in ext3

Signed-off-by: Matt Mackall <mpm@selenic.com>

 tiny-mpm/fs/ext3/super.c |   53 ++++++++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 28 deletions(-)

diff -puN fs/ext3/super.c~kill-ext3-error-buff fs/ext3/super.c
--- tiny/fs/ext3/super.c~kill-ext3-error-buff	2004-03-20 12:14:48.000000000 -0600
+++ tiny-mpm/fs/ext3/super.c	2004-03-20 12:14:48.000000000 -0600
@@ -115,8 +115,6 @@ void ext3_journal_abort_handle(const cha
 		handle->h_err = err;
 }
 
-static char error_buf[1024];
-
 /* Deal with the reporting of failure conditions on a filesystem such as
  * inconsistencies detected or read IO failures.
  *
@@ -163,12 +161,11 @@ void ext3_error (struct super_block * sb
 {
 	va_list args;
 
-	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
-	va_end (args);
-
-	printk (KERN_CRIT "EXT3-fs error (device %s): %s: %s\n",
-		sb->s_id, function, error_buf);
+	va_start(args, fmt);
+	printk(KERN_CRIT "EXT3-fs error (device %s): %s: ",sb->s_id, function);
+	vprintk(fmt, args);
+	printk("\n");
+	va_end(args);
 
 	ext3_handle_error(sb);
 }
@@ -237,21 +234,19 @@ void ext3_abort (struct super_block * sb
 
 	printk (KERN_CRIT "ext3_abort called.\n");
 
-	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
-	va_end (args);
-
-	if (test_opt (sb, ERRORS_PANIC))
-		panic ("EXT3-fs panic (device %s): %s: %s\n",
-		       sb->s_id, function, error_buf);
+	va_start(args, fmt);
+	printk(KERN_CRIT "EXT3-fs error (device %s): %s: ",sb->s_id, function);
+	vprintk(fmt, args);
+	printk("\n");
+	va_end(args);
 
-	printk (KERN_CRIT "EXT3-fs abort (device %s): %s: %s\n",
-		sb->s_id, function, error_buf);
+	if (test_opt(sb, ERRORS_PANIC))
+		panic("EXT3-fs panic from previous error\n");
 
 	if (sb->s_flags & MS_RDONLY)
 		return;
 
-	printk (KERN_CRIT "Remounting filesystem read-only\n");
+	printk(KERN_CRIT "Remounting filesystem read-only\n");
 	EXT3_SB(sb)->s_mount_state |= EXT3_ERROR_FS;
 	sb->s_flags |= MS_RDONLY;
 	EXT3_SB(sb)->s_mount_opt |= EXT3_MOUNT_ABORT;
@@ -269,15 +264,16 @@ NORET_TYPE void ext3_panic (struct super
 {
 	va_list args;
 
-	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
-	va_end (args);
+	va_start(args, fmt);
+	printk(KERN_CRIT "EXT3-fs error (device %s): %s: ",sb->s_id, function);
+	vprintk(fmt, args);
+	printk("\n");
+	va_end(args);
 
 	/* this is to prevent panic from syncing this filesystem */
 	/* AKPM: is this sufficient? */
 	sb->s_flags |= MS_RDONLY;
-	panic ("EXT3-fs panic (device %s): %s: %s\n",
-	       sb->s_id, function, error_buf);
+	panic ("EXT3-fs panic forced\n");
 }
 
 void ext3_warning (struct super_block * sb, const char * function,
@@ -285,11 +281,12 @@ void ext3_warning (struct super_block * 
 {
 	va_list args;
 
-	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
-	va_end (args);
-	printk (KERN_WARNING "EXT3-fs warning (device %s): %s: %s\n",
-		sb->s_id, function, error_buf);
+	va_start(args, fmt);
+	printk(KERN_WARNING "EXT3-fs warning (device %s): %s: ",
+	       sb->s_id, function);
+	vprintk(fmt, args);
+	printk("\n");
+	va_end(args);
 }
 
 void ext3_update_dynamic_rev(struct super_block *sb)

_


-- 
Mathematics is the supreme nostalgia of our time.
