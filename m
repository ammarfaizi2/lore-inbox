Return-Path: <linux-kernel-owner+w=401wt.eu-S1754249AbWLYIGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbWLYIGl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 03:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754266AbWLYIGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 03:06:40 -0500
Received: from colo.lackof.org ([198.49.126.79]:55189 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754249AbWLYIGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 03:06:39 -0500
Date: Mon, 25 Dec 2006 01:06:35 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] Update Documentation/pci.txt v7
Message-ID: <20061225080635.GB32499@colo.lackof.org>
References: <456404E2.1060102@jp.fujitsu.com> <20061122182804.GE378@colo.lackof.org> <45663EE8.1080708@jp.fujitsu.com> <20061124051217.GB8202@colo.lackof.org> <20061206072651.GG17199@kroah.com> <20061210072508.GA12272@colo.lackof.org> <20061215170207.GB15058@kroah.com> <20061218071133.GA1738@colo.lackof.org> <20061224060726.GC24131@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061224060726.GC24131@colo.lackof.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2006 at 11:07:26PM -0700, Grant Grundler wrote:
> "final" patch v7 and commit log entry appended below. :)

v8 adds 2cd round of feedback from Randy Dunlap.
Going once...twice... ;)

> Full pci.txt text is easier to review at:
>     http://www.parisc-linux.org/~grundler/Documentation/

Same place.

grant


Rewrite Documentation/pci.txt:
o restructure document to match how API is used when writing init code.
o update to reflect changes in struct pci_driver function pointers.
o removed language on "new style vs old style" device discovery.
  "Old style" is now deprecated. Don't use it. Left description in
  to document existing driver behaviors.
o add section "Legacy I/O Port free driver" by Kenji Kaneshige
  http://lkml.org/lkml/2006/11/22/25
  (renamed to "pci_enable_device_bars() and Legacy I/O Port space")
o add "MMIO space and write posting" section to help avoid common pitfall
  when converting drivers from IO Port space to MMIO space.
  Orignally posted http://lkml.org/lkml/2006/2/27/24
o many typo/grammer/spelling corrections from Randy Dunlap
o two more spelling corrections from Stephan Richter
o fix CodingStyle as per Randy Dunlap


Signed-off-by: Grant Grundler <grundler@parisc-linux.org>


diff --git a/Documentation/pci.txt b/Documentation/pci.txt
index 2b395e4..0d33d80 100644
--- a/Documentation/pci.txt
+++ b/Documentation/pci.txt
@@ -1,142 +1,231 @@
-			 How To Write Linux PCI Drivers
 
-		   by Martin Mares <mj@ucw.cz> on 07-Feb-2000
+			How To Write Linux PCI Drivers
+
+		by Martin Mares <mj@ucw.cz> on 07-Feb-2000
+	updated by Grant Grundler <grundler@parisc-linux.org> on 23-Dec-2006
 
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-The world of PCI is vast and it's full of (mostly unpleasant) surprises.
-Different PCI devices have different requirements and different bugs --
-because of this, the PCI support layer in Linux kernel is not as trivial
-as one would wish. This short pamphlet tries to help all potential driver
-authors find their way through the deep forests of PCI handling.
+The world of PCI is vast and full of (mostly unpleasant) surprises.
+Since each CPU architecture implements different chip-sets and PCI devices
+have different requirements (erm, "features"), the result is the PCI support
+in the Linux kernel is not as trivial as one would wish. This short paper
+tries to introduce all potential driver authors to Linux APIs for
+PCI device drivers.
+
+A more complete resource is the third edition of "Linux Device Drivers"
+by Jonathan Corbet, Alessandro Rubini, and Greg Kroah-Hartman.
+LDD3 is available for free (under Creative Commons License) from:
+
+	http://lwn.net/Kernel/LDD3/
+
+However, keep in mind that all documents are subject to "bit rot".
+Refer to the source code if things are not working as described here.
+
+Please send questions/comments/patches about Linux PCI API to the
+"Linux PCI" <linux-pci@atrey.karlin.mff.cuni.cz> mailing list.
+
 
 
 0. Structure of PCI drivers
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
-There exist two kinds of PCI drivers: new-style ones (which leave most of
-probing for devices to the PCI layer and support online insertion and removal
-of devices [thus supporting PCI, hot-pluggable PCI and CardBus in a single
-driver]) and old-style ones which just do all the probing themselves. Unless
-you have a very good reason to do so, please don't use the old way of probing
-in any new code. After the driver finds the devices it wishes to operate
-on (either the old or the new way), it needs to perform the following steps:
+PCI drivers "discover" PCI devices in a system via pci_register_driver().
+Actually, it's the other way around. When the PCI generic code discovers
+a new device, the driver with a matching "description" will be notified.
+Details on this below.
+
+pci_register_driver() leaves most of the probing for devices to
+the PCI layer and supports online insertion/removal of devices [thus
+supporting hot-pluggable PCI, CardBus, and Express-Card in a single driver].
+pci_register_driver() call requires passing in a table of function
+pointers and thus dictates the high level structure of a driver.
+
+Once the driver knows about a PCI device and takes ownership, the
+driver generally needs to perform the following initialization:
 
 	Enable the device
