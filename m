Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268951AbTBSQQ5>; Wed, 19 Feb 2003 11:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268950AbTBSQQ5>; Wed, 19 Feb 2003 11:16:57 -0500
Received: from gateway.dadaboom.com ([198.144.206.17]:780 "HELO
	spider.dadaboom.com") by vger.kernel.org with SMTP
	id <S268957AbTBSQQH>; Wed, 19 Feb 2003 11:16:07 -0500
Date: Wed, 19 Feb 2003 08:26:08 -0800 (PST)
From: William King <wrking@dadaboom.com>
X-X-Sender: wrking@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] serial.c xmit fifo overflow bug
Message-ID: <Pine.LNX.4.44.0302190815020.8391-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a patch to correct a xmit fifo overflow bug in serial.c. I 
limited the changes to a patch and not a feature addition which would add 
support for programming the tx fifo interrupt threshold. 

I've tested it on an embedded system which uses an Exar ST16C654 QUART.


--- serial.c	2003/02/17 18:03:39	1.1
+++ serial.c	2003/02/18 16:30:11
@@ -698,7 +698,24 @@
 		return;
 	}
 	
-	count = info->xmit_fifo_size;
+	if (info->state->type == PORT_16654) {
+		/*
+		 * The assumption in the following do loop is that the
+		 * uart will interrupt when the number of bytes in the
+		 * fifo drops to 0. The ST16654 will trigger the interrupt
+		 * when the number of bytes drops below a programmed
+		 * threshold. By default, the threshold is 8. There is no
+		 * code in place in this driver to alter the transmit fifo
+		 * threshold, so hard coding an 8 here is okay for now.
+		 *
+		 * This prevents overflowing the xmit fifo.
+		 *
+		 */
+		count = info->xmit_fifo_size - 8;
+	} else {
+		count = info->xmit_fifo_size;
+	}
+
 	do {
 		serial_out(info, UART_TX, info->xmit.buf[info->xmit.tail]);
 		info->xmit.tail = (info->xmit.tail + 1) & (SERIAL_XMIT_SIZE-1);

-- 

William King
Integrated Consulting, Inc.
William.King@dadaboom.com


