Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUC1Le0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUC1Le0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:34:26 -0500
Received: from ozlabs.org ([203.10.76.45]:47798 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261160AbUC1LeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:34:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16486.42912.340325.522003@cargo.ozlabs.ibm.com>
Date: Sun, 28 Mar 2004 20:23:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] further early_param fixes
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew & Tom,

Tom's patches to add early_param also added some code to read the
command line from nvram in setup_arch on PReP boxes.  This broke
powermacs, though, since init_prep_nvram() calls the
ppc_md.nvram_read_val pointer, which is initialized later on
powermac.  In any case we don't want to call the prep nvram code on
powermacs.  This patch fixes it, and also eliminates a compile warning
about early_adb_sync.

Paul.

diff -urN linux-2.6.5-rc2-mm4.orig/arch/ppc/kernel/setup.c linux-2.6.5-rc2-mm4/arch/ppc/kernel/setup.c
--- linux-2.6.5-rc2-mm4.orig/arch/ppc/kernel/setup.c	2004-03-28 15:46:22.621884568 +1000
+++ linux-2.6.5-rc2-mm4/arch/ppc/kernel/setup.c	2004-03-28 16:26:20.297905848 +1000
@@ -470,10 +470,11 @@
 
 #ifdef CONFIG_ADB
 /* Allow us to say that ADB probing will be done synchronously. */
-static void __init early_adb_sync(char **ign)
+static int __init early_adb_sync(char *ign)
 {
 	extern int __adb_probe_sync;
 	__adb_probe_sync = 1;
+	return 0;
 }
 __early_param("adb_sync", early_adb_sync);
 #endif /* CONFIG_ADB */
@@ -663,13 +664,15 @@
 
 	/* See if we need to grab the command line params from PPCBUG. */
 #ifdef CONFIG_PPCBUG_NVRAM
-	/* Read in NVRAM data */
-	init_prep_nvram();
-
-	if (cmd_line[0] == '\0') {
-		char *bootargs = prep_nvram_get_var("bootargs");
-		if (bootargs != NULL)
-			strlcpy(cmd_line, bootargs, sizeof(cmd_line));
+	if (_machine == _MACH_prep) {
+		/* Read in NVRAM data */
+		init_prep_nvram();
+
+		if (cmd_line[0] == '\0') {
+			char *bootargs = prep_nvram_get_var("bootargs");
+			if (bootargs != NULL)
+				strlcpy(cmd_line, bootargs, sizeof(cmd_line));
+		}
 	}
 #endif
 