-	Access device configuration space
-	Discover resources (addresses and IRQ numbers) provided by the device
-	Allocate these resources
-	Communicate with the device
+	Request MMIO/IOP resources
+	Set the DMA mask size (for both coherent and streaming DMA)
+	Allocate and initialize shared control data (pci_allocate_coherent())
+	Access device configuration space (if needed)
+	Register IRQ handler (request_irq())
+	Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
+	Enable DMA/processing engines
+
+When done using the device, and perhaps the module needs to be unloaded,
+the driver needs to take the follow steps:
+	Disable the device from generating IRQs
+	Release the IRQ (free_irq())
+	Stop all DMA activity
+	Release DMA buffers (both streaming and coherent)
+	Unregister from other subsystems (e.g. scsi or netdev)
+	Release MMIO/IOP resources
 	Disable the device
 
-Most of these topics are covered by the following sections, for the rest
-look at <linux/pci.h>, it's hopefully well commented.
+Most of these topics are covered in the following sections.
+For the rest look at LDD3 or <linux/pci.h> .
 
 If the PCI subsystem is not configured (CONFIG_PCI is not set), most of
-the functions described below are defined as inline functions either completely
-empty or just returning an appropriate error codes to avoid lots of ifdefs
-in the drivers.
+the PCI functions described below are defined as inline functions either
+completely empty or just returning an appropriate error codes to avoid
+lots of ifdefs in the drivers.
+
 
 
-1. New-style drivers
-~~~~~~~~~~~~~~~~~~~~
-The new-style drivers just call pci_register_driver during their initialization
-with a pointer to a structure describing the driver (struct pci_driver) which
-contains:
+1. pci_register_driver() call
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-	name		Name of the driver
+PCI device drivers call pci_register_driver() during their
+initialization with a pointer to a structure describing the driver
+(struct pci_driver):
+
+	field name	Description
+	----------	------------------------------------------------------
 	id_table	Pointer to table of device ID's the driver is
 			interested in.  Most drivers should export this
 			table using MODULE_DEVICE_TABLE(pci,...).
-	probe		Pointer to a probing function which gets called (during
-			execution of pci_register_driver for already existing
-			devices or later if a new device gets inserted) for all
-			PCI devices which match the ID table and are not handled
-			by the other drivers yet. This function gets passed a
-			pointer to the pci_dev structure representing the device
-			and also which entry in the ID table did the device
-			match. It returns zero when the driver has accepted the
-			device or an error code (negative number) otherwise.
-			This function always gets called from process context,
-			so it can sleep.
-	remove		Pointer to a function which gets called whenever a
-			device being handled by this driver is removed (either
-			during deregistration of the driver or when it's
-			manually pulled out of a hot-pluggable slot). This
-			function always gets called from process context, so it
-			can sleep.
-	save_state	Save a device's state before it's suspend.
+
+	probe		This probing function gets called (during execution
+			of pci_register_driver() for already existing
+			devices or later if a new device gets inserted) for
+			all PCI devices which match the ID table and are not
+			"owned" by the other drivers yet. This function gets
+			passed a "struct pci_dev *" for each device whose
+			entry in the ID table matches the device. The probe
+			function returns zero when the driver chooses to
+			take "ownership" of the device or an error code
+			(negative number) otherwise.
+			The probe function always gets called from process
+			context, so it can sleep.
+
+	remove		The remove() function gets called whenever a device
+			being handled by this driver is removed (either during
+			deregistration of the driver or when it's manually
+			pulled out of a hot-pluggable slot).
+			The remove function always gets called from process
+			context, so it can sleep.
+
 	suspend		Put device into low power state.
+	suspend_late	Put device into low power state.
+
+	resume_early	Wake device from low power state.
 	resume		Wake device from low power state.
+
+		(Please see Documentation/power/pci.txt for descriptions
+		of PCI Power Management and the related functions.)
+
 	enable_wake	Enable device to generate wake events from a low power
 			state.
 
