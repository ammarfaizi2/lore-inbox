Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTCEQSS>; Wed, 5 Mar 2003 11:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTCEQSS>; Wed, 5 Mar 2003 11:18:18 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:18189 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267613AbTCEQSD>; Wed, 5 Mar 2003 11:18:03 -0500
To: davies@maniac.ultranet.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] depca update
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 05 Mar 2003 17:27:22 +0100
Message-ID: <wrpof4psrrp.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

David, Alan,

I've updated the depca driver to use the EISA/sysfs framework. While I
had my hands under the hood, I got rid of check_region.

Since I only have an EISA board, this is untested on both ISA and
MCA. Also, modules being currently broken on alpha, this is only
tested when built-in.

Thanks for any comment,

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=depca.patch
Content-Description: DEPCA patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1038  -> 1.1039 
#	 drivers/net/depca.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/05	maz@hina.wild-wind.fr.eu.org	1.1039
# depca update :
#     Now use EISA/sysfs framework.
#     Get rid of check_region.
#     Properly reserve mem region.
# --------------------------------------------
#
diff -Nru a/drivers/net/depca.c b/drivers/net/depca.c
--- a/drivers/net/depca.c	Wed Mar  5 17:17:45 2003
+++ b/drivers/net/depca.c	Wed Mar  5 17:17:45 2003
@@ -230,6 +230,7 @@
       			   by acme@conectiva.com.br
       0.54    08-Nov-01	  use library crc32 functions
       			   by Matt_Domsch@dell.com
+      0.55    01-Mar-03   Use EISA/sysfs framework <maz@wild-wind.fr.eu.org>
 
     =========================================================================
 */
@@ -263,6 +264,11 @@
 #include <linux/mca.h>
 #endif
 
+#ifdef CONFIG_EISA
+#include <linux/device.h>
+#include <linux/eisa.h>
+#endif
+
 #include "depca.h"
 
 static char version[] __initdata = "depca.c:v0.53 2001/1/12 davies@maniac.ultranet.com\n";
@@ -328,6 +334,25 @@
 	DEPCA, de100, de101, de200, de201, de202, de210, de212, de422, unknown
 } adapter;
 
+#ifdef CONFIG_EISA
+struct eisa_device_id depca_eisa_ids[] = {
+	{ "DEC4220" },
+	{ "" }
+};
+
+static int depca_eisa_probe  (struct device *device);
+static int depca_eisa_remove (struct device *device);
+
+struct eisa_driver depca_eisa_driver = {
+	.id_table = depca_eisa_ids,
+	.driver   = {
+		.name    = "depca",
+		.probe   = depca_eisa_probe,
+		.remove  = __devexit_p (depca_eisa_remove)
+	}
+};
+#endif
+
 /*
 ** Miscellaneous info...
 */
@@ -388,6 +413,8 @@
 	void *rx_buff[NUM_RX_DESC];	/* CPU virt address of sh'd memory buffs  */
 	void *tx_buff[NUM_TX_DESC];	/* CPU virt address of sh'd memory buffs  */
 	void *sh_mem;		/* CPU mapped virt address of device RAM  */
+	u_long mem_start;	/* Bus address of device RAM (before remap) */
+	u_long mem_len;		/* device memory size */
 /* Device address space fields */
 	u_long device_ram_start;	/* Start of RAM in device addr space      */
 /* Offsets used in both address spaces */
@@ -450,10 +477,8 @@
 static void DepcaSignature(char *name, u_long paddr);
 static int DevicePresent(u_long ioaddr);
 static int get_hw_addr(struct net_device *dev);
-static int EISA_signature(char *name, s32 eisa_id);
 static void SetMulticastFilter(struct net_device *dev);
 static void isa_probe(struct net_device *dev, u_long iobase);
-static void eisa_probe(struct net_device *dev, u_long iobase);
 #ifdef CONFIG_MCA
 static void mca_probe(struct net_device *dev, u_long iobase);
 #endif
@@ -503,7 +528,9 @@
 		mca_probe(dev, iobase);
 #endif
 		isa_probe(dev, iobase);
