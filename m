Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268870AbRHFQuS>; Mon, 6 Aug 2001 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268872AbRHFQt6>; Mon, 6 Aug 2001 12:49:58 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:35337 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S268870AbRHFQtq>; Mon, 6 Aug 2001 12:49:46 -0400
Date: Mon, 6 Aug 2001 18:49:44 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: [PATCH] eepro100.c - Add option to disable power saving in
 2.4.7-ac7
In-Reply-To: <3B6EBC34.9578EA4E@TeraPort.de>
Message-ID: <Pine.LNX.4.33.0108061847110.8689-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Martin Knoblauch wrote:

>  after realizing that my first attempt for this patch was to
> enthusiastic, I have no a somewhat stripped down version. Compiles
> against 2.4.7-ac7.

I have an even smaller version. You can select the D state for sleeping as 
a parameter, 0 should fix Martin's flaky hardware, 2 is the default - 
current behavior.

--Kai

--- linux-2.4.7-ac2/drivers/net/eepro100.c	Sat Jul 28 10:24:55 2001
+++ linux-2.4.7-ac2.work/drivers/net/eepro100.c	Mon Aug  6 18:49:11 2001
@@ -60,6 +60,8 @@
 static int full_duplex[] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int options[] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int debug = -1;			/* The debug level */
+/* power save D state when device is not open */
+static unsigned int sleep_state = 2;
 
 /* A few values that may be tweaked. */
 /* The ring sizes should be a power of two for efficiency. */
@@ -125,6 +127,7 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(multicast_filter_limit, "i");
+MODULE_PARM(sleep_state, "i");
 MODULE_PARM_DESC(debug, "eepro100 debug level (0-6)");
 MODULE_PARM_DESC(options, "eepro100: Bits 0-3: tranceiver type, bit 4: full duplex, bit 5: 100Mbps");
 MODULE_PARM_DESC(full_duplex, "eepro100 full duplex setting(s) (1)");
@@ -136,6 +139,7 @@
 MODULE_PARM_DESC(rx_copybreak, "eepro100 copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(max_interrupt_work, "eepro100 maximum events handled per interrupt");
 MODULE_PARM_DESC(multicast_filter_limit, "eepro100 maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(sleep_state, "eepro100 power save D state (default 2)");
 
 #define RUN_AT(x) (jiffies + (x))
 
@@ -777,8 +781,10 @@
 	inl(ioaddr + SCBPort);
 	udelay(10);
 
-	/* Put chip into power state D2 until we open() it. */
-	pci_set_power_state(pdev, 2);
+	if (sleep_state > 2)
+		sleep_state = 2;
+	/* Put chip into power saving state until we open() it. */
+	pci_set_power_state(pdev, sleep_state);
 
 	pci_set_drvdata (pdev, dev);
 
@@ -1833,7 +1839,7 @@
 	if (speedo_debug > 0)
 		printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
 
-	pci_set_power_state(sp->pdev, 2);
+	pci_set_power_state(sp->pdev, sleep_state);
 
 	MOD_DEC_USE_COUNT;
 

