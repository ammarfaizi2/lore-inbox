Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTFCWcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTFCWcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:32:55 -0400
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:49168
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S261773AbTFCWcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:32:20 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33EB7@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
       "'Marcelo Tosatti'" <marcelo@conectiva.com.br>
Subject: [PATCH] serial.c 2.4.20 - ST16654 xmit data loss
Date: Tue, 3 Jun 2003 15:45:47 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes transmit FIFO overrun that affects ST16654 UART only.
Bug found by William King [William.King@dadaboom.com]
Symptom: random loss of transmit data, worse at low baud rates.
Cause: on 16654 UART, default transmit FIFO trigger level is 8
       instead of zero, so full FIFO depth is not available 
       when transmit interrupt arrives. Race between UART 
       transmitting last 8 bytes still in TX FIFO and driver 
       writing full FIFO length of new data to TX FIFO.

diff -Naur -X dontdiff.txt linux-2.4.20/drivers/char/serial.c
patched-2.4.20/drivers/char/serial.c
--- linux-2.4.20/drivers/char/serial.c	Thu Nov 28 15:53:12 2002
+++ patched-2.4.20/drivers/char/serial.c	Tue May 27 15:14:58 2003
@@ -306,8 +306,8 @@
 	{ "TI16750", 64, UART_CLEAR_FIFO | UART_USE_FIFO},
 	{ "Startech", 1, 0},	/* usurped by cyclades.c */
 	{ "16C950/954", 128, UART_CLEAR_FIFO | UART_USE_FIFO},
-	{ "ST16654", 64, UART_CLEAR_FIFO | UART_USE_FIFO |
-		  UART_STARTECH }, 
+	{ "ST16654", 64-8, UART_CLEAR_FIFO | UART_USE_FIFO |
+		  UART_STARTECH },	/* ST16654 xmit trigger lvl = 8 */
 	{ "XR16850", 128, UART_CLEAR_FIFO | UART_USE_FIFO |
 		  UART_STARTECH },
 	{ "RSA", 2048, UART_CLEAR_FIFO | UART_USE_FIFO }, 
