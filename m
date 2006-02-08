Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWBHCt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWBHCt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWBHCt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:49:29 -0500
Received: from tim.rpsys.net ([194.106.48.114]:51427 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965185AbWBHCt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:49:28 -0500
Subject: Re: [PATCH 11/12] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1139154893.14624.15.camel@localhost.localdomain>
References: <1139154893.14624.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 02:49:20 +0000
Message-Id: <1139366960.6422.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE disk activity fixes: 

Catch failure case of driver_register().
Only trigger on blk_fs end requests.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.15.orig/drivers/ide/ide-disk.c	2006-02-08 01:09:23.000000000 +0000
+++ linux-2.6.15/drivers/ide/ide-disk.c	2006-02-08 01:08:39.000000000 +0000
@@ -302,7 +302,8 @@
 
 static int ide_end_rw_disk(ide_drive_t *drive, int uptodate, int nr_sectors)
 {
-	led_trigger_event(ide_led_trigger, LED_OFF);
+	if (blk_fs_request(HWGROUP(drive)->rq))
+		led_trigger_event(ide_led_trigger, LED_OFF);
 	return ide_end_request(drive, uptodate, nr_sectors);
 }
 
@@ -1251,8 +1252,10 @@
 
 static int __init idedisk_init(void)
 {
-	led_trigger_register_simple("ide-disk", &ide_led_trigger);
-	return driver_register(&idedisk_driver.gen_driver);
+	int ret = driver_register(&idedisk_driver.gen_driver);
+	if (ret >= 0)
+		led_trigger_register_simple("ide-disk", &ide_led_trigger);
+	return ret;
 }
 
 MODULE_ALIAS("ide:*m-disk*");


