Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbTGLVcW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 17:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268539AbTGLVcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 17:32:22 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:668 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S268537AbTGLVcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 17:32:20 -0400
Message-ID: <3F1081D7.9090209@portrix.net>
Date: Sat, 12 Jul 2003 23:47:03 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: kraxel@bytesex.org
CC: linux-kernel@vger.kernel.org
Subject: Improve error handling for msp3400.c
Content-Type: multipart/mixed;
 boundary="------------010803020408010601090404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803020408010601090404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

on read/send failure the msp3400 driver is trying three times to recover and 
is printing a message each time. On a unloaded system this happens at a rate 
of about 1/min while watching tv and is quite annoying, while non critical.
This patchs gets rid of it and instead raises the final error message to 
KERN_ERR if indeed the communication failed three times in a row.

Thanks,

Jan

-- 
Linux rubicon 2.5.75-mm1-jd10 #1 SMP Sat Jul 12 19:40:28 CEST 2003 i686

--------------010803020408010601090404
Content-Type: text/plain;
 name="msp3400.remove.warning"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msp3400.remove.warning"

--- linux-bk/drivers/media/video/msp3400.c	Fri May 30 20:29:35 2003
+++ 2.5.75-bk1-jd2/drivers/media/video/msp3400.c	Sat Jul 12 23:41:19 2003
@@ -192,13 +192,11 @@
 		if (2 == i2c_transfer(client->adapter,msgs,2))
 			break;
 		err++;
-		printk(KERN_WARNING "msp34xx: I/O error #%d (read 0x%02x/0x%02x)\n",
-		       err, dev, addr);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(HZ/10);
 	}
 	if (3 == err) {
-		printk(KERN_WARNING "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
+		printk(KERN_ERR "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
 		msp3400c_reset(client);
 		return -1;
 	}
@@ -221,13 +219,11 @@
 		if (5 == i2c_master_send(client, buffer, 5))
 			break;
 		err++;
-		printk(KERN_WARNING "msp34xx: I/O error #%d (write 0x%02x/0x%02x)\n",
-		       err, dev, addr);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(HZ/10);
 	}
 	if (3 == err) {
-		printk(KERN_WARNING "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
+		printk(KERN_ERR "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
 		msp3400c_reset(client);
 		return -1;
 	}

--------------010803020408010601090404--

