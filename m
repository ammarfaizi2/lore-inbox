Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVIHPG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVIHPG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbVIHPG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:06:57 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:16856
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932630AbVIHPGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:06:46 -0400
Subject: [patch] synclink_cs add statistics clear
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1126191997.7234.3.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Sep 2005 10:06:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] synclink_cs add statistics clear

From: Paul Fulghum <paulkf@microgate.com>

Add ability to clear statistics.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.13/drivers/char/pcmcia/synclink_cs.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-mg/drivers/char/pcmcia/synclink_cs.c	2005-09-08 09:46:20.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/pcmcia/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 4.26 2004/08/11 19:30:02 paulkf Exp $
+ * $Id: synclink_cs.c,v 4.34 2005/09/08 13:20:54 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -472,7 +472,7 @@ module_param_array(dosyncppp, int, NULL,
 MODULE_LICENSE("GPL");
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 4.26 $";
+static char *driver_version = "$Revision: 4.34 $";
 
 static struct tty_driver *serial_driver;
 
@@ -1457,6 +1457,8 @@ static int startup(MGSLPC_INFO * info)
 
 	info->pending_bh = 0;
 	
+	memset(&info->icount, 0, sizeof(info->icount));
+
 	init_timer(&info->tx_timer);
 	info->tx_timer.data = (unsigned long)info;
 	info->tx_timer.function = tx_timeout;
@@ -1946,9 +1948,13 @@ static int get_stats(MGSLPC_INFO * info,
 	int err;
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("get_params(%s)\n", info->device_name);
-	COPY_TO_USER(err,user_icount, &info->icount, sizeof(struct mgsl_icount));
-	if (err)
-		return -EFAULT;
+	if (!user_icount) {
+		memset(&info->icount, 0, sizeof(info->icount));
+	} else {
+		COPY_TO_USER(err, user_icount, &info->icount, sizeof(struct mgsl_icount));
+		if (err)
+			return -EFAULT;
+	}
 	return 0;
 }
 


