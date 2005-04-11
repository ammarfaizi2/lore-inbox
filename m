Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVDKUen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVDKUen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDKUen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:34:43 -0400
Received: from mail.dif.dk ([193.138.115.101]:50887 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261916AbVDKUeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:34:01 -0400
Date: Mon, 11 Apr 2005 22:36:39 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paul Mackerras <paulus@au.ibm.com>
Cc: Anton Blanchard <anton@au.ibm.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] redundant NULL checks before kfree should go away...
Message-ID: <Pine.LNX.4.62.0504112231470.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(keeping me on CC when replying will be appreciated, thanks)


kfree() checks for NULL pointers. Checking prior to calling it is 
reundant.
This patch removes such redundant checks from arch/ppc64/

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -upr linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/lparcfg.c linux-2.6.12-rc2-mm3/arch/ppc64/kernel/lparcfg.c
--- linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/lparcfg.c	2005-04-05 21:21:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/ppc64/kernel/lparcfg.c	2005-04-11 22:23:37.000000000 +0200
@@ -597,9 +597,7 @@ int __init lparcfg_init(void)
 void __exit lparcfg_cleanup(void)
 {
 	if (proc_ppc64_lparcfg) {
-		if (proc_ppc64_lparcfg->data) {
-			kfree(proc_ppc64_lparcfg->data);
-		}
+		kfree(proc_ppc64_lparcfg->data);
 		remove_proc_entry("lparcfg", proc_ppc64_lparcfg->parent);
 	}
 }
diff -upr linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/pSeries_reconfig.c linux-2.6.12-rc2-mm3/arch/ppc64/kernel/pSeries_reconfig.c
--- linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/pSeries_reconfig.c	2005-04-05 21:21:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/ppc64/kernel/pSeries_reconfig.c	2005-04-11 22:25:01.000000000 +0200
@@ -294,10 +294,8 @@ static struct property *new_property(con
 	return new;
 
 cleanup:
-	if (new->name)
-		kfree(new->name);
-	if (new->value)
-		kfree(new->value);
+	kfree(new->name);
+	kfree(new->value);
 	kfree(new);
 	return NULL;
 }
diff -upr linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/rtas_flash.c linux-2.6.12-rc2-mm3/arch/ppc64/kernel/rtas_flash.c
--- linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/rtas_flash.c	2005-04-05 21:21:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/ppc64/kernel/rtas_flash.c	2005-04-11 22:25:49.000000000 +0200
@@ -565,8 +565,7 @@ static int validate_flash_release(struct
 static void remove_flash_pde(struct proc_dir_entry *dp)
 {
 	if (dp) {
-		if (dp->data != NULL)
-			kfree(dp->data);
+		kfree(dp->data);
 		dp->owner = NULL;
 		remove_proc_entry(dp->name, dp->parent);
 	}
diff -upr linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/scanlog.c linux-2.6.12-rc2-mm3/arch/ppc64/kernel/scanlog.c
--- linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/scanlog.c	2005-04-05 21:21:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/ppc64/kernel/scanlog.c	2005-04-11 22:26:11.000000000 +0200
@@ -234,8 +234,7 @@ int __init scanlog_init(void)
 void __exit scanlog_cleanup(void)
 {
 	if (proc_ppc64_scan_log_dump) {
-		if (proc_ppc64_scan_log_dump->data)
-			kfree(proc_ppc64_scan_log_dump->data);
+		kfree(proc_ppc64_scan_log_dump->data);
 		remove_proc_entry("scan-log-dump", proc_ppc64_scan_log_dump->parent);
 	}
 }



