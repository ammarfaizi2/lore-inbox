Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSGHMmL>; Mon, 8 Jul 2002 08:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSGHMmK>; Mon, 8 Jul 2002 08:42:10 -0400
Received: from [195.63.194.11] ([195.63.194.11]:778 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316884AbSGHMmI>;
	Mon, 8 Jul 2002 08:42:08 -0400
Message-ID: <3D29893D.2040909@evision-ventures.com>
Date: Mon, 08 Jul 2002 14:44:45 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.25 end_request trivia
References: <Pine.LNX.4.33.0207051646280.2484-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020200010201000909040009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200010201000909040009
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

The following patch does the following:

1. Make airo include tqueue.h, which is needed to make this driver
compile at all again.

2. Adjust aztcd.c and sonycd535.c to the recent end_request() signature
changes.

The patch is against 2.5.24, but still applies cleanly on top of 2.5.25.

--------------020200010201000909040009
Content-Type: text/plain;
 name="misc-2.5.24.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.5.24.diff"

diff -urN linux-2.5.24/drivers/cdrom/aztcd.c linux/drivers/cdrom/aztcd.c
--- linux-2.5.24/drivers/cdrom/aztcd.c	2002-06-21 00:53:56.000000000 +0200
+++ linux/drivers/cdrom/aztcd.c	2002-06-23 20:12:27.000000000 +0200
@@ -2083,12 +2083,12 @@
 				}
 				azt_state = AZT_S_IDLE;
 				while (current_valid())
-					end_request(0);
+					end_request(CURRENT, 0);
 				return;
 			}
 
 /*	  if (aztSendCmd(ACMD_SET_MODE)) RETURN("azt_poll 3");
-	  outb(0x01, DATA_PORT);          
+	  outb(0x01, DATA_PORT);
 	  PA_OK;
 	  STEN_LOW;
 */
@@ -2138,7 +2138,7 @@
 				}
 				azt_state = AZT_S_IDLE;
 				while (current_valid())
-					end_request(0);
+					end_request(CURRENT, 0);
 				return;
 			}
 
@@ -2236,7 +2236,7 @@
 						break;
 					}
 					if (current_valid())
-						end_request(0);
+						end_request(CURRENT, 0);
 					AztTries = 5;
 				}
 				azt_state = AZT_S_START;
diff -urN linux-2.5.24/drivers/cdrom/sonycd535.c linux/drivers/cdrom/sonycd535.c
--- linux-2.5.24/drivers/cdrom/sonycd535.c	2002-06-21 00:53:49.000000000 +0200
+++ linux/drivers/cdrom/sonycd535.c	2002-06-23 20:12:27.000000000 +0200
@@ -805,14 +805,8 @@
 	Byte cmd[2];
 
 	while (1) {
-		/*
-		 * The beginning here is stolen from the hard disk driver.  I hope
-		 * it's right.
-		 */
-		if (blk_queue_empty(QUEUE)) {
-			CLEAR_INTR;
+		if (blk_queue_empty(QUEUE))
 			return;
-		}
 
 		dev = minor(CURRENT->rq_dev);
 		block = CURRENT->sector;
@@ -828,7 +822,6 @@
 				 * If the block address is invalid or the request goes beyond the end of
 				 * the media, return an error.
 				 */
-				
 				if (sony_toc->lead_out_start_lba <= (block / 4)) {
 					end_request(CURRENT, 0);
 					return;
diff -urN linux-2.5.24/drivers/net/wireless/airo.c linux/drivers/net/wireless/airo.c
--- linux-2.5.24/drivers/net/wireless/airo.c	2002-06-21 00:53:45.000000000 +0200
+++ linux/drivers/net/wireless/airo.c	2002-06-23 18:25:56.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/in.h>
+#include <linux/tqueue.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/bitops.h>

--------------020200010201000909040009--

