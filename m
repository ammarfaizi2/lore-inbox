Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132347AbQLHRLW>; Fri, 8 Dec 2000 12:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbQLHRLM>; Fri, 8 Dec 2000 12:11:12 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:10771 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S132402AbQLHRKz>; Fri, 8 Dec 2000 12:10:55 -0500
Date: Fri, 8 Dec 2000 11:41:07 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: <linux-kernel@vger.kernel.org>
cc: <linux-sound@vger.kernel.org>, Pete Zaitcev <zaitcev@metabyte.com>,
        Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] for YMF PCI sound cards
Message-ID: <Pine.LNX.4.30.0012081128330.5353-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Description of the changes:

Changed logic in drivers/sound/Config.in so that both drivers for YMF PCI
can be compiled as modules, but neither of them is enabled if the other
one is linked into the kernel (just like the UHCI drivers).

Don't use ENOTTY in the ioctl routine in drivers/sound/ymfpci.c - use
EINVAL instead.

Initialize the legacy OPL3 interface in drivers/sound/ymfpci.c since there
is no native synthesizer support yet. Added parameter synth_io to specify
the address of the OPL3 interface.

Add YMF cards to the table of known codecs in drivers/sound/ac97_codec.c

For your convenience, the patch is also available at
http://www.red-bean.com/~proski/ymf.patch

Regards,
Pavel Roskin

_________________________________
--- ./drivers/sound/Config.in	Thu Dec  7 10:59:06 2000
+++ ./drivers/sound/Config.in	Fri Dec  8 11:25:08 2000
@@ -142,8 +142,10 @@
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2, SA3, and SAx based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha YMF7xx PCI audio (legacy mode)' CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
-   if [ "$CONFIG_SOUND_YMPCI" = "n" ]; then
+   if [ "$CONFIG_SOUND_YMFPCI" != "y" ]; then
+      dep_tristate '    Yamaha YMF7xx PCI audio (legacy mode)' CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
+   fi
+   if [ "$CONFIG_SOUND_YMPCI" != "y" ]; then
       dep_tristate '    Yamaha YMF7xx PCI audio (native mode) (EXPERIMENTAL)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI $CONFIG_EXPERIMENTAL
    fi
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 $CONFIG_SOUND_OSS
--- ./drivers/sound/ymfpci.c	Thu Dec  7 10:59:06 2000
+++ ./drivers/sound/ymfpci.c	Fri Dec  8 11:33:51 2000
@@ -81,6 +81,13 @@
 };
 MODULE_DEVICE_TABLE(pci, ymf_id_tbl);

+#ifdef MODULE
+static int synth_io = 0;
+MODULE_PARM(synth_io, "i");
+#else
+static int synth_io   = 0x388;
+#endif
+
 /*
  * Mindlessly copied from cs46xx XXX
  */
@@ -1868,7 +1875,7 @@
 	case SNDCTL_DSP_SETSYNCRO:
 	case SOUND_PCM_WRITE_FILTER:
 	case SOUND_PCM_READ_FILTER:
-		return -ENOTTY;
+		return -EINVAL;

 	default:
 	/* P3 */ printk(KERN_WARNING "ymfpci: unknown ioctl cmd 0x%x\n", cmd);
@@ -1879,7 +1886,76 @@
 		 * XXX Is there sound_generic_ioctl() around?
 		 */
 	}
-	return -ENOTTY;
+	return -EINVAL;
+}
+
+#define	YMFSB_PCIR_LEGCTRL              0x40
+#define	YMFSB_PCIR_ELEGCTRL             0x42
+#define YMFSB_PCIR_OPLADR               0x60
+static int ymfpci_opl3_init(struct pci_dev *pcidev, int instance)
+{
+	int v;
+	int oplio = 0;
+
+	switch(synth_io) {
+	case 0:
+		/* Only enable OPL3 by default for the first card */
+		if (instance == 0) {
+			synth_io = 0x388;
+		} else {
+			return 0;
+		}
+		break;
+	case 0x388:
+		oplio = 0;
+		break;
+	case 0x398:
+		oplio = 1;
+		break;
+	case 0x3a0:
+		oplio = 2;
+		break;
+	case 0x3a8:
+		oplio = 3;
+		break;
+	case -1:
+		return 0;
+		break;
+	default:
+		printk(KERN_ERR
+		       "ymfpci%d: synth_io=0x%x is not valid\n",
+		       instance, synth_io);
+		return -1;
+		break;
+	}
+
+	printk("ymfpci%d: set OPL3 I/O at 0x%x\n", instance, synth_io);
+
+	v = 0x003f;
+	pci_write_config_word(pcidev, YMFSB_PCIR_LEGCTRL, v);
+
+	v = 0x8800;
+	switch( pcidev->device ) {
+	case PCI_DEVICE_ID_YAMAHA_724:
+	case PCI_DEVICE_ID_YAMAHA_724F:
+	case PCI_DEVICE_ID_YAMAHA_740:
+	case PCI_DEVICE_ID_YAMAHA_740C:
+		v = v | (oplio & 0x03);
+		pci_write_config_word(pcidev, YMFSB_PCIR_ELEGCTRL, v);
+		break;
+
+	case PCI_DEVICE_ID_YAMAHA_744:
+	case PCI_DEVICE_ID_YAMAHA_754:
+		pci_write_config_word(pcidev, YMFSB_PCIR_ELEGCTRL, v);
+		pci_write_config_word(pcidev, YMFSB_PCIR_OPLADR, synth_io);
+		break;
+
+	default:
+		return -1;
+		break;
+	}
+
+	return 0;
 }

 static int ymf_open(struct inode *inode, struct file *file)
@@ -2290,6 +2366,8 @@

 	printk(KERN_INFO "ymfpci%d: %s at 0x%lx IRQ %d\n", ymf_instance,
 	    (char *)ent->driver_data, pci_resource_start(pcidev, 0), pcidev->irq);
+
+	ymfpci_opl3_init(pcidev, ymf_instance);

 	ymfpci_aclink_reset(pcidev);
 	if (ymfpci_codec_ready(codec, 0, 1) < 0)
--- ./drivers/sound/ac97_codec.c	Thu Dec  7 10:59:06 2000
+++ ./drivers/sound/ac97_codec.c	Thu Dec  7 11:00:44 2000
@@ -61,6 +61,7 @@
 } ac97_codec_ids[] = {
 	{0x414B4D00, "Asahi Kasei AK4540 rev 0", NULL},
 	{0x414B4D01, "Asahi Kasei AK4540 rev 1", NULL},
+	{0x41445303, "Yamaha YMF????"          , NULL},
 	{0x41445340, "Analog Devices AD1881"  , NULL},
 	{0x41445360, "Analog Devices AD1885"  , enable_eapd},
 	{0x43525900, "Cirrus Logic CS4297"    , NULL},
_________________________________


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