-		eisa_probe(dev, iobase);
+#ifdef CONFIG_EISA
+		eisa_driver_register (&depca_eisa_driver);
+#endif
 
 		if ((tmp == num_depcas) && (iobase != 0) && loading_module) {
 			printk("%s: depca_probe() cannot find device at 0x%04lx.\n", dev->name, iobase);
@@ -530,6 +557,7 @@
 	int i, j, offset, netRAM, mem_len, status = 0;
 	s16 nicsr;
 	u_long mem_start = 0, mem_base[] = DEPCA_RAM_BASE_ADDRESSES;
+	int is_eisa = ((ioaddr & 0x0fff) == DEPCA_EISA_IO_PORTS);
 
 	STOP_DEPCA;
 
@@ -555,7 +583,7 @@
 
 	if (mca_slot != -1) {
 		printk("%s: %s at 0x%04lx (MCA slot %d)", dev->name, name, ioaddr, mca_slot);
-	} else if ((ioaddr & 0x0fff) == DEPCA_EISA_IO_PORTS) {	/* EISA slot address */
+	} else if (is_eisa) {	/* EISA slot address */
 		printk("%s: %s at 0x%04lx (EISA slot %d)", dev->name, name, ioaddr, (int) ((ioaddr >> 12) & 0x0f));
 	} else {		/* ISA port address */
 		printk("%s: %s at 0x%04lx", dev->name, name, ioaddr);
@@ -600,9 +628,11 @@
 	}
 
 	/* Define the device private memory */
-	dev->priv = (void *) kmalloc(sizeof(struct depca_private), GFP_KERNEL);
-	if (dev->priv == NULL)
-		return -ENOMEM;
+	if (!is_eisa) {
+		dev->priv = (void *) kmalloc(sizeof(struct depca_private), GFP_KERNEL);
+		if (dev->priv == NULL)
+			return -ENOMEM;
+	}
 	lp = (struct depca_private *) dev->priv;
 	memset((char *) dev->priv, 0, sizeof(struct depca_private));
 	lp->adapter = adapter;
@@ -610,18 +640,23 @@
 	lp->lock = SPIN_LOCK_UNLOCKED;
 	sprintf(lp->adapter_name, "%s (%s)", name, dev->name);
 	status = -EBUSY;
-	if (!request_region(ioaddr, DEPCA_TOTAL_SIZE, lp->adapter_name)) {
-		printk(KERN_ERR "depca: I/O resource 0x%x @ 0x%lx busy\n", DEPCA_TOTAL_SIZE, ioaddr);
-		goto out_priv;
-	}
 
 	/* Initialisation Block */
-	lp->sh_mem = ioremap(mem_start, mem_len);
+	if (!request_mem_region (mem_start, mem_len, lp->adapter_name)) {
+		printk(KERN_ERR "depca: cannot request ISA memory, aborting\n");
+		goto out_priv;
+	}
+		
 	status = -EIO;
+	lp->sh_mem = ioremap(mem_start, mem_len);
 	if (lp->sh_mem == NULL) {
 		printk(KERN_ERR "depca: cannot remap ISA memory, aborting\n");
-		goto out_region;
+		release_mem_region (mem_start, mem_len);
+		goto out_priv;
 	}
+
+	lp->mem_start = mem_start;
+	lp->mem_len   = mem_len;
 	lp->device_ram_start = mem_start & LA_MASK;
 
 	offset = 0;
@@ -703,7 +738,7 @@
 		status = -ENXIO;
 		if (!irqnum) {
 			printk(" and failed to detect IRQ line.\n");
-			goto out_region;
+			goto out_priv;
 		} else {
 			for (dev->irq = 0, i = 0; (depca_irq[i]) && (!dev->irq); i++)
 				if (irqnum == depca_irq[i]) {
@@ -714,7 +749,7 @@
 			status = -ENXIO;
 			if (!dev->irq) {
 				printk(" but incorrect IRQ line detected.\n");
-				goto out_region;
+				goto out_priv;
 			}
 		}
 #endif				/* MODULE */
@@ -739,13 +774,16 @@
 	dev->mem_start = 0;
 
 	/* Fill in the generic field of the device structure. */
-	ether_setup(dev);
+	if (!is_eisa)
+		ether_setup(dev);
 	return 0;
-      out_region:
-	release_region(ioaddr, DEPCA_TOTAL_SIZE);
       out_priv:
-	kfree(dev->priv);
-	dev->priv = NULL;
+	if (!is_eisa) {
+		kfree(dev->priv);
+		dev->priv = NULL;
+	} else {
+		unregister_netdev (dev);
+	}
 	return status;
 }
 
@@ -1350,31 +1388,35 @@
 			   ** Get everything allocated and initialized...  (almost just
 			   ** like the ISA and EISA probes)
 			 */
+			if (!request_region (ioase, DEPCA_TOTAL_SIZE, "depca")) {
+				if (autoprobed)
+					printk(KERN_WARNING "%s: region already allocated at 0x%04lx.\n", dev->name, iobase);
+				goto next;
+			}
 			if (DevicePresent(iobase) != 0) {
 				/*
 				   ** If the MCA configuration says the card should be here,
 				   ** it really should be here.
 				 */
 				printk(KERN_ERR "%s: MCA reports card at 0x%lx but it is not responding.\n", dev->name, iobase);
+				goto release_next;
 			}
 
-			if (check_region(iobase, DEPCA_TOTAL_SIZE) == 0) {
-				if ((dev = alloc_device(dev, iobase)) != NULL) {
-					dev->irq = irq;
-					if (depca_hw_init(dev, iobase, slot) == 0) {
-						/*
-						   ** Adapter initialized correctly:  Name it in
-						   ** /proc/mca.
-						 */
-						mca_set_adapter_name(slot, "DE210/212 Ethernet Adapter");
-						mca_mark_as_used(slot);
-						num_depcas++;
-					}
-					num_eth++;
-				}
-			} else if (autoprobed) {
-				printk(KERN_WARNING "%s: region already allocated at 0x%04lx.\n", dev->name, iobase);
-			}
+			if (!(dev = alloc_device(dev, iobase)))
+				goto release_next;
+
+			num_eth++;
+			dev->irq = irq;
+			if (depca_hw_init(dev, iobase, slot))
+				goto release_next;
+			
+			/*
+			** Adapter initialized correctly:  Name it in
+			** /proc/mca.
+			*/
+			mca_set_adapter_name(slot, "DE210/212 Ethernet Adapter");
+			mca_mark_as_used(slot);
+			num_depcas++;
 
 			/*
 			   ** If this is a probe by a module, return after setting up the
@@ -1384,9 +1426,15 @@
 				return;
 
 			/*
-			   ** Set up to check the next slot and loop.
+			** Set up to check the next slot and loop.
 			 */
 			slot++;
+			continue;
+
+	release_next:
+			release_region (iobase, DEPCA_TOTAL_SIZE);
+	next:
+			slot++;
 		}
 	}
 
