Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSFNX0F>; Fri, 14 Jun 2002 19:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSFNX0F>; Fri, 14 Jun 2002 19:26:05 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:11975 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S312973AbSFNX0B>; Fri, 14 Jun 2002 19:26:01 -0400
Date: Fri, 14 Jun 2002 18:25:15 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <3D0A449C.5030304@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0206141803260.31514-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002, Jeff Garzik wrote:

> We already have pci_request_regions() and currently PCI drivers should 
> use that.

I have to admit I wasn't aware of that. It doesn't really help with the 
problem which started this thread, though.

> Auto-ioremap would be bad, though... you would wind up wasting address 
> space for any case where MMIO areas are not 100% utilized (like network 
> cards that require use of PIO due to hardware bugs, but still export an 
> MMIO region for their NIC registers)

auto-ioremap would be bad for pci_request_regions(), which just blindly 
allocates all regions. Let's show an example of what I was thinking about, 
though.

This is eepro100.c::eepro100_init_one() after the conversion
- IMO it looks a lot simpler than the old code.

--------------------------------------------------------------
#ifdef USE_IO
	ioaddr = pci_request_io(pdev, 1);
	if (!ioaddr)
		goto err_out_none;

	if (speedo_debug > 2)
		printk("Found Intel i82557 PCI Speedo at I/O %#lx.\n", ioaddr);
#else
	ioaddr = (unsigned long) pci_request_mmio(pdev, 0);
	if (!ioaddr)
		goto err_out_none;

	if (speedo_debug > 2)
		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx.\n",
			   pci_resource_start(pdev, 0));
#endif
	if (speedo_found1(pdev, ioaddr, cards_found, acpi_idle_state) == 0)
		cards_found++;
	else
		goto err_out_release;

	return 0;

err_out_release:
#ifdef USE_IO
	pci_release_io(pdev, 1);
#else
	pci_release_mmio(pdev, 0, (void *)ioaddr);
#endif
err_out_none:
	return -ENODEV;
--------------------------------------------------------------

We only request the regions we're going to use, so the others may even 
stay unassigned and disabled.

So my idea looks something like this:

	unsigned long
	pci_request_io(struct pci_dev *pdev, int nr);

	void *
	pci_request_mmio(struct pci_dev *pdev, int nr);

	void 
	pci_release_io(struct pci_dev *pdev, int nr);

	void 
	pci_release_mmio(struct pci_dev *pdev, int nr, void *addr);

	int 
	pci_request_irq(struct pci_dev *pdev,
			void (*handler)(int, void *, struct pt_regs *),
		        unsigned long flags, const char *name, void *dev);

	void 
	pci_release_irq(struct pci_dev *pdev, void *dev);

These functions return directly what we need: an address for 
in/out[bwl], a cookie for read/write[bwl] - well, and the irq
which however is only for informational purposes.

It probably makes sense to split the pci_request_irq() into 
pci_assign_irq() and pci_request_irq(), since we want to delay the
pci_request_irq() until we really need it.

The advantages are:
o saves the ioremap etc.
o tells the PCI layer explicitly which resources we use, so
  it doesn't have to take the all or nothing pci_enable_device()/
  pci_request_resources() approach
o adds appropriate printk(KERN_INFO) when request_region etc fails,
  saving thousands of places where we need do the printk() by hand,
  and fixing the other thousands of places where we don't printk() so the
  user has no idea why the driver wouldn't load.

I deliberately deviated a bit from the normal syntax
(region -> io, mem_region -> mmio, free_irq -> release_irq), for one
reason since I find it more logical this way, but also because the API is
somewhat different, so it shouldn't just appear to be the same - the 
difference being e.g. that the old API needed the explicit 
pci_enable_device(), whereas that should not be used in the new one.

A very early patch is appended, totally untested, though - I chose
eepro100 since I have that in my laptop, but I don't have my laptop here.

Some parts of the implementation are not as clean as they could be since I 
didn't want to muck with the internals of the PCI layer too much - some 
cleanup there wouldn't hurt, though.

--Kai

===== arch/i386/pci/i386.c 1.10 vs edited =====
--- 1.10/arch/i386/pci/i386.c	Wed May  8 18:10:45 2002
+++ edited/arch/i386/pci/i386.c	Fri Jun 14 17:23:28 2002
@@ -243,16 +243,15 @@
 	pcibios_assign_resources();
 }
 
