Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUIXBLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUIXBLo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUIXBHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:07:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:5089 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267597AbUIXBEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 21:04:23 -0400
Subject: [PATCH] ppc32: adapt prom_init to offb change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095987849.3878.29.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 11:04:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The changes to prom_init/offb interaction introduced by the ppc64
monster cleanup patch need a fix to ppc32 prom_init so that offb
works again. ppc32 prom_init() could use a lot more cleanup, but
let's do the minimal fix to make it work now.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/syslib/prom_init.c 1.14 vs edited =====
--- 1.14/arch/ppc/syslib/prom_init.c	2004-07-27 04:44:22 +10:00
+++ edited/arch/ppc/syslib/prom_init.c	2004-09-24 10:59:24 +10:00
@@ -115,11 +115,11 @@
 ihandle prom_chosen __initdata;
 ihandle prom_stdout __initdata;
 
-char *prom_display_paths[FB_MAX] __initdata;
-phandle prom_display_nodes[FB_MAX] __initdata;
-unsigned int prom_num_displays __initdata;
-char *of_stdout_device __initdata;
+static char *prom_display_paths[FB_MAX] __initdata;
+static phandle prom_display_nodes[FB_MAX] __initdata;
+static unsigned int prom_num_displays __initdata;
 static ihandle prom_disp_node __initdata;
+char *of_stdout_device __initdata;
 
 unsigned int rtas_data;   /* physical pointer */
 unsigned int rtas_entry;  /* physical pointer */
@@ -403,6 +403,7 @@
 
 	for (j=0; j<prom_num_displays; j++) {
 		path = prom_display_paths[j];
+		node = prom_display_nodes[j];
 		prom_print("opening display ");
 		prom_print(path);
 		ih = call_prom("open", 1, 1, path);
@@ -420,6 +421,8 @@
 			continue;
 		} else {
 			prom_print("... ok\n");
+			call_prom("setprop", 4, 1, node, "linux,opened", 0, NULL);
+
 			/*
 			 * Setup a usable color table when the appropriate
 			 * method is available.
@@ -439,6 +442,19 @@
 						   clut[1], clut[2]) != 0)
 					break;
 #endif /* CONFIG_LOGO_LINUX_CLUT224 */
+		}
+	}
+	
+	if (prom_stdout) {
+		phandle p;
+		p = call_prom("instance-to-package", 1, 1, prom_stdout);
+		if (p && (int)p != -1) {
+			type[0] = 0;
+			call_prom("getprop", 4, 1, p, "device_type",
+				  type, sizeof(type));
+			if (strcmp(type, "display") == 0)
+				call_prom("setprop", 4, 1, p, "linux,boot-display",
+					  0, NULL);
 		}
 	}
 


