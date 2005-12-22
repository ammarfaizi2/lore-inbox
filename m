Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVLVExc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVLVExc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVLVExN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:53:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37584 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965098AbVLVEvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:40 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 31/36] m68k: amifb __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQV-0004ti-OL@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011915 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/video/amifb.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

8985aa3a3e05419516a54ae120ffb7149b14647a
diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 8cfba10..2c42a81 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -1166,8 +1166,8 @@ static void ami_update_display(void);
 static void ami_init_display(void);
 static void ami_do_blank(void);
 static int ami_get_fix_cursorinfo(struct fb_fix_cursorinfo *fix);
-static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data);
-static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data);
+static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char __user *data);
+static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char __user *data);
 static int ami_get_cursorstate(struct fb_cursorstate *state);
 static int ami_set_cursorstate(struct fb_cursorstate *state);
 static void ami_set_sprite(void);
@@ -2181,6 +2181,7 @@ static int amifb_ioctl(struct inode *ino
 		struct fb_var_cursorinfo var;
 		struct fb_cursorstate state;
 	} crsr;
+	void __user *argp = (void __user *)arg;
 	int i;
 
 	switch (cmd) {
@@ -2188,33 +2189,32 @@ static int amifb_ioctl(struct inode *ino
 			i = ami_get_fix_cursorinfo(&crsr.fix);
 			if (i)
 				return i;
-			return copy_to_user((void *)arg, &crsr.fix,
+			return copy_to_user(argp, &crsr.fix,
 					    sizeof(crsr.fix)) ? -EFAULT : 0;
 
 		case FBIOGET_VCURSORINFO:
 			i = ami_get_var_cursorinfo(&crsr.var,
-				((struct fb_var_cursorinfo *)arg)->data);
+				((struct fb_var_cursorinfo __user *)arg)->data);
 			if (i)
 				return i;
-			return copy_to_user((void *)arg, &crsr.var,
+			return copy_to_user(argp, &crsr.var,
 					    sizeof(crsr.var)) ? -EFAULT : 0;
 
 		case FBIOPUT_VCURSORINFO:
-			if (copy_from_user(&crsr.var, (void *)arg,
-					   sizeof(crsr.var)))
+			if (copy_from_user(&crsr.var, argp, sizeof(crsr.var)))
 				return -EFAULT;
 			return ami_set_var_cursorinfo(&crsr.var,
-				((struct fb_var_cursorinfo *)arg)->data);
+				((struct fb_var_cursorinfo __user *)arg)->data);
 
 		case FBIOGET_CURSORSTATE:
 			i = ami_get_cursorstate(&crsr.state);
 			if (i)
 				return i;
-			return copy_to_user((void *)arg, &crsr.state,
+			return copy_to_user(argp, &crsr.state,
 					    sizeof(crsr.state)) ? -EFAULT : 0;
 
 		case FBIOPUT_CURSORSTATE:
-			if (copy_from_user(&crsr.state, (void *)arg,
+			if (copy_from_user(&crsr.state, argp,
 					   sizeof(crsr.state)))
 				return -EFAULT;
 			return ami_set_cursorstate(&crsr.state);
@@ -3327,7 +3327,7 @@ static int ami_get_fix_cursorinfo(struct
 	return 0;
 }
 
-static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data)
+static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char __user *data)
 {
 	struct amifb_par *par = &currentpar;
 	register u_short *lspr, *sspr;
@@ -3349,14 +3349,14 @@ static int ami_get_var_cursorinfo(struct
 	var->yspot = par->crsr.spot_y;
 	if (size > var->height*var->width)
 		return -ENAMETOOLONG;
-	if (!access_ok(VERIFY_WRITE, (void *)data, size))
+	if (!access_ok(VERIFY_WRITE, data, size))
 		return -EFAULT;
 	delta = 1<<par->crsr.fmode;
 	lspr = lofsprite + (delta<<1);
 	if (par->bplcon0 & BPC0_LACE)
 		sspr = shfsprite + (delta<<1);
 	else
-		sspr = 0;
+		sspr = NULL;
 	for (height = (short)var->height-1; height >= 0; height--) {
 		bits = 0; words = delta; datawords = 0;
 		for (width = (short)var->width-1; width >= 0; width--) {
@@ -3402,7 +3402,7 @@ static int ami_get_var_cursorinfo(struct
 	return 0;
 }
 
-static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data)
+static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char __user *data)
 {
 	struct amifb_par *par = &currentpar;
 	register u_short *lspr, *sspr;
@@ -3429,7 +3429,7 @@ static int ami_set_var_cursorinfo(struct
 		return -EINVAL;
 	if (!var->height)
 		return -EINVAL;
-	if (!access_ok(VERIFY_READ, (void *)data, var->width*var->height))
+	if (!access_ok(VERIFY_READ, data, var->width*var->height))
 		return -EFAULT;
 	delta = 1<<fmode;
 	lofsprite = shfsprite = (u_short *)spritememory;
@@ -3444,13 +3444,13 @@ static int ami_set_var_cursorinfo(struct
 		if (((var->height+2)<<fmode<<2) > SPRITEMEMSIZE)
 			return -EINVAL;
 		memset(lspr, 0, (var->height+2)<<fmode<<2);
-		sspr = 0;
+		sspr = NULL;
 	}
 	for (height = (short)var->height-1; height >= 0; height--) {
 		bits = 16; words = delta; datawords = 0;
 		for (width = (short)var->width-1; width >= 0; width--) {
 			unsigned long tdata = 0;
-			get_user(tdata, (char *)data);
+			get_user(tdata, data);
 			data++;
 #ifdef __mc68000__
 			asm volatile (
-- 
0.99.9.GIT

