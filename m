Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWJJNQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWJJNQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWJJNQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:16:43 -0400
Received: from havoc.gtf.org ([69.61.125.42]:39317 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750726AbWJJNQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:16:41 -0400
Date: Tue, 10 Oct 2006 09:16:40 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH] drivers/ide: fix error return bugs, interface
Message-ID: <20061010131639.GA8523@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following error handling problems:

* The init_chipset API function is defined to return 'unsigned int', but
	- the caller code tests the return value for '< 0'
	- drivers sometimes return a negative value
  so, we change the API to return an 'int'

* cs5530: handle pci_set_mwi() failure with a printk()... shouldn't kill driver

* sc1200: handle pci_enable_device() failure during resume

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/ide/pci/aec62xx.c       |    2 +-
 drivers/ide/pci/alim15x3.c      |    2 +-
 drivers/ide/pci/amd74xx.c       |    2 +-
 drivers/ide/pci/cmd64x.c        |    2 +-
 drivers/ide/pci/cs5530.c        |    6 ++++--
 drivers/ide/pci/cy82c693.c      |    2 +-
 drivers/ide/pci/hpt34x.c        |    2 +-
 drivers/ide/pci/hpt366.c        |    2 +-
 drivers/ide/pci/it821x.c        |    2 +-
 drivers/ide/pci/pdc202xx_new.c  |    2 +-
 drivers/ide/pci/pdc202xx_old.c  |    2 +-
 drivers/ide/pci/piix.c          |    2 +-
 drivers/ide/pci/sc1200.c        |    7 ++++++-
 drivers/ide/pci/serverworks.c   |    2 +-
 drivers/ide/pci/siimage.c       |    2 +-
 drivers/ide/pci/sis5513.c       |    2 +-
 drivers/ide/pci/sl82c105.c      |    2 +-
 drivers/ide/pci/via82cxxx.c     |    2 +-
 include/linux/ide.h             |    2 +-

diff --git a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
index f286079..6bd482d 100644
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -247,7 +247,7 @@ static int aec62xx_irq_timeout (ide_driv
 	return 0;
 }
 
