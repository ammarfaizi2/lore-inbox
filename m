Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264384AbUEMScs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUEMScs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUEMScs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:32:48 -0400
Received: from village.ehouse.ru ([193.111.92.18]:528 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264384AbUEMScK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:32:10 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] befs (5/5): debugging code cleanup
Date: Thu, 13 May 2004 22:30:37 +0400
User-Agent: KMail/1.6.1
Cc: Will Dyson <will_dyson@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <E1BOL04-0003ou-00@mail.ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Reduce stack usage.
- Kill useless duplication of error and warning messages when debug is on. Old
	behaviour was:
...
BeFS(hda1): ---> befs_fill_super()
BeFS(hda1): No write support. Marking filesystem read-only
BeFS(hda1): No write support. Marking filesystem read-only
...

===== fs/befs/debug.c 1.2 vs edited =====
--- 1.2/fs/befs/debug.c	Thu Mar 20 21:47:37 2003
+++ edited/fs/befs/debug.c	Thu May 13 20:58:26 2004
@@ -29,22 +29,29 @@
 befs_error(const struct super_block *sb, const char *fmt, ...)
 {
 	va_list args;
-	char err_buf[ERRBUFSIZE];
-
+	char *err_buf = (char *) kmalloc(ERRBUFSIZE, GFP_KERNEL);
+	if (err_buf == NULL) {
+		printk(KERN_ERR "could not allocate %d bytes\n", ERRBUFSIZE);
+		return;
+	}
+		
 	va_start(args, fmt);
 	vsnprintf(err_buf, ERRBUFSIZE, fmt, args);
 	va_end(args);
 
 	printk(KERN_ERR "BeFS(%s): %s\n", sb->s_id, err_buf);
-
-	befs_debug(sb, err_buf);
+	kfree(err_buf);
 }
 
 void
 befs_warning(const struct super_block *sb, const char *fmt, ...)
 {
 	va_list args;
-	char err_buf[ERRBUFSIZE];
+	char *err_buf = (char *) kmalloc(ERRBUFSIZE, GFP_KERNEL);
+	if (err_buf == NULL) {
+		printk(KERN_ERR "could not allocate %d bytes\n", ERRBUFSIZE);
+		return;
+	}
 
 	va_start(args, fmt);
 	vsnprintf(err_buf, ERRBUFSIZE, fmt, args);
@@ -52,7 +59,7 @@
 
 	printk(KERN_WARNING "BeFS(%s): %s\n", sb->s_id, err_buf);
 
-	befs_debug(sb, err_buf);
+	kfree(err_buf);
 }
 
 void
@@ -61,15 +68,25 @@
 #ifdef CONFIG_BEFS_DEBUG
 
 	va_list args;
-	char err_buf[ERRBUFSIZE];
+	char *err_buf = NULL;
 
 	if (BEFS_SB(sb)->mount_opts.debug) {
+		err_buf = (char *) kmalloc(ERRBUFSIZE, GFP_KERNEL);
+		if (err_buf == NULL) {
+			printk(KERN_ERR "could not allocate %d bytes\n",
+				ERRBUFSIZE);
+			return;
+		}
+
 		va_start(args, fmt);
 		vsnprintf(err_buf, ERRBUFSIZE, fmt, args);
 		va_end(args);
 
 		printk(KERN_DEBUG "BeFS(%s): %s\n", sb->s_id, err_buf);
+
+		kfree(err_buf);
 	}
+
 #endif				//CONFIG_BEFS_DEBUG
 }
 

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc

