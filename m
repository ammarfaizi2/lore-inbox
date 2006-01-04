Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWADWCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWADWCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWADWB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:01:56 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:53238 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932080AbWADWBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:01:50 -0500
Date: Wed, 04 Jan 2006 17:01:30 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 13/15] irda/nsc-ircc: Add ISAPNP support
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00EQ796X6A@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Author: Jean Tourrilhes <jt@hpl.hp.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/net/irda/nsc-ircc.c |  102 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 98 insertions(+), 4 deletions(-)

7fd4a2788d8e81700779727795757252e92ea394
diff --git a/drivers/net/irda/nsc-ircc.c b/drivers/net/irda/nsc-ircc.c
index ee717d0..fe07bf9 100644
--- a/drivers/net/irda/nsc-ircc.c
+++ b/drivers/net/irda/nsc-ircc.c
@@ -12,6 +12,7 @@
  *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>
  *     Copyright (c) 1998 Lichen Wang, <lwang@actisys.com>
  *     Copyright (c) 1998 Actisys Corp., www.actisys.com
+ *     Copyright (c) 2000-2004 Jean Tourrilhes <jt@hpl.hp.com>
  *     All Rights Reserved
  *      
  *     This program is free software; you can redistribute it and/or 
@@ -53,6 +54,7 @@
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
 #include <linux/dma-mapping.h>
+#include <linux/pnp.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -87,6 +89,8 @@ static int nsc_ircc_probe_39x(nsc_chip_t
 static int nsc_ircc_init_108(nsc_chip_t *chip, chipio_t *info);
 static int nsc_ircc_init_338(nsc_chip_t *chip, chipio_t *info);
 static int nsc_ircc_init_39x(nsc_chip_t *chip, chipio_t *info);
