Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288976AbSBIPWX>; Sat, 9 Feb 2002 10:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288977AbSBIPWO>; Sat, 9 Feb 2002 10:22:14 -0500
Received: from ra.abo.fi ([130.232.213.1]:17876 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S288976AbSBIPV4>;
	Sat, 9 Feb 2002 10:21:56 -0500
Date: Sat, 9 Feb 2002 17:21:51 +0200 (EET)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: <perex@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: [patch] request_region / release_resource mixup
Message-ID: <Pine.LNX.4.33.0202091708230.1410-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, looking at region and resource handling I see that request_region
allocates the struct resource with kmalloc() while request_resource
takes it as a parameter. This means that release_region uses kfree()
and release_resource doesn't.

There are some drivers which mix this up by doing a request_region /
release_resource pair, instead of the proper request_region /
release_region. This leads to a memory leak.

I've tried to fix this below. Comments? Output is from bk diff -u,
not sure what the best command would've been.

Also, one check_region was removed, and isapnp seems to release the
wrong region, isapnp_rdp instead of _PNPWRP.

Marcus

===== drivers/pnp/isapnp.c 1.7 vs 1.8 =====
--- 1.7/drivers/pnp/isapnp.c	Tue Feb  5 16:10:27 2002
+++ 1.8/drivers/pnp/isapnp.c	Sat Feb  9 03:40:41 2002
@@ -2148,12 +2148,12 @@
 {
 #ifdef ISAPNP_REGION_OK
 	if (pidxr_res)
-		release_resource(pidxr_res);
+		release_region(_PIDXR, 1);
 #endif
 	if (pnpwrp_res)
-		release_resource(pnpwrp_res);
+		release_region(_PNPWRP, 1);
 	if (isapnp_rdp >= 0x203 && isapnp_rdp <= 0x3ff && isapnp_rdp_res)
-		release_resource(isapnp_rdp_res);
+		release_region(isapnp_rdp, 1);
 #ifdef MODULE
 #ifdef CONFIG_PROC_FS
 	isapnp_proc_done();
@@ -2313,7 +2313,7 @@
 #ifdef ISAPNP_REGION_OK
 			release_region(_PIDXR, 1);
 #endif
-			release_region(isapnp_rdp, 1);
+			release_region(_PNPWRP, 1);
 			return -EBUSY;
 		}
 		isapnp_set_rdp();
===== drivers/net/wd.c 1.6 vs 1.7 =====
--- 1.6/drivers/net/wd.c	Tue Feb  5 09:49:26 2002
+++ 1.7/drivers/net/wd.c	Sat Feb  9 03:40:41 2002
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
===== drivers/net/lance.c 1.8 vs 1.9 =====
--- 1.8/drivers/net/lance.c	Tue Feb  5 09:49:26 2002
+++ 1.9/drivers/net/lance.c	Sat Feb  9 03:40:41 2002
@@ -383,7 +383,7 @@
 					return 0;
 				}
 			}
-			release_resource(r);
+			release_region(ioaddr, LANCE_TOTAL_SIZE);
 		}
 	}
 	return -ENODEV;
===== drivers/net/pcnet32.c 1.14 vs 1.15 =====
--- 1.14/drivers/net/pcnet32.c	Tue Feb  5 16:10:21 2002
+++ 1.15/drivers/net/pcnet32.c	Sat Feb  9 03:40:41 2002
@@ -704,7 +704,7 @@

     /* pci_alloc_consistent returns page-aligned memory, so we do not have to check the alignment */
     if ((lp = pci_alloc_consistent(pdev, sizeof(*lp), &lp_dma_addr)) == NULL) {
-	release_resource(res);
+	release_region(ioaddr, PCNET32_TOTAL_SIZE);
 	return -ENOMEM;
     }

===== drivers/char/tpqic02.c 1.6 vs 1.7 =====
--- 1.6/drivers/char/tpqic02.c	Tue Feb  5 09:45:20 2002
+++ 1.7/drivers/char/tpqic02.c	Sat Feb  9 03:40:41 2002
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

