Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSFOXBq>; Sat, 15 Jun 2002 19:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSFOXBp>; Sat, 15 Jun 2002 19:01:45 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:62154 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315734AbSFOXBM>; Sat, 15 Jun 2002 19:01:12 -0400
Date: Sat, 15 Jun 2002 18:00:53 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <3D0B9C6B.8050601@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0206151752300.7247-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Jeff Garzik wrote:

> > So a complete API would be
> > 
> > 	pci_request_{irq,io,mmio}
> > 	pci_release_{irq,io,mmio}
> > 	pci_enable_{irq,io,mmio}
> > 	pci_assign_{irq,io,mmio}
> > 
> > but normally a driver would just use pci_request/release_*() + maybe
> > pci_assign_irq(), which will take care of the appropriate assign/enable
> > internally.
> 
> 
> That seems like a decent enough API, pending a bit of driver conversion 
> to see how well it works out in practice.  So I'm ok with it (with the 
> pci_enable_device proviso, above)

Okay, so here's a patch which actually compiles and works here.

TODO:
o move the pci_set_power_state() before calling pci_driver::probe()
  add pci_disable_device() after pci_driver::remove()
o fix other archs.

Currently, each arch has a

	pcibios_enable_device()
	
function, which now needs to be split into

	pcibios_assign_irq()
	pcibios_enable_irq()

IO/MMIO is all taken care of by the generic code currently. (Possibly we 
need to add callbacks into arch-specific code there)

Apart from breaking each arch but i386/x86_64, the patch is ready, at 
least from my point of view ;)

--Kai


Pull from http://linux-isdn.bkbits.net/linux-2.5.pci

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.491, 2002-06-15 14:04:46-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Set pci_dev->driver before calling ::probe()
  
  That's just preparation so that we can use pci_dev->driver inside
  the probe() routine, e.g. for driver->name.

 ----------------------------------------------------------------------------
 pci-driver.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.492, 2002-06-15 15:19:22-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Introduce pci_assign_irq() and pci_enable_irq()
  
  The functions assign and route an IRQ on a PCI device, a bit inline
  docu is available in drivers/pci/pci.c
  
  Internally they call back into the arch specific
  pcibios_assign/enable_irq(), which means everything but i386/x86_64
  gets broken by this change (should be easy to fix, though).
  
  Rename the function pointer pcibios_enable_irq to pcibios_enable_irq_func
  to not clash with these functions.

 ----------------------------------------------------------------------------
 arch/i386/pci/acpi.c     |    2 -
 arch/i386/pci/common.c   |   18 +++++++++++++++-
 arch/i386/pci/irq.c      |   10 +++++----
 arch/i386/pci/pci.h      |    3 --
 arch/x86_64/pci/acpi.c   |    2 -
 arch/x86_64/pci/common.c |    5 ++++
 arch/x86_64/pci/irq.c    |   10 +++++----
 arch/x86_64/pci/pci.h    |    3 --
 drivers/pci/pci.c        |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h      |    2 +
 10 files changed, 90 insertions(+), 15 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.493, 2002-06-15 16:35:23-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Introduce wrapper to set/clear PCI command bits
  
  It'd be worth it even if we wouldn't make yet more use of it in
  the next patch.

 ----------------------------------------------------------------------------
 pci.c |   61 ++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 32 insertions(+), 29 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.494, 2002-06-15 16:38:20-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Introduce pci_assign/enable_io/mmio functions
  
  The main use of those will be internal to
  pci_request/release_io/mmio. However, we export them, since
  there'll always be hardware which needs special hacks...

 ----------------------------------------------------------------------------
 drivers/pci/pci.c   |  123 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |    7 ++
 2 files changed, 128 insertions(+), 2 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.495, 2002-06-15 17:23:10-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Add pci_request_* and pci_release_* API
  
  Docu is available inline. When switching a driver to this API,
  calling pci_enable_device() is not necessary anymore, the needed
  resources will be activated at pci_request_* time.
  
  In particular, that means if your driver only uses MMIO, IO resources
  on your card won't be assigned and enabled (it's possible that the
  BIOS did that, though).

 ----------------------------------------------------------------------------
 drivers/pci/pci.c   |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |    9 ++
 2 files changed, 196 insertions(+)

-----------------------------------------------------------------------------
ChangeSet@1.496, 2002-06-15 17:31:38-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Convert two sample drivers to new interface
  
  eepro100 and ymfpci still work fine on my laptop after the change,
  even when zeroing out their BARs during boot.

 ----------------------------------------------------------------------------
 drivers/net/eepro100.c |   83 +++++++++++++++++++++----------------------------
 sound/oss/ymfpci.c     |   45 ++++++++++----------------
 2 files changed, 54 insertions(+), 74 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================

-----------------------------------------------------------------------------
ChangeSet@1.491, 2002-06-15 14:04:46-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Set pci_dev->driver before calling ::probe()
  
  That's just preparation so that we can use pci_dev->driver inside
  the probe() routine, e.g. for driver->name.

  ---------------------------------------------------------------------------

diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Sat Jun 15 17:59:18 2002
+++ b/drivers/pci/pci-driver.c	Sat Jun 15 17:59:18 2002
@@ -48,12 +48,14 @@
 		const struct pci_device_id *id;
 
 		id = pci_match_device(drv->id_table, pci_dev);
