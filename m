Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136213AbRD0U5W>; Fri, 27 Apr 2001 16:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136214AbRD0U5M>; Fri, 27 Apr 2001 16:57:12 -0400
Received: from zeus.kernel.org ([209.10.41.242]:54241 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136213AbRD0U5A>;
	Fri, 27 Apr 2001 16:57:00 -0400
Message-ID: <3AE9DB3A.7437F7B2@utad.pt>
Date: Fri, 27 Apr 2001 21:48:58 +0100
From: Alvaro Lopes <alvieboy@utad.pt>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, alvieboy@alvie.com,
        Herbert Xu <herbert@debian.org>
Subject: i2o_block struct gendisk misinitialization (2.4.3)
Content-Type: multipart/mixed;
 boundary="------------F9EED53010E2A92EC3C8DCDB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F9EED53010E2A92EC3C8DCDB
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi

i2o_block is not properly initializing its gendisk structure
(i2o_gendisk) and someone forgot to link it to the gendisk linked list,
causing i2o hard drives and partitions not to show in /proc/partitions
(debian installer relies on this to find fdisk'able drives).

I attached a simple patch to fix it.

Álvaro Lopes
--------------F9EED53010E2A92EC3C8DCDB
Content-Type: text/plain; charset=us-ascii;
 name="i2o_block_gendisk_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_block_gendisk_patch.diff"

--- linux-2.4.3/drivers/i2o/i2o_block.c	Sat Apr  7 16:42:21 2001
+++ linux/drivers/i2o/i2o_block.c	Fri Apr 27 19:58:41 2001
@@ -15,6 +15,8 @@
  * from loop.c. Isn't free software great for reusability 8)
  *
  * Fixes/additions:
+ *      Alvaro Lopes:
+ *              Fixed misc gendisk misinitialization
  *	Steve Ralston:	
  *		Multiple device handling error fixes,
  *		Added a queue depth.
@@ -1675,6 +1677,10 @@
 		i2o_remove_handler(&i2o_block_handler);
 		return 0;
 	}
+
+	i2ob_gendisk.next = gendisk_head;
+	gendisk_head = &i2ob_gendisk;
+	i2ob_gendisk.nr_real = MAX_I2OB;
 
 	/*
 	 *	Finally see what is actually plugged in to our controllers


--------------F9EED53010E2A92EC3C8DCDB--

