Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbREVMpz>; Tue, 22 May 2001 08:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbREVMpp>; Tue, 22 May 2001 08:45:45 -0400
Received: from ns.caldera.de ([212.34.180.1]:10151 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261478AbREVMpZ>;
	Tue, 22 May 2001 08:45:25 -0400
Date: Tue, 22 May 2001 14:44:38 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: more esssolo1 cleanups
Message-ID: <20010522144438.A21170@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I did some more cleanups:
- changed PM to 2.4 pci module style
- removed global list of devices, now using pci device data.

I tried to add a pci_set_power_state(dev,3) in _remove, but this apparently
has no effect (amplifier stays switched on), so I did not submit this part.

Tested on IBM ThinkPad 390E.

Ciao, Marcus

Index: drivers/sound/esssolo1.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/esssolo1.c,v
retrieving revision 1.12
diff -u -r1.12 esssolo1.c
--- drivers/sound/esssolo1.c	2001/05/18 08:06:38	1.12
+++ drivers/sound/esssolo1.c	2001/05/22 12:28:54
@@ -79,6 +79,9 @@
  *                       for abs. Bug report by Andrew Morton <andrewm@uow.edu.au>
  *    15.05.2001         pci_enable_device moved, return values in probe cleaned
  *                       up. Marcus Meissner <mm@caldera.de>
+ *    22.05.2001   0.19  more cleanups, changed PM to PCI 2.4 style, got rid
+ *                       of global list of devices, using pci device data.
+ *                       Marcus Meissner <mm@caldera.de>
  */
 
 /*****************************************************************************/
@@ -94,7 +97,6 @@
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
-#include <linux/pm.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/init.h>
@@ -161,15 +163,14 @@
 
 #define FMODE_DMFM 0x10
 
+static struct pci_driver solo1_driver;
+
 /* --------------------------------------------------------------------- */
 
 struct solo1_state {
 	/* magic */
 	unsigned int magic;
 
-	/* list of esssolo1 devices */
-	struct list_head devs;
-	
 	/* the corresponding pci_dev structure */
 	struct pci_dev *dev;
 
@@ -244,10 +245,6 @@
 
 /* --------------------------------------------------------------------- */
 
-static LIST_HEAD(devs);
-
-/* --------------------------------------------------------------------- */
-
 extern inline void write_seq(struct solo1_state *s, unsigned char data)
 {
         int i;
@@ -939,16 +936,22 @@
 static int solo1_open_mixdev(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
-	struct list_head *list;
-	struct solo1_state *s;
+	struct solo1_state *s = NULL;
+	struct pci_dev *pci_dev;
 
-	for (list = devs.next; ; list = list->next) {
-		if (list == &devs)
-			return -ENODEV;
-		s = list_entry(list, struct solo1_state, devs);
+	pci_for_each_dev(pci_dev) {
+		struct pci_driver *drvr;
+		drvr = pci_dev_driver (pci_dev);
+		if (drvr != &solo1_driver)
+			continue;
+		s = (struct solo1_state*)pci_get_drvdata(pci_dev);
+		if (!s)
+			continue;
 		if (s->dev_mixer == minor)
 			break;
 	}
+	if (!s)
+		return -ENODEV;
        	VALIDATE_STATE(s);
 	file->private_data = s;
 	return 0;
@@ -1611,16 +1614,23 @@
 {
 	int minor = MINOR(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
-	struct list_head *list;
-	struct solo1_state *s;
+	struct solo1_state *s = NULL;
+	struct pci_dev *pci_dev;
 	
-	for (list = devs.next; ; list = list->next) {
-		if (list == &devs)
-			return -ENODEV;
-		s = list_entry(list, struct solo1_state, devs);
+	pci_for_each_dev(pci_dev) {
+		struct pci_driver *drvr;
+
+		drvr = pci_dev_driver(pci_dev);
+		if (drvr != &solo1_driver)
+			continue;
+		s = (struct solo1_state*)pci_get_drvdata(pci_dev);
+		if (!s)
+			continue;
 		if (!((s->dev_audio ^ minor) & ~0xf))
 			break;
 	}
+	if (!s)
+		return -ENODEV;
        	VALIDATE_STATE(s);
 	file->private_data = s;
 	/* wait for device to become free */
@@ -1894,16 +1904,23 @@
 	int minor = MINOR(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
-	struct list_head *list;
-	struct solo1_state *s;
+	struct solo1_state *s = NULL;
+	struct pci_dev *pci_dev;
+
+	pci_for_each_dev(pci_dev) {
+		struct pci_driver *drvr;
 
-	for (list = devs.next; ; list = list->next) {
-		if (list == &devs)
-			return -ENODEV;
-		s = list_entry(list, struct solo1_state, devs);
+		drvr = pci_dev_driver(pci_dev);
+		if (drvr != &solo1_driver)
+			continue;
+		s = (struct solo1_state*)pci_get_drvdata(pci_dev);
+		if (!s)
+			continue;
 		if (s->dev_midi == minor)
 			break;
 	}
+	if (!s)
+		return -ENODEV;
        	VALIDATE_STATE(s);
 	file->private_data = s;
 	/* wait for device to become free */
@@ -2112,16 +2129,23 @@
 {
 	int minor = MINOR(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
-	struct list_head *list;
-	struct solo1_state *s;
+	struct solo1_state *s = NULL;
+	struct pci_dev *pci_dev;
+
+	pci_for_each_dev(pci_dev) {
+		struct pci_driver *drvr;
 
-	for (list = devs.next; ; list = list->next) {
-		if (list == &devs)
-			return -ENODEV;
-		s = list_entry(list, struct solo1_state, devs);
+		drvr = pci_dev_driver(pci_dev);
+		if (drvr != &solo1_driver)
+			continue;
+		s = (struct solo1_state*)pci_get_drvdata(pci_dev);
+		if (!s)
+			continue;
 		if (s->dev_dmfm == minor)
 			break;
 	}
+	if (!s)
+		return -ENODEV;
        	VALIDATE_STATE(s);
 	file->private_data = s;
 	/* wait for device to become free */
@@ -2256,33 +2280,31 @@
 	return 0;
 }
 
-static int solo1_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	struct solo1_state *s = (struct solo1_state*) dev->data;
-	if (s) {
-		switch(rqst) {
-		case PM_RESUME:
-			setup_solo1(s);
-			break;
+static void
+solo1_suspend(struct pci_dev *pci_dev) {
+	struct solo1_state *s = (struct solo1_state*)pci_get_drvdata(pci_dev);
+	if (!s)
+		return;
+	outb(0, s->iobase+6);
+	/* DMA master clear */
+	outb(0, s->ddmabase+0xd); 
+	/* reset sequencer and FIFO */
+	outb(3, s->sbbase+6); 
+	/* turn off DDMA controller address space */
+	pci_write_config_word(s->dev, 0x60, 0); 
+}
 
-		case PM_SUSPEND:
-			outb(0, s->iobase+6);
-			/* DMA master clear */
-			outb(0, s->ddmabase+0xd); 
-			/* reset sequencer and FIFO */
-			outb(3, s->sbbase+6); 
-			/* turn off DDMA controller address space */
-			pci_write_config_word(s->dev, 0x60, 0); 
-			break;
-		}
-	}
-	return 0;
+static void
+solo1_resume(struct pci_dev *pci_dev) {
+	struct solo1_state *s = (struct solo1_state*)pci_get_drvdata(pci_dev);
+	if (!s)
+		return;
+	setup_solo1(s);
 }
 
 static int __devinit solo1_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct solo1_state *s;
-	struct pm_dev *pmdev;
 	int ret;
 
  	if ((ret=pci_enable_device(pcidev)))
@@ -2379,13 +2401,6 @@
 	gameport_register_port(&s->gameport);
 	/* store it in the driver field */
 	pci_set_drvdata(pcidev, s);
-	/* put it into driver list */
-	list_add_tail(&s->devs, &devs);
-
-	pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev), solo1_pm_callback);
-	if (pmdev)
-		pmdev->data = s;
-
 	return 0;
 
  err:
@@ -2420,7 +2435,6 @@
 	
 	if (!s)
 		return;
-	list_del(&s->devs);
 	/* stop DMA controller */
 	outb(0, s->iobase+6);
 	outb(0, s->ddmabase+0xd); /* DMA master clear */
@@ -2455,7 +2469,9 @@
 	name: "ESS Solo1",
 	id_table: id_table,
 	probe: solo1_probe,
-	remove: solo1_remove
+	remove: solo1_remove,
+	suspend: solo1_suspend,
+	resume: solo1_resume
 };
 
 
@@ -2463,7 +2479,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "solo1: version v0.18 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "solo1: version v0.19 time " __TIME__ " " __DATE__ "\n");
 	if (!pci_register_driver(&solo1_driver)) {
 		pci_unregister_driver(&solo1_driver);
                 return -ENODEV;
@@ -2480,7 +2496,6 @@
 {
 	printk(KERN_INFO "solo1: unloading\n");
 	pci_unregister_driver(&solo1_driver);
-	pm_unregister_all(solo1_pm_callback);
 }
 
 /* --------------------------------------------------------------------- */
