Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUIAQl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUIAQl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUIAQlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:41:14 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:26806 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S266463AbUIAQgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:36:10 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] announce hpet devices claimed
Date: Wed, 1 Sep 2004 10:36:02 -0600
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Cc: venkatesh.pallipadi@intel.com, Bob Picco <Robert.Picco@hp.com>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409011036.02276.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the HPET driver should announce the hardware it claims.  Here's
a patch that prints this:

	hpet0: at MMIO 0xc0000ffffc002000, IRQs 74, 75, 76
	hpet0: 4ns tick, 3 64-bit timers
	hpet1: at MMIO 0xc0000ffffc082000, IRQs 77, 78, 79
	hpet1: 4ns tick, 3 64-bit timers

This has been acked by Bob.  I haven't heard from Venkatesh.


Print basic information (MMIO address, IRQs used, tick rate, number
of timers) when claiming an HPET device.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/char/hpet.c 1.5 vs edited =====
--- 1.5/drivers/char/hpet.c	2004-08-02 02:00:44 -06:00
+++ edited/drivers/char/hpet.c	2004-08-26 12:46:01 -06:00
@@ -789,6 +789,7 @@
 	size_t siz;
 	struct hpet *hpet;
 	static struct hpets *last __initdata = (struct hpets *)0;
+	unsigned long ns;
 
 	/*
 	 * hpet_alloc can be called by platform dependent code.
@@ -840,6 +841,18 @@
 	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
 	    HPET_COUNTER_CLK_PERIOD_SHIFT;
 
+	printk(KERN_INFO "hpet%d: at MMIO 0x%p, IRQ%s",
+		hpetp->hp_which, hpet, hpetp->hp_ntimer > 1 ? "s" : "");
+	for (i = 0; i < hpetp->hp_ntimer; i++)
+		printk("%s %d", i > 0 ? "," : "", hdp->hd_irq[i]);
+	printk("\n");
+
+	ns = hpetp->hp_period;	/* femptoseconds, 10^-15 */
+	do_div(ns, 1000000);	/* convert to nanoseconds, 10^-9 */
+	printk(KERN_INFO "hpet%d: %ldns tick, %d %d-bit timers\n",
+		hpetp->hp_which, ns, hpetp->hp_ntimer,
+		cap & HPET_COUNTER_SIZE_MASK ? 64 : 32);
+
 	mcfg = readq(&hpet->hpet_config);
 	if ((mcfg & HPET_ENABLE_CNF_MASK) == 0) {
 		write_counter(0L, &hpet->hpet_mc);
@@ -946,7 +960,6 @@
 
 static struct acpi_driver hpet_acpi_driver __initdata = {
 	.name = "hpet",
-	.class = "",
 	.ids = "PNP0103",
 	.ops = {
 		.add = hpet_acpi_add,

