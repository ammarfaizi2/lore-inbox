Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTFZUKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 16:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTFZUKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 16:10:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34777 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262115AbTFZUK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 16:10:27 -0400
Date: Thu, 26 Jun 2003 13:24:31 -0700
From: Bob Miller <rem@osdl.org>
To: alan@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.73] Remove check_region and MOD_*_USE_COUNT from mixcomwd.c
Message-ID: <20030626202430.GB16162@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't recieve any negative feed back from my CFT.  To recap this
patch:

Replaces the call to MOD_INC_USE_COUNT with a __module_get() when
forcing the module to not be unloadable.

And removes the check_region() calls and restructured things to only
use request_region().

--
Bob Miller                                      Email: rem@osdl.org
Open Source Development Lab                     Phone: 503.626.2455 Ext. 17


diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	Wed Jun 25 16:18:28 2003
+++ b/drivers/char/watchdog/mixcomwd.c	Wed Jun 25 16:18:28 2003
@@ -95,7 +95,12 @@
 	mixcomwd_ping();
 	
 	if (nowayout) {
-		MOD_INC_USE_COUNT;
+		/*
+		 * fops_get() code via open() has already done
+		 * a try_module_get() so it is safe to do the
+		 * __module_get().
+		 */
+		__module_get(THIS_MODULE);
 	} else {
 		if(mixcomwd_timer_alive) {
 			del_timer(&mixcomwd_timer);
@@ -211,30 +216,34 @@
 {
 	int id;
 
-	if(check_region(port+MIXCOM_WATCHDOG_OFFSET,1)) {
+	port += MIXCOM_WATCHDOG_OFFSET;
+	if (!request_region(port, 1, "MixCOM watchdog")) {
 		return 0;
 	}
 	
-	id=inb_p(port + MIXCOM_WATCHDOG_OFFSET) & 0x3f;
+	id=inb_p(port) & 0x3f;
 	if(id!=MIXCOM_ID) {
+		release_region(port, 1);
 		return 0;
 	}
-	return 1;
+	return port;
 }
 
 static int __init flashcom_checkcard(int port)
 {
 	int id;
 	
-	if(check_region(port + FLASHCOM_WATCHDOG_OFFSET,1)) {
+	port += FLASHCOM_WATCHDOG_OFFSET;
+	if (!request_region(port, 1, "MixCOM watchdog")) {
 		return 0;
 	}
 	
-	id=inb_p(port + FLASHCOM_WATCHDOG_OFFSET);
+	id=inb_p(port);
  	if(id!=FLASHCOM_ID) {
+		release_region(port, 1);
 		return 0;
 	}
- 	return 1;
+ 	return port;
  }
  
 static int __init mixcomwd_init(void)
@@ -244,17 +253,17 @@
 	int found=0;
 
 	for (i = 0; !found && mixcomwd_ioports[i] != 0; i++) {
-		if (mixcomwd_checkcard(mixcomwd_ioports[i])) {
+		watchdog_port = mixcomwd_checkcard(mixcomwd_ioports[i]);
+		if (watchdog_port) {
 			found = 1;
-			watchdog_port = mixcomwd_ioports[i] + MIXCOM_WATCHDOG_OFFSET;
 		}
 	}
 	
 	/* The FlashCOM card can be set up at 0x300 -> 0x378, in 0x8 jumps */
 	for (i = 0x300; !found && i < 0x380; i+=0x8) {
-		if (flashcom_checkcard(i)) {
+		watchdog_port = flashcom_checkcard(i);
+		if (watchdog_port) {
 			found = 1;
-			watchdog_port = i + FLASHCOM_WATCHDOG_OFFSET;
 		}
 	}
 	
@@ -263,9 +272,6 @@
 		return -ENODEV;
 	}
 
-	if (!request_region(watchdog_port,1,"MixCOM watchdog"))
-		return -EIO;
-		
 	ret = misc_register(&mixcomwd_miscdev);
 	if (ret)
 	{

