Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbTBQX0u>; Mon, 17 Feb 2003 18:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267694AbTBQX0H>; Mon, 17 Feb 2003 18:26:07 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:23457 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267645AbTBQXP7>;
	Mon, 17 Feb 2003 18:15:59 -0500
Date: Mon, 17 Feb 2003 18:25:37 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Shawn Starr <spstarr@sh0n.net>
Subject: [PATCH] PnP Bug Fixes (12/13)
Message-ID: <20030217182537.GA31502@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Shawn Starr <spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains numerous bugfixes discovered by myself and Shawn Starr.

Please apply,

Adam


diff -urN a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Sat Feb 15 22:53:38 2003
+++ b/drivers/pnp/driver.c	Sun Feb 16 20:29:08 2003
@@ -107,9 +107,6 @@
 			if (error < 0)
 				return error;
 		}
-	} else {
-		if ((pnp_drv->flags & PNP_DRIVER_DO_NOT_ACTIVATE))
-			pnp_disable_dev(pnp_dev);
 	}
 	error = 0;
 	if (pnp_drv->probe && pnp_dev->active) {
diff -urN a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Sat Feb 15 23:26:41 2003
+++ b/drivers/pnp/interface.c	Sun Feb 16 20:29:08 2003
@@ -229,6 +229,13 @@
 
 static DEVICE_ATTR(possible,S_IRUGO,pnp_show_possible_resources,NULL);
 
+static void pnp_print_conflict_node(pnp_info_buffer_t *buffer, struct pnp_dev * dev)
+{
+	if (!dev)
+		return;
+	pnp_printf(buffer, "'%s'.\n", dev->dev.bus_id);
+}
+
 static void pnp_print_conflict_desc(pnp_info_buffer_t *buffer, int conflict)
 {
 	if (!conflict)
@@ -236,31 +243,31 @@
 	pnp_printf(buffer, "  Conflict Detected: %2x - ", conflict);
 	switch (conflict) {
 	case CONFLICT_TYPE_RESERVED:
-		pnp_printf(buffer, "This resource was manually reserved.\n");
+		pnp_printf(buffer, "manually reserved.\n");
 		break;
 
 	case CONFLICT_TYPE_IN_USE:
-		pnp_printf(buffer, "This resource resource is currently in use.\n");
+		pnp_printf(buffer, "currently in use.\n");
 		break;
 
 	case CONFLICT_TYPE_PCI:
-		pnp_printf(buffer, "This resource conflicts with a PCI device.\n");
+		pnp_printf(buffer, "PCI device.\n");
 		break;
 
 	case CONFLICT_TYPE_INVALID:
-		pnp_printf(buffer, "This resource is invalid.\n");
+		pnp_printf(buffer, "invalid.\n");
 		break;
 
 	case CONFLICT_TYPE_INTERNAL:
-		pnp_printf(buffer, "This resource conflicts with another resource on this device.\n");
+		pnp_printf(buffer, "another resource on this device.\n");
 		break;
 
 	case CONFLICT_TYPE_PNP_WARM:
-		pnp_printf(buffer, "This resource conflicts with the active PnP device ");
+		pnp_printf(buffer, "active PnP device ");
 		break;
 
 	case CONFLICT_TYPE_PNP_COLD:
-		pnp_printf(buffer, "This resource conflicts with the resources that PnP plans to assign to the device ");
+		pnp_printf(buffer, "disabled PnP device ");
 		break;
 	default:
 		pnp_printf(buffer, "Unknown conflict.\n");
@@ -268,16 +275,9 @@
 	}
 }
 
-static void pnp_print_conflict_node(pnp_info_buffer_t *buffer, struct pnp_dev * dev)
-{
-	if (!dev)
-		return;
-	pnp_printf(buffer, "%s.\n", dev->dev.bus_id);
-}
-
 static void pnp_print_conflict(pnp_info_buffer_t *buffer, struct pnp_dev * dev, int idx, int type)
 {
-	struct pnp_dev * cdev, * wdev;
+	struct pnp_dev * cdev, * wdev = NULL;
 	int conflict;
 	switch (type) {
 	case IORESOURCE_IO:
@@ -310,6 +310,8 @@
 
 	pnp_print_conflict_desc(buffer, conflict);
 
+	if (wdev)
+		pnp_print_conflict_node(buffer, wdev);
 
 	if (cdev) {
 		pnp_print_conflict_desc(buffer, CONFLICT_TYPE_PNP_COLD);
@@ -392,14 +394,41 @@
 		retval = pnp_activate_dev(dev);
 		goto done;
 	}
+	if (!strnicmp(buf,"reset",5)) {
+		if (!dev->active)
+			goto done;
+		retval = pnp_disable_dev(dev);
+		if (retval)
+			goto done;
+		retval = pnp_activate_dev(dev);
+		goto done;
+	}
 	if (!strnicmp(buf,"auto-config",11)) {
 		if (dev->active)
 			goto done;
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
+	if (!strnicmp(buf,"clear-config",12)) {
+		if (dev->active)
+			goto done;
+		spin_lock(&pnp_lock);
+		dev->config_mode = PNP_CONFIG_MANUAL;
+		pnp_init_resource_table(&dev->res);
+		if (dev->rule)
+			dev->rule->depnum = 0;
+		spin_unlock(&pnp_lock);
+		goto done;
+	}
 	if (!strnicmp(buf,"resolve",7)) {
 		retval = pnp_resolve_conflicts(dev);
+		goto done;
+	}
+	if (!strnicmp(buf,"get",3)) {
+		spin_lock(&pnp_lock);
+		if (pnp_can_read(dev))
+			dev->protocol->get(dev, &dev->res);
+		spin_unlock(&pnp_lock);
 		goto done;
 	}
 	if (!strnicmp(buf,"set",3)) {
diff -urN a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sat Feb 15 23:26:41 2003
+++ b/drivers/pnp/isapnp/core.c	Sun Feb 16 20:29:09 2003
@@ -765,7 +765,7 @@
 /*
  *  Parse resource map for ISA PnP card.
  */
- 
+
 static void __init isapnp_parse_resource_map(struct pnp_card *card)
 {
 	unsigned char type, tmp[17];
@@ -822,7 +822,7 @@
 {
 	int i, j;
 	unsigned char checksum = 0x6a, bit, b;
-	
+
 	for (i = 0; i < 8; i++) {
 		b = data[i];
 		for (j = 0; j < 8; j++) {
@@ -900,7 +900,6 @@
 		}
 		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
 			ret = isapnp_read_byte(ISAPNP_CFG_DMA + tmp);
-			pnp_info("dma %d", tmp);
 			if (ret == 4)
 				continue;
 			if (rule.dma[tmp]) { /* some isapnp systems forget to set this to 4 so we have to check */
@@ -1174,7 +1173,7 @@
 	return 0;
 }
 
-subsys_initcall(isapnp_init);
+device_initcall(isapnp_init);
 
 /* format is: noisapnp */
 
diff -urN a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Sat Feb 15 23:26:41 2003
+++ b/drivers/pnp/manager.c	Sun Feb 16 20:29:09 2003
@@ -1,7 +1,7 @@
 /*
  * manager.c - Resource Management, Conflict Resolution, Activation and Disabling of Devices
  *
- * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
+ * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
  *
  */
 
@@ -27,31 +27,31 @@
 static int pnp_next_port(struct pnp_dev * dev, int idx)
 {
 	struct pnp_port *port;
-	unsigned long *value1, *value2, *value3;
+	unsigned long *start, *end, *flags;
 	if (!dev || idx < 0 || idx >= PNP_MAX_PORT)
 		return 0;
 	port = dev->rule->port[idx];
 	if (!port)
 		return 1;
 
-	value1 = &dev->res.port_resource[idx].start;
-	value2 = &dev->res.port_resource[idx].end;
-	value3 = &dev->res.port_resource[idx].flags;
+	start = &dev->res.port_resource[idx].start;
+	end = &dev->res.port_resource[idx].end;
+	flags = &dev->res.port_resource[idx].flags;
 
 	/* set the initial values if this is the first time */
-	if (*value1 == 0) {
-		*value1 = port->min;
-		*value2 = *value1 + port->size -1;
-		*value3 = port->flags | IORESOURCE_IO;
+	if (*start == 0) {
+		*start = port->min;
+		*end = *start + port->size - 1;
+		*flags = port->flags | IORESOURCE_IO;
 		if (!pnp_check_port(dev, idx))
 			return 1;
 	}
 
 	/* run through until pnp_check_port is happy */
 	do {
-		*value1 += port->align;
-		*value2 = *value1 + port->size - 1;
-		if (*value1 > port->max || !port->align)
+		*start += port->align;
+		*end = *start + port->size - 1;
+		if (*start > port->max || !port->align)
 			return 0;
 	} while (pnp_check_port(dev, idx));
 	return 1;
@@ -60,39 +60,39 @@
 static int pnp_next_mem(struct pnp_dev * dev, int idx)
 {
 	struct pnp_mem *mem;
-	unsigned long *value1, *value2, *value3;
+	unsigned long *start, *end, *flags;
 	if (!dev || idx < 0 || idx >= PNP_MAX_MEM)
 		return 0;
 	mem = dev->rule->mem[idx];
 	if (!mem)
 		return 1;
 
-	value1 = &dev->res.mem_resource[idx].start;
-	value2 = &dev->res.mem_resource[idx].end;
-	value3 = &dev->res.mem_resource[idx].flags;
+	start = &dev->res.mem_resource[idx].start;
+	end = &dev->res.mem_resource[idx].end;
+	flags = &dev->res.mem_resource[idx].flags;
 
 	/* set the initial values if this is the first time */
-	if (*value1 == 0) {
-		*value1 = mem->min;
-		*value2 = *value1 + mem->size -1;
-		*value3 = mem->flags | IORESOURCE_MEM;
+	if (*start == 0) {
+		*start = mem->min;
+		*end = *start + mem->size -1;
+		*flags = mem->flags | IORESOURCE_MEM;
 		if (!(mem->flags & IORESOURCE_MEM_WRITEABLE))
-			*value3 |= IORESOURCE_READONLY;
+			*flags |= IORESOURCE_READONLY;
 		if (mem->flags & IORESOURCE_MEM_CACHEABLE)
-			*value3 |= IORESOURCE_CACHEABLE;
+			*flags |= IORESOURCE_CACHEABLE;
 		if (mem->flags & IORESOURCE_MEM_RANGELENGTH)
-			*value3 |= IORESOURCE_RANGELENGTH;
+			*flags |= IORESOURCE_RANGELENGTH;
 		if (mem->flags & IORESOURCE_MEM_SHADOWABLE)
-			*value3 |= IORESOURCE_SHADOWABLE;
+			*flags |= IORESOURCE_SHADOWABLE;
 		if (!pnp_check_mem(dev, idx))
 			return 1;
 	}
 
 	/* run through until pnp_check_mem is happy */
 	do {
-		*value1 += mem->align;
-		*value2 = *value1 + mem->size - 1;
-		if (*value1 > mem->max || !mem->align)
+		*start += mem->align;
+		*end = *start + mem->size - 1;
+		if (*start > mem->max || !mem->align)
 			return 0;
 	} while (pnp_check_mem(dev, idx));
 	return 1;
@@ -101,7 +101,7 @@
 static int pnp_next_irq(struct pnp_dev * dev, int idx)
 {
 	struct pnp_irq *irq;
-	unsigned long *value1, *value2, *value3;
+	unsigned long *start, *end, *flags;
 	int i, mask;
 	if (!dev || idx < 0 || idx >= PNP_MAX_IRQ)
 		return 0;
@@ -109,23 +109,23 @@
 	if (!irq)
 		return 1;
 
-	value1 = &dev->res.irq_resource[idx].start;
-	value2 = &dev->res.irq_resource[idx].end;
-	value3 = &dev->res.irq_resource[idx].flags;
+	start = &dev->res.irq_resource[idx].start;
+	end = &dev->res.irq_resource[idx].end;
+	flags = &dev->res.irq_resource[idx].flags;
 
 	/* set the initial values if this is the first time */
-	if (*value1 == -1) {
-		*value1 = *value2 = 0;
-		*value3 = irq->flags | IORESOURCE_IRQ;
+	if (*start == -1) {
+		*start = *end = 0;
+		*flags = irq->flags | IORESOURCE_IRQ;
 		if (!pnp_check_irq(dev, idx))
 			return 1;
 	}
 
 	mask = irq->map;
-	for (i = *value1 + 1; i < 16; i++)
+	for (i = *start + 1; i < 16; i++)
 	{
 		if(mask>>i & 0x01) {
-			*value1 = *value2 = i;
+			*start = *end = i;
 			if(!pnp_check_irq(dev, idx))
 				return 1;
 		}
@@ -136,8 +136,7 @@
 static int pnp_next_dma(struct pnp_dev * dev, int idx)
 {
 	struct pnp_dma *dma;
-	struct resource backup;
-	unsigned long *value1, *value2, *value3;
+	unsigned long *start, *end, *flags;
 	int i, mask;
 	if (!dev || idx < 0 || idx >= PNP_MAX_DMA)
 		return -EINVAL;
@@ -145,46 +144,52 @@
 	if (!dma)
 		return 1;
 
-	value1 = &dev->res.dma_resource[idx].start;
-	value2 = &dev->res.dma_resource[idx].end;
-	value3 = &dev->res.dma_resource[idx].flags;
-	*value3 = dma->flags | IORESOURCE_DMA;
-	backup = dev->res.dma_resource[idx];
+	start = &dev->res.dma_resource[idx].start;
+	end = &dev->res.dma_resource[idx].end;
+	flags = &dev->res.dma_resource[idx].flags;
 
 	/* set the initial values if this is the first time */
-	if (*value1 == -1) {
-		*value1 = *value2 = 0;
-		*value3 = dma->flags | IORESOURCE_DMA;
+	if (*start == -1) {
+		*start = *end = 0;
+		*flags = dma->flags | IORESOURCE_DMA;
 		if (!pnp_check_dma(dev, idx))
 			return 1;
 	}
 
 	mask = dma->map;
-	for (i = *value1 + 1; i < 8; i++)
+	for (i = *start + 1; i < 8; i++)
 	{
 		if(mask>>i & 0x01) {
-			*value1 = *value2 = i;
+			*start = *end = i;
 			if(!pnp_check_dma(dev, idx))
 				return 1;
 		}
 	}
-	dev->res.dma_resource[idx] = backup;
 	return 0;
 }
 
-
 static int pnp_next_rule(struct pnp_dev *dev)
 {
 	int depnum = dev->rule->depnum;
         int max = pnp_get_max_depnum(dev);
 	int priority = PNP_RES_PRIORITY_PREFERRED;
 
+	if (depnum < 0)
+		return 0;
+
+	if (max == 0) {
+		if (pnp_generate_rule(dev, 0, dev->rule)) {
+			dev->rule->depnum = -1;
+			return 1;
+		}
+	}
+
 	if(depnum > 0) {
 		struct pnp_resources * res = pnp_find_resources(dev, depnum);
 		priority = res->priority;
 	}
 
-	for (; priority <= PNP_RES_PRIORITY_FUNCTIONAL; priority++, depnum=0) {
+	for (; priority <= PNP_RES_PRIORITY_FUNCTIONAL; priority++, depnum = 0) {
 		depnum += 1;
 		for (; depnum <= max; depnum++) {
 			struct pnp_resources * res = pnp_find_resources(dev, depnum);
@@ -251,6 +256,7 @@
 	if (!list_empty(&change->changes))
 		list_splice_init(&change->changes, &parent->changes);
 }
+
 static int pnp_next_config(struct pnp_dev * dev, int move, struct pnp_change * parent);
 
 static int pnp_next_request(struct pnp_dev * dev, int move, struct pnp_change * parent, struct pnp_change * change)
@@ -259,7 +265,8 @@
 	struct pnp_dev * cdev;
 
 	for (i = 0; i < PNP_MAX_PORT; i++) {
-		if (dev->res.port_resource[i].start == 0 || pnp_check_port_conflicts(dev,i,SEARCH_WARM)) {
+		if (dev->res.port_resource[i].start == 0
+		 || pnp_check_port_conflicts(dev,i,SEARCH_WARM)) {
 			if (!pnp_next_port(dev,i))
 				return 0;
 		}
@@ -274,7 +281,8 @@
 		pnp_commit_changes(parent, change);
 	}
 	for (i = 0; i < PNP_MAX_MEM; i++) {
-		if (dev->res.mem_resource[i].start == 0 || pnp_check_mem_conflicts(dev,i,SEARCH_WARM)) {
+		if (dev->res.mem_resource[i].start == 0
+		 || pnp_check_mem_conflicts(dev,i,SEARCH_WARM)) {
 			if (!pnp_next_mem(dev,i))
 				return 0;
 		}
@@ -289,7 +297,8 @@
 		pnp_commit_changes(parent, change);
 	}
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
-		if (dev->res.irq_resource[i].start == -1 || pnp_check_irq_conflicts(dev,i,SEARCH_WARM)) {
+		if (dev->res.irq_resource[i].start == -1
+		 || pnp_check_irq_conflicts(dev,i,SEARCH_WARM)) {
 			if (!pnp_next_irq(dev,i))
 				return 0;
 		}
@@ -304,7 +313,8 @@
 		pnp_commit_changes(parent, change);
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
-		if (dev->res.dma_resource[i].start == -1 || pnp_check_dma_conflicts(dev,i,SEARCH_WARM)) {
+		if (dev->res.dma_resource[i].start == -1
+		 || pnp_check_dma_conflicts(dev,i,SEARCH_WARM)) {
 			if (!pnp_next_dma(dev,i))
 				return 0;
 		}
@@ -323,12 +333,13 @@
 
 static int pnp_next_config(struct pnp_dev * dev, int move, struct pnp_change * parent)
 {
-	struct pnp_change * change = pnp_add_change(parent,dev);
+	struct pnp_change * change;
 	move--;
+	if (!dev->rule)
+		return 0;
+	change = pnp_add_change(parent,dev);
 	if (!change)
 		return 0;
-	if (!dev->rule)
-		goto fail;
 	if (!pnp_can_configure(dev))
 		goto fail;
 	if (!dev->rule->depnum) {
@@ -431,8 +442,6 @@
 		spin_unlock(&pnp_lock);
 		return 1;
 	}
-	dev->rule->depnum = 0;
-	pnp_init_resource_table(&dev->res);
 	if (!dev->rule) {
 		dev->rule = pnp_alloc(sizeof(struct pnp_rule_table));
 		if (!dev->rule) {
@@ -440,6 +449,8 @@
 			return -ENOMEM;
 		}
 	}
+	dev->rule->depnum = 0;
+	pnp_init_resource_table(&dev->res);
 	while (pnp_next_rule(dev)) {
 		for (i = 0; i < PNP_MAX_PORT; i++) {
 			if (!pnp_next_port(dev,i))
diff -urN a/drivers/pnp/names.c b/drivers/pnp/names.c
--- a/drivers/pnp/names.c	Sat Feb 15 22:53:38 2003
+++ b/drivers/pnp/names.c	Sun Feb 16 20:31:36 2003
@@ -33,7 +33,7 @@
 	char *name = dev->dev.name;
 	for(i=0; i<sizeof(pnp_id_eisaid)/sizeof(pnp_id_eisaid[0]); i++){
 		if (compare_pnp_id(dev->id,pnp_id_eisaid[i])){
-			sprintf(name, "%s", pnp_id_names[i]);
+			snprintf(name, DEVICE_NAME_SIZE, "%s", pnp_id_names[i]);
 			return;
 		}
 	}
diff -urN a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sat Feb 15 23:26:41 2003
+++ b/drivers/pnp/pnpbios/core.c	Sun Feb 16 20:29:09 2003
@@ -146,9 +146,9 @@
 
 /*
  * At some point we want to use this stack frame pointer to unwind
- * after PnP BIOS oopses. 
+ * after PnP BIOS oopses.
  */
- 
+
 u32 pnp_bios_fault_esp;
 u32 pnp_bios_fault_eip;
 u32 pnp_bios_is_utter_crap = 0;
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Sat Feb 15 23:26:41 2003
+++ b/drivers/pnp/resource.c	Sun Feb 16 20:29:09 2003
@@ -2,7 +2,7 @@
  * resource.c - Contains functions for registering and analyzing resource information
  *
  * based on isapnp.c resource management (c) Jaroslav Kysela <perex@suse.cz>
- * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
+ * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
  *
  */
 
@@ -598,7 +598,7 @@
 	struct pnp_irq * irq;
 	struct pnp_dma * dma;
 
-	if (depnum <= 0 || !rule)
+	if (depnum < 0 || !rule)
 		return -EINVAL;
 
 	/* independent */
@@ -631,6 +631,8 @@
 	}
 
 	/* dependent */
+	if (depnum == 0)
+		return 1;
 	res = pnp_find_resources(dev, depnum);
 	if (!res)
 		return -ENODEV;
@@ -680,7 +682,6 @@
 EXPORT_SYMBOL(pnp_add_dma_resource);
 EXPORT_SYMBOL(pnp_add_port_resource);
 EXPORT_SYMBOL(pnp_add_mem_resource);
-EXPORT_SYMBOL(pnp_add_mem32_resource);
 EXPORT_SYMBOL(pnp_init_resource_table);
 EXPORT_SYMBOL(pnp_generate_rule);
 
diff -urN a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Sat Feb 15 23:26:41 2003
+++ b/drivers/pnp/support.c	Sun Feb 16 20:30:49 2003
@@ -36,7 +36,7 @@
 #define LARGE_TAG_ANSISTR		0x02
 #define LARGE_TAG_UNICODESTR		0x03
 #define LARGE_TAG_VENDOR		0x04
-#define LARGE_TAG_MEM32		0x05
+#define LARGE_TAG_MEM32			0x05
 #define LARGE_TAG_FIXEDMEM32		0x06
 
 
@@ -143,6 +143,11 @@
 				/* ignore this for now */
 				break;
 			}
+			case LARGE_TAG_VENDOR:
+			{
+				/* do nothing */
+				break;
+			}
 			case LARGE_TAG_MEM32:
 			{
 				int io = *(int *) &p[4];
@@ -204,6 +209,11 @@
 			if (len != 7)
 				goto sm_err;
 			current_ioresource(res, io, size);
+			break;
+		}
+		case SMALL_TAG_VENDOR:
+		{
+			/* do nothing */
 			break;
 		}
 		case SMALL_TAG_FIXEDPORT:
diff -urN a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	Sat Feb 15 23:26:41 2003
+++ b/drivers/pnp/system.c	Sun Feb 16 20:29:09 2003
@@ -93,6 +93,7 @@
 
 static struct pnp_driver system_pnp_driver = {
 	.name		= "system",
+	.flags		= PNP_DRIVER_DO_NOT_ACTIVATE, 
 	.id_table	= pnp_dev_table,
 	.probe		= system_pnp_probe,
 	.remove		= NULL,
