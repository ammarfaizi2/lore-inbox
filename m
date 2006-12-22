Return-Path: <linux-kernel-owner+w=401wt.eu-S1752417AbWLVTqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbWLVTqc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbWLVTqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:46:32 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:20743 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbWLVTqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:46:31 -0500
Date: Fri, 22 Dec 2006 11:46:58 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <greg@kroah.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       e1000-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Update Documentation/pci.txt
Message-Id: <20061222114658.01da661b.randy.dunlap@oracle.com>
In-Reply-To: <20061218071133.GA1738@colo.lackof.org>
References: <456404E2.1060102@jp.fujitsu.com>
	<20061122182804.GE378@colo.lackof.org>
	<45663EE8.1080708@jp.fujitsu.com>
	<20061124051217.GB8202@colo.lackof.org>
	<20061206072651.GG17199@kroah.com>
	<20061210072508.GA12272@colo.lackof.org>
	<20061215170207.GB15058@kroah.com>
	<20061218071133.GA1738@colo.lackof.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 00:11:33 -0700 Grant Grundler wrote:

> Full version of pci.txt (v6 is 677 lines):
> 	http://www.parisc-linux.org/~grundler/Documentation/pci.txt-06
> 
> I've appended patch v6 (823 lines!) and commit log entry is below.
> 
> 
> 
> diff --git a/Documentation/pci.txt b/Documentation/pci.txt
> index 2b395e4..dce829e 100644
> --- a/Documentation/pci.txt
> +++ b/Documentation/pci.txt
> @@ -1,147 +1,235 @@
> -			 How To Write Linux PCI Drivers
>  
> -		   by Martin Mares <mj@ucw.cz> on 07-Feb-2000
> +			How To Write Linux PCI Drivers
> +
> +		by Martin Mares <mj@ucw.cz> on 07-Feb-2000
> +	updatedby Grant Grundler <grundler@parisc-linux.org> on 17-Dec-2006

        updated by
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> +pci_register_driver() leaves most of the probing for devices to
> +the PCI layer and supports online insertion/removal of devices [thus
> +supporting PCI, hot-pluggable PCI and CardBus in a single driver].

ExpressCard ?

> +pci_register_driver() call requires passing in a table of function
> +calls and thus dictates the high level structure of a driver.

s/calls/pointers/ ?

> +
> +Once the driver knows about a PCI device and takes ownership, the
> +driver generally needs to perform the following initialization:
>  
>  	Enable the device
> -	Access device configuration space
> -	Discover resources (addresses and IRQ numbers) provided by the device
> -	Allocate these resources
> -	Communicate with the device
> +	request MMIO/IOP resources
> +	set the DMA mask size (for both coherent and streaming DMA)
> +	allocate and initialize shared control data (pci_allocate_coherent())
> +	Access device configuration space (if needed)
> +	register IRQ handler (request_irq())
> +	Initialize non-PCI (ie LAN/SCSI/etc parts of the chip)
> +	enable DMA/processing engines.

Please capitalize the first word of each list item.
(i.e., be consistent)

> +When done using the device, and perhaps the module needs to be unloaded,
> +the driver needs to take the follow steps:
> +	disable the device from generating IRQs
> +	release the IRQ (free_irq())
> +	stop all DMA activity
> +	release DMA buffers (both streaming and coherent)
> +	unregister from other subsystems (e.g. scsi or netdev)
> +	release MMIO/IOP resources
>  	Disable the device

Be consistent.

> +1. pci_register_driver() call
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +PCI device drivers call pci_register_driver() during their
> +initialization with a pointer to a structure describing the driver
> +(struct pci_driver):
> +
> +	field name	Description
> +	----------	------------------------------------------------------
> +	shutdown	Hook into reboot_notifier_list (kernel/sys.c).
> +			Intended to stop any idling DMA operations.
> +			Useful for enabling wake-on-lan (NIC) or change

s/change/changing/ or /to change/

