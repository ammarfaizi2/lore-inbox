Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWALTCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWALTCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWALTCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:02:12 -0500
Received: from mail.gmx.net ([213.165.64.21]:12507 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030349AbWALTCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:02:10 -0500
X-Authenticated: #6666257
Message-ID: <43C6A9C3.2060704@gmx.de>
Date: Thu, 12 Jan 2006 20:10:59 +0100
From: "M.Gehre" <M.Gehre@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [Patch] Replacing 0xff.. with correct DMA_xBIT_MASK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Gehre

Included is a patch to replace all occurences of 0xff..
in calls to function pci_set_dma_mask() with the corresponding
DMA_xBIT_MASK from linux/dma-mapping.h.
This patch was made against 2.6.15-rc4

Signed-off-by: Matthias Gehre <M.Gehre@gmx.de>

---
Task was found on janitor.kernelnewbies.org
Please CC answer to me.

diff -pruNX linux/Documentation/dontdiff linux-org/Documentation/DMA-mapping.txt linux-newest/Documentation/DMA-mapping.txt
--- linux-org/Documentation/DMA-mapping.txt	2005-11-24 23:10:21.000000000 +0100
+++ linux-newest/Documentation/DMA-mapping.txt	2005-12-13 01:58:49.000000000 +0100
@@ -199,6 +199,8 @@ address during PCI bus mastering you mig
 		       "mydev: 24-bit DMA addressing not available.\n");
 		goto ignore_this_device;
 	}
