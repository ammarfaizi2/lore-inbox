Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268430AbUH3Buh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268430AbUH3Buh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 21:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUH3Buh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 21:50:37 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:60555 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S268430AbUH3Bua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 21:50:30 -0400
Date: Mon, 30 Aug 2004 03:50:18 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk, akpm@osdl.org
Subject: [PATCH] Add support for Possio GCC AKA PCMCIA Siemens MC45
Message-ID: <20040830015018.GB5298@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   This ugly hack add support for Siemens MC45 PCMCIA GPRS card (which is
identical to Possio GCC, and which is offered by one of our local GPRS
providers).  Card has unfortunate feature that after poweron oxcf950 chip 
is fully powered and works, but attached MC45 modem is powered down :-(  
There is a special sequence (which takes 1 sec :-( ) to poweron
MC45 (and after MC45 powers on, it takes more than 2 secs until firmware
fully boots...) which needs to be executed after all powerons.

   I'm really not familiar with PCMCIA subsystem, so I have no idea whether
I should issue request_region() on rest of oxcf950 address range (0-7
is UART, 8-F are special configuration registers), or how this should be
better integrated with PM system and so on - I just put it in same place
where another hack already lived...

   Card uses 18.432MHz XTAL, so to get it to work you must add lines below
to the /etc/pcmcia/serial.opts.

case "$MANFID-$FUNCID-$PRODID_1-$PRODID_2-$PRODID_3-$PRODID_4" in
'030c,0003-2-GPRS-CARD--')
    SERIAL_OPTS="baud_base 1152000"
    ;;
esac

						Best regards,
							Petr Vandrovec



diff -urN linux/drivers/serial/serial_cs.c linux/drivers/serial/serial_cs.c
--- linux/drivers/serial/serial_cs.c   2004-08-28 23:19:58.000000000 +0200
+++ linux/drivers/serial/serial_cs.c   2004-08-30 02:53:05.000000000 +0200
@@ -44,6 +44,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/major.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -112,6 +113,8 @@
 	int			multi;
 	int			slave;
 	int			manfid;
+	int			prodid;
+	int			c950ctrl;
 	dev_node_t		node[4];
 	int			line[4];
 };
@@ -127,6 +130,33 @@
 
 static dev_link_t *dev_list = NULL;
 
+static void wakeup_card(struct serial_info *info)
+{
+	int ctrl = info->c950ctrl;
+
+	if (info->manfid == MANFID_OXSEMI) {
+		outb(12, ctrl + 1);
+	} else if (info->manfid == MANFID_SIEMENS && info->prodid == PRODID_SIEMENS_MC45) {
+		/* request_region? oxsemi branch does no request_region too... */
+		/* This sequence is needed to properly initialize MC45 attached to OXCF950.
+		 * I tried decreasing these msleep()s, but it worked properly (survived
+		 * 1000 stop/start operations) with these timeouts (or bigger). */
+		outb(0xA, ctrl + 1);
+		msleep(100);
+		outb(0xE, ctrl + 1);
+		msleep(300);
+		outb(0xC, ctrl + 1);
+		msleep(100);
+		outb(0xE, ctrl + 1);
+		msleep(200);
+		outb(0xF, ctrl + 1);
+		msleep(100);
+		outb(0xE, ctrl + 1);
+		msleep(100);
+		outb(0xC, ctrl + 1);
+	}
+}
+
 /*======================================================================
 
     After a card is removed, serial_remove() will unregister
@@ -191,6 +221,7 @@
 
 		for (i = 0; i < info->ndev; i++)
 			serial8250_resume_port(info->line[i]);
+		wakeup_card(info);
 	}
 }
 
@@ -554,15 +585,20 @@
 	}
 
 	/* The Oxford Semiconductor OXCF950 cards are in fact single-port:
-	   8 registers are for the UART, the others are extra registers */
-	if (info->manfid == MANFID_OXSEMI) {
+	   8 registers are for the UART, the others are extra registers.
+	   Siemen's MC45 PCMCIA (Possio's GCC) is OXCF950 based too. */
+	if (info->manfid == MANFID_OXSEMI ||
+	    (info->manfid == MANFID_SIEMENS && info->prodid == PRODID_SIEMENS_MC45)) {
+		int err;
+
 		if (cf->index == 1 || cf->index == 3) {
-			setup_serial(info, base2, link->irq.AssignedIRQ);
-			outb(12, link->io.BasePort1 + 1);
+			err = setup_serial(info, base2, link->irq.AssignedIRQ);
+			base2 = link->io.BasePort1;
 		} else {
-			setup_serial(info, link->io.BasePort1, link->irq.AssignedIRQ);
-			outb(12, base2 + 1);
+			err = setup_serial(info, link->io.BasePort1, link->irq.AssignedIRQ);
 		}
+		info->c950ctrl = base2;
+		wakeup_card(info);
 		return 0;
 	}
 
@@ -622,9 +658,10 @@
 	tuple.DesiredTuple = CISTPL_MANFID;
 	if (first_tuple(handle, &tuple, &parse) == CS_SUCCESS) {
 		info->manfid = le16_to_cpu(buf[0]);
+		info->prodid = le16_to_cpu(buf[1]);
 		for (i = 0; i < MULTI_COUNT; i++)
 			if ((info->manfid == multi_id[i].manfid) &&
-			    (le16_to_cpu(buf[1]) == multi_id[i].prodid))
+			    (info->prodid == multi_id[i].prodid))
 				break;
 		if (i < MULTI_COUNT)
 			info->multi = multi_id[i].multi;
