Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTEYOsg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 10:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbTEYOsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 10:48:36 -0400
Received: from mail-3.tiscali.it ([195.130.225.149]:27551 "EHLO
	mail-3.tiscali.it") by vger.kernel.org with ESMTP id S262720AbTEYOsf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 10:48:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Daniele Bellucci <danielebellucci@libero.it>
To: linux-kernel@vger.kernel.org
Subject: replaced BKL in rio500.c [2.5.69]
Date: Sun, 25 May 2003 17:01:41 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305251701.41504.danielebellucci@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In open_rio a BKL is acquired, there is no need because rio500 never sleeps in such control path.
Also, if you look at ioctl_rio a semaphore is acquired/released for the same check.



--- linux-2.5.69/drivers/usb/miscrio500.c       2003-05-26 16:23:20.000000000 +0200
+++ linux-2.5.69-new/drivers/usb/misc/rio500.c  2003-05-26 16:24:36.000000000 +0200
@@ -23,6 +23,9 @@
  *
  * Based upon mouse.c (Brad Keryan) and printer.c (Michael Gee).
  *
+ * Changelog:
+ * 25/05/03  replaced lock/unlock_kernel with up/down in open_rio.
+ *           Daniele Bellucci (bellucda@tiscali.it) 
  * */
 
 #include <linux/module.h>
@@ -81,17 +84,17 @@
 {
        struct rio_usb_data *rio = &rio_instance;
 
-       lock_kernel();
+       down(&(rio->lock));
 
        if (rio->isopen || !rio->present) {
-               unlock_kernel();
+               up(&(rio->lock));
                return -EBUSY;
        }
        rio->isopen = 1;
 
        init_waitqueue_head(&rio->wait_q);
 
-       unlock_kernel();
+       up(&(rio->lock));
 
        info("Rio opened.");
 

