Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbTHXLeG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbTHXLeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:34:06 -0400
Received: from coderock.org ([193.77.147.115]:63492 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263372AbTHXLeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:34:03 -0400
From: Domen Puncer <domen@coderock.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.0-test4][Bug 976] modprobe pcnet32 (no card) then ns83820 (card present) causes oops
Date: Sun, 24 Aug 2003 13:33:58 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308241333.58457.domen@coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The problem in pcnet32 is, that it doesn't unregister pci, if there's no
hardware.

This patch solves the problem.
As Barry K. Nathan reported, it also works if you have the card.

Feedback welcome.


        Domen


--- linux-2.6.0-test4-clean/drivers/net/pcnet32.c	2003-08-24 11:42:49.000000000 +0200
+++ linux-2.6.0-test4/drivers/net/pcnet32.c	2003-08-24 11:42:38.000000000 +0200
@@ -1726,6 +1726,7 @@
 /* An additional parameter that may be passed in... */
 static int debug = -1;
 static int tx_start_pt = -1;
+static int pcnet32_have_pci;
 
 static int __init pcnet32_init_module(void)
 {
@@ -1738,7 +1739,8 @@
 	tx_start = tx_start_pt;
 
     /* find the PCI devices */
-    pci_module_init(&pcnet32_driver);
+    if (!pci_module_init(&pcnet32_driver))
+	pcnet32_have_pci = 1;
 
     /* should we find any remaining VLbus devices ? */
     if (pcnet32vlb)
@@ -1747,7 +1749,7 @@
     if (cards_found)
 	printk(KERN_INFO PFX "%d cards_found.\n", cards_found);
     
-    return cards_found ? 0 : -ENODEV;
+    return (pcnet32_have_pci + cards_found) ? 0 : -ENODEV;
 }
 
 static void __exit pcnet32_cleanup_module(void)
@@ -1765,6 +1767,9 @@
 	free_netdev(pcnet32_dev);
 	pcnet32_dev = next_dev;
     }
+
+    if (pcnet32_have_pci)
+	pci_unregister_driver(&pcnet32_driver);
 }
 
 module_init(pcnet32_init_module);

