Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTBFCZj>; Wed, 5 Feb 2003 21:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTBFCZj>; Wed, 5 Feb 2003 21:25:39 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:15754 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265543AbTBFCZa>;
	Wed, 5 Feb 2003 21:25:30 -0500
Date: Wed, 5 Feb 2003 21:34:26 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jaroslav Kysela <perex@perex.cz>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PnP model
Message-ID: <20030205213426.GF22089@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"greg@kroah.com" <greg@kroah.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030204094634.A11346@flint.arm.linux.org.uk> <Pine.LNX.4.44.0302041117500.1278-100000@pnote.perex-int.cz> <20030204104937.A13453@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204104937.A13453@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 10:49:37AM +0000, Russell King wrote:
> On Tue, Feb 04, 2003 at 11:18:36AM +0100, Jaroslav Kysela wrote:
> > I think that legacy devices must be probed after PnP ones, otherwise
> > you'll get these duplications.
> 
> Unfortunately, this isn't easy to do, while keeping stuff like serial
> consoles working from early at bootup.  Alan Cox definitely does not
> want to see the serial console initialised any later than it is today,
> and he's not the only one.
> 
> In addition, the "legacy" devices are part of the 8250.c module - they
> have to be for serial console.  The PNP devices are probed as part of
> the 8250_pnp.c module, and since 8250_pnp.c depends on 8250.c, the
> serial PNP ports will _always_ be initialised after the ISA probes.
>

I think I have an alternative solution.  If we add support for current
resource configs and don't reset the cards, we can determine what the
active configuration was when the serial driver detects the isapnp card.
Because the device will remain active the resources will not be changed.
Below is a patch against my previous 5 patches.  This patch also
contains a few fixes and cleanups.  Could you please test this and let
me know if it solves the problem.

Also I noticed that the serial driver legacy probe, independent of my
changes, sometimes detects the incorrect irq, is proper irq detection
needed by the serial driver or will it still work properly even if
that information is detected incorrectly?

Thanks,
Adam


P.S.: ISAPnP MEM32 writing and reading still needs a little work.
P.S.: PNPBIOS MEM32s are fully supported.

diff -urN a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Mon Feb  3 19:44:01 2003
+++ b/drivers/pnp/interface.c	Tue Feb  4 20:58:01 2003
@@ -265,7 +265,6 @@
 			str += sprintf(str," %ld \n", pnp_dma(dev, i));
 		}
 	}
-	done:
 	return (str - buf);
 }
 
diff -urN a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sun Feb  2 18:43:34 2003
+++ b/drivers/pnp/isapnp/core.c	Wed Feb  5 21:06:09 2003
@@ -53,7 +53,7 @@
 
 int isapnp_disable;			/* Disable ISA PnP */
 int isapnp_rdp;				/* Read Data Port */
-int isapnp_reset = 1;			/* reset all PnP cards (deactivate) */
+int isapnp_reset = 0;			/* reset all PnP cards (deactivate) */
 int isapnp_skip_pci_scan;		/* skip PCI resource scanning */
 int isapnp_verbose = 1;			/* verbose mode */
 
@@ -259,7 +259,7 @@
 		 *	We cannot use NE2000 probe spaces for ISAPnP or we
 		 *	will lock up machines.
 		 */
