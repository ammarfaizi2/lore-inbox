Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVCEW7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVCEW7H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVCEW4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:56:16 -0500
Received: from coderock.org ([193.77.147.115]:54437 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261305AbVCEWn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:29 -0500
Subject: [patch 08/15] block/ps2esdi: replace sleep_on() with wait_event()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:06 +0100
Message-Id: <20050305224306.04E961F07A@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Use wait_event() instead of the deprecated sleep_on(). In all
replacements, wait_event() expects the condition to *stop* on, so the existing
conditional is negated and passed as the parameter. I am not sure if these
changes are appropriate, as the condition to pass to wait_event() to guarantee
the same behavior; I think this is the best choice, though.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/ps2esdi.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/block/ps2esdi.c~wait_event-drivers_block_ps2esdi drivers/block/ps2esdi.c
--- kj/drivers/block/ps2esdi.c~wait_event-drivers_block_ps2esdi	2005-03-05 16:11:24.000000000 +0100
+++ kj-domen/drivers/block/ps2esdi.c	2005-03-05 16:11:24.000000000 +0100
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
_