-		if (id)
-			error = drv->probe(pci_dev, id);
-		if (error >= 0) {
+		if (id) {
 			pci_dev->driver = drv;
-			error = 0;
+			error = drv->probe(pci_dev, id);
 		}
+		if (error < 0)
+			pci_dev->driver = NULL;
+		else 
+			error = 0;
 	}
 	return error;
 }

-----------------------------------------------------------------------------
ChangeSet@1.492, 2002-06-15 15:19:22-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Introduce pci_assign_irq() and pci_enable_irq()
  
  The functions assign and route an IRQ on a PCI device, a bit inline
  docu is available in drivers/pci/pci.c
  
  Internally they call back into the arch specific
  pcibios_assign/enable_irq(), which means everything but i386/x86_64
  gets broken by this change (should be easy to fix, though).
  
  Rename the function pointer pcibios_enable_irq to pcibios_enable_irq_func
  to not clash with these functions.

  ---------------------------------------------------------------------------

diff -Nru a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
--- a/arch/i386/pci/acpi.c	Sat Jun 15 17:59:19 2002
+++ b/arch/i386/pci/acpi.c	Sat Jun 15 17:59:19 2002
@@ -13,7 +13,7 @@
 			printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
 			printk(KERN_INFO "PCI: if you experience problems, try using option 'pci=noacpi'\n");
 			pcibios_scanned++;
-			pcibios_enable_irq = acpi_pci_irq_enable;
+			pcibios_enable_irq_func = acpi_pci_irq_enable;
 		} else
 			printk(KERN_WARNING "PCI: Invalid ACPI-PCI IRQ routing table\n");
 
diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	Sat Jun 15 17:59:19 2002
+++ b/arch/i386/pci/common.c	Sat Jun 15 17:59:19 2002
@@ -209,5 +209,21 @@
 	if ((err = pcibios_enable_resources(dev)) < 0)
 		return err;
 
-	return pcibios_enable_irq(dev);
+	return pcibios_enable_irq_func(dev);
+}
+
+int pcibios_assign_irq(struct pci_dev *dev)
+{
+	return pcibios_enable_irq_func(dev);
+}
+
+/*
+ * We've done all the work in pcibios_assign_irq already. 
+ * We may want to change this later to activate the actual routing at this 
+ * point, though.
+ * It's only ever called after a successful pcibios_assign_irq()
+ */
+int pcibios_enable_irq(struct pci_dev *dev)
+{
+	return 0;
 }
diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	Sat Jun 15 17:59:19 2002
+++ b/arch/i386/pci/irq.c	Sat Jun 15 17:59:19 2002
@@ -44,7 +44,7 @@
 	int (*set)(struct pci_dev *router, struct pci_dev *dev, int pirq, int new);
 };
 
