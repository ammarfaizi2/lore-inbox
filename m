Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263734AbTCUVZ6>; Fri, 21 Mar 2003 16:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbTCUVYy>; Fri, 21 Mar 2003 16:24:54 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:17635 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262750AbTCUVXn>; Fri, 21 Mar 2003 16:23:43 -0500
Date: Fri, 21 Mar 2003 22:32:49 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] PCI quirk for SMBus bridge on Asus P4 boards
Message-ID: <20030321213249.GA16016@brodo.de>
References: <20030319211837.GA23651@brodo.de> <1048146514.12350.43.camel@workshop.saharact.lan> <20030320084148.GA2414@brodo.de> <20030321100801.13107ef0.azarah@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321100801.13107ef0.azarah@gentoo.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 10:08:01AM +0200, Martin Schlemmer wrote:
> On Thu, 20 Mar 2003 09:41:48 +0100
> Dominik Brodowski <linux@brodo.de> wrote:
> 
> > On Thu, Mar 20, 2003 at 09:48:35AM +0200, Martin Schlemmer wrote:
> > > On Wed, 2003-03-19 at 23:18, Dominik Brodowski wrote:
> > > > Asus hides the SMBus PCI bridge within the ICH2 or ICH4
> > > > southbridge on Asus P4B/P4PE mainboards. The attached patch adds a
> > > > quirk to re-enable the SMBus PCI bridge for P4B533 and P4PE
> > > > mainboards.
> > > > 
> > > 
> > > The ASUS P4T533-C J(850E Chipset) does that as well .... think you
> > > might tweak the patch for this board ?  I can test if you can ....
> > 
> > Sure: please send me the output of "pcitweak -l" or "lspci -vv".
> > 
> 
> Here you go

And here's the patch (for 2.5.65). Please tell me whether it works on your
P4T533 mainboard; if so, I'll re-diff it for -ac and send it to Alan (he 
included the first patch already)

	Dominik

diff -ru linux-original/drivers/pci/quirks.c linux/drivers/pci/quirks.c
--- linux-original/drivers/pci/quirks.c	2003-03-19 22:13:57.000000000 +0100
+++ linux/drivers/pci/quirks.c	2003-03-21 22:28:51.000000000 +0100
@@ -647,6 +647,56 @@
 }
 
 /*
+ * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
+ * is not activated. The myth is that Asus said that they do not want the
+ * users to be irritated by just another PCI Device in the Win98 device
+ * manager. (see the file prog/hotplug/README.p4b in the lm_sensors 
+ * package 2.7.0 for details)
+ *
+ * The SMBus PCI Device can be activated by setting a bit in the ICH LPC 
+ * bridge. Unfortunately, this device has no subvendor/subdevice ID. So it 
+ * becomes necessary to do this tweak in two steps -- I've chosen the Host
+ * bridge as trigger.
+ */
+
+static int __initdata asus_hides_smbus = 0;
+
+static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
+{
+	if (likely(dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK))
+		return;
+
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82845_HB) && 
+	    (dev->subsystem_device == 0x8088)) /* P4B533 */
+		asus_hides_smbus = 1;
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82845G_HB) &&
+	    (dev->subsystem_device == 0x80b2)) /* P4PE */
+		asus_hides_smbus = 1;
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82850_HB) &&
+	    (dev->subsystem_device == 0x8030)) /* P4T533 */
+		asus_hides_smbus = 1;
+	return;
+}
+
+static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
+{
+	u16 val;
+	
+	if (likely(!asus_hides_smbus))
+		return;
+
+	pci_read_config_word(dev, 0xF2, &val);
+	if (val & 0x8) {
+		pci_write_config_word(dev, 0xF2, val & (~0x8));
+		pci_read_config_word(dev, 0xF2, &val);
+		if(val & 0x8)
+			printk(KERN_INFO "PCI: i801 SMBus device continues to play 'hide and seek'! 0x%x\n", val);
+		else
+			printk(KERN_INFO "PCI: Enabled i801 SMBus device\n");
+	}
+}
+
+/*
  *  The main table of quirks.
  */
 
@@ -724,6 +774,15 @@
 	
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge },
 
+	/*
+	 * on Asus P4B boards, the i801SMBus device is disabled at startup.
+	 */
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
+
 	{ 0 }
 };
 
