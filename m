Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbVKXGIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVKXGIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 01:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbVKXGIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 01:08:23 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:4978 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161012AbVKXGIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 01:08:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=GOkUQUR/X7Fb4aiCGaS45pgjoCWCEVDsB2pclkCoe9qezsLLdyHu93iNnwuBN0TP7mww5SsFREEeOukAKHfoLeTVpe6Vdqu4C2EbcAF2F3XKDxyRw7jVrOyEcjlLpWrtgMWlhJYE+Mm5O41z9Kvt0hognq37J0tpSQnPKJyFO8k=
Message-ID: <656113ee0511232208n6948c364ke6103b3ef0a54f@mail.gmail.com>
Date: Wed, 23 Nov 2005 22:08:22 -0800
From: Nathan Cline <nathan.cline@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Patch to framebuffer
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10076_8767321.1132812502629"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_10076_8767321.1132812502629
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello, this is my first time posting to this list so please forgive me
if I'm violating protocol in some way. :)  I've written a patch to the
framebuffer code to modify its behavior a bit. I am running on a
dual-headed system and I noticed when I was working in one console on
one monitor, the console on the other monitor was "frozen", not
updating itself. After some digging through the code I realized this
is because the two framebuffer drivers share the same framebuffer code
which stores a single pointer to the "current" virtual console. If a
VC is not current it is considered invisible and is not updated. So I
patched the code to store a pointer for each framebuffer to the
"foreground" VC on each one. It seems to work well but I'd like to get
others' input as this is my first time writing any kernel code, and to
be honest there is so much code it's difficult to get a clear picture
in my head of how the whole system works.
I've attached the patches to this message, a small one to
drivers/video/console/fbcon.h, and a larger one to fbcon.c. I would
appreciate it if some of you guys could look over this code and look
for any obvious errors, or better yet, hopefully someone else has a
multihead system they can try it on. The patches are against the
latest GIT source tree (torvalds, main branch, 2.6.15rc2) as of last
night.
Any replies to this message should be CC'ed directly to my e-mail
account (nathan dot cline .. gmail dot com) as I am not currently
subscribed to this list. I look forward to getting this patch of high
enough quality to submit to Linus. Thanks!

------=_Part_10076_8767321.1132812502629
Content-Type: text/plain; name=fbcon.c.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fbcon.c.patch"

--- fbcon.c	2005-11-23 23:49:10.000000000 -0600
+++ fbcon.c.mine	2005-11-23 23:12:16.000000000 -0600
@@ -390,12 +390,15 @@
 	int mode;
 
 	if (ops->currcon != -1)
-		vc = vc_cons[ops->currcon].d;
+		vc = ops->currcon_ptr; 
 
-	if (!vc || !CON_IS_VISIBLE(vc) ||
+	if (!vc)
+		return;
+
+	if (!CON_IS_VISIBLE(vc) ||
 	    fbcon_is_inactive(vc, info) ||
  	    registered_fb[con2fb_map[vc->vc_num]] != info ||
-	    vc_cons[ops->currcon].d->vc_deccm != 1)
+	    vc->vc_deccm != 1)
 		return;
 	acquire_console_sem();
 	p = &fb_display[vc->vc_num];
@@ -753,6 +756,7 @@
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	ops->currcon = fg_console;
+	ops->currcon_ptr = vc_cons[fg_console].d;
 
 	if (info->fbops->fb_set_par && !(ops->flags & FBCON_FLAGS_INIT))
 		info->fbops->fb_set_par(info);
@@ -766,7 +770,7 @@
 		fbcon_preset_disp(info, &info->var, unit);
 
 	if (show_logo) {
-		struct vc_data *fg_vc = vc_cons[fg_console].d;
+		struct vc_data *fg_vc = ops->currcon_ptr;
 		struct fb_info *fg_info =
 			registered_fb[con2fb_map[fg_console]];
 
@@ -775,7 +779,7 @@
 				   fg_vc->vc_rows);
 	}
 