-		if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1)) 
+		if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1))
 		{
 			isapnp_rdp = rdp;
 			return 0;
@@ -435,6 +435,7 @@
 /*
  *  Parse logical device tag.
  */
+static int isapnp_get_resources(struct pnp_dev *dev, struct pnp_resource_table * res);
 
 static struct pnp_dev * __init isapnp_parse_device(struct pnp_card *card, int size, int number)
 {
@@ -765,7 +766,7 @@
 /*
  *  Parse resource map for ISA PnP card.
  */
- 
+
 static void __init isapnp_parse_resource_map(struct pnp_card *card)
 {
 	unsigned char type, tmp[17];
@@ -822,7 +823,7 @@
 {
 	int i, j;
 	unsigned char checksum = 0x6a, bit, b;
-	
+
 	for (i = 0; i < 8; i++) {
 		b = data[i];
 		for (j = 0; j < 8; j++) {
@@ -855,6 +856,63 @@
 	pnpc_add_id(id,card);
 }
 
+
+static int isapnp_parse_current_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
+{
+	int tmp, ret;
+	struct pnp_rule_table rule;
+	if (dev->rule)
+		rule = *dev->rule;
+	else {
+		if (!pnp_generate_rule(dev,1,&rule))
+			return -EINVAL;
+	}
+
+	dev->active = isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
+	if (dev->active) {
+		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
+			ret = isapnp_read_word(ISAPNP_CFG_PORT + (tmp << 1));
+			if (!ret)
+				continue;
+			res->port_resource[tmp].start = ret;
+			if (rule.port[tmp])
+				res->port_resource[tmp].end = ret + rule.port[tmp]->size - 1;
+			else
+				res->port_resource[tmp].end = ret + 1; /* all we can do is assume 1 :-( */
+			res->port_resource[tmp].flags = IORESOURCE_IO;
+		}
+		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
+			ret = isapnp_read_dword(ISAPNP_CFG_MEM + (tmp << 3));
+			if (!ret)
+				continue;
+			res->mem_resource[tmp].start = ret;
+			if (rule.mem[tmp])
+				res->mem_resource[tmp].end = ret + rule.mem[tmp]->size - 1;
+			else
+				res->mem_resource[tmp].end = ret + 1; /* all we can do is assume 1 :-( */
+			res->mem_resource[tmp].flags = IORESOURCE_MEM;
+		}
+		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
+			ret = (isapnp_read_word(ISAPNP_CFG_IRQ + (tmp << 1)) >> 8);
+			if (!ret)
+				continue;
+			res->irq_resource[tmp].start = res->irq_resource[tmp].end = ret;
+			res->irq_resource[tmp].flags = IORESOURCE_IRQ;
+		}
+		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
+			ret = isapnp_read_byte(ISAPNP_CFG_DMA + tmp);
+			if (ret == 4)
+				continue;
+			if (rule.dma[tmp]) { /* some isapnp systems forget to set this to 4 so we have to check */
+				res->dma_resource[tmp].start = res->dma_resource[tmp].end = ret;
+				res->dma_resource[tmp].flags = IORESOURCE_DMA;
+			}
+		}
+	}
+	return 0;
+}
+
+
 /*
  *  Build device list for all present ISA PnP devices.
  */
@@ -864,6 +922,7 @@
 	int csn;
 	unsigned char header[9], checksum;
 	struct pnp_card *card;
+	struct pnp_dev *dev;
 
 	isapnp_wait();
 	isapnp_key();
@@ -896,8 +955,17 @@
 			printk(KERN_ERR "isapnp: checksum for device %i is not valid (0x%x)\n", csn, isapnp_checksum_value);
 		card->checksum = isapnp_checksum_value;
 		card->protocol = &isapnp_protocol;
+
+		/* read the current resource data */
+		card_for_each_dev(card,dev) {
+			isapnp_device(dev->number);
+		pnp_init_resource_table(&dev->res);
+			isapnp_parse_current_resources(dev, &dev->res);
+		}
+
 		pnpc_add_card(card);
 	}
+	isapnp_wait();
 	return 0;
 }
 
@@ -971,16 +1039,12 @@
 
 static int isapnp_get_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
 {
-	/* We don't need to do anything but this, the rest is taken care of */
-	if (pnp_port_valid(dev, 0) == 0 &&
-	    pnp_mem_valid(dev, 0) == 0 &&
-	    pnp_irq_valid(dev, 0) == 0 &&
-	    pnp_dma_valid(dev, 0) == 0)
-		dev->active = 0;
-	else
-		dev->active = 1;
-	*res = dev->res;
-	return 0;
+	int ret;
+	pnp_init_resource_table(res);
+	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_parse_current_resources(dev, res);
+	isapnp_cfg_end();
+	return ret;
 }
 
 static int isapnp_set_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
@@ -989,18 +1053,19 @@
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
-	for (tmp = 0; tmp < 8 && res->port_resource[tmp].flags & IORESOURCE_IO; tmp++)
+	for (tmp = 0; tmp < PNP_MAX_PORT && res->port_resource[tmp].flags & IORESOURCE_IO; tmp++)
 		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), res->port_resource[tmp].start);