-			(Please see Documentation/power/pci.txt for descriptions
-			of PCI Power Management and the related functions)
+	shutdown	Hook into reboot_notifier_list (kernel/sys.c).
+			Intended to stop any idling DMA operations.
+			Useful for enabling wake-on-lan (NIC) or changing
+			the power state of a device before reboot.
+			e.g. drivers/net/e100.c.
+
+	err_handler	See Documentation/pci-error-recovery.txt
+
+	multithread_probe	Enable multi-threaded probe/scan. Driver must
+			provide its own locking/syncronization for init
+			operations if this is enabled.
+
 
-The ID table is an array of struct pci_device_id ending with a all-zero entry.
-Each entry consists of:
+The ID table is an array of struct pci_device_id entries ending with an
+all-zero entry.  Each entry consists of:
+
+	vendor,device	Vendor and device ID to match (or PCI_ANY_ID)
 
-	vendor, device	Vendor and device ID to match (or PCI_ANY_ID)
 	subvendor,	Subsystem vendor and device ID to match (or PCI_ANY_ID)
-	subdevice
-	class,		Device class to match. The class_mask tells which bits
-	class_mask	of the class are honored during the comparison.
+	subdevice,
+
+	class		Device class, subclass, and "interface" to match.
+			See Appendix D of the PCI Local Bus Spec or
+			include/linux/pci_ids.h for a full list of classes.
+			Most drivers do not need to specify class/class_mask
+			as vendor/device is normally sufficient.
+
+	class_mask	limit which sub-fields of the class field are compared.
+			See drivers/scsi/sym53c8xx_2/ for example of usage.
+
 	driver_data	Data private to the driver.
+			Most drivers don't need to use driver_data field.
+			Best practice is to use driver_data as an index
+			into a static list of equivalent device types,
+			instead of using it as a pointer.
 
-Most drivers don't need to use the driver_data field.  Best practice
-for use of driver_data is to use it as an index into a static list of
-equivalent device types, not to use it as a pointer.
 
-Have a table entry {PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID}
-to have probe() called for every PCI device known to the system.
+Most drivers only need PCI_DEVICE() or PCI_DEVICE_CLASS() to set up
+a pci_device_id table.
 
-New PCI IDs may be added to a device driver at runtime by writing
-to the file /sys/bus/pci/drivers/{driver}/new_id.  When added, the
-driver will probe for all devices it can support.
+New PCI IDs may be added to a device driver pci_ids table at runtime
+as shown below:
 
 echo "vendor device subvendor subdevice class class_mask driver_data" > \
- /sys/bus/pci/drivers/{driver}/new_id
-where all fields are passed in as hexadecimal values (no leading 0x).
-Users need pass only as many fields as necessary; vendor, device,
-subvendor, and subdevice fields default to PCI_ANY_ID (FFFFFFFF),
-class and classmask fields default to 0, and driver_data defaults to
-0UL.  Device drivers must initialize use_driver_data in the dynids struct
-in their pci_driver struct prior to calling pci_register_driver in order
-for the driver_data field to get passed to the driver. Otherwise, only a
-0 is passed in that field.
+/sys/bus/pci/drivers/{driver}/new_id
+
+All fields are passed in as hexadecimal values (no leading 0x).
+Users need pass only as many fields as necessary:
+	o vendor, device, subvendor, and subdevice fields default
+	  to PCI_ANY_ID (FFFFFFFF),
+	o class and classmask fields default to 0
+	o driver_data defaults to 0UL.
+
+Once added, the driver probe routine will be invoked for any unclaimed
+PCI devices listed in its (newly updated) pci_ids list.
 
 When the driver exits, it just calls pci_unregister_driver() and the PCI layer
 automatically calls the remove hook for all devices handled by the driver.
 
+
+1.1 "Attributes" for driver functions/data
+
 Please mark the initialization and cleanup functions where appropriate
 (the corresponding macros are defined in <linux/init.h>):
 
 	__init		Initialization code. Thrown away after the driver
 			initializes.
 	__exit		Exit code. Ignored for non-modular drivers.
-	__devinit	Device initialization code. Identical to __init if
-			the kernel is not compiled with CONFIG_HOTPLUG, normal
-			function otherwise.
+
+
+	__devinit	Device initialization code.
+			Identical to __init if the kernel is not compiled
+			with CONFIG_HOTPLUG, normal function otherwise.
 	__devexit	The same for __exit.
 
