Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291040AbSBLUEO>; Tue, 12 Feb 2002 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291049AbSBLUDz>; Tue, 12 Feb 2002 15:03:55 -0500
Received: from ra.abo.fi ([130.232.213.1]:38798 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S291040AbSBLUDp>;
	Tue, 12 Feb 2002 15:03:45 -0500
Date: Tue, 12 Feb 2002 22:03:40 +0200 (EET)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <perex@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] request_region / release_resource mixup
In-Reply-To: <3C68BB15.AF27E615@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202122157090.22607-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Jeff Garzik wrote:

> Good patch, but a comment.  When you replace release_resource(res) with
> release_region(), you should also look and see if you can eliminate the
> temporary variable 'res' too.

Yes, sounds great. Another try below, with some more fixes forgotten
from pcnet32.c and trying to fix isapnp.c even further.

Since pcnet32.c seems to be in for a change by Go Taniguchi, I'll keep
this diff current, and if no other issues arise I'll try to get it
applied.

Marcus

===== drivers/char/tpqic02.c 1.6 vs edited =====
--- 1.6/drivers/char/tpqic02.c	Tue Feb  5 09:45:20 2002
+++ edited/drivers/char/tpqic02.c	Tue Feb 12 20:22:38 2002
@@ -2750,7 +2750,9 @@
 	 * the config parameters have been set using MTSETCONFIG.
 	 */

-	if (check_region(QIC02_TAPE_PORT, QIC02_TAPE_PORT_RANGE)) {
+	/* Grab the IO region. */
+	if (!request_region(QIC02_TAPE_PORT, QIC02_TAPE_PORT_RANGE,
+			   TPQIC02_NAME)) {
 		printk(TPQIC02_NAME
 		       ": IO space at 0x%x [%d ports] already reserved\n",
 		       QIC02_TAPE_PORT, QIC02_TAPE_PORT_RANGE);
@@ -2764,6 +2766,7 @@
 		printk(TPQIC02_NAME
 		       ": can't allocate IRQ%d for QIC-02 tape\n",
 		       QIC02_TAPE_IRQ);
+		release_region(QIC02_TAPE_PORT, QIC02_TAPE_PORT_RANGE);
 		return -EBUSY;
 	}

@@ -2773,12 +2776,9 @@
 		       ": can't allocate DMA%d for QIC-02 tape\n",
 		       QIC02_TAPE_DMA);
 		free_irq(QIC02_TAPE_IRQ, NULL);
+		release_region(QIC02_TAPE_PORT, QIC02_TAPE_PORT_RANGE);
 		return -EBUSY;
 	}
-
-	/* Grab the IO region. We already made sure it's available. */
-	request_region(QIC02_TAPE_PORT, QIC02_TAPE_PORT_RANGE,
-		       TPQIC02_NAME);

 	/* Setup the page-address for the dma transfer. */
 	buffaddr =
===== drivers/net/lance.c 1.8 vs edited =====
--- 1.8/drivers/net/lance.c	Tue Feb  5 09:49:26 2002
+++ edited/drivers/net/lance.c	Tue Feb 12 20:22:36 2002
@@ -383,7 +383,7 @@
 					return 0;
 				}
 			}
-			release_resource(r);
+			release_region(ioaddr, LANCE_TOTAL_SIZE);
 		}
 	}
 	return -ENODEV;
===== drivers/net/pcnet32.c 1.14 vs edited =====
--- 1.14/drivers/net/pcnet32.c	Tue Feb  5 16:10:21 2002
+++ edited/drivers/net/pcnet32.c	Tue Feb 12 20:24:20 2002
@@ -518,7 +518,6 @@
 pcnet32_probe1(unsigned long ioaddr, unsigned char irq_line, int shared, int card_idx, struct pci_dev *pdev)
 {
     struct pcnet32_private *lp;
-    struct resource *res;
     dma_addr_t lp_dma_addr;
     int i,media,fdx = 0, mii = 0, fset = 0;
 #ifdef DO_DXSUFLO
@@ -698,13 +697,12 @@
     }

     dev->base_addr = ioaddr;
-    res = request_region(ioaddr, PCNET32_TOTAL_SIZE, chipname);
-    if (res == NULL)
+    if (request_region(ioaddr, PCNET32_TOTAL_SIZE, chipname) == NULL)
 	return -EBUSY;

     /* pci_alloc_consistent returns page-aligned memory, so we do not have to check the alignment */
     if ((lp = pci_alloc_consistent(pdev, sizeof(*lp), &lp_dma_addr)) == NULL) {
-	release_resource(res);
+	release_region(ioaddr, PCNET32_TOTAL_SIZE);
 	return -ENOMEM;
     }

@@ -738,7 +736,7 @@
     if (a == NULL) {
       printk(KERN_ERR "pcnet32: No access methods\n");
       pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
-      release_resource(res);
+      release_region(ioaddr, PCNET32_TOTAL_SIZE);
       return -ENODEV;
     }
     lp->a = *a;