-	for (tmp = 0; tmp < 2 && res->irq_resource[tmp].flags & IORESOURCE_IRQ; tmp++) {
+	for (tmp = 0; tmp < PNP_MAX_IRQ && res->irq_resource[tmp].flags & IORESOURCE_IRQ; tmp++) {
 		int irq = res->irq_resource[tmp].start;
 		if (irq == 2)
 			irq = 9;
 		isapnp_write_byte(ISAPNP_CFG_IRQ+(tmp<<1), irq);
 	}
-	for (tmp = 0; tmp < 2 && res->dma_resource[tmp].flags & IORESOURCE_DMA; tmp++)
+	for (tmp = 0; tmp < PNP_MAX_DMA && res->dma_resource[tmp].flags & IORESOURCE_DMA; tmp++)
 		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, res->dma_resource[tmp].start);
-	for (tmp = 0; tmp < 4 && res->mem_resource[tmp].flags & IORESOURCE_MEM; tmp++)
+	for (tmp = 0; tmp < PNP_MAX_MEM && res->mem_resource[tmp].flags & IORESOURCE_MEM; tmp++)
 		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (res->mem_resource[tmp].start >> 8) & 0xffff);
+	/* FIXME: We aren't handling 32bit mems properly here */
 	isapnp_activate(dev->number);
 	isapnp_cfg_end();
 	return 0;
@@ -1010,7 +1075,7 @@
 {
 	if (!dev || !dev->active)
 		return -EINVAL;
-      	isapnp_cfg_begin(dev->card->number, dev->number);
+	isapnp_cfg_begin(dev->card->number, dev->number);
 	isapnp_deactivate(dev->number);
 	dev->active = 0;
 	isapnp_cfg_end();
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Mon Feb  3 19:44:02 2003
+++ b/drivers/pnp/resource.c	Wed Feb  5 20:01:16 2003
@@ -725,6 +725,12 @@
 	return 0;
 }
 
