Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbTEARfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTEARfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:35:25 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:17590
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261524AbTEARfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:35:21 -0400
Message-ID: <3EB15DBF.3060608@rogers.com>
Date: Thu, 01 May 2003 13:47:43 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] NE2000 driver updates
References: <3EB15127.2060409@rogers.com>
In-Reply-To: <3EB15127.2060409@rogers.com>
Content-Type: multipart/mixed;
 boundary="------------060302050705010907090804"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Thu, 1 May 2003 13:47:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302050705010907090804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060302050705010907090804
Content-Type: text/plain;
 name="ne-bad.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ne-bad.patch"

--- linux-2.5.66-nelist/drivers/net/ne.c	2003-05-01 11:05:56.000000000 -0400
+++ linux-2.5.66-nebad/drivers/net/ne.c	2003-05-01 11:18:19.000000000 -0400
@@ -145,10 +145,10 @@
 
 static int ne_legacy_probe(unsigned long base_addr, unsigned long irq, unsigned long bad);
 
-static int ne_probe1(struct net_device *dev, int ioaddr);
+static int ne_probe1(struct net_device *dev, int ioaddr, int bad);
 
 static int ne_create(struct net_device **ndev, unsigned long base_addr, 
-		unsigned long irq, unsigned long bad);
+		unsigned long irq, int bad);
 static void ne_remove(struct net_device *dev);
 
 static int ne_open(struct net_device *dev);
@@ -223,7 +223,7 @@
 	return err;
 }
 
-static int ne_create(struct net_device **ndev, unsigned long base_addr, unsigned long irq, unsigned long bad)
+static int ne_create(struct net_device **ndev, unsigned long base_addr, unsigned long irq, int bad)
 {
 	int err;
 	
@@ -237,7 +237,7 @@
 	(*ndev)->mem_end = bad;
 	SET_MODULE_OWNER(*ndev);
 	
-	if (ne_probe1(*ndev, (*ndev)->base_addr) != 0) {	/* Shouldn't happen. */
+	if (ne_probe1(*ndev, (*ndev)->base_addr, bad) != 0) {	/* Shouldn't happen. */
 		printk(KERN_ERR "ne.c: Probe at %#lx failed\n", (*ndev)->base_addr);
 		err = -ENXIO;
 		goto probe_fail;
@@ -268,14 +268,14 @@
 	}
 }
 
-static int __init ne_probe1(struct net_device *dev, int ioaddr)
+static int __init ne_probe1(struct net_device *dev, int ioaddr, int bad_card)
 {
 	int i;
 	unsigned char SA_prom[32];
 	int wordlength = 2;
 	const char *name = NULL;
 	int start_page, stop_page;
-	int neX000, ctron, copam, bad_card;
+	int neX000, ctron, copam;
 	int reg0, ret;
 	static unsigned version_printed;
 
@@ -311,11 +311,8 @@
 
 	/* A user with a poor card that fails to ack the reset, or that
 	   does not have a valid 0x57,0x57 signature can still use this
-	   without having to recompile. Specifying an i/o address along
-	   with an otherwise unused dev->mem_end value of "0xBAD" will
-	   cause the driver to skip these parts of the probe. */
-
-	bad_card = ((dev->base_addr != 0) && (dev->mem_end == 0xbad));
+	   without having to recompile. Specifying a bad card will cause 
+	   the driver to skip these parts of the probe. */
 
 	/* Reset card. Who knows what dain-bramaged state it was left in. */
 
@@ -766,7 +763,7 @@
 #define MAX_NE_CARDS	4	/* Max number of NE cards per module */
 static int io[MAX_NE_CARDS];
 static int irq[MAX_NE_CARDS];
-static int bad[MAX_NE_CARDS];	/* 0xbad = bad sig or no reset ack */
+static int bad[MAX_NE_CARDS];	/* bad sig or no reset ack */
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");

--------------060302050705010907090804--

