Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVCTG4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVCTG4m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 01:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVCTG4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 01:56:42 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:647 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262030AbVCTG4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 01:56:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=PY1BIpYfU+eb434FsfJIWeJ7Cur9klnW4yIJFusqfmEx7yJnNOPes6ulh8KFAlF/GurKo/t07hRj8UvfSjc8kMmd/2D/V00zhPhCZ0/v27ffNUE3C0CUlFihy06sik/rqe0QYJXM/PbScCbLKB+zH0YlCIB3RXrYQHDXdteG6Qc=
Message-ID: <df35dfeb05031922561284add0@mail.gmail.com>
Date: Sat, 19 Mar 2005 22:56:37 -0800
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Error in ERR_PTR usage
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was trying to understand ERR_PTR and friends and surprisingly the
first 2 references via LXR seem to be erroneous. Did grep and found 1
additional incorrect reference "return ERR_PTR(0)" and another
"ERR_PTR(PTR_ERR(p))" usage. Please let me know if this patch is good.
If need be, I can chop it up for the individual maintainers, but it
would be nice if someone can comment first.

Thanks,
Rayan

Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

diff -Nur linux-2.6.11.5.orig/drivers/video/backlight/backlight.c
linux-2.6.11.5/drivers/video/backlight/backlight.c
--- linux-2.6.11.5.orig/drivers/video/backlight/backlight.c	2005-03-18
22:34:50.000000000 -0800
+++ linux-2.6.11.5/drivers/video/backlight/backlight.c	2005-03-19
22:21:45.058128838 -0800
@@ -174,7 +174,7 @@
 
 	new_bd = kmalloc(sizeof(struct backlight_device), GFP_KERNEL);
 	if (unlikely(!new_bd))
-		return ERR_PTR(ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
 	init_MUTEX(&new_bd->sem);
 	new_bd->props = bp;
diff -Nur linux-2.6.11.5.orig/drivers/video/backlight/lcd.c
linux-2.6.11.5/drivers/video/backlight/lcd.c
--- linux-2.6.11.5.orig/drivers/video/backlight/lcd.c	2005-03-18
22:35:04.000000000 -0800
+++ linux-2.6.11.5/drivers/video/backlight/lcd.c	2005-03-19
22:22:02.923823575 -0800
@@ -173,7 +173,7 @@
 
 	new_ld = kmalloc(sizeof(struct lcd_device), GFP_KERNEL);
 	if (unlikely(!new_ld))
-		return ERR_PTR(ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
 	init_MUTEX(&new_ld->sem);
 	new_ld->props = lp;
diff -Nur linux-2.6.11.5.orig/fs/jfs/namei.c linux-2.6.11.5/fs/jfs/namei.c
--- linux-2.6.11.5.orig/fs/jfs/namei.c	2005-03-18 22:35:07.000000000 -0800
+++ linux-2.6.11.5/fs/jfs/namei.c	2005-03-19 22:26:52.156692285 -0800
@@ -1420,7 +1420,7 @@
 		free_UCSname(&key);
 		if (rc == -ENOENT) {
 			d_add(dentry, NULL);
-			return ERR_PTR(0);
+			return ERR_PTR(-ENOENT);
 		} else if (rc) {
 			jfs_err("jfs_lookup: dtSearch returned %d", rc);
 			return ERR_PTR(rc);
diff -Nur linux-2.6.11.5.orig/fs/reiserfs/xattr.c
linux-2.6.11.5/fs/reiserfs/xattr.c
--- linux-2.6.11.5.orig/fs/reiserfs/xattr.c	2005-03-18 22:35:04.000000000 -0800
+++ linux-2.6.11.5/fs/reiserfs/xattr.c	2005-03-19 22:26:13.997480188 -0800
@@ -200,7 +200,7 @@
 
     xadir = open_xa_dir (inode, flags);
     if (IS_ERR (xadir)) {
-        return ERR_PTR (PTR_ERR (xadir));
+        return xadir;
     } else if (xadir && !xadir->d_inode) {
         dput (xadir);
         return ERR_PTR (-ENODATA);
@@ -209,7 +209,7 @@
     xafile = lookup_one_len (name, xadir, strlen (name));
     if (IS_ERR (xafile)) {
         dput (xadir);
-        return ERR_PTR (PTR_ERR (xafile));
+        return xafile;
     }
 
     if (xafile->d_inode) { /* file exists */
@@ -251,7 +251,7 @@
 
     xafile = get_xa_file_dentry (inode, name, flags);
     if (IS_ERR (xafile))
-        return ERR_PTR (PTR_ERR (xafile));
+        return xafile;
     else if (!xafile->d_inode) {
         dput (xafile);
         return ERR_PTR (-ENODATA);
