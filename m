Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUBLVAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUBLVAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:00:38 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:52542 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id S266595AbUBLU5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:57:13 -0500
Date: Thu, 12 Feb 2004 14:57:12 -0600
From: shaggy@austin.ibm.com
Message-Id: <200402122057.i1CKvC8P006270@kleikamp.dyn.webahead.ibm.com>
To: akpm@osdl.org
Subject: [PATCH] JFS: sane file name handling (2 of 2)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/12 09:23:55-06:00 shaggy@austin.ibm.com 
#   JFS: Don't do filename translation by default
#   
#   Due to its roots in OS/2, JFS has always tried to convert pathnames
#   into unicode.  Unfortunately, it never had a reliable idea of what
#   the incoming character set was, so it defaulted to CONFIG_NLS_DEFAULT.
#   
#   This behavior was confusing and many users have requested that JFS
#   have a more sane behavior.   This patch changes the default behavior
#   to store the incoming bytes directly without translation.  This is
#   consistent with the behavior when the default value of
#   CONFIG_NLS_DEFAULT (iso8859-1) was defined.  The default behavior
#   can be overridden by using the iocharset mount option.
# 
diff -Nru a/Documentation/filesystems/jfs.txt b/Documentation/filesystems/jfs.txt
--- a/Documentation/filesystems/jfs.txt	Thu Feb 12 14:43:38 2004
+++ b/Documentation/filesystems/jfs.txt	Thu Feb 12 14:43:38 2004
@@ -12,10 +12,9 @@
 The following mount options are supported:
 
 iocharset=name	Character set to use for converting from Unicode to
-		ASCII.  The default is compiled into the kernel as
-		CONFIG_NLS_DEFAULT.  Use iocharset=utf8 for UTF8
-		translations.  This requires CONFIG_NLS_UTF8 to be set
-		in the kernel .config file.
+		ASCII.  The default is to do no conversion.  Use
+		iocharset=utf8 for UTF8 translations.  This requires
+		CONFIG_NLS_UTF8 to be set in the kernel .config file.
 
 resize=value	Resize the volume to <value> blocks.  JFS only supports
 		growing a volume, not shrinking it.  This option is only
@@ -35,18 +34,6 @@
 errors=continue		Keep going on a filesystem error.
 errors=remount-ro	Default. Remount the filesystem read-only on an error.
 errors=panic		Panic and halt the machine if an error occurs.
-
-JFS TODO list:
-
-Plans for our near term development items
-
-   - enhance support for logfile on dedicated partition
-
-Longer term work items
-
-   - implement defrag utility, for online defragmenting
-   - add quota support
-   - add support for block sizes (512,1024,2048)
 
 Please send bugs, comments, cards and letters to shaggy@austin.ibm.com.
 
diff -Nru a/fs/jfs/jfs_unicode.c b/fs/jfs/jfs_unicode.c
--- a/fs/jfs/jfs_unicode.c	Thu Feb 12 14:43:38 2004
+++ b/fs/jfs/jfs_unicode.c	Thu Feb 12 14:43:38 2004
@@ -1,5 +1,5 @@
 /*
- *   Copyright (c) International Business Machines Corp., 2000-2002
+ *   Copyright (C) International Business Machines Corp., 2000-2004
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -35,16 +35,22 @@
 	int i;
 	int outlen = 0;
 
-	for (i = 0; (i < len) && from[i]; i++) {
-		int charlen;
-		charlen =
-		    codepage->uni2char(le16_to_cpu(from[i]), &to[outlen],
-				       NLS_MAX_CHARSET_SIZE);
-		if (charlen > 0) {
-			outlen += charlen;
-		} else {
-			to[outlen++] = '?';
+	if (codepage) {
+		for (i = 0; (i < len) && from[i]; i++) {
+			int charlen;
+			charlen =
+			    codepage->uni2char(le16_to_cpu(from[i]),
+					       &to[outlen],
+					       NLS_MAX_CHARSET_SIZE);
+			if (charlen > 0)
+				outlen += charlen;
+			else
+				to[outlen++] = '?';
 		}
+	} else {
+		for (i = 0; (i < len) && from[i]; i++)
+			to[i] = (char) (le16_to_cpu(from[i]));
+		outlen = i;
 	}
 	to[outlen] = 0;
 	return outlen;
@@ -62,14 +68,22 @@
 	int charlen;
 	int i;
 
-	for (i = 0; len && *from; i++, from += charlen, len -= charlen) {
-		charlen = codepage->char2uni(from, len, &to[i]);
-		if (charlen < 1) {
-			jfs_err("jfs_strtoUCS: char2uni returned %d.", charlen);
-			jfs_err("charset = %s, char = 0x%x",
-				codepage->charset, (unsigned char) *from);
-			return charlen;
+	if (codepage) {
+		for (i = 0; len && *from; i++, from += charlen, len -= charlen)
+		{
+			charlen = codepage->char2uni(from, len, &to[i]);
+			if (charlen < 1) {
+				jfs_err("jfs_strtoUCS: char2uni returned %d.",
+					charlen);
+				jfs_err("charset = %s, char = 0x%x",
+					codepage->charset,
+					(unsigned char) *from);
+				return charlen;
+			}
 		}
+	} else {
+		for (i = 0; (i < len) && from[i]; i++)
+			to[i] = (wchar_t) from[i];
 	}
 
 	to[i] = 0;
diff -Nru a/fs/jfs/super.c b/fs/jfs/super.c
--- a/fs/jfs/super.c	Thu Feb 12 14:43:38 2004
+++ b/fs/jfs/super.c	Thu Feb 12 14:43:38 2004
@@ -195,7 +195,8 @@
 	rc = jfs_umount(sb);
 	if (rc)
 		jfs_err("jfs_umount failed with return code %d", rc);
-	unload_nls(sbi->nls_tab);
+	if (sbi->nls_tab)
+		unload_nls(sbi->nls_tab);
 	sbi->nls_tab = NULL;
 
 	kfree(sbi);
@@ -434,9 +435,6 @@
 	sb->s_root = d_alloc_root(inode);
 	if (!sb->s_root)
 		goto out_no_root;
-
-	if (!sbi->nls_tab)
-		sbi->nls_tab = load_nls_default();
 
 	/* logical blocks are represented by 40 bits in pxd_t, etc. */
 	sb->s_maxbytes = ((u64) sb->s_blocksize) << 40;
