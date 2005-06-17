Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVFQF1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVFQF1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 01:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVFQF1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 01:27:17 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:38379 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261902AbVFQF1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 01:27:11 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] silence cs89x0
Date: Fri, 17 Jun 2005 08:26:46 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W8lsCwTCOWYliOK"
Message-Id: <200506170826.46415.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_W8lsCwTCOWYliOK
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jeff,

cs89x0 talks a lot at boot. Seems like debug leftover.
This patch downgrades printks to KERN_DEBUG.
While we're at it, make these messages a bit less obscure.
--
vda

--Boundary-00=_W8lsCwTCOWYliOK
Content-Type: text/x-diff;
  charset="koi8-r";
  name="cs89x0.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cs89x0.c.diff"

cs89x0:cs89x0_probe(0x0)
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
PP_addr=0xffff
eth1: incorrect signature 0xffff
cs89x0: no cs8900 or cs8920 detected.  Be sure to disable PnP with SETUP


--- linux-2.6.12-rc5.src/drivers/net/cs89x0.h.orig	Tue Oct 19 00:54:39 2004
+++ linux-2.6.12-rc5.src/drivers/net/cs89x0.h	Fri Jun 17 01:04:53 2005
@@ -93,6 +93,7 @@
 #endif
 
 #define CHIP_EISA_ID_SIG 0x630E   /*  Product ID Code for Crystal Chip (CS8900 spec 4.3) */
+#define CHIP_EISA_ID_SIG_STR "0x630E"
 
 #ifdef IBMEIPKT
 #define EISA_ID_SIG 0x4D24	/*  IBM */
--- linux-2.6.12-rc5.src/drivers/net/cs89x0.c.orig	Tue May 31 16:18:35 2005
+++ linux-2.6.12-rc5.src/drivers/net/cs89x0.c	Fri Jun 17 01:06:04 2005
@@ -416,6 +416,7 @@ cs89x0_probe1(struct net_device *dev, in
 	struct net_local *lp = netdev_priv(dev);
 	static unsigned version_printed;
 	int i;
+	int tmp;
 	unsigned rev_type = 0;
 	int eeprom_buff[CHKSUM_LEN];
 	int retval;
@@ -467,14 +468,17 @@ cs89x0_probe1(struct net_device *dev, in
 				goto out2;
 			}
 	}
-printk("PP_addr=0x%x\n", inw(ioaddr + ADD_PORT));
+	printk(KERN_DEBUG "PP_addr at %x: 0x%x\n",
+			ioaddr + ADD_PORT, inw(ioaddr + ADD_PORT));
 
 	ioaddr &= ~3;
 	outw(PP_ChipID, ioaddr + ADD_PORT);
 
-	if (inw(ioaddr + DATA_PORT) != CHIP_EISA_ID_SIG) {
-		printk(KERN_ERR "%s: incorrect signature 0x%x\n",
-			dev->name, inw(ioaddr + DATA_PORT));
+	tmp = inw(ioaddr + DATA_PORT);
+	if (tmp != CHIP_EISA_ID_SIG) {
+		printk(KERN_DEBUG "%s: incorrect signature at %x: 0x%x!="
+			CHIP_EISA_ID_SIG_STR "\n",
+			dev->name, ioaddr + DATA_PORT, tmp);
   		retval = -ENODEV;
   		goto out2;
 	}

--Boundary-00=_W8lsCwTCOWYliOK--