@@ -1417,69 +1465,100 @@
 	}
 
 	for (; (i < maxSlots) && (dev != NULL) && ports[i]; i++) {
-		if (check_region(ports[i], DEPCA_TOTAL_SIZE) == 0) {
-			if (DevicePresent(ports[i]) == 0) {
-				if ((dev = alloc_device(dev, ports[i])) != NULL) {
-					if (depca_hw_init(dev, ports[i], -1) == 0) {
-						num_depcas++;
-					}
-					num_eth++;
-				}
-			}
-		} else if (autoprobed) {
-			printk("%s: region already allocated at 0x%04x.\n", dev->name, ports[i]);
+		if (!request_region (ports[i], DEPCA_TOTAL_SIZE, "depca")) {
+			if (autoprobed)
+				printk("%s: region already allocated at 0x%04x.\n", dev->name, ports[i]);
+			continue;
 		}
+
+		if (DevicePresent(ports[i])) {
+			release_region (ports[i], DEPCA_TOTAL_SIZE);
+			continue;
+		}
+
+		if (!(dev = alloc_device(dev, ports[i]))) {
+			release_region (ports[i], DEPCA_TOTAL_SIZE);
+			continue;
+		}
+
+		num_eth++;
+
+		if (depca_hw_init(dev, ports[i], -1)) {
+			release_region (ports[i], DEPCA_TOTAL_SIZE);
+			continue;
+		}
+
+		num_depcas++;
 	}
 
 	return;
 }
 
 /*
-** EISA bus I/O device probe. Probe from slot 1 since slot 0 is usually
-** the motherboard. Upto 15 EISA devices are supported.
+** EISA callbacks from sysfs.
 */
