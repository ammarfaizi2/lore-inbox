Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752597AbVHGTRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbVHGTRh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbVHGTRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:17:37 -0400
Received: from dvhart.com ([64.146.134.43]:61056 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1752597AbVHGTRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:17:36 -0400
Date: Sun, 07 Aug 2005 12:17:38 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove warning about e1000_suspend
Message-ID: <256850000.1123442258@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e1000_suspend is only used under #ifdef CONFIG_PM. Move the declaration
of it to be the same way, just like e1000_resume, otherwise gcc whines 
on compile. I offer as evidence:

	static struct pci_driver e1000_driver = {
 	       .name     = e1000_driver_name,
 	      .id_table = e1000_pci_tbl,
  	      .probe    = e1000_probe,
  	      .remove   = __devexit_p(e1000_remove),
 	      /* Power Managment Hooks */
	#ifdef CONFIG_PM
 	       .suspend  = e1000_suspend,
 	       .resume   = e1000_resume
	#endif
	};


diff -aurpN -X /home/fletch/.diff.exclude virgin/drivers/net/e1000/e1000_main.c e1000_suspend/drivers/net/e1000/e1000_main.c
--- virgin/drivers/net/e1000/e1000_main.c	2005-08-07 09:15:36.000000000 -0700
+++ e1000_suspend/drivers/net/e1000/e1000_main.c	2005-08-07 12:10:42.000000000 -0700
@@ -162,8 +162,8 @@ static void e1000_vlan_rx_add_vid(struct
 static void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
 static void e1000_restore_vlan(struct e1000_adapter *adapter);
 
-static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
 #ifdef CONFIG_PM
+static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
 static int e1000_resume(struct pci_dev *pdev);
 #endif
 
@@ -3641,6 +3641,7 @@ e1000_set_spd_dplx(struct e1000_adapter 
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int
 e1000_suspend(struct pci_dev *pdev, uint32_t state)
 {
@@ -3733,7 +3734,6 @@ e1000_suspend(struct pci_dev *pdev, uint
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int
 e1000_resume(struct pci_dev *pdev)
 {