+/**
+ * pnp_init_resource_table - Resets a resource table to default values.
+ * @table: pointer to the desired resource table
+ *
+ */
+
 void pnp_init_resource_table(struct pnp_resource_table *table)
 {
 	int idx;
@@ -787,6 +793,8 @@
 static struct pnp_change * pnp_add_change(struct pnp_change * parent, struct pnp_dev * dev)
 {
 	struct pnp_change * change = pnp_alloc(sizeof(struct pnp_change));
+	if (!change)
+		return NULL;
 	change->res_bak = dev->res;
 	change->rule_bak = *dev->rule;
 	change->dev = dev;
@@ -805,7 +813,15 @@
 		list_splice_init(&change->changes, &parent->changes);
 }
 
-static int pnp_generate_rule(struct pnp_dev *dev, int depnum)
+/**
+ * pnp_generate_rule - Creates a rule table structure based on depnum and device.
+ * @dev: pointer to the desired device
+ * @depnum: dependent function, if not valid will return an error
+ * @rule: pointer to a rule structure to record data to
+ *
+ */
+
+int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule)
 {
 	int nport = 0, nirq = 0, ndma = 0, nmem = 0;
 	struct pnp_resources * res;
@@ -813,7 +829,6 @@
 	struct pnp_mem * mem;
 	struct pnp_irq * irq;
 	struct pnp_dma * dma;
-	struct pnp_rule_table * rule = dev->rule;
 
 	if (depnum <= 0 || !rule)
 		return -EINVAL;
@@ -905,7 +920,7 @@
 		for (; depnum <= max; depnum++) {
 			struct pnp_resources * res = pnp_find_resources(dev, depnum);
 			if (res->priority == priority) {
-				if(pnp_generate_rule(dev, depnum)) {
+				if(pnp_generate_rule(dev, depnum, dev->rule)) {
 					dev->rule->depnum = depnum;
 					return 1;
 				}
@@ -923,7 +938,7 @@
 	struct pnp_dev * cdev;
 
 	for (i = 0; i < PNP_MAX_PORT; i++) {
-		if (dev->res.port_resource[i].start == 0) {
+		if (dev->res.port_resource[i].start == 0 || pnp_check_port_conflicts(dev,i,SEARCH_WARM)) {
 			if (!pnp_next_port(dev,i))
 				return 0;
 		}
@@ -938,7 +953,7 @@
 		pnp_commit_changes(parent, change);
 	}
 	for (i = 0; i < PNP_MAX_MEM; i++) {
-		if (dev->res.mem_resource[i].start == 0) {
+		if (dev->res.mem_resource[i].start == 0 || pnp_check_mem_conflicts(dev,i,SEARCH_WARM)) {
 			if (!pnp_next_mem(dev,i))
 				return 0;
 		}
@@ -953,7 +968,7 @@
 		pnp_commit_changes(parent, change);
 	}
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
-		if (dev->res.irq_resource[i].start == -1) {
+		if (dev->res.irq_resource[i].start == -1 || pnp_check_irq_conflicts(dev,i,SEARCH_WARM)) {
 			if (!pnp_next_irq(dev,i))
 				return 0;
 		}
@@ -968,7 +983,7 @@
 		pnp_commit_changes(parent, change);
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
-		if (dev->res.dma_resource[i].start == -1) {
+		if (dev->res.dma_resource[i].start == -1 || pnp_check_dma_conflicts(dev,i,SEARCH_WARM)) {
 			if (!pnp_next_dma(dev,i))
 				return 0;
 		}
@@ -989,6 +1004,8 @@
 {
 	struct pnp_change * change = pnp_add_change(parent,dev);
 	move--;
+	if (!change)
+		return 0;
 	if (!dev->rule)
 		goto fail;
 	if (!pnp_can_configure(dev))
@@ -1014,7 +1031,8 @@
 	return 0;
 }
 
-static int pnp_generate_config(struct pnp_dev * dev)
+/* this advanced algorithm will shuffle other configs to make room and ensure that the most possible devices have configs */
+static int pnp_advanced_config(struct pnp_dev * dev)
 {
 	int move;
 	/* if the device cannot be configured skip it */
@@ -1036,7 +1054,6 @@
 		spin_unlock(&pnp_lock);
 	}
 
-	spin_lock(&pnp_lock);
 	pnp_init_resource_table(&dev->res);
 	dev->rule->depnum = 0;
 	spin_unlock(&pnp_lock);
@@ -1054,7 +1071,7 @@
 		do {
 			cdev = pnp_check_port_conflicts(dev,i,SEARCH_COLD);
 			if (cdev)
-				pnp_generate_config(cdev);
+				pnp_advanced_config(cdev);
 		} while (cdev);
 	}
 	for (i = 0; i < PNP_MAX_MEM; i++)
@@ -1062,7 +1079,7 @@
 		do {
 			cdev = pnp_check_mem_conflicts(dev,i,SEARCH_COLD);
 			if (cdev)
-				pnp_generate_config(cdev);
+				pnp_advanced_config(cdev);
 		} while (cdev);
 	}
 	for (i = 0; i < PNP_MAX_IRQ; i++)
@@ -1070,7 +1087,7 @@
 		do {
 			cdev = pnp_check_irq_conflicts(dev,i,SEARCH_COLD);
 			if (cdev)
-				pnp_generate_config(cdev);
+				pnp_advanced_config(cdev);
 		} while (cdev);
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++)
@@ -1078,12 +1095,59 @@
 		do {
 			cdev = pnp_check_dma_conflicts(dev,i,SEARCH_COLD);
 			if (cdev)
-				pnp_generate_config(cdev);
+				pnp_advanced_config(cdev);
 		} while (cdev);
 	}
 	return 1;
 }
 
+/* this is a much faster algorithm but it may not leave resources for other devices to use */
+static int pnp_simple_config(struct pnp_dev * dev)
+{
+	int i;
+	spin_lock(&pnp_lock);
+	if (dev->active) {
+		spin_unlock(&pnp_lock);
+		return 1;
+	}
+	dev->rule->depnum = 0;
+	pnp_init_resource_table(&dev->res);
+	if (!dev->rule) {
+		dev->rule = pnp_alloc(sizeof(struct pnp_rule_table));
+		if (!dev->rule) {
+			spin_unlock(&pnp_lock);
+			return -ENOMEM;
+		}
+	}
+	while (pnp_next_rule(dev)) {
+		for (i = 0; i < PNP_MAX_PORT; i++) {
+			if (!pnp_next_port(dev,i))
+				continue;
+		}
+		for (i = 0; i < PNP_MAX_MEM; i++) {
+			if (!pnp_next_mem(dev,i))
+				continue;
+		}
+		for (i = 0; i < PNP_MAX_IRQ; i++) {
+			if (!pnp_next_irq(dev,i))
+				continue;
+		}
+		for (i = 0; i < PNP_MAX_DMA; i++) {
+			if (!pnp_next_dma(dev,i))
+				continue;
+		}
+		goto done;
+	}
+	pnp_init_resource_table(&dev->res);
+	dev->rule->depnum = 0;
+	spin_unlock(&pnp_lock);
+	return 0;
+
+done:
+	pnp_resolve_conflicts(dev);	/* this is required or we will break the advanced configs */
+	return 1;
+}
+
 static int pnp_compare_resources(struct pnp_resource_table * resa, struct pnp_resource_table * resb)
 {
 	int idx;
@@ -1136,6 +1200,7 @@
 /**
  * pnp_auto_config_dev - determines the best possible resource configuration based on available information
  * @dev: pointer to the desired device
+ *
  */
 
 int pnp_auto_config_dev(struct pnp_dev *dev)
@@ -1149,7 +1214,7 @@
 	if(dev->active)
 		error = pnp_resolve_conflicts(dev);
 	else
-		error = pnp_generate_config(dev);
+		error = pnp_advanced_config(dev);
 	return error;
 }
 
@@ -1157,6 +1222,8 @@
  * pnp_manual_config_dev - Disables Auto Config and Manually sets the resource table
  * @dev: pointer to the desired device
  * @res: pointer to the new resource config
+ *
+ * This function can be used by drivers that want to manually set thier resources.
  */
 
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table * res, int mode)
@@ -1190,9 +1257,7 @@
 	}
 	spin_unlock(&pnp_lock);
 
-	if (mode & PNP_CONFIG_RESOLVE)
-		pnp_resolve_conflicts(dev);
-
+	pnp_resolve_conflicts(dev);
 	dev->config_mode = PNP_CONFIG_MANUAL;
 
 fail:
@@ -1216,49 +1281,51 @@
 		pnp_info("res: The PnP device '%s' is already active.", dev->dev.bus_id);
 		return -EBUSY;
 	}
