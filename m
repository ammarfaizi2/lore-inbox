Return-Path: <linux-kernel-owner+w=401wt.eu-S1422845AbWLUIRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWLUIRU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWLUIRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:17:20 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:46814 "EHLO vana.vc.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422842AbWLUIRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:17:19 -0500
X-Greylist: delayed 1296 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 03:17:18 EST
Date: Thu, 21 Dec 2006 08:55:40 +0100
From: Petr Vandrovec <petr@vandrovec.name>
To: jeff@garzik.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Unbreak MSI on ATI devices
Message-ID: <20061221075540.GA21152@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,
  I'm using second patch below for couple of months to get MSI on all
devices present on my notebook which are MSI capable (except IDE - notebook
uses IDE in legacy mode and seems unhappy with transition to native MSI-based
mode; maybe I could try do the job with libata now when I switched; and VGA, I 
do not use dri...).  All worked nicely until last sync, when I noticed that my 
USB devices suddenly stopped working (it took me few weeks as I do not use USB
regulary). 

After poking around I've found that problem is that at least ATI USB-HCDs
apply INTX enable even for MSI, despite warning in the PCI specification that
it should apply only to MSI (actually I have feeling that on these USB devices 
disabling INTX in MSI mode drives their INTA# line active as when ohci1394 
module got loaded kernel complained about interrupt being continuously 
activated for no good reason (TI's 7421 is one of few MSI-incapable devices
in my box).

So my question is - what is real reason for disabling INTX when in MSI mode?
According to PCI spec it should not be needed, and it hurts at least chips
listed below:

00:13.0 0c03: 1002:4374 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
00:13.1 0c03: 1002:4375 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
00:13.2 0c03: 1002:4373 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller 

I believe that these devices from same vendor accept disabling INTX while in MSI
fine (I did not notice problems with them even with INTX disabling code in msi.c):

00:14.5 0401: 1002:4370 (rev 02) Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 02)
00:14.6 0703: 1002:4378 (rev 02) Modem: ATI Technologies Inc ATI SB400 - AC'97 Modem Controller (rev 02)

None of devices in the box assert INTX while in MSI even if INTX is enabled.


So I'd like to see first patch below accepted.  If there are some devices which
require INTX disabling, then apparently decision whether to disable it or no
has to be moved to device drivers, or some blacklist/whitelist must be created...

I'm not sure about second one - I have it in my tree for months, but I run 
that kernel only on hardware mentioned above, so it is probably too dangerous 
until pci_enable_msi() gets answer whether MSI works or no always right.
						Thanks,
							Petr Vandrovec

/proc/interrupts after patch.  Before patch *hci_hcd:usb* were at zero, IRQ21 was
stuck with IRQ count at 10000, and HCD complained about "Unlink after no-IRQ?".

           CPU0
  0:     140326  local-APIC-edge-fasteio   timer
  1:      10773   IO-APIC-edge      i8042
  8:          1   IO-APIC-edge      rtc
 12:      34498   IO-APIC-edge      i8042
 14:      34714   IO-APIC-edge      libata
 15:         82   IO-APIC-edge      libata
 16:          1   IO-APIC-fasteoi   tifm_7xx1, yenta, sdhci:slot0, sdhci:slot1, sdhci:slot2
 21:        265   IO-APIC-fasteoi   acpi, ohci1394
 22:      28973   IO-APIC-fasteoi   ipw2200
216:          1   PCI-MSI-edge      ATI IXP Modem
217:          1   PCI-MSI-edge      ATI IXP
218:          2   PCI-MSI-edge      ehci_hcd:usb3
219:         88   PCI-MSI-edge      ohci_hcd:usb2
220:          1   PCI-MSI-edge      ohci_hcd:usb1
221:          1   PCI-MSI-edge      eth0
NMI:          0
LOC:     140293
ERR:          0
MIS:          0


Do not disable INTX in MSI mode.  It breaks ATI USB HCDs (both OHCI and EHCI).

Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

