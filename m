Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbQKQXMu>; Fri, 17 Nov 2000 18:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQKQXMl>; Fri, 17 Nov 2000 18:12:41 -0500
Received: from 3dyn88.com21.casema.net ([212.64.94.88]:45580 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129859AbQKQXMW>;
	Fri, 17 Nov 2000 18:12:22 -0500
Date: Fri, 17 Nov 2000 23:41:44 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: mingo@redhat.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] raid5 fix after xor.c cleanup
Message-ID: <20001117234144.A14461@spaans.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo & lists,

due to the xor.c cleanup in 2.4.0-test11-pre5+, raid5 compiled into the
kernel fails when booting, because the calibrate_xor_block function
hasn't been called while registering a raid5 volume; this leads to a
panic, as no checksumming function has been chosen.

Here's a tiny patch to restore that functionality, can you apply it?

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>

diff -Nru linux-2.4.0-test11-pre6-orig/drivers/md/raid5.c linux-2.4.0-test11-pre6/drivers/md/raid5.c
--- linux-2.4.0-test11-pre6-orig/drivers/md/raid5.c	Fri Nov 17 23:21:18 2000
+++ linux-2.4.0-test11-pre6/drivers/md/raid5.c	Fri Nov 17 23:19:24 2000
@@ -2344,6 +2344,9 @@
 
 int raid5_init (void)
 {
+#ifndef MODULE
+	calibrate_xor_block();
+#endif
 	return register_md_personality (RAID5, &raid5_personality);
 }
 
diff -Nru linux-2.4.0-test11-pre6-orig/drivers/md/xor.c linux-2.4.0-test11-pre6/drivers/md/xor.c
--- linux-2.4.0-test11-pre6-orig/drivers/md/xor.c	Fri Nov 17 23:21:18 2000
+++ linux-2.4.0-test11-pre6/drivers/md/xor.c	Fri Nov 17 23:31:36 2000
@@ -98,7 +98,7 @@
 	       speed / 1000, speed % 1000);
 }
 
-static int
+int
 calibrate_xor_block(void)
 {
 	void *b1, *b2;
@@ -139,5 +139,6 @@
 }
 
 MD_EXPORT_SYMBOL(xor_block);
+MD_EXPORT_SYMBOL(calibrate_xor_block);
 
 module_init(calibrate_xor_block);
diff -Nru linux-2.4.0-test11-pre6-orig/include/linux/raid/xor.h linux-2.4.0-test11-pre6/include/linux/raid/xor.h
--- linux-2.4.0-test11-pre6-orig/include/linux/raid/xor.h	Fri Nov 17 23:21:48 2000
+++ linux-2.4.0-test11-pre6/include/linux/raid/xor.h	Fri Nov 17 23:33:03 2000
@@ -6,6 +6,7 @@
 #define MAX_XOR_BLOCKS 5
 
 extern void xor_block(unsigned int count, struct buffer_head **bh_ptr);
+extern int calibrate_xor_block(void);
 
 struct xor_block_template {
         struct xor_block_template *next;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
