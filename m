Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265809AbUFVUHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUFVUHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265761AbUFVUEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:04:12 -0400
Received: from fmr05.intel.com ([134.134.136.6]:20129 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265119AbUFVTzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:55:09 -0400
Date: Tue, 22 Jun 2004 14:48:10 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com>
To: ak@muc.de, akpm@osdl.org, greg@kroah.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, roland@topspin.com,
       tom.l.nguyen@intel.com, zwane@linuxpower.ca
Subject: [PATCH]2.6.7 MSI-X Update
Cc: eli@mellanox.co.il
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 22, 2004 Roland Dreier wrote:  
>Do you have any plans for when this should be fixed?  Right now, with
>the standard kernel, if I unload and then reload my driver module,
>setting up MSI-X fails the second time through because the core has
>not cleaned up the memory region from the first time.

For the case where a device function implements both the MSI 
capability structure and the MSI-X capability structure, the 
MSI support in kernel 2.6.x chooses to enable the MSI-X capability 
structure because one of its key advantages over MSI allows kernel
to provide a device function multiple messages. We've received inputs 
from some IHVs requesting the kernel to provide a device driver the
ability to selectively decide to enable MSI or MSI-X to fit its 
specific needs. 

Also, the kernel may encounter MSI-X vector shortages when handling an 
MSI-X request from a device driver. This can cause a failure to enable
MSI-X if the requested number of vectors are not available. To allow
the driver to still use MSI-X but reduce the number of vectors 
requested to the amount available the kernel should return the maximum
number of MSI-X vectors available to the caller. In addition to the 
device driver requires the ability to selectively decide which MSI-X  
entries of the MSI-X table to be enabled(ABC--, A-B-C, A--CB, etc...). 

As a result, I would like to propose the following changes to the 
current 2.6 MSI implementation:

1.	Make existing API pci_enable_msi(struct pci_dev *dev) to 
	support only MSI.
2.	Consolidate existing msi_alloc_vectors() and 
	msi_free_vectors() into a single API called pci_enable_msix
	(struct pci_dev *dev, unsigned int *data, int nvec) to 
	support MSI-X.
3.	To provide finer granularity in handling MSI/MSI-X vectors 
	freed by a device driver as well as MSI/MSI-X reassign on new
	request.
4.	Update MSI-HOWTO to describe more details on items 1, 2, and 
	3.

For implementation details refer to the patch.

Starting on 06/26, I do not have access to email in two weeks. I'll
respond to lkml inputs after that.

Thanks,
Long

---------------------------------------------------------------------
diff -urN linux-2.6.7/Documentation/MSI-HOWTO.txt patch-2.6.7-msix/Documentation/MSI-HOWTO.txt
--- linux-2.6.7/Documentation/MSI-HOWTO.txt	2004-05-09 22:31:58.000000000 -0400
+++ patch-2.6.7-msix/Documentation/MSI-HOWTO.txt	2004-06-22 10:16:09.000000000 -0400
@@ -3,13 +3,14 @@
 			10/03/2003
 	Revised Feb 12, 2004 by Martine Silbermann
 		email: Martine.Silbermann@hp.com
+	Revised May 24, 2004 by Tom L Nguyen
 
 1. About this guide
 
-This guide describes the basics of Message Signaled Interrupts(MSI), the
-advantages of using MSI over traditional interrupt mechanisms, and how
-to enable your driver to use MSI or MSI-X. Also included is a Frequently
-Asked Questions.
+This guide describes the basics of Message Signaled Interrupts (MSI), 
+the advantages of using MSI over traditional interrupt mechanisms, 
+and how to enable your driver to use MSI or MSI-X. Also included is 
+a Frequently Asked Questions.
 
 2. Copyright 2003 Intel Corporation
 
@@ -35,7 +36,7 @@
 the MSI/MSI-X capability structure in its PCI capability list. The
 device function may implement both the MSI capability structure and
 the MSI-X capability structure; however, the bus driver should not
-enable both, but instead enable only the MSI-X capability structure.
+enable both.
 
 The MSI capability structure contains Message Control register,
 Message Address register and Message Data register. These registers
@@ -86,7 +87,7 @@
 support for better interrupt performance.
 
 Using MSI enables the device functions to support two or more
-vectors, which can be configure to target different CPU's to
+vectors, which can be configured to target different CPU's to
 increase scalability.
 
 5. Configuring a driver to use MSI/MSI-X
@@ -95,26 +96,39 @@
 support this capability. The CONFIG_PCI_USE_VECTOR kernel option
 must be selected to enable MSI/MSI-X support.
 
-5.1 Including MSI support into the kernel
+5.1 Including MSI/MSI-X support into the kernel
 
-To allow MSI-Capable device drivers to selectively enable MSI (using
-pci_enable_msi as described below), the VECTOR based scheme needs to
-be enabled by setting CONFIG_PCI_USE_VECTOR.
+To allow MSI/MSI-X capable device drivers to selectively enable 
+MSI/MSI-X (using pci_enable_msi()/pci_enable_msix() as described 
+below), the VECTOR based scheme needs to be enabled by setting 
+CONFIG_PCI_USE_VECTOR during kernel config.
 
 Since the target of the inbound message is the local APIC, providing
-CONFIG_PCI_USE_VECTOR is dependent on whether CONFIG_X86_LOCAL_APIC
-is enabled or not.
+CONFIG_X86_LOCAL_APIC must be enabled as well as CONFIG_PCI_USE_VECTOR.
 
-int pci_enable_msi(struct pci_dev *)
+5.2 Configuring for MSI support
+
+Due to the non-contiguous fashion in vector assignment of the
+existing Linux kernel, this version does not support multiple
+messages regardless of a device function is capable of supporting
+more than one vector. To enable MSI on a device function's MSI
+capability structure requires a device driver to call the function 
+pci_enable_msi() explicitly.
+
+5.2.1 API pci_enable_msi
+
+int pci_enable_msi(struct pci_dev *dev)
 
 With this new API, any existing device driver, which like to have
-MSI enabled on its device function, must call this explicitly. A
-successful call will initialize the MSI/MSI-X capability structure
-with ONE vector, regardless of whether the device function is
+MSI enabled on its device function, must call this API to enable MSI
+A successful call will initialize the MSI capability structure
+with ONE vector, regardless of whether a device function is
 capable of supporting multiple messages. This vector replaces the
 pre-assigned dev->irq with a new MSI vector. To avoid the conflict
 of new assigned vector with existing pre-assigned vector requires
-the device driver to call this API before calling request_irq(...).
+a device driver to call this API before calling request_irq().
+
+5.2.2 MSI mode vs. legacy mode diagram
 
 The below diagram shows the events, which switches the interrupt
 mode on the MSI-capable device function between MSI mode and
@@ -126,103 +140,238 @@
 	| 	     | ===============>	|			 |
  	 ------------	free_irq      	 ------------------------
 
-5.2 Configuring for MSI support
+Figure 1.0 MSI Mode vs. Legacy Mode
 
-Due to the non-contiguous fashion in vector assignment of the
-existing Linux kernel, this version does not support multiple
-messages regardless of the device function is capable of supporting
-more than one vector. The bus driver initializes only entry 0 of
-this capability if pci_enable_msi(...) is called successfully by
-the device driver.
+In Figure 1.0, a device operates by default in legacy mode. Legacy
+in this context means PCI pin-irq assertion or PCI-Express INTx 
+emulation. A successful MSI request (using pci_enable_msi()) switches 
+a device's interrupt mode to MSI mode. A pre-assigned IOAPIC vector
+stored in dev->irq will be saved by the PCI subsystem and a new 
+assigned MSI vector will replace dev->irq. 
+
+To return back to its default mode, a device driver must call 
+free_irq() using the allocated MSI vector. The PCI subsystem restores a
+device's dev->irq with a pre-assigned IOAPIC vector and marks released
+MSI vector as unused. Once being marked as unused, there is no 
+guarantee that the PCI subsystem will reserve this MSI vector for a
+device. Depending on the availability of current PCI vector resources
+and the number of MSI/MSI-X requests from other drivers, this MSI
+may be re-assigned. For the case where the PCI subsystem re-assigned 
+this MSI vector another driver, a request to switching back to MSI
+mode may result in being assigned a different MSI vector or a failure
+if no more vectors are available.  
 
 5.3 Configuring for MSI-X support
 
-Both the MSI capability structure and the MSI-X capability structure
-share the same above semantics; however, due to the ability of the
-system software to configure each vector of the MSI-X capability
-structure with an independent message address and message data, the
-non-contiguous fashion in vector assignment of the existing Linux
-kernel has no impact on supporting multiple messages on an MSI-X
-capable device functions. By default, as mentioned above, ONE vector
-should be always allocated to the MSI-X capability structure at
-entry 0. The bus driver does not initialize other entries of the
-MSI-X table.
-
-Note that the PCI subsystem should have full control of a MSI-X
-table that resides in Memory Space. The software device driver
-should not access this table.
-
-To request for additional vectors, the device software driver should
-call function msi_alloc_vectors(). It is recommended that the
-software driver should call this function once during the
+Due to the ability of the system software to configure each vector of
+the MSI-X capability structure with an independent message address 
+and message data, the non-contiguous fashion in vector assignment of
+the existing Linux kernel has no impact on supporting multiple 
+messages on an MSI-X capable device functions. To enable MSI-X on 
+a device function's MSI-X capability structure requires its device 
+driver to call the function pci_enable_msix() explicitly.
+
+The function pci_enable_msix(), once invoked, enables either
+all or nothing, depending on the current availability of PCI vector
+resources. If the PCI vector resources are available for the number 
+of vectors requested by a device driver, this function will configure 
+the MSI-X table of the MSI-X capability structure of a device with
+requested messages. To emphasize this reason, for example, a device 
+may be capable for supporting the maximum of 32 vectors while its 
+software driver usually may request 4 vectors. It is recommended
+that the device driver should call this function once during the 
 initialization phase of the device driver.
 
-The function msi_alloc_vectors(), once invoked, enables either
-all or nothing, depending on the current availability of vector
-resources. If no vector resources are available, the device function
-still works with ONE vector. If the vector resources are available
-for the number of vectors requested by the driver, this function
-will reconfigure the MSI-X capability structure of the device with
-additional messages, starting from entry 1. To emphasize this
-reason, for example, the device may be capable for supporting the
-maximum of 32 vectors while its software driver usually may request
-4 vectors.
-
-For each vector, after this successful call, the device driver is
-responsible to call other functions like request_irq(), enable_irq(),
-etc. to enable this vector with its corresponding interrupt service
-handler. It is the device driver's choice to have all vectors shared
-the same interrupt service handler or each vector with a unique
-interrupt service handler.
-
-In addition to the function msi_alloc_vectors(), another function
-msi_free_vectors() is provided to allow the software driver to
-release a number of vectors back to the vector resources. Once
-invoked, the PCI subsystem disables (masks) each vector released.
-These vectors are no longer valid for the hardware device and its
-software driver to use. Like free_irq, it recommends that the
-device driver should also call msi_free_vectors to release all
-additional vectors previously requested.
-
-int msi_alloc_vectors(struct pci_dev *dev, int *vector, int nvec)
-
-This API enables the software driver to request the PCI subsystem
-for additional messages. Depending on the number of vectors
-available, the PCI subsystem enables either all or nothing.
+Unlike the function pci_enable_msi(), the function pci_enable_msix() 
+does not replace the pre-assigned IOAPIC dev->irq with a new MSI 
+vector because the PCI subsystem writes the 1:1 vector-to-entry mapping
+into the field vector of each element contained in a second argument. 
+Note that the pre-assigned IO-APIC dev->irq is valid only if the device
+operates in PIN-IRQ assertion mode. In MSI-X mode, any attempt of
+using dev->irq by the device driver to request for interrupt service
+may result unpredictabe behavior. 
+
+For each MSI-X vector granted, a device driver is responsible to call 
+other functions like request_irq(), enable_irq(), etc. to enable
+this vector with its corresponding interrupt service handler. It is 
+a device driver's choice to assign all vectors with the same 
+interrupt service handler or each vector with a unique interrupt 
+service handler. 
+
+5.3.1 Handling MMIO address space of MSI-X Table
+
+The PCI 3.0 specification has implementation notes that MMIO address
+space for a device's MSI-X structure should be isolated so that the 
+software system can set different page for controlling accesses to 
+the MSI-X structure. The implementation of MSI patch requires the PCI
+subsystem, not a device driver, to maintain full control of the MSI-X
+table/MSI-X PBA and MMIO address space of the MSI-X table/MSI-X PBA. 
+A device driver is prohibited from requesting the MMIO address space 
+of the MSI-X table/MSI-X PBA. Otherwise, the PCI subsystem will fail 
+enabling MSI-X on its hardware device when it calls the function 
+pci_enable_msix().
+
+5.3.2 Handling MSI-X allocation
+
+Determining the number of MSI-X vectors allocated to a function is 
+dependent on the number of MSI capable devices and MSI-X capable
+devices populated in the system. The policy of allocating MSI-X 
+vectors to a function is defined as the following:
+
+#of MSI-X vectors allocated to a function = (x - y)/z where
+
+x = 	The number of available PCI vector resources by the time 
+	the device driver calls pci_enable_msix(). The PCI vector
+	resources is the sum of the number of unassigned vectors
+	(new) and the number of released vectors when any MSI/MSI-X
+	device driver switches its hardware device back to a legacy
+	mode or is hot-removed.	The number of unassigned vectors
+	may exclude some vectors reserved, as defined in parameter
+	NR_HP_RESERVED_VECTORS, for the case where the system is 
+	capable of supporting hot-add/hot-remove operations. Users
+	may change the value defined in NR_HR_RESERVED_VECTORS to
+	meet their specific needs. 
+
+y =	The number of MSI capable devices populated in the system.
+	This policy ensures that each MSI capable device has its
+	vector reserved to avoid the case where some MSI-X capable
+	drivers may attempt to claim all available vector resources.
+
+z =	The number of MSI-X capable devices pupulated in the system.
+	This policy ensures that maximum (x - y) is distributed 
+	evenly among MSI-X capable devices.	
+    
+Note that the PCI subsystem scans y and z during a bus enumeration.
+When the PCI subsystem completes configuring MSI/MSI-X capability
+structure of a device as requested by its device driver, y/z is 
+decremented accordingly.  
+
+5.3.3 Handling MSI-X shortages
+
+For the case where fewer MSI-X vectors are allocated to a function 
+than requested, the function pci_enable_msix() will return the
+maximum number of MSI-X vectors available to the caller. A device 
+driver may re-send its request with fewer or equal vectors indicated
+in a return. For example, if a device driver requests 5 vectors, but 
+the number of available vectors is 3 vectors, a value of 3 will be a 
+return as a result of pci_enable_msix() call. A function could be 
+designed for its driver to use only 3 MSI-X table entries as 
+different combinations as ABC--, A-B-C, A--CB, etc. Note that this 
+patch does not support multiple entries with the same vector. Such 
+attempt by a device driver to use 5 MSI-X table entries with 3 vectors
+as ABBCC, AABCC, BCCBA, etc will result as a failure by the function
+pci_enable_msix(). Below are the reasons why supporting multiple 
+entries with the same vector is an undesirable solution.
+	
+	- The PCI subsystem can not determine which entry, which
+	  generated the message, to mask/unmask MSI while handling
+	  software driver ISR. Attempting to walk through all MSI-X 
+	  table entries (2048 max) to mask/unmask any match vector 
+	  is an undesirable solution. 
+
+	- Walk through all MSI-X table entries (2048 max) to handle
+	  SMP affinity of any match vector is an undesirable solution. 
+
+5.3.4 API pci_enable_msix
+
+int pci_enable_msix(struct pci_dev *dev, u32 *entries, int nvec)
+
+This API enables a device driver to request the PCI subsystem
+for enabling MSI-X messages on its hardware device. Depending on 
+the availability of PCI vectors resources, the PCI subsystem enables
+either all or nothing.
 
 Argument dev points to the device (pci_dev) structure.
-Argument vector is a pointer of integer type. The number of
-elements is indicated in argument nvec.
+
+Argument entries is a pointer of unsigned integer type. The number of
+elements is indicated in argument nvec. The content of each element 
+will be mapped to the following struct defined in /driver/pci/msi.h.
+
+struct msix_entry {
+	__u32 	vector	: 16; /* kernel uses to write alloc vector */
+	__u32	entry	: 16; /* driver uses to specify entry */
+};
+
+A device driver is responsible for initializing the field entry of 
+each element with unique entry supported by MSI-X table. Otherwise, 
+-EINVAL will be returned as a result. A successful return of zero 
+indicates the PCI subsystem completes initializing each of requested 
+entries of the MSI-X table with message address and message data. 
+Last but not least, the PCI subsystem will write the 1:1 
+vector-to-entry mapping into the field vector of each element. A 
+device driver is responsible of keeping track of allocated MSI-X
+vectors in its internal data structure.
+
 Argument nvec is an integer indicating the number of messages
 requested.
-A return of zero indicates that the number of allocated vector is
-successfully allocated. Otherwise, indicate resources not
-available.
-
-int msi_free_vectors(struct pci_dev* dev, int *vector, int nvec)
-
-This API enables the software driver to inform the PCI subsystem
-that it is willing to release a number of vectors back to the
-MSI resource pool. Once invoked, the PCI subsystem disables each
-MSI-X entry associated with each vector stored in the argument 2.
-These vectors are no longer valid for the hardware device and
-its software driver to use.
 
-Argument dev points to the device (pci_dev) structure.
-Argument vector is a pointer of integer type. The number of
-elements is indicated in argument nvec.
-Argument nvec is an integer indicating the number of messages
-released.
-A return of zero indicates that the number of allocated vectors
-is successfully released. Otherwise, indicates a failure.
+A return of zero indicates that the number of MSI-X vectors is
+successfully allocated. A return of greater than zero indicates
+MSI-X vector shortage. Or a return of less than zero indicates
+a failure. This failure may be a result of duplicate entries 
+specified in second argument, or a result of no available vector,
+or a result of failing to initialize MSI-X table entries.
+
+5.3.5 MSI-X mode vs. legacy mode diagram
+
+The below diagram shows the events, which switches the interrupt
+mode on the MSI-X capable device function between MSI-X mode and
+PIN-IRQ assertion mode (legacy).
+
+	 ------------   pci_enable_msix(,,n) ------------------------
+	|	     | <===============	    | 			     |
+	| MSI-X MODE |	  	     	    | PIN-IRQ ASSERTION MODE |
+	| 	     | ===============>	    |			     |
+ 	 ------------	(n)free_irq    	     ------------------------
+
+Figure 2.0 MSI-X Mode vs. Legacy Mode
+
+In Figure 2.0, a device operates by default in legacy mode. A 
+successful MSI-X request (using pci_enable_msix()) switches a 
+device's interrupt mode to MSI-X mode. A pre-assigned IOAPIC vector
+stored in dev->irq will be saved by the PCI subsystem; however, 
+unlike MSI mode, the PCI subsystem will not replace dev->irq with 
+assigned MSI-x vector because the PCI subsystem already writes the 1:1 
+vector-to-entry mapping into the field vector of each element 
+specified in second argument.
+
+To return back to its default mode, a device driver requires to call 
+free_irq() on all allocated MSI vectors. Unlike MSI mode, the PCI 
+subsystem switches a device function back to its default legacy mode
+if and only if its device driver successfully releases all allocated 
+MSI-X vectors (n) through (n) number of free_irq calls.
+
+Note that if a device still operates in MSI-X mode, its device 
+driver can use request_irq/free_irq to any vectors in subset n. When
+the PCI subsystem detects all MSI-X vectors being released by a device
+driver, it will switches a function's interrupt mode from MSI-X mode
+to legacy mode and mark all allocated MSI-X vectors as unused. Once 
+being marked as unused, there is no guarantee that the PCI subsystem 
+will reserve these MSI-X vectors for a device. Depending on the 
+availability of current PCI vector resources and the number of 
+MSI/MSI-X requests from other drivers, these MSI-X vectors may be 
+re-assigned. For the case where the PCI subsystem re-assigned 
+these MSI-X vectors to other driver, a request to switching back to 
+MSI-X mode may result being assigned with another set of MSI-X vectors
+or a failure.  
+
+5.4 Handling function implementng both MSI and MSI-X capabilities
+
+For the case where a function implements both MSI and MSI-X 
+capabilities, the PCI subsystem enables a device to run either in MSI
+mode or MSI-X mode but not both. A device driver determines whether it
+wants MSI or MSI-X enabled on its hardware device. Once a device 
+driver requests for MSI, for example, it is prohibited to request for
+MSI-X; in other words, a device driver is not permitted to ping-pong
+between MSI mod MSI-X mode during a run-time.
 
-5.4 Hardware requirements for MSI support
-MSI support requires support from both system hardware and
+5.5 Hardware requirements for MSI/MSI-X support
+MSI/MSI-X support requires support from both system hardware and
 individual hardware device functions.
 
-5.4.1 System hardware support
+5.5.1 System hardware support
 Since the target of MSI address is the local APIC CPU, enabling
-MSI support in Linux kernel is dependent on whether existing
+MSI/MSI-X support in Linux kernel is dependent on whether existing
 system hardware supports local APIC. Users should verify their
 system whether it runs when CONFIG_X86_LOCAL_APIC=y.
 
@@ -231,14 +380,14 @@
 CONFIG_X86_LOCAL_APIC. Once CONFIG_X86_LOCAL_APIC=y, setting
 CONFIG_PCI_USE_VECTOR enables the VECTOR based scheme and
 the option for MSI-capable device drivers to selectively enable
-MSI (using pci_enable_msi as described below).
+MSI/MSI-X.
 
-Note that CONFIG_X86_IO_APIC setting is irrelevant because MSI
-vector is allocated new during runtime and MSI support does not
-depend on BIOS support. This key independency enables MSI support
-on future IOxAPIC free platform.
+Note that CONFIG_X86_IO_APIC setting is irrelevant because MSI/MSI-X
+vector is allocated new during runtime and MSI/MSI-X support does not
+depend on BIOS support. This key independency enables MSI/MSI-X 
+support on future IOxAPIC free platform.
 
-5.4.2 Device hardware support
+5.5.2 Device hardware support
 The hardware device function supports MSI by indicating the
 MSI/MSI-X capability structure on its PCI capability list. By
 default, this capability structure will not be initialized by
@@ -249,17 +398,19 @@
 MSI-capable hardware is responsible for whether calling
 pci_enable_msi or not. A return of zero indicates the kernel
 successfully initializes the MSI/MSI-X capability structure of the
-device funtion. The device function is now running on MSI mode.
+device funtion. The device function is now running on MSI/MSI-X mode.
 
-5.5 How to tell whether MSI is enabled on device function
+5.6 How to tell whether MSI/MSI-X is enabled on device function
 
-At the driver level, a return of zero from pci_enable_msi(...)
-indicates to the device driver that its device function is
-initialized successfully and ready to run in MSI mode.
+At the driver level, a return of zero from the function call of 
+pci_enable_msi()/pci_enable_msix() indicates to a device driver that
+its device function is initialized successfully and ready to run in 
+MSI/MSI-X mode.
 
 At the user level, users can use command 'cat /proc/interrupts'
-to display the vector allocated for the device and its interrupt
-mode, as shown below.
+to display the vector allocated for a device and its interrupt
+MSI/MSI-X mode ("PCI MSI"/"PCI MSIX"). Below shows below MSI mode is 
+enabled on a SCSI Adaptec 39320D Ultra320.  
 
            CPU0       CPU1
   0:     324639          0    IO-APIC-edge  timer
diff -urN linux-2.6.7/drivers/pci/msi.c patch-2.6.7-msix/drivers/pci/msi.c
--- linux-2.6.7/drivers/pci/msi.c	2004-05-09 22:33:20.000000000 -0400
+++ patch-2.6.7-msix/drivers/pci/msi.c	2004-06-22 11:53:03.000000000 -0400
@@ -179,6 +179,18 @@
 
 static unsigned int startup_msi_irq_w_maskbit(unsigned int vector)
 {
+	struct msi_desc *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msi_lock, flags);
+	entry = msi_desc[vector];
+	if (!entry || !entry->dev) {
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return 0;
+	}
+	entry->msi_attrib.state = 1;		/* Mark it active */
+	spin_unlock_irqrestore(&msi_lock, flags);
+	
 	unmask_MSI_irq(vector);
 	return 0;	/* never anything pending */
 }