-	/* if the auto config failed, try again now, because this device was requested before others it's best to find a config at all costs */
+	spin_lock(&pnp_lock);	/* we lock just in case the device is being configured during this call */
+	dev->active = 1;
+	spin_unlock(&pnp_lock); /* once the device is claimed active we know it won't be configured so we can unlock */
+
+	/* If this condition is true, advanced configuration failed, we need to get this device up and running
+	 * so we use the simple config engine which ignores cold conflicts, this of course may lead to new failures */
 	if (!pnp_is_active(dev)) {
-		spin_lock(&pnp_lock);
-		if (!pnp_next_config(dev,1,NULL)) {
-			pnp_init_resource_table(&dev->res);
-			dev->rule->depnum = 0;
-			pnp_err("res: Unable to resolve resource conflicts for the device '%s'", dev->dev.bus_id);
-			spin_unlock(&pnp_lock);
-			return -EBUSY;
+		if (!pnp_simple_config(dev)) {
+			pnp_err("res: Unable to resolve resource conflicts for the device '%s'.", dev->dev.bus_id);
+			goto fail;
 		}
-		spin_unlock(&pnp_lock);
 	}
 	if (dev->config_mode & PNP_CONFIG_INVALID) {
-		pnp_info("res: Unable to activate the PnP device '%s' because its resource configuration is invalid", dev->dev.bus_id);
-		return -EINVAL;
+		pnp_info("res: Unable to activate the PnP device '%s' because its resource configuration is invalid.", dev->dev.bus_id);
+		goto fail;
 	}
 	if (dev->status != PNP_READY && dev->status != PNP_ATTACHED){
-		pnp_err("res: Activation failed because the PnP device '%s' is busy", dev->dev.bus_id);
-		return -EBUSY;
+		pnp_err("res: Activation failed because the PnP device '%s' is busy.", dev->dev.bus_id);
+		goto fail;
 	}
 	if (!pnp_can_write(dev)) {
-		pnp_info("res: Unable to activate the PnP device '%s' because this feature is not supported", dev->dev.bus_id);
-		return -EINVAL;
+		pnp_info("res: Unable to activate the PnP device '%s' because this feature is not supported.", dev->dev.bus_id);
+		goto fail;
 	}
 	if (!dev->protocol->set(dev, &dev->res)<0) {
-		pnp_err("res: The protocol '%s' reports that activating the PnP device '%s' has failed", dev->protocol->name, dev->dev.bus_id);
-		return -1;
+		pnp_err("res: The protocol '%s' reports that activating the PnP device '%s' has failed.", dev->protocol->name, dev->dev.bus_id);
+		goto fail;
 	}
 	if (pnp_can_read(dev)) {
 		struct pnp_resource_table res;
 		dev->protocol->get(dev, &res);
-		if (pnp_compare_resources(&dev->res, &res)) {
-			pnp_err("res: The resources requested do not match those actually set for the PnP device '%s'", dev->dev.bus_id);
-			return -1;
-		}
+		if (pnp_compare_resources(&dev->res, &res)) /* if this happens we may be in big trouble but it's best just to continue */
+			pnp_err("res: The resources requested do not match those set for the PnP device '%s', please report.", dev->dev.bus_id);
 	} else
 		dev->active = pnp_is_active(dev);
-	pnp_dbg("res: the device '%s' has been activated", dev->dev.bus_id);
+	pnp_dbg("res: the device '%s' has been activated.", dev->dev.bus_id);
 	if (dev->rule) {
 		kfree(dev->rule);
 		dev->rule = NULL;
 	}
 	return 0;
+
+fail:
+	dev->active = 0; /* fixes incorrect active state */
+	return -EINVAL;
 }
 
 /**
@@ -1277,18 +1344,19 @@
 		return -EINVAL;
 	}
 	if (dev->status != PNP_READY){
-		pnp_info("res: Disable failed becuase the PnP device '%s' is busy", dev->dev.bus_id);
+		pnp_info("res: Disable failed becuase the PnP device '%s' is busy.", dev->dev.bus_id);
 		return -EINVAL;
 	}
-	if (!pnp_can_disable(dev)<0) {
-		pnp_info("res: Unable to disable the PnP device '%s' because this feature is not supported", dev->dev.bus_id);
+	if (!pnp_can_disable(dev)) {
+		pnp_info("res: Unable to disable the PnP device '%s' because this feature is not supported.", dev->dev.bus_id);
 		return -EINVAL;
 	}
-	if (!dev->protocol->disable(dev)) {
-		pnp_err("res: The protocol '%s' reports that disabling the PnP device '%s' has failed", dev->protocol->name, dev->dev.bus_id);
+	if (dev->protocol->disable(dev)<0) {
+		pnp_err("res: The protocol '%s' reports that disabling the PnP device '%s' has failed.", dev->protocol->name, dev->dev.bus_id);
 		return -1;
 	}
-	pnp_dbg("the device '%s' has been disabled", dev->dev.bus_id);
+	dev->active = 0; /* just in case the protocol doesn't do this */
+	pnp_dbg("the device '%s' has been disabled.", dev->dev.bus_id);
 	return 0;
 }
 
