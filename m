Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268833AbRHFPs1>; Mon, 6 Aug 2001 11:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268831AbRHFPsS>; Mon, 6 Aug 2001 11:48:18 -0400
Received: from mail.teraport.de ([195.143.8.72]:1665 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S268675AbRHFPsC>;
	Mon, 6 Aug 2001 11:48:02 -0400
Message-ID: <3B6EBC34.9578EA4E@TeraPort.de>
Date: Mon, 06 Aug 2001 17:48:04 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] eepro100.c - Add option to disable power saving in 2.4.7-ac7
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/06/2001 05:48:04 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/06/2001 05:48:11 PM,
	Serialize complete at 08/06/2001 05:48:11 PM
Content-Type: multipart/mixed;
 boundary="------------666ABCD4088CFD06A7523195"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------666ABCD4088CFD06A7523195
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

Hi,

 after realizing that my first attempt for this patch was to
enthusiastic, I have no a somewhat stripped down version. Compiles
against 2.4.7-ac7.

 The patch adds the option "power_save" to eepro100. If "1" (default),
power save handling is done as normal. If "0", no power saving is done.
This is to workaround some flaky eepro100 adapters that do not survive
D0->D2-D0 transitions.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------666ABCD4088CFD06A7523195
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii;
 name="eepro100-power_save.txt"
Content-Disposition: inline;
 filename="eepro100-power_save.txt"

--- linux-2.4.7-ac7/drivers/net/eepro100.c-orig-ac7	Mon Aug  6 10:36:54 2001
+++ linux-2.4.7-ac7/drivers/net/eepro100.c	Mon Aug  6 17:32:38 2001
@@ -60,6 +60,8 @@
 static int full_duplex[] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int options[] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int debug = -1;			/* The debug level */
+/* power_save option */
+static int power_save = 1;
 
 /* A few values that may be tweaked. */
 /* The ring sizes should be a power of two for efficiency. */
@@ -125,6 +127,7 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(multicast_filter_limit, "i");
+MODULE_PARM(power_save, "i");
 MODULE_PARM_DESC(debug, "eepro100 debug level (0-6)");
 MODULE_PARM_DESC(options, "eepro100: Bits 0-3: tranceiver type, bit 4: full duplex, bit 5: 100Mbps");
 MODULE_PARM_DESC(full_duplex, "eepro100 full duplex setting(s) (1)");
@@ -136,6 +139,7 @@
 MODULE_PARM_DESC(rx_copybreak, "eepro100 copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(max_interrupt_work, "eepro100 maximum events handled per interrupt");
 MODULE_PARM_DESC(multicast_filter_limit, "eepro100 maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(power_save, "Disable/Enable power saving (0,1). Default 1.");
 
 #define RUN_AT(x) (jiffies + (x))
 
@@ -778,7 +782,11 @@
 	udelay(10);
 
 	/* Put chip into power state D2 until we open() it. */
-	pci_set_power_state(pdev, 2);
+	if ((power_save < 0) || (power_save > 1))
+	  power_save = 1;
+	printk(KERN_INFO "  power_save = %d.\n",power_save);
+	if (power_save)
+	  pci_set_power_state(pdev, 2);
 
 	pci_set_drvdata (pdev, dev);
 
@@ -902,7 +910,8 @@
 
 	MOD_INC_USE_COUNT;
 
-	pci_set_power_state(sp->pdev, 0);
+	if (power_save)
+	  pci_set_power_state(sp->pdev, 0);
 
 	/* Set up the Tx queue early.. */
 	sp->cur_tx = 0;
@@ -1833,7 +1842,8 @@
 	if (speedo_debug > 0)
 		printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
 
-	pci_set_power_state(sp->pdev, 2);
+	if (power_save)
+	  pci_set_power_state(sp->pdev, 2);
 
 	MOD_DEC_USE_COUNT;
 
@@ -1902,12 +1912,14 @@
 		   They are currently serialized only with MDIO access from the
 		   timer routine.  2000/05/09 SAW */
 		saved_acpi = sp->pdev->current_state;
-		pci_set_power_state(sp->pdev, 0);
+		if (power_save)
+		  pci_set_power_state(sp->pdev, 0);
 		t = del_timer_sync(&sp->timer);
 		data->val_out = mdio_read(ioaddr, data->phy_id & 0x1f, data->reg_num & 0x1f);
 		if (t)
 			add_timer(&sp->timer); /* may be set to the past  --SAW */
-		pci_set_power_state(sp->pdev, saved_acpi);
+		if (power_save)
+		  pci_set_power_state(sp->pdev, saved_acpi);
 		return 0;
 
 	case SIOCSMIIREG:		/* Write MII PHY register. */
@@ -1915,12 +1927,14 @@
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		saved_acpi = sp->pdev->current_state;
-		pci_set_power_state(sp->pdev, 0);
+		if (power_save)
+		  pci_set_power_state(sp->pdev, 0);
 		t = del_timer_sync(&sp->timer);
 		mdio_write(ioaddr, data->phy_id, data->reg_num, data->val_in);
 		if (t)
 			add_timer(&sp->timer); /* may be set to the past  --SAW */
-		pci_set_power_state(sp->pdev, saved_acpi);
+		if (power_save)
+		  pci_set_power_state(sp->pdev, saved_acpi);
 		return 0;
 	default:
 		return -EOPNOTSUPP;

--------------666ABCD4088CFD06A7523195--