-int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
+int (*pcibios_enable_irq_func)(struct pci_dev *dev);
 
 /*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
@@ -684,11 +684,13 @@
 	return 1;
 }
 
+static int pirq_enable_irq(struct pci_dev *dev);
+
 static int __init pcibios_irq_init(void)
 {
 	DBG("PCI: IRQ init\n");
 
-	if (pcibios_enable_irq)
+	if (pcibios_enable_irq_func)
 		return 0;
 
 	pirq_table = pirq_find_routing_table();
@@ -711,7 +713,7 @@
 			pirq_table = NULL;
 	}
 
-	pcibios_enable_irq = pirq_enable_irq;
+	pcibios_enable_irq_func = pirq_enable_irq;
 
 	pcibios_fixup_irqs();
 	return 0;
@@ -794,7 +796,7 @@
 	pirq_penalty[irq] += 100;
 }
 
-int pirq_enable_irq(struct pci_dev *dev)
+static int pirq_enable_irq(struct pci_dev *dev)
 {
 	u8 pin;
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
diff -Nru a/arch/i386/pci/pci.h b/arch/i386/pci/pci.h
--- a/arch/i386/pci/pci.h	Sat Jun 15 17:59:19 2002
+++ b/arch/i386/pci/pci.h	Sat Jun 15 17:59:19 2002
@@ -70,6 +70,5 @@
 extern spinlock_t pci_config_lock;
 
 void pcibios_fixup_irqs(void);
-int pirq_enable_irq(struct pci_dev *dev);
 
-extern int (*pcibios_enable_irq)(struct pci_dev *dev);
+extern int (*pcibios_enable_irq_func)(struct pci_dev *dev);
diff -Nru a/arch/x86_64/pci/acpi.c b/arch/x86_64/pci/acpi.c
--- a/arch/x86_64/pci/acpi.c	Sat Jun 15 17:59:19 2002
+++ b/arch/x86_64/pci/acpi.c	Sat Jun 15 17:59:19 2002
@@ -13,7 +13,7 @@
 			printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
 			printk(KERN_INFO "PCI: if you experience problems, try using option 'pci=noacpi'\n");
 			pcibios_scanned++;
-			pcibios_enable_irq = acpi_pci_irq_enable;
+			pcibios_enable_irq_func = acpi_pci_irq_enable;
 		} else
 			printk(KERN_WARNING "PCI: Invalid ACPI-PCI IRQ routing table\n");
 
diff -Nru a/arch/x86_64/pci/common.c b/arch/x86_64/pci/common.c
--- a/arch/x86_64/pci/common.c	Sat Jun 15 17:59:19 2002
+++ b/arch/x86_64/pci/common.c	Sat Jun 15 17:59:19 2002
@@ -194,3 +194,8 @@
 
 	return pcibios_enable_irq(dev);
 }
+
+int pcibios_enable_irq(struct pci_dev *dev)
+{
+	return pcibios_enable_irq_func(dev);
+}
diff -Nru a/arch/x86_64/pci/irq.c b/arch/x86_64/pci/irq.c
--- a/arch/x86_64/pci/irq.c	Sat Jun 15 17:59:19 2002
+++ b/arch/x86_64/pci/irq.c	Sat Jun 15 17:59:19 2002
@@ -44,7 +44,7 @@
 	int (*set)(struct pci_dev *router, struct pci_dev *dev, int pirq, int new);
 };
 
-int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
+int (*pcibios_enable_irq_func)(struct pci_dev *dev);
 
 /*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
@@ -528,11 +528,13 @@
 	return 1;
 }
 
+static int pirq_enable_irq(struct pci_dev *dev);
+
 static int __init pcibios_irq_init(void)
 {
 	DBG("PCI: IRQ init\n");
 
-	if (pcibios_enable_irq)
+	if (pcibios_enable_irq_func)
 		return 0;
 
 	pirq_table = pirq_find_routing_table();
@@ -551,7 +553,7 @@
 			pirq_table = NULL;
 	}
 
-	pcibios_enable_irq = pirq_enable_irq;
+	pcibios_enable_irq_func = pirq_enable_irq;
 
 	pcibios_fixup_irqs();
 	return 0;
@@ -634,7 +636,7 @@
 	pirq_penalty[irq] += 100;
 }
 
-int pirq_enable_irq(struct pci_dev *dev)
+static int pirq_enable_irq(struct pci_dev *dev)
 {
 	u8 pin;
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
diff -Nru a/arch/x86_64/pci/pci.h b/arch/x86_64/pci/pci.h
--- a/arch/x86_64/pci/pci.h	Sat Jun 15 17:59:19 2002
+++ b/arch/x86_64/pci/pci.h	Sat Jun 15 17:59:19 2002
@@ -68,6 +68,5 @@
 extern spinlock_t pci_config_lock;
 
 void pcibios_fixup_irqs(void);
-int pirq_enable_irq(struct pci_dev *dev);
 
-extern int (*pcibios_enable_irq)(struct pci_dev *dev);
+extern int (*pcibios_enable_irq_func)(struct pci_dev *dev);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Sat Jun 15 17:59:19 2002
+++ b/drivers/pci/pci.c	Sat Jun 15 17:59:19 2002
@@ -555,6 +555,56 @@
 	return 0;
 }
 
+/**
+ * pci_assign_irq - Assign an IRQ to a PCI device
+ * @dev: PCI device
+ *
+ *  Figure out the the routing from the IRQ pin to an actual IRQ 
+ *  vector on the processor.
+ *  Make sure the device is in D0 state (woken up).
+ *  Returns an IRQ number (only supposed to be use for printk() or 
+ *  similar), or a negative error code.
+ */
+int
+pci_assign_irq(struct pci_dev *dev)
+{
+	int retval;
+
+	pci_set_power_state(dev, 0);
+
+	retval = pcibios_assign_irq(dev);
+	if (retval < 0)
+		return retval;
+
+	return dev->irq;
+}
+
+/**
+ * pci_enable_irq - Enable an IRQ on a PCI device
+ * @dev: PCI device
+ *
+ *  Route an IRQ pin to an actual IRQ vector on the processor.
+ *  Make sure the device is in D0 state (woken up).
+ *  Returns an IRQ number (only supposed to be use for printk() or 
+ *  similar), or a negative error code.
+ */
+int
+pci_enable_irq(struct pci_dev *dev)
+{
+	int retval;
+
+	retval = pci_assign_irq(dev);
+	if (retval < 0)
+		return retval;
+
+	retval = pcibios_enable_irq(dev);
+	if (retval < 0)
+		return retval;
+
+	return dev->irq;
+}
+
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Sat Jun 15 17:59:19 2002
+++ b/include/linux/pci.h	Sat Jun 15 17:59:19 2002
@@ -500,6 +500,8 @@
 
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *);
+int pcibios_assign_irq(struct pci_dev *dev);
+int pcibios_enable_irq(struct pci_dev *dev);
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */

-----------------------------------------------------------------------------
ChangeSet@1.493, 2002-06-15 16:35:23-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Introduce wrapper to set/clear PCI command bits
  
  It'd be worth it even if we wouldn't make yet more use of it in
  the next patch.

  ---------------------------------------------------------------------------

diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Sat Jun 15 17:59:20 2002
+++ b/drivers/pci/pci.c	Sat Jun 15 17:59:20 2002
@@ -239,6 +239,34 @@
 	return 0;
 }
 
