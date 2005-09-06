Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVIFCJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVIFCJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 22:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVIFCJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 22:09:44 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:63898 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751301AbVIFCJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 22:09:43 -0400
Message-ID: <3445.10.124.102.246.1125972580.squirrel@dominion>
Date: Tue, 6 Sep 2005 11:09:40 +0900 (JST)
Subject: [Patch] Peformance improvement of serial console via virtual
 serial port
From: "Taku Izumi" <izumi2005@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: "Russell King" <rmk@arm.linux.org.uk>
Reply-To: izumi2005@soft.fujitsu.com
User-Agent: SquirrelMail/1.4.5-1_rh4
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-2022-jp
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

This patch improves peformance of serial console by using FIFO.
I think original serial driver is not effective, but transfer rate of
real serial port is low, so this problem has not been exposed.

However, because transfer rate of virtual serial port (ex. Serial Over
Ethernet)
is higher than that of real serial port, this problem is exposed.
The output performance via virtual serial port is still low by using original
serial driver. I think original serial driver becomes bottoleneck.


Taku Izumi <izumi2005@soft.fujitsu.com>

----------patch-------->8----------------------------------------

diff -Npur linux-2.6.9.org/drivers/serial/8250.c
linux-2.6.9/drivers/serial/8250.c
--- linux-2.6.9.org/drivers/serial/8250.c       2005-08-08
11:17:38.556373366 +0900
+++ linux-2.6.9/drivers/serial/8250.c   2005-08-08 11:41:03.759131389 +0900
@@ -1943,18 +1943,33 @@ serial8250_console_write(struct console
        /*
         *      Now, do each character
         */
-       for (i = 0; i < count; i++, s++) {
-               wait_for_xmitr(up);
+       for (i = 0; i < count; ) {
+               int     fifo ;

+               wait_for_xmitr(up);
+               fifo = up->tx_loadsz ;
                /*
-                *      Send the character out.
+                *      Send the character out using FIFO.
                 *      If a LF, also do CR...
                 */
-               serial_out(up, UART_TX, *s);
-               if (*s == 10) {
-                       wait_for_xmitr(up);
-                       serial_out(up, UART_TX, 13);
-               }
+               do {
+                       serial_out(up, UART_TX, *s);
+                       fifo-- ;
+                       if (*s == 10) {
+                               if (fifo > 0) {
+                                       serial_out(up, UART_TX, 13);
+                                       fifo--;
+                               } else {
+                                       /* No room to add CR */
+                                       wait_for_xmitr(up);
+                                       fifo = up->tx_loadsz ;
+                                       serial_out(up, UART_TX, 13);
+                                       fifo--;
+                               }
+                       }
+                       i++ ;
+                       s++ ;
+               } while (fifo > 0 && i < count ) ;
        }

        /*
----------------------------------------------------------------------