@@ -200,7 +212,7 @@
  * which implement the MSI-X Capability Structure.
  */
 static struct hw_interrupt_type msix_irq_type = {
-	.typename	= "PCI MSI-X",
+	.typename	= "PCI-MSI-X",
 	.startup	= startup_msi_irq_w_maskbit,
 	.shutdown	= shutdown_msi_irq_w_maskbit,
 	.enable		= enable_msi_irq_w_maskbit,
@@ -216,7 +228,7 @@
  * Mask-and-Pending Bits.
  */
 static struct hw_interrupt_type msi_irq_w_maskbit_type = {
-	.typename	= "PCI MSI",
+	.typename	= "PCI-MSI",
 	.startup	= startup_msi_irq_w_maskbit,
 	.shutdown	= shutdown_msi_irq_w_maskbit,
 	.enable		= enable_msi_irq_w_maskbit,
@@ -232,7 +244,7 @@
  * Mask-and-Pending Bits.
  */
 static struct hw_interrupt_type msi_irq_wo_maskbit_type = {
-	.typename	= "PCI MSI",
+	.typename	= "PCI-MSI",
 	.startup	= startup_msi_irq_wo_maskbit,
 	.shutdown	= shutdown_msi_irq_wo_maskbit,
 	.enable		= enable_msi_irq_wo_maskbit,
@@ -265,6 +277,7 @@
 	msi_address->lo_address.value |= (MSI_TARGET_CPU << MSI_TARGET_CPU_SHIFT);
 }
 
+static int msi_free_vector(struct pci_dev* dev, int vector, int reassign);
 static int assign_msi_vector(void)
 {
 	static int new_vector_avail = 1;
@@ -278,6 +291,8 @@
 	spin_lock_irqsave(&msi_lock, flags);
 
 	if (!new_vector_avail) {
+		int free_vector = 0;
+		
 		/*
 	 	 * vector_irq[] = -1 indicates that this specific vector is:
 	 	 * - assigned for MSI (since MSI have no associated IRQ) or
@@ -294,13 +309,34 @@
 		for (vector = FIRST_DEVICE_VECTOR; vector < NR_IRQS; vector++) {
 			if (vector_irq[vector] != 0)
 				continue;
-			vector_irq[vector] = -1;
-			nr_released_vectors--;
-			spin_unlock_irqrestore(&msi_lock, flags);
-			return vector;
+			free_vector = vector;
+			if (!msi_desc[vector]) 
+			      	break;	
+			else
+				continue;
 		}
+		if (!free_vector) {
+			spin_unlock_irqrestore(&msi_lock, flags);
+			return -EBUSY;
+		}	
+		vector_irq[free_vector] = -1;
+		nr_released_vectors--;
 		spin_unlock_irqrestore(&msi_lock, flags);
-		return -EBUSY;
+		if (msi_desc[free_vector] != NULL) {
+			struct pci_dev *dev;
+			int tail;
+			
+			/* free all linked vectors before re-assign */
+			do {
+				spin_lock_irqsave(&msi_lock, flags);
+				dev = msi_desc[free_vector]->dev;
+				tail = msi_desc[free_vector]->link.tail;
+				spin_unlock_irqrestore(&msi_lock, flags);
+				msi_free_vector(dev, tail, 1);
+			} while (free_vector != tail);
+		}
+	       	
+		return free_vector;
 	}
 	vector = assign_irq_vector(AUTO_ASSIGN);
 	last_alloc_vector = vector;
@@ -333,6 +369,15 @@
 		printk(KERN_INFO "WARNING: MSI INIT FAILURE\n");
 		return status;
 	}
+	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN);
+	if (last_alloc_vector < 0) {
+		pci_msi_enable = 0;
+		printk(KERN_INFO "WARNING: ALL VECTORS ARE BUSY\n");
+		status = -EBUSY;
+		return status;
+	}
+	vector_irq[last_alloc_vector] = 0;
+	nr_released_vectors++;
 	printk(KERN_INFO "MSI INIT SUCCESS\n");
 
 	return status;
