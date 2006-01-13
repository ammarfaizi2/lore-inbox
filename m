Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWAMSJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWAMSJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWAMSJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:09:20 -0500
Received: from mail.gmx.net ([213.165.64.21]:63962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422780AbWAMSJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:09:19 -0500
X-Authenticated: #6666257
Message-ID: <43C7EEF0.8070300@gmx.de>
Date: Fri, 13 Jan 2006 19:18:24 +0100
From: "M.Gehre" <M.Gehre@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [Patch v3] Replacing 0xff.. with correct DMA_xBIT_MASK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Gehre <M.Gehre@gmx.de>

Included is a patch to replace all occurences of 0xff..
in calls to function pci_set_dma_mask() and pci_set_consistant_dma_mask()
with the corresponding DMA_xBIT_MASK from linux/dma-mapping.h.
This patch was made against 2.6.15-git9.

Signed-off-by: Matthias Gehre <M.Gehre@gmx.de>

---
Task was found on janitor.kernelnewbies.org
This is a new version of an early submitted patch.
The last version was made against 2.6.14.3 by accident.
Sorry for that! Triple checked now.
Please CC answer to me.

diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/Documentation/DMA-mapping.txt linux-2.6.15-git9_patched/Documentation/DMA-mapping.txt
--- linux-2.6.15-git9/Documentation/DMA-mapping.txt	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.15-git9_patched/Documentation/DMA-mapping.txt	2006-01-13 18:24:36.000000000 +0100
@@ -199,6 +199,8 @@
 		       "mydev: 24-bit DMA addressing not available.\n");
 		goto ignore_this_device;
 	}
+[Better use DMA_24BIT_MASK instead of 0x00ffffff.
+See linux/include/dma-mapping.h for reference.]

 When pci_set_dma_mask() is successful, and returns zero, the PCI layer
 saves away this mask you have provided.  The PCI layer will use this
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/atm/lanai.c linux-2.6.15-git9_patched/drivers/atm/lanai.c
--- linux-2.6.15-git9/drivers/atm/lanai.c	2006-01-13 18:21:22.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/atm/lanai.c	2006-01-13 18:24:36.000000000 +0100
@@ -1972,7 +1972,7 @@
 		    "(itf %d): No suitable DMA available.\n", lanai->number);
 		return -EBUSY;
 	}
