Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135591AbRDSI0M>; Thu, 19 Apr 2001 04:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135592AbRDSI0H>; Thu, 19 Apr 2001 04:26:07 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29877 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135591AbRDSIZu>;
	Thu, 19 Apr 2001 04:25:50 -0400
Message-ID: <3ADEA108.50BB415D@mandrakesoft.com>
Date: Thu, 19 Apr 2001 04:25:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com>, mj@ucw.cz,
        andre@linux-ide.org
Subject: PCI power management
In-Reply-To: <Pine.LNX.4.10.10104181150530.7690-100000@nobelium.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------1BF3BCC7D191700823767A5F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1BF3BCC7D191700823767A5F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This was originally a private reply to Patrick Mochel, but the e-mail
kept getting longer and longer :)


The current state of PCI PM is this:

pci_enable_device (1) enables IO and mem decoding, (2) assigns/routes
the PCI IRQ, and (3) brings the device to D0 using pci_set_power_state. 
Linus believes the power state transition should occur before (1) and
(2), and I agree.

pci_set_power_state brings a device to a new D state.  If the D state
transition is D3->D0, then we (1) save key PCI config registers, (2) go
to D0, and (3) restore saved PCI config registers.  This originally
comes from Donald Becker's acpi_wake function, which is used only for
the case of device enabling (where he had no problems), not for the case
of returning-from-suspend (where we see problems).

"apm -s" causes the apm driver to map all suspends to the ACPI D3
state.  An apm suspend triggers a pm_send_all call, which in turns
triggers pci_pm_suspend.  This code [from Linus iirc] walks the root
buses, recursively suspending downstream buses and then attached
devices.  The resume code does the exact opposite.  The PCI core
suspend/resume code has this comment, and we note the current
requirement that -all- drivers should export suspend/resume somehow, in
order for a sane PM system to work here.

>  * We do not touch devices that don't have a driver that exports
>  * a suspend/resume function. That is just too dangerous. If the default
>  * PCI suspend/resume functions work for a device, the driver can
>  * easily implement them (ie just have a suspend function that calls
>  * the pci_set_power_state() function).

It is up to the drivers to implement ::suspend() and ::resume(), and few
do.  The few that do, even fewer work well in practice.

That's the current state of things.  I do not think the system -- at the
PCI core level -- is poorly designed.  I think it just takes a lot of
grunt work with drivers at this point, plus maybe a few new pci helper
functions.

So here's a random list of notes and issues on Linux PCI PM.

1) pci_enable_device needs to power up the device before enabling it.

2) AFAICT, it is safe to turn off a PCI device's bus-mastering bit and
take the device to D3, if it exports the PCI PM capability.  My
previously-submitted pci_disable_function function turns off the
bus-mastering bit, and should probably take the device to D3 too.

3) The current pci_set_power_state implementation is non-spec, and even
though it works for some cases it does not appear like the right thing
to do.

4) Because of #2, I have create pci_power_on and pci_power_off. 
pci_power_off saves ALL the PCI config registers, turns off
busmastering, and goes to D3.  pci_power_on takes the device to D0, then
blasts the stored PCI config register data back to the hardware.

5) In testing, this works sometimes, but other times it causes the
upstream bridge of the device being resumed to stop decoding the device.

6) One solution to #4 is to save and restore the PCI bridge registers
too.  This comes partially from a Linus suggestion, and partially from
an end user who solved their eepro100 suspend/resume problems with a
setpci command to their PCI bridge (not to the eepro100 device).  In my
own testing this solution works 100%, but (a) it might not be right, and
thus (b) it might cause problems.  I am -very- interested in feedback on
this solution, or a better one.

7) Due to #5 an open issue is to re-read the bridge and PCI PM specs. 
Some portions of the spec imply that the bridge should never be touched
during device suspend or resume :)

8) Who can predict what a laptop's AML tables want to do with the PCI
bus, and if Linux will be interfering with ACPI suspend, or if ACPI will
be interfering with Linux resume, etc.

9) A truly green driver should register itself then disable its
hardware.  It is wasting power otherwise.  That implies waking up
hardware on dev->open and sleeping on dev->release.  Some net drivers do
this already.  This further implies problems down the road with stuff
like char drivers, where applications often open and close the device
node very rapidly.  This happens in OSS audio land when some audio apps
start up, for example.  Maybe an inactivity timer would work here, to
power down the device after time passes with no open(2) calls.

10) We might wind up needing northbridge, southbridge, and/or PCI bridge
drivers.  They will likely be small, but I think eventually they will
need to exist in order to provide complete power management coverage.

11) Hard drives.  Our IDE and SCSI subsystems stink when it comes to
working with the PCI PM framework.  Andre has spoken of plans to use
pci_driver in 2.5, and turn the IDE subsystem "inside out" so that PCI
drivers call out to registration functions, etc., instead of the current
system.  The same thing needs to happen for SCSI.

12) Continuing #11, there needs to be a general notion of when the
system should -not- write stuff to disk.  This is mainly a userspace
issue, ie. low-priority syslog messages should not prevent the system
from idling the hard drive and spinning it down.  BUT..  the kernel may
need to be the central arbiter if only to have a single place which says
"hard drive is idle now"...



