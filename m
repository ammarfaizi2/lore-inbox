Return-Path: <linux-kernel-owner+w=401wt.eu-S1751134AbXAFCbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbXAFCbz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbXAFCbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:25 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36729 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbXAFCbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:31:21 -0500
Message-Id: <20070106023521.635299000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:28 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>
Subject: [patch 35/50] SPARC64: Handle ISA devices with no regs property.
Content-Disposition: inline; filename=sparc64-handle-isa-devices-with-no-regs-property.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

And this points out that the return value from
isa_dev_get_resource() and the 'pregs' arg to
isa_dev_get_irq() are totally unused.

Based upon a patch from Richard Mortimer <richm@oldelvet.org.uk>

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/sparc64/kernel/isa.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- linux-2.6.19.1.orig/arch/sparc64/kernel/isa.c
+++ linux-2.6.19.1/arch/sparc64/kernel/isa.c
@@ -22,14 +22,15 @@ static void __init report_dev(struct spa
 		printk(" [%s", isa_dev->prom_node->name);
 }
 
-static struct linux_prom_registers * __init
-isa_dev_get_resource(struct sparc_isa_device *isa_dev)
+static void __init isa_dev_get_resource(struct sparc_isa_device *isa_dev)
 {
 	struct linux_prom_registers *pregs;
 	unsigned long base, len;
 	int prop_len;
 
 	pregs = of_get_property(isa_dev->prom_node, "reg", &prop_len);
+	if (!pregs)
+		return;
 
 	/* Only the first one is interesting. */
 	len = pregs[0].reg_size;
@@ -44,12 +45,9 @@ isa_dev_get_resource(struct sparc_isa_de
 
 	request_resource(&isa_dev->bus->parent->io_space,
 			 &isa_dev->resource);
-
-	return pregs;
 }
 
-static void __init isa_dev_get_irq(struct sparc_isa_device *isa_dev,
-				   struct linux_prom_registers *pregs)
+static void __init isa_dev_get_irq(struct sparc_isa_device *isa_dev)
 {
 	struct of_device *op = of_find_device_by_node(isa_dev->prom_node);
 
@@ -69,7 +67,6 @@ static void __init isa_fill_children(str
 
 	printk(" ->");
 	while (dp) {
-		struct linux_prom_registers *regs;
 		struct sparc_isa_device *isa_dev;
 
 		isa_dev = kmalloc(sizeof(*isa_dev), GFP_KERNEL);
@@ -87,8 +84,8 @@ static void __init isa_fill_children(str
 		isa_dev->bus = parent_isa_dev->bus;
 		isa_dev->prom_node = dp;
 
-		regs = isa_dev_get_resource(isa_dev);
-		isa_dev_get_irq(isa_dev, regs);
+		isa_dev_get_resource(isa_dev);
+		isa_dev_get_irq(isa_dev);
 
 		report_dev(isa_dev, 1);
 
@@ -101,7 +98,6 @@ static void __init isa_fill_devices(stru
 	struct device_node *dp = isa_br->prom_node->child;
 
 	while (dp) {
-		struct linux_prom_registers *regs;
 		struct sparc_isa_device *isa_dev;
 
 		isa_dev = kmalloc(sizeof(*isa_dev), GFP_KERNEL);
@@ -141,8 +137,8 @@ static void __init isa_fill_devices(stru
 		isa_dev->bus = isa_br;
 		isa_dev->prom_node = dp;
 
-		regs = isa_dev_get_resource(isa_dev);
-		isa_dev_get_irq(isa_dev, regs);
+		isa_dev_get_resource(isa_dev);
+		isa_dev_get_irq(isa_dev);
 
 		report_dev(isa_dev, 0);
 

--