-Tips:
-	The module_init()/module_exit() functions (and all initialization
-        functions called only from these) should be marked __init/exit.
-	The struct pci_driver shouldn't be marked with any of these tags.
-	The ID table array should be marked __devinitdata.
-	The probe() and remove() functions (and all initialization
-	functions called only from these) should be marked __devinit/exit.
-	If you are sure the driver is not a hotplug driver then use only 
-	__init/exit __initdata/exitdata.
+Tips on when/where to use the above attributes:
+	o The module_init()/module_exit() functions (and all
+	  initialization functions called _only_ from these)
+	  should be marked __init/__exit.
 
-        Pointers to functions marked as __devexit must be created using
-        __devexit_p(function_name).  That will generate the function
-        name or NULL if the __devexit function will be discarded.
+	o Do not mark the struct pci_driver.
 
+	o The ID table array should be marked __devinitdata.
 
-2. How to find PCI devices manually (the old style)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-PCI drivers not using the pci_register_driver() interface search
-for PCI devices manually using the following constructs:
+	o The probe() and remove() functions should be marked __devinit
+	  and __devexit respectively.  All initialization functions
+	  exclusively called by the probe() routine, can be marked __devinit.
+	  Ditto for remove() and __devexit.
+
+	o If mydriver_probe() is marked with __devinit(), then all address
+	  references to mydriver_probe must use __devexit_p(mydriver_probe)
+	  (in the struct pci_driver declaration for example).
+	  __devexit_p() will generate the function name _or_ NULL if the
+	  function will be discarded.  For an example, see drivers/net/tg3.c.
+
+	o Do NOT mark a function if you are not sure which mark to use.
+	  Better to not mark the function than mark the function wrong.
+
+
+
+2. How to find PCI devices manually
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+PCI drivers should have a really good reason for not using the
+pci_register_driver() interface to search for PCI devices.
+The main reason PCI devices are controlled by multiple drivers
+is because one PCI device implements several different HW services.
+E.g. combined serial/parallel port/floppy controller.
+
+A manual search may be performed using the following constructs:
 
 Searching by vendor and device ID:
 
@@ -150,87 +239,311 @@ Searching by class ID (iterate in a similar way):
 
 Searching by both vendor/device and subsystem vendor/device ID:
 
-	pci_get_subsys(VENDOR_ID, DEVICE_ID, SUBSYS_VENDOR_ID, SUBSYS_DEVICE_ID, dev).
+	pci_get_subsys(VENDOR_ID,DEVICE_ID, SUBSYS_VENDOR_ID, SUBSYS_DEVICE_ID, dev).
 
-   You can use the constant PCI_ANY_ID as a wildcard replacement for
+You can use the constant PCI_ANY_ID as a wildcard replacement for
 VENDOR_ID or DEVICE_ID.  This allows searching for any device from a
 specific vendor, for example.
 
-   These functions are hotplug-safe. They increment the reference count on
+These functions are hotplug-safe. They increment the reference count on
 the pci_dev that they return. You must eventually (possibly at module unload)
 decrement the reference count on these devices by calling pci_dev_put().
 
 
-3. Enabling and disabling devices
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-   Before you do anything with the device you've found, you need to enable
-it by calling pci_enable_device() which enables I/O and memory regions of
-the device, allocates an IRQ if necessary, assigns missing resources if
-needed and wakes up the device if it was in suspended state. Please note
-that this function can fail.
 
-   If you want to use the device in bus mastering mode, call pci_set_master()
-which enables the bus master bit in PCI_COMMAND register and also fixes
-the latency timer value if it's set to something bogus by the BIOS.
+3. Device Initialization Steps
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As noted in the introduction, most PCI drivers need the following steps
+for device initialization:
 