@@ -431,7 +476,7 @@
 	}
 }
 
-static int msi_lookup_vector(struct pci_dev *dev)
+static int msi_lookup_vector(struct pci_dev *dev, int type)
 {
 	int vector;
 	unsigned long flags;
@@ -439,11 +484,11 @@
 	spin_lock_irqsave(&msi_lock, flags);
 	for (vector = FIRST_DEVICE_VECTOR; vector < NR_IRQS; vector++) {
 		if (!msi_desc[vector] || msi_desc[vector]->dev != dev ||
-			msi_desc[vector]->msi_attrib.entry_nr ||
+			msi_desc[vector]->msi_attrib.type != type ||
 			msi_desc[vector]->msi_attrib.default_vector != dev->irq)
-			continue;	/* not entry 0, skip */
+			continue;	
 		spin_unlock_irqrestore(&msi_lock, flags);
-		/* This pre-assigned entry-0 MSI vector for this device
+		/* This pre-assigned MSI vector for this device
 		   already exits. Override dev->irq with this vector */
 		dev->irq = vector;
 		return 0;
@@ -458,10 +503,9 @@
 	if (!dev)
 		return;
 
-   	if (pci_find_capability(dev, PCI_CAP_ID_MSIX) > 0) {
-		nr_reserved_vectors++;
+   	if (pci_find_capability(dev, PCI_CAP_ID_MSIX) > 0) 
 		nr_msix_devices++;
-	} else if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0)
+	else if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0)
 		nr_reserved_vectors++;
 }
 