diff -uprdN linux/drivers/pci/msi.c linux/drivers/pci/msi.c
--- linux/drivers/pci/msi.c	2006-12-16 13:34:52.000000000 -0800
+++ linux/drivers/pci/msi.c	2006-12-20 23:18:10.000000000 -0800
@@ -256,7 +256,7 @@ static void enable_msi_mode(struct pci_d
 		dev->msix_enabled = 1;
 	}
 
-	pci_intx(dev, 0);  /* disable intx */
+	pci_intx(dev, 1);  /* enable intx, on some devices it affects MSI as well */
 }
 
 void disable_msi_mode(struct pci_dev *dev, int pos, int type)



Use MSI when available on USB HCDs and on ATI AC'97 hardware.

Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

diff -uprdN linux/drivers/usb/core/hcd-pci.c linux/drivers/usb/core/hcd-pci.c
--- linux/drivers/usb/core/hcd-pci.c	2006-12-16 13:34:57.000000000 -0800
+++ linux/drivers/usb/core/hcd-pci.c	2006-12-16 13:57:09.000000000 -0800
@@ -69,6 +69,7 @@ int usb_hcd_pci_probe (struct pci_dev *d
 
 	if (pci_enable_device (dev) < 0)
 		return -ENODEV;
+	pci_enable_msi(dev);
 	dev->current_state = PCI_D0;
 	dev->dev.power.power_state = PMSG_ON;
 	
@@ -139,6 +140,7 @@ int usb_hcd_pci_probe (struct pci_dev *d
 		release_region (hcd->rsrc_start, hcd->rsrc_len);
  err2:
 	usb_put_hcd (hcd);
+	pci_disable_msi (dev);
  err1:
 	pci_disable_device (dev);
 	dev_err (&dev->dev, "init %s fail, %d\n", pci_name(dev), retval);
@@ -177,6 +179,7 @@ void usb_hcd_pci_remove (struct pci_dev 
 		release_region (hcd->rsrc_start, hcd->rsrc_len);
 	}
 	usb_put_hcd (hcd);
+	pci_disable_msi(dev);
 	pci_disable_device(dev);
 }
 EXPORT_SYMBOL (usb_hcd_pci_remove);
@@ -391,6 +394,7 @@ int usb_hcd_pci_resume (struct pci_dev *
 			"can't re-enable after resume, %d!\n", retval);
 		return retval;
 	}
+	pci_enable_msi (dev);
 	pci_set_master (dev);
 	pci_restore_state (dev);
 
diff -uprdN linux/sound/pci/atiixp.c linux/sound/pci/atiixp.c
--- linux/sound/pci/atiixp.c	2006-12-16 13:35:47.000000000 -0800
+++ linux/sound/pci/atiixp.c	2006-12-16 13:57:09.000000000 -0800
@@ -60,6 +60,8 @@ MODULE_PARM_DESC(spdif_aclink, "S/PDIF o
 /* just for backward compatibility */
 static int enable;
 module_param(enable, bool, 0444);
+static int msi;
+module_param(msi, bool, 0444);
 
 
 /*
@@ -279,6 +281,8 @@ struct atiixp {
 
 	int spdif_over_aclink;		/* passed from the module option */
 	struct mutex open_mutex;	/* playback open mutex */
+	
+	int have_msi;
 };
 
 
