Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268284AbRG3CkU>; Sun, 29 Jul 2001 22:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268279AbRG3CkK>; Sun, 29 Jul 2001 22:40:10 -0400
Received: from ohiper1-226.apex.net ([209.250.47.241]:56328 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S268284AbRG3CkB>; Sun, 29 Jul 2001 22:40:01 -0400
Date: Sun, 29 Jul 2001 21:40:16 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Mundt <lethal@ChaoticDreams.org>
Subject: [PATCH] Add module parameter support to tdfxfb
Message-ID: <20010729214016.B2149@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 8:38pm  up 1 day,  4:47,  1 user,  load average: 1.05, 1.02, 1.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The attached patch adds support for module parameters to the tdfxfb
driver.  As it stands, these options can only be changed if the driver
is compiled into the kernel.

This patch is incremental to Paul Mundt's patch.  Its very
straightforward to apply to 2.4.7, but I'll gladly make such a patch if
there is demand.  All comments are welcome.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

--- clean-2.4.7/drivers/video/tdfxfb.c	Sun Jul 29 21:14:45 2001
+++ linux/drivers/video/tdfxfb.c	Sun Jul 29 21:19:33 2001
@@ -500,6 +500,17 @@
 
 MODULE_DEVICE_TABLE(pci, tdfxfb_id_table);
 
+MODULE_PARM(inverse, "i");
+MODULE_PARM(noaccel, "i");
+MODULE_PARM(nopan, "i");
+MODULE_PARM(nowrap, "i");
+MODULE_PARM(nohwcursor,  "i");
+#ifdef CONFIG_MTRR
+MODULE_PARM(nomtrr, "i");
+#endif
+MODULE_PARM(font, "s");
+MODULE_PARM(mode_option, "s");
+
 struct mode {
   char* name;
   struct fb_var_screeninfo var;
@@ -529,7 +540,8 @@
 #endif
 static int  nohwcursor = 0;
 static char __initdata fontname[40] = { 0 };
-static const char *mode_option __initdata = NULL;
+static char *font __initdata = NULL;
+static char *mode_option __initdata = NULL;
 
 /* ------------------------------------------------------------------------- 
  *                      Hardware-specific funcions
@@ -2059,6 +2071,13 @@
 
 int __init tdfxfb_init(void)
 {
+	if (inverse)
+		fb_invert_cmaps();
+	if (noaccel)
+		nopan = nowrap = nohwcursor = 1;
+	if (font)
+		strncpy(fontname, font, 40);
+
	return pci_module_init(&tdfxfb_driver);
 }
 
@@ -2089,9 +2108,8 @@
       this_opt = strtok(NULL, ",")) {
     if(!strcmp(this_opt, "inverse")) {
       inverse = 1;
-      fb_invert_cmaps();
     } else if(!strcmp(this_opt, "noaccel")) {
-      noaccel = nopan = nowrap = nohwcursor = 1; 
+      noaccel = 1; 
     } else if(!strcmp(this_opt, "nopan")) {
       nopan = 1;
     } else if(!strcmp(this_opt, "nowrap")) {

