Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVCKW7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVCKW7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVCKW6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:58:44 -0500
Received: from fmr20.intel.com ([134.134.136.19]:43436 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261798AbVCKWwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:52:13 -0500
Date: Fri, 11 Mar 2005 16:12:18 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200503120012.j2C0CIj4020297@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Cc: greg@kroah.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes PCIEAER-HOWTO.txt, which describes how the PCI
Express Advanced Error Reporting Root driver works.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------
diff -urpN linux-2.6.11-rc5/Documentation/PCIEAER-HOWTO.txt patch-2.6.11-rc5-aerc3-split1/Documentation/PCIEAER-HOWTO.txt
--- linux-2.6.11-rc5/Documentation/PCIEAER-HOWTO.txt	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split1/Documentation/PCIEAER-HOWTO.txt	2005-03-11 10:25:21.000000000 -0500
@@ -0,0 +1,712 @@
+   The PCI Express Advanced Error Reporting Root Driver Guide HOWTO
+		T. Long Nguyen <tom.l.nguyen@intel.com>
+				02/23/2005
+
+1. About this guide
+
+This guide describes the basics of the PCI Express Advanced Error
+Reporting (AER) Root driver and provides information on how to enable
+the drivers of AER endpoint devices to register/un-register with PCI
+Express Root AER driver.
+
+2. Copyright © Intel Corporation 2005. 
+
+3. What is the PCI Express AER Root Driver?
+
+PCI Express error signaling can occur on the PCI Express link itself
+or on behalf of transactions initiated on the link. PCI Express
+defines two error reporting paradigms: the baseline capability and
+the Advanced Error Reporting capability. The baseline capability is
+required of all PCI Express components providing a minimum defined
+set of error reporting requirements. Advanced Error Reporting
+capability is implemented with a PCI Express advanced error reporting
+extended capability structure providing more robust error reporting.
+
+The PCI Express AER Root driver provides the mechanism to support PCI
+Express Advanced Error Reporting capability. The PCI Express AER Root
+driver provides three basic functions:
+
+-	A mechanism to allow a driver of a PCI Express component to
+	register/un-register its AER aware callback handle with the
+	PCI Express AER Root driver. This mechanism is provided as
+	an option to allow the PCI Express AER Root driver to query
+	the PCI Express component device driver to determine more
+	precisely which error and what severity occurred.
+	
+-	A mechanism to process the error reporting message detected
+	by Root Ports, and report the errors to user.
+
+4. Why Use the PCI Express AER Root Driver?
+
+In a PCI Express-aware system, a PCI Express component in a hierarchy
+associated with the Root Port can send an error reporting message
+to the Root Port. The Root Port, upon receiving an error reporting
+message, internally processes and logs the error message in its PCI
+Express capability structure. Error information being logged includes
+storing the error reporting agent's requestor ID into the Error
+Source Identification Registers and setting the error bits of the
+Root Error Status Register accordingly. If AER error reporting is
+enabled in Root Error Command Register, the Root Port generates an
+interrupt if an error is detected.
+
+In existing Linux kernels, 2.4.x and 2.6.x, there is no root service
+driver available to manage the PCI Express advanced error reporting
+extended capability structure. If an error is detected by the Root
+Port, the baseline capability, as described above, therefore must
+be provided by platform hardware to provide the platform-specific
+system with minimum defined error reporting requirements. Such a 
+platform-specific system may have BIOS not only configure the Root
+Control Register of the Root Ports' PCI Express capability structure
+to generate the system error accordingly but also handle error 
+reporting messages. Using platform-specific BIOS to handle system
+error reporting has three key issues:
+
+-	Inability to coordinate with the downstream device drivers
+	to determine more precisely which error and what severity.
+
+- 	Inability to reset the downstream links while handling fatal
+	error recovery.
+
+- 	Platform-specific dependency.
+
+To provide a solution to these issues requires the PCI Express AER
+Root driver that provides:
+
+- 	A mechanism for the OS and application to determine if a fatal
+	error is fatal to the system, OS, or application increasing
+	uptime.
+
+-	A mechanism to notify the downstream device drivers if errors
+	occurred.
+
+-	A mechanism to dynamically perform error recovery actions
+	based on configuration options.
+
+- 	Platform-specific independence.
+
+5. Including the PCI Express AER Root Driver into the Linux Kernel
+
+The PCI Express AER Root driver is a Root Port service driver attached
+to the PCI Express Port Bus driver. Its service must be registered
+with the PCI Express Port Bus driver and users are required to include
+the PCI Express Port Bus driver in the kernel (refer to
+PCIEBUS-HOWTO.txt). Once the kernel config CONFIG_PCIEPORTBUS is
+included, the PCI Express AER Root driver is automatically included
+as a kernel driver by default (CONFIG_PCIEAER = Y). Users may disable
+the PCI Express AER driver by clearing CONFIG_PCIEAER.
+
+Note that there is a case where a system has AER support in BIOS. 
+Enabling the AER Root driver and having AER support in BIOS may
+result unpredictable behavior. To avoid this conflict, a successful
+load of the AER Root driver requires ACPI _OSC support in the BIOS to
+allow the AER Root driver to request for native control of AER. See
+the PCI FW 3.0 Specification for details regarding OSC usage.  
+
+6. Enabling AER Aware Support in PCI Express Device Driver
+
+To enable AER aware support requires a software driver to configure
+the AER capability structure within its device, to initialize its AER
+aware callback handle and to call pcie_aer_register. Sections 6.1,
+6.2, and 6.3 describe how to enable AER aware support in details.
+
+6.1 Calling pcie_aer_register
+
+The PCI Express AER Root driver defines a register-callback
+mechanism to provide AER aware drivers of PCI Express components
+to register their callback handles with the PCI Express AER Root
+driver. The PCI Express AER Root driver uses these callback handles
+to coordinate with downstream AER aware drivers to provide not only
+more robust error reporting but also the ability to reset the link,
+in a hierarchy associated with the Root Port, while handling fatal
+error recovery.
+
+To register AER callback handle requires an AER aware driver of PCI
+Express component to call pcie_aer_register. Calling pcie_aer_register
+is provided as an option instead of a requirement to make sure that
+the PCI Express AER Root driver works with existing PCI Express
+drivers. However, this patch highly recommends that a software driver
+of PCI Express component should call pcie_aer_register because
+calling pcie_aer_register poses no impact on its behavior. The
+following reasons explain why calling pcie_aer_register is safe and
+recommended.
+
+-	In a PCI Express aware kernel, the PCI Express AER Root
+	driver uses register-callback handle to coordinate with an
+	AER aware driver of PCI Express component when an error
+	occurs. Such coordination enables an AER aware driver to
+	clear corresponding error status, to recover any unreliable
+	transactions if required, and to report more precisely which
+	error and what severity to the PCI Express AER Root driver.
+
+-	In a non-PCI Express-aware kernel, pcie_aer_register returns
+	non-zero immediately as an indicator to tell the driver that
+	BIOS/FW is in control.
+
+Note that pcie_aer_unregister is also provided to allow an AER
+aware driver to undo the effect of calling pcie_aer_register.
+Calling pcie_aer_unregister is required when an AER aware driver
+is unloaded.
+
+"AER assumes only one AER aware driver will register per device ID"..
+
+6.2 Configure PCI Express Component to Report Errors
+
+PCI Express errors are classified into two types: correctable errors
+and uncorrectable errors. This classification is based on the impacts
+of those errors, which may result in function failure or in degraded
+performance.
+
+Correctable errors pose no impacts on the functionality of the
+interface. The PCI Express protocol can recover without any software
+intervention or any loss of data. These errors are detected and
+corrected by hardware. Unlike correctable errors, uncorrectable
+errors impact functionality of the interface. Uncorrectable errors
+can cause a particular transaction or a particular PCI Express link
+to be unreliable. Depending on those error conditions, uncorrectable
+errors are further classified into fatal errors and non-fatal errors.
+Non-fatal errors cause the particular transaction to be unreliable,
+but the PCI Express link itself is fully functional. Fatal errors, on
+the other hand, cause the link to be unreliable.
+
+Because selecting specific correctable/uncorrectable errors to report
+to Root Port is device implementation specific, an AER aware driver
+of PCI Express component is responsible for configuring its device not
+only to mask specific correctable/uncorrectable errors but also to
+select whether an individual uncorrectable error is reported as a
+non-fatal or fatal error.
+
+Note that the errors as described above are related to the PCI Express
+hierarchy and links. These errors do not include any device specific
+errors because device specific errors will still get sent directly to
+the device driver.
+
+6.3 Provide AER Service Callback Handle
+
+As described in above paragraph, an AER aware driver must provide its
+AER aware callback handle by calling pcie_aer_register. The data
+structure of callback handle is defined in section 7. The PCI Express
+AER Root driver uses callback handle to notify an AER aware driver
+associated with an agent, which sends an error message to the Root
+Port. Because the Root Port reports error of either correctable or
+uncorrectable, the PCI Express AER Root driver notifies an AER aware
+driver with either AER_CORRECTABLE or AER_UNCORRECTABLE. An AER aware
+driver is responsible for clearing the error status within its device
+and reporting back to the PCI Express AER Root driver with appropriate
+eror status and error type. 
+
+If the Root Port detected a correctable error, the PCI Express AER
+Root driver notifies an AER aware driver of the agent, which sent
+an error, to determine more precisely which correctable error. No
+other actions are necessary because the PCI Express protocol can
+recover without any software intervention or any loss of data. An
+AER aware driver is responsible for clearing its correctable error
+status within its device and reporting back to the PCI Express AER
+Root driver with the correctable error status.
+
+If the Root Port detected an uncorrectable error, the PCI Express AER
+Root driver notifies an AER aware driver of the agent, which sent an
+error, to determine more precisely which uncorrectable error and what
+severity (non-fatal/fatal) occurred. In addition to notify, the PCI
+Express AER Root driver calls an AER aware driver to query for any
+specific TLP header associated with non-fatal error because some
+non-fatal errors may have associated TLP header and some may not.
+An AER aware driver is responsible for clearing its uncorrectable
+error status within its device, recovering any unreliable transactions
+and reporting back to the PCI Express AER Root driver with the
+uncorrectable error status and AER_NONFATAL/AER_FATAL type.
+
+If the error information returned from an AER aware driver indicates
+a fatal severity, the AER Root driver may attempt to return the link,
+where an AER aware agent is point-to-point connected, to reliable
+operation by resetting the link. Depending on the link position in a
+hierarchy associated with the Root Port, the PCI Express AER Root
+driver may invoke AER aware drivers of downstream devices associated
+with this link hierarchy to abort their operations before resetting
+the link and restart their operations after returning the link to
+reliable. This is one of the key advantages of why software drivers
+of PCI Express components should be AER aware.
+
+Note that the link reset, called the Training Control Reset or hot
+reset, is performed by an upstream device to force a reset of all
+downstream devices. A bridge must propagate hot reset onto all
+downstream links. A downstream device can optionally use hot reset
+to reset its internal logic. The mechanism of hot reset is device
+implementation specific. If the upstream device of the link does not
+support hot reset or the software driver of upstream device is not
+AER aware, there is no attempt to return the link to reliable.
+
+6.4 Sample Code
+
+Below is the sample code of how a device driver registers its AER
+callback handle with the PCI Express AER driver.
+
+static int generic_aer_notify(u16 requestor_id, union aer_error *error)
+{
+	struct pci_dev *dev = (struct pci_dev*)host->dev;
+	u32 status;
+	u16 reg16;
+	int pos;
+
+	if (requestor_id != ((dev->bus->number << 8) | dev->devfn))
+		return -EINVAL;
+
+	if (error->type == AER_CORRECTABLE) {
+		pci_read_config_dword(dev, 
+			CORRECTABLE_ERROR_STATUS_REG, &status);	
+		pci_write_config_dword(dev, 
+			CORRECTABLE_ERROR_STATUS_REG, status);
+		if (!(status & CORRECTABLE_ERROR_MASK_REG))
+			return -EINVAL;
+
+		/* 
+		 * AER Root driver needs this info to determine more
+		 * precisely which error and what severity occurred.
+		 */
+		error->source.status = status;
+
+		/*
+		 * DEVICE SPECIFIC FIXUP 
+		 */
+	} else {
+		pci_read_config_dword(dev, 
+			UNCORRECTABLE_ERROR_STATUS_REG, &status);	
+		pci_write_config_dword(dev, 
+			UNCORRECTABLE_ERROR_STATUS_REG, status);
+		if (!(status & UNCORRECTABLE_ERROR_MASK_REG))
+			return -EINVAL;
+
+		/* 
+		 * AER Root driver needs this info to determine more
+		 * precisely which error and what severity occurred.
+		 */
+		error->source.status = status;
+		if (status & UNCORRECTABLE_ERROR_SEVERITY_MASK)
+			error->source.type = AER_FATAL;
+		else
+			error->source.type = AER_NONFATAL;
+
+		/*
+		 * DEVICE SPECIFIC FIXUP 
+		 */
+	}
+
+	/* Clean up PCIE capability's device status */
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	pci_read_config_word(dev, pos + 
+		PCIE_CAP_DEVICE_STATUS_REG_OFF, &reg16);
+	pci_write_config_word(dev, pos + 
+		PCIE_CAP_DEVICE_STATUS_REG_OFF, reg16);
+
+	return 0;
+}
+
+static int generic_aer_get_header(unsigned short requestor_id, 
+	union aer_error *error, struct header_log_regs *log)
+{
+	struct pci_dev *dev = (struct pci_dev*)host->dev;
+
+	if (error->type == AER_CORRECTABLE ||
+		!(error->source.status & TLP_MASKS))
+		return -EINVAL;
+
+	pci_read_config_dword(dev, HEADER_LOG_REG, &log->dw0);
+	pci_read_config_dword(dev, HEADER_LOG_REG + 4, &log->dw1);
+	pci_read_config_dword(dev, HEADER_LOG_REG + 8, &log->dw2);
+	pci_read_config_dword(dev, HEADER_LOG_REG + 12, &log->dw3);
+
+	return 0;
+}
+
+
+static int generic_aer_link_rec_prepare(unsigned short requestor_id)
+{
+	/*
+	 * Link Recovery Prepare. Stop all transactions
+	 * DEVICE SPECIFIC FIXUP 
+	 */
+
+	return 0;
+}
+
+static int generic_aer_link_rec_restart(unsigned short requestor_id)
+{
+	/*
+	 * Link Recovery Restart. Transaction Retry.
+	 * DEVICE SPECIFIC FIXUP 
+	 */
+
+	return 0;
+}
+
+struct pcie_aer_handle generic_aer_handle = {
+	.notify 		= generic_aer_notify,
+	.get_header 		= generic_aer_get_header,
+	.link_rec_prepare	= generic_aer_link_rec_prepare,
+	.link_rec_restart	= generic_aer_link_rec_restart
+};
+
+int hw_aer_register(struct pci_dev *dev)
+{
+	int status;
+
+	/* AER Init */
+	hw_aer_enable(dev);
+	
+	/* Register with AER Root driver */
+	if ((status = pcie_aer_register(dev, &generic_aer_handle))) 
+		hw_aer_disable(dev);
+		
+	return status;
+}
+
+void hw_aer_unregister(void)
+{
+	struct pci_dev *dev = (struct pci_dev*)host->dev;
+	unsigned short id;
+
+	id = (dev->bus->number << 8) | dev->devfn;
+	
+	/* Unregister with AER Root driver */
+	pcie_aer_unregister(id);
+}
+
+static int __devinit hw_pci_probe(struct pci_dev *dev, 
+   	const struct pci_device_id *id )
+{
+	/*
+	 * Hardware Init
+	 */
+
+	hw_aer_register(dev);
+	return 0;
+}
+
+static void __exit hw_exit_cleanup(void) 
+{
+	hw_aer_unregister();
+
+	/*
+	 * Hardware Cleanup
+	 */
+}
+
+7. Data Structure of Callback Handle
+
+The PCI Express AER Root driver defines a data structure, named struct
+pcie_aer_handle, which contains five callback routines. The device
+driver of PCI Express component provides the callback routines when
+calling pcie_aer_register. The PCI Express AER Root driver uses the
+callback routines to notify the device driver if its device detects
+an error and sends an error message to Root Port. Depending on an
+error message, the PCI Express AER Root driver may call an AER aware
+driver to query for more error information or possibly to reset the
+link to return to reliable operation.
+
+The data structure of pcie_aer_handle is defined as below: 
+
+struct pcie_aer_handle {
+
+	int (*notify) (u16 requestor_id, union aer_error *error);
+
+	int (*get_header) (u16 requestor_id, union aer_error *error,
+		struct header_log_regs *log);
+
+	int (*link_rec_prepare) (u16 requestor_id);
+
+	int (*link_rec_restart) (u16 requestor_id);
+
+	int (*link_reset) (u16 requestor_id);
+};
+
+With aer_error data structure is defined as:
+
+union aer_error {
+	unsigned int type;
+	struct {
+		unsigned int type;
+		unsigned int status;
+	}source;
+};
+
+-	int (*notify) (u16 requestor_id, union aer_error *error)
+
+	An AER aware driver is required to provide this callback.
+	The PCI Express AER Root driver calls notify to inform an
+	AER aware driver that its device has detected an error and
+	sent the error reporting message to Root Port. An error
+	message can be either ERR_COR or ERR_UNCOR, which is further
+	categorized into either ERR_FATAL or ERR_NONFATAL. Because
+	these errors are device-specific and configured by an AER
+	aware driver, retrieving a precise error type requires the PCI
+	Express AER Root driver to call notify with error->type 
+	set to either AER_CORRECTABLE or AER_UNCORRECTABLE. Once
+	being invoked, an AER aware driver requires returning
+	error->source.status and error->source.type. Refer to the
+	sample code in section 6.4.
+	
+	In addition, an AER aware driver is responsible for clearing
+	its corresponding error status, recovering any unreliable
+	transactions if required, and returning its device to a
+	reliable state.  
+
+-	int (*get_header) (u16 requestor_id, union aer_error *error,
+		struct header_log_regs *log)
+
+	An AER aware driver is required to provide this callback.
+	The PCI Express AER Root driver calls get_header if an error
+	message is either ERR_FATAL or ERR_NONFATAL. Some of these
+	errors may have associated TLP header and some may not. The
+	PCI Express AER Root driver has no knowledge of whether TLP
+	header should be reported along with a detected error. Again,
+	it is the responsibility of an AER aware driver, once being
+	invoked, to indicate whether an error has an associated TLP
+	header. A return of zero indicates a param log pointer
+	containing valid TLP header. A return of nonzero is otherwise.
+
+-	int (*link_rec_prepare) (u16 requestor_id)
+
+	An AER aware driver is required to provide this callback.
+	The PCI Express AER Root driver calls link_rec_prepare if and
+	only if it requires resetting the link in a hierarchy
+	associated with PCI Express Port, which detected and sent a
+	fatal error message to the Root Port. PCI Express Port can be
+	a Root Port itself, an Upstream Switch Port, or a Downstream
+	Switch Port. The PCI AER Root driver, before doing a hot reset
+	on PCI Express Port, informs AER aware driver of each
+	downstream PCI Express component in a hierarchy to abort all
+	currently in-progress transactions.
+
+-	int (*link_rec_restart) (u16 requestor_id)
+
+	An AER aware driver is required to provide this callback.
+	The PCI Express AER Root driver calls link_rec_restart to
+	inform AER aware driver of each downstream PCI Express
+	component to retry all transactions aborted by the previous
+	link_rec_prepare call and any device initialization that may
+	be required due to the link reset.
+
+-	int (*link_reset) (u16 requestor_id)
+
+	The PCI Express AER Root driver calls link_reset when the Root
+	Port detects a fatal error message, which was sent by a PCI
+	Express Port in a hierarchy associated with the Root Port. 
+	Performing a hot reset on this PCI Express Port is necessary
+	in attempt of returning this Port to reliable operation (fatal
+	error recovery). Again note that the mechanism of hot reset is
+	device implementation specific. An AER aware driver is not
+	required to provide this callback if its PCI Express Port
+	hardware device does not support hot reset. 
+
+	Note this callback is not required for an AER aware driver of
+	PCI Express endpoint device.    
+
+8. APIs
+
+8.1 pcie_aer_register
+
+int pcie_aer_register(struct pci_dev*, struct pcie_aer_handle *handle)
+
+The PCI Express AER Root driver provides pcie_aer_register to allow
+a software driver of PCI Express component to register its AER
+callback handle. Note that this API is provided as an option to
+provide more robust error reporting. If PCI Express AER Root driver
+detects an error message sent by an agent, which does not AER
+callback handle in its driver, PCI Express AER Root driver will
+provide basic error reporting as described in section 6.
+
+8.2 pcie_aer_unregister
+
+void pcie_aer_unregister(unsigned short requestor_id)
+
+The PCI Express AER Root driver provides pcie_aer_unregister to allow
+a software driver of PCI Express component to undo the effect of
+calling pcie_aer_register. Note that a device driver should always
+call pcie_aer_unregister when it unloads.
+
+9. Error Reporting Data Structures
+
+PCI Express AER error reporting data structures are defined to
+consist of three components: Record Header, Platform PCIE Bus Error
+Info section and PCI Component Error Info section.
+
+Record Header contains generic information such as the record
+revision, the record length, the error severity, and the time stamp
+at which an error occurred.
+
+Platform PCIE Bus Error Info section provides the section length and
+the information of detected error. Note that the context of PCI
+Express error information is depending on whether an agent's software
+driver is AER aware or not.
+
+PCI Component Error Info section provides the section length and the
+PCI component information of an agent, which detects and sends an
+error message to Root Port. Such PCI component information includes
+bus number, device number and function number.
+
+9.1 Error Reporting Samples
+
+This patch provides two samples of how the PCI Express AER Root
+driver reports errors detected by Root Port. Since Root Port reports
+detected error as correctable or uncorrectable, obtaining specific
+error type requires the use of callback handle registered by an AER
+aware driver. If an AER aware driver of an agent, which sent an
+error to Root Port, has its callback handle registered, then the PCI
+Express AER Root driver will notify an AER aware driver to obtain
+specific error type. If not, then an error detected by Root Port is
+known as Unaccessible.
+
+9.1.1 Without Register Callback Handle
+
+Error Severity        : Uncorrected
+Time Stamp            : 2/16/2005 7:51:24
+PCIE Bus Error type   : Unaccessible
+Unaccessible Received : Multiple
+Unregistered Agent ID : 0030
+VendorID=xxxxh, DeviceID=xxxxh, Bus=00h, Device=06h, Function=00h
+
+9.1.2 With Register Callback Handle
+
+Error Severity        : Uncorrected (Non-Fatal)
+Time Stamp            : 2/16/2005 7:51:24
+PCIE Bus Error type   : Transaction Layer
+Poisoned TLP          : Multiple
+Receiver ID           : 0030
+VendorID=8086h, DeviceID=3599h, Bus=00h, Device=06h, Function=00h
+
+10. User Interface
+
+Interface, /sys/bus/pci_express/drivers/aer, is provided to enable
+user to interface with PCI Express AER Root driver. The description
+of the interface is defined as below:
+
+/sys/bus/pci_express/drivers/aer
+	|
+	|___ auto
+	|
+	|___ consume
+	|
+	|___ status
+	|
+	|___ verbose
+
+Option auto indicates whether user wants the PCI Express AER Root
+driver to write error reporting into /var/log/messages (ON) or to hold
+error logs in a system memory until user manually consumes these
+error logs (OFF). This option can be read or written. A read returns
+the auto mode and a write sets the auto mode. Auto mode is turned ON
+by default. Note that in an auto-off mode, the latest error log is 
+consumed first while in an auto-on mode, an error log is automatically
+consumed and written into /var/log/messages.
+
+Option consume is valid only when auto mode is OFF. This option is
+read only. When auto mode is OFF, user can consume any detected error
+logs stored in a system memory one at a time (FILO). A read, such as
+cat consume, displays the error reporting in a full display or a raw
+binary display. This patch defines the maximum number of error logs
+stored in a system memory to EVENT_LOG_SIZE_MAX (100). If the number
+of error logs exceeds this limit, the user will start loosing error
+logs (oldest) if he doesn't consume. 
+
+Option status allows user to display a AER hierarchy maintained by
+the PCI Express AER Root driver. A sample of AER hierarchy is shown as
+below:
+
+Root Port [0.2.4] Device List:
+  Bus 0, device 2, function 0:
+    Class 60400: PCI device 3595:8086
+    COR_ERR 0, NONFATAL_ERR 0, FATAL_ERR 0
+    Register Callbacks - Yes
+Root Port [0.5.5] Device List:
+  Bus 0, device 4, function 0:
+    Class 60400: PCI device 3597:8086
+    COR_ERR 0, NONFATAL_ERR 0, FATAL_ERR 0
+    Register Callbacks - Yes
+Root Port [0.6.6] Device List:
+  Bus 0, device 6, function 0:
+    Class 60400: PCI device 3599:8086
+    COR_ERR 0, NONFATAL_ERR 3, FATAL_ERR 0
+    Last Error Detected @ 2/16/2005 7:52:35 - Poisoned TLP          
+    Register Callbacks - Yes
+  Bus 6, device 0, function 0:
+    Class ff0000: PCI device 5375:8086
+    COR_ERR 0, NONFATAL_ERR 0, FATAL_ERR 0
+    Register Callbacks - Yes
+
+Option verbose allows user to setup how error is reported. This
+option can be read or written. There are display options as below:
+
+1) Error reporting is displayed in a limited format. To select this
+option, user does "echo 1 > /sys/bus/pci_express/drivers/aer/verbose".
+The sample is shown below.
+
+Error Severity        : Uncorrected (Non-Fatal)
+Time Stamp            : 2/16/2005 7:51:24
+PCIE Bus Error type   : Transaction Layer
+Poisoned TLP          : Multiple
+Receiver ID           : 0030
+VendorID=8086h, DeviceID=3599h, Bus=00h, Device=06h, Function=00h
+
+2) Error reporting is displayed in a full format. To select this
+option, user does "echo 2 > /sys/bus/pci_express/drivers/aer/verbose".
+The sample is shown below.
+
++------ RECORD HEADER -----+
+Revision              : 00.03
+Error Severity        : Uncorrected (Non-Fatal)
+Validation Bits       : 0x2
+Record Length (bytes) : 0x78
+Time Stamp            : 2/16/2005 7:52:14
++--------------------------+
++    SECTION #0 HEADER     +
++--------------------------+
+Revision              : 00.02
+Error Recovery Info   : UnCorrected
+PCIE Bus Error type   : Transaction Layer
+Poisoned TLP          : Multiple
+Receiver ID           : 0030
++--------------------------+
++    SECTION #1 HEADER     +
++--------------------------+
+Revision              : 00.02
+Error Recovery Info   : UnCorrected
+VendorID=8086h, DeviceID=3599h, Bus=00h, Device=06h, Function=00h
+TLB Header:
+40005020 060001ff 1fda8000 00000000
+
+3) Error reporting is displayed in a raw binary dump format. To select
+option, user does "echo 3 > /sys/bus/pci_express/drivers/aer/verbose".
+The sample is shown below.
+
+00 00 00 00 00 00 00 00 03 00 00 02 78 00 00 00 
+23 34 07 00 10 02 69 14 02 00 80 00 1c 00 00 00 
+05 00 00 00 00 00 00 00 00 44 00 40 00 10 00 00 
+30 00 00 00 02 00 80 00 44 00 00 00 22 00 00 00 
+00 00 00 00 00 00 00 00 00 00 00 00 86 80 99 35 
+00 04 06 00 06 00 00 00 00 00 00 00 00 00 00 00 
+00 00 00 00 14 00 20 50 00 40 ff 02 00 06 00 80 
+da 1f 00 00 00 00 00 00 
+
+11. Frequent Asked Questions
+
+Q: What happens if a PCI Express device driver does not register its
+callback handle with the PCI Express AER Root driver?
+
+A: The PCI Express AER Root driver maintains a list of all registered
+callback handles. When an error is logged in the Root Port, the PCI
+Express AER Root driver reads an agent's requestor ID. If the
+requestor ID is not found in a list of all registered callback
+handles associated with this Root Port, a limited error reporting log
+is provided since specific error type is not accessible.
+
+Q: How does this infrastructure deal with driver that is not PCI
+Express aware?
+
+A: This infrastructure handles non-PCI Express aware driver the same
+way as handling driver that does not register its callback handle
+with the PCI Express AER Root driver.
+
+Q: What modifications will that driver need to make it compatible
+with the PCI Express AER Root driver?
+
+A: Please refer to section 6 above.
+
