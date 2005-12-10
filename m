Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVLJHTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVLJHTS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbVLJHTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:19:18 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:29389 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932761AbVLJHTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:19:17 -0500
Message-ID: <439A81AE.5030509@t-online.de>
Date: Sat, 10 Dec 2005 08:20:14 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/1 2.6.15-rc4-git1] Fixing switch to KD_TEXT, enhanced version
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: GlWI1sZpZedfy1CKSKzt14GGCfNjQSlWhsg8LbwwexqDH9TFbrZL4U@t-dialin.net
X-TOI-MSGID: 0050e024-6f82-4c7d-bb82-46cac15712c6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every framebuffer driver relies on the assumption that the
set_par() function of the driver is called before drawing
functions and other functions dependent on the hardware
state are executed.

Whenever you switch from X to a framebuffer console for the
very first time, there is a chance that a broken X system has
_not_ set the mode to KD_GRAPHICS, thus the vt and framebuffer
code executes a screen redraw and several other functions
before a set_par() is executed. This is believed to be not a
bug of linux but a bug of X/xdm. At least some X releases
used by SuSE and Debian show this behaviour.

There was a 2nd case, but that has been fixed by Antonino
Daplas on 10-dec-2005.

This patch allows drivers to set a flag to inform fbcon_switch()
that they prefer a set_par() call on every console switch,
working around the problems caused by the broken X releases.

The flag will be used by the next release of cyblafb and might
help other drivers that assume a hardware state different to
the one used by X.

As the default behaviour does not change, this patch should
be acceptable to everybody.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>


diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linuxorig/drivers/video/console/fbcon.c	2005-12-02 12:18:04.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2005-12-10 06:51:30.000000000 +0100
@@ -2103,7 +2103,8 @@ static int fbcon_switch(struct vc_data *
  	fb_set_var(info, &var);
  	ops->var = info->var;

-	if (old_info != NULL && old_info != info) {
+	if (old_info != NULL && (old_info != info ||
+				 info->flags & FBINFO_MISC_ALLWAYS_SETPAR)) {
  		if (info->fbops->fb_set_par)
  			info->fbops->fb_set_par(info);
  		fbcon_del_cursor_timer(old_info);
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/include/linux/fb.h linux/include/linux/fb.h
--- linuxorig/include/linux/fb.h	2005-12-02 12:18:22.000000000 +0100
+++ linux/include/linux/fb.h	2005-12-10 06:55:24.000000000 +0100
@@ -725,6 +725,18 @@ struct fb_tile_ops {
  #define FBINFO_MISC_USEREVENT          0x10000 /* event request
  						  from userspace */
  #define FBINFO_MISC_TILEBLITTING       0x20000 /* use tile blitting */
+/* A driver may set this flag to indicate that it does want a set_par to be
+ * called every time when fbcon_switch is executed. The advantage is that with
+ * this flag set you can really be shure that set_par is always called before
+ * any of the functions dependant on the correct hardware state or altering
+ * that state, even if you are using some broken X releases. The disadvantage
+ * is that it introduces unwanted delays to every console switch if set_par
+ * is slow. It is a good idea to try this flag in the drivers initialization
+ * code whenever there is a bug report related to switching between X and the
+ * framebuffer console.
+ */
+#define FBINFO_MISC_ALLWAYS_SETPAR   0x40000
+

  struct fb_info {
  	int node;