@@ -483,19 +527,8 @@
 	u32 control;
 
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (!pos)
-		return -EINVAL;
-
 	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
 		2, &control);
-	if (control & PCI_MSI_FLAGS_ENABLE)
-		return 0;
-
-	if (!msi_lookup_vector(dev)) {
-		/* Lookup Sucess */
-		enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
-		return 0;
-	}
 	/* MSI Entry Initialization */
 	if (!(entry = alloc_msi_entry()))
 		return -ENOMEM;
@@ -504,11 +537,14 @@
 		kmem_cache_free(msi_cachep, entry);
 		return -EBUSY;
 	}
+	entry->link.head = vector;
+	entry->link.tail = vector;
 	entry->msi_attrib.type = PCI_CAP_ID_MSI;
+	entry->msi_attrib.state = 1;			/* Mark it active */
 	entry->msi_attrib.entry_nr = 0;
 	entry->msi_attrib.maskbit = is_mask_bit_support(control);
-	entry->msi_attrib.default_vector = dev->irq;
-	dev->irq = vector;	/* save default pre-assigned ioapic vector */
+	entry->msi_attrib.default_vector = dev->irq;	/* Save IOAPIC IRQ */
+	dev->irq = vector;	
 	entry->dev = dev;
 	if (is_mask_bit_support(control)) {
 		entry->mask_base = msi_mask_bits_reg(pos,
@@ -556,135 +592,170 @@
  * @dev: pointer to the pci_dev data structure of MSI-X device function
  *
  * Setup the MSI-X capability structure of device funtion with a
- * single MSI-X vector. A return of zero indicates the successful setup
- * of an entry zero with the new MSI-X vector or non-zero for otherwise.
- * To request for additional MSI-X vectors, the device drivers are
- * required to utilize the following supported APIs:
- * 1) msi_alloc_vectors(...) for requesting one or more MSI-X vectors
- * 2) msi_free_vectors(...) for releasing one or more MSI-X vectors
- *    back to PCI subsystem before calling free_irq(...)
+ * single MSI-X vector. A return of zero indicates the successful setup of
+ * requested MSI-X entries with allocated vectors or non-zero for otherwise.
  **/