-int pcibios_enable_resources(struct pci_dev *dev)
+int pcibios_enable_resource(struct pci_dev *dev, int nr)
 {
+	struct resource *r = &dev->resource(nr);
 	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
-		r = &dev->resource[idx];
+	
+	if (nr != PCI_ROM_RESOURCE) {
 		if (!r->start && r->end) {
 			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", dev->slot_name);
 			return -EINVAL;
@@ -261,13 +260,21 @@
 			cmd |= PCI_COMMAND_IO;
 		if (r->flags & IORESOURCE_MEM)
 			cmd |= PCI_COMMAND_MEMORY;
+	} else {
+		if (r->start)
+			cmd |= PCI_COMMAND_MEMORY;
 	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
 	if (cmd != old_cmd) {
 		printk("PCI: Enabling device %s (%04x -> %04x)\n", dev->slot_name, old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
+}
+
+int pcibios_enable_resources(struct pci_dev *dev)
+{
+	for(idx = 0; idx <= PCI_ROM_RESOURCE; idx++)
+		pcibios_enable_resource(dev, idx);
+
 	return 0;
 }
 
===== drivers/net/eepro100.c 1.32 vs edited =====
--- 1.32/drivers/net/eepro100.c	Thu May 30 01:18:19 2002
+++ edited/drivers/net/eepro100.c	Fri Jun 14 18:05:35 2002
@@ -559,7 +559,6 @@
 		const struct pci_device_id *ent)
 {
 	unsigned long ioaddr;
-	int irq;
 	int acpi_idle_state = 0, pm;
 	static int cards_found /* = 0 */;
 
@@ -575,57 +574,37 @@
 		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
 	}
 
-	if (pci_enable_device(pdev))
-		goto err_out_free_mmio_region;
-
 	pci_set_master(pdev);
 
-	if (!request_region(pci_resource_start(pdev, 1),
-			pci_resource_len(pdev, 1), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
+#ifdef USE_IO
+	ioaddr = pci_request_io(pdev, 1);
+	if (!ioaddr)
 		goto err_out_none;
-	}
-	if (!request_mem_region(pci_resource_start(pdev, 0),
-			pci_resource_len(pdev, 0), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
-		goto err_out_free_pio_region;
-	}
 
-	irq = pdev->irq;
-#ifdef USE_IO
-	ioaddr = pci_resource_start(pdev, 1);
 	if (speedo_debug > 2)
-		printk("Found Intel i82557 PCI Speedo at I/O %#lx, IRQ %d.\n",
-			   ioaddr, irq);
+		printk("Found Intel i82557 PCI Speedo at I/O %#lx.\n", ioaddr);
 #else
-	ioaddr = (unsigned long)ioremap(pci_resource_start(pdev, 0),
-									pci_resource_len(pdev, 0));
-	if (!ioaddr) {
-		printk (KERN_ERR "eepro100: cannot remap MMIO region %lx @ %lx\n",
-				pci_resource_len(pdev, 0), pci_resource_start(pdev, 0));
-		goto err_out_free_mmio_region;
-	}
+	ioaddr = (unsigned long) pci_request_mmio(pdev, 0);
+	if (!ioaddr)
+		goto err_out_none;
+
 	if (speedo_debug > 2)
-		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx, IRQ %d.\n",
-			   pci_resource_start(pdev, 0), irq);
+		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx.\n",
+			   pci_resource_start(pdev, 0));
 #endif
-
-
 	if (speedo_found1(pdev, ioaddr, cards_found, acpi_idle_state) == 0)
 		cards_found++;
 	else
-		goto err_out_iounmap;
+		goto err_out_release;
 
 	return 0;
 
-err_out_iounmap: ;
-#ifndef USE_IO
-	iounmap ((void *)ioaddr);
+err_out_release:
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
@@ -803,7 +782,6 @@
 	pci_set_drvdata (pdev, dev);
 
 	dev->base_addr = ioaddr;
-	dev->irq = pdev->irq;
 
 	sp = dev->priv;
 	sp->pdev = pdev;
@@ -924,7 +902,7 @@
 	int retval;
 
 	if (speedo_debug > 1)
-		printk(KERN_DEBUG "%s: speedo_open() irq %d.\n", dev->name, dev->irq);
+		printk(KERN_DEBUG "%s: speedo_open()\n", dev->name);
 
 	MOD_INC_USE_COUNT;
 
@@ -939,11 +917,12 @@
 	sp->in_interrupt = 0;
 
 	/* .. we can safely take handler calls during init. */
-	retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = pci_request_irq(sp->pdev, &speedo_interrupt, SA_SHIRQ, dev->name, dev);
 	if (retval) {
 		MOD_DEC_USE_COUNT;
 		return retval;
 	}
+	dev->irq = retval;
 
 	dev->if_port = sp->default_port;
 
@@ -1834,7 +1813,7 @@
 	/* Shutting down the chip nicely fails to disable flow control. So.. */
 	outl(PortPartialReset, ioaddr + SCBPort);
 
-	free_irq(dev->irq, dev);
+	pci_release_irq(sp->pdev, dev);
 
 	/* Print a few items for debugging. */
 	if (speedo_debug > 3)
@@ -2253,11 +2232,12 @@
 	
 	unregister_netdev(dev);
 
-	release_region(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
 	release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 
-#ifndef USE_IO
-	iounmap((char *)dev->base_addr);
+#ifdef USE_IO
+	pci_release_io(pdev, 1);
+#else
+	pci_release_mmio(pdev, 0, (void *) dev->base_addr);
 #endif
 
 	pci_free_consistent(pdev, TX_RING_SIZE * sizeof(struct TxFD)
@@ -2348,7 +2328,6 @@
 
 /*
  * Local variables:
- *  compile-command: "gcc -DMODULE -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -c eepro100.c `[ -f /usr/include/linux/modversions.h ] && echo -DMODVERSIONS`"
  *  c-indent-level: 4
  *  c-basic-offset: 4
  *  tab-width: 4
===== drivers/pci/pci.c 1.44 vs edited =====
--- 1.44/drivers/pci/pci.c	Wed May  8 18:10:45 2002
+++ edited/drivers/pci/pci.c	Fri Jun 14 17:54:07 2002
@@ -555,6 +555,112 @@
 	return 0;
 }
 
+#define IORESOURCE_IO_MEM (IORESOURCE_IO | IORESOURCE_MEM)
+
+unsigned long
+__pci_request_region(struct pci_dev *pdev, int nr, unsigned long flags,
+					 struct resource *root)
+{
+	struct pci_driver *drv = pci_dev_driver(pdev);
+	char *drv_name = drv ? drv->name : "unknown";
+	struct resource *res;
+
+	/* Make sure we have the right type (IO/MMIO) */
+	if ((pci_resource_flags(pdev, nr) ^ flags) & IORESOURCE_IO_MEM)
+		goto err;
+
+	/* If no resource has been assigned yet, try to do it now */
+	if (!pci_resource_start(pdev, nr) && pci_resource_end(pdev, nr))
+		if (pci_assign_resource(pdev, nr) < 0)
+			goto err;
+
+	/* Enable the resource (unless already done) */
+	pcibios_enable_resource(pdev, nr);
+
+	res = __request_region(root, pci_resource_start(pdev, nr), 
+			       pci_resource_len(pdev, nr), drv_name);
+	if (!res)
+		goto err;
+
+	return res->start;
+
+ err:
+	printk(KERN_INFO
+		   "%s: failed to get %s(%d) for %s, %#lx-%#lx flags %#lx.\n",
+		   pdev->slot_name, (flags == IORESOURCE_IO ? "IO" : "MMIO"),
+		   nr, drv_name,
+		   pci_resource_start(pdev, nr),
+		   pci_resource_flags(pdev, nr),
+		   pci_resource_end(pdev, nr));
+
+	return 0;
+}
+
+unsigned long
+pci_request_io(struct pci_dev *pdev, int nr)
+{
+	return __pci_request_region(pdev, nr, IORESOURCE_IO, &ioport_resource);
+}
+
+void *
+pci_request_mmio(struct pci_dev *pdev, int nr)
+{
+	unsigned long base;
+	void *addr;
+
+	base = __pci_request_region(pdev, nr, IORESOURCE_MEM, &iomem_resource);
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
+void
+pci_release_io(struct pci_dev *pdev, int nr)
+{
+	__release_region(&ioport_resource,
+			 pci_resource_start(pdev, nr), 
+			 pci_resource_len(pdev, nr));
+}
+
+void
+pci_release_mmio(struct pci_dev *pdev, int nr, void *addr)
+{
+	iounmap(addr);
+	__release_region(&iomem_resource,
+			 pci_resource_start(pdev, nr), 
+			 pci_resource_len(pdev, nr));
+}
+
+int
+pci_request_irq(struct pci_dev *pdev,
+		void (*handler)(int, void *, struct pt_regs *),
+		unsigned long flags, const char *name, void *dev)
+{
+	int irq, retval;
+
+	pcibios_enable_irq(pdev);
+	irq = pdev->irq;
+
+	retval = request_irq(irq, handler, flags, name, dev);
+	if (retval < 0)
+		return retval;
+
+	return irq;
+}
+
+void
+pci_release_irq(struct pci_dev *pdev, void *dev)
+{
+	free_irq(pdev->irq, dev);
+}
+
+
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev;
@@ -601,6 +707,13 @@
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_enable_wake);
+
+EXPORT_SYMBOL(pci_request_io);
+EXPORT_SYMBOL(pci_request_mmio);
+EXPORT_SYMBOL(pci_release_io);
+EXPORT_SYMBOL(pci_release_mmio);
+EXPORT_SYMBOL(pci_request_irq);
+EXPORT_SYMBOL(pci_release_irq);
 
 /* Obsolete functions */
 
===== include/linux/pci.h 1.32 vs edited =====
--- 1.32/include/linux/pci.h	Tue May 28 20:02:33 2002
+++ edited/include/linux/pci.h	Fri Jun 14 17:56:28 2002
@@ -580,6 +580,16 @@
 int pci_set_power_state(struct pci_dev *dev, int state);
 int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
 
+/* New resource management */
+unsigned long pci_request_io(struct pci_dev *pdev, int nr);
+void *pci_request_mmio(struct pci_dev *pdev, int nr);
+void pci_release_io(struct pci_dev *pdev, int nr);
+void pci_release_mmio(struct pci_dev *pdev, int nr, void *addr);
+int pci_request_irq(struct pci_dev *pdev,
+		    void (*handler)(int, void *, struct pt_regs *),
+		    unsigned long flags, const char *name, void *dev);
+void pci_release_irq(struct pci_dev *pdev, void *dev);
+
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 
 int pci_claim_resource(struct pci_dev *, int);

