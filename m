Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbTCGVhW>; Fri, 7 Mar 2003 16:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbTCGVhW>; Fri, 7 Mar 2003 16:37:22 -0500
Received: from p5085DAF8.dip.t-dialin.net ([80.133.218.248]:3588 "EHLO
	consystor2.razik.de") by vger.kernel.org with ESMTP
	id <S261796AbTCGVhL>; Fri, 7 Mar 2003 16:37:11 -0500
From: Lukas@razik.de
To: linux-kernel@vger.kernel.org
Date: Fri, 07 Mar 2003 22:25:32 +0100
MIME-Version: 1.0
Subject: [BUG 380][PATCH] SB16 compile errors
Message-ID: <3E691C5C.16719.A96B633@localhost>
X-mailer: Pegasus Mail for Windows (v4.02, DE v4.02 R1a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Bug description:
	Please look at:
	http://bugme.osdl.org/show_bug.cgi?id=380

Further information
	Bug reported for linux-2.5.62
	Bug also present in linux-2.5.64

Patch:
	Compiled without errors/warnings but driver not tested! (No SB16 card 
available)


Changed files (differences to linux-2.5.64.tar.gz):

==================================================
=== sound/isa/sb/sb16.c ==========================
=== CHANGES BEGIN ================================
==================================================
diff -Nru sound/isa/sb/sb16.c sound/isa/sb/sb16.c.new
--- sound/isa/sb/sb16.c         Wed Mar  5 04:29:33 2003
+++ sound/isa/sb/sb16.c.new     Fri Mar  7 21:42:51 2003
@@ -25,8 +25,8 @@
 #include <linux/slab.h>
 #ifndef LINUX_ISAPNP_H
 #include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
+#define isapnp_card pnp_card
+#define isapnp_dev pnp_dev
 #endif
 #include <sound/core.h>
 #include <sound/sb.h>
@@ -275,14 +275,15 @@
        const struct isapnp_card_id *id = snd_sb16_isapnp_id[dev];
        struct isapnp_card *card = snd_sb16_isapnp_cards[dev];
        struct isapnp_dev *pdev;
+       struct pnp_resource_table *resource_table;

-       acard->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, 
NULL);
+       acard->dev = pnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
        if (acard->dev->active) {
                acard->dev = NULL;
                return -EBUSY;
        }
 #ifdef SNDRV_SBAWE_EMU8000
-       acard->devwt = isapnp_find_dev(card, id->devs[1].vendor, id->devs[1].function, 
NULL);
+       acard->devwt = pnp_find_dev(card, id->devs[1].vendor, id->devs[1].function, 
NULL);
        if (acard->devwt->active) {
                acard->dev = acard->devwt = NULL;
                return -EBUSY;
@@ -290,30 +291,31 @@
 #endif
        /* Audio initialization */
        pdev = acard->dev;
+       resource_table = &pdev->res;
        if (pdev->prepare(pdev) < 0)
                return -EAGAIN;
        if (port[dev] != SNDRV_AUTO_PORT)
-               isapnp_resource_change(&pdev->resource[0], port[dev], 16);
+               pnp_resource_change(&resource_table->port_resource[0], port[dev], 16);
        if (mpu_port[dev] != SNDRV_AUTO_PORT)
-               isapnp_resource_change(&pdev->resource[1], mpu_port[dev], 2);
+               pnp_resource_change(&resource_table->port_resource[1], mpu_port[dev], 
2);
        if (fm_port[dev] != SNDRV_AUTO_PORT)
-               isapnp_resource_change(&pdev->resource[2], fm_port[dev], 4);
+               pnp_resource_change(&resource_table->port_resource[2], fm_port[dev], 4);
        if (dma8[dev] != SNDRV_AUTO_DMA)
-               isapnp_resource_change(&pdev->dma_resource[0], dma8[dev], 1);
+               pnp_resource_change(&resource_table->dma_resource[0], dma8[dev], 1);
        if (dma16[dev] != SNDRV_AUTO_DMA)
-               isapnp_resource_change(&pdev->dma_resource[1], dma16[dev], 1);
+               pnp_resource_change(&resource_table->dma_resource[1], dma16[dev], 1);
        if (irq[dev] != SNDRV_AUTO_IRQ)
-               isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
+               pnp_resource_change(&resource_table->irq_resource[0], irq[dev], 1);
        if (pdev->activate(pdev) < 0) {
                printk(KERN_ERR PFX "isapnp configure failure (out of resources?)\n");
                return -EBUSY;
        }
-       port[dev] = pdev->resource[0].start;
-       mpu_port[dev] = pdev->resource[1].start;
-       fm_port[dev] = pdev->resource[2].start;
-       dma8[dev] = pdev->dma_resource[0].start;
-       dma16[dev] = pdev->dma_resource[1].start;
-       irq[dev] = pdev->irq_resource[0].start;
+       port[dev]     = resource_table->port_resource[0].start;
+       mpu_port[dev] = resource_table->port_resource[1].start;
+       fm_port[dev]  = resource_table->port_resource[2].start;
+       dma8[dev]     = resource_table->dma_resource[0].start;
+       dma16[dev]    = resource_table->dma_resource[1].start;
+       irq[dev]      = resource_table->irq_resource[0].start;
        snd_printdd("isapnp SB16: port=0x%lx, mpu port=0x%lx, fm port=0x%lx\n",
                        port[dev], mpu_port[dev], fm_port[dev]);
        snd_printdd("isapnp SB16: dma1=%i, dma2=%i, irq=%i\n",
@@ -326,17 +328,17 @@
                return -EAGAIN;
        }
        if (awe_port[dev] != SNDRV_AUTO_PORT) {
-               isapnp_resource_change(&pdev->resource[0], awe_port[dev], 4);
-               isapnp_resource_change(&pdev->resource[1], awe_port[dev] + 0x400, 4);
-               isapnp_resource_change(&pdev->resource[2], awe_port[dev] + 0x800, 4);
+               pnp_resource_change(&resource_table->port_resource[0], awe_port[dev], 4);
+               pnp_resource_change(&resource_table->port_resource[1], awe_port[dev] + 
0x400, 4);
+               pnp_resource_change(&resource_table->port_resource[2], awe_port[dev] + 
0x800, 4);
        }
        if (pdev->activate(pdev)<0) {
                printk(KERN_ERR PFX "WaveTable isapnp configure failure (out of 
resources?)\n");
                acard->dev->deactivate(acard->dev);
                return -EBUSY;
        }
-       awe_port[dev] = pdev->resource[0].start;
-       snd_printdd("isapnp SB16: wavetable port=0x%lx\n", pdev->resource[0].start);
+       awe_port[dev] = resource_table->port_resource[0].start;
+       snd_printdd("isapnp SB16: wavetable port=0x%lx\n", resource_table-
>port_resource[0].start);
 #endif
        return 0;
 }
@@ -629,7 +631,7 @@
        cards += snd_legacy_auto_probe(possible_ports, snd_sb16_probe_legacy_port);
 #ifdef __ISAPNP__
        /* ISA PnP cards at last */
-       cards += isapnp_probe_cards(snd_sb16_pnpids, snd_sb16_isapnp_detect);
+       cards += pnp_probe_cards(snd_sb16_pnpids, snd_sb16_isapnp_detect);
 #endif

        if (!cards) {
==================================================
=== CHANGES END ==================================
==================================================

==================================================
=== include/linux/isapnp.h =======================
=== CHANGES BEGIN ================================
==================================================
diff -Nru include/linux/isapnp.h include/linux/isapnp.h.new
--- include/linux/isapnp.h      Wed Mar  5 04:29:53 2003
+++ include/linux/isapnp.h.new  Fri Mar  7 12:40:07 2003
@@ -22,6 +22,10 @@
 #ifndef LINUX_ISAPNP_H
 #define LINUX_ISAPNP_H

+#define isapnp_card pnp_card
+#define isapnp_dev pnp_dev
+
+
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/pnp.h>
@@ -130,6 +134,15 @@
                             unsigned short vendor,
                             unsigned short function,
                             struct pnp_dev *from);
+int pnp_probe_cards(const struct isapnp_card_id *ids,
+                    int (*probe)(struct pnp_card *card,
+                    const struct isapnp_card_id *id));
+int pnp_probe_devs(const struct isapnp_device_id *ids,
+                   int (*probe)(struct pnp_dev *dev,
+                   const struct isapnp_device_id *id));
+void pnp_resource_change(struct resource *resource,
+                         unsigned long start,
+                         unsigned long size);

 #else /* !CONFIG_ISAPNP */

@@ -155,6 +168,15 @@
                                           unsigned short vendor,
                                           unsigned short function,
                                           struct pnp_dev *from) { return NULL; }
