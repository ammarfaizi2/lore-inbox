Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRDOI7b>; Sun, 15 Apr 2001 04:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132608AbRDOI7M>; Sun, 15 Apr 2001 04:59:12 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29391 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132607AbRDOI7F>;
	Sun, 15 Apr 2001 04:59:05 -0400
Message-ID: <3AD962D3.2E6E6DC1@mandrakesoft.com>
Date: Sun, 15 Apr 2001 04:58:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mj@ucw.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.4.3: pci_enable/disable_device stuff
Content-Type: multipart/mixed;
 boundary="------------9AE4842FA5854A19103975B5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9AE4842FA5854A19103975B5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch does two things:

1) Take PCI devices to D0 state before enabling them.  We both think
this is the right thing to do, but there is always the crazy chance this
change will break something.  So, think twice before applying, but IMHO
apply :)

2) Adds pci_disable_device.  Right now is just disables busmastering. 
When suspending devices, the last task that should occur is to disable
busmastering, before ceding control to ACPI.  Also its a good idea in
general to disable busmastering when its not in use; it's friendlier to
the bus.  When unloading drivers too, we should be more "green" about
disabling devices.

I wonder if we should disable IO and MEM decoding too, and I also like
to ack PCI_STATUS.  I didn't add those things because I'm not yet sure
we want to do that unconditionally.  Comments welcome.

-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
--------------9AE4842FA5854A19103975B5
Content-Type: text/plain; charset=us-ascii;
 name="pci-disable-2.4.4.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-disable-2.4.4.3.patch"

diff -urN linux.vanilla/drivers/pci/pci.c linux/drivers/pci/pci.c
--- linux.vanilla/drivers/pci/pci.c	Wed Mar  7 01:44:15 2001
+++ linux/drivers/pci/pci.c	Sun Apr 15 04:32:41 2001
@@ -286,12 +286,33 @@
 {
 	int err;
 
+	pci_set_power_state(dev, 0);
 	if ((err = pcibios_enable_device(dev)) < 0)
 		return err;
-	pci_set_power_state(dev, 0);
 	return 0;
 }
 
+/**
+ * pci_disable_device - Disable PCI device after use
+ * @dev: PCI device to be disabled
+ *
+ * Signal to the system that the PCI device is not in use by the system
+ * anymore.  Currently this only involves disabling PCI busmastering,
+ * if active.
+ */
+
+void
+pci_disable_device(struct pci_dev *dev)
+{
+	u16 pci_command;
+
+	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_MASTER) {
+		pci_command &= ~PCI_COMMAND_MASTER;
+		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+	}
+}
+
 int
 pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 {
@@ -1381,6 +1402,7 @@
 EXPORT_SYMBOL(pci_devices);
 EXPORT_SYMBOL(pci_root_buses);
 EXPORT_SYMBOL(pci_enable_device);
+EXPORT_SYMBOL(pci_disable_device);
 EXPORT_SYMBOL(pci_find_capability);
 EXPORT_SYMBOL(pci_release_regions);
 EXPORT_SYMBOL(pci_request_regions);
diff -urN linux.vanilla/include/linux/pci.h linux/include/linux/pci.h
--- linux.vanilla/include/linux/pci.h	Mon Mar 26 18:48:46 2001
+++ linux/include/linux/pci.h	Sun Apr 15 04:27:28 2001
@@ -525,7 +525,9 @@
 int pci_write_config_word(struct pci_dev *dev, int where, u16 val);
 int pci_write_config_dword(struct pci_dev *dev, int where, u32 val);
 
+#define HAVE_PCI_DISABLE_DEVICE
 int pci_enable_device(struct pci_dev *dev);
+void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask);
 int pci_set_power_state(struct pci_dev *dev, int state);
@@ -594,6 +596,7 @@
 
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
+static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_module_init(struct pci_driver *drv) { return -ENODEV; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}

--------------9AE4842FA5854A19103975B5--

