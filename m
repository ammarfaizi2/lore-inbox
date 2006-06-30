Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWF3Hx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWF3Hx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWF3Hx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:53:58 -0400
Received: from mga07.intel.com ([143.182.124.22]:7989 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751381AbWF3Hxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:53:55 -0400
X-IronPort-AV: i="4.06,194,1149490800"; 
   d="scan'208"; a="59617320:sNHT135936773"
Subject: Re: [PATCH 1/6] PCI-Express AER implemetation
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <1151630897.28493.107.camel@ymzhang-perf.sh.intel.com>
References: <1151543547.28493.70.camel@ymzhang-perf.sh.intel.com>
	 <20060629162214.GB18767@colo.lackof.org>
	 <1151630897.28493.107.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1151653962.28493.121.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 30 Jun 2006 15:52:42 +0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the updated pciaer-howto.txt.

From: Zhang, Yanmin <yanmin.zhang@intel.com>

PCI-Express AER (Advanced Error Reporting) provides more robust error reporting.
The series of patches enable kernel support to AER.

The initial patches were written by Tom Long Nguyen. I ported them to the kernel
2.6.17. Many thanks to Rajesh Shah and Narayanan Chandramouli for their great
review comments and testing help.

Patch 1 consists of the pciaer-howto.txt document.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com> 

---

--- linux-2.6.17/Documentation/pcieaer-howto.txt	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17_aer/Documentation/pcieaer-howto.txt	2006-06-30 15:45:26.000000000 +0800
@@ -0,0 +1,224 @@
+   The PCI Express Advanced Error Reporting Driver Guide HOWTO
+		T. Long Nguyen	<tom.l.nguyen@intel.com>
+		Yanmin Zhang	<yanmin.zhang@intel.com>
+				03/30/2006
+
+1. About this guide
+
+This guide describes the basics of the PCI Express Advanced Error
+Reporting (AER) driver and provides information on how to enable
+the drivers of endpoint devices to conform with PCI Express AER
+driver.
+
+2. Copyright © Intel Corporation 2006.
+
+3. What is the PCI Express AER Driver?
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
+The PCI Express AER driver provides the infrastructure to support PCI
+Express Advanced Error Reporting capability. The PCI Express AER
+driver provides three basic functions:
+
+-	Gathers the comprehensive error information if errors
+	occurred. 
+-	Performs error recovery actions.
+-	Reports error to the users.
+
+AER driver only attaches root port which support PCI-Express AER
+capability.
+
+4. Why Use the PCI Express AER Driver?
+
+In a PCI Express-aware system, when AER is enabled, a PCI Express
+device will automatically send an error message to the PCIE root
+port above it when the device captures an error. The Root Port,
+upon receiving an error reporting message, internally processes
+and logs the error message in its PCI Express capability structure.
+Error information being logged includes storing the error reporting
+agent's requestor ID into the Error Source Identification Registers
+and setting the error bits of the Root Error Status Register
+accordingly. If AER error reporting is enabled in Root Error Command
+Register, the Root Port generates an interrupt if an error is
+detected.
+
+All kernels released before 2.6.18 have no root service driver
+available to manage the PCI Express advanced error reporting
+extended capability structure. BIOS could provide the baseline
+capability, but it is unable to coordinate with the downstream device
+drivers to determine more precisely which error and what severity,
+and unable to reset the downstream links while handling fatal error
+recovery.
+
+To provide a solution to these BIOS issues requires the PCI Express AER
+Root driver that provides:
+
+- 	An infrastructure for the OS and application to determine if a
+	fatal error is fatal to the system, OS, or application increasing
+	uptime.
+
+-	An infrastructure to notify the downstream device drivers if errors
+	occurred.
+
+-	An infrastructure to dynamically perform error recovery actions
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
+as a kernel driver by default (CONFIG_PCIEAER = y). Users may disable
+the PCI Express AER driver by clearing CONFIG_PCIEAER.
+
+Note that there is a case where a system has AER support in BIOS. 
+Enabling the AER Root driver and having AER support in BIOS may
+result unpredictable behavior. To avoid this conflict, a successful
+load of the AER Root driver requires ACPI _OSC support in the BIOS to
+allow the AER Root driver to request for native control of AER. See
+the PCI FW 3.0 Specification for details regarding OSC usage. Currently,
+lots of firmwares don't provide _OSC support while they use
+PCI-Express. To support such firmwares, forceload, a module parameter
+of type bool, could enable AER to continue to be initiated although
+firmwares have no _OSC support. forceload=n by default.
+
+6. Enabling AER Aware Support in PCI Express Device Driver
+
+To enable AER aware support requires a software driver to configure
+the AER capability structure within its device and to provide its
+error-recovery callbacks as described below.
+
+6.1. Configuring the AER capability structure
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
+AER aware drivers of PCI Express component need change the device
+control registers to enable AER. They also could change AER registers,
+including mask and severity registers.
+
+Note that the errors as described above are related to the PCI Express
+hierarchy and links. These errors do not include any device specific
+errors because device specific errors will still get sent directly to
+the device driver.
+
+6.2. Provide PCI error-recovery callbacks
+
+The PCI Express AER Root driver uses callbacks to coordinate with
+downstream device drivers associated with a hierarchy in question
+when performing error recovery actions. AER driver follows the rules
+defined in pci-error-recovery.txt.
+
+Note that correctable errors pose no impacts on the functionality of
+the interface. The PCI Express protocol can recover without any
+software intervention or any loss of data. These errors do not
+require any recovery actions. The AER driver clears the device's
+correctable error status register accordingly and logs these errors.
+
+If an error message indicates a non-fatal error, performing link reset
+at upstream is not required. The AER driver calls error_detected(dev,
+pci_channel_io_normal) to all drivers associated within a hierarchy in
+question. A driver may return PCI_ERS_RESULT_CAN_RECOVER,
+PCI_ERS_RESULT_DISCONNECT, or PCI_ERS_RESULT_NEED_RESET, depending on
+whether it can recover or the AER driver calls mmio_enabled as next.
+ 
+If an error message indicates a fatal error, kernel will broadcast
+error_detected(dev, pci_channel_io_frozen) to all drivers within
+a hierarchy in question. Then, performing link reset at upstream is
+necessary. As different kinds of devices might use different approaches
+to reset link, AER port service driver is required to provide the
+function to reset link. Firstly, kernel looks for if the upstream
+component has an aer driver. If it has, kernel uses the reset_link
+callback of the aer driver. If the upstream component has no aer driver
+and the port is downstream port, we will use the aer driver of the
+root port who reports the AER error. As for upstream ports,
+they should provide their own aer service drivers with reset_link
+function. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER and
+reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
+to mmio_enabled.
+
+6.2.5 helper functions
+
+6.2.5.1 int pci_find_aer_capability(struct pci_dev *dev);
+pci_find_aer_capability locates the PCI-Express AER capability
+in the device configuration space. If the device doesn't support
+PCI-Express AER, the function returns 0.
+
+6.2.5.2 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
+pci_enable_pcie_error_reporting enables the device to send error
+messages to root port when an error is detected. Note that devices
+don't enable the error reporting by default, so device driver need
+call this function to enable it.
+
+6.2.5.3 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+pci_disable_pcie_error_reporting disables the device to send error
+messages to root port when an error is detected.
+
+6.2.5.4 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
+pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
+error status register.
+
+7. AER error output
+
+When any AER error is reported, kernel will call printk to output
+error messages.
+
+Below shows an sample.
++------ PCI-Express Device Error -----+
+Error Severity          : Uncorrected (Fatal)
+PCIE Bus Error type     : Transaction Layer
+Unsupported Request     : First
+Requester ID            : 0500
+VendorID=8086h, DeviceID=0329h, Bus=05h, Device=00h, Function=00h
+TLB Header:
+04000001 00200a03 05010000 00050100
+
+8. Frequent Asked Questions
+
+Q: What happens if a PCI Express device driver does not provide an
+error recovery handle?
+
+A: The devices attached with the driver won't be recovered. If the
+error is fatal, kernel will print out warning messages. Please refer
+to section 6 for more information.
+
+Q: How does this infrastructure deal with driver that is not PCI
+Express aware?
+
+A: This infrastructure calls the error callback functions of the
+driver when an error happens. But if the driver is not aware of
+PCI Express, the device might not report its own errors to root
+port.
+
+Q: What modifications will that driver need to make it compatible
+with the PCI Express AER Root driver?
+
+A: It could call the helper functions to enable AER in devices and
+cleanup uncorrectable status register. Pls. refer to section 6.2.5.
+
