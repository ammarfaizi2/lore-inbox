Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWGTKLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWGTKLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 06:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWGTKLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 06:11:05 -0400
Received: from server6.greatnet.de ([83.133.96.26]:30931 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932575AbWGTKLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 06:11:04 -0400
Message-ID: <44BF56B8.9050502@nachtwindheim.de>
Date: Thu, 20 Jul 2006 12:11:04 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: jgarzik@pobox.com
Cc: kernel-janitors@lists.osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][NET] ULi526x - driver cleanups
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Some little cleanups for ULI-TULIP-driver:

pci_module_init() conversion to pci_register_driver()
remove rc, an unneeded variable from uli526x_module_init()
let the debug macros use correct loglevels
add a loglevel to a printk
let some code more look like CodingStyle

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc2/drivers/net/tulip/uli526x.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tulip/uli526x.c	2006-07-20 11:43:07.000000000 +0200
@@ -82,9 +82,9 @@
 #define ULI526X_TX_TIMEOUT ((16*HZ)/2)	/* tx packet time-out time 8 s" */
 #define ULI526X_TX_KICK 	(4*HZ/2)	/* tx packet Kick-out time 2 s" */
 
-#define ULI526X_DBUG(dbug_now, msg, value) if (uli526x_debug || (dbug_now)) printk(KERN_ERR DRV_NAME ": %s %lx\n", (msg), (long) (value))
+#define ULI526X_DBUG(dbug_now, msg, value) if (uli526x_debug || (dbug_now)) printk(KERN_DEBUG DRV_NAME ": %s %lx\n", (msg), (long) (value))
 
-#define SHOW_MEDIA_TYPE(mode) printk(KERN_ERR DRV_NAME ": Change Speed to %sMhz %s duplex\n",mode & 1 ?"100":"10", mode & 4 ? "full":"half");
+#define SHOW_MEDIA_TYPE(mode) printk(KERN_NOTICE DRV_NAME ": Change Speed to %sMhz %s duplex\n",mode & 1 ?"100":"10", mode & 4 ? "full":"half");
 
 
 /* CR9 definition: SROM/MII */
@@ -373,7 +373,8 @@
 	if (err)
 		goto err_out_res;
 
-	printk(KERN_INFO "%s: ULi M%04lx at pci%s,",dev->name,ent->driver_data >> 16,pci_name(pdev));
+	printk(KERN_INFO "%s: ULi M%04lx at pci%s,",dev->name,
+			ent->driver_data >> 16,pci_name(pdev));
 
 	for (i = 0; i < 6; i++)
 		printk("%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
@@ -1027,7 +1028,7 @@
 		if ( time_after(jiffies, dev->trans_start + ULI526X_TX_TIMEOUT) ) {
 			db->reset_TXtimeout++;
 			db->wait_reset = 1;
-			printk( "%s: Tx timeout - resetting\n",
+			printk(KERN_ERR "%s: Tx timeout - resetting\n",
 			       dev->name);
 		}
 	}
@@ -1671,18 +1672,17 @@
 
 
 static struct pci_device_id uli526x_pci_tbl[] = {
-	{ 0x10B9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_ULI5261_ID },
-	{ 0x10B9, 0x5263, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_ULI5263_ID },
-	{ 0, }
+	{0x10B9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_ULI5261_ID},
+	{0x10B9, 0x5263, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_ULI5263_ID},
+	{}
 };
 MODULE_DEVICE_TABLE(pci, uli526x_pci_tbl);
 
-
 static struct pci_driver uli526x_driver = {
-	.name		= "uli526x",
-	.id_table	= uli526x_pci_tbl,
-	.probe		= uli526x_init_one,
-	.remove		= __devexit_p(uli526x_remove_one),
+	.name = "uli526x",
+	.id_table = uli526x_pci_tbl,
+	.probe = uli526x_init_one,
+	.remove = __devexit_p(uli526x_remove_one),
 };
 
 MODULE_AUTHOR("Peer Chen, peer.chen@uli.com.tw");
@@ -1702,7 +1702,6 @@
 
 static int __init uli526x_init_module(void)
 {
-	int rc;
 
 	printk(version);
 	printed_version = 1;
@@ -1714,25 +1713,21 @@
 	if (cr6set)
 		uli526x_cr6_user_set = cr6set;
 
- 	switch(mode) {
+ 	switch (mode) {
    	case ULI526X_10MHF:
 	case ULI526X_100MHF:
 	case ULI526X_10MFD:
 	case ULI526X_100MFD:
 		uli526x_media_mode = mode;
 		break;
-	default:uli526x_media_mode = ULI526X_AUTO;
+	default:
+		uli526x_media_mode = ULI526X_AUTO;
 		break;
 	}
 
-	rc = pci_module_init(&uli526x_driver);
-	if (rc < 0)
-		return rc;
-
-	return 0;
+	return pci_register_driver(&uli526x_driver);
 }
 
-
 /*
  *	Description:
  *	when user used rmmod to delete module, system invoked clean_module()