-   If you want to use the PCI Memory-Write-Invalidate transaction,
+	Enable the device
+	Request MMIO/IOP resources
+	Set the DMA mask size (for both coherent and streaming DMA)
+	Allocate and initialize shared control data (pci_allocate_coherent())
+	Access device configuration space (if needed)
+	Register IRQ handler (request_irq())
+	Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
+	Enable DMA/processing engines.
+
+The driver can access PCI config space registers at any time.
+(Well, almost. When running BIST, config space can go away...but
+that will just result in a PCI Bus Master Abort and config reads
+will return garbage).
+
+ 
+3.1 Enable the PCI device
+~~~~~~~~~~~~~~~~~~~~~~~~~
+Before touching any device registers, the driver needs to enable
+the PCI device by calling pci_enable_device(). This will:
+	o wake up the device if it was in suspended state,
+	o allocate I/O and memory regions of the device (if BIOS did not),
+	o allocate an IRQ (if BIOS did not).
+
+NOTE: pci_enable_device() can fail! Check the return value.
+NOTE2: Also see pci_enable_device_bars() below. Drivers can
+    attempt to enable only a subset of BARs they need.
+
+[ OS BUG: we don't check resource allocations before enabling those
+  resources. The sequence would make more sense if we called
+  pci_request_resources() before calling pci_enable_device().
+  Currently, the device drivers can't detect the bug when when two
+  devices have been allocated the same range. This is not a common
+  problem and unlikely to get fixed soon.
+
+  This has been discussed before but not changed as of 2.6.19:
+	http://lkml.org/lkml/2006/3/2/194
+]
+
+pci_set_master() will enable DMA by setting the bus master bit
+in the PCI_COMMAND register. It also fixes the latency timer value if
+it's set to something bogus by the BIOS.
+
+If the PCI device can use the PCI Memory-Write-Invalidate transaction,
 call pci_set_mwi().  This enables the PCI_COMMAND bit for Mem-Wr-Inval
 and also ensures that the cache line size register is set correctly.
-Make sure to check the return value of pci_set_mwi(), not all architectures
-may support Memory-Write-Invalidate.
+Check the return value of pci_set_mwi() as not all architectures
+or chip-sets may support Memory-Write-Invalidate.
+
+
+3.2 Request MMIO/IOP resources
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Memory (MMIO), and I/O port addresses should NOT be read directly
+from the PCI device config space. Use the values in the pci_dev structure
+as the PCI "bus address" might have been remapped to a "host physical"
+address by the arch/chip-set specific kernel support.
 
-   If your driver decides to stop using the device (e.g., there was an
-error while setting it up or the driver module is being unloaded), it
-should call pci_disable_device() to deallocate any IRQ resources, disable
-PCI bus-mastering, etc.  You should not do anything with the device after
+See Documentation/IO-mapping.txt for how to access device registers
+or device memory.
+
+The device driver needs to call pci_request_region() to verify
+no other device is already using the same address resource.
+Conversely, drivers should call pci_release_region() AFTER
 calling pci_disable_device().