diff -urN a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Mon Feb  3 19:44:02 2003
+++ b/include/linux/pnp.h	Tue Feb  4 21:41:01 2003
@@ -303,9 +303,8 @@
 /* config modes */
 #define PNP_CONFIG_AUTO		0x0001	/* Use the Resource Configuration Engine to determine resource settings */
 #define PNP_CONFIG_MANUAL	0x0002	/* the config has been manually specified */
-#define PNP_CONFIG_FORCE	0x0003	/* disables validity checking */
-#define PNP_CONFIG_RESOLVE	0x0008	/* moves other configs out of the way, use only when absolutely necessary */
-#define PNP_CONFIG_INVALID	0x0010	/* If this flag is set, the pnp layer will refuse to activate the device */
+#define PNP_CONFIG_FORCE	0x0004	/* disables validity checking */
+#define PNP_CONFIG_INVALID	0x0008	/* If this flag is set, the pnp layer will refuse to activate the device */
 
 /* capabilities */
 #define PNP_READ		0x0001
@@ -381,6 +380,7 @@
 int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data);
 int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data);
 void pnp_init_resource_table(struct pnp_resource_table *table);
+int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
 void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
@@ -421,6 +421,7 @@
 static inline int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
 static inline int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
 static inline void pnp_init_resource_table(struct pnp_resource_table *table) { ; }
+static inline int pnp_generate_rule(struct pnp_dev * dev, int depnum, struct pnp_rule_table * rule) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { ; }
