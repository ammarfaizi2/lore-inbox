Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946270AbWKAFkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946270AbWKAFkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946512AbWKAFjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:39:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45201 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946270AbWKAFjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:39:08 -0500
Message-Id: <20061101053908.502794000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 23/61] SPARC64: Fix central/FHC bus handling on Ex000 systems.
Content-Disposition: inline; filename=sparc64-fix-central-fhc-bus-handling-on-ex000-systems.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

1) probe_other_fhcs() wants to see only non-central FHC
   busses, so skip FHCs that don't sit off the root

2) Like SBUS, FHC can lack the appropriate address and
   size cell count properties, so add an of_busses[]
   entry and handlers for that.

3) Central FHC irq translator probing was buggy.  We
   were trying to use dp->child in irq_trans_init but
   that linkage is not setup at this point.

   So instead, pass in the parent of "dp" and look for
   the child "fhc" with parent "central".

Thanks to the tireless assistence of Ben Collins in tracking
down these problems and testing out these fixes.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/sparc64/kernel/central.c   |    4 ++++
 arch/sparc64/kernel/of_device.c |   33 ++++++++++++++++++++++++---------
 arch/sparc64/kernel/prom.c      |   30 +++++++++++++++---------------
 3 files changed, 43 insertions(+), 24 deletions(-)

--- linux-2.6.18.1.orig/arch/sparc64/kernel/central.c
+++ linux-2.6.18.1/arch/sparc64/kernel/central.c
@@ -126,6 +126,10 @@ static void probe_other_fhcs(void)
 		int board;
 		u32 tmp;
 
+		if (dp->parent &&
+		    dp->parent->parent != NULL)
+			continue;
+
 		fhc = (struct linux_fhc *)
 			central_alloc_bootmem(sizeof(struct linux_fhc));
 		if (fhc == NULL)
--- linux-2.6.18.1.orig/arch/sparc64/kernel/of_device.c
+++ linux-2.6.18.1/arch/sparc64/kernel/of_device.c
@@ -398,16 +398,22 @@ static void of_bus_sbus_count_cells(stru
 		*sizec = 1;
 }
 
-static int of_bus_sbus_map(u32 *addr, const u32 *range, int na, int ns, int pna)
-{
-	return of_bus_default_map(addr, range, na, ns, pna);
-}
-
-static unsigned int of_bus_sbus_get_flags(u32 *addr)
+/*
+ * FHC/Central bus specific translator.
+ *
+ * This is just needed to hard-code the address and size cell
+ * counts.  'fhc' and 'central' nodes lack the #address-cells and
+ * #size-cells properties, and if you walk to the root on such
+ * Enterprise boxes all you'll get is a #size-cells of 2 which is
+ * not what we want to use.
+ */
+static int of_bus_fhc_match(struct device_node *np)
 {
-	return IORESOURCE_MEM;
+	return !strcmp(np->name, "fhc") ||
+		!strcmp(np->name, "central");
 }
 
+#define of_bus_fhc_count_cells of_bus_sbus_count_cells
 
 /*
  * Array of bus specific translators
@@ -429,8 +435,17 @@ static struct of_bus of_busses[] = {
 		.addr_prop_name = "reg",
 		.match = of_bus_sbus_match,
 		.count_cells = of_bus_sbus_count_cells,
-		.map = of_bus_sbus_map,
-		.get_flags = of_bus_sbus_get_flags,
+		.map = of_bus_default_map,
+		.get_flags = of_bus_default_get_flags,
+	},
+	/* FHC */
+	{
+		.name = "fhc",
+		.addr_prop_name = "reg",
+		.match = of_bus_fhc_match,
+		.count_cells = of_bus_fhc_count_cells,
+		.map = of_bus_default_map,
+		.get_flags = of_bus_default_get_flags,
 	},
 	/* Default */
 	{
--- linux-2.6.18.1.orig/arch/sparc64/kernel/prom.c
+++ linux-2.6.18.1/arch/sparc64/kernel/prom.c
@@ -1080,23 +1080,22 @@ static void sun4v_vdev_irq_trans_init(st
 
 static void irq_trans_init(struct device_node *dp)
 {
-	const char *model;
 #ifdef CONFIG_PCI
+	const char *model;
 	int i;
 #endif
 
+#ifdef CONFIG_PCI
 	model = of_get_property(dp, "model", NULL);
 	if (!model)
 		model = of_get_property(dp, "compatible", NULL);
-	if (!model)
-		return;
-
-#ifdef CONFIG_PCI
-	for (i = 0; i < ARRAY_SIZE(pci_irq_trans_table); i++) {
-		struct irq_trans *t = &pci_irq_trans_table[i];
+	if (model) {
+		for (i = 0; i < ARRAY_SIZE(pci_irq_trans_table); i++) {
+			struct irq_trans *t = &pci_irq_trans_table[i];
 
-		if (!strcmp(model, t->name))
-			return t->init(dp);
+			if (!strcmp(model, t->name))
+				return t->init(dp);
+		}
 	}
 #endif
 #ifdef CONFIG_SBUS
@@ -1104,8 +1103,9 @@ static void irq_trans_init(struct device
 	    !strcmp(dp->name, "sbi"))
 		return sbus_irq_trans_init(dp);
 #endif
-	if (!strcmp(dp->name, "central"))
-		return central_irq_trans_init(dp->child);
+	if (!strcmp(dp->name, "fhc") &&
+	    !strcmp(dp->parent->name, "central"))
+		return central_irq_trans_init(dp);
 	if (!strcmp(dp->name, "virtual-devices"))
 		return sun4v_vdev_irq_trans_init(dp);
 }
@@ -1517,7 +1517,7 @@ static char * __init get_one_property(ph
 	return buf;
 }
 
-static struct device_node * __init create_node(phandle node)
+static struct device_node * __init create_node(phandle node, struct device_node *parent)
 {
 	struct device_node *dp;
 
@@ -1526,6 +1526,7 @@ static struct device_node * __init creat
 
 	dp = prom_early_alloc(sizeof(*dp));
 	dp->unique_id = unique_id++;
+	dp->parent = parent;
 
 	kref_init(&dp->kref);
 
@@ -1544,12 +1545,11 @@ static struct device_node * __init build
 {
 	struct device_node *dp;
 
-	dp = create_node(node);
+	dp = create_node(node, parent);
 	if (dp) {
 		*(*nextp) = dp;
 		*nextp = &dp->allnext;
 
-		dp->parent = parent;
 		dp->path_component_name = build_path_component(dp);
 		dp->full_name = build_full_name(dp);
 
@@ -1565,7 +1565,7 @@ void __init prom_build_devicetree(void)
 {
 	struct device_node **nextp;
 
-	allnodes = create_node(prom_root_node);
+	allnodes = create_node(prom_root_node, NULL);
 	allnodes->path_component_name = "";
 	allnodes->full_name = "/";
 

--
