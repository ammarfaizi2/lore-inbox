Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbTCHR6H>; Sat, 8 Mar 2003 12:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbTCHR6F>; Sat, 8 Mar 2003 12:58:05 -0500
Received: from pD9E5C11F.dip.t-dialin.net ([217.229.193.31]:35076 "EHLO
	consystor2.razik.de") by vger.kernel.org with ESMTP
	id <S262107AbTCHR56>; Sat, 8 Mar 2003 12:57:58 -0500
From: Lukas@Razik.de
To: linux-kernel@vger.kernel.org
Date: Sat, 08 Mar 2003 19:08:30 +0100
MIME-Version: 1.0
Subject: [BUG 380][PATCHv2] SB16 compile errors
Message-ID: <3E6A3FAE.26113.1A49791@localhost>
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
	Compiled without errors/warnings but driver not tested!
	(No ISA SB16 card available)


Changed files (differences to files of linux-2.5.64.tar.gz):
==================================================
=== sound/isa/sb/sb16.c ==========================
=== DIFFERENCES BEGIN ============================
==================================================
diff -Nru linux-2.5.64/sound/isa/sb/sb16.c linux-2.5.64/sound/isa/sb/sb16.c.new
--- linux-2.5.64/sound/isa/sb/sb16.c            Wed Mar  5 04:29:33 2003
+++ linux-2.5.64/sound/isa/sb/sb16.c.new        Sat Mar  8 18:41:42 2003
@@ -17,6 +17,12 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
+ *  Update 2003-03-08: Changed some #defines and the names of some functions
+ *                     to the new names in isapnp.h and pnp.h
+ *                     isapnp_find_dev()       to  pnp_find_def()
+ *                     isapnp_resourcechange() to  pnp_resource_change()
+ *                     by Lukas Razik <Lukas@Razik.de>
+ *
  */

 #include <sound/driver.h>
@@ -25,8 +31,8 @@
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
@@ -275,14 +281,15 @@
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
@@ -290,30 +297,31 @@
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
@@ -326,17 +334,17 @@
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
@@ -629,7 +637,7 @@
        cards += snd_legacy_auto_probe(possible_ports, snd_sb16_probe_legacy_port);
 #ifdef __ISAPNP__
        /* ISA PnP cards at last */
-       cards += isapnp_probe_cards(snd_sb16_pnpids, snd_sb16_isapnp_detect);
+       cards += pnp_probe_cards(snd_sb16_pnpids, snd_sb16_isapnp_detect);
 #endif

        if (!cards) {
==================================================
=== DIFFERENCES END ==============================
==================================================

==================================================
=== drivers/pnp/isapnp/compat.c ==================
=== DIFFERENCES BEGIN ============================
==================================================
diff -Nru linux-2.5.64/drivers/pnp/isapnp/compat.c linux-
2.5.64/drivers/pnp/isapnp/compat.c.new
--- linux-2.5.64/drivers/pnp/isapnp/compat.c    Wed Mar  5 04:29:34 2003
+++ linux-2.5.64/drivers/pnp/isapnp/compat.c.new        Sat Mar  8 18:42:18 2003
@@ -6,7 +6,10 @@
  *
  */

-/* TODO: see if more isapnp functions are needed here */
+/* TODO: see if more isapnp functions are needed here
+ * Update 2003-03-08: added pnp_probe_cards() and pnp_match_card()
+ *                    by Lukas Razik <Lukas@Razik.de>
+ */

 #include <linux/config.h>
 #include <linux/version.h>
@@ -47,6 +50,7 @@
        return NULL;
 }

+
 struct pnp_dev *pnp_find_dev(struct pnp_card *card,
                             unsigned short vendor,
                             unsigned short function,
@@ -88,5 +92,49 @@
        return NULL;
 }

+static const struct isapnp_card_id *
+pnp_match_card(const struct isapnp_card_id *ids, struct pnp_card *card)
+{
+        int idx;
+
+        while (ids->card_vendor || ids->card_device) {
+                if (ids->card_vendor == ISAPNP_ANY_ID && ids->card_device == 
ISAPNP_ANY_ID) {
+                        for (idx = 0; idx < ISAPNP_CARD_DEVS; idx++) {
+                                if (ids->devs[idx].vendor == 0 &&
+                                    ids->devs[idx].function == 0)
+                                        return ids;
+                                if (pnp_find_dev(card,
+                                                 ids->devs[idx].vendor,
+                                                 ids->devs[idx].function,
+                                                 NULL) == NULL)
+                                        goto __next;
+                        }
+                        return ids;
+                }
+              __next:
+                ids++;
+        }
+        return NULL;
+}
+
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
+        pnp_for_each_card(card) {
+                id = pnp_match_card(ids, card);
+                if (id != NULL && probe(card, id) >= 0)
+                        count++;
+        }
+        return count;
+}
+
 EXPORT_SYMBOL(pnp_find_card);
 EXPORT_SYMBOL(pnp_find_dev);
