Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSLQAeI>; Mon, 16 Dec 2002 19:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSLQAeI>; Mon, 16 Dec 2002 19:34:08 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:15817 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S262813AbSLQAeH>;
	Mon, 16 Dec 2002 19:34:07 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] PCI: disable decoding while sizing BARs
Date: Mon, 16 Dec 2002 17:41:53 -0700
User-Agent: KMail/1.4.3
Cc: mj@ucw.cz, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212161741.53287.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While sizing BARs, devices are temporarily assigned ranges
that may conflict with other things in the system, like IOSAPICs.
Here's a detailed description of a hang that results from leaving
device decoding enabled while sizing the BARs:

    https://lists.linuxia64.org/archives//linux-ia64/2002-April/003302.html

This patch applies to current 2.4 BitKeeper.

--- linux-2.4/drivers/pci/pci.c	2002-12-16 10:44:21.000000000 -0700
+++ testing/drivers/pci/pci.c	2002-12-16 17:22:26.000000000 -0700
@@ -1058,8 +1058,14 @@
 {
 	unsigned int pos, reg, next;
 	u32 l, sz;
+	u16 cmd;
 	struct resource *res;
 
+	/* Disable I/O & memory decoding while we size the BARs. */
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND,
+		cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));
+
 	for(pos=0; pos<howmany; pos = next) {
 		next = pos+1;
 		res = &dev->resource[pos];
@@ -1131,6 +1137,8 @@
 			res->end = res->start + (unsigned long) sz;
 		}
 	}
+
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
 }
 
 void __devinit pci_read_bridge_bases(struct pci_bus *child)