+The idea is to prevent two devices colliding on the same address range.
+
+[ See OS BUG comment above. Currently (2.6.19), The driver can only
+  determine MMIO and IO Port resource availability _after_ calling
+  pci_enable_device(). ]
+
+Generic flavors of pci_request_region() are request_mem_region()
+(for MMIO ranges) and request_region() (for IO Port ranges).
+Use these for address resources that are not described by "normal" PCI
+BARs.
+
+Also see pci_request_selected_regions() below.
+
+
+3.3 Set the DMA mask size
+~~~~~~~~~~~~~~~~~~~~~~~~~
+[ If anything below doesn't make sense, please refer to
+  Documentation/DMA-API.txt. This section is just a reminder that
+  drivers need to indicate DMA capabilities of the device and is not
+  an authoritative source for DMA interfaces. ]
+
+While all drivers should explicitly indicate the DMA capability
+(e.g. 32 or 64 bit) of the PCI bus master, devices with more than
+32-bit bus master capability for streaming data need the driver
+to "register" this capability by calling pci_set_dma_mask() with
+appropriate parameters.  In general this allows more efficient DMA
+on systems where System RAM exists above 4G _physical_ address.
+
+Drivers for all PCI-X and PCIe compliant devices must call
+pci_set_dma_mask() as they are 64-bit DMA devices.
+
+Similarly, drivers must also "register" this capability if the device
+can directly address "consistent memory" in System RAM above 4G physical
+address by calling pci_set_consistent_dma_mask().
+Again, this includes drivers for all PCI-X and PCIe compliant devices.
+Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
+64-bit DMA capable for payload ("streaming") data but not control
+("consistent") data.
+
+
+3.4 Setup shared control data
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
+memory.  See Documentation/DMA-API.txt for a full description of
+the DMA APIs. This section is just a reminder that it needs to be done
+before enabling DMA on the device.
+
+
+3.5 Initialize device registers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Some drivers will need specific "capability" fields programmed
+or other "vendor specific" register initialized or reset.
+E.g. clearing pending interrupts.
+
+
+3.6 Register IRQ handler
+~~~~~~~~~~~~~~~~~~~~~~~~
+While calling request_irq() is the the last step described here,
+this is often just another intermediate step to initialize a device.
+This step can often be deferred until the device is opened for use.
+
+All interrupt handlers for IRQ lines should be registered with IRQF_SHARED
+and use the devid to map IRQs to devices (remember that all PCI IRQ lines
+can be shared).
+
+request_irq() will associate an interrupt handler and device handle
+with an interrupt number. Historically interrupt numbers represent
+IRQ lines which run from the PCI device to the Interrupt controller.
+With MSI and MSI-X (more below) the interrupt number is a CPU "vector".
+
+request_irq() also enables the interrupt. Make sure the device is
+quiesced and does not have any interrupts pending before registering
+the interrupt handler.
+
+MSI and MSI-X are PCI capabilities. Both are "Message Signaled Interrupts"
+which deliver interrupts to the CPU via a DMA write to a Local APIC.
+The fundamental difference between MSI and MSI-X is how multiple
+"vectors" get allocated. MSI requires contiguous blocks of vectors
+while MSI-X can allocate several individual ones.
+
+MSI capability can be enabled by calling pci_enable_msi() or
+pci_enable_msix() before calling request_irq(). This causes
+the PCI support to program CPU vector data into the PCI device
+capability registers.
+
+If your PCI device supports both, try to enable MSI-X first.
+Only one can be enabled at a time.  Many architectures, chip-sets,
+or BIOSes do NOT support MSI or MSI-X and the call to pci_enable_msi/msix
+will fail. This is important to note since many drivers have
+two (or more) interrupt handlers: one for MSI/MSI-X and another for IRQs.
+They choose which handler to register with request_irq() based on the
+return value from pci_enable_msi/msix().
+
+There are (at least) two really good reasons for using MSI:
+1) MSI is an exclusive interrupt vector by definition.
+   This means the interrupt handler doesn't have to verify
+   its device caused the interrupt.
+
+2) MSI avoids DMA/IRQ race conditions. DMA to host memory is guaranteed
+   to be visible to the host CPU(s) when the MSI is delivered. This
+   is important for both data coherency and avoiding stale control data.
+   This guarantee allows the driver to omit MMIO reads to flush
+   the DMA stream.
+
+See drivers/infiniband/hw/mthca/ or drivers/net/tg3.c for examples
+of MSI/MSI-X usage.
+
+
+
+4. PCI device shutdown
+~~~~~~~~~~~~~~~~~~~~~~~
+
+When a PCI device driver is being unloaded, most of the following
+steps need to be performed:
+
+	Disable the device from generating IRQs
+	Release the IRQ (free_irq())
+	Stop all DMA activity
+	Release DMA buffers (both streaming and consistent)
+	Unregister from other subsystems (e.g. scsi or netdev)
+	Disable device from responding to MMIO/IO Port addresses
+	Release MMIO/IO Port resource(s)
+
+
+4.1 Stop IRQs on the device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+How to do this is chip/device specific. If it's not done, it opens
+the possibility of a "screaming interrupt" if (and only if)
+the IRQ is shared with another device.
+
+When the shared IRQ handler is "unhooked", the remaining devices
+using the same IRQ line will still need the IRQ enabled. Thus if the
+"unhooked" device asserts IRQ line, the system will respond assuming
+it was one of the remaining devices asserted the IRQ line. Since none
+of the other devices will handle the IRQ, the system will "hang" until
+it decides the IRQ isn't going to get handled and masks the IRQ (100,000
+iterations later). Once the shared IRQ is masked, the remaining devices
+will stop functioning properly. Not a nice situation.
+
+This is another reason to use MSI or MSI-X if it's available.
+MSI and MSI-X are defined to be exclusive interrupts and thus
+are not susceptible to the "screaming interrupt" problem.
+
+
+4.2 Release the IRQ
+~~~~~~~~~~~~~~~~~~~
+Once the device is quiesced (no more IRQs), one can call free_irq().
+This function will return control once any pending IRQs are handled,
+"unhook" the drivers IRQ handler from that IRQ, and finally release
+the IRQ if no one else is using it.
+
+
+4.3 Stop all DMA activity
+~~~~~~~~~~~~~~~~~~~~~~~~~
+It's extremely important to stop all DMA operations BEFORE attempting
+to deallocate DMA control data. Failure to do so can result in memory
+corruption, hangs, and on some chip-sets a hard crash.
 