+static void
+pci_set_command(struct pci_dev *dev, u16 mask)
+{
+	u16 cmd;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+	if ((cmd | mask) != cmd) {
+		printk(KERN_DEBUG "PCI: Enabling device %s (%04x -> %04x)\n",
+		       dev->slot_name, cmd, cmd | mask);
+		pci_write_config_word(dev, PCI_COMMAND, cmd | mask);
+	}
+}
+
+static void
+pci_clear_command(struct pci_dev *dev, u16 mask)
+{
+	u16 cmd;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+	if ((cmd & ~mask) != cmd) {
+		printk(KERN_DEBUG "PCI: Disabling device %s (%04x -> %04x)\n",
+		       dev->slot_name, cmd, cmd & ~mask);
+		pci_write_config_word(dev, PCI_COMMAND, cmd & ~mask);
+	}
+}
+
 /**
  * pci_enable_device - Initialize device before it's used by a driver.
  * @dev: PCI device to be initialized
@@ -268,13 +296,7 @@
 void
 pci_disable_device(struct pci_dev *dev)
 {
-	u16 pci_command;
-
-	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_MASTER) {
-		pci_command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
-	}
+	pci_clear_command(dev, PCI_COMMAND_MASTER);
 }
 
 /**
@@ -426,14 +448,7 @@
 void
 pci_set_master(struct pci_dev *dev)
 {
-	u16 cmd;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (! (cmd & PCI_COMMAND_MASTER)) {
-		DBG("PCI: Enabling bus mastering for device %s\n", dev->slot_name);
-		cmd |= PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
+	pci_set_command(dev, PCI_COMMAND_MASTER);
 	pcibios_set_master(dev);
 }
 
@@ -494,7 +509,6 @@
 pci_set_mwi(struct pci_dev *dev)
 {
 	int rc;
-	u16 cmd;
 
 #ifdef HAVE_ARCH_PCI_MWI
 	rc = pcibios_prep_mwi(dev);
@@ -505,12 +519,7 @@
 	if (rc)
 		return rc;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (! (cmd & PCI_COMMAND_INVALIDATE)) {
-		DBG("PCI: Enabling Mem-Wr-Inval for device %s\n", dev->slot_name);
-		cmd |= PCI_COMMAND_INVALIDATE;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
+	pci_set_command(dev, PCI_COMMAND_INVALIDATE);
 	
 	return 0;
 }
@@ -524,13 +533,7 @@
 void
 pci_clear_mwi(struct pci_dev *dev)
 {
-	u16 cmd;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (cmd & PCI_COMMAND_INVALIDATE) {
-		cmd &= ~PCI_COMMAND_INVALIDATE;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
+	pci_clear_command(dev, PCI_COMMAND_INVALIDATE);
 }
 
 int

-----------------------------------------------------------------------------
ChangeSet@1.494, 2002-06-15 16:38:20-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Introduce pci_assign/enable_io/mmio functions
  
  The main use of those will be internal to
  pci_request/release_io/mmio. However, we export them, since
  there'll always be hardware which needs special hacks...

  ---------------------------------------------------------------------------

diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Sat Jun 15 17:59:22 2002
+++ b/drivers/pci/pci.c	Sat Jun 15 17:59:22 2002
@@ -280,6 +280,13 @@
 {
 	int err;
 
+	/* FIXME: this should be turned into
+	 *   pci_enable_irq(dev);
+	 *   pci_enable_mmio(dev);
+	 *   pci_enable_io(dev);
+	 * after splitting the per arch pcibios_enable_device()
+	 * into the appropriate parts
+	 */
 	pci_set_power_state(dev, 0);
 	if ((err = pcibios_enable_device(dev)) < 0)
 		return err;
@@ -562,9 +569,9 @@
  * pci_assign_irq - Assign an IRQ to a PCI device
  * @dev: PCI device
  *
+ *  Make sure the device is in D0 state (woken up).
  *  Figure out the the routing from the IRQ pin to an actual IRQ 
  *  vector on the processor.
- *  Make sure the device is in D0 state (woken up).
  *  Returns an IRQ number (only supposed to be use for printk() or 
  *  similar), or a negative error code.
  */
@@ -586,8 +593,8 @@
  * pci_enable_irq - Enable an IRQ on a PCI device
  * @dev: PCI device
  *
- *  Route an IRQ pin to an actual IRQ vector on the processor.
  *  Make sure the device is in D0 state (woken up).
+ *  Route an IRQ pin to an actual IRQ vector on the processor.
  *  Returns an IRQ number (only supposed to be use for printk() or 
  *  similar), or a negative error code.
  */
@@ -607,6 +614,111 @@
 	return dev->irq;
 }
 
