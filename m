Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTDGXBx (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTDGXBx (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:01:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48768
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263788AbTDGWz6 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:55:58 -0400
Date: Tue, 8 Apr 2003 01:14:53 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080014.h380Erif009011@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: error handling for upd4990a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Stephan Maciej)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/char/upd4990a.c linux-2.5.67-ac1/drivers/char/upd4990a.c
--- linux-2.5.67/drivers/char/upd4990a.c	2003-03-26 19:59:51.000000000 +0000
+++ linux-2.5.67-ac1/drivers/char/upd4990a.c	2003-04-03 23:43:02.000000000 +0100
@@ -343,19 +343,28 @@
 
 static int __init rtc_init(void)
 {
+	int err = 0;
+
 	if (!request_region(UPD4990A_IO, 1, "rtc")) {
 		printk(KERN_ERR "upd4990a: could not acquire I/O port %#x\n",
 			UPD4990A_IO);
 		return -EBUSY;
 	}
 
+	err = misc_register(&rtc_dev);
+	if (err) {
+		printk(KERN_ERR "upd4990a: can't misc_register() on minor=%d\n",
+			RTC_MINOR);
+		release_region(UPD4990A_IO, 1);
+		return err;
+	}
+		
 #if 0
 	printk(KERN_INFO "\xB6\xDA\xDD\xC0\xDE \xC4\xDE\xB9\xB2 Driver\n");  /* Calender Clock Driver */
 #else
 	printk(KERN_INFO
 	       "Real Time Clock driver for NEC PC-9800 v" RTC98_VERSION "\n");
 #endif
-	misc_register(&rtc_dev);
 	create_proc_read_entry("driver/rtc", 0, NULL, rtc_read_proc, NULL);
 
 	init_timer(&rtc_uie_timer);
