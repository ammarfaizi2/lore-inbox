Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312878AbSC0BlV>; Tue, 26 Mar 2002 20:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312789AbSC0BlF>; Tue, 26 Mar 2002 20:41:05 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:36625 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S312829AbSC0Bkv>; Tue, 26 Mar 2002 20:40:51 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7738@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-serial'" <linux-serial@vger.kernel.org>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Roman Kurakin'" <rik@cronyx.ru>,
        "'Russell King'" <rmk@arm.linux.org.uk>,
        "'Theodore Tso'" <tytso@mit.edu>
Subject: [PATCH] serial port in use bug - discussion please
Date: Tue, 26 Mar 2002 17:40:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to function set_serial_info() to fix two issues: 

1. Function returned -EADDRINUSE when attempt was made to change fields 
such as "baud_base" on a memory based serial port with the setserial 
command. A check was added to bypass the port-in-use test loop if the 
existing "iomem_base" field is nonzero, indicating a memory based 
serial port that cannot be moved by this function. 

2. Function allowed attempts to set "port" field on memory based serial 
ports to a nonzero value. The iomem_base field cannot be changed by this 
function, so a test was added to return -EINVALID when new "port" field 
is nonzero and existing "iomem_base" field is also nonzero. 

For kernel files rev 2.14.19-pre3

Contributor: Roman Kurakin <rik@cronyx.ru>

 Subject: Serial.c Bug
 Date: Wed, 14 Nov 2001 13:02:47 +0300
 From: Roman Kurakin <rik@cronyx.ru>
 To: linux-kernel@vger.kernel.org

   I have found a bug. It is in support of serial cards which uses
   memory for I/O instead of ports. I made a patch for serial.c and
   fix one place, but probably the problem like this one could be
   somewhere else.

   If you try to use setserial with such cards you will get "Address in use"
   (-EADDRINUSE)

   Best regards,
   Roman Kurakin

diff -urN -X dontdiff.txt linux-2.4.19-pre3/drivers/char/serial.c
patched/drivers/char/serial.c
--- linux-2.4.19-pre3/drivers/char/serial.c	Thu Mar 14 16:19:02 2002
+++ patched/drivers/char/serial.c	Tue Mar 26 16:06:06 2002
@@ -2131,6 +2131,7 @@
 	if ((new_serial.irq >= NR_IRQS) || (new_serial.irq < 0) || 
 	    (new_serial.baud_base < 9600)|| (new_serial.type < PORT_UNKNOWN)
||
 	    (new_serial.type > PORT_MAX) || (new_serial.type == PORT_CIRRUS)
||
+	    (new_port && state->iomem_base) ||
 	    (new_serial.type == PORT_STARTECH)) {
 		return -EINVAL;
 	}
@@ -2141,7 +2142,7 @@
 			uart_config[new_serial.type].dfl_xmit_fifo_size;
 
 	/* Make sure address is not already in use */
-	if (new_serial.type) {
+	if (!state->iomem_base && new_serial.type) {
 		for (i = 0 ; i < NR_PORTS; i++)
 			if ((state != &rs_table[i]) &&
 			    (rs_table[i].port == new_port) &&


---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------