+static int
+pci_assign_resources(struct pci_dev *dev, unsigned long flags)
+{
+	int nr, retval = 0;
+	struct resource *r;
+
+	pci_set_power_state(dev, 0);
+
+	for (nr = 0; nr < PCI_ROM_RESOURCE; nr++) {
+		r = &dev->resource[nr];
+
+		/* Skip if other type */
+		if ((r->flags ^ flags) & (IORESOURCE_IO | IORESOURCE_MEM))
+			continue;
+
+		/* If unassigned, try to assign */
+		if (!r->start && r->end) {
+			retval = pci_assign_resource(dev, nr);
+			if (retval < 0)
+				break;
+		}
+	}
+	return retval;
+}
+
+/**
+ * pci_assign_mmio - Assign MMIO resources on a PCI device
+ * @dev: PCI device
+ *
+ *  Make sure the device is in D0 state (woken up).
+ *  Assign all as of yet unassigned MMIO resources for
+ *  the PCI device.
+ *  Returns 0 on success, or a negative error code.
+ */
+int
+pci_assign_mmio(struct pci_dev *dev)
+{
+	return pci_assign_resources(dev, IORESOURCE_MEM);
+}
+
+/**
+ * pci_assign_io - Assign IO resources on a PCI device
+ * @dev: PCI device
+ *
+ *  Make sure the device is in D0 state (woken up).
+ *  Assign all as of yet unassigned IO resources for
+ *  the PCI device.
+ *  Returns 0 on success, or a negative error code.
+ */
+int
+pci_assign_io(struct pci_dev *dev)
+{
+	return pci_assign_resources(dev, IORESOURCE_IO);
+}
+
+static int
+pci_enable_resources(struct pci_dev *dev, unsigned long flags)
+{
+	int retval;
+
+	retval = pci_assign_resources(dev, flags);
+	if (retval < 0)
+		return retval;
+
+	if (flags & IORESOURCE_IO)
+		pci_set_command(dev, PCI_COMMAND_IO);
+	if (flags & IORESOURCE_MEM)
+		pci_set_command(dev, PCI_COMMAND_MEMORY);
+
+	return 0;
+}
+
+/**
+ * pci_enable_mmio - Enable IO resources on a PCI device
+ * @dev: PCI device
+ *
+ *  Make sure the device is in D0 state (woken up).
+ *  Assign all as of yet unassigned IO resources for
+ *  the PCI device.
+ *  Enable MMIO in the PCI COMMAND config word
+ *  Returns 0 on success, or a negative error code.
+ */
+int
+pci_enable_mmio(struct pci_dev *dev)
+{
+	return pci_enable_resources(dev, IORESOURCE_MEM);
+}
+
+/**
+ * pci_enable_io - Enable IO resources on a PCI device
+ * @dev: PCI device
+ *
+ *  Make sure the device is in D0 state (woken up).
+ *  Assign all as of yet unassigned IO resources for
+ *  the PCI device.
+ *  Enable IO in the PCI COMMAND config word
+ *  Returns 0 on success, or a negative error code.
+ */
+int
+pci_enable_io(struct pci_dev *dev)
+{
+	return pci_enable_resources(dev, IORESOURCE_IO);
+}
+
+
 
 static int __devinit pci_init(void)
 {
@@ -654,6 +766,13 @@
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_enable_wake);
+
+EXPORT_SYMBOL(pci_assign_irq);
+EXPORT_SYMBOL(pci_assign_mmio);
+EXPORT_SYMBOL(pci_assign_io);
+EXPORT_SYMBOL(pci_enable_irq);
+EXPORT_SYMBOL(pci_enable_mmio);
+EXPORT_SYMBOL(pci_enable_io);
 
 /* Obsolete functions */
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Sat Jun 15 17:59:22 2002
+++ b/include/linux/pci.h	Sat Jun 15 17:59:22 2002
@@ -576,6 +576,13 @@
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
+int pci_assign_irq(struct pci_dev *dev);
+int pci_enable_irq(struct pci_dev *dev);
+int pci_assign_mmio(struct pci_dev *dev);
+int pci_assign_io(struct pci_dev *dev);
+int pci_enable_mmio(struct pci_dev *dev);
+int pci_enable_io(struct pci_dev *dev);
+
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);
 int pci_restore_state(struct pci_dev *dev, u32 *buffer);

-----------------------------------------------------------------------------
ChangeSet@1.495, 2002-06-15 17:23:10-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Add pci_request_* and pci_release_* API
  
  Docu is available inline. When switching a driver to this API,
  calling pci_enable_device() is not necessary anymore, the needed
  resources will be activated at pci_request_* time.
  
  In particular, that means if your driver only uses MMIO, IO resources
  on your card won't be assigned and enabled (it's possible that the
  BIOS did that, though).

  ---------------------------------------------------------------------------

diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Sat Jun 15 17:59:23 2002
+++ b/drivers/pci/pci.c	Sat Jun 15 17:59:23 2002
@@ -614,6 +614,57 @@
 	return dev->irq;
 }
 
+/**
+ * pci_request_irq - Register an interrupt handler for a PCI device
+ * @dev: PCI device
+ * @handler: Function to be called when the IRQ occurs
+ * @irqflags: Interrupt type flags
+ * @dev_id: A cookie passed back to the handler function
+ *
+ *  Make sure the device is in D0 state (woken up).
+ *  Route an IRQ pin to an actual IRQ vector on the processor.
+ *  Register a handler for this IRQ vector.
+ *  Returns an IRQ number (only supposed to be use for printk() or 
+ *  similar), or a negative error code.
+ */
+int
+pci_request_irq(struct pci_dev *dev,
+		void (*handler)(int, void *, struct pt_regs *),
+		unsigned long flags, void *dev_id)
+{
+	int retval;
+
+	BUG_ON(!(flags & SA_SHIRQ));
+
+	retval = pcibios_assign_irq(dev);
+	if (retval < 0)
+		return retval;
+
+	retval = request_irq(dev->irq, handler, flags, dev->slot_name, dev_id);
+	if (retval < 0)
+		return retval;
+	
+	retval = pcibios_enable_irq(dev);
+	if (retval < 0)
+		free_irq(dev->irq, dev_id);
+
+	return retval;
+}
+
+/**
+ * pci_release_irq - Unregister an interrupt handler for a PCI device
+ * @dev: PCI device
+ * @dev_id: Same cookie you passed when calling pci_request_irq()
+ *
+ *  Unregister an IRQ handler previously registered with
+ *  pci_request_irq().
+ */
+void
+pci_release_irq(struct pci_dev *dev, void *dev_id)
+{
+	free_irq(dev->irq, dev_id);
+}
+
 static int
 pci_assign_resources(struct pci_dev *dev, unsigned long flags)
 {
@@ -718,7 +769,136 @@
 	return pci_enable_resources(dev, IORESOURCE_IO);
 }
 
