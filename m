Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTFRP0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTFRP0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:26:36 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:61746 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265279AbTFRPZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:25:26 -0400
Subject: [PATCH] 2.5.72 synclink.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055950778.2140.2.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jun 2003 10:39:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix arbitration between net open and tty open.

Cleanup unused local resulting from latest tty changes.

Please apply.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.5.72/drivers/char/synclink.c	2003-06-16 08:42:25.000000000 -0500
+++ linux-2.5.72-mg/drivers/char/synclink.c	2003-06-18 10:31:00.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.9 2003/05/06 21:18:51 paulkf Exp $
+ * $Id: synclink.c,v 4.12 2003/06/18 15:29:32 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -910,7 +910,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.9 $";
+static char *driver_version = "$Revision: 4.12 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -3170,14 +3170,17 @@
 {
 	struct mgsl_struct * info = (struct mgsl_struct *)tty->driver_data;
 
-	if (!info || mgsl_paranoia_check(info, tty->name, "mgsl_close"))
+	if (mgsl_paranoia_check(info, tty->name, "mgsl_close"))
 		return;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_close(%s) entry, count=%d\n",
 			 __FILE__,__LINE__, info->device_name, info->count);
 			 
-	if (!info->count || tty_hung_up_p(filp))
+	if (!info->count)
+		return;
+
+	if (tty_hung_up_p(filp))
 		goto cleanup;
 			
 	if ((tty->count == 1) && (info->count != 1)) {
@@ -3493,16 +3496,11 @@
 	info = mgsl_device_list;
 	while(info && info->line != line)
 		info = info->next_device;
-	if ( !info ){
-		printk("%s(%d):Can't find specified device on open (line=%d)\n",
-			__FILE__,__LINE__,line);
+	if (mgsl_paranoia_check(info, tty->name, "mgsl_open"))
 		return -ENODEV;
-	}
 	
 	tty->driver_data = info;
 	info->tty = tty;
-	if (mgsl_paranoia_check(info, tty->name, "mgsl_open"))
-		return -ENODEV;
 		
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_open(%s), old ref count = %d\n",
@@ -3562,6 +3560,8 @@
 	
 cleanup:			
 	if (retval) {
+		if (tty->count == 1)
+			info->tty = 0; /* tty layer will release tty struct */
 		if(info->count)
 			info->count--;
 	}
@@ -4461,7 +4461,6 @@
 int mgsl_init_tty(void);
 int mgsl_init_tty()
 {
-	struct mgsl_struct *info;
 	serial_driver = alloc_tty_driver(mgsl_device_count);
 	if (!serial_driver)
 		return -ENOMEM;