+[Better use DMA_24BIT_MASK instead of 0x00ffffff.
+See linux/include/dma-mapping.h for reference.]

 When pci_set_dma_mask() is successful, and returns zero, the PCI layer
 saves away this mask you have provided.  The PCI layer will use this
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/block/umem.c linux-newest/drivers/block/umem.c
--- linux-org/drivers/block/umem.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-newest/drivers/block/umem.c	2005-12-13 01:42:53.000000000 +0100
@@ -50,6 +50,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>

 #include <linux/fcntl.h>        /* O_ACCMODE */
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
@@ -892,8 +893,8 @@ static int __devinit mm_pci_probe(struct
 	printk(KERN_INFO "Micro Memory(tm) controller #%d found at %02x:%02x (PCI Mem Module (Battery Backup))\n",
 	       card->card_number, dev->bus->number, dev->devfn);

-	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
-	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
+	if (pci_set_dma_mask(dev, DMA_64BIT_MASK) &&
+	    !pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
 		return  -ENOMEM;
 	}
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/net/forcedeth.c linux-newest/drivers/net/forcedeth.c
--- linux-org/drivers/net/forcedeth.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/net/forcedeth.c	2005-12-13 01:25:01.000000000 +0100
@@ -129,6 +129,7 @@
 #include <linux/random.h>
 #include <linux/init.h>
 #include <linux/if_vlan.h>
+#include <linux/dma-mapping.h>

 #include <asm/irq.h>
 #include <asm/io.h>
@@ -2430,7 +2431,7 @@ static int __devinit nv_probe(struct pci
 	if (id->driver_data & DEV_HAS_HIGH_DMA) {
 		/* packet format 3: supports 40-bit addressing */
 		np->desc_ver = DESC_VER_3;
-		if (pci_set_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
+		if (pci_set_dma_mask(pci_dev, DMA_39BIT_MASK)) {
 			printk(KERN_INFO "forcedeth: 64-bit DMA failed, using 32-bit addressing for device %s.\n",
 					pci_name(pci_dev));
 		} else {
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/net/ioc3-eth.c linux-newest/drivers/net/ioc3-eth.c
--- linux-org/drivers/net/ioc3-eth.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/net/ioc3-eth.c	2005-12-13 01:19:26.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
+#include <linux/dma-mapping.h>

 #ifdef CONFIG_SERIAL_8250
 #include <linux/serial_core.h>
@@ -1195,7 +1196,7 @@ static int ioc3_probe(struct pci_dev *pd
 	int err, pci_using_dac;

 	/* Configure DMA attributes. */
-	err = pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
+	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (!err) {
 		pci_using_dac = 1;
 		err = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
@@ -1205,7 +1206,7 @@ static int ioc3_probe(struct pci_dev *pd
 			goto out;
 		}
 	} else {
-		err = pci_set_dma_mask(pdev, 0xffffffffULL);
+		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (err) {
 			printk(KERN_ERR "%s: No usable DMA configuration, "
 			       "aborting.\n", pci_name(pdev));
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/net/ns83820.c linux-newest/drivers/net/ns83820.c
--- linux-org/drivers/net/ns83820.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/net/ns83820.c	2005-12-13 01:22:13.000000000 +0100
@@ -1826,10 +1826,10 @@ static int __devinit ns83820_init_one(st
 	int using_dac = 0;

 	/* See if we can set the dma mask early on; failure is fatal. */
-	if (sizeof(dma_addr_t) == 8 &&
-	 	!pci_set_dma_mask(pci_dev, 0xffffffffffffffffULL)) {
+	if (sizeof(dma_addr_t) == 8 &&
+	 	!pci_set_dma_mask(pci_dev, DMA_64BIT_MASK)) {
 		using_dac = 1;
-	} else if (!pci_set_dma_mask(pci_dev, 0xffffffff)) {
+	} else if (!pci_set_dma_mask(pci_dev, DMA_32BIT_MASK)) {
 		using_dac = 0;
 	} else {
 		printk(KERN_WARNING "ns83820.c: pci_set_dma_mask failed!\n");
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/net/wan/wanxl.c linux-newest/drivers/net/wan/wanxl.c
--- linux-org/drivers/net/wan/wanxl.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-newest/drivers/net/wan/wanxl.c	2005-12-13 01:59:46.000000000 +0100
@@ -577,8 +577,8 @@ static int __devinit wanxl_pci_init_one(
 	   We set both dma_mask and consistent_dma_mask to 28 bits
 	   and pray pci_alloc_consistent() will use this info. It should
 	   work on most platforms */
-	if (pci_set_consistent_dma_mask(pdev, 0x0FFFFFFF) ||
-	    pci_set_dma_mask(pdev, 0x0FFFFFFF)) {
+	if (pci_set_consistent_dma_mask(pdev, DMA_28BIT_MASK) ||
+	    pci_set_dma_mask(pdev, DMA_28BIT_MASK)) {
 		printk(KERN_ERR "wanXL: No usable DMA configuration\n");
 		return -EIO;
 	}
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/net/wireless/prism54/islpci_hotplug.c linux-newest/drivers/net/wireless/prism54/islpci_hotplug.c
--- linux-org/drivers/net/wireless/prism54/islpci_hotplug.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/net/wireless/prism54/islpci_hotplug.c	2005-12-13 01:23:09.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/init.h> /* For __init, __exit */
+#include <linux/dma-mapping.h>

 #include "prismcompat.h"
 #include "islpci_dev.h"
@@ -124,7 +125,7 @@ prism54_probe(struct pci_dev *pdev, cons
 	}

 	/* enable PCI DMA */
-	if (pci_set_dma_mask(pdev, 0xffffffff)) {
+	if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		printk(KERN_ERR "%s: 32-bit PCI DMA not supported", DRV_NAME);
 		goto do_pci_disable_device;
         }
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/a100u2w.c linux-newest/drivers/scsi/a100u2w.c
--- linux-org/drivers/scsi/a100u2w.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/a100u2w.c	2005-12-13 01:26:58.000000000 +0100
@@ -89,6 +89,7 @@
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>

 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1052,7 +1053,7 @@ static int __devinit inia100_probe_one(s

 	if (pci_enable_device(pdev))
 		goto out;
-	if (pci_set_dma_mask(pdev, 0xffffffffULL)) {
+	if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "Unable to set 32bit DMA "
 				    "on inia100 adapter, ignoring.\n");
 		goto out_disable_device;
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/aacraid/linit.c linux-newest/drivers/scsi/aacraid/linit.c
--- linux-org/drivers/scsi/aacraid/linit.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/aacraid/linit.c	2005-12-13 01:36:07.000000000 +0100
@@ -49,6 +49,7 @@
 #include <linux/ioctl32.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
+#include <linux/dma-mapping.h>
 #include <asm/semaphore.h>

 #include <scsi/scsi.h>
@@ -762,7 +763,7 @@ static int __devinit aac_probe_one(struc
 	 * to driver communication memory to be allocated below 2gig
 	 */
 	if (aac_drivers[index].quirks & AAC_QUIRK_31BIT)
-		if (pci_set_dma_mask(pdev, 0x7FFFFFFFULL) ||
+		if (pci_set_dma_mask(pdev, DMA_31BIT_MASK) ||
 				pci_set_consistent_dma_mask(pdev, 0x7FFFFFFFULL))
 			goto out;
 	
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/atp870u.c linux-newest/drivers/scsi/atp870u.c
--- linux-org/drivers/scsi/atp870u.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/atp870u.c	2005-12-13 01:37:54.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/blkdev.h>
+#include <linux/dma-mapping.h>
 #include <asm/system.h>
 #include <asm/io.h>

@@ -2631,7 +2632,7 @@ static int atp870u_probe(struct pci_dev
 	if (pci_enable_device(pdev))
 		return -EIO;

-        if (!pci_set_dma_mask(pdev, 0xFFFFFFFFUL)) {
+        if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
                 printk(KERN_INFO "atp870u: use 32bit DMA mask.\n");
         } else {
                 printk(KERN_ERR "atp870u: DMA mask required but not available.\n");
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/BusLogic.c linux-newest/drivers/scsi/BusLogic.c
--- linux-org/drivers/scsi/BusLogic.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-newest/drivers/scsi/BusLogic.c	2005-12-13 01:41:56.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/stat.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
+#include <linux/dma-mapping.h>
 #include <scsi/scsicam.h>

 #include <asm/dma.h>
@@ -676,7 +677,7 @@ static int __init BusLogic_InitializeMul
 		if (pci_enable_device(PCI_Device))
 			continue;

-		if (pci_set_dma_mask(PCI_Device, (u64) 0xffffffff))
+		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK ))
 			continue;

 		Bus = PCI_Device->bus->number;
@@ -831,7 +832,7 @@ static int __init BusLogic_InitializeMul
 		if (pci_enable_device(PCI_Device))
 			continue;

-		if (pci_set_dma_mask(PCI_Device, (u64) 0xffffffff))
+		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK))
 			continue;

 		Bus = PCI_Device->bus->number;
@@ -885,7 +886,7 @@ static int __init BusLogic_InitializeFla
 		if (pci_enable_device(PCI_Device))
 			continue;

-		if (pci_set_dma_mask(PCI_Device, (u64) 0xffffffff))
+		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK))
 			continue;

 		Bus = PCI_Device->bus->number;
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/dpt_i2o.c linux-newest/drivers/scsi/dpt_i2o.c
--- linux-org/drivers/scsi/dpt_i2o.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/dpt_i2o.c	2005-12-13 01:30:32.000000000 +0100
@@ -57,6 +57,7 @@ MODULE_DESCRIPTION("Adaptec I2O RAID Dri
 #include <linux/reboot.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
+#include <linux/dma-mapping.h>

 #include <linux/timer.h>
 #include <linux/string.h>
@@ -884,8 +885,8 @@ static int adpt_install_hba(struct scsi_
 		return -EINVAL;
 	}
 	pci_set_master(pDev);
-	if (pci_set_dma_mask(pDev, 0xffffffffffffffffULL) &&
-	    pci_set_dma_mask(pDev, 0xffffffffULL))
+	if (pci_set_dma_mask(pDev, DMA_64BIT_MASK) &&
+	    pci_set_dma_mask(pDev, DMA_32BIT_MASK))
 		return -EINVAL;

 	base_addr0_phys = pci_resource_start(pDev,0);
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/eata.c linux-newest/drivers/scsi/eata.c
--- linux-org/drivers/scsi/eata.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/eata.c	2005-12-13 01:33:16.000000000 +0100
@@ -490,6 +490,7 @@
 #include <linux/init.h>
 #include <linux/ctype.h>
 #include <linux/spinlock.h>
+#include <linux/dma-mapping.h>
 #include <asm/byteorder.h>
 #include <asm/dma.h>
 #include <asm/io.h>
@@ -1426,7 +1427,7 @@ static int port_detect(unsigned long por

 	if (ha->pdev) {
 		pci_set_master(ha->pdev);
-		if (pci_set_dma_mask(ha->pdev, 0xffffffff))
+		if (pci_set_dma_mask(ha->pdev, DMA_32BIT_MASK))
 			printk("%s: warning, pci_set_dma_mask failed.\n",
 			       ha->board_name);
 	}
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/gdth.c linux-newest/drivers/scsi/gdth.c
--- linux-org/drivers/scsi/gdth.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/gdth.c	2005-12-13 01:34:45.000000000 +0100
@@ -388,6 +388,7 @@
 #include <linux/proc_fs.h>
 #include <linux/time.h>
 #include <linux/timer.h>
+#include <linux/dma-mapping.h>
 #ifdef GDTH_RTC
 #include <linux/mc146818rtc.h>
 #endif
@@ -4527,15 +4528,15 @@ static int __init gdth_detect(struct scs
             if (!(ha->cache_feat & ha->raw_feat & ha->screen_feat &GDT_64BIT)||
                 /* 64-bit DMA only supported from FW >= x.43 */
                 (!ha->dma64_support)) {
-                if (pci_set_dma_mask(pcistr[ctr].pdev, 0xffffffff)) {
+                if (pci_set_dma_mask(pcistr[ctr].pdev, DMA_32BIT_MASK)) {
                     printk(KERN_WARNING "GDT-PCI %d: Unable to set 32-bit DMA\n", hanum);
                     err = TRUE;
                 }
             } else {
                 shp->max_cmd_len = 16;
-                if (!pci_set_dma_mask(pcistr[ctr].pdev, 0xffffffffffffffffULL)) {
+                if (!pci_set_dma_mask(pcistr[ctr].pdev, DMA_64BIT_MASK)) {
                     printk("GDT-PCI %d: 64-bit DMA enabled\n", hanum);
-                } else if (pci_set_dma_mask(pcistr[ctr].pdev, 0xffffffff)) {
+                } else if (pci_set_dma_mask(pcistr[ctr].pdev, DMA_32BIT_MASK)) {
                     printk(KERN_WARNING "GDT-PCI %d: Unable to set 64/32-bit DMA\n", hanum);
                     err = TRUE;
                 }
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/initio.c linux-newest/drivers/scsi/initio.c
--- linux-org/drivers/scsi/initio.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-newest/drivers/scsi/initio.c	2005-12-13 01:40:32.000000000 +0100
@@ -127,6 +127,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>

 #include <scsi/scsi.h>
@@ -2780,7 +2781,7 @@ static int tul_NewReturnNumberOfAdapters
 			if (((dRegValue & 0xFF00) >> 8) == 0xFF)
 				dRegValue = 0;
 			wBIOS = (wBIOS << 8) + ((UWORD) ((dRegValue & 0xFF00) >> 8));
-			if (pci_set_dma_mask(pDev, 0xffffffff)) {
+			if (pci_set_dma_mask(pDev, DMA_32BIT_MASK)) {
 				printk(KERN_WARNING
 				       "i91u: Could not set 32 bit DMA mask\n");
 				continue;
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/ips.c linux-newest/drivers/scsi/ips.c
--- linux-org/drivers/scsi/ips.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/ips.c	2005-12-13 01:28:56.000000000 +0100
@@ -179,6 +179,7 @@

 #include <linux/blkdev.h>
 #include <linux/types.h>
+#include <linux/dma-mapping.h>

 #include <scsi/sg.h>

@@ -7279,10 +7280,10 @@ ips_init_phase1(struct pci_dev *pci_dev,
 	 * are guaranteed to be < 4G.
 	 */
 	if (IPS_ENABLE_DMA64 && IPS_HAS_ENH_SGLIST(ha) &&
-	    !pci_set_dma_mask(ha->pcidev, 0xffffffffffffffffULL)) {
+	    !pci_set_dma_mask(ha->pcidev, DMA_64BIT_MASK)) {
 		(ha)->flags |= IPS_HA_ENH_SG;
 	} else {
-		if (pci_set_dma_mask(ha->pcidev, 0xffffffffULL) != 0) {
+		if (pci_set_dma_mask(ha->pcidev, DMA_32BIT_MASK) != 0) {
 			printk(KERN_WARNING "Unable to set DMA Mask\n");
 			return ips_abort_init(ha, index);
 		}
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/megaraid.c linux-newest/drivers/scsi/megaraid.c
--- linux-org/drivers/scsi/megaraid.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/megaraid.c	2005-12-13 01:32:16.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/dma-mapping.h>
 #include <scsi/scsicam.h>

 #include "scsi.h"
@@ -2093,7 +2094,7 @@ make_local_pdev(adapter_t *adapter, stru

 	memcpy(*pdev, adapter->dev, sizeof(struct pci_dev));

-	if( pci_set_dma_mask(*pdev, 0xffffffff) != 0 ) {
+	if( pci_set_dma_mask(*pdev, DMA_32BIT_MASK) != 0 ) {
 		kfree(*pdev);
 		return -1;
 	}
@@ -4858,10 +4859,10 @@ megaraid_probe_one(struct pci_dev *pdev,

 	/* Set the Mode of addressing to 64 bit if we can */
 	if ((adapter->flag & BOARD_64BIT) && (sizeof(dma_addr_t) == 8)) {
-		pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
+		pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 		adapter->has_64bit_addr = 1;
 	} else  {
-		pci_set_dma_mask(pdev, 0xffffffff);
+		pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		adapter->has_64bit_addr = 0;
 	}
 		
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/nsp32.c linux-newest/drivers/scsi/nsp32.c
--- linux-org/drivers/scsi/nsp32.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/nsp32.c	2005-12-13 01:37:06.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/ctype.h>
+#include <linux/dma-mapping.h>

 #include <asm/dma.h>
 #include <asm/system.h>
@@ -2776,7 +2777,7 @@ static int nsp32_detect(struct scsi_host
 	/*
 	 * setup DMA
 	 */
-	if (pci_set_dma_mask(PCIDEV, 0xffffffffUL) != 0) {
+	if (pci_set_dma_mask(PCIDEV, DMA_32BIT_MASK) != 0) {
 		nsp32_msg (KERN_ERR, "failed to set PCI DMA mask");
 		goto scsi_unregister;
 	}
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/qla1280.c linux-newest/drivers/scsi/qla1280.c
--- linux-org/drivers/scsi/qla1280.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/qla1280.c	2005-12-13 01:39:38.000000000 +0100
@@ -348,6 +348,7 @@
 #include <linux/pci_ids.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/dma-mapping.h>

 #include <asm/io.h>
 #include <asm/irq.h>
@@ -4569,7 +4570,7 @@ qla1280_probe_one(struct pci_dev *pdev,

 #ifdef QLA_64BIT_PTR
 	if (pci_set_dma_mask(ha->pdev, (dma_addr_t) ~ 0ULL)) {
-		if (pci_set_dma_mask(ha->pdev, 0xffffffff)) {
+		if (pci_set_dma_mask(ha->pdev, DMA_32BIT_MASK)) {
 			printk(KERN_WARNING "scsi(%li): Unable to set a "
 			       "suitable DMA mask - aborting\n", ha->host_no);
 			error = -ENODEV;
@@ -4579,7 +4580,7 @@ qla1280_probe_one(struct pci_dev *pdev,
 		dprintk(2, "scsi(%li): 64 Bit PCI Addressing Enabled\n",
 			ha->host_no);
 #else
-	if (pci_set_dma_mask(ha->pdev, 0xffffffff)) {
+	if (pci_set_dma_mask(ha->pdev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "scsi(%li): Unable to set a "
 		       "suitable DMA mask - aborting\n", ha->host_no);
 		error = -ENODEV;
diff -pruNX linux/Documentation/dontdiff linux-org/drivers/scsi/qlogicfc.c linux-newest/drivers/scsi/qlogicfc.c
--- linux-org/drivers/scsi/qlogicfc.c	2005-12-13 01:09:19.000000000 +0100
+++ linux-newest/drivers/scsi/qlogicfc.c	2005-12-13 01:26:04.000000000 +0100
@@ -61,6 +61,7 @@
 #include <linux/unistd.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include "scsi.h"
@@ -737,8 +738,8 @@ static int isp2x00_detect(struct scsi_ho
 				continue;

 			/* Try to configure DMA attributes. */
-			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) &&
-			    pci_set_dma_mask(pdev, 0xffffffffULL))
+			if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) &&
+			    pci_set_dma_mask(pdev, DMA_32BIT_MASK))
 					continue;

 		        host = scsi_register(tmpt, sizeof(struct isp2x00_hostdata));
diff -pruNX linux/Documentation/dontdiff linux-org/include/linux/dma-mapping.h linux-newest/include/linux/dma-mapping.h
--- linux-org/include/linux/dma-mapping.h	2005-11-24 23:10:21.000000000 +0100
+++ linux-newest/include/linux/dma-mapping.h	2005-12-13 01:49:28.000000000 +0100
@@ -20,6 +20,8 @@ enum dma_data_direction {
 #define DMA_31BIT_MASK	0x000000007fffffffULL
 #define DMA_30BIT_MASK	0x000000003fffffffULL
 #define DMA_29BIT_MASK	0x000000001fffffffULL
+#define DMA_28BIT_MASK 0x000000000fffffffULL
+#define DMA_24BIT_MASK 0x0000000000ffffffULL

 #include <asm/dma-mapping.h>

diff -pruNX linux/Documentation/dontdiff linux-org/sound/oss/esssolo1.c linux-newest/sound/oss/esssolo1.c
--- linux-org/sound/oss/esssolo1.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-newest/sound/oss/esssolo1.c	2005-12-13 02:03:28.000000000 +0100
@@ -2346,7 +2346,7 @@ static int __devinit solo1_probe(struct
 	/* Recording requires 24-bit DMA, so attempt to set dma mask
 	 * to 24 bits first, then 32 bits (playback only) if that fails.
 	 */
-	if (pci_set_dma_mask(pcidev, 0x00ffffff) &&
+	if (pci_set_dma_mask(pcidev, DMA_24BIT_MASK) &&
 	    pci_set_dma_mask(pcidev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "solo1: architecture does not support 24bit or 32bit PCI busmaster DMA\n");
 		return -ENODEV;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/oss/sonicvibes.c linux-newest/sound/oss/sonicvibes.c
--- linux-org/sound/oss/sonicvibes.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-newest/sound/oss/sonicvibes.c	2005-12-13 02:04:14.000000000 +0100
@@ -116,6 +116,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/gameport.h>
+#include <linux/dma-mapping.h>

 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -2551,7 +2552,7 @@ static int __devinit sv_probe(struct pci
 		return -ENODEV;
 	if (pcidev->irq == 0)
 		return -ENODEV;
-	if (pci_set_dma_mask(pcidev, 0x00ffffff)) {
+	if (pci_set_dma_mask(pcidev, DMA_24BIT_MASK)) {
 		printk(KERN_WARNING "sonicvibes: architecture does not support 24bit PCI busmaster DMA\n");
 		return -ENODEV;
 	}
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/ad1889.c linux-newest/sound/pci/ad1889.c
--- linux-org/sound/pci/ad1889.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/ad1889.c	2005-12-13 02:02:07.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>

 #include <sound/driver.h>
 #include <sound/core.h>
@@ -920,8 +921,8 @@ snd_ad1889_create(snd_card_t *card,
 		return err;
 	
 	/* check PCI availability (32bit DMA) */
-	if (pci_set_dma_mask(pci, 0xffffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0xffffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		printk(KERN_ERR PFX "error setting 32-bit DMA mask.\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/ali5451/ali5451.c linux-newest/sound/pci/ali5451/ali5451.c
--- linux-org/sound/pci/ali5451/ali5451.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/ali5451/ali5451.c	2005-12-13 01:55:14.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -2237,8 +2238,8 @@ static int __devinit snd_ali_create(snd_
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 31 bits */
-	if (pci_set_dma_mask(pci, 0x7fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x7fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_31BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_31BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 31bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/als4000.c linux-newest/sound/pci/als4000.c
--- linux-org/sound/pci/als4000.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/als4000.c	2005-12-13 01:46:35.000000000 +0100
@@ -65,6 +65,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/rawmidi.h>
@@ -665,8 +666,8 @@ static int __devinit snd_card_als4000_pr
 		return err;
 	}
 	/* check, if we can restrict PCI DMA transfers to 24 bits */
-	if (pci_set_dma_mask(pci, 0x00ffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x00ffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_24BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_24BITMASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 24bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/azt3328.c linux-newest/sound/pci/azt3328.c
--- linux-org/sound/pci/azt3328.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/azt3328.c	2005-12-13 02:02:54.000000000 +0100
@@ -104,6 +104,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -1672,8 +1673,8 @@ snd_azf3328_create(snd_card_t * card,
 	chip->irq = -1;

 	/* check if we can restrict PCI DMA transfers to 24 bits */
-	if (pci_set_dma_mask(pci, 0x00ffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x00ffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_24BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_24BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 24bit PCI busmaster DMA\n");
 		err = -ENXIO;
 		goto out_err;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/emu10k1/emu10k1x.c linux-newest/sound/pci/emu10k1/emu10k1x.c
--- linux-org/sound/pci/emu10k1/emu10k1x.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/emu10k1/emu10k1x.c	2005-12-13 01:49:07.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -911,8 +912,8 @@ static int __devinit snd_emu10k1x_create

 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "error to set 28bit mask DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/es1938.c linux-newest/sound/pci/es1938.c
--- linux-org/sound/pci/es1938.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/es1938.c	2005-12-13 01:50:36.000000000 +0100
@@ -55,6 +55,7 @@
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -1499,8 +1500,8 @@ static int __devinit snd_es1938_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
         /* check, if we can restrict PCI DMA transfers to 24 bits */
-	if (pci_set_dma_mask(pci, 0x00ffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x00ffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_24BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_24BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 24bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
                 return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/es1968.c linux-newest/sound/pci/es1968.c
--- linux-org/sound/pci/es1968.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/es1968.c	2005-12-13 01:51:27.000000000 +0100
@@ -103,6 +103,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/mpu401.h>
@@ -2560,8 +2561,8 @@ static int __devinit snd_es1968_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/ice1712/ice1712.c linux-newest/sound/pci/ice1712/ice1712.c
--- linux-org/sound/pci/ice1712/ice1712.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/ice1712/ice1712.c	2005-12-13 02:01:04.000000000 +0100
@@ -55,6 +55,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/cs8427.h>
 #include <sound/info.h>
@@ -2522,8 +2523,8 @@ static int __devinit snd_ice1712_create(
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/maestro3.c linux-newest/sound/pci/maestro3.c
--- linux-org/sound/pci/maestro3.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/maestro3.c	2005-12-13 01:54:10.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -2651,8 +2652,8 @@ snd_m3_create(snd_card_t *card, struct p
 		return -EIO;

 	/* check, if we can restrict PCI DMA transfers to 28 bits */
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/mixart/mixart.c linux-newest/sound/pci/mixart/mixart.c
--- linux-org/sound/pci/mixart/mixart.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/mixart/mixart.c	2005-12-13 01:53:22.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
@@ -1283,7 +1284,7 @@ static int __devinit snd_mixart_probe(st
 	pci_set_master(pci);

 	/* check if we can restrict PCI DMA transfers to 32 bits */
-	if (pci_set_dma_mask(pci, 0xffffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 32bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/sonicvibes.c linux-newest/sound/pci/sonicvibes.c
--- linux-org/sound/pci/sonicvibes.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/sonicvibes.c	2005-12-13 01:56:03.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>

 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1237,8 +1238,8 @@ static int __devinit snd_sonicvibes_crea
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 24 bits */
-        if (pci_set_dma_mask(pci, 0x00ffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x00ffffff) < 0) {
+        if (pci_set_dma_mask(pci, DMA_24BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_24BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 24bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
                 return -ENXIO;
diff -pruNX linux/Documentation/dontdiff linux-org/sound/pci/trident/trident_main.c linux-newest/sound/pci/trident/trident_main.c
--- linux-org/sound/pci/trident/trident_main.c	2005-12-13 01:09:24.000000000 +0100
+++ linux-newest/sound/pci/trident/trident_main.c	2005-12-13 01:52:49.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/gameport.h>
+#include <linux/dma-mapping.h>

 #include <sound/core.h>
 #include <sound/info.h>
@@ -3539,8 +3540,8 @@ int __devinit snd_trident_create(snd_car
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 30 bits */
-	if (pci_set_dma_mask(pci, 0x3fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x3fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_30BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_30BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 30bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
@@ -3949,8 +3950,8 @@ static int snd_trident_resume(snd_card_t
 	trident_t *trident = card->pm_private_data;

 	pci_enable_device(trident->pci);
-	if (pci_set_dma_mask(trident->pci, 0x3fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(trident->pci, 0x3fffffff) < 0)
+	if (pci_set_dma_mask(trident->pci, DMA_30BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(trident->pci, DMA_30BIT_MASK) < 0)
 		snd_printk(KERN_WARNING "trident: can't set the proper DMA mask\n");
 	pci_set_master(trident->pci); /* to be sure */