+EXPORT_SYMBOL(pnp_probe_cards);
==================================================
=== DIFFERENCES END ==============================
==================================================


==================================================
=== linux-2.5.64/include/linux/isapnp.h ==========
=== DIFFERENCES BEGIN ============================
==================================================
diff -Nru linux-2.5.64/include/linux/isapnp.h linux-2.5.64/include/linux/isapnp.h.new
--- linux-2.5.64/include/linux/isapnp.h Wed Mar  5 04:29:53 2003
+++ linux-2.5.64/include/linux/isapnp.h.new     Sat Mar  8 18:43:12 2003
@@ -17,11 +17,17 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
+ *  Update 2003-03-08: Addes some defines
+ *                     added pnp_probe_cards()
+ *                     by Lukas Razik <Lukas@Razik.de>
  */

 #ifndef LINUX_ISAPNP_H
 #define LINUX_ISAPNP_H

+#define isapnp_card pnp_card
+#define isapnp_dev pnp_dev
+
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/pnp.h>
@@ -130,7 +136,10 @@
                             unsigned short vendor,
                             unsigned short function,
                             struct pnp_dev *from);
-
+int pnp_probe_cards(const struct isapnp_card_id *ids,
+                    int (*probe)(struct pnp_card *card,
+                    const struct isapnp_card_id *id));
+
 #else /* !CONFIG_ISAPNP */

 /* lowlevel configuration */
@@ -155,6 +164,9 @@
                                           unsigned short vendor,
                                           unsigned short function,
                                           struct pnp_dev *from) { return NULL; }
+static inline int pnp_probe_cards(const struct isapnp_card_id *ids,
+                                  int (*probe)(struct pnp_card *card,
+                                  const struct isapnp_card_id *id));

 #endif /* CONFIG_ISAPNP */
==================================================
=== DIFFERENCES END ==============================
==================================================


==================================================
=== linux-2.5.64/include/linux/pnp.h =============
=== DIFFERENCES BEGIN ============================
==================================================
diff -Nru linux-2.5.64/include/linux/pnp.h linux-2.5.64/include/linux/pnp.h.new
--- linux-2.5.64/include/linux/pnp.h    Wed Mar  5 04:29:54 2003
+++ linux-2.5.64/include/linux/pnp.h.new        Sat Mar  8 18:43:20 2003
@@ -2,6 +2,8 @@
  * Linux Plug and Play Support
  * Copyright by Adam Belay <ambx1@neo.rr.com>
  *
+ * Update 2003-03-08: Changed struct pnp_dev
+ *                    by Lukas Razik <Lukas@Razik.de>
  */

 #ifndef _LINUX_PNP_H
@@ -13,6 +15,10 @@
 #include <linux/list.h>
 #include <linux/errno.h>

+#ifndef _LINUX_IOPORT_H
+#include <linux/ioport.h>
+#endif
+
 #define PNP_MAX_PORT           8
 #define PNP_MAX_MEM            4
 #define PNP_MAX_IRQ            2
@@ -207,6 +213,10 @@
        unsigned short  regs;           /* ISAPnP: supported registers */
        int             flags;          /* used by protocols */
        struct proc_dir_entry *procent; /* device entry in /proc/bus/isapnp */
+
+       int (*prepare)(struct pnp_dev *dev);    /* ISAPnP hooks */
+       int (*activate)(struct pnp_dev *dev);
+       int (*deactivate)(struct pnp_dev *dev);
 };

 #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)
==================================================
=== DIFFERENCES END ==============================
==================================================

Lukas