I have attached the pci_power_{on,off} implementation to this message. 
Note that the current checked-in implementation does not suspend/resume
bridges, I only did that in local versions of the test laptop kernels...

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
--------------1BF3BCC7D191700823767A5F
Content-Type: text/plain; charset=us-ascii;
 name="pcipm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcipm.patch"

Index: drivers/pci/pci.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/pci/pci.c,v
retrieving revision 1.1.1.32
retrieving revision 1.1.1.32.2.1
diff -u -r1.1.1.32 -r1.1.1.32.2.1
--- drivers/pci/pci.c	2001/04/18 01:19:31	1.1.1.32
+++ drivers/pci/pci.c	2001/04/18 03:39:02	1.1.1.32.2.1
@@ -228,49 +228,157 @@
 }
 
 /**
- * pci_set_power_state - Set power management state of a device.
- * @dev: PCI device for which PM is set
- * @new_state: new power management statement (0 == D0, 3 == D3, etc.)
+ * pci_power_on - Wake up a PCI device
+ * @dev: PCI device to which power is to be applied
  *
- *  Set power management state of a device.  For transitions from state D3
- *  it isn't as straightforward as one could assume since many devices forget
- *  their configuration space during wakeup.  Returns old power state.
+ * Bring the given PCI device @dev up to full power,
+ * using standard PCI PM techniques.  Any saved context
+ * is restored after device power-up.
+ *
+ * RETURN VALUE: Zero is returned upon successful completion
+ * of the wake-up operation.
  */
+
 int
-pci_set_power_state(struct pci_dev *dev, int new_state)
+pci_power_on(struct pci_dev *dev)
 {
-	u32 base[5], romaddr;
-	u16 pci_command, pwr_command;
-	u8  pci_latency, pci_cacheline;
-	int i, old_state;
-	int pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	u16 pwr_command;
+	int pm_d_state, pm, i;
+
+	/* find PCI PM capability in list */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!pm) return 0; /* assume no PM == poweron success */
 
-	if (!pm)
-		return 0;
+	/* make sure we aren't already in D0 state */
 	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pwr_command);
