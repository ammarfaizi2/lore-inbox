Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266030AbTGDNAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 09:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbTGDNAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 09:00:34 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:6557 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S266030AbTGDNAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 09:00:11 -0400
Date: Fri, 4 Jul 2003 15:14:34 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] via-rhine 1.18-2.5: Fix Rhine-I regression
Message-ID: <20030704131434.GA4477@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20030704131317.GA4285@k3.hellgate.ch>
X-Operating-System: Linux 2.5.74 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch addresses a minor regression reported by Rhine-I users (leading
to occasional Tx timeouts).

I also merged some cosmetic changes.

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.18-2.5.diff"

--- linux-2.5/drivers/net/via-rhine.c.org	2003-05-21 07:16:17.000000000 +0200
+++ linux-2.5/drivers/net/via-rhine.c	2003-07-04 15:02:36.000000000 +0200
@@ -2,6 +2,8 @@
 /*
 	Written 1998-2001 by Donald Becker.
 
+	Current Maintainer: Roger Luethi <rl@hellgate.ch>
+
 	This software may be used and distributed according to the terms of
 	the GNU General Public License (GPL), incorporated herein by reference.
 	Drivers based on or derived from this code fall under the GPL and must
@@ -9,8 +11,9 @@
 	a complete program and may only be used when the entire operating
 	system is licensed under the GPL.
 
-	This driver is designed for the VIA VT86C100A Rhine-I. 
-	It also works with the 6102 Rhine-II, and 6105/6105M Rhine-III.   
+	This driver is designed for the VIA VT86C100A Rhine-I.
+	It also works with the Rhine-II (6102) and Rhine-III (6105/6105L/6105LOM
+	and management NIC 6105M).
 
 	The author may be reached as becker@scyld.com, or C/O
 	Scyld Computing Corporation
@@ -115,11 +118,15 @@
 	- Force flushing for PCI posted writes
 	- More reset code changes
 
+	LK1.1.18 (Roger Luethi)
+	- No filtering multicast in promisc mode (Edward Peng)
+	- Fix for Rhine-I Tx timeouts
+
 */
 
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.1.17"
-#define DRV_RELDATE	"March-1-2003"
+#define DRV_VERSION	"1.1.18-2.5"
+#define DRV_RELDATE	"July-4-2003"
 
 
 /* A few user-configurable values.
@@ -386,17 +393,17 @@
 	{ "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
 	  CanHaveMII | HasWOL },
 	{ "VIA VT6105 Rhine-III", RHINE_IOTYPE, 256,
-	  CanHaveMII | HasWOL },	  
+	  CanHaveMII | HasWOL },
 	{ "VIA VT6105M Rhine-III", RHINE_IOTYPE, 256,
-	  CanHaveMII | HasWOL },	  	  	 
+	  CanHaveMII | HasWOL },
 };
 
 static struct pci_device_id via_rhine_pci_tbl[] __devinitdata =
 {
 	{0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
 	{0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6102},
-	{0x1106, 0x3106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105},
-	{0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105M},	
+	{0x1106, 0x3106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105}, /* 6105{,L,LOM} */
+	{0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105M},
 	{0,}			/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, via_rhine_pci_tbl);
@@ -441,7 +448,7 @@
 	IntrRxWakeUp=0x8000,
 	IntrNormalSummary=0x0003, IntrAbnormalSummary=0xC260,
 	IntrTxDescRace=0x080000,	/* mapped from IntrStatus2 */
-	IntrTxErrSummary=0x082210,
+	IntrTxErrSummary=0x082218,
 };
 
 /* The Rx and Tx buffer descriptors. */
@@ -1655,11 +1662,18 @@
 			printk(KERN_INFO "%s: Tx descriptor write-back race.\n",
 				   dev->name);
 	}
-	if (intr_status & ( IntrTxAborted | IntrTxUnderrun | IntrTxDescRace ))
+	if ((intr_status & IntrTxError) && ~( IntrTxAborted | IntrTxUnderrun |
+										   IntrTxDescRace )) {
+		if (debug > 2)
+			printk(KERN_INFO "%s: Unspecified error.\n",
+				   dev->name);
+	}
+	if (intr_status & ( IntrTxAborted | IntrTxUnderrun | IntrTxDescRace |
+						IntrTxError ))
 		via_rhine_restart_tx(dev);
 
 	if (intr_status & ~( IntrLinkChange | IntrStatsMax | IntrTxUnderrun |
- 						 IntrTxError | IntrTxAborted | IntrNormalSummary |
+						 IntrTxError | IntrTxAborted | IntrNormalSummary |
 						 IntrTxDescRace )) {
 		if (debug > 1)
 			printk(KERN_ERR "%s: Something Wicked happened! %8.8x.\n",

--jRHKVT23PllUwdXP--
