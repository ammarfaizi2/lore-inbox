Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLEHoy>; Tue, 5 Dec 2000 02:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQLEHoo>; Tue, 5 Dec 2000 02:44:44 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:60946 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129401AbQLEHo0>; Tue, 5 Dec 2000 02:44:26 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14892.38320.194351.163997@wire.cadcamlab.org>
Date: Tue, 5 Dec 2000 01:13:52 -0600 (CST)
To: adam@yggdrasil.com
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ymfpci.c MODULE_DEVICE_TABLE
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adam, could you check my work here?  I haven't done this before....  It
compiles, but I don't have the hardware to verify anything.  And, being
a lousy kernel hacker, I've probably introduced at least one bug.

Peter


diff -urk~ test12pre5/drivers/sound/Config.in~ test12pre5/drivers/sound/Config.in
--- test12pre5/drivers/sound/Config.in~	Mon Dec  4 23:59:44 2000
+++ test12pre5/drivers/sound/Config.in	Tue Dec  5 01:02:05 2000
@@ -142,9 +142,9 @@
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2, SA3, and SAx based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha PCI legacy mode support' CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
+   dep_tristate '    Yamaha YMF7xx PCI audio (legacy mode)' CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
    if [ "$CONFIG_SOUND_YMPCI" = "n" ]; then
-     dep_tristate 'Yamaha PCI native mode support (EXPERIMENTAL)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS
+      dep_tristate '    Yamaha YMF7xx PCI audio (native mode) (EXPERIMENTAL)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI $CONFIG_EXPERIMENTAL
    fi
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 $CONFIG_SOUND_OSS
   
diff -urk~ test12pre5/drivers/sound/ymfpci.c~ test12pre5/drivers/sound/ymfpci.c
--- test12pre5/drivers/sound/ymfpci.c~	Mon Dec  4 23:59:46 2000
+++ test12pre5/drivers/sound/ymfpci.c	Tue Dec  5 00:59:44 2000
@@ -68,17 +68,19 @@
  *  constants
  */
 
-static struct ymf_devid {
-	int id;
-	char *name;
-} ymf_devv[] = {
-	{ PCI_DEVICE_ID_YAMAHA_724,  "YMF724" },
-	{ PCI_DEVICE_ID_YAMAHA_724F, "YMF724F" },
-	{ PCI_DEVICE_ID_YAMAHA_740,  "YMF740" },
-	{ PCI_DEVICE_ID_YAMAHA_740C, "YMF740C" },
-	{ PCI_DEVICE_ID_YAMAHA_744,  "YMF744" },
-	{ PCI_DEVICE_ID_YAMAHA_754,  "YMF754" },
+static struct pci_device_id ymf_id_tbl[] = {
+#define DEV(v, d, data) \
+  { PCI_VENDOR_ID_##v, PCI_DEVICE_ID_##v##_##d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (unsigned long)data }
+	DEV (YAMAHA, 724,  "YMF724"),
+	DEV (YAMAHA, 724F, "YMF724F"),
+	DEV (YAMAHA, 740,  "YMF740"),
+	DEV (YAMAHA, 740C, "YMF740C"),
+	DEV (YAMAHA, 744,  "YMF744"),
+	DEV (YAMAHA, 754,  "YMF754"),
+#undef DEV
+	{ }
 };
+MODULE_DEVICE_TABLE(pci, ymf_id_tbl);
 
 /*
  * Mindlessly copied from cs46xx XXX
@@ -2245,8 +2247,10 @@
 	return 0;
 }
 
-static int /* __init */
-ymf_install(struct pci_dev *pcidev, int instance, int devx)
+static int ymf_instance;
+
+static int __devinit
+ymf_install_one(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
 	ymfpci_t *codec;
 
@@ -2261,7 +2265,7 @@
 	spin_lock_init(&codec->reg_lock);
 	spin_lock_init(&codec->voice_lock);
 	codec->pci = pcidev;
-	codec->inst = instance;
+	codec->inst = ymf_instance;
 	codec->irq = pcidev->irq;
 	codec->device_id = pcidev->device;
 	pci_read_config_byte(pcidev, PCI_REVISION_ID, (u8 *)&codec->rev);
@@ -2270,8 +2274,8 @@
 	pci_set_master(pcidev);
 
 	/* XXX KERN_INFO */
-	printk("ymfpci%d: %s at 0x%lx IRQ %d\n", instance,
-	    ymf_devv[devx].name, codec->reg_area_phys, codec->irq);
+	printk("ymfpci%d: %s at 0x%lx IRQ %d\n", ymf_instance,
+	    (char *)ent->driver_data, codec->reg_area_phys, codec->irq);
 
 	ymfpci_aclink_reset(pcidev);
 	if (ymfpci_codec_ready(codec, 0, 1) < 0) {
@@ -2317,6 +2321,7 @@
 
 	codec->next = ymf_devs;
 	ymf_devs = codec;
+	ymf_instance++;
 
 	return 0;
 }
@@ -2356,43 +2361,15 @@
 MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Yamaha YMF7xx PCI Audio");
 
-static int /* __init */
-ymf_probe(void)
-{
-	struct pci_dev *pcidev;
-	int foundone;
-	int i;
-
-	if (!pci_present())
-		return -ENODEV;
-
-	/*
-	 * Print our proud ego-nursing "Hello, World!" message as in MS-DOS.
-	 */
-	/* printk(KERN_INFO "ymfpci: Yamaha YMF7xx\n"); */
-
-	/*
-	 * Not very efficient, but Alan did it so in cs46xx.c.
-	 */
-	foundone = 0;
-	pcidev = NULL;
-	for (i = 0; i < sizeof(ymf_devv)/sizeof(ymf_devv[0]); i++) {
-		while ((pcidev = pci_find_device(PCI_VENDOR_ID_YAMAHA,
-		    ymf_devv[i].id, pcidev)) != NULL) {
-			if (ymf_install(pcidev, foundone, i) == 0) {
-				foundone++;
-			}
-		}
-	}
-
-	return foundone;
-}
+static struct pci_driver ymfpci_driver = {
+	name:		"ymfpci",
+	id_table:	ymf_id_tbl,
+	probe:		ymf_install_one,
+};
 
 static int ymf_init_module(void)
 {
-	if (ymf_probe()==0)
-		printk(KERN_ERR "ymfpci: No devices found.\n");
-	return 0;
+	return pci_module_init (&ymfpci_driver);
 }
 
 static void ymf_cleanup_module (void)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
