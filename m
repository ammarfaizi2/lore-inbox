Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbTCaOa1>; Mon, 31 Mar 2003 09:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbTCaOa1>; Mon, 31 Mar 2003 09:30:27 -0500
Received: from slarti.muc.de ([193.149.48.10]:49668 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S261659AbTCaO3w>;
	Mon, 31 Mar 2003 09:29:52 -0500
From: Stephan Maciej <stephanm@muc.de>
Date: Mon, 31 Mar 2003 16:15:38 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: Osamu Tomita <tomita@cinet.co.jp>
Subject: [PATCH 2.5.66] Janitor: misc_register() can fail, even in drivers/char/upd4990.c
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200303311615.38019.stephanm@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.66/drivers/char/upd4990a.c~unmodified	2003-03-31 15:42:15.000000000 +0200
+++ linux-2.5.66/drivers/char/upd4990a.c	2003-03-31 16:05:15.000000000 +0200
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

