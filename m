Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbUJZBoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUJZBoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUJZBnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:43:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:58582 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261863AbUJZBVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:21:51 -0400
Subject: [PATCH] ppc64: Cleanup console detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 11:19:00 +1000
Message-Id: <1098753540.17905.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch removes some leftover code that was in #if 0 in the console autodetect
code. It also adds passing of the default serial speed as console options when
it is available from Open Firmware.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/setup.c	2004-10-25 21:58:12.000000000 +1000
+++ linux-work/arch/ppc64/kernel/setup.c	2004-10-26 11:18:05.630004280 +1000
@@ -786,12 +786,11 @@
 #ifdef CONFIG_PPC_MULTIPLATFORM
 static int __init set_preferred_console(void)
 {
-	struct device_node *prom_stdout;
+	struct device_node *prom_stdout = NULL;
 	char *name;
+	u32 *spd;
 	int offset = 0;
-#if  0
-	phandle *stdout_ph;
-#endif
+
 	DBG(" -> set_preferred_console()\n");
 
 	/* The user has requested a console so this is already set up. */
@@ -805,20 +804,7 @@
 		return -ENODEV;
 	}
 	/* We are getting a weird phandle from OF ... */
-#if 0
-	stdout_ph = (phandle *)get_property(of_chosen, "linux,stdout-package", NULL);
-	if (stdout_ph == NULL) {
-		DBG(" no linux,stdout-package !\n");
-		return -ENODEV;
-	}
-	prom_stdout = of_find_node_by_phandle(*stdout_ph);
-	if (!prom_stdout) {
-		DBG(" can't find stdout package for phandle 0x%x !\n", *stdout_ph);
-		return -ENODEV;
-	}
-#endif
 	/* ... So use the full path instead */
-#if 1
 	name = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name == NULL) {
 		DBG(" no linux,stdout-path !\n");
@@ -829,7 +815,6 @@
 		DBG(" can't find stdout package %s !\n", name);
 		return -ENODEV;
 	}	
-#endif
 	DBG("stdout is %s\n", prom_stdout->full_name);
 
 	name = (char *)get_property(prom_stdout, "name", NULL);
@@ -837,8 +822,12 @@
 		DBG(" stdout package has no name !\n");
 		goto not_found;
 	}
+	spd = (u32 *)get_property(prom_stdout, "current-speed", NULL);
 
-	if (strcmp(name, "serial") == 0) {
+	if (0)
+		;
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	else if (strcmp(name, "serial") == 0) {
 		int i;
 		u32 *reg = (u32 *)get_property(prom_stdout, "reg", &i);
 		if (i > 8) {
@@ -861,6 +850,7 @@
 			}
 		}
 	}
+#endif /* CONFIG_SERIAL_8250_CONSOLE */
 #ifdef CONFIG_PPC_PSERIES
 	else if (strcmp(name, "vty") == 0) {
  		u32 *reg = (u32 *)get_property(prom_stdout, "reg", NULL);
@@ -890,17 +880,24 @@
  		}
 	}
 #endif /* CONFIG_PPC_PSERIES */
+#ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
 	else if (strcmp(name, "ch-a") == 0)
 		offset = 0;
 	else if (strcmp(name, "ch-b") == 0)
 		offset = 1;
+#endif /* CONFIG_SERIAL_PMACZILOG_CONSOLE */
 	else
 		goto not_found;
 	of_node_put(prom_stdout);
 
 	DBG("Found serial console at ttyS%d\n", offset);
 
-	return add_preferred_console("ttyS", offset, NULL);
+	if (spd) {
+		char opt[16];
+		sprintf(opt, "%d", *spd);
+		return add_preferred_console("ttyS", offset, opt);
+	} else
+		return add_preferred_console("ttyS", offset, NULL);
 
  not_found:
 	DBG("No preferred console found !\n");