+static unsigned long
+pci_request_resources(struct pci_dev *pdev, unsigned int nr,
+		      unsigned long flags, struct resource *root)
+{
+	struct pci_driver *drv = pci_dev_driver(pdev);
+	char *drv_name = drv ? drv->name : "unknown";
+	struct resource *res;
+
+	BUG_ON(nr >= PCI_ROM_RESOURCE);
+
+	/* Make sure we have the right type (IO/MMIO) */
+	if ((pci_resource_flags(pdev, nr) ^ flags) & 
+	    (IORESOURCE_IO | IORESOURCE_MEM))
+		goto err;
+
+	/* Assign and enable all resources of this type */
+	pci_enable_resources(pdev, flags);
+
+	res = __request_region(root, pci_resource_start(pdev, nr), 
+			       pci_resource_len(pdev, nr), drv_name);
+	if (!res)
+		goto err;
+
+	return res->start;
+
+ err:
+	/* Print extensive info so that drivers don't have to do it
+	   themselves */
+	printk(KERN_INFO
+		   "%s: failed to get %s(%d) for %s, %#lx-%#lx flags %#lx.\n",
+		   pdev->slot_name, (flags == IORESOURCE_IO ? "IO" : "MMIO"),
+		   nr, drv_name,
+		   pci_resource_start(pdev, nr),
+		   pci_resource_flags(pdev, nr),
+		   pci_resource_end(pdev, nr));
 
+	return 0;
+}
+
+/**
+ * pci_request_mmio - Register a MMIO region on a PCI device
+ * @dev: PCI device
+ * @nr:  The index of the Base Address Register (BAR)
+ *
+ *  Make sure the device is in D0 state (woken up).
+ *  Assign all as of yet unassigned MMIO resources for
+ *  the PCI device.
+ *  Enable MMIO in the PCI COMMAND config word
+ *  Register the requested MMIO region with the kernel
+ *  resource management.
+ *  Map the MMIO region.
+ *  Returns a cookie to be used with the MMIO functions
+ *  (readb, writeb, ...), or NULL on error.
+ *  In case of failure it also printk's extensive information
+ *  about what went wrong (so you don't need to do that in your
+ *  driver)
+ */
+void *
+pci_request_mmio(struct pci_dev *pdev, unsigned int nr)
+{
+	unsigned long base;
+	void *addr;
+
+	base = pci_request_resources(pdev, nr, IORESOURCE_MEM, &iomem_resource);
+	if (!base)
+		return 0;
+
+	addr = ioremap(base, pci_resource_len(pdev, nr));
+	if (!addr)
+		release_region(base, pci_resource_len(pdev, nr));
+
+	return addr;
+}
+
+/**
+ * pci_request_io - Register an IO region on a PCI device
+ * @dev: PCI device
+ * @nr:  The index of the Base Address Register (BAR)
+ *
+ *  Make sure the device is in D0 state (woken up).
+ *  Assign all as of yet unassigned IO resources for
+ *  the PCI device.
+ *  Enable IO in the PCI COMMAND config word
+ *  Register the requested IO region with the kernel
+ *  resource management.
+ *  Returns an IO port to be used with the IO functions
+ *  (inb, outb, ...), or 0 on error.
+ *  In case of failure it also printk's extensive information
+ *  about what went wrong (so you don't need to do that in your
+ *  driver)
+ */
+unsigned long
+pci_request_io(struct pci_dev *dev, unsigned int nr)
+{
+	return pci_request_resources(dev, nr, IORESOURCE_IO, &ioport_resource);
+}
+
+/**
+ * pci_release_mmio - Release an MMIO region on a PCI device
+ * @dev:  PCI device
+ * @nr:   The index of the Base Address Register (BAR)
+ * @addr: The cookie returned from pci_request_mmio()
+ *
+ *  Unmaps and unregisters a MMIO region previously
+ *  registered by pci_request_mmio().
+ */
+void
+pci_release_mmio(struct pci_dev *dev, unsigned int nr, void *addr)
+{
+	iounmap(addr);
+	__release_region(&iomem_resource,
+			 pci_resource_start(dev, nr), 
+			 pci_resource_len(dev, nr));
+}
+
+/**
+ * pci_release_io - Release an IO region on a PCI device
+ * @dev:  PCI device
+ * @nr:   The index of the Base Address Register (BAR)
+ *
+ *  Unregisters an IO region previously registered by 
+ *  pci_request_io().
+ */
+void
+pci_release_io(struct pci_dev *dev, unsigned int nr)
+{
+	__release_region(&ioport_resource,
+			 pci_resource_start(dev, nr), 
+			 pci_resource_len(dev, nr));
+}
 
 static int __devinit pci_init(void)
 {
@@ -766,6 +946,13 @@
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_enable_wake);
+
+EXPORT_SYMBOL(pci_request_irq);
+EXPORT_SYMBOL(pci_request_mmio);
+EXPORT_SYMBOL(pci_request_io);
+EXPORT_SYMBOL(pci_release_irq);
+EXPORT_SYMBOL(pci_release_mmio);
+EXPORT_SYMBOL(pci_release_io);
 
 EXPORT_SYMBOL(pci_assign_irq);
 EXPORT_SYMBOL(pci_assign_mmio);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Sat Jun 15 17:59:23 2002
+++ b/include/linux/pci.h	Sat Jun 15 17:59:23 2002
@@ -576,6 +576,15 @@
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
+int pci_request_irq(struct pci_dev *dev,
+		    void (*handler)(int, void *, struct pt_regs *),
+		    unsigned long flags, void *dev_id);
+void *pci_request_mmio(struct pci_dev *pdev, unsigned int nr);
+unsigned long pci_request_io(struct pci_dev *dev, unsigned int nr);
+void pci_release_irq(struct pci_dev *dev, void *dev_id);
+void pci_release_mmio(struct pci_dev *dev, unsigned int nr, void *addr);
+void pci_release_io(struct pci_dev *dev, unsigned int nr);
+
 int pci_assign_irq(struct pci_dev *dev);
 int pci_enable_irq(struct pci_dev *dev);
 int pci_assign_mmio(struct pci_dev *dev);