-static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
 {
 	int bus_speed = system_bus_clock();
 
diff --git a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
index d419e4b..6da390f 100644
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -582,7 +582,7 @@ static int ali15x3_dma_setup(ide_drive_t
  *	appropriate also sets up the 1533 southbridge.
  */
   
-static unsigned int __devinit init_chipset_ali15x3 (struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_ali15x3 (struct pci_dev *dev, const char *name)
 {
 	unsigned long flags;
 	u8 tmpbyte;
diff --git a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
index 2b0ea8b..5866b13 100644
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -312,7 +312,7 @@ static int amd74xx_ide_dma_check(ide_dri
  * and initialize its drive independent registers.
  */
 
-static unsigned int __devinit init_chipset_amd74xx(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_amd74xx(struct pci_dev *dev, const char *name)
 {
 	unsigned char t;
 	unsigned int u;
diff --git a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
index 20c3271..d60221e 100644
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -589,7 +589,7 @@ static int cmd646_1_ide_dma_end (ide_dri
 	return (dma_stat & 7) != 4;
 }
 
-static unsigned int __devinit init_chipset_cmd64x(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_cmd64x(struct pci_dev *dev, const char *name)
 {
 	u32 class_rev = 0;
 	u8 mrdmode = 0;
diff --git a/drivers/ide/pci/cs5530.c b/drivers/ide/pci/cs5530.c
index ae405fa..2035246 100644
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -216,7 +216,7 @@ static int cs5530_config_dma (ide_drive_
  *	Initialize the cs5530 bridge for reliable IDE DMA operation.
  */
 
-static unsigned int __devinit init_chipset_cs5530 (struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_cs5530 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
 	unsigned long flags;
@@ -250,7 +250,9 @@ static unsigned int __devinit init_chips
 	 */
 
 	pci_set_master(cs5530_0);
-	pci_set_mwi(cs5530_0);
+	if (pci_set_mwi(cs5530_0))
+		dev_printk(KERN_WARNING, &cs5530_0->dev,
+			   "MWI enable failed\n");
 
 	/*
 	 * Set PCI CacheLineSize to 16-bytes:
diff --git a/drivers/ide/pci/cy82c693.c b/drivers/ide/pci/cy82c693.c
index 64330c4..dfb5db2 100644
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -390,7 +390,7 @@ #endif /* CY82C693_DEBUG_INFO */
 /*
  * this function is called during init and is used to setup the cy82c693 chip
  */
-static unsigned int __devinit init_chipset_cy82c693(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_cy82c693(struct pci_dev *dev, const char *name)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
 		return 0;
diff --git a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
index b46cb04..53370d6 100644
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -156,7 +156,7 @@ fast_ata_pio:
  */
 #define	HPT34X_PCI_INIT_REG		0x80
 
-static unsigned int __devinit init_chipset_hpt34x(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_hpt34x(struct pci_dev *dev, const char *name)
 {
 	int i = 0;
 	unsigned long hpt34xIoBase = pci_resource_start(dev, 4);
diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index e993a51..509960b 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1334,7 +1334,7 @@ static int __devinit init_hpt366(struct 
 	return 0;
 }
 
-static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
 {
 	int ret = 0;
 
diff --git a/drivers/ide/pci/it821x.c b/drivers/ide/pci/it821x.c
index e9bad18..17b8f5e 100644
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -742,7 +742,7 @@ static void __devinit it8212_disable_rai
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x20);
 }
 
-static unsigned int __devinit init_chipset_it821x(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_it821x(struct pci_dev *dev, const char *name)
 {
 	u8 conf;
 	static char *mode[2] = { "pass through", "smart" };
diff --git a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
index 6c097e8..d25a48f 100644
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -307,7 +307,7 @@ static void __devinit apple_kiwi_init(st
 }
 #endif /* CONFIG_PPC_PMAC */
 
-static unsigned int __devinit init_chipset_pdcnew(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_pdcnew(struct pci_dev *dev, const char *name)
 {
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
diff --git a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
index 184cdac..783ce6b 100644
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -481,7 +481,7 @@ static void pdc202xx_reset (ide_drive_t 
 	hwif->tuneproc(drive, 5);
 }
 
-static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev,
+static int __devinit init_chipset_pdc202xx(struct pci_dev *dev,
 							const char *name)
 {
 	/* This doesn't appear needed */
diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
index cdc3aab..3870bd1 100644
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -451,7 +451,7 @@ fast_ata_pio:
  *	out to be nice and simple
  */
  
-static unsigned int __devinit init_chipset_piix (struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_piix (struct pci_dev *dev, const char *name)
 {
         switch(dev->device) {
 		case PCI_DEVICE_ID_INTEL_82801EB_1:
diff --git a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
index ff80937..1e3a503 100644
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -394,10 +394,15 @@ static int sc1200_suspend (struct pci_de
 static int sc1200_resume (struct pci_dev *dev)
 {
 	ide_hwif_t	*hwif = NULL;
+	int rc;
+
 
 	pci_set_power_state(dev, PCI_D0);	// bring chip back from sleep state
 	dev->current_state = PM_EVENT_ON;
-	pci_enable_device(dev);
+	rc = pci_enable_device(dev);
+	if (rc)
+		return rc;
+
 	//
 	// loop over all interfaces that are part of this pci device:
 	//
diff --git a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
index 057548d..1f36656 100644
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -346,7 +346,7 @@ static int svwks_ide_dma_end (ide_drive_
 	return __ide_dma_end(drive);
 }
 
-static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
 {
 	unsigned int reg;
 	u8 btr;
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
index 697f566..cd5ca7d 100644
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -764,7 +764,7 @@ static unsigned int setup_mmio_siimage (
  *	to 133MHz clocking if the system isn't already set up to do it.
  */
 
-static unsigned int __devinit init_chipset_siimage(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_siimage(struct pci_dev *dev, const char *name)
 {
 	u32 class_rev	= 0;
 	u8 tmpbyte	= 0;
diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
index 92edf76..6b2f97e 100644
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -730,7 +730,7 @@ static int sis5513_config_xfer_rate (ide
 */
 
 /* Chip detection and general config */
-static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *host;
 	int i = 0;
diff --git a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
index 0b4b604..e006201 100644
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -385,7 +385,7 @@ static unsigned int sl82c105_bridge_revi
  * channel 0 here at least, but channel 1 has to be enabled by
  * firmware or arch code. We still set both to 16 bits mode.
  */
-static unsigned int __devinit init_chipset_sl82c105(struct pci_dev *dev, const char *msg)
+static int __devinit init_chipset_sl82c105(struct pci_dev *dev, const char *msg)
 {
 	u32 val;
 
diff --git a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
index 2af634d..8285ce1 100644
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -271,7 +271,7 @@ static struct via_isa_bridge *via_config
  *	and initialize its drive independent registers.
  */
 
-static unsigned int __devinit init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
+static int __devinit init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *isa = NULL;
 	struct via_isa_bridge *via_config;
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 9c20502..33887ab 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1233,7 +1233,7 @@ typedef struct ide_pci_device_s {
 	char			*name;
 	int			(*init_setup)(struct pci_dev *, struct ide_pci_device_s *);
 	void			(*init_setup_dma)(struct pci_dev *, struct ide_pci_device_s *, ide_hwif_t *);
-	unsigned int		(*init_chipset)(struct pci_dev *, const char *);
+	int			(*init_chipset)(struct pci_dev *, const char *);
 	void			(*init_iops)(ide_hwif_t *);
 	void                    (*init_hwif)(ide_hwif_t *);
 	void			(*init_dma)(ide_hwif_t *, unsigned long);