@@ -786,7 +784,7 @@
 	else {
 	    printk(", failed to detect IRQ line.\n");
 	    pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
-	    release_resource(res);
+	    release_region(ioaddr, PCNET32_TOTAL_SIZE);
 	    return -ENODEV;
 	}
     }
===== drivers/net/wd.c 1.6 vs edited =====
--- 1.6/drivers/net/wd.c	Tue Feb  5 09:49:26 2002
+++ edited/drivers/net/wd.c	Tue Feb 12 20:22:36 2002
@@ -97,7 +97,7 @@
 			return -EBUSY;
 		i = wd_probe1(dev, base_addr);
 		if (i != 0)
-			release_resource(r);
+			release_region(base_addr, WD_IO_EXTENT);
 		else
 			r->name = dev->name;
 		return i;
@@ -114,7 +114,7 @@
 			r->name = dev->name;
 			return 0;
 		}
-		release_resource(r);
+		release_region(ioaddr, WD_IO_EXTENT);
 	}

 	return -ENODEV;
===== drivers/pnp/isapnp.c 1.7 vs edited =====
--- 1.7/drivers/pnp/isapnp.c	Tue Feb  5 16:10:27 2002
+++ edited/drivers/pnp/isapnp.c	Tue Feb 12 20:48:28 2002
@@ -56,10 +56,6 @@
 #define ISAPNP_DEBUG
 #endif

-struct resource *pidxr_res;
-struct resource *pnpwrp_res;
-struct resource *isapnp_rdp_res;
-
 int isapnp_disable;			/* Disable ISA PnP */
 int isapnp_rdp;				/* Read Data Port */
 int isapnp_reset = 1;			/* reset all PnP cards (deactivate) */
@@ -2147,13 +2143,10 @@
 static void isapnp_free_all_resources(void)
 {
 #ifdef ISAPNP_REGION_OK
-	if (pidxr_res)
-		release_resource(pidxr_res);
+	release_region(_PIDXR, 1);
 #endif
-	if (pnpwrp_res)
-		release_resource(pnpwrp_res);
-	if (isapnp_rdp >= 0x203 && isapnp_rdp <= 0x3ff && isapnp_rdp_res)
-		release_resource(isapnp_rdp_res);
+	release_region(_PNPWRP, 1);
+	release_region(isapnp_rdp, 1);
 #ifdef MODULE
 #ifdef CONFIG_PROC_FS
 	isapnp_proc_done();
@@ -2284,14 +2277,12 @@
 		return 0;
 	}
 #ifdef ISAPNP_REGION_OK
-	pidxr_res=request_region(_PIDXR, 1, "isapnp index");
-	if(!pidxr_res) {
+	if (!request_region(_PIDXR, 1, "isapnp index")) {
 		printk(KERN_ERR "isapnp: Index Register 0x%x already used\n", _PIDXR);
 		return -EBUSY;
 	}
 #endif
-	pnpwrp_res=request_region(_PNPWRP, 1, "isapnp write");
-	if(!pnpwrp_res) {
+	if (!request_region(_PNPWRP, 1, "isapnp write")) {
 		printk(KERN_ERR "isapnp: Write Data Register 0x%x already used\n", _PNPWRP);
 #ifdef ISAPNP_REGION_OK
 		release_region(_PIDXR, 1);
@@ -2307,13 +2298,12 @@
 	printk(KERN_INFO "isapnp: Scanning for PnP cards...\n");
 	if (isapnp_rdp >= 0x203 && isapnp_rdp <= 0x3ff) {
 		isapnp_rdp |= 3;
-		isapnp_rdp_res=request_region(isapnp_rdp, 1, "isapnp read");
-		if(!isapnp_rdp_res) {
+		if (!request_region(isapnp_rdp, 1, "isapnp read")) {
 			printk(KERN_ERR "isapnp: Read Data Register 0x%x already used\n", isapnp_rdp);
 #ifdef ISAPNP_REGION_OK
 			release_region(_PIDXR, 1);
 #endif
-			release_region(isapnp_rdp, 1);
+			release_region(_PNPWRP, 1);
 			return -EBUSY;
 		}
 		isapnp_set_rdp();
@@ -2323,12 +2313,15 @@
 		cards = isapnp_isolate();
 		if (cards < 0 ||
 		    (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
-			isapnp_free_all_resources();
+#ifdef ISAPNP_REGION_OK
+			release_region(_PIDXR, 1);
+#endif
+			release_region(_PNPWRP, 1);
 			isapnp_detected = 0;
 			printk(KERN_INFO "isapnp: No Plug & Play device found\n");
 			return 0;
 		}
-		isapnp_rdp_res=request_region(isapnp_rdp, 1, "isapnp read");
+		request_region(isapnp_rdp, 1, "isapnp read");
 	}
 	isapnp_build_device_list();
 	cards = 0;

-- 
Marcus Alanen * Department of Computer Science * http://www.cs.abo.fi/
maalanen@abo.fi