+static int __devinit nsc_ircc_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *id);
+static void __devexit nsc_ircc_pnp_remove(struct pnp_dev * dev);
 
 /* These are the known NSC chips */
 static nsc_chip_t chips[] = {
@@ -126,8 +130,24 @@ static char *dongle_types[] = {
 	"No dongle connected",
 };
 
+/* PNP probing */
+static const struct pnp_device_id nsc_ircc_pnp_table[] = {
+	{ .id = "NSC6001", .driver_data = 0 },
+	{ .id = "IBM0071", .driver_data = 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pnp, nsc_ircc_pnp_table);
+
+static struct pnp_driver nsc_ircc_pnp_driver = {
+	.name = "nsc-ircc",
+	.id_table = nsc_ircc_pnp_table,
+	.probe = nsc_ircc_pnp_probe,
+	.remove = __devexit_p(nsc_ircc_pnp_remove),
+};
+
 /* Some prototypes */
-static int  nsc_ircc_open(int i, chipio_t *info);
+static int  nsc_ircc_open(chipio_t *info);
 static int  nsc_ircc_close(struct nsc_ircc_cb *self);
 static int  nsc_ircc_setup(chipio_t *info);
 static void nsc_ircc_pio_receive(struct nsc_ircc_cb *self);
@@ -148,6 +168,9 @@ static int  nsc_ircc_net_ioctl(struct ne
 static struct net_device_stats *nsc_ircc_net_get_stats(struct net_device *dev);
 static int nsc_ircc_pmproc(struct pm_dev *dev, pm_request_t rqst, void *data);
 
+/* Globals */
+static int pnp_registered_port;
+
 /*
  * Function nsc_ircc_init ()
  *
@@ -163,6 +186,14 @@ static int __init nsc_ircc_init(void)
 	int cfg, id;
 	int reg;
 	int i = 0;
+	int r;
+
+	/* Register with PnP subsystem to detect disable ports */
+	r = pnp_register_driver(&nsc_ircc_pnp_driver);
+	if (r >= 0) {
+		pnp_registered_port = 1;
+		ret = 0;
+	}
 
 	/* Probe for all the NSC chipsets we know about */
 	for (chip=chips; chip->name ; chip++) {
@@ -204,7 +235,7 @@ static int __init nsc_ircc_init(void)
 				} else
 					chip->probe(chip, &info);
 
-				if (nsc_ircc_open(i, &info) == 0)
+				if (nsc_ircc_open(&info) == 0)
 					ret = 0;
 				i++;
 			} else {
@@ -229,6 +260,9 @@ static void __exit nsc_ircc_cleanup(void
 
 	pm_unregister_all(nsc_ircc_pmproc);
 
+	if (pnp_registered_port)
+		pnp_unregister_driver(&nsc_ircc_pnp_driver);
+
 	for (i=0; i < 4; i++) {
 		if (dev_self[i])
 			nsc_ircc_close(dev_self[i]);
@@ -241,16 +275,26 @@ static void __exit nsc_ircc_cleanup(void
  *    Open driver instance
  *
  */
-static int __init nsc_ircc_open(int i, chipio_t *info)
+static int __devinit nsc_ircc_open(chipio_t *info)
 {
 	struct net_device *dev;
 	struct nsc_ircc_cb *self;
         struct pm_dev *pmdev;
 	void *ret;
 	int err;
+	int i;
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
+	for (i=0; i < 4; i++) {
+		if (!dev_self[i])
+			break;
+	}
+	if (i == 4) {
+		IRDA_ERROR("%s(), maximum number of supported chips reached!\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+
 	IRDA_MESSAGE("%s, Found chip at base=0x%03x\n", driver_name,
 		     info->cfg_base);
 
@@ -389,7 +433,7 @@ static int __init nsc_ircc_open(int i, c
  *    Close driver instance
  *
  */
-static int __exit nsc_ircc_close(struct nsc_ircc_cb *self)
+static int __devexit nsc_ircc_close(struct nsc_ircc_cb *self)
 {
 	int iobase;
 
@@ -806,6 +850,56 @@ static int nsc_ircc_probe_39x(nsc_chip_t
 	return 0;
 }
 
+/* PNP probing */
+static int __devinit
+nsc_ircc_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *id)
+{
+	chipio_t info;
+
+	memset(&info, 0, sizeof(chipio_t));
+	info.irq = -1;
+	info.dma = -1;
+
+	/* There don't seem to be any way to get the cfg_base.
+	 * On my box, cfg_base is in the PnP descriptor of the
+	 * motherboard. Oh well... Jean II */
+
+	if (pnp_port_valid(dev, 0) &&
+		!(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED))
+		info.fir_base = pnp_port_start(dev, 0);
+
+	if (pnp_irq_valid(dev, 0) &&
+		!(pnp_irq_flags(dev, 0) & IORESOURCE_DISABLED))
+		info.irq = pnp_irq(dev, 0);
+
+	if (pnp_dma_valid(dev, 0) &&
+		!(pnp_dma_flags(dev, 0) & IORESOURCE_DISABLED))
+		info.dma = pnp_dma(dev, 0);
+
+	IRDA_DEBUG(0, "%s() : Found cfg_base 0x%03X ; firbase 0x%03X ; irq %d ; dma %d.\n", __FUNCTION__, info.cfg_base, info.fir_base, info.irq, info.dma);
+
+	if(/*(info.cfg_base == 0) ||*/ (info.fir_base == 0) ||
+	   (info.irq == -1) || (info.dma == -1)) {
+		/* Returning an error will disable the device. Yuck ! */
+		//return -EINVAL;
+		return 0;
+	}
+
+	/* We should identify and initialise the device */
+	if (nsc_ircc_open(&info) == 0)
+		pnp_set_drvdata(dev, (void *)1);
+
+	return 0;
+}
+
+static void __devexit
+nsc_ircc_pnp_remove(struct pnp_dev * dev)
+{
+	int index = (int)pnp_get_drvdata(dev);
+	if (index && dev_self[index - 1])
+		nsc_ircc_close(dev_self[index - 1]);
+}
+
 /*
  * Function nsc_ircc_setup (info)
  *
-- 
1.0.5
