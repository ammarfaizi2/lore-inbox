Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWFRPtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWFRPtE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWFRPsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:48:40 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751196AbWFRPsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:48:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=EBkaDXIeGTz8lrx4czg8RFgt2UOoAgV25RRGOLaf7OteS+VxslEaI3tN2w2hjvRGrl/9fA+Q24zP0QuNDWlZ99hxfE90y1ix5aR8RgEwlXfD3edPQ/CnxJSc3qh11dmYswe/4TIwzk72rQWjdzCpPBUdeKRLyWgLjVlwFD+lprc=
Message-ID: <44957240.2000405@gmail.com>
Date: Sun, 18 Jun 2006 23:33:20 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, tsbogend@alpha.franken.de
Subject: [PATCH 7/9] VT binding: Make newport_con support binding
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- move register ioremap from newport_startup() to newport_console_init()
- fonts are freed multiple times, do it only once

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/newport_con.c |   36 ++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e99fe30..cc121dc 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -51,6 +51,7 @@ static int topscan;
 static int xcurs_correction = 29;
 static int newport_xsize;
 static int newport_ysize;
+static int newport_has_init;
 
 static int newport_set_def_font(int unit, struct console_font *op);
 
@@ -283,15 +284,20 @@ #undef L
 		xcurs_correction = 21;
 }
 
+static void newport_exit(void)
+{
+	int i;
+
+	/* free memory used by user font */
+	for (i = 0; i < MAX_NR_CONSOLES; i++)
+		newport_set_def_font(i, NULL);
+}
+
 /* Can't be __init, take_over_console may call it later */
 static const char *newport_startup(void)
 {
 	int i;
 
-	if (!sgi_gfxaddr)
-		return NULL;
-	npregs = (struct newport_regs *)	/* ioremap cannot fail */
-		 ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
 	npregs->cset.config = NPORT_CFG_GD0;
 
 	if (newport_wait(npregs))
@@ -307,11 +313,11 @@ static const char *newport_startup(void)
 	newport_reset();
 	newport_get_revisions();
 	newport_get_screensize();
+	newport_has_init = 1;
 
 	return "SGI Newport";
 
 out_unmap:
-	iounmap((void *)npregs);
 	return NULL;
 }
 
@@ -324,11 +330,10 @@ static void newport_init(struct vc_data 
 
 static void newport_deinit(struct vc_data *c)
 {
-	int i;
-
-	/* free memory used by user font */
-	for (i = 0; i < MAX_NR_CONSOLES; i++)
-		newport_set_def_font(i, NULL);
+	if (!con_is_bound(&newport_con) && newport_has_init) {
+		newport_exit();
+		newport_has_init = 0;
+	}
 }
 
 static void newport_clear(struct vc_data *vc, int sy, int sx, int height,
@@ -725,19 +730,24 @@ const struct consw newport_con = {
 	.con_save_screen  = DUMMY
 };
 
-#ifdef MODULE
 static int __init newport_console_init(void)
 {
+
+	if (!sgi_gfxaddr)
+		return NULL;
+	npregs = (struct newport_regs *)	/* ioremap cannot fail */
+		 ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
+
 	return take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
 }
+module_init(newport_console_init);
 
+#ifdef MODULE
 static void __exit newport_console_exit(void)
 {
 	give_up_console(&newport_con);
 	iounmap((void *)npregs);
 }
-
-module_init(newport_console_init);
 module_exit(newport_console_exit);
 #endif
 