> +			the power state of a device before reboot.
> +			e.g. drivers/net/e100.c.
> +
> +	multithread_probe	Enable multi-threaded probe/scan. Driver is
> +			required to provide it's own locking/syncronization

s/it's/its/
s/syncronization/synchronization/

> +			for init operations if this is enabled.
> +
> +
> +The ID table is an array of struct pci_device_id entries ending with an
> +all-zero entry.  Each entry consists of:
> +
> +	vendor,device	Vendor and device ID to match (or PCI_ANY_ID)
>  
>  	subvendor,	Subsystem vendor and device ID to match (or PCI_ANY_ID)
> +	subdevice,
> +
>  
>  
> +
> +1.1 "Marks" for driver functions/data

Markers, Attributes, Tags ?  (I prefer Attributes.)

> +
>  Please mark the initialization and cleanup functions where appropriate
>  (the corresponding macros are defined in <linux/init.h>):
>  
>  
> +2. How to find PCI devices manually
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +A manual search may be performed using the following constructs:
>  
>  Searching by vendor and device ID:
>  
> -	struct pci_dev *dev = NULL;
> -	while (dev = pci_get_device(VENDOR_ID, DEVICE_ID, dev))
> +	structpci_dev *dev = NULL;

missing some spaces:

        struct pci_dev

> +	while(dev = pci_get_device(VENDOR_ID, DEVICE_ID, dev))

        while (

>  		configure_device(dev);
>  
> +3. Device Initialization Steps
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +As noted in the introduction, most PCI drivers need the following steps
> +for device initialization:
>  
> -   If you want to use the PCI Memory-Write-Invalidate transaction,
> +	Enable the device
> +	request MMIO/IOP resources
> +	set the DMA mask size (for both coherent and streaming DMA)
> +	allocate and initialize shared control data (pci_allocate_coherent())
> +	Access device configuration space (if needed)
> +	register IRQ handler (request_irq())
> +	Initialize non-PCI (ie LAN/SCSI/etc parts of the chip)
> +	enable DMA/processing engines.
> +

Consistent capitalization, please.

> +3.2 Request MMIO/IOP resources
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +3.2 Set the DMA mask size
> +~~~~~~~~~~~~~~~~~~~~~~~~~

Duplicate 3.2 heading.

> +3.4 Initialize device registers
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Some drivers will need specific "capability" fields programmed
> +or other "vendor specific" register initialized or reset.

s/register/registers/

> +3.5 register IRQ handler
> +~~~~~~~~~~~~~~~~~~~~~~~~

       Register

> +While calling request_irq() is the the last step describe here,

s/describe/described/

> +this is often just another intermediate step to initializing a device.

s/to initializing/in initializing/ (or /to initialize/)

> +This step can often be deferred until the device is opened for use.
> +
> +All interrupt handlers for IRQ lines should be registered with IRQF_SHARED
> +and use the devid to map IRQs to devices (remember that all PCI IRQ lines
> +can be shared).
> +
> +request_irq() will associate a interrupt handler and device handle

s/a interrupt/an interrupt/

> +with an interrupt number. Historically interrupt numbers represent
> +IRQ lines which run from the PCI device to the Interrupt controller.
> +With MSI and MSI-X (more below) the interrupt number is a CPU "vector".
> +
> +MSI and MSI-X are PCI capabilities. Both are "Message Signaled Interrupts"
> +which deliver interrupts to the CPU via a DMA write to a Local APIC.
> +The fundemental difference between MSI and MSI-X are how multiple

       fundamental                                  is how

> +"vectors" get allocated. MSI requires contiguous blocks of vectors
> +while MSI-X can allocate several individual ones.
> +
> +MSI capability can be enabled by calling pci_enable_msi() or
> +pci_enable_msix() before calling request_irq(). This causes
> +the PCI support to program CPU vector data into the PCI device
> +capability registers.
> +
> +
> +4. PCI device shutdown
> +~~~~~~~~~~~~~~~~~~~~~~~
> +When a PCI device driver is being unloaded, most of the follow

                                                           following

> +steps need to be performed:
> +
> +	disable the device from generating IRQs
> +	release the IRQ (free_irq())
> +	stop all DMA activity
> +	release DMA buffers (both streaming and consistent)
> +	unregister from other subsystems (e.g. scsi or netdev)
> +	Disable device from responding to MMIO/IO Port addresses
> +	release MMIO/IO Port resource(s)

Consistent caps, please.

> +
> +4.1 Stop IRQs on the device
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +How to do this is chip/device specific. If it's not done, it opens
> +the possibility of a "screaming interrupt" if (and only if)
> +the IRQ is shared with another device.
> +
> +When the shared IRQ handler is "unhoooked", the remaining devices
> +using the same IRQ line will still need the IRQ enabled. Thus if the
> +"unhooked" device asserts IRQ line, the system wil respond assuming
> +it was one of the remaining devices asserted the IRQ line. Since none
> +of the other devices will handle the IRQ, the system will "hang" until
> +it decides the IRQ isn't going to get handled and masks the IRQ (100,000
> +iterations later). Once the shared IRQ is masked, the remaining devices
> +will stop functioning properly. Not a nice situation.
> +
> +This is another reason to use MSI or MSI-X if it's available.
> +MSI and MSI-X are defined to be exclusive interrupts and thus
> +are not susceptible to the "screaming interrupt" problem.
> +
> +
> +4.2 release the IRQ

       Release