@@ -1442,6 +1446,11 @@ static int snd_atiixp_suspend(struct pci
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
+	if (chip->have_msi) {
+		pci_disable_msi(pci);
+	} else {
+		pci_intx(pci, 0);
+	}
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	pci_set_power_state(pci, pci_choose_state(pci, state));
@@ -1463,6 +1472,11 @@ static int snd_atiixp_resume(struct pci_
 		return -EIO;
 	}
 	pci_set_master(pci);
+	if (chip->have_msi) {
+		pci_enable_msi(pci);
+	} else {
+		pci_intx(pci, 1);
+	}
 
 	snd_atiixp_aclink_reset(chip);
 	snd_atiixp_chip_start(chip);
@@ -1532,6 +1546,11 @@ static int snd_atiixp_free(struct atiixp
 	if (chip->remap_addr)
 		iounmap(chip->remap_addr);
 	pci_release_regions(chip->pci);
+	if (chip->have_msi) {
+		pci_disable_msi(chip->pci);
+	} else {
+		pci_intx(chip->pci, 0);
+	}
 	pci_disable_device(chip->pci);
 	kfree(chip);
 	return 0;
@@ -1583,6 +1602,9 @@ static int __devinit snd_atiixp_create(s
 		return -EIO;
 	}
 
+	if (msi && pci_enable_msi(pci) == 0) {
+		chip->have_msi = 1;
+	}
 	if (request_irq(pci->irq, snd_atiixp_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card->shortname, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
@@ -1591,6 +1613,9 @@ static int __devinit snd_atiixp_create(s
 	}
 	chip->irq = pci->irq;
 	pci_set_master(pci);
+	if (!chip->have_msi) {
+		pci_intx(pci, 1);
+	}
 	synchronize_irq(chip->irq);
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
diff -uprdN linux/sound/pci/atiixp_modem.c linux/sound/pci/atiixp_modem.c
--- linux/sound/pci/atiixp_modem.c	2006-12-16 13:35:47.000000000 -0800
+++ linux/sound/pci/atiixp_modem.c	2006-12-16 13:57:09.000000000 -0800
@@ -54,6 +54,8 @@ MODULE_PARM_DESC(ac97_clock, "AC'97 code
 /* just for backward compatibility */
 static int enable;
 module_param(enable, bool, 0444);
+static int msi;
+module_param(msi, bool, 0444);
 
 
 /*
@@ -257,6 +259,8 @@ struct atiixp_modem {
 
 	int spdif_over_aclink;		/* passed from the module option */
 	struct mutex open_mutex;	/* playback open mutex */
+	
+	int have_msi;
 };
 
 
@@ -1128,6 +1132,11 @@ static int snd_atiixp_suspend(struct pci
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
+	if (chip->have_msi) {
+		pci_disable_msi(pci);
+	} else {
+		pci_intx(pci, 0);
+	}
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	pci_set_power_state(pci, pci_choose_state(pci, state));
@@ -1149,6 +1158,11 @@ static int snd_atiixp_resume(struct pci_
 		return -EIO;
 	}
 	pci_set_master(pci);
+	if (chip->have_msi) {
+		pci_enable_msi(pci);
+	} else {
+		pci_intx(pci, 1);
+	}
 
 	snd_atiixp_aclink_reset(chip);
 	snd_atiixp_chip_start(chip);
@@ -1204,6 +1218,11 @@ static int snd_atiixp_free(struct atiixp
 		free_irq(chip->irq, chip);
 	if (chip->remap_addr)
 		iounmap(chip->remap_addr);
+	if (chip->have_msi) {
+		pci_disable_msi(chip->pci);
+	} else {
+		pci_intx(chip->pci, 0);
+	}
 	pci_release_regions(chip->pci);
 	pci_disable_device(chip->pci);
 	kfree(chip);
@@ -1255,7 +1274,9 @@ static int __devinit snd_atiixp_create(s
 		snd_atiixp_free(chip);
 		return -EIO;
 	}
-
+	if (msi && pci_enable_msi(pci) == 0) {
+		chip->have_msi = 1;
+	}
 	if (request_irq(pci->irq, snd_atiixp_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card->shortname, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
@@ -1264,6 +1285,9 @@ static int __devinit snd_atiixp_create(s
 	}
 	chip->irq = pci->irq;
 	pci_set_master(pci);
+	if (!chip->have_msi) {
+		pci_intx(pci, 1);
+	}
 	synchronize_irq(chip->irq);
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
