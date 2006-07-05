Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWGEU7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWGEU7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWGEU7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:59:39 -0400
Received: from xenotime.net ([66.160.160.81]:13229 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964903AbWGEU7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:59:38 -0400
Date: Wed, 5 Jul 2006 14:02:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: davem@davemloft.net, vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.17 on SPARC64 compile fails
Message-Id: <20060705140224.144cb9bc.rdunlap@xenotime.net>
In-Reply-To: <20060705131539.ba3275d8.rdunlap@xenotime.net>
References: <200607041417.k64EHNIT009599@laptop11.inf.utfsm.cl>
	<20060705.113911.112605950.davem@davemloft.net>
	<20060705131539.ba3275d8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 13:15:39 -0700 Randy.Dunlap wrote:

> On Wed, 05 Jul 2006 11:39:11 -0700 (PDT) David Miller wrote:
> 
> > From: Horst von Brand <vonbrand@inf.utfsm.cl>
> > Date: Tue, 04 Jul 2006 10:17:23 -0400
> > 
> > > Looking at the relevant file, it seems the offending functions are for PCI
> > > only (and my SparcStation Ultra 1 sure doesn't have any PCI in it, so this
> > > is disabled in the configuration). Maybe the #endif is too early?
> > 
> > Yes, I'm still thinking how to fix this.
> 
> Do you mean a generalized arch-independent fix?
> 
> > Turn CONFIG_PCI on as a workaround for now.
> 
> Good plan.  With CONFIG_PCI still off and a patch for the above
> problem, next CONFIG_PCI=n issue is this one:
> 
> /var/linsrc/linux-2617-g24/arch/sparc64/kernel/time.c: In function `clock_probe':
> /var/linsrc/linux-2617-g24/arch/sparc64/kernel/time.c:795: error: invalid lvalue in assignment

This fixes all sparc64 build errors for me when using Horst's
config (PCI=n).

---
From: Randy Dunlap <rdunlap@xenotime.net>

Fix sparc64 build errors when CONFIG_PCI=n.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/sparc64/kernel/prom.c        |    2 ++
 arch/sparc64/kernel/time.c        |    5 ++++-
 include/asm-sparc64/dma-mapping.h |   14 ++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

--- linux-2617-g24.orig/include/asm-sparc64/dma-mapping.h
+++ linux-2617-g24/include/asm-sparc64/dma-mapping.h
@@ -160,6 +160,20 @@ static inline void dma_free_coherent(str
 	BUG();
 }
 
+static inline void
+dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
+			enum dma_data_direction direction)
+{
+	BUG();
+}
+
+static inline void
+dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
+			   enum dma_data_direction direction)
+{
+	BUG();
+}
+
 #endif /* PCI */
 
 
--- linux-2617-g24.orig/arch/sparc64/kernel/time.c
+++ linux-2617-g24/arch/sparc64/kernel/time.c
@@ -788,12 +788,15 @@ static int __devinit clock_probe(struct 
 	if (!regs)
 		return -ENOMEM;
 
+#ifdef CONFIG_PCI
 	if (!strcmp(model, "ds1287") ||
 	    !strcmp(model, "m5819") ||
 	    !strcmp(model, "m5819p") ||
 	    !strcmp(model, "m5823")) {
 		ds1287_regs = (unsigned long) regs;
-	} else if (model[5] == '0' && model[6] == '2') {
+	} else
+#endif
+	if (model[5] == '0' && model[6] == '2') {
 		mstk48t02_regs = regs;
 	} else if(model[5] == '0' && model[6] == '8') {
 		mstk48t08_regs = regs;
--- linux-2617-g24.orig/arch/sparc64/kernel/prom.c
+++ linux-2617-g24/arch/sparc64/kernel/prom.c
@@ -1032,7 +1032,9 @@ static void sun4v_vdev_irq_trans_init(st
 static void irq_trans_init(struct device_node *dp)
 {
 	const char *model;
+#ifdef CONFIG_PCI
 	int i;
+#endif
 
 	model = of_get_property(dp, "model", NULL);
 	if (!model)
