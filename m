Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbUJYBIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUJYBIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUJYBIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:08:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:61644 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261645AbUJYBId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:08:33 -0400
Subject: [PATCH] ppc64: Some small pci fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098666394.16132.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Oct 2004 11:06:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a few issues in the ppc64 pci code, notably some
incorrect parsing of Open Firmware "ranges" when setting up host
bridge resources that would cause a problem with some future
platforms, a default mapping of the ISA IOs if the OF "isa" node
lacks a "ranges" property, and a safeguard in pci_scan_all_fns()
in case a pci<->OF node mapping cannot be established.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2004-10-25 10:36:50.724712968 +1000
+++ linux-work/arch/ppc64/kernel/pci.c	2004-10-25 11:04:50.070413616 +1000
@@ -585,9 +585,11 @@
 	int rlen = 0;
 
 	range = (struct isa_range *) get_property(isa_node, "ranges", &rlen);
-	if (rlen < sizeof(struct isa_range)) {
-		printk(KERN_ERR "unexpected isa range size: %s\n", 
-				__FUNCTION__);
+	if (range == NULL || (rlen < sizeof(struct isa_range))) {
+		printk(KERN_ERR "no ISA ranges or unexpected isa range size,"
+		       "mapping 64k\n");
+		__ioremap_explicit(phb_io_base_phys, (unsigned long)phb_io_base_virt, 
+				   0x10000, _PAGE_NO_CACHE);
 		return;	
 	}
 	
@@ -652,8 +654,7 @@
 			cpu_phys_addr = cpu_phys_addr << 32 | ranges[4];
 
 		size = (unsigned long)ranges[na+3] << 32 | ranges[na+4];
-
-		switch (ranges[0] >> 24) {
+		switch ((ranges[0] >> 24) & 0x3) {
 		case 1:		/* I/O space */
 			hose->io_base_phys = cpu_phys_addr;
 			hose->pci_io_size = size;
@@ -862,6 +863,9 @@
        else
                busdn = bus->sysdata;   /* must be a phb */
 
+       if (busdn == NULL)
+	       return 0;
+
        /*
         * Check to see if there is any of the 8 functions are in the
         * device tree.  If they are then we need to scan all the