-4. How to access PCI config space
+Stopping DMA after stopping the IRQs can avoid races where the
+IRQ handler might restart DMA engines.
+
+While this step sounds obvious and trivial, several "mature" drivers
+didn't get this step right in the past.
+
+
+4.4 Release DMA buffers
+~~~~~~~~~~~~~~~~~~~~~~~
+Once DMA is stopped, clean up streaming DMA first.
+I.e. unmap data buffers and return buffers to "upstream"
+owners if there is one.
+
+Then clean up "consistent" buffers which contain the control data.
+
+See Documentation/DMA-API.txt for details on unmapping interfaces.
+
+
+4.5 Unregister from other subsystems
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Most low level PCI device drivers support some other subsystem
+like USB, ALSA, SCSI, NetDev, Infiniband, etc. Make sure your
+driver isn't losing resources from that other subsystem.
+If this happens, typically the symptom is an Oops (panic) when
+the subsystem attempts to call into a driver that has been unloaded.
+
+
+4.6 Disable Device from responding to MMIO/IO Port addresses
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+io_unmap() MMIO or IO Port resources and then call pci_disable_device().
+This is the symmetric opposite of pci_enable_device().
+Do not access device registers after calling pci_disable_device().
+
+
+4.7 Release MMIO/IO Port Resource(s)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Call pci_release_region() to mark the MMIO or IO Port range as available.
+Failure to do so usually results in the inability to reload the driver.
+
+
+
+5. How to access PCI config space
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-   You can use pci_(read|write)_config_(byte|word|dword) to access the config
+
+You can use pci_(read|write)_config_(byte|word|dword) to access the config
 space of a device represented by struct pci_dev *. All these functions return 0
 when successful or an error code (PCIBIOS_...) which can be translated to a text
 string by pcibios_strerror. Most drivers expect that accesses to valid PCI
 devices don't fail.
 
-   If you don't have a struct pci_dev available, you can call
+If you don't have a struct pci_dev available, you can call
 pci_bus_(read|write)_config_(byte|word|dword) to access a given device
 and function on that bus.
 
-   If you access fields in the standard portion of the config header, please
+If you access fields in the standard portion of the config header, please
 use symbolic names of locations and bits declared in <linux/pci.h>.
 
-   If you need to access Extended PCI Capability registers, just call
+If you need to access Extended PCI Capability registers, just call
 pci_find_capability() for the particular capability and it will find the
 corresponding register block for you.
 
 
-5. Addresses and interrupts
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
-   Memory and port addresses and interrupt numbers should NOT be read from the
-config space. You should use the values in the pci_dev structure as they might
-have been remapped by the kernel.
-
-   See Documentation/IO-mapping.txt for how to access device memory.
-
-   The device driver needs to call pci_request_region() to make sure
-no other device is already using the same resource. The driver is expected
-to determine MMIO and IO Port resource availability _before_ calling
-pci_enable_device().  Conversely, drivers should call pci_release_region()
-_after_ calling pci_disable_device(). The idea is to prevent two devices
-colliding on the same address range.
-
-Generic flavors of pci_request_region() are request_mem_region()
-(for MMIO ranges) and request_region() (for IO Port ranges).
-Use these for address resources that are not described by "normal" PCI
-interfaces (e.g. BAR).
-
-   All interrupt handlers should be registered with IRQF_SHARED and use the devid
-to map IRQs to devices (remember that all PCI interrupts are shared).
-
 
 6. Other interesting functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 pci_find_slot()			Find pci_dev corresponding to given bus and
 				slot numbers.
 pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
@@ -247,11 +560,12 @@ pci_set_mwi()			Enable Memory-Write-Invalidate transactions.
 pci_clear_mwi()			Disable Memory-Write-Invalidate transactions.
 
 
+
 7. Miscellaneous hints
 ~~~~~~~~~~~~~~~~~~~~~~
-When displaying PCI slot names to the user (for example when a driver wants
-to tell the user what card has it found), please use pci_name(pci_dev)
-for this purpose.
+
+When displaying PCI device names to the user (for example when a driver wants
+to tell the user what card has it found), please use pci_name(pci_dev).
 
 Always refer to the PCI devices by a pointer to the pci_dev structure.
 All PCI layer functions use this identification and it's the only
@@ -259,31 +573,113 @@ reasonable one. Don't use bus/slot/function numbers except for very
 special purposes -- on systems with multiple primary buses their semantics
 can be pretty complex.
 
-If you're going to use PCI bus mastering DMA, take a look at
-Documentation/DMA-mapping.txt.
-
 Don't try to turn on Fast Back to Back writes in your driver.  All devices
 on the bus need to be capable of doing it, so this is something which needs
 to be handled by platform and generic code, not individual drivers.
 
 
+
 8. Vendor and device identifications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-For the future, let's avoid adding device ids to include/linux/pci_ids.h.
 
