Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVHHWdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVHHWdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVHHWbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:42 -0400
Received: from coderock.org ([193.77.147.115]:64666 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932315AbVHHWb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:31:26 -0400
Message-Id: <20050808223100.045700000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:52 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 16/16] block/ps2esdi: replace sleep_on() with wait_event()
Content-Disposition: inline; filename=wait_event-drivers_block_ps2esdi.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use wait_event() instead of the deprecated sleep_on(). In all
replacements, wait_event() expects the condition to *stop* on, so the existing
conditional is negated and passed as the parameter. I am not sure if these
changes are appropriate, as the condition to pass to wait_event() to guarantee
the same behavior; I think this is the best choice, though.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ps2esdi.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: quilt/drivers/block/ps2esdi.c
===================================================================
--- quilt.orig/drivers/block/ps2esdi.c
+++ quilt/drivers/block/ps2esdi.c
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -461,8 +462,7 @@ static void __init ps2esdi_get_device_cf
 	cmd_blk[1] = 0;
 	no_int_yet = TRUE;
 	ps2esdi_out_cmd_blk(cmd_blk);
-	if (no_int_yet)
-		sleep_on(&ps2esdi_int);
+	wait_event(ps2esdi_int, !no_int_yet);
 
 	if (ps2esdi_drives > 1) {
 		printk("%s: Drive 1\n", DEVICE_NAME);	/*BA */
@@ -470,8 +470,7 @@ static void __init ps2esdi_get_device_cf
 		cmd_blk[1] = 0;
 		no_int_yet = TRUE;
 		ps2esdi_out_cmd_blk(cmd_blk);
-		if (no_int_yet)
-			sleep_on(&ps2esdi_int);
+		wait_event(ps2esdi_int, !no_int_yet);
 	}			/* if second physical drive is present */
 	return;
 }

--
