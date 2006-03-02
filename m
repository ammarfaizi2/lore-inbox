Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWCBXL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWCBXL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWCBXJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:09:57 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:18870 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751295AbWCBXJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:53 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 8/9] cs4232: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:51 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.51563.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/sound/oss/cs4232.c
===================================================================
--- work-mm4.orig/sound/oss/cs4232.c	2006-01-02 20:21:10.000000000 -0700
+++ work-mm4/sound/oss/cs4232.c	2006-02-15 15:44:34.000000000 -0700
@@ -360,6 +360,8 @@
 static int __initdata synthirq	= -1;
 static int __initdata isapnp	= 1;
 
+static unsigned int cs4232_devices;
+
 MODULE_DESCRIPTION("CS4232 based soundcard driver"); 
 MODULE_AUTHOR("Hannu Savolainen, Paul Barton-Davis"); 
 MODULE_LICENSE("GPL");
@@ -421,6 +423,7 @@
 		return -ENODEV;
 	}
 	pnp_set_drvdata(dev,isapnpcfg);
+	cs4232_devices++;
 	return 0;
 }
 
@@ -455,10 +458,11 @@
 #endif
 	cfg.irq = -1;
 
-	if (isapnp &&
-	    (pnp_register_driver(&cs4232_driver) > 0)
-	)
-		return 0;
+	if (isapnp) {
+		pnp_register_driver(&cs4232_driver);
+		if (cs4232_devices)
+			return 0;
+	}
 
 	if(io==-1||irq==-1||dma==-1)
 	{
@@ -503,7 +507,8 @@
 	int ints[7];
 
 	/* If we have isapnp cards, no need for options */
-	if (pnp_register_driver(&cs4232_driver) > 0)
+	pnp_register_driver(&cs4232_driver);
+	if (cs4232_devices)
 		return 1;
 	
 	str = get_options(str, ARRAY_SIZE(ints), ints);