-	if (pci_set_consistent_dma_mask(pci, 0xFFFFFFFF) != 0) {
+	if (pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK) != 0) {
 		printk(KERN_WARNING DEV_LABEL
 		    "(itf %d): No suitable DMA available.\n", lanai->number);
 		return -EBUSY;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/block/umem.c linux-2.6.15-git9_patched/drivers/block/umem.c
--- linux-2.6.15-git9/drivers/block/umem.c	2006-01-13 18:21:40.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/block/umem.c	2006-01-13 18:24:36.000000000 +0100
@@ -50,6 +50,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>

 #include <linux/fcntl.h>        /* O_ACCMODE */
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
@@ -881,8 +882,8 @@
 	printk(KERN_INFO "Micro Memory(tm) controller #%d found at %02x:%02x (PCI Mem Module (Battery Backup))\n",
 	       card->card_number, dev->bus->number, dev->devfn);

-	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
-	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
+	if (pci_set_dma_mask(dev, DMA_64BIT_MASK) &&
+	    !pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
 		return  -ENOMEM;
 	}
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/forcedeth.c linux-2.6.15-git9_patched/drivers/net/forcedeth.c
--- linux-2.6.15-git9/drivers/net/forcedeth.c	2006-01-13 18:21:40.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/net/forcedeth.c	2006-01-13 18:24:36.000000000 +0100
@@ -131,6 +131,7 @@
 #include <linux/random.h>
 #include <linux/init.h>
 #include <linux/if_vlan.h>
+#include <linux/dma-mapping.h>

 #include <asm/irq.h>
 #include <asm/io.h>
@@ -2467,7 +2468,7 @@
 	if (id->driver_data & DEV_HAS_HIGH_DMA) {
 		/* packet format 3: supports 40-bit addressing */
 		np->desc_ver = DESC_VER_3;
-		if (pci_set_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
+		if (pci_set_dma_mask(pci_dev, DMA_39BIT_MASK)) {
 			printk(KERN_INFO "forcedeth: 64-bit DMA failed, using 32-bit addressing for device %s.\n",
 					pci_name(pci_dev));
 		} else {
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/ioc3-eth.c linux-2.6.15-git9_patched/drivers/net/ioc3-eth.c
--- linux-2.6.15-git9/drivers/net/ioc3-eth.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/net/ioc3-eth.c	2006-01-13 18:24:36.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
+#include <linux/dma-mapping.h>

 #ifdef CONFIG_SERIAL_8250
 #include <linux/serial_core.h>
@@ -1195,17 +1196,17 @@
 	int err, pci_using_dac;

 	/* Configure DMA attributes. */
-	err = pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
+	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (!err) {
 		pci_using_dac = 1;
-		err = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+		err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (err < 0) {
 			printk(KERN_ERR "%s: Unable to obtain 64 bit DMA "
 			       "for consistent allocations\n", pci_name(pdev));
 			goto out;
 		}
 	} else {
-		err = pci_set_dma_mask(pdev, 0xffffffffULL);
+		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (err) {
 			printk(KERN_ERR "%s: No usable DMA configuration, "
 			       "aborting.\n", pci_name(pdev));
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/ns83820.c linux-2.6.15-git9_patched/drivers/net/ns83820.c
--- linux-2.6.15-git9/drivers/net/ns83820.c	2006-01-13 18:21:40.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/net/ns83820.c	2006-01-13 18:24:36.000000000 +0100
@@ -1827,10 +1827,10 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/wan/wanxl.c linux-2.6.15-git9_patched/drivers/net/wan/wanxl.c
--- linux-2.6.15-git9/drivers/net/wan/wanxl.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/net/wan/wanxl.c	2006-01-13 18:24:39.000000000 +0100
@@ -577,8 +577,8 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/wireless/prism54/islpci_hotplug.c linux-2.6.15-git9_patched/drivers/net/wireless/prism54/islpci_hotplug.c
--- linux-2.6.15-git9/drivers/net/wireless/prism54/islpci_hotplug.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/net/wireless/prism54/islpci_hotplug.c	2006-01-13 18:24:39.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/init.h> /* For __init, __exit */
+#include <linux/dma-mapping.h>

 #include "prismcompat.h"
 #include "islpci_dev.h"
@@ -124,7 +125,7 @@
 	}

 	/* enable PCI DMA */
-	if (pci_set_dma_mask(pdev, 0xffffffff)) {
+	if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		printk(KERN_ERR "%s: 32-bit PCI DMA not supported", DRV_NAME);
 		goto do_pci_disable_device;
         }
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/a100u2w.c linux-2.6.15-git9_patched/drivers/scsi/a100u2w.c
--- linux-2.6.15-git9/drivers/scsi/a100u2w.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/a100u2w.c	2006-01-13 18:24:39.000000000 +0100
@@ -89,6 +89,7 @@
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>

 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1052,7 +1053,7 @@

 	if (pci_enable_device(pdev))
 		goto out;
-	if (pci_set_dma_mask(pdev, 0xffffffffULL)) {
+	if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "Unable to set 32bit DMA "
 				    "on inia100 adapter, ignoring.\n");
 		goto out_disable_device;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/aacraid/aachba.c linux-2.6.15-git9_patched/drivers/scsi/aacraid/aachba.c
--- linux-2.6.15-git9/drivers/scsi/aacraid/aachba.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/aacraid/aachba.c	2006-01-13 18:24:39.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/blkdev.h>
+#include <linux/dma-mapping.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>

diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/aacraid/linit.c linux-2.6.15-git9_patched/drivers/scsi/aacraid/linit.c
--- linux-2.6.15-git9/drivers/scsi/aacraid/linit.c	2006-01-13 18:21:41.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/aacraid/linit.c	2006-01-13 18:31:49.000000000 +0100
@@ -48,6 +48,7 @@
 #include <linux/syscalls.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
+#include <linux/dma-mapping.h>
 #include <asm/semaphore.h>

 #include <scsi/scsi.h>
@@ -761,8 +762,8 @@
 	 * to driver communication memory to be allocated below 2gig
 	 */
 	if (aac_drivers[index].quirks & AAC_QUIRK_31BIT)
-		if (pci_set_dma_mask(pdev, 0x7FFFFFFFULL) ||
-				pci_set_consistent_dma_mask(pdev, 0x7FFFFFFFULL))
+		if (pci_set_dma_mask(pdev, DMA_31BIT_MASK) ||
+				pci_set_consistent_dma_mask(pdev, DMA_31BIT_MASK))
 			goto out;
 	
 	pci_set_master(pdev);
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/atp870u.c linux-2.6.15-git9_patched/drivers/scsi/atp870u.c
--- linux-2.6.15-git9/drivers/scsi/atp870u.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/atp870u.c	2006-01-13 18:24:40.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/blkdev.h>
+#include <linux/dma-mapping.h>
 #include <asm/system.h>
 #include <asm/io.h>

@@ -2631,7 +2632,7 @@
 	if (pci_enable_device(pdev))
 		return -EIO;

-        if (!pci_set_dma_mask(pdev, 0xFFFFFFFFUL)) {
+        if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
                 printk(KERN_INFO "atp870u: use 32bit DMA mask.\n");
         } else {
                 printk(KERN_ERR "atp870u: DMA mask required but not available.\n");
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/BusLogic.c linux-2.6.15-git9_patched/drivers/scsi/BusLogic.c
--- linux-2.6.15-git9/drivers/scsi/BusLogic.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/BusLogic.c	2006-01-13 18:24:40.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/stat.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
+#include <linux/dma-mapping.h>
 #include <scsi/scsicam.h>

 #include <asm/dma.h>
@@ -676,7 +677,7 @@
 		if (pci_enable_device(PCI_Device))
 			continue;

-		if (pci_set_dma_mask(PCI_Device, (u64) 0xffffffff))
+		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK ))
 			continue;

 		Bus = PCI_Device->bus->number;
@@ -831,7 +832,7 @@
 		if (pci_enable_device(PCI_Device))
 			continue;

-		if (pci_set_dma_mask(PCI_Device, (u64) 0xffffffff))
+		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK))
 			continue;

 		Bus = PCI_Device->bus->number;
@@ -885,7 +886,7 @@
 		if (pci_enable_device(PCI_Device))
 			continue;

-		if (pci_set_dma_mask(PCI_Device, (u64) 0xffffffff))
+		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK))
 			continue;

 		Bus = PCI_Device->bus->number;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/dpt_i2o.c linux-2.6.15-git9_patched/drivers/scsi/dpt_i2o.c
