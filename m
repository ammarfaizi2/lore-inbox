Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbTFSPJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbTFSPJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:09:26 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:8549 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265795AbTFSPJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:09:22 -0400
Subject: [PATCH] 2.4.21 synclink_cs.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Content-Type: text/plain
Organization: 
Message-Id: <1056036221.2037.10.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jun 2003 10:23:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* fix arbitration between net open and tty open
* add MODULE_LICENSE() macro
* add dosyncppp module parameter

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.4.21/drivers/char/pcmcia/synclink_cs.c	2002-11-28 17:53:12.000000000 -0600
+++ linux-2.4.21-mg/drivers/char/pcmcia/synclink_cs.c	2003-06-18 15:02:56.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 3.4 2002/04/22 14:36:41 paulkf Exp $
+ * $Id: synclink_cs.c,v 3.9 2003/05/23 20:16:41 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -483,6 +483,7 @@
 
 static int debug_level = 0;
 static int maxframe[MAX_DEVICE_COUNT] = {0,};
+static int dosyncppp[MAX_DEVICE_COUNT] = {1,1,1,1};
 
 /* The old way: bit map of interrupts to choose from */
 /* This means pick from 15, 14, 12, 11, 10, 9, 7, 5, 4, and 3 */
@@ -499,9 +500,14 @@
 MODULE_PARM(cuamajor,"i");
 MODULE_PARM(debug_level,"i");
 MODULE_PARM(maxframe,"1-" __MODULE_STRING(MAX_DEVICE_COUNT) "i");
+MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICE_COUNT) "i");
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 3.4 $";
+static char *driver_version = "$Revision: 3.9 $";
 
 static struct tty_driver serial_driver, callout_driver;
 static int serial_refcount;
@@ -2616,14 +2622,17 @@
 {
 	MGSLPC_INFO * info = (MGSLPC_INFO *)tty->driver_data;
 
-	if (!info || mgslpc_paranoia_check(info, tty->device, "mgslpc_close"))
+	if (mgslpc_paranoia_check(info, tty->device, "mgslpc_close"))
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
@@ -2747,7 +2756,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	} else {
@@ -2757,7 +2766,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	}
@@ -2937,16 +2946,11 @@
 	info = mgslpc_device_list;
 	while(info && info->line != line)
 		info = info->next_device;
-	if ( !info ){
-		printk("%s(%d):Can't find specified device on open (line=%d)\n",
-			__FILE__,__LINE__,line);
+	if (mgslpc_paranoia_check(info, tty->device, "mgslpc_open"))
 		return -ENODEV;
-	}
 	
 	tty->driver_data = info;
 	info->tty = tty;
-	if (mgslpc_paranoia_check(info, tty->device, "mgslpc_open"))
-		return -ENODEV;
 		
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_open(%s), old ref count = %d\n",
@@ -3008,6 +3012,8 @@
 	
 cleanup:			
 	if (retval) {
+		if (tty->count == 1)
+			info->tty = 0; /* tty layer will release tty struct */
 		if(MOD_IN_USE)
 			MOD_DEC_USE_COUNT;
 		if(info->count)
@@ -3181,8 +3187,7 @@
 	if (info->line < MAX_DEVICE_COUNT) {
 		if (maxframe[info->line])
 			info->max_frame_size = maxframe[info->line];
-//		info->dosyncppp = dosyncppp[info->line];
-		info->dosyncppp = 1;
+		info->dosyncppp = dosyncppp[info->line];
 	}
 
 	mgslpc_device_count++;