> +~~~~~~~~~~~~~~~~~~~
> +
> +
> +4.3 stop all DMA activity

       Stop
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +
> +4.4 release DMA buffers

       Release
> +~~~~~~~~~~~~~~~~~~~~~~~
> +Once DMA is stopped, clean up streaming DMA first.
> +i.e. unmap data buffers and return buffers to "upstream"

   I.e.

> +owners if there is one.
> +
> +
> +4.5 unregister from other subsystems

       Unregister
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Most low level PCI device drivers support some other subsystem
> +like USB, ALSA, SCSI, NetDev, Infiniband, etc. Make sure your
> +driver isn't losing resources from that other subsystem.
> +If this happens, typically the symptom is an Oops (panic) when
> +the subsystem attempts to call into a driver that has been unloaded.
> +
> +
> +4.6 Disable device from responding to MMIO/IO Port addresses
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +io_unmap() MMIO or IO Port resources and then call pci_disable_device().
> +This is the symmetric opposite of pci_enable_device().
> +Do not access device registers after calling pci_disable_device().
> +
> +
> +4.7 release MMIO/IO Port resource(s)

       Release
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Call pci_release_region() to mark the MMIO or IO Port range as available.
> +Failure to do so usually results in the inability to reload the driver.
> +
> +
> +
> +10. Legacy I/O port free driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Fortunately, many PCI devices which request I/O Port resources also
> +provide access to the same registers via MMIO BARs. These devices can
> +be handled without using I/O port space and the drivers typically
> +offer a CONFIG_ option to only use MMIO regions
> +(e.g. CONFIG_TULIP_MMIO). PCI devices typically provide I/O port
> +interface for legacy OSs and will work when I/O port resources are not

                        OSes ?

> +assigned. The "PCI Local Bus Specification Revision 3.0" discusses
> +this on p.44, "IMPLEMENTATION NOTE".
> +
> +
> +
> +11. MMIO Space and "Write Posting"
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Converting a driver from using I/O Port space to using MMIO space
> +often requires some additional changes. Specifically, "write posting"
> +needs to be handled. Many drivers (e.g. tg3, acenic, sym53c8xx_2)
> +already do. I/O Port space guarantees write transactions reach the PCI

   already do this.

> +device before the CPU can continue. Writes to MMIO space allow to CPU
> +continue before the transaction reaches the PCI device. HW weenies
> +call this "Write Posting" because the write completion is "posted" to
> +the CPU before the transaction has reached it's destination.

                                              its (not "it is")

---
~Randy
