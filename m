Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbUKIBis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUKIBis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbUKIBir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:38:47 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:22237 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261329AbUKIBf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:35:28 -0500
Date: Tue, 9 Nov 2004 02:35:24 +0100
From: lsr@neapel230.server4you.de
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Move check for invalid chars to vfat_valid_longname()
Message-ID: <20041109013524.GB6835@neapel230.server4you.de>
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the check for invalid characters into
vfat_valid_longname(), i.e. before the filename is converted to Unicode. 
Benefits: It's simpler to check the non-Unicode string and now all
checks are done in one place. Note: we don't need to check for / (slash)
as this is already done by VFS.

--- ./fs/vfat/namei.c.orig	2004-11-08 18:35:52.000000000 +0100
+++ ./fs/vfat/namei.c	2004-11-08 18:37:06.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <linux/namei.h>
+#include <linux/string.h>
 
 static int vfat_hashi(struct dentry *parent, struct qstr *qstr);
 static int vfat_hash(struct dentry *parent, struct qstr *qstr);
@@ -158,14 +159,6 @@ static int vfat_cmp(struct dentry *dentr
 
 /* Characters that are undesirable in an MS-DOS file name */
 
-static wchar_t bad_chars[] = {
-	/*  `*'     `?'     `<'    `>'      `|'     `"'     `:'     `/' */
-	0x002A, 0x003F, 0x003C, 0x003E, 0x007C, 0x0022, 0x003A, 0x002F,
-	/*  `\' */
-	0x005C, 0,
-};
-#define IS_BADCHAR(uni)	(vfat_unistrchr(bad_chars, (uni)) != NULL)
-
 static wchar_t replace_chars[] = {
 	/*  `['     `]'    `;'     `,'     `+'      `=' */
 	0x005B, 0x005D, 0x003B, 0x002C, 0x002B, 0x003D, 0,
@@ -187,18 +180,10 @@ static inline wchar_t *vfat_unistrchr(co
 	return (wchar_t *) s;
 }
 
-static inline int vfat_is_used_badchars(const wchar_t *s, int len)
-{
-	int i;
-	
-	for (i = 0; i < len; i++)
-		if (s[i] < 0x0020 || IS_BADCHAR(s[i]))
-			return -EINVAL;
-	return 0;
-}
-
 static int vfat_valid_longname(const unsigned char *name, unsigned int len)
 {
+	const unsigned char *p;
+
 	if (len && name[len-1] == ' ')
 		return 0;
 	if (len >= 256)
@@ -221,6 +206,12 @@ static int vfat_valid_longname(const uns
 		}
 	}
 
+	/* check for invalid characters */
+	for (p = name; p < name + len; p++) {
+		if (*p < 0x0020 || strchr("*?<>|\":\\", *p) != NULL)
+			return 0;
+	}
+
 	return 1;
 }
 
@@ -636,10 +627,6 @@ static int vfat_build_slots(struct inode
 	if (res < 0)
 		goto out_free;
 
-	res = vfat_is_used_badchars(uname, ulen);
-	if (res < 0)
-		goto out_free;
-
 	res = vfat_create_shortname(dir, sbi->nls_disk, uname, ulen,
 				    msdos_name, &lcase);
 	if (res < 0)