--- linux-2.6.15-git9/drivers/scsi/dpt_i2o.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/dpt_i2o.c	2006-01-13 18:24:40.000000000 +0100
@@ -57,6 +57,7 @@
 #include <linux/reboot.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
+#include <linux/dma-mapping.h>

 #include <linux/timer.h>
 #include <linux/string.h>
@@ -899,8 +900,8 @@
 		return -EINVAL;
 	}
 	pci_set_master(pDev);
-	if (pci_set_dma_mask(pDev, 0xffffffffffffffffULL) &&
-	    pci_set_dma_mask(pDev, 0xffffffffULL))
+	if (pci_set_dma_mask(pDev, DMA_64BIT_MASK) &&
+	    pci_set_dma_mask(pDev, DMA_32BIT_MASK))
 		return -EINVAL;

 	base_addr0_phys = pci_resource_start(pDev,0);
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/eata.c linux-2.6.15-git9_patched/drivers/scsi/eata.c
--- linux-2.6.15-git9/drivers/scsi/eata.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/eata.c	2006-01-13 18:24:40.000000000 +0100
@@ -490,6 +490,7 @@
 #include <linux/init.h>
 #include <linux/ctype.h>
 #include <linux/spinlock.h>
+#include <linux/dma-mapping.h>
 #include <asm/byteorder.h>
 #include <asm/dma.h>
 #include <asm/io.h>
@@ -1426,7 +1427,7 @@

 	if (ha->pdev) {
 		pci_set_master(ha->pdev);
-		if (pci_set_dma_mask(ha->pdev, 0xffffffff))
+		if (pci_set_dma_mask(ha->pdev, DMA_32BIT_MASK))
 			printk("%s: warning, pci_set_dma_mask failed.\n",
 			       ha->board_name);
 	}
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/gdth.c linux-2.6.15-git9_patched/drivers/scsi/gdth.c
--- linux-2.6.15-git9/drivers/scsi/gdth.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/gdth.c	2006-01-13 18:24:40.000000000 +0100
@@ -388,6 +388,7 @@
 #include <linux/proc_fs.h>
 #include <linux/time.h>
 #include <linux/timer.h>
