Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269269AbTGJNkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269273AbTGJNkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:40:18 -0400
Received: from coderock.org ([193.77.147.115]:41993 "EHLO mail.coderock.org")
	by vger.kernel.org with ESMTP id S269269AbTGJNkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:40:11 -0400
From: Domen Puncer <root@coderock.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] check_region removal from 3c509.c
Date: Thu, 10 Jul 2003 15:54:52 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sAXD/RQs2J6eKVx"
Message-Id: <200307101554.52458.root@coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_sAXD/RQs2J6eKVx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

Replaced check_region() with request_region(), removed 2 #ifdefs.

This is first time i'm posting a patch, so please comment if something could 
be done better.


	Domen
--Boundary-00=_sAXD/RQs2J6eKVx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="3c509.c-check_region-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="3c509.c-check_region-2.patch"

--- linux-2.5.74/drivers/net/3c509.c-orig	2003-07-10 12:55:08.000000000 +0200
+++ linux-2.5.74/drivers/net/3c509.c	2003-07-10 15:01:41.000000000 +0200
@@ -370,9 +370,7 @@
 #if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 	static int pnp_cards;
 	struct pnp_dev *idev = NULL;
-#endif /* __ISAPNP__ */
 
-#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 	if (nopnp == 1)
 		goto no_pnp;
 
@@ -428,12 +426,15 @@
 #else
 	/* Select an open I/O location at 0x1*0 to do contention select. */
 	for ( ; id_port < 0x200; id_port += 0x10) {
-		if (check_region(id_port, 1))
+		if (!request_region(id_port, 1, "3c509"))
 			continue;
 		outb(0x00, id_port);
 		outb(0xff, id_port);
-		if (inb(id_port) & 0x01)
+		if (inb(id_port) & 0x01){
+			release_region(id_port, 1);
 			break;
+		} else
+			release_region(id_port, 1);
 	}
 	if (id_port >= 0x200) {
 		/* Rare -- do we really need a warning? */
@@ -496,19 +497,17 @@
 	{
 		unsigned int iobase = id_read_eeprom(8);
 		if_port = iobase >> 14;
+		irq = id_read_eeprom(9) >> 12;
 #ifdef CONFIG_X86_PC9800
 		ioaddr = 0x40d0 + ((iobase & 0x1f) << 8);
+		if (irq == 7)
+			irq = 6;
+		else if (irq == 15)
+			irq = 13;
 #else
 		ioaddr = 0x200 + ((iobase & 0x1f) << 4);
 #endif
 	}
-	irq = id_read_eeprom(9) >> 12;
-#ifdef CONFIG_X86_PC9800
-	if (irq == 7)
-		irq = 6;
-	else if (irq == 15)
-		irq = 13;
-#endif
 
 	dev = alloc_etherdev(sizeof (struct el3_private));
 	if (!dev)

--Boundary-00=_sAXD/RQs2J6eKVx--

