Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTEODTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263779AbTEODSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:39 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:5356 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263778AbTEODSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:16 -0400
Date: Thu, 15 May 2003 04:31:04 +0100
Message-Id: <200305150331.h4F3V4M1000576@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: pcwatchdog firmware memory leak
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/watchdog/pcwd.c linux-2.5/drivers/char/watchdog/pcwd.c
--- bk-linus/drivers/char/watchdog/pcwd.c	2003-04-25 13:53:15.000000000 +0100
+++ linux-2.5/drivers/char/watchdog/pcwd.c	2003-04-26 15:08:04.000000000 +0100
@@ -594,6 +594,7 @@ static void __init pcwd_validate_timeout
  
 static int __init pcwatchdog_init(void)
 {
+	char *firmware;
 	int i, found = 0;
 	pcwd_validate_timeout();
 	spin_lock_init(&io_lock);
@@ -633,10 +634,12 @@ static int __init pcwatchdog_init(void)
 
 	if (revision == PCWD_REVISION_A)
 		printk(KERN_INFO "pcwd: PC Watchdog (REV.A) detected at port 0x%03x\n", current_readport);
-	else if (revision == PCWD_REVISION_C)
+	else if (revision == PCWD_REVISION_C) {
+		firmware = get_firmware();
 		printk(KERN_INFO "pcwd: PC Watchdog (REV.C) detected at port 0x%03x (Firmware version: %s)\n",
-			current_readport, get_firmware());
-	else {
+			current_readport, firmware);
+		kfree(firmware);
+	} else {
 		/* Should NEVER happen, unless get_revision() fails. */
 		printk("pcwd: Unable to get revision.\n");
 		return -1;