+static inline int pnp_probe_cards(const struct isapnp_card_id *ids,
+                                  int (*probe)(struct pnp_card *card,
+                                  const struct isapnp_card_id *id));
+static inline int pnp_probe_devs(const struct isapnp_device_id *ids,
+                                 int (*probe)(struct pnp_dev *dev,
+                                 const struct isapnp_device_id *id));
+static inline void pnp_resource_change(struct resource *resource,
+                                       unsigned long start,
+                                       unsigned long size);

 #endif /* CONFIG_ISAPNP */
==================================================
=== CHANGES END ==================================
==================================================


==================================================
=== include/linux/pnp.h ==========================
=== CHANGES BEGIN ================================
==================================================
diff -Nru include/linux/pnp.h include/linux/pnp.h.new
--- include/linux/pnp.h Wed Mar  5 04:29:54 2003
+++ include/linux/pnp.h.new     Fri Mar  7 12:15:45 2003
@@ -13,6 +13,10 @@
 #include <linux/list.h>
 #include <linux/errno.h>

+#ifndef _LINUX_IOPORT_H
+#include <linux/ioport.h>
+#endif
+
 #define PNP_MAX_PORT           8
 #define PNP_MAX_MEM            4
 #define PNP_MAX_IRQ            2
@@ -207,6 +211,10 @@
        unsigned short  regs;           /* ISAPnP: supported registers */
        int             flags;          /* used by protocols */
        struct proc_dir_entry *procent; /* device entry in /proc/bus/isapnp */
