Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTFRP3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTFRP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:29:50 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:49715 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265297AbTFRP3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:29:10 -0400
Subject: [PATCH] 2.5.72 synclink_cs.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055951004.2140.9.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jun 2003 10:43:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix arbitration between net open and tty open.

Cleanup missed bits of CUA device removal changes.

Please apply.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


--- linux-2.5.72/drivers/char/pcmcia/synclink_cs.c	2003-06-16 08:42:24.000000000 -0500
+++ linux-2.5.72-mg/drivers/char/pcmcia/synclink_cs.c	2003-06-18 10:31:08.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/pcmcia/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 4.10 2003/05/13 16:06:03 paulkf Exp $
+ * $Id: synclink_cs.c,v 4.13 2003/06/18 15:29:32 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -467,7 +467,6 @@
  * assigned major number. May be forced as module parameter.
  */
 static int ttymajor=0;
-static int cuamajor=0;
 
 static int debug_level = 0;
 static int maxframe[MAX_DEVICE_COUNT] = {0,};
@@ -485,7 +484,6 @@
 
 MODULE_PARM(break_on_load,"i");
 MODULE_PARM(ttymajor,"i");
-MODULE_PARM(cuamajor,"i");
 MODULE_PARM(debug_level,"i");
 MODULE_PARM(maxframe,"1-" __MODULE_STRING(MAX_DEVICE_COUNT) "i");
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICE_COUNT) "i");
@@ -493,7 +491,7 @@
 MODULE_LICENSE("GPL");
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 4.10 $";
+static char *driver_version = "$Revision: 4.13 $";
 
 static struct tty_driver *serial_driver;
 
@@ -1290,7 +1288,7 @@
 			       (info->serial_signals & SerialSignal_DCD) ? "on" : "off");
 		if (info->serial_signals & SerialSignal_DCD)
 			wake_up_interruptible(&info->open_wait);
-		else if (!(info->flags & ASYNC_CALLOUT_NOHUP)) {
+		else {
 			if (debug_level >= DEBUG_LEVEL_ISR)
 				printk("doing serial hangup...");
 			if (info->tty)
@@ -2538,14 +2536,17 @@
 {
 	MGSLPC_INFO * info = (MGSLPC_INFO *)tty->driver_data;
 
-	if (!info || mgslpc_paranoia_check(info, tty->name, "mgslpc_close"))
+	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_close"))
 		return;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_close(%s) entry, count=%d\n",
 			 __FILE__,__LINE__, info->device_name, info->count);
 			 
-	if (!info->count || tty_hung_up_p(filp))
+	if (!info->count)
+		return;
+
+	if (tty_hung_up_p(filp))
 		goto cleanup;
 			
 	if ((tty->count == 1) && (info->count != 1)) {
@@ -2822,16 +2823,11 @@
 	info = mgslpc_device_list;
 	while(info && info->line != line)
 		info = info->next_device;
-	if ( !info ){
-		printk("%s(%d):Can't find specified device on open (line=%d)\n",
-			__FILE__,__LINE__,line);
+	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_open"))
 		return -ENODEV;
-	}
 	
 	tty->driver_data = info;
 	info->tty = tty;
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_open"))
-		return -ENODEV;
 		
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_open(%s), old ref count = %d\n",
@@ -2879,6 +2875,8 @@
 	
 cleanup:			
 	if (retval) {
+		if (tty->count == 1)
+			info->tty = 0; /* tty layer will release tty struct */
 		if(info->count)
 			info->count--;
 	}