+#include <linux/dma-mapping.h>
 #ifdef GDTH_RTC
 #include <linux/mc146818rtc.h>
 #endif
@@ -4527,15 +4528,15 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/initio.c linux-2.6.15-git9_patched/drivers/scsi/initio.c
--- linux-2.6.15-git9/drivers/scsi/initio.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/initio.c	2006-01-13 18:24:40.000000000 +0100
@@ -127,6 +127,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>

 #include <scsi/scsi.h>
@@ -2780,7 +2781,7 @@
 			if (((dRegValue & 0xFF00) >> 8) == 0xFF)
 				dRegValue = 0;
 			wBIOS = (wBIOS << 8) + ((UWORD) ((dRegValue & 0xFF00) >> 8));
-			if (pci_set_dma_mask(pDev, 0xffffffff)) {
+			if (pci_set_dma_mask(pDev, DMA_32BIT_MASK)) {
 				printk(KERN_WARNING
 				       "i91u: Could not set 32 bit DMA mask\n");
 				continue;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/ips.c linux-2.6.15-git9_patched/drivers/scsi/ips.c
--- linux-2.6.15-git9/drivers/scsi/ips.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/ips.c	2006-01-13 18:24:40.000000000 +0100
@@ -179,6 +179,7 @@

 #include <linux/blkdev.h>
 #include <linux/types.h>
+#include <linux/dma-mapping.h>

 #include <scsi/sg.h>

@@ -7279,10 +7280,10 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/megaraid.c linux-2.6.15-git9_patched/drivers/scsi/megaraid.c
--- linux-2.6.15-git9/drivers/scsi/megaraid.c	2006-01-13 18:21:41.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/megaraid.c	2006-01-13 18:24:40.000000000 +0100
@@ -45,6 +45,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/dma-mapping.h>
 #include <scsi/scsicam.h>

 #include "scsi.h"
@@ -2094,7 +2095,7 @@

 	memcpy(*pdev, adapter->dev, sizeof(struct pci_dev));

-	if( pci_set_dma_mask(*pdev, 0xffffffff) != 0 ) {
+	if( pci_set_dma_mask(*pdev, DMA_32BIT_MASK) != 0 ) {
 		kfree(*pdev);
 		return -1;
 	}
@@ -4859,10 +4860,10 @@

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
 		
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/nsp32.c linux-2.6.15-git9_patched/drivers/scsi/nsp32.c
--- linux-2.6.15-git9/drivers/scsi/nsp32.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/nsp32.c	2006-01-13 18:24:40.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/ctype.h>
+#include <linux/dma-mapping.h>

 #include <asm/dma.h>
 #include <asm/system.h>
@@ -2776,7 +2777,7 @@
 	/*
 	 * setup DMA
 	 */
-	if (pci_set_dma_mask(PCIDEV, 0xffffffffUL) != 0) {
+	if (pci_set_dma_mask(PCIDEV, DMA_32BIT_MASK) != 0) {
 		nsp32_msg (KERN_ERR, "failed to set PCI DMA mask");
 		goto scsi_unregister;
 	}
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/qla1280.c linux-2.6.15-git9_patched/drivers/scsi/qla1280.c
--- linux-2.6.15-git9/drivers/scsi/qla1280.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/qla1280.c	2006-01-13 18:24:40.000000000 +0100
@@ -348,6 +348,7 @@
 #include <linux/pci_ids.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/dma-mapping.h>

 #include <asm/io.h>
 #include <asm/irq.h>
@@ -4569,7 +4570,7 @@

 #ifdef QLA_64BIT_PTR
 	if (pci_set_dma_mask(ha->pdev, (dma_addr_t) ~ 0ULL)) {
-		if (pci_set_dma_mask(ha->pdev, 0xffffffff)) {
+		if (pci_set_dma_mask(ha->pdev, DMA_32BIT_MASK)) {
 			printk(KERN_WARNING "scsi(%li): Unable to set a "
 			       "suitable DMA mask - aborting\n", ha->host_no);
 			error = -ENODEV;
@@ -4579,7 +4580,7 @@
 		dprintk(2, "scsi(%li): 64 Bit PCI Addressing Enabled\n",
 			ha->host_no);
 #else
-	if (pci_set_dma_mask(ha->pdev, 0xffffffff)) {
+	if (pci_set_dma_mask(ha->pdev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "scsi(%li): Unable to set a "
 		       "suitable DMA mask - aborting\n", ha->host_no);
 		error = -ENODEV;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/qlogicfc.c linux-2.6.15-git9_patched/drivers/scsi/qlogicfc.c
--- linux-2.6.15-git9/drivers/scsi/qlogicfc.c	2006-01-13 18:21:24.000000000 +0100
+++ linux-2.6.15-git9_patched/drivers/scsi/qlogicfc.c	2006-01-13 18:24:40.000000000 +0100
@@ -61,6 +61,7 @@
 #include <linux/unistd.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include "scsi.h"
@@ -737,8 +738,8 @@
 				continue;

 			/* Try to configure DMA attributes. */
-			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) &&
-			    pci_set_dma_mask(pdev, 0xffffffffULL))
+			if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) &&
+			    pci_set_dma_mask(pdev, DMA_32BIT_MASK))
 					continue;

 		        host = scsi_register(tmpt, sizeof(struct isp2x00_hostdata));
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/include/linux/dma-mapping.h linux-2.6.15-git9_patched/include/linux/dma-mapping.h
--- linux-2.6.15-git9/include/linux/dma-mapping.h	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.15-git9_patched/include/linux/dma-mapping.h	2006-01-13 18:24:40.000000000 +0100
@@ -20,6 +20,8 @@
 #define DMA_31BIT_MASK	0x000000007fffffffULL
 #define DMA_30BIT_MASK	0x000000003fffffffULL
 #define DMA_29BIT_MASK	0x000000001fffffffULL
+#define DMA_28BIT_MASK 0x000000000fffffffULL
+#define DMA_24BIT_MASK 0x0000000000ffffffULL

 #include <asm/dma-mapping.h>

diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/oss/esssolo1.c linux-2.6.15-git9_patched/sound/oss/esssolo1.c
--- linux-2.6.15-git9/sound/oss/esssolo1.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/oss/esssolo1.c	2006-01-13 18:24:40.000000000 +0100
@@ -2346,7 +2346,7 @@
 	/* Recording requires 24-bit DMA, so attempt to set dma mask
 	 * to 24 bits first, then 32 bits (playback only) if that fails.
 	 */
-	if (pci_set_dma_mask(pcidev, 0x00ffffff) &&
+	if (pci_set_dma_mask(pcidev, DMA_24BIT_MASK) &&
 	    pci_set_dma_mask(pcidev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "solo1: architecture does not support 24bit or 32bit PCI busmaster DMA\n");
 		return -ENODEV;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/oss/sonicvibes.c linux-2.6.15-git9_patched/sound/oss/sonicvibes.c
--- linux-2.6.15-git9/sound/oss/sonicvibes.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/oss/sonicvibes.c	2006-01-13 18:24:40.000000000 +0100
@@ -116,6 +116,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/gameport.h>
+#include <linux/dma-mapping.h>

 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -2551,7 +2552,7 @@
 		return -ENODEV;
 	if (pcidev->irq == 0)
 		return -ENODEV;
-	if (pci_set_dma_mask(pcidev, 0x00ffffff)) {
+	if (pci_set_dma_mask(pcidev, DMA_24BIT_MASK)) {
 		printk(KERN_WARNING "sonicvibes: architecture does not support 24bit PCI busmaster DMA\n");
 		return -ENODEV;
 	}
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/ad1889.c linux-2.6.15-git9_patched/sound/pci/ad1889.c
--- linux-2.6.15-git9/sound/pci/ad1889.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/ad1889.c	2006-01-13 18:24:40.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>

 #include <sound/driver.h>
 #include <sound/core.h>
@@ -911,8 +912,8 @@
 		return err;
 	
 	/* check PCI availability (32bit DMA) */
-	if (pci_set_dma_mask(pci, 0xffffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0xffffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		printk(KERN_ERR PFX "error setting 32-bit DMA mask.\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/ali5451/ali5451.c linux-2.6.15-git9_patched/sound/pci/ali5451/ali5451.c
--- linux-2.6.15-git9/sound/pci/ali5451/ali5451.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/ali5451/ali5451.c	2006-01-13 18:24:40.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -2220,8 +2221,8 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/als4000.c linux-2.6.15-git9_patched/sound/pci/als4000.c
--- linux-2.6.15-git9/sound/pci/als4000.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/als4000.c	2006-01-13 18:24:40.000000000 +0100
@@ -70,6 +70,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/rawmidi.h>
@@ -688,8 +689,8 @@
 		return err;
 	}
 	/* check, if we can restrict PCI DMA transfers to 24 bits */
-	if (pci_set_dma_mask(pci, 0x00ffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x00ffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_24BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_24BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 24bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/azt3328.c linux-2.6.15-git9_patched/sound/pci/azt3328.c
--- linux-2.6.15-git9/sound/pci/azt3328.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/azt3328.c	2006-01-13 18:24:40.000000000 +0100
@@ -104,6 +104,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -1669,8 +1670,8 @@
 	chip->irq = -1;

 	/* check if we can restrict PCI DMA transfers to 24 bits */
-	if (pci_set_dma_mask(pci, 0x00ffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x00ffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_24BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_24BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 24bit PCI busmaster DMA\n");
 		err = -ENXIO;
 		goto out_err;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/emu10k1/emu10k1x.c linux-2.6.15-git9_patched/sound/pci/emu10k1/emu10k1x.c
--- linux-2.6.15-git9/sound/pci/emu10k1/emu10k1x.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/emu10k1/emu10k1x.c	2006-01-13 18:24:40.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -898,8 +899,8 @@

 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "error to set 28bit mask DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/es1938.c linux-2.6.15-git9_patched/sound/pci/es1938.c
--- linux-2.6.15-git9/sound/pci/es1938.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/es1938.c	2006-01-13 18:24:40.000000000 +0100
@@ -55,6 +55,7 @@
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -1517,8 +1518,8 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/es1968.c linux-2.6.15-git9_patched/sound/pci/es1968.c
--- linux-2.6.15-git9/sound/pci/es1968.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/es1968.c	2006-01-13 18:24:40.000000000 +0100
@@ -103,6 +103,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/mpu401.h>
@@ -2559,8 +2560,8 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/ice1712/ice1712.c linux-2.6.15-git9_patched/sound/pci/ice1712/ice1712.c
--- linux-2.6.15-git9/sound/pci/ice1712/ice1712.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/ice1712/ice1712.c	2006-01-13 18:24:40.000000000 +0100
@@ -55,6 +55,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/cs8427.h>
 #include <sound/info.h>
@@ -2538,8 +2539,8 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/maestro3.c linux-2.6.15-git9_patched/sound/pci/maestro3.c
--- linux-2.6.15-git9/sound/pci/maestro3.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/maestro3.c	2006-01-13 18:24:40.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -2657,8 +2658,8 @@
 		return -EIO;

 	/* check, if we can restrict PCI DMA transfers to 28 bits */
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/mixart/mixart.c linux-2.6.15-git9_patched/sound/pci/mixart/mixart.c
--- linux-2.6.15-git9/sound/pci/mixart/mixart.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/mixart/mixart.c	2006-01-13 18:24:40.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
@@ -1288,7 +1289,7 @@
 	pci_set_master(pci);

 	/* check if we can restrict PCI DMA transfers to 32 bits */
-	if (pci_set_dma_mask(pci, 0xffffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 32bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/pcxhr/pcxhr.c linux-2.6.15-git9_patched/sound/pci/pcxhr/pcxhr.c
--- linux-2.6.15-git9/sound/pci/pcxhr/pcxhr.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/pcxhr/pcxhr.c	2006-01-13 18:39:56.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
@@ -1214,7 +1215,7 @@
 	pci_set_master(pci);

 	/* check if we can restrict PCI DMA transfers to 32 bits */
-	if (pci_set_dma_mask(pci, 0xffffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 32bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/sonicvibes.c linux-2.6.15-git9_patched/sound/pci/sonicvibes.c
--- linux-2.6.15-git9/sound/pci/sonicvibes.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/sonicvibes.c	2006-01-13 18:24:40.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>

 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1227,8 +1228,8 @@
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
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/pci/trident/trident_main.c linux-2.6.15-git9_patched/sound/pci/trident/trident_main.c
--- linux-2.6.15-git9/sound/pci/trident/trident_main.c	2006-01-13 18:21:43.000000000 +0100
+++ linux-2.6.15-git9_patched/sound/pci/trident/trident_main.c	2006-01-13 18:26:21.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/gameport.h>
+#include <linux/dma-mapping.h>

 #include <sound/core.h>
 #include <sound/info.h>
@@ -3554,8 +3555,8 @@
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