-	old_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
-	if (old_state == new_state)
-		return old_state;
-	DBG("PCI: %s goes from D%d to D%d\n", dev->slot_name, old_state, new_state);
-	if (old_state == 3) {
-		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
-		pci_write_config_word(dev, PCI_COMMAND, pci_command & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));
-		for (i = 0; i < 5; i++)
-			pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + i*4, &base[i]);
-		pci_read_config_dword(dev, PCI_ROM_ADDRESS, &romaddr);
-		pci_read_config_byte(dev, PCI_LATENCY_TIMER, &pci_latency);
-		pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &pci_cacheline);
-		pci_write_config_word(dev, pm + PCI_PM_CTRL, new_state);
-		for (i = 0; i < 5; i++)
-			pci_write_config_dword(dev, PCI_BASE_ADDRESS_0 + i*4, base[i]);
-		pci_write_config_dword(dev, PCI_ROM_ADDRESS, romaddr);
+	pm_d_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
+	if (pm_d_state == 0) return 0;
+
+	/* go to D0 */
+	/* XXX: should we enable function's ability to assert
+	 * PME# here (bit 8) too?
+	 */
+	pci_write_config_word(dev, pm + PCI_PM_CTRL, 0);
+
+	/*
+	 * restore context, if saved
+	 */
+	if (dev->saved_context) {
+		/* XXX: 100% dword access ok here? */
+		for (i = 0; i < dev->saved_context->n_dwords; i++)
+			pci_write_config_dword(dev, i * 4,
+				       dev->saved_context->cfg_hdr[i]);
+
+		kfree(dev->saved_context);
+		dev->saved_context = NULL;
+	}
+
+	/*
+	 * otherwise, write the context information we know from bootup.
+	 * This works around a problem where warm-booting from Windows
+	 * combined with a D3(hot)->D0 transition causes PCI config
+	 * header data to be forgotten.
+	 */	
+	else {
+		for (i = 0; i < 6; i ++)
+			pci_write_config_dword(dev,
+					       PCI_BASE_ADDRESS_0 + (i * 4),
+					       dev->resource[i].start);
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, pci_cacheline);
-		pci_write_config_byte(dev, PCI_LATENCY_TIMER, pci_latency);
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
-	} else
-		pci_write_config_word(dev, pm + PCI_PM_CTRL, (pwr_command & ~PCI_PM_CTRL_STATE_MASK) | new_state);
-	return old_state;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_power_off - Suspend a PCI device
+ * @dev: PCI device to be suspended
+ * @context_size: Number of PCI config bytes to save
+ *
+ * Remove power from a PCI device, saving PCI context
+ * before fully transitioning to the D3 state.
+ *
+ * The @context_size argument can be -1, which indicates
+ * that only the standard PCI 2.2 configuration header
+ * is to be saved.  @context_size can be zero, which indicates
+ * no context is to be saved.  Or, @context_size can be a
+ * specific length, indicating the number of bytes to be saved
+ * before poweroff.  @context_size is always rounded up to the nearest
+ * dword boundary.
+ *
+ * RETURN VALUE: If the PCI device
+ * does not support PCI PM, %EIO is returned.  If memory
+ * is not available to store the PCI context requested,
+ * %ENOMEM is returned.  Otherwise, zero (success) is returned.
+ */
+
+int
+pci_power_off(struct pci_dev *dev, int context_size)
+{
+	u16 pwr_command, tmp, newtmp;
+	int pm_d_state, pm, i;
+	void *mem;
+
+	/* find PCI PM capability in list */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!pm) return -EIO; /* this device cannot poweroff */
+
+	/* make sure we aren't already in D3 state */
+	/* XXX: reliable/superfluous test? */
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pwr_command);
+	pm_d_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
+	if (pm_d_state == 3) return 0;
+
+	/* programmer error... */
+	if (dev->saved_context)
+		BUG();
+
+	/*
+	 * save context
+	 */
+	if (context_size == -1) /* save only standard PCI config header */
+		context_size = 15 * sizeof(u32);
+	if (context_size > 0) {
+		/* convert bytes to dwords, with rounding */
+		if (context_size % 4 == 0)
+			context_size >>= 2;
+		else
+			context_size = (context_size >> 2) + 1;
+
+		mem = kmalloc(sizeof(struct pci_dev_context) +
+			      (context_size * sizeof(u32)), GFP_KERNEL);
+		if (!mem)
+			return -ENOMEM;
+		dev->saved_context = mem;
+		dev->saved_context->n_dwords = context_size;
+		dev->saved_context->cfg_hdr = mem + sizeof(struct pci_dev_context);
+
+		/* XXX: 100% dword access ok here? */
+		for (i = 0; i < dev->saved_context->n_dwords; i++)
+			pci_read_config_dword(dev, i * 4,
+					      &dev->saved_context->cfg_hdr[i]);
+	}
+
+	/* _PCI System Arch._ sez "disable device's ability to act as
+	 * a master and a target."  Interpreted as clearing the
+	 * master, MEM decode and IO decode bits
+	 */
+	pci_read_config_word(dev, PCI_COMMAND, &tmp);
+	newtmp = tmp & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER);
+	if (tmp != newtmp)
+		pci_write_config_word(dev, PCI_COMMAND, newtmp);
+ 
+	/* just for the sake of sanity and pessimism, pause for a bit,
+	 * then clear any status conditions.  PCI status register
+	 * is nicely designed so we can clear it thusly..
+	 */
+	pci_read_config_word(dev, PCI_STATUS, &tmp);
+	pci_write_config_word(dev, PCI_STATUS, tmp);
+
+	/* go to D3 */
+	pci_write_config_word(dev, pm + PCI_PM_CTRL, 3);
+
+	return 0;
 }
 
 /**
@@ -285,10 +393,13 @@
 pci_enable_device(struct pci_dev *dev)
 {
 	int err;
+
+	err = pci_power_on(dev);
+	if (err) return err;
+
+	err = pcibios_enable_device(dev);
+	if (err < 0) return err;
 
-	if ((err = pcibios_enable_device(dev)) < 0)
-		return err;
-	pci_set_power_state(dev, 0);
 	return 0;
 }
 
@@ -1390,7 +1501,8 @@
 EXPORT_SYMBOL(pci_find_subsys);
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_dma_mask);
-EXPORT_SYMBOL(pci_set_power_state);
+EXPORT_SYMBOL(pci_power_on);
+EXPORT_SYMBOL(pci_power_off);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_register_driver);
 EXPORT_SYMBOL(pci_unregister_driver);
Index: include/linux/pci.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/pci.h,v
retrieving revision 1.1.1.39
retrieving revision 1.1.1.39.2.1
diff -u -r1.1.1.39 -r1.1.1.39.2.1
--- include/linux/pci.h	2001/04/18 01:11:14	1.1.1.39
+++ include/linux/pci.h	2001/04/18 03:44:33	1.1.1.39.2.1
@@ -308,6 +308,11 @@
 #define pci_for_each_dev_reverse(dev) \
 	for(dev = pci_dev_g(pci_devices.prev); dev != pci_dev_g(&pci_devices); dev = pci_dev_g(dev->global_list.prev))
 
+struct pci_dev_context {
+	int n_dwords;
+	u32 *cfg_hdr;
+};
+
 /*
  * The pci_dev structure is used to describe both PCI and ISAPnP devices.
  */
@@ -330,6 +335,11 @@
 	u8		rom_base_reg;	/* which config register controls the ROM */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
+
+	struct pci_dev_context *saved_context;
+					/* PCI config header, when suspended.
+					   NULL when active */
+
 	void		*driver_data;	/* data private to the driver */
 	dma_addr_t	dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
@@ -528,7 +538,8 @@
 int pci_enable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask);
-int pci_set_power_state(struct pci_dev *dev, int state);
+int pci_power_on(struct pci_dev *dev);
+int pci_power_off(struct pci_dev *dev, int context_size);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */

--------------1BF3BCC7D191700823767A5F--