-static int msix_capability_init(struct pci_dev	*dev)
+static int msix_capability_init(struct pci_dev *dev, 
+				struct msix_entry *entries, int nvec)
 {
-	struct msi_desc *entry;
+	struct msi_desc *head = NULL, *tail = NULL, *entry = NULL;
 	struct msg_address address;
 	struct msg_data data;
-	int vector = 0, pos, dev_msi_cap;
+	int vector, pos, i, j, nr_entries, temp = 0;
 	u32 phys_addr, table_offset;
 	u32 control;
 	u8 bir;
 	void *base;
-
+	
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (!pos)
-		return -EINVAL;
-
 	/* Request & Map MSI-X table region */
 	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 2,
 		&control);
-	if (control & PCI_MSIX_FLAGS_ENABLE)
-		return 0;
-
-	if (!msi_lookup_vector(dev)) {
-		/* Lookup Sucess */
-		enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
-		return 0;
-	}
-
-	dev_msi_cap = multi_msix_capable(control);
+	nr_entries = multi_msix_capable(control);
 	dev->bus->ops->read(dev->bus, dev->devfn,
 		msix_table_offset_reg(pos), 4, &table_offset);
 	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
 	phys_addr = pci_resource_start (dev, bir);
 	phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
 	if (!request_mem_region(phys_addr,
-		dev_msi_cap * PCI_MSIX_ENTRY_SIZE,
-		"MSI-X iomap Failure"))
+		nr_entries * PCI_MSIX_ENTRY_SIZE,
+		"MSI-X vector table"))
 		return -ENOMEM;
