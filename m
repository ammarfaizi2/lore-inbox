Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271718AbRH0Mjn>; Mon, 27 Aug 2001 08:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271714AbRH0Mje>; Mon, 27 Aug 2001 08:39:34 -0400
Received: from 20dyn24.com21.casema.net ([213.17.90.24]:6159 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S271711AbRH0Mj2>; Mon, 27 Aug 2001 08:39:28 -0400
Message-Id: <200108271239.OAA13583@cave.bitwizard.nl>
Subject: [PATCH] Firestream: Multi-phy. 
To: Linus Torvalds <Torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-atm-general@lists.sourceforge.net
Date: Mon, 27 Aug 2001 14:39:21 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Alan, others, 

The Firestream ATM SAR can be connected to multiple Physical interface
chips over the "utopia-2" bus. So far the driver would always address
the PHY at address 0. This patch allows the driver to address multiple
PHY devices. 

When instructed to do so, the driver will present itself as multiple
cards. This was the cleanest way that I could find to fit this into
the "scheme of things". 

Somehow, the Makefile entry for the firestream driver was lost in the
standard line of the kernels. 


			Roger Wolff. 

P.S. I created the patch on 2.4.6, but it has been tested & applies
cleanly on 2.4.9 . 


#-------------------------------------------------------------------

diff -ur linux-2.4.6.clean/drivers/atm/Makefile linux-2.4.6.fs/drivers/atm/Makefile
--- linux-2.4.6.clean/drivers/atm/Makefile	Mon Aug 27 14:11:31 2001
+++ linux-2.4.6.fs/drivers/atm/Makefile	Mon Aug 27 14:12:07 2001
@@ -25,6 +25,7 @@
 obj-$(CONFIG_ATM_AMBASSADOR) += ambassador.o
 obj-$(CONFIG_ATM_TCP) += atmtcp.o
 obj-$(CONFIG_ATM_IA) += iphase.o suni.o
+obj-$(CONFIG_ATM_FIRESTREAM) += firestream.o
 
 ifeq ($(CONFIG_ATM_FORE200E_PCA),y)
   FORE200E_FW_OBJS += fore200e_pca_fw.o
diff -ur linux-2.4.6.clean/drivers/atm/firestream.c linux-2.4.6.fs/drivers/atm/firestream.c
--- linux-2.4.6.clean/drivers/atm/firestream.c	Wed May  2 18:29:55 2001
+++ linux-2.4.6.fs/drivers/atm/firestream.c	Mon Aug 27 14:33:36 2001
@@ -295,6 +295,7 @@
 
 
 static int fs_keystream = 0;
+static int fs_maxphy = 1;
 
 #ifdef DEBUG
 /* I didn't forget to set this to zero before shipping. Hit me with a stick 
@@ -308,6 +309,7 @@
 #ifdef DEBUG 
 MODULE_PARM(fs_debug, "i");
 #endif
+MODULE_PARM(fs_maxphy, "i");
 MODULE_PARM(loopback, "i");
 MODULE_PARM(num, "i");
 MODULE_PARM(fs_keystream, "i");
@@ -866,6 +868,7 @@
 	int bfp;
 	int to;
 	unsigned short tmc0;
+	int uaddr;
 
 	func_enter ();
 
@@ -908,6 +911,9 @@
 	txtp = &atm_vcc->qos.txtp;
 	rxtp = &atm_vcc->qos.rxtp;
 
+	/* XXX Use VPI? How many bits? Which bits? */
+	uaddr = atm_vcc->dev->number - dev->start_number;
+
 	if (!test_bit(ATM_VF_PARTIAL, &atm_vcc->flags)) {
 		if (IS_FS50(dev)) {
 			/* Increment the channel numer: take a free one next time.  */
@@ -1012,7 +1018,7 @@
 		tc->TMC[2] = 0; /* Unused */
 		tc->TMC[3] = 0; /* Unused */
     
-		tc->spec = 0;    /* UTOPIA address, UDF, HEC: Unused -> 0 */
+		tc->spec = uaddr << 16;  /* UTOPIA address, UDF, HEC: Unused -> 0 */
 		tc->rtag[0] = 0; /* What should I do with routing tags??? 
 				    -- Not used -- AS -- Thanks -- REW*/
 		tc->rtag[1] = 0;
@@ -1081,7 +1087,7 @@
 			submit_command (dev, &dev->hp_txq, 
 					QE_CMD_REG_WR | QE_CMD_IMM_INQ,
 					0x80 + vcc->channo,
-					(vpi << 16) | vci, 0 ); /* XXX -- Use defines. */
+					(uaddr << 28) | (vpi << 16) | vci, 0 ); /* XXX -- Use defines. */
 		}
 		submit_command (dev, &dev->hp_txq, 
 				QE_CMD_RX_EN | QE_CMD_IMM_INQ | vcc->channo,
@@ -1772,8 +1778,10 @@
 
 	if (IS_FS50 (dev)) {
 		write_fs (dev, RAS0, RAS0_DCD_XHLT);
-		dev->atm_dev->ci_range.vpi_bits = 12;
-		dev->atm_dev->ci_range.vci_bits = 16;
+		for (i=0;i<fs_maxphy;i++) {
+			dev->atm_dev[i]->ci_range.vpi_bits = 12;
+			dev->atm_dev[i]->ci_range.vci_bits = 16;
+		}
 		dev->nchannels = FS50_NR_CHANNELS;
 	} else {
 		write_fs (dev, RAS0, RAS0_DCD_XHLT 
@@ -1781,8 +1789,10 @@
 			  | (((1 << FS155_VCI_BITS) - 1) * RAS0_VCSEL));
 		/* We can chose the split arbitarily. We might be able to 
 		   support more. Whatever. This should do for now. */
-		dev->atm_dev->ci_range.vpi_bits = FS155_VPI_BITS;
-		dev->atm_dev->ci_range.vci_bits = FS155_VCI_BITS;
+		for (i=0;i<fs_maxphy;i++) {
+			dev->atm_dev[i]->ci_range.vpi_bits = FS155_VPI_BITS;
+			dev->atm_dev[i]->ci_range.vci_bits = FS155_VCI_BITS;
+		}
     
 		/* Address bits we can't use should be compared to 0. */
 		write_fs (dev, RAC, 0);
@@ -1817,9 +1827,14 @@
 	}
 	memset (dev->tx_inuse, 0, dev->nchannels / 8);
 
-	/* -- RAS1 : FS155 and 50 differ. Default (0) should be OK for both */
-	/* -- RAS2 : FS50 only: Default is OK. */
+	if (IS_FS50 (dev)) {
+		/* -- RAS1 : FS155 and 50 differ. Default (0) should be OK for FS155, FS50/multiphy needs the maxPHY set... */
+		write_fs (dev, RAS1, (fs_maxphy - 1) * RAS1_UTREG);
 
+		/* -- RAS2 : FS50 only: Default is OK. */
+		/* Enable selecting for Utopia address for multiphy configs. */
+		write_fs (dev, RAS2, RAS2_USEL);
+	}
 	/* DMAMODE, default should be OK. -- REW */
 	write_fs (dev, DMAMR, DMAMR_TX_MODE_FULL);
 
@@ -1888,7 +1903,8 @@
 	add_timer (&dev->timer);
 #endif
 
-	dev->atm_dev->dev_data = dev;
+	for (i=0;i<fs_maxphy;i++)
+		dev->atm_dev[i]->dev_data = dev;
   
 	func_exit ();
 	return 0;
@@ -1897,9 +1913,9 @@
 static int __init firestream_init_one (struct pci_dev *pci_dev,
 				       const struct pci_device_id *ent) 
 {
-	struct atm_dev *atm_dev;
 	struct fs_dev *fs_dev;
-	
+	int i;
+
 	if (pci_enable_device(pci_dev)) 
 		goto err_out;
 
@@ -1910,13 +1926,17 @@
 		goto err_out;
 
 	memset (fs_dev, 0, sizeof (struct fs_dev));
-  
-	atm_dev = atm_dev_register("fs", &ops, -1, NULL);
-	if (!atm_dev)
-		goto err_out_free_fs_dev;
-  
+
+	for (i=0;i<fs_maxphy;i++) {
+		fs_dev->atm_dev[i] = atm_dev_register("fs", &ops, -1, NULL);
+		if (!fs_dev->atm_dev[i])
+			goto err_out_free_atm_dev;
+	}
+	/* XXX if another device is registering atm devices at the same time
+	   we get confusion.  */
+	fs_dev->start_number = fs_dev->atm_dev[0]->number;
+
 	fs_dev->pci_dev = pci_dev;
-	fs_dev->atm_dev = atm_dev;
 	fs_dev->flags = ent->driver_data;
 
 	if (fs_init(fs_dev))
@@ -1927,7 +1947,8 @@
 	return 0;
 
  err_out_free_atm_dev:
-	atm_dev_deregister(atm_dev);
+	for (i--;i >= 0;i--)
+		atm_dev_deregister(fs_dev->atm_dev[i]);
  err_out_free_fs_dev:
 	kfree(fs_dev);
  err_out:
@@ -2002,7 +2023,9 @@
 		free_irq (dev->irq, dev);
 		del_timer (&dev->timer);
 
-		atm_dev_deregister(dev->atm_dev);
+		for (i=0;i<fs_maxphy;i++)
+			atm_dev_deregister(dev->atm_dev[i]);
+
 		free_queue (dev, &dev->hp_txq);
 		free_queue (dev, &dev->lp_txq);
 		free_queue (dev, &dev->tx_relq);
diff -ur linux-2.4.6.clean/drivers/atm/firestream.h linux-2.4.6.fs/drivers/atm/firestream.h
--- linux-2.4.6.clean/drivers/atm/firestream.h	Wed May  2 18:29:55 2001
+++ linux-2.4.6.fs/drivers/atm/firestream.h	Mon Aug 27 13:45:21 2001
@@ -345,13 +345,15 @@
 #define CELLOSCONF_COST   (0x1 <<  0)
 /* Bits? */
 
-
 #define RAS0 0x1bc
 #define RAS0_DCD_XHLT (0x1 << 31)
 
 #define RAS0_VPSEL    (0x1 << 16)
 #define RAS0_VCSEL    (0x1 <<  0)
 
+#define RAS1 0x1c0
+#define RAS1_UTREG    (0x1 << 5)
+
 
 #define DMAMR 0x1cc
 #define DMAMR_TX_MODE_FULL (0x0 << 0)
@@ -360,6 +362,14 @@
 
 
 
+#define RAS2 0x280
+
+#define RAS2_NNI  (0x1 << 0)
+#define RAS2_USEL (0x1 << 1)
+#define RAS2_UBS  (0x1 << 2)
+
+
+
 struct fs_transmit_config {
 	u32 flags;
 	u32 atm_hdr;
@@ -456,6 +466,7 @@
 	int n;
 };
 
+#define MAX_PHY 0x20
 
 struct fs_dev {
 	struct fs_dev *next;		/* other FS devices */
@@ -463,8 +474,9 @@
 
 	unsigned char irq;		/* IRQ */
 	struct pci_dev *pci_dev;	/* PCI stuff */
-	struct atm_dev *atm_dev;
+	struct atm_dev *atm_dev[MAX_PHY];
 	struct timer_list timer;
+	int start_number; 
 
 	unsigned long hw_base;		/* mem base address */
 	unsigned long base;             /* Mapping of base address */




-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
