Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbUC2PET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbUC2PCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:02:40 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:49368 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262924AbUC2PCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:02:11 -0500
Date: Mon, 29 Mar 2004 08:02:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] further early_param fixes
Message-ID: <20040329150210.GA2895@smtp.west.cox.net>
References: <16486.42912.340325.522003@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16486.42912.340325.522003@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 08:23:28PM +1000, Paul Mackerras wrote:

> Andrew & Tom,
> 
> Tom's patches to add early_param also added some code to read the
> command line from nvram in setup_arch on PReP boxes.  This broke
> powermacs, though, since init_prep_nvram() calls the
> ppc_md.nvram_read_val pointer, which is initialized later on
> powermac.  In any case we don't want to call the prep nvram code on
> powermacs.

But we do want to call it on other configs where _machine == 0.  So how
about:

diff -urN linux-2.6.5-rc2-mm4.orig/arch/ppc/kernel/setup.c linux-2.6.5-rc2-mm4/arch/ppc/kernel/setup.c
--- linux-2.6.5-rc2-mm4.orig/arch/ppc/kernel/setup.c	2004-03-28 15:46:22.621884568 +1000
+++ linux-2.6.5-rc2-mm4/arch/ppc/kernel/setup.c	2004-03-28 16:26:20.297905848 +1000
@@ -663,13 +664,18 @@
 
 	/* See if we need to grab the command line params from PPCBUG. */
 #ifdef CONFIG_PPCBUG_NVRAM
-	/* Read in NVRAM data */
-	init_prep_nvram();
-
-	if (cmd_line[0] == '\0') {
-		char *bootargs = prep_nvram_get_var("bootargs");
-		if (bootargs != NULL)
-			strlcpy(cmd_line, bootargs, sizeof(cmd_line));
+#ifdef CONFIG_PPC_PMAC
+	if (_machine == _MACH_prep)
+#endif
+	{
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


> This patch fixes it, and also eliminates a compile warning
> about early_adb_sync.

Whoops, good catch.

-- 
Tom Rini
http://gate.crashing.org/~trini/