-	update_screen(vc_cons[fg_console].d);
+	update_screen(ops->currcon_ptr);
 }
 
 /**
@@ -929,6 +933,7 @@
 
 	memset(ops, 0, sizeof(struct fbcon_ops));
 	ops->currcon = -1;
+	ops->currcon_ptr = NULL;
 	ops->graphics = 1;
 	ops->cur_rotate = -1;
 	info->fbcon_par = ops;
@@ -1055,6 +1060,15 @@
 	    return;
 
 	cap = info->flags;
+	ops = info->fbcon_par;
+
+	if (ops->currcon == -1)
+	{
+		ops->currcon = vc->vc_num;
+		ops->currcon_ptr = vc;
+	}
+
+	vc->vc_display_fg = &(ops->currcon_ptr);
 
 	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
 	    (info->fix.type == FB_TYPE_TEXT))
@@ -1091,7 +1105,6 @@
 	if (!*vc->vc_uni_pagedir_loc)
 		con_copy_unimap(vc, svc);
 
-	ops = info->fbcon_par;
 	p->con_rotate = rotate;
 	set_blitting_type(vc, info, NULL);
 
@@ -1296,6 +1309,8 @@
 	struct fbcon_ops *ops = info->fbcon_par;
 	int rows, cols, charcnt = 256;
 
+	vc->vc_display_fg = &(ops->currcon_ptr);
+	
 	if (var_to_display(p, var, info))
 		return;
 	t = &fb_display[svc->vc_num];
@@ -2048,7 +2063,7 @@
 	struct fbcon_ops *ops;
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
-	int i, prev_console;
+	int prev_console;
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
 	ops = info->fbcon_par;
@@ -2073,21 +2088,10 @@
 	prev_console = ops->currcon;
 	if (prev_console != -1)
 		old_info = registered_fb[con2fb_map[prev_console]];
-	/*
-	 * FIXME: If we have multiple fbdev's loaded, we need to
-	 * update all info->currcon.  Perhaps, we can place this
-	 * in a centralized structure, but this might break some
-	 * drivers.
-	 *
-	 * info->currcon = vc->vc_num;
-	 */
-	for (i = 0; i < FB_MAX; i++) {
-		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
-			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
 
-			o->currcon = vc->vc_num;
-		}
-	}
+	ops->currcon = vc->vc_num;
+	ops->currcon_ptr = vc;
+	
 	memset(&var, 0, sizeof(struct fb_var_screeninfo));
 	display_to_var(&var, p);
 	var.activate = FB_ACTIVATE_NOW;
@@ -2103,13 +2107,6 @@
 	fb_set_var(info, &var);
 	ops->var = info->var;
 
-	if (old_info != NULL && old_info != info) {
-		if (info->fbops->fb_set_par)
-			info->fbops->fb_set_par(info);
-		fbcon_del_cursor_timer(old_info);
-		fbcon_add_cursor_timer(info);
-	}
-
 	set_blitting_type(vc, info, p);
 	ops->cursor_reset = 1;
 
@@ -2691,7 +2688,7 @@
 
 	if (!ops || ops->currcon < 0)
 		return;
-	vc = vc_cons[ops->currcon].d;
+	vc = ops->currcon_ptr;
 
 	/* Clear cursor, restore saved data */
 	fbcon_cursor(vc, CM_ERASE);
@@ -2704,7 +2701,7 @@
 
 	if (!ops || ops->currcon < 0)
 		return;
-	vc = vc_cons[ops->currcon].d;
+	vc = ops->currcon_ptr; 
 
 	update_screen(vc);
 }
@@ -2718,7 +2715,7 @@
 
 	if (!ops || ops->currcon < 0)
 		return;
-	vc = vc_cons[ops->currcon].d;
+	vc = ops->currcon_ptr; 
 	if (vc->vc_mode != KD_TEXT ||
 	    registered_fb[con2fb_map[ops->currcon]] != info)
 		return;
@@ -2841,7 +2838,7 @@
 	if (!ops || ops->currcon < 0)
 		return;
 
-	vc = vc_cons[ops->currcon].d;
+	vc = ops->currcon_ptr; 
 	if (vc->vc_mode != KD_TEXT ||
 			registered_fb[con2fb_map[ops->currcon]] != info)
 		return;

------=_Part_10076_8767321.1132812502629
Content-Type: text/plain; name=fbcon.h.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fbcon.h.patch"

--- fbcon.h	2005-11-23 23:49:10.000000000 -0600
+++ fbcon.h.mine	2005-11-23 23:46:07.000000000 -0600
@@ -73,6 +73,7 @@
 	struct fb_cursor cursor_state;
 	struct display *p;
         int    currcon;	                /* Current VC. */
+	struct vc_data *currcon_ptr;
 	int    cursor_flash;
 	int    cursor_reset;
 	int    blank_state;

------=_Part_10076_8767321.1132812502629--