-static void __init eisa_probe(struct net_device *dev, u_long ioaddr)
+
+#ifdef CONFIG_EISA
+static int __init depca_eisa_probe (struct device *device)
 {
-	int i, maxSlots;
+	struct eisa_device *edev;
+	struct net_device *dev;
 	u_long iobase;
-	char name[DEPCA_STRLEN];
+	int status = 0;
 
-	if (!ioaddr && autoprobed)
-		return;		/* Been here before ! */
-	if ((ioaddr < 0x400) && (ioaddr > 0))
-		return;		/* ISA Address */
+	edev = to_eisa_device (device);
+	iobase = edev->base_addr + DEPCA_EISA_IO_PORTS;
 
-	if (ioaddr == 0) {	/* Autoprobing */
-		iobase = EISA_SLOT_INC;	/* Get the first slot address */
-		i = 1;
-		maxSlots = MAX_EISA_SLOTS;
-	} else {		/* Probe a specific location */
-		iobase = ioaddr;
-		i = (ioaddr >> 12);
-		maxSlots = i + 1;
+	if (!request_region (iobase, DEPCA_TOTAL_SIZE, "depca")) {
+		status = -EBUSY;
+		goto out;
+	}
+	
+	if (DevicePresent(iobase)) {
+		status = -ENODEV;
+		goto out_release;
 	}
-	if ((iobase & 0x0fff) == 0)
-		iobase += DEPCA_EISA_IO_PORTS;
 
-	for (; (i < maxSlots) && (dev != NULL); i++, iobase += EISA_SLOT_INC) {
-		if (check_region(iobase, DEPCA_TOTAL_SIZE) == 0) {
-			if (EISA_signature(name, EISA_ID)) {
-				if (DevicePresent(iobase) == 0) {
-					if ((dev = alloc_device(dev, iobase)) != NULL) {
-						if (depca_hw_init(dev, iobase, -1) == 0) {
-							num_depcas++;
-						}
-						num_eth++;
-					}
-				}
-			}
-		} else if (autoprobed) {
-			printk("%s: region already allocated at 0x%04lx.\n", dev->name, iobase);
-		}
+	if (!(dev = init_etherdev (NULL, sizeof (struct depca_private)))) {
+		status = -ENOMEM;
+		goto out_release;
 	}
+		
+	eisa_set_drvdata (edev, dev);
 
-	return;
+	if ((status = depca_hw_init(dev, iobase, -1)))
+		goto out_free;
+
+	num_depcas++;
+	return 0;
+
+ out_free:
+	kfree (dev);
+ out_release:
+	release_region (iobase, DEPCA_TOTAL_SIZE);
+ out:
+	return status;
+}
+
+static int __devexit depca_eisa_remove (struct device *device)
+{
+	struct net_device *dev;
+	struct eisa_device *edev;
+	struct depca_private *lp;
+
+	edev = to_eisa_device (device);
+	dev  = eisa_get_drvdata (edev);
+	lp   = dev->priv;
+
+	unregister_netdev (dev);
+	iounmap (lp->sh_mem);
+	release_mem_region (lp->mem_start, lp->mem_len);
+	release_region (dev->base_addr, DEPCA_TOTAL_SIZE);
+	kfree (dev);
+
+	return 0;
 }
+#endif
 
 /*
 ** Search the entire 'eth' device list for a fixed probe. If a match isn't
@@ -1780,40 +1859,6 @@
 	return status;
 }
 
-/*
-** Look for a particular board name in the EISA configuration space
-*/
-static int __init EISA_signature(char *name, s32 eisa_id)
-{
-	u_int i;
-	const char *signatures[] = DEPCA_SIGNATURE;
-	char ManCode[DEPCA_STRLEN];
-	union {
-		s32 ID;
-		char Id[4];
-	} Eisa;
-	int status = 0;
-
-	*name = '\0';
-	Eisa.ID = inl(eisa_id);
-
-	ManCode[0] = (((Eisa.Id[0] >> 2) & 0x1f) + 0x40);
-	ManCode[1] = (((Eisa.Id[1] & 0xe0) >> 5) + ((Eisa.Id[0] & 0x03) << 3) + 0x40);
-	ManCode[2] = (((Eisa.Id[2] >> 4) & 0x0f) + 0x30);
-	ManCode[3] = ((Eisa.Id[2] & 0x0f) + 0x30);
-	ManCode[4] = (((Eisa.Id[3] >> 4) & 0x0f) + 0x30);
-	ManCode[5] = '\0';
-
-	for (i = 0; (*signatures[i] != '\0') && (*name == '\0'); i++) {
-		if (strstr(ManCode, signatures[i]) != NULL) {
-			strcpy(name, ManCode);
-			status = 1;
-		}
-	}
-
-	return status;
-}
-
 static void depca_dbg_open(struct net_device *dev)
 {
 	struct depca_private *lp = (struct depca_private *) dev->priv;
@@ -2066,6 +2111,7 @@
 	unregister_netdev(&thisDepca);
 	if (lp) {
 		iounmap(lp->sh_mem);
+		release_mem_region (lp->mem_start, lp->mem_len);
 #ifdef CONFIG_MCA
 		if (lp->mca_slot != -1)
 			mca_mark_as_unused(lp->mca_slot);

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
