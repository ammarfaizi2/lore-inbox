Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbUCPRzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUCPRww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:52:52 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:11515 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264312AbUCPRtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:49:40 -0500
Message-Id: <200403161749.i2GHnUe8013149@ginger.cmf.nrl.navy.mil>
To: Peter Daum <gator@cs.tu-berlin.de>
cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Bug in ForeRunner LE (cache line settings) (was ATM (LANE) - related Kernel-Crashes)
In-Reply-To: Message from Peter Daum <gator@cs.tu-berlin.de> 
   of "Tue, 16 Mar 2004 13:08:59 +0100." <Pine.LNX.4.30.0403161249270.9408-100000@swamp.bayern.net> 
Date: Tue, 16 Mar 2004 12:49:32 -0500
From: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while i was looking at the bug report on the sourceforge site, i decided
to take a quick look at your nicstar problem.  can you try the following
patch (apply with patch -p1).


===== drivers/atm/nicstar.c 1.14 vs edited =====
--- 1.14/drivers/atm/nicstar.c	Sun Feb 29 13:53:50 2004
+++ edited/drivers/atm/nicstar.c	Tue Mar 16 12:43:19 2004
@@ -467,7 +467,7 @@
 {
    int j;
    struct ns_dev *card = NULL;
-   unsigned char pci_latency;
+   unsigned char pci_latency, cache_size;
    unsigned error;
    u32 data;
    u32 u32d[4];
@@ -512,6 +512,21 @@
    PRINTK("nicstar%d: membase at 0x%x.\n", i, card->membase);
 
    pci_set_master(pcidev);
+
+   if (pci_read_config_byte(pcidev, PCI_CACHE_LINE_SIZE, &cache_size)) {
+	printk("nicstar%d: can't read cache line size?\n", i);
+	error = 6;
+	ns_init_card_error(card, error);
+	return error;
+   }
+
+   if ((cache_size << 2) != L1_CACHE_BYTES) {
+	printk("nicstar%d: PCI cache line size set incorrectly (%d), ", i, cache_size);
+	cache_size = L1_CACHE_BYTES >> 2;
+	printk("setting cache line size to %d\n", cache_size);
+	if (pci_write_config_byte(pcidev, PCI_CACHE_LINE_SIZE, cache_size))
+	    printk("nicstar%d: can't set cache line size to %d\n", i, cache_size);
+   }
 
    if (pci_read_config_byte(pcidev, PCI_LATENCY_TIMER, &pci_latency) != 0)
    {