-----------------------------------------------------------------------------
ChangeSet@1.496, 2002-06-15 17:31:38-05:00, kai@tp1.ruhr-uni-bochum.de
  PCI: Convert two sample drivers to new interface
  
  eepro100 and ymfpci still work fine on my laptop after the change,
  even when zeroing out their BARs during boot.

  ---------------------------------------------------------------------------

diff -Nru a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	Sat Jun 15 17:59:24 2002
+++ b/drivers/net/eepro100.c	Sat Jun 15 17:59:24 2002
@@ -558,6 +558,7 @@
 static int __devinit eepro100_init_one (struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
+	u16 cmd;
 	unsigned long ioaddr;
 	int irq;
 	int acpi_idle_state = 0, pm;
@@ -567,65 +568,55 @@
 	if (speedo_debug > 0  &&  did_version++ == 0)
 		printk(version);
 
-	/* save power state before pci_enable_device overwrites it */
+	/* save power state before pci_request_* overwrites it */
 	pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
 	if (pm) {
 		u16 pwr_command;
 		pci_read_config_word(pdev, pm + PCI_PM_CTRL, &pwr_command);
 		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
 	}
-
-	if (pci_enable_device(pdev))
-		goto err_out_free_mmio_region;
-
-	pci_set_master(pdev);
-
-	if (!request_region(pci_resource_start(pdev, 1),
-			pci_resource_len(pdev, 1), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
+	irq = pci_assign_irq(pdev);
+	if (irq < 0)
 		goto err_out_none;
-	}
-	if (!request_mem_region(pci_resource_start(pdev, 0),
-			pci_resource_len(pdev, 0), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
-		goto err_out_free_pio_region;
-	}
 
-	irq = pdev->irq;
 #ifdef USE_IO
-	ioaddr = pci_resource_start(pdev, 1);
+	ioaddr = pci_request_io(pdev, 1);
+	if (!ioaddr)
+		goto err_out_none;
+
 	if (speedo_debug > 2)
-		printk("Found Intel i82557 PCI Speedo at I/O %#lx, IRQ %d.\n",
+		printk("Found Intel i82557 PCI Speedo at I/O %#lx IRQ %d.\n",
 			   ioaddr, irq);
 #else
-	ioaddr = (unsigned long)ioremap(pci_resource_start(pdev, 0),
-									pci_resource_len(pdev, 0));
-	if (!ioaddr) {
-		printk (KERN_ERR "eepro100: cannot remap MMIO region %lx @ %lx\n",
-				pci_resource_len(pdev, 0), pci_resource_start(pdev, 0));
-		goto err_out_free_mmio_region;
-	}
+	/* Even if using MMIO, the hardware won't work 
+	   unless IO is enabled, too */
+	if (pci_enable_io(pdev) < 0)
+		goto err_out_none;
+
+	ioaddr = (unsigned long) pci_request_mmio(pdev, 0);
+	if (!ioaddr)
+		goto err_out_none;
+
 	if (speedo_debug > 2)
-		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx, IRQ %d.\n",
+		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx IRQ %d.\n",
 			   pci_resource_start(pdev, 0), irq);
 #endif
-
+	pci_set_master(pdev);
 
 	if (speedo_found1(pdev, ioaddr, cards_found, acpi_idle_state) == 0)
 		cards_found++;
 	else
-		goto err_out_iounmap;
+		goto err_out_disable;
 
 	return 0;
 
-err_out_iounmap: ;
-#ifndef USE_IO
-	iounmap ((void *)ioaddr);
+ err_out_disable:
+	pci_disable_device(pdev);
+#ifdef USE_IO
+	pci_release_io(pdev, 1);
+#else
+	pci_release_mmio(pdev, 0, (void *)ioaddr);
 #endif
-err_out_free_mmio_region:
-	release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
-err_out_free_pio_region:
-	release_region(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
 err_out_none:
 	return -ENODEV;
 }
@@ -803,7 +794,6 @@
 	pci_set_drvdata (pdev, dev);
 
 	dev->base_addr = ioaddr;
-	dev->irq = pdev->irq;
 
 	sp = dev->priv;
 	sp->pdev = pdev;
@@ -924,7 +914,7 @@
 	int retval;
 
 	if (speedo_debug > 1)
-		printk(KERN_DEBUG "%s: speedo_open() irq %d.\n", dev->name, dev->irq);
+		printk(KERN_DEBUG "%s: speedo_open()\n", dev->name);
 
 	MOD_INC_USE_COUNT;
 
@@ -939,11 +929,12 @@
 	sp->in_interrupt = 0;
 
 	/* .. we can safely take handler calls during init. */
-	retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ, dev->name, dev);
-	if (retval) {
+	retval = pci_request_irq(sp->pdev, &speedo_interrupt, SA_SHIRQ, dev);
+	if (retval < 0) {
 		MOD_DEC_USE_COUNT;
 		return retval;
 	}
+	dev->irq = retval;
 
 	dev->if_port = sp->default_port;
 
@@ -1834,7 +1825,7 @@
 	/* Shutting down the chip nicely fails to disable flow control. So.. */
 	outl(PortPartialReset, ioaddr + SCBPort);
 
-	free_irq(dev->irq, dev);
+	pci_release_irq(sp->pdev, dev);
 
 	/* Print a few items for debugging. */
 	if (speedo_debug > 3)
@@ -2253,11 +2244,10 @@
 	
 	unregister_netdev(dev);
 
-	release_region(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
-	release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
-
-#ifndef USE_IO
-	iounmap((char *)dev->base_addr);
+#ifdef USE_IO
+	pci_release_io(pdev, 1);
+#else
+	pci_release_mmio(pdev, 0, (void *) dev->base_addr);
 #endif
 
 	pci_free_consistent(pdev, TX_RING_SIZE * sizeof(struct TxFD)
@@ -2348,7 +2338,6 @@
 
 /*
  * Local variables:
- *  compile-command: "gcc -DMODULE -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -c eepro100.c `[ -f /usr/include/linux/modversions.h ] && echo -DMODVERSIONS`"
  *  c-indent-level: 4
  *  c-basic-offset: 4
  *  tab-width: 4
diff -Nru a/sound/oss/ymfpci.c b/sound/oss/ymfpci.c
--- a/sound/oss/ymfpci.c	Sat Jun 15 17:59:24 2002
+++ b/sound/oss/ymfpci.c	Sat Jun 15 17:59:24 2002
@@ -2496,16 +2496,15 @@
 static int __devinit ymf_probe_one(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
 	u16 ctrl;
-	unsigned long base;
 	ymfpci_t *codec;
+	int irq, err;
 
-	int err;
-
+#if 0
 	if ((err = pci_enable_device(pcidev)) != 0) {
 		printk(KERN_ERR "ymfpci: pci_enable_device failed\n");
 		return err;
 	}
-	base = pci_resource_start(pcidev, 0);
+#endif
 
 	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "ymfpci: no core\n");
@@ -2520,25 +2519,16 @@
 	codec->pci = pcidev;
 
 	pci_read_config_byte(pcidev, PCI_REVISION_ID, &codec->rev);
-
-	if (request_mem_region(base, 0x8000, "ymfpci") == NULL) {
-		printk(KERN_ERR "ymfpci: unable to request mem region\n");
+	
+	codec->reg_area_virt = pci_request_mmio(pcidev, 0);
+	if (!codec->reg_area_virt)
 		goto out_free;
-	}
-
-	if ((codec->reg_area_virt = ioremap(base, 0x8000)) == NULL) {
-		printk(KERN_ERR "ymfpci: unable to map registers\n");
-		goto out_release_region;
-	}
 
 	pci_set_master(pcidev);
 
-	printk(KERN_INFO "ymfpci: %s at 0x%lx IRQ %d\n",
-	    (char *)ent->driver_data, base, pcidev->irq);
-
 	ymfpci_aclink_reset(pcidev);
 	if (ymfpci_codec_ready(codec, 0, 1) < 0)
-		goto out_unmap;
+		goto out_release_mmio;
 
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
 	if (assigned == 0) {
@@ -2556,16 +2546,16 @@
 		goto out_disable_dsp;
 	ymf_memload(codec);
 
-	if (request_irq(pcidev->irq, ymf_interrupt, SA_SHIRQ, "ymfpci", codec) != 0) {
-		printk(KERN_ERR "ymfpci: unable to request IRQ %d\n",
-		    pcidev->irq);
+	irq = pci_request_irq(pcidev, ymf_interrupt, SA_SHIRQ, codec);
+	if (irq < 0) {
+		printk(KERN_ERR "ymfpci: unable to request IRQ %d\n", irq);
 		goto out_memfree;
 	}
 
 	/* register /dev/dsp */
 	if ((codec->dev_audio = register_sound_dsp(&ymf_fops, -1)) < 0) {
 		printk(KERN_ERR "ymfpci: unable to register dsp\n");
-		goto out_free_irq;
+		goto out_release_irq;
 	}
 
 	/*
@@ -2591,6 +2581,9 @@
 	}
 #endif /* CONFIG_SOUND_YMFPCI_LEGACY */
 
+	printk(KERN_INFO "ymfpci: %s at 0x%lx IRQ %d\n",
+	       (char *)ent->driver_data, pci_resource_start(pcidev, 0), irq);
+
 	/* put it into driver list */
 	list_add_tail(&codec->ymf_devs, &ymf_devs);
 	pci_set_drvdata(pcidev, codec);
@@ -2599,8 +2592,8 @@
 
  out_unregister_sound_dsp:
 	unregister_sound_dsp(codec->dev_audio);
- out_free_irq:
-	free_irq(pcidev->irq, codec);
+ out_release_irq:
+	pci_release_irq(pcidev, codec);
  out_memfree:
 	ymfpci_memfree(codec);
  out_disable_dsp:
@@ -2608,10 +2601,8 @@
 	ctrl = ymfpci_readw(codec, YDSXGR_GLOBALCTRL);
 	ymfpci_writew(codec, YDSXGR_GLOBALCTRL, ctrl & ~0x0007);
 	ymfpci_writel(codec, YDSXGR_STATUS, ~0);
- out_unmap:
-	iounmap(codec->reg_area_virt);
- out_release_region:
-	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
+ out_release_mmio:
+	pci_release_mmio(pcidev, 0, codec->reg_area_virt);
  out_free:
 	kfree(codec);
 	return -ENODEV;


