Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262366AbSKRNNJ>; Mon, 18 Nov 2002 08:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSKRNNJ>; Mon, 18 Nov 2002 08:13:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35029 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262366AbSKRNNG>; Mon, 18 Nov 2002 08:13:06 -0500
Date: Mon, 18 Nov 2002 14:20:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix compile breakage in drivers/net/irda/vlsi_ir.c
Message-ID: <20021118132002.GD11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

could you check whether the patch below that does a name -> dev.name to
fix the following compile error in 2.5.48 is correct?

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/irda/.vlsi_ir.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vlsi_ir -DKBUILD_MODNAME=vlsi_ir   -c -o drivers/net/irda/vlsi_ir.o drivers/net/irda/vlsi_ir.c
...
drivers/net/irda/vlsi_ir.c: In function `vlsi_proc_pdev':
drivers/net/irda/vlsi_ir.c:165: structure has no member named `name'
drivers/net/irda/vlsi_ir.c: In function `vlsi_tx_timeout':
drivers/net/irda/vlsi_ir.c:1520: structure has no member named `name'
drivers/net/irda/vlsi_ir.c: In function `vlsi_irda_probe':
drivers/net/irda/vlsi_ir.c:1768: structure has no member named `name'
drivers/net/irda/vlsi_ir.c: In function `vlsi_irda_remove':
drivers/net/irda/vlsi_ir.c:1866: structure has no member named `name'
drivers/net/irda/vlsi_ir.c: In function `vlsi_irda_save_state':
drivers/net/irda/vlsi_ir.c:1882: structure has no member named `name'
drivers/net/irda/vlsi_ir.c: In function `vlsi_irda_suspend':
drivers/net/irda/vlsi_ir.c:1895: structure has no member named `name'
drivers/net/irda/vlsi_ir.c:1899: structure has no member named `name'
drivers/net/irda/vlsi_ir.c:1911: structure has no member named `name'
drivers/net/irda/vlsi_ir.c: In function `vlsi_irda_resume':
drivers/net/irda/vlsi_ir.c:1938: structure has no member named `name'
drivers/net/irda/vlsi_ir.c:1945: structure has no member named `name'
make[3]: *** [drivers/net/irda/vlsi_ir.o] Error 1

<--  snip  -->


TIA
Adrian


--- linux-2.5.48/drivers/net/irda/vlsi_ir.c.old	2002-11-18 14:11:30.000000000 +0100
+++ linux-2.5.48/drivers/net/irda/vlsi_ir.c	2002-11-18 14:13:07.000000000 +0100
@@ -162,7 +162,7 @@
 		return 0;
 
 	out += sprintf(out, "\n%s (vid/did: %04x/%04x)\n",
-			pdev->name, (int)pdev->vendor, (int)pdev->device);
+			pdev->dev.name, (int)pdev->vendor, (int)pdev->device);
 	out += sprintf(out, "pci-power-state: %u\n", (unsigned) pdev->current_state);
 	out += sprintf(out, "resources: irq=%u / io=0x%04x / dma_mask=0x%016Lx\n",
 			pdev->irq, (unsigned)pci_resource_start(pdev, 0), (u64)pdev->dma_mask);
@@ -1517,7 +1517,7 @@
 
 	if (vlsi_start_hw(idev))
 		printk(KERN_CRIT "%s: failed to restart hw - %s(%s) unusable!\n",
-			__FUNCTION__, idev->pdev->name, ndev->name);
+			__FUNCTION__, idev->pdev->dev.name, ndev->name);
 	else
 		netif_start_queue(ndev);
 }
@@ -1765,7 +1765,7 @@
 		pdev->current_state = 0; /* hw must be running now */
 
 	printk(KERN_INFO "%s: IrDA PCI controller %s detected\n",
-		drivername, pdev->name);
+		drivername, pdev->dev.name);
 
 	if ( !pci_resource_start(pdev,0)
 	     || !(pci_resource_flags(pdev,0) & IORESOURCE_IO) ) {
@@ -1863,7 +1863,7 @@
 	 * ndev->destructor called (if present) when going to free
 	 */
 
-	printk(KERN_INFO "%s: %s removed\n", drivername, pdev->name);
+	printk(KERN_INFO "%s: %s removed\n", drivername, pdev->dev.name);
 }
 
 #ifdef CONFIG_PM
@@ -1879,7 +1879,7 @@
 {
 	if (state < 1 || state > 3 ) {
 		printk( KERN_ERR "%s - %s: invalid pm state request: %u\n",
-			__FUNCTION__, pdev->name, state);
+			__FUNCTION__, pdev->dev.name, state);
 		return -1;
 	}
 	return 0;
@@ -1892,11 +1892,11 @@
 
 	if (state < 1 || state > 3 ) {
 		printk( KERN_ERR "%s - %s: invalid pm state request: %u\n",
-			__FUNCTION__, pdev->name, state);
+			__FUNCTION__, pdev->dev.name, state);
 		return 0;
 	}
 	if (!ndev) {
-		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->name);
+		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->dev.name);
 		return 0;
 	}
 	idev = ndev->priv;	
@@ -1908,7 +1908,7 @@
 		}
 		else
 			printk(KERN_ERR "%s - %s: invalid suspend request %u -> %u\n",
-				__FUNCTION__, pdev->name, pdev->current_state, state);
+				__FUNCTION__, pdev->dev.name, pdev->current_state, state);
 		up(&idev->sem);
 		return 0;
 	}
@@ -1935,14 +1935,14 @@
 	vlsi_irda_dev_t	*idev;
 
 	if (!ndev) {
-		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->name);
+		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->dev.name);
 		return 0;
 	}
 	idev = ndev->priv;	
 	down(&idev->sem);
 	if (pdev->current_state == 0) {
 		up(&idev->sem);
-		printk(KERN_ERR "%s - %s: already resumed\n", __FUNCTION__, pdev->name);
+		printk(KERN_ERR "%s - %s: already resumed\n", __FUNCTION__, pdev->dev.name);
 		return 0;
 	}
 	