-	base = ioremap_nocache(phys_addr, dev_msi_cap * PCI_MSIX_ENTRY_SIZE);
-	if (base == NULL)
-		goto free_region;
-	/* MSI Entry Initialization */
-	entry = alloc_msi_entry();
-	if (!entry)
-		goto free_iomap;
-	if ((vector = get_msi_vector(dev)) < 0)
-		goto free_entry;
-
-	entry->msi_attrib.type = PCI_CAP_ID_MSIX;
-	entry->msi_attrib.entry_nr = 0;
-	entry->msi_attrib.maskbit = 1;
-	entry->msi_attrib.default_vector = dev->irq;
-	dev->irq = vector;	/* save default pre-assigned ioapic vector */
-	entry->dev = dev;
-	entry->mask_base = (unsigned long)base;
-	/* Replace with MSI handler */
-	irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
-	/* Configure MSI-X capability structure */
-	msi_address_init(&address);
-	msi_data_init(&data, vector);
-	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
-				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
-	writel(address.lo_address.value, base + PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-	writel(address.hi_address, base + PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-	writel(*(u32*)&data, base + PCI_MSIX_ENTRY_DATA_OFFSET);
-	/* Initialize all entries from 1 up to 0 */
-	for (pos = 1; pos < dev_msi_cap; pos++) {
-		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+	base = ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
+	if (base == NULL) {
+		release_mem_region(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
+		return -ENOMEM;
+	}
+	/* MSI-X Table Initialization */
+	for (i = 0; i < nvec; i++) {
+		entry = alloc_msi_entry();
+		if (!entry)
+			break;	
+		if ((vector = get_msi_vector(dev)) < 0)
+			break; 	
+
+		j = (entries + i)->entry;
+		(entries + i)->vector = vector;
+		entry->msi_attrib.type = PCI_CAP_ID_MSIX;
+		entry->msi_attrib.state = 1;		/* Mark it active */
+		entry->msi_attrib.entry_nr = j;
+		entry->msi_attrib.maskbit = 1;
+		entry->msi_attrib.default_vector = dev->irq;
+		entry->dev = dev;
+		entry->mask_base = (unsigned long)base;
+		if (!head) {
+			entry->link.head = vector;
+			entry->link.tail = vector;
+			head = entry;
+		} else {
+			entry->link.head = temp;
+			entry->link.tail = tail->link.tail;
+			tail->link.tail = vector;
+			head->link.head = vector;
+		}
+		temp = vector;
+		tail = entry;
+		/* Replace with MSI-X handler */
+		irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
+		/* Configure MSI-X capability structure */
+		msi_address_init(&address);
+		msi_data_init(&data, vector);
+		entry->msi_attrib.current_cpu = 
+			((address.lo_address.u.dest_id >>
+			MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
+		writel(address.lo_address.value, 
+			base + j * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+		writel(address.hi_address, 
+			base + j * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+		writel(*(u32*)&data, 
+			base + j * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_DATA_OFFSET);
+		attach_msi_entry(entry, vector);
 	}
-	attach_msi_entry(entry, vector);
-	/* Set MSI enabled bits	 */
+	if (i != nvec) {
+		i--;
+		for (; i >= 0; i--) {
+			vector = (entries + i)->vector;
+			msi_free_vector(dev, vector, 0);
+			(entries + i)->vector = 0;
+		}
+		return -EBUSY;
+	}
+	/* Set MSI-X enabled bits */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
-
+	
 	return 0;
-
-free_entry:
-	kmem_cache_free(msi_cachep, entry);
-free_iomap:
-	iounmap(base);
-free_region:
-	release_mem_region(phys_addr, dev_msi_cap * PCI_MSIX_ENTRY_SIZE);
-
-	return ((vector < 0) ? -EBUSY : -ENOMEM);
 }
 
 /**
- * pci_enable_msi - configure device's MSI(X) capability structure
- * @dev: pointer to the pci_dev data structure of MSI(X) device function
+ * pci_enable_msi - configure device's MSI capability structure
+ * @dev: pointer to the pci_dev data structure of MSI device function
  *
- * Setup the MSI/MSI-X capability structure of device function with
- * a single MSI(X) vector upon its software driver call to request for
- * MSI(X) mode enabled on its hardware device function. A return of zero
- * indicates the successful setup of an entry zero with the new MSI(X)
+ * Setup the MSI capability structure of device function with
+ * a single MSI vector upon its software driver call to request for
+ * MSI mode enabled on its hardware device function. A return of zero
+ * indicates the successful setup of an entry zero with the new MSI
  * vector or non-zero for otherwise.
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
-	int status = -EINVAL;
+	int pos, temp = dev->irq, status = -EINVAL;
+	u32 control;
 
 	if (!pci_msi_enable || !dev)
  		return status;
 
-	if (msi_init() < 0)
-		return -ENOMEM;
+	if ((status = msi_init()) < 0)
+		return status;
 
-	if ((status = msix_capability_init(dev)) == -EINVAL)
-		status = msi_capability_init(dev);
-	if (!status)
-		nr_reserved_vectors--;
+   	if (!(pos = pci_find_capability(dev, PCI_CAP_ID_MSI)))
+		return -EINVAL;
+
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
+		2, &control);
+	if (control & PCI_MSI_FLAGS_ENABLE)
+		return 0;			/* Already in MSI mode */
+
+	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
+		/* Lookup Sucess */
+		unsigned long flags;
+
+		spin_lock_irqsave(&msi_lock, flags);
+		if (!vector_irq[dev->irq]) {
+			msi_desc[dev->irq]->msi_attrib.state = 1;	
+			vector_irq[dev->irq] = -1;			
+			nr_released_vectors--;
+			spin_unlock_irqrestore(&msi_lock, flags);
+			enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+			return 0;
+		}
+		spin_unlock_irqrestore(&msi_lock, flags);
+		dev->irq = temp;
+	}
+	/* Check whether driver already requested for MSI-X vectors */
+   	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) > 0 && 
+		!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
+			printk(KERN_INFO "Can't enable MSI. Device already had MSI-X vectors assigned\n");
+			dev->irq = temp;
+			return -EINVAL;	
+	}		
+	status = msi_capability_init(dev);
+	if (!status) {
+   		if (!pos) 
+			nr_reserved_vectors--;	/* Only MSI capable */
+		else if (nr_msix_devices > 0) 
+			nr_msix_devices--;	/* Both MSI and MSI-X capable, 
+						   but choose enabling MSI */
+	}
 
 	return status;
 }
 
-static int msi_free_vector(struct pci_dev* dev, int vector);
 static void pci_disable_msi(unsigned int vector)
 {
-	int head, tail, type, default_vector;
+	int type, default_vector;
 	struct msi_desc *entry;
 	struct pci_dev *dev;
 	unsigned long flags;
@@ -697,168 +768,235 @@
 	}
 	dev = entry->dev;
 	type = entry->msi_attrib.type;
-	head = entry->link.head;
-	tail = entry->link.tail;
+	entry->msi_attrib.state = 0;		/* Mark it not active */
 	default_vector = entry->msi_attrib.default_vector;
 	spin_unlock_irqrestore(&msi_lock, flags);
-
-	disable_msi_mode(dev, pci_find_capability(dev, type), type);
-	/* Restore dev->irq to its default pin-assertion vector */
-	dev->irq = default_vector;
-	if (type == PCI_CAP_ID_MSIX && head != tail) {
-		/* Bad driver, which do not call msi_free_vectors before exit.
-		   We must do a cleanup here */
-		while (1) {
-			spin_lock_irqsave(&msi_lock, flags);
-			entry = msi_desc[vector];
-			head = entry->link.head;
-			tail = entry->link.tail;
+	switch (type) {
+	case PCI_CAP_ID_MSI:
+		spin_lock_irqsave(&msi_lock, flags);
+		vector_irq[vector] = 0;		/* Mark it free */
+		nr_released_vectors++;
+		spin_unlock_irqrestore(&msi_lock, flags);
+		break;
+	case PCI_CAP_ID_MSIX:
+		spin_lock_irqsave(&msi_lock, flags);
+		while (vector != entry->link.tail) {
+			entry = msi_desc[entry->link.tail];
+			if (!entry->msi_attrib.state)
+				continue;
 			spin_unlock_irqrestore(&msi_lock, flags);
-			if (tail == head)
-				break;
-			if (msi_free_vector(dev, entry->link.tail))
-				break;
+			/* 
+			 * Device still operates in MSI-X mode. Do not
+			 * switch interrupt mode
+			 */
+			return;
 		}
+		entry = msi_desc[vector];
+		vector_irq[vector] = 0; 		  /* Mark it free */
+		nr_released_vectors++;
+		while (vector != entry->link.tail) {
+			vector_irq[entry->link.tail] = 0; /* Mark it free */
+			nr_released_vectors++;
+			entry = msi_desc[entry->link.tail];
+		} 
+		spin_unlock_irqrestore(&msi_lock, flags);
+		break;
+	default:
+		return;
 	}
+	/* Restore dev->irq to its default pin-assertion vector */
+	dev->irq = default_vector;
+	disable_msi_mode(dev, pci_find_capability(dev, type), type);
 }
 
-static int msi_alloc_vector(struct pci_dev* dev, int head)
+static int msi_free_vector(struct pci_dev* dev, int vector, int reassign)
 {
 	struct msi_desc *entry;
-	struct msg_address address;
-	struct msg_data data;
-	int i, offset, pos, dev_msi_cap, vector;
-	u32 low_address, control;
+	int head, entry_nr, type;
 	unsigned long base = 0L;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[dev->irq];
-	if (!entry) {
+	entry = msi_desc[vector];
+	if (!entry || entry->dev != dev) {
 		spin_unlock_irqrestore(&msi_lock, flags);
 		return -EINVAL;
 	}
+	type = entry->msi_attrib.type;
+	entry_nr = entry->msi_attrib.entry_nr;
+	head = entry->link.head;
 	base = entry->mask_base;
-	spin_unlock_irqrestore(&msi_lock, flags);
-
-   	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
-		2, &control);
-	dev_msi_cap = multi_msix_capable(control);
-	for (i = 1; i < dev_msi_cap; i++) {
-		if (!(low_address = readl(base + i * PCI_MSIX_ENTRY_SIZE)))
-			 break;
+	msi_desc[entry->link.head]->link.tail = entry->link.tail;
+	msi_desc[entry->link.tail]->link.head = entry->link.head;
+	entry->dev = NULL;
+	if (!reassign) {
+		vector_irq[vector] = 0;
+		nr_released_vectors++;
 	}
-	if (i >= dev_msi_cap)
-		return -EINVAL;
+	msi_desc[vector] = NULL;
+	spin_unlock_irqrestore(&msi_lock, flags);
 
-	/* MSI Entry Initialization */
-	if (!(entry = alloc_msi_entry()))
-		return -ENOMEM;
+	kmem_cache_free(msi_cachep, entry);
 
-	if ((vector = get_new_vector()) < 0) {
-		kmem_cache_free(msi_cachep, entry);
-		return vector;
+	if (type == PCI_CAP_ID_MSIX) {
+		if (!reassign) 
+			writel(1, base + 
+				entry_nr * PCI_MSIX_ENTRY_SIZE +
+				PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
+		
+		if (head == vector) {
+			/* 
+			 * Detect last MSI-X vector to be released.
+			 * Release the MSI-X memory-mapped table.
+			 */
+			int pos, nr_entries;
+			u32 phys_addr, table_offset;
+			u32 control;
+			u8 bir;
+
+   			pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+			dev->bus->ops->read(dev->bus, dev->devfn, 
+				msi_control_reg(pos), 2, &control);
+			nr_entries = multi_msix_capable(control);
+			dev->bus->ops->read(dev->bus, dev->devfn,
+				msix_table_offset_reg(pos), 4, &table_offset);
+			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+			phys_addr = pci_resource_start (dev, bir);
+			phys_addr += (u32)(table_offset & 
+				~PCI_MSIX_FLAGS_BIRMASK);
+			iounmap((void*)base);
+			release_mem_region(phys_addr, 
+				nr_entries * PCI_MSIX_ENTRY_SIZE);
+		}
 	}
-	entry->msi_attrib.type = PCI_CAP_ID_MSIX;
-	entry->msi_attrib.entry_nr = i;
-	entry->msi_attrib.maskbit = 1;
-	entry->dev = dev;
-	entry->link.head = head;
-	entry->mask_base = base;
-	irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
-	/* Configure MSI-X capability structure */
-	msi_address_init(&address);
-	msi_data_init(&data, vector);
-	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
-				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
-	offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
-	writel(address.lo_address.value, base + offset +
-		PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-	writel(address.hi_address, base + offset +
-		PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-	writel(*(u32*)&data, base + offset + PCI_MSIX_ENTRY_DATA_OFFSET);
-	writel(1, base + offset + PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
-	attach_msi_entry(entry, vector);
 
-	return vector;
+	return 0;
 }
 
-static int msi_free_vector(struct pci_dev* dev, int vector)
+static int reroute_msix_table(int head, struct msix_entry *entries, int *nvec)
 {
-	struct msi_desc *entry;
-	int entry_nr, type;
+	int vector = head, tail = 0;
+	int i = 0, j = 0, nr_entries = 0;
 	unsigned long base = 0L;
 	unsigned long flags;
-
+		
 	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[vector];
-	if (!entry || entry->dev != dev) {
+	while (head != tail) {
+		nr_entries++;
+		tail = msi_desc[vector]->link.tail;
+		if (entries->entry == msi_desc[vector]->msi_attrib.entry_nr)
+			j = vector;
+		vector = tail;
+	}
+	if (*nvec > nr_entries) {
 		spin_unlock_irqrestore(&msi_lock, flags);
+		*nvec = nr_entries;
 		return -EINVAL;
 	}
-	type = entry->msi_attrib.type;
-	entry_nr = entry->msi_attrib.entry_nr;
-	base = entry->mask_base;
-	if (entry->link.tail != entry->link.head) {
-		msi_desc[entry->link.head]->link.tail = entry->link.tail;
-		if (entry->link.tail)
-			msi_desc[entry->link.tail]->link.head = entry->link.head;
+	vector = ((j > 0) ? j : head);
+	for (i = 0; i < *nvec; i++) {
+		j = msi_desc[vector]->msi_attrib.entry_nr;
+		msi_desc[vector]->msi_attrib.state = 1;	/* Mark it active */
+		vector_irq[vector] = -1;		/* Mark it busy */	
+		nr_released_vectors--;
+		(entries + i)->vector = vector;
+		if (j != (entries + i)->entry) {
+			base = msi_desc[vector]->mask_base;
+			msi_desc[vector]->msi_attrib.entry_nr =	
+				(entries + i)->entry;
+			writel( readl(base + j * PCI_MSIX_ENTRY_SIZE +
+				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET), base + 
+				(entries + i)->entry * PCI_MSIX_ENTRY_SIZE +
+				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+			writel(	readl(base + j * PCI_MSIX_ENTRY_SIZE +
+				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET), base + 
+				(entries + i)->entry * PCI_MSIX_ENTRY_SIZE +
+				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
+			writel( (readl(base + j * PCI_MSIX_ENTRY_SIZE +
+				PCI_MSIX_ENTRY_DATA_OFFSET) & 0xff00) | vector,
+				base + (entries+i)->entry*PCI_MSIX_ENTRY_SIZE + 
+				PCI_MSIX_ENTRY_DATA_OFFSET);
+		}
+		vector = msi_desc[vector]->link.tail;
 	}
-	entry->dev = NULL;
-	vector_irq[vector] = 0;
-	nr_released_vectors++;
-	msi_desc[vector] = NULL;
 	spin_unlock_irqrestore(&msi_lock, flags);
-
-	kmem_cache_free(msi_cachep, entry);
-	if (type == PCI_CAP_ID_MSIX) {
-		int offset;
-
-		offset = entry_nr * PCI_MSIX_ENTRY_SIZE;
-		writel(1, base + offset + PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
-		writel(0, base + offset + PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-	}
-
+	
 	return 0;
 }
 
 /**
- * msi_alloc_vectors - allocate additional MSI-X vectors
+ * pci_enable_msix - configure device's MSI-X capability structure
  * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @vector: pointer to an array of new allocated MSI-X vectors
+ * @data: pointer to an array of MSI-X entries
  * @nvec: number of MSI-X vectors requested for allocation by device driver
  *
- * Allocate additional MSI-X vectors requested by device driver. A
- * return of zero indicates the successful setup of MSI-X capability
- * structure with new allocated MSI-X vectors or non-zero for otherwise.
+ * Setup the MSI-X capability structure of device function with the number
+ * of requested vectors upon its software driver call to request for
+ * MSI-X mode enabled on its hardware device function. A return of zero
+ * indicates the successful configuration of MSI-X capability structure 
+ * with new allocated MSI-X vectors. A return of < 0 indicates a failure. 
+ * Or a return of > 0 indicates that driver request is exceeding the number
+ * of vectors available. Driver should use the returned value to re-send 
+ * its request.
  **/
-int msi_alloc_vectors(struct pci_dev* dev, int *vector, int nvec)
+int pci_enable_msix(struct pci_dev* dev, unsigned int *data, int nvec)
 {
-	struct msi_desc *entry;
-	int i, head, pos, vec, free_vectors, alloc_vectors;
-	int *vectors = (int *)vector;
+	struct msix_entry *entries = (struct msix_entry *)data;
+	int status, pos, nr_entries, free_vectors;
+	int i, j, temp;
 	u32 control;
 	unsigned long flags;
 
-	if (!pci_msi_enable || !dev)
+	if (!pci_msi_enable || !dev || !data)
  		return -EINVAL;
-
+	
+	if ((status = msi_init()) < 0)
+		return status;
+	
    	if (!(pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)))
  		return -EINVAL;
-
-	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 			2, &control);
-	if (nvec > multi_msix_capable(control))
-		return -EINVAL;
-
-	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[dev->irq];
-	if (!entry || entry->dev != dev ||		/* legal call */
-	   entry->msi_attrib.type != PCI_CAP_ID_MSIX || /* must be MSI-X */
-	   entry->link.head != entry->link.tail) {	/* already multi */
-		spin_unlock_irqrestore(&msi_lock, flags);
+		
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
+		2, &control);
+	if (control & PCI_MSIX_FLAGS_ENABLE)
+		return -EINVAL;			/* Already in MSI-X mode */
+	
+	nr_entries = multi_msix_capable(control);
+	if (nvec > nr_entries)
 		return -EINVAL;
+	
+	/* Check for any invalid entries */
+	for (i = 0; i < nvec; i++) {
+		if ((entries + i)->entry >= nr_entries)
+			return -EINVAL;		/* invalid entry */
+		for (j = i + 1; j < nvec; j++) {
+			if ((entries + i)->entry == (entries + j)->entry)
+				return -EINVAL;	/* duplicate entry */
+		}
+	}
+	temp = dev->irq;
+	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
+		/* Lookup Sucess */
+		nr_entries = nvec;	
+		/* Reroute MSI-X table */
+		if (reroute_msix_table(dev->irq, entries, &nr_entries)) {
+			/* #requested > #previous-assigned */
+			dev->irq = temp;
+			return nr_entries;
+		}
+		dev->irq = temp;
+		enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+		return 0;
 	}
+	/* Check whether driver already requested for MSI vector */
+   	if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0 &&
+		!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
+		printk(KERN_INFO "Can't enable MSI-X. Device already had MSI vector assigned\n");
+		dev->irq = temp;
+		return -EINVAL;	
+	}
+	
+	spin_lock_irqsave(&msi_lock, flags);
 	/*
 	 * msi_lock is provided to ensure that enough vectors resources are
 	 * available before granting.
@@ -874,71 +1012,18 @@
 		free_vectors /= nr_msix_devices;
 	spin_unlock_irqrestore(&msi_lock, flags);
 
-	if (nvec > free_vectors)
-		return -EBUSY;
+	if (nvec > free_vectors) {
+		if (free_vectors > 0)
+			return free_vectors;
+		else
+			return -EBUSY;
+	}	
 
-	alloc_vectors = 0;
-	head = dev->irq;
-	for (i = 0; i < nvec; i++) {
-		if ((vec = msi_alloc_vector(dev, head)) < 0)
-			break;
-		*(vectors + i) = vec;
-		head = vec;
-		alloc_vectors++;
-	}
-	if (alloc_vectors != nvec) {
-		for (i = 0; i < alloc_vectors; i++) {
-			vec = *(vectors + i);
-			msi_free_vector(dev, vec);
-		}
-		spin_lock_irqsave(&msi_lock, flags);
-		msi_desc[dev->irq]->link.tail = msi_desc[dev->irq]->link.head;
-		spin_unlock_irqrestore(&msi_lock, flags);
-		return -EBUSY;
-	}
-	if (nr_msix_devices > 0)
+	status = msix_capability_init(dev, entries, nvec);
+	if (!status && nr_msix_devices > 0)
 		nr_msix_devices--;
-
-	return 0;
-}
-
-/**
- * msi_free_vectors - reclaim MSI-X vectors to unused state
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @vector: pointer to an array of released MSI-X vectors
- * @nvec: number of MSI-X vectors requested for release by device driver
- *
- * Reclaim MSI-X vectors released by device driver to unused state,
- * which may be used later on. A return of zero indicates the
- * success or non-zero for otherwise. Device driver should call this
- * before calling function free_irq.
- **/
-int msi_free_vectors(struct pci_dev* dev, int *vector, int nvec)
-{
-	struct msi_desc *entry;
-	int i;
-	unsigned long flags;
-
-	if (!pci_msi_enable)
- 		return -EINVAL;
-
-	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[dev->irq];
-	if (!entry || entry->dev != dev ||
-	   	entry->msi_attrib.type != PCI_CAP_ID_MSIX ||
-		entry->link.head == entry->link.tail) {	/* Nothing to free */
-		spin_unlock_irqrestore(&msi_lock, flags);
-		return -EINVAL;
-	}
-	spin_unlock_irqrestore(&msi_lock, flags);
-
-	for (i = 0; i < nvec; i++) {
-		if (*(vector + i) == dev->irq)
-			continue;/* Don't free entry 0 if mistaken by driver */
-		msi_free_vector(dev, *(vector + i));
-	}
-
-	return 0;
+	
+	return status;
 }
 
 /**
@@ -952,62 +1037,67 @@
  **/
 void msi_remove_pci_irq_vectors(struct pci_dev* dev)
 {
-	struct msi_desc *entry;
-	int type, temp;
+	int state, pos, temp;
 	unsigned long flags;
-
+	
 	if (!pci_msi_enable || !dev)
  		return;
-
-   	if (!pci_find_capability(dev, PCI_CAP_ID_MSI)) {
-   		if (!pci_find_capability(dev, PCI_CAP_ID_MSIX))
-			return;
-	}
-	temp = dev->irq;
-	if (msi_lookup_vector(dev))
-		return;
-
-	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[dev->irq];
-	if (!entry || entry->dev != dev) {
+	
+	temp = dev->irq;		/* Save IOAPIC IRQ */
+   	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSI)) > 0 &&
+		!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
+		spin_lock_irqsave(&msi_lock, flags);
+		state = msi_desc[dev->irq]->msi_attrib.state;
 		spin_unlock_irqrestore(&msi_lock, flags);
-		return;
-	}
-	type = entry->msi_attrib.type;
-	spin_unlock_irqrestore(&msi_lock, flags);
-
-	msi_free_vector(dev, dev->irq);
-	if (type == PCI_CAP_ID_MSIX) {
-		int i, pos, dev_msi_cap;
-		u32 phys_addr, table_offset;
-		u32 control;
-		u8 bir;
-
-   		pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-		dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 			2, &control);
-		dev_msi_cap = multi_msix_capable(control);
-		dev->bus->ops->read(dev->bus, dev->devfn,
-			msix_table_offset_reg(pos), 4, &table_offset);
-		bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
-		phys_addr = pci_resource_start (dev, bir);
-		phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
-		for (i = FIRST_DEVICE_VECTOR; i < NR_IRQS; i++) {
+		if (state)  	
+			printk("WARNING! Driver fails freeing MSI vector[%d]\n",
+				dev->irq);
+		else /* Release MSI vector assigned to this device */
+			msi_free_vector(dev, dev->irq, 0);
+		dev->irq = temp;		/* Restore IOAPIC IRQ */
+	}
+   	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) > 0 &&
+		!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
+		int vector, head, tail = 0, warning = 0;
+		unsigned long base = 0L;
+		
+		vector = head = dev->irq;
+		while (head != tail) {
 			spin_lock_irqsave(&msi_lock, flags);
-			if (!msi_desc[i] || msi_desc[i]->dev != dev) {
-				spin_unlock_irqrestore(&msi_lock, flags);
-				continue;
-			}
+			state = msi_desc[vector]->msi_attrib.state;
+			tail = msi_desc[vector]->link.tail;
+			base = msi_desc[vector]->mask_base;
 			spin_unlock_irqrestore(&msi_lock, flags);
-			msi_free_vector(dev, i);
+			if (state) { 	
+				printk("WARNING! Driver fails freeing MSI-X vector[%d]\n",
+				vector);
+				warning = 1;
+			} else if (vector != head) /* Release MSI-X vector */
+				msi_free_vector(dev, vector, 0);
+			vector = tail;
+		}
+		msi_free_vector(dev, vector, 0);
+		if (warning) {
+			/* Force to release the MSI-X memory-mapped table */
+			u32 phys_addr, table_offset;
+			u32 control;
+			u8 bir;
+
+			dev->bus->ops->read(dev->bus, dev->devfn, 
+				msi_control_reg(pos), 2, &control);
+			dev->bus->ops->read(dev->bus, dev->devfn,
+				msix_table_offset_reg(pos), 4, &table_offset);
+			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+			phys_addr = pci_resource_start (dev, bir);
+			phys_addr += (u32)(table_offset & 
+				~PCI_MSIX_FLAGS_BIRMASK);
+			iounmap((void*)base);
+			release_mem_region(phys_addr, PCI_MSIX_ENTRY_SIZE *
+				multi_msix_capable(control));
 		}
-		writel(1, entry->mask_base + PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
-		iounmap((void*)entry->mask_base);
-		release_mem_region(phys_addr, dev_msi_cap * PCI_MSIX_ENTRY_SIZE);
+		dev->irq = temp;		/* Restore IOAPIC IRQ */
 	}
-	dev->irq = temp;
-	nr_reserved_vectors++;
 }
 
 EXPORT_SYMBOL(pci_enable_msi);
-EXPORT_SYMBOL(msi_alloc_vectors);
-EXPORT_SYMBOL(msi_free_vectors);
+EXPORT_SYMBOL(pci_enable_msix);
diff -urN linux-2.6.7/drivers/pci/msi.h patch-2.6.7-msix/drivers/pci/msi.h
--- linux-2.6.7/drivers/pci/msi.h	2004-05-09 22:32:53.000000000 -0400
+++ patch-2.6.7-msix/drivers/pci/msi.h	2004-06-22 10:16:09.000000000 -0400
@@ -90,6 +90,11 @@
 #define MSI_LOGICAL_MODE		1
 #define MSI_REDIRECTION_HINT_MODE	0
 
+struct msix_entry {
+	__u32 	vector	: 16;	/* kernel uses to write allocated vector */
+	__u32	entry	: 16;	/* driver uses to specify entry, OS writes */
+};
+
 struct msg_data {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 	__u32	vector		:  8;
@@ -140,7 +145,8 @@
 	struct {
 		__u8	type	: 5; 	/* {0: unused, 5h:MSI, 11h:MSI-X} */
 		__u8	maskbit	: 1; 	/* mask-pending bit supported ?   */
-		__u8	reserved: 2; 	/* reserved			  */
+		__u8	state	: 1; 	/* {0: free, 1: busy}		  */
+		__u8	reserved: 1; 	/* reserved			  */
 		__u8	entry_nr;    	/* specific enabled entry 	  */
 		__u8	default_vector; /* default pre-assigned vector    */
 		__u8	current_cpu; 	/* current destination cpu	  */
diff -urN linux-2.6.7/include/linux/pci.h patch-2.6.7-msix/include/linux/pci.h
--- linux-2.6.7/include/linux/pci.h	2004-06-22 10:11:40.000000000 -0400
+++ patch-2.6.7-msix/include/linux/pci.h	2004-06-22 10:16:09.000000000 -0400
@@ -789,13 +789,14 @@
 #ifndef CONFIG_PCI_USE_VECTOR
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
+static inline int pci_enable_msix(struct pci_dev* dev, 
+	unsigned int *data, int nvec) {return -1;}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
 #else
 extern void pci_scan_msi_device(struct pci_dev *dev);
 extern int pci_enable_msi(struct pci_dev *dev);
+extern int pci_enable_msix(struct pci_dev* dev, unsigned int *data, int nvec);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
-extern int msi_alloc_vectors(struct pci_dev* dev, int *vector, int nvec);
-extern int msi_free_vectors(struct pci_dev* dev, int *vector, int nvec);
 #endif
 
 #endif /* CONFIG_PCI */
