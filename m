Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbTFSPGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbTFSPGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:06:52 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:4709 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265800AbTFSPGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:06:48 -0400
Subject: [PATCH] 2.4.21 synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Content-Type: text/plain
Organization: 
Message-Id: <1056036066.2037.6.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jun 2003 10:21:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* fix arbitration between net open and tty open
* add MODULE_LICENSE() macro
* use time_after() macro

Please apply

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.4.21/drivers/char/synclinkmp.c	2002-11-28 17:53:12.000000000 -0600
+++ linux-2.4.21-mg/drivers/char/synclinkmp.c	2003-06-19 08:27:19.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 3.17 2002/04/22 16:05:39 paulkf Exp $
+ * $Id: synclinkmp.c,v 3.21 2003/06/18 21:02:26 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -504,7 +504,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 3.17 $";
+static char *driver_version = "$Revision: 3.21 $";
 
 static int __devinit synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void __devexit synclinkmp_remove_one(struct pci_dev *dev);
@@ -515,6 +515,10 @@
 };
 MODULE_DEVICE_TABLE(pci, synclinkmp_pci_tbl);
 
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
 static struct pci_driver synclinkmp_pci_driver = {
 	name:		"synclinkmp",
 	id_table:	synclinkmp_pci_tbl,
@@ -748,12 +752,8 @@
 	info = synclinkmp_device_list;
 	while(info && info->line != line)
 		info = info->next_device;
-	if ( !info ){
-		printk("%s(%d):%s Can't find specified device on open (line=%d)\n",
-			__FILE__,__LINE__,info->device_name,line);
+	if (sanity_check(info, tty->device, "open"))
 		return -ENODEV;
-	}
-
 	if ( info->init_error ) {
 		printk("%s(%d):%s device is not allocated, init error=%d\n",
 			__FILE__,__LINE__,info->device_name,info->init_error);
@@ -762,8 +762,6 @@
 
 	tty->driver_data = info;
 	info->tty = tty;
-	if (sanity_check(info, tty->device, "open"))
-		return -ENODEV;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s open(), old ref count = %d\n",
@@ -825,6 +823,8 @@
 
 cleanup:
 	if (retval) {
+		if (tty->count == 1)
+			info->tty = 0; /* tty layer will release tty struct */
 		if(MOD_IN_USE)
 			MOD_DEC_USE_COUNT;
 		if(info->count)
@@ -841,14 +841,17 @@
 {
 	SLMP_INFO * info = (SLMP_INFO *)tty->driver_data;
 
-	if (!info || sanity_check(info, tty->device, "close"))
+	if (sanity_check(info, tty->device, "close"))
 		return;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s close() entry, count=%d\n",
 			 __FILE__,__LINE__, info->device_name, info->count);
 
-	if (!info->count || tty_hung_up_p(filp))
+	if (!info->count)
+		return;
+
+	if (tty_hung_up_p(filp))
 		goto cleanup;
 
 	if ((tty->count == 1) && (info->count != 1)) {
@@ -1203,7 +1206,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	} else {
@@ -1214,7 +1217,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	}



