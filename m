Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUBQARg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 19:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUBQARf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 19:17:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:57505 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261799AbUBQAR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 19:17:29 -0500
Subject: [PATCH] Fix building both old & new radeonfb's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076977005.1056.124.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 11:16:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fix build of "allyesconfig", old and new radeonfb's would
collide on some symbols.

Ben.


===== drivers/video/fbmem.c 1.88 vs edited =====
--- 1.88/drivers/video/fbmem.c	Tue Feb 17 04:58:08 2004
+++ edited/drivers/video/fbmem.c	Tue Feb 17 10:58:14 2004
@@ -138,6 +138,8 @@
 extern int tx3912fb_setup(char*);
 extern int radeonfb_init(void);
 extern int radeonfb_setup(char*);
+extern int radeonfb_old_init(void);
+extern int radeonfb_old_setup(char*);
 extern int e1355fb_init(void);
 extern int e1355fb_setup(char*);
 extern int pvr2fb_init(void);
@@ -226,7 +228,7 @@
 	{ "radeonfb", radeonfb_init, radeonfb_setup },
 #endif
 #ifdef CONFIG_FB_RADEON_OLD
-	{ "radeonfb_old", radeonfb_init, radeonfb_setup },
+	{ "radeonfb_old", radeonfb_old_init, radeonfb_old_setup },
 #endif
 #ifdef CONFIG_FB_CONTROL
 	{ "controlfb", control_init, control_setup },
===== drivers/video/radeonfb.c 1.37 vs edited =====
--- 1.37/drivers/video/radeonfb.c	Fri Feb 13 04:14:53 2004
+++ edited/drivers/video/radeonfb.c	Tue Feb 17 10:57:34 2004
@@ -234,7 +234,7 @@
 /* these common regs are cleared before mode setting so they do not
  * interfere with anything
  */
-reg_val common_regs[] = {
+static reg_val common_regs[] = {
 	{ OVR_CLR, 0 },	
 	{ OVR_WID_LEFT_RIGHT, 0 },
 	{ OVR_WID_TOP_BOTTOM, 0 },
@@ -246,7 +246,7 @@
 	{ CAP0_TRIG_CNTL, 0 },
 };
 
-reg_val common_regs_m6[] = {
+static reg_val common_regs_m6[] = {
 	{ OVR_CLR,      0 },
 	{ OVR_WID_LEFT_RIGHT,   0 },
 	{ OVR_WID_TOP_BOTTOM,   0 },
@@ -3134,19 +3134,19 @@
 };
 
 
-int __init radeonfb_init (void)
+int __init radeonfb_old_init (void)
 {
 	return pci_module_init (&radeonfb_driver);
 }
 
 
-void __exit radeonfb_exit (void)
+void __exit radeonfb_old_exit (void)
 {
 	pci_unregister_driver (&radeonfb_driver);
 }
 
 
-int __init radeonfb_setup (char *options)
+int __init radeonfb_old_setup (char *options)
 {
         char *this_opt;
 
@@ -3174,8 +3174,8 @@
 }
 
 #ifdef MODULE
-module_init(radeonfb_init);
-module_exit(radeonfb_exit);
+module_init(radeonfb_old_init);
+module_exit(radeonfb_old_exit);
 #endif
 
 
===== drivers/video/aty/radeon_base.c 1.7 vs edited =====
--- 1.7/drivers/video/aty/radeon_base.c	Mon Feb 16 14:56:24 2004
+++ edited/drivers/video/aty/radeon_base.c	Tue Feb 17 10:37:53 2004
@@ -212,7 +212,7 @@
 /* these common regs are cleared before mode setting so they do not
  * interfere with anything
  */
-reg_val common_regs[] = {
+static reg_val common_regs[] = {
 	{ OVR_CLR, 0 },	
 	{ OVR_WID_LEFT_RIGHT, 0 },
 	{ OVR_WID_TOP_BOTTOM, 0 },
@@ -224,7 +224,7 @@
 	{ CAP0_TRIG_CNTL, 0 },
 };
 
-reg_val common_regs_m6[] = {
+static reg_val common_regs_m6[] = {
 	{ OVR_CLR,      0 },
 	{ OVR_WID_LEFT_RIGHT,   0 },
 	{ OVR_WID_TOP_BOTTOM,   0 },