+
+        int (*prepare)(struct pnp_dev *dev);    /* ISAPnP hooks */
+        int (*activate)(struct pnp_dev *dev);
+        int (*deactivate)(struct pnp_dev *dev);
 };
==================================================
=== CHANGES END ==================================
==================================================

==================================================
=== drivers/pnp/isapnp/compat.c ==================
=== CHANGES BEGIN ================================
==================================================
=== The "new" functions here are from:         ===
=== linux-2.4.20/drivers/pnp/isapnp.c          ===
==================================================
diff -Nru drivers/pnp/isapnp/compat.c drivers/pnp/isapnp/compat.c.new
--- drivers/pnp/isapnp/compat.c Wed Mar  5 04:29:34 2003
+++ drivers/pnp/isapnp/compat.c.new     Fri Mar  7 12:34:18 2003
@@ -88,5 +88,53 @@
        return NULL;
 }

+int pnp_probe_cards(const struct isapnp_card_id *ids,
+                    int (*probe)(struct pnp_card *_card,
+                    const struct isapnp_card_id *_id))
+{
+        struct pnp_card *card;
+        const struct isapnp_card_id *id;
+        int count = 0;
+
+        if (ids == NULL || probe == NULL)
+                return -EINVAL;
+        isapnp_for_each_card(card) {
+                id = isapnp_match_card(ids, card);
+                if (id != NULL && probe(card, id) >= 0)
+                        count++;
+        }
+        return count;
+}
+
+int pnp_probe_devs(const struct isapnp_device_id *ids,
+                   int (*probe)(struct pnp_dev *dev,
+                   const struct isapnp_device_id *id))
+{
+
+        struct pnp_dev *dev;
+        const struct isapnp_device_id *id;
+        int count = 0;
+
+        if (ids == NULL || probe == NULL)
+                return -EINVAL;
+        isapnp_for_each_dev(dev) {
+                id = isapnp_match_dev(ids, dev);
+                if (id != NULL && probe(dev, id) >= 0)
+                        count++;
+        }
+        return count;
+}
+
+void pnp_resource_change(struct resource *resource,
+                         unsigned long start,
+                         unsigned long size)
+{
+        if (resource == NULL)
+                return;
+        resource->flags &= ~IORESOURCE_AUTO;
+        resource->start = start;
+        resource->end = start + size - 1;
+}
+
 EXPORT_SYMBOL(pnp_find_card);
 EXPORT_SYMBOL(pnp_find_dev);
==================================================
=== CHANGES END ==================================
==================================================


Lukas


----------
...enjoy the day! :-)))

