Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTFRP1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbTFRP1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:27:30 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:3891 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265287AbTFRP1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:27:00 -0400
Subject: [PATCH] 2.5.72 synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055950872.2140.5.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jun 2003 10:41:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix arbitration between net open and tty open.

Clean up unused locals resulting from latest tty changes.

Please apply.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.5.72/drivers/char/synclinkmp.c	2003-06-16 08:42:25.000000000 -0500
+++ linux-2.5.72-mg/drivers/char/synclinkmp.c	2003-06-18 10:31:01.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.8 2003/04/21 17:46:55 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.12 2003/06/18 15:29:33 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -481,7 +481,6 @@
  * assigned major number. May be forced as module parameter.
  */
 static int ttymajor=0;
-static int cuamajor=0;
 
 /*
  * Array of user specified options for ISA adapters.
@@ -492,13 +491,12 @@
 
 MODULE_PARM(break_on_load,"i");
 MODULE_PARM(ttymajor,"i");
-MODULE_PARM(cuamajor,"i");
 MODULE_PARM(debug_level,"i");
 MODULE_PARM(maxframe,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.8 $";
+static char *driver_version = "$Revision: 4.12 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -739,12 +737,8 @@
 	info = synclinkmp_device_list;
 	while(info && info->line != line)
 		info = info->next_device;
-	if ( !info ){
-		printk("%s(%d):%s Can't find specified device on open (line=%d)\n",
-			__FILE__,__LINE__,info->device_name,line);
+	if (sanity_check(info, tty->name, "open"))
 		return -ENODEV;
-	}
-
 	if ( info->init_error ) {
 		printk("%s(%d):%s device is not allocated, init error=%d\n",
 			__FILE__,__LINE__,info->device_name,info->init_error);
@@ -753,8 +747,6 @@
 
 	tty->driver_data = info;
 	info->tty = tty;
-	if (sanity_check(info, tty->name, "open"))
-		return -ENODEV;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s open(), old ref count = %d\n",
@@ -802,6 +794,8 @@
 
 cleanup:
 	if (retval) {
+		if (tty->count == 1)
+			info->tty = 0; /* tty layer will release tty struct */
 		if(info->count)
 			info->count--;
 	}
@@ -816,14 +810,17 @@
 {
 	SLMP_INFO * info = (SLMP_INFO *)tty->driver_data;
 
-	if (!info || sanity_check(info, tty->name, "close"))
+	if (sanity_check(info, tty->name, "close"))
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
@@ -3775,8 +3772,6 @@
 
 static int __init synclinkmp_init(void)
 {
-	SLMP_INFO *info;
-
 	if (break_on_load) {
 	 	synclinkmp_get_text_ptr();
   		BREAKPOINT();