-PCI_VENDOR_ID_xxx for vendors, and a hex constant for device ids.
+One is not not required to add new device ids to include/linux/pci_ids.h.
+Please add PCI_VENDOR_ID_xxx for vendors and a hex constant for device ids.
+
+PCI_VENDOR_ID_xxx constants are re-used. The device ids are arbitrary
+hex numbers (vendor controlled) and normally used only in a single
+location, the pci_device_id table.
+
+Please DO submit new vendor/device ids to pciids.sourceforge.net project.
+
 
-Rationale:  PCI_VENDOR_ID_xxx constants are re-used, but device ids are not.
-    Further, device ids are arbitrary hex numbers, normally used only in a
-    single location, the pci_device_id table.
 
 9. Obsolete functions
 ~~~~~~~~~~~~~~~~~~~~~
+
 There are several functions which you might come across when trying to
 port an old driver to the new PCI interface.  They are no longer present
 in the kernel as they aren't compatible with hotplug or PCI domains or
 having sane locking.
 
-pci_find_device()		Superseded by pci_get_device()
-pci_find_subsys()		Superseded by pci_get_subsys()
-pci_find_slot()			Superseded by pci_get_slot()
+pci_find_device()	Superseded by pci_get_device()
+pci_find_subsys()	Superseded by pci_get_subsys()
+pci_find_slot()		Superseded by pci_get_slot()
+
+
+The alternative is the traditional PCI device driver that walks PCI
+device lists. This is still possible but discouraged.
+
+
+
+10. pci_enable_device_bars() and Legacy I/O Port space
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Large servers may not be able to provide I/O port resources to all PCI
+devices. I/O Port space is only 64KB on Intel Architecture[1] and is
+likely also fragmented since the I/O base register of PCI-to-PCI
+bridge will usually be aligned to a 4KB boundary[2]. On such systems,
+pci_enable_device() and pci_request_region() will fail when
+attempting to enable I/O Port regions that don't have I/O Port
+resources assigned.
+
+Fortunately, many PCI devices which request I/O Port resources also
+provide access to the same registers via MMIO BARs. These devices can
+be handled without using I/O port space and the drivers typically
+offer a CONFIG_ option to only use MMIO regions
+(e.g. CONFIG_TULIP_MMIO). PCI devices typically provide I/O port
+interface for legacy OSes and will work when I/O port resources are not
+assigned. The "PCI Local Bus Specification Revision 3.0" discusses
+this on p.44, "IMPLEMENTATION NOTE".
+
+If your PCI device driver doesn't need I/O port resources assigned to
+I/O Port BARs, you should use pci_enable_device_bars() instead of
+pci_enable_device() in order not to enable I/O port regions for the
+corresponding devices. In addition, you should use
+pci_request_selected_regions() and pci_release_selected_regions()
+instead of pci_request_regions()/pci_release_regions() in order not to
+request/release I/O port regions for the corresponding devices.
+
+[1] Some systems support 64KB I/O port space per PCI segment.
+[2] Some PCI-to-PCI bridges support optional 1KB aligned I/O base.
+
+
+
+11. MMIO Space and "Write Posting"
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Converting a driver from using I/O Port space to using MMIO space
+often requires some additional changes. Specifically, "write posting"
+needs to be handled. Many drivers (e.g. tg3, acenic, sym53c8xx_2)
+already do this. I/O Port space guarantees write transactions reach the PCI
+device before the CPU can continue. Writes to MMIO space allow the CPU
+to continue before the transaction reaches the PCI device. HW weenies
+call this "Write Posting" because the write completion is "posted" to
+the CPU before the transaction has reached its destination.
+
+Thus, timing sensitive code should add readl() where the CPU is
+expected to wait before doing other work.  The classic "bit banging"
+sequence works fine for I/O Port space:
+
+       for (i = 8; --i; val >>= 1) {
+               outb(val & 1, ioport_reg);      /* write bit */
+               udelay(10);
+       }
+
+The same sequence for MMIO space should be:
+
+       for (i = 8; --i; val >>= 1) {
+               writeb(val & 1, mmio_reg);      /* write bit */
+               readb(safe_mmio_reg);           /* flush posted write */
+               udelay(10);
+       }
+
+It is important that "safe_mmio_reg" not have any side effects that
+interferes with the correct operation of the device.
+
+Another case to watch out for is when resetting a PCI device. Use PCI
+Configuration space reads to flush the writel(). This will gracefully
+handle the PCI master abort on all platforms if the PCI device is
+expected to not respond to a readl().  Most x86 platforms will allow
+MMIO reads to master abort (a.k.a. "Soft Fail") and return garbage
+(e.g. ~0). But many RISC platforms will crash (a.k.a."Hard Fail").
+
