Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWISWSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWISWSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWISWSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:18:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:7385 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751232AbWISWSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:18:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MjCCU6OEz3GTNVO2H9boGubygR3IkEkfliAcyEOyx4bBQtROLuqZbNO4rcjGIBm2afPDdoKA3Qe5LiTArfFMz+A/vdxxeR7u6a2KHvoiOokTNW2Mq9ufJkPeyLxeuvTbVDdD5xmX7SBjLEbP4ppAbDhjOBZm85x9MpLw8yDFvAQ=
Message-ID: <8b96e3d20609191518o3a6d4ee3j7e3e40a72260a8af@mail.gmail.com>
Date: Tue, 19 Sep 2006 19:18:40 -0300
From: "Luiz Angelo Daros de Luca" <luizluca@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Adds kernel parameter to ignore pci devices
Cc: torvalds@osdl.org
In-Reply-To: <8b96e3d20609191447x77e284b1j904e4106942e040e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8b96e3d20609191447x77e284b1j904e4106942e040e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

     Some time ago, I went to freenode IRC trying to solve a hardware
imcompatible problem in Linux. I have an old computer
(k6-200Mhz/chipset sis) and a USB 1.x and 2.0 expansion PCI Card
(LG/chipset sis). Usb 1.x works fine but if usb 2.0 (ehci) is set up,
the system freezes. This happens in Linux and win98. In windows I
managed to solve this simply disabling the device. But in Linux, I
can't do that, just disabling all pci with pci=off. I tried reserve=
stuff with no luck. As the help from the friends in IRC wasn't enough,
I decided to do it my self.

     This is my first patch and so must have lots of problems. I think
I must also write a description for
Documentation/kernel-parameters.txt. I'm not sure about the "flag" in
dev struct to tell that it is to be ignored. Null can't be used as the
multifunction is detected by the current device. So, I assumed that
devices with bus==null are ignored. The only alternative that I though
to not use this hack is spliting and join some other functions.
Please, feed back me. BTW, this patch really solved my problem. lspci
doesn't show the device and so all the OS. Just scanpci was able to
list the ignored device.

     Please, CC to my personal email as I'm not in kernel mail list.

     Luiz Andelo Daros de Luca,


     This patchs adds ignore_pci= parameter to disable a pci device as
windows control panel does. This solves some hardware incompatibily in
old computers that freezes the kernel just after the device gets
configured by pci driver.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

---
--- linux-2.6.16.13-4/drivers/pci/probe.c.orig	2006-09-19
19:07:39.000000000 -0300
+++ linux-2.6.16.13-4/drivers/pci/probe.c	2006-09-19 19:09:21.000000000 -0300
@@ -753,6 +753,94 @@ static void pci_release_bus_bridge_dev(s
 }

 /*
+ * Max ignored devices
+ */
+#define MAX_IGNORED_DEVICES 10
+/*
+ * Vector with device/vendor numbers as (device<<16|vendor)
+ */
+static u32 ignore_device[MAX_IGNORED_DEVICES+1];
+
+/*
+ * Loops ignore_device checking if vendor_device matches one of the
+ * ignore_device[] elements.
+ */
+static inline u8 device_shouldbe_ignored(u32 vendor_device) {
+	u32 *device_ignored = ignore_device; //read static
+	u32 cur_ignored_device;
+
+	while ((cur_ignored_device=device_ignored[0])) {
+		if (vendor_device==cur_ignored_device)
+			return 1;
+		device_ignored++;
+	}
+	return 0;
+}
+
+/*
+ * Reads the kernel parameter ignore_device= and save
+ * the values in vector ignore_device
+ */
+static int __init ignore_device_setup (char *str)
+{
+	static int ignore_device_ptr;//=0
+	int id=0;
+
+	int vendor=0;
+	int device=0;
+
+	while (str && str[0]) {
+		/* Interpret first parameter as number */
+		if (!get_option (&str, &id)) {
+			printk(KERN_WARNING
+				"Warning: ignore_device parameter '%s' should be a number\n",
+				 str);
+			return 0;
+		}
+
+		if (!vendor) {
+			vendor=id;
+			/* Check for device syntax */
+			if (str[0]==':') {
+				str++;
+				continue;
+			} else
+				break;
+		} else {
+			device=id;
+			/* Check for next entry */
+			if (str[0] == ',')
+				str++;
+		}
+
+		if (ignore_device_ptr < MAX_IGNORED_DEVICES) {
+			/* Save the ignored device information */
+			ignore_device[ignore_device_ptr++]=device<<16 | vendor;
+			/* Warns it */
+			printk(KERN_WARNING "Device %04X:%04X will be ignored\n",
+				vendor, device);
+			/* Reset vendor and device */
+			vendor=0;
+			device=0;
+		} else {
+			printk(KERN_WARNING
+				"Too many ignored devices. %04X:%04X will NOT be ignored\n",
+				vendor, device);
+			return 0;
+		}
+	}
+
+	if (vendor) {
+		printk(KERN_WARNING
+			"IGNORE_DEVICE: Invalid vendor:device parameter. Ignoring %d\n",
+			vendor);
+		return 0;
+	}
+
+	return 1;
+}
+
+/*
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
  */
@@ -805,6 +893,17 @@ pci_scan_device(struct pci_bus *bus, int
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
+    /* Mark as ignored(dev->bus=NULL) and return. Do not allow any
+       further setups as some broken devices freezes the computer here.
+       It must return a dev to keep pci_scan_slot scanning for other
+       devices (dev->multifunction).  */
+	if (device_shouldbe_ignored(l)) {
+		printk(KERN_WARNING
+			"PCI_IGNORE: Device %04X:%04X ignored as requested\n",
+			dev->vendor,dev->device);
+			dev->bus=NULL;
+			return dev;
+		}
 	dev->cfg_size = pci_cfg_space_size(dev);

 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
@@ -849,8 +948,11 @@ pci_scan_single_device(struct pci_bus *b
 	if (!dev)
 		return NULL;

-	pci_device_add(dev, bus);
-	pci_scan_msi_device(dev);
+	/* Devices with dev->bus==NULL where set to be ignored by pci_scan_device. */
+	if (dev->bus) {
+		pci_device_add(dev, bus);
+		pci_scan_msi_device(dev);
+	}

 	return dev;
 }
@@ -1036,6 +1138,8 @@ struct pci_bus * __devinit pci_scan_bus_
 }
 EXPORT_SYMBOL(pci_scan_bus_parented);

+__setup("ignore_device=", ignore_device_setup);
+
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_do_scan_bus);
