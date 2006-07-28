Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161197AbWG1Rdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWG1Rdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWG1Rde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:33:34 -0400
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:29678 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1161196AbWG1Rdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:33:32 -0400
Date: Sat, 29 Jul 2006 01:33:22 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: "James.Bottomley" <James.Bottomley@SteelEye.com>, "jeff" <jeff@garzik.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "promise_linux" <promise_linux@promise.com>
Subject: [PATCH 4/4] stex: add hard reset function
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBzdfTVSxzW234000002b8@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 28 Jul 2006 17:35:33.0359 (UTC) FILETIME=[3A74E7F0:01C6B26C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For 'shasta' type controller there are at least one P2P bridge in it
and MU/ATU on the secondary bus under the bridge. When there is a
hardware/firmware hang, use the reset secondary bus function of P2P
bridge to actually reset and recover the hardware. As our MU/ATU is
the only device on this secondary bus, this reset action would not
affect other devices.

Signed-off-by: Ed Lin <ed.lin@promise.com>
---
 stex.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+)
diff -urN a/drivers/scsi/stex.c b/drivers/scsi/stex.c
--- a/drivers/scsi/stex.c	2006-07-28 05:59:16.000000000 -0400
+++ b/drivers/scsi/stex.c	2006-07-28 06:02:04.000000000 -0400
@@ -882,6 +882,40 @@
 	return result;
 }
 
+static void stex_hard_reset(struct st_hba *hba)
+{
+	struct pci_bus *bus;
+	int i;
+	u16 pci_cmd;
+	u8 pci_bctl;
+
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(hba->pdev, i * 4,
+			&hba->pdev->saved_config_space[i]);
+
+	/* Reset secondary bus. Our controller(MU/ATU) is the only device on
+	   secondary bus. Consult Intel 80331/3 developer's manual for detail */
+	bus = hba->pdev->bus;
+	pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
+	pci_bctl |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
+	msleep(1);
+	pci_bctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
+
+	for (i = 0; i < MU_MAX_DELAY_TIME; i++) {
+		pci_read_config_word(hba->pdev, PCI_COMMAND, &pci_cmd);
+		if (pci_cmd & PCI_COMMAND_MASTER)
+			break;
+		msleep(1);
+	}
+
+	ssleep(5);
+	for (i = 0; i < 16; i++)
+		pci_write_config_dword(hba->pdev, i * 4,
+			hba->pdev->saved_config_space[i]);
+}
+
 static int stex_reset(struct scsi_cmnd *cmd)
 {
 	struct st_hba *hba;
@@ -916,6 +950,9 @@
 
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
+	if (hba->cardtype == st_shasta)
+		stex_hard_reset(hba);
+
 	if (stex_handshake(hba)) {
 		printk(KERN_WARNING DRV_NAME
 			"(%s): resetting: handshake failed\n",

