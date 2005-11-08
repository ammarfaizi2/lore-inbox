Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbVKHXyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbVKHXyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbVKHXyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:54:13 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:24252 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030416AbVKHXyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:54:12 -0500
Date: Tue, 8 Nov 2005 17:53:57 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] PCI Error Recovery: header file patch
Message-ID: <20051108235357.GD19593@austin.ibm.com>
References: <20051108234911.GC19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108234911.GC19593@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply.
--------

PCI Error Recovery: header file patch

Various PCI bus errors can be signaled by newer PCI controllers. Recovering 
from those errors requires an infrastructure to notify affected device drivers 
of the error, and a way of walking through a reset sequence.  This patch adds 
a set of callbacks to be used by error recovery routines to notify device 
drivers of the various stages of recovery.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
Index: linux-2.6.14-git10/include/linux/pci.h
===================================================================
--- linux-2.6.14-git10.orig/include/linux/pci.h	2005-11-07 17:24:23.048968436 -0600
+++ linux-2.6.14-git10/include/linux/pci.h	2005-11-07 17:42:46.026024245 -0600
@@ -78,6 +78,23 @@
 #define PCI_UNKNOWN	((pci_power_t __force) 5)
 #define PCI_POWER_ERROR	((pci_power_t __force) -1)
 
+/** The pci_channel state describes connectivity between the CPU and
+ *  the pci device.  If some PCI bus between here and the pci device
+ *  has crashed or locked up, this info is reflected here.
+ */
+typedef int __bitwise pci_channel_state_t;
+
+enum pci_channel_state {
+	/* I/O channel is in normal state */
+	pci_channel_io_normal = (__force pci_channel_state_t) 1,
+	
+	/* I/O to channel is blocked */
+	pci_channel_io_frozen = (__force pci_channel_state_t) 2,
+
+	/* PCI card is dead */
+	pci_channel_io_perm_failure = (__force pci_channel_state_t) 3,
+};
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -110,6 +127,7 @@
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
 
+	pci_channel_state_t error_state;  /* current connectivity state */
 	struct	device	dev;		/* Generic device interface */
 
 	/* device is compatible with these IDs */
@@ -232,6 +250,54 @@
 	unsigned int use_driver_data:1; /* pci_driver->driver_data is used */
 };
 
+/* ---------------------------------------------------------------- */
+/** PCI Error Recovery System (PCI-ERS).  If a PCI device driver provides
+ *  a set fof callbacks in struct pci_error_handlers, then that device driver
+ *  will be notified of PCI bus errors, and will be driven to recovery
+ *  when an error occurs.
+ */
+
+typedef int __bitwise pci_ers_result_t;
+
+enum pci_ers_result {
+	/* no result/none/not supported in device driver */
+	PCI_ERS_RESULT_NONE = (__force pci_ers_result_t) 1,
+
+	/* Device driver can recover without slot reset */
+	PCI_ERS_RESULT_CAN_RECOVER = (__force pci_ers_result_t) 2,
+
+	/* Device driver wants slot to be reset. */
+	PCI_ERS_RESULT_NEED_RESET = (__force pci_ers_result_t) 3,
+
+	/* Device has completely failed, is unrecoverable */
+	PCI_ERS_RESULT_DISCONNECT = (__force pci_ers_result_t) 4,
+
+	/* Device driver is fully recovered and operational */
+	PCI_ERS_RESULT_RECOVERED = (__force pci_ers_result_t) 5,
+};
+
+/* PCI bus error event callbacks */
+struct pci_error_handlers
+{
+	/* PCI bus error detected on this device */
+	pci_ers_result_t (*error_detected)(struct pci_dev *dev,
+	                      enum pci_channel_state error);
+
+	/* MMIO has been re-enabled, but not DMA */
+	pci_ers_result_t (*mmio_enabled)(struct pci_dev *dev);
+
+	/* PCI Express link has been reset */
+	pci_ers_result_t (*link_reset)(struct pci_dev *dev);
+
+	/* PCI slot has been reset */
+	pci_ers_result_t (*slot_reset)(struct pci_dev *dev);
+
+	/* Device driver may resume normal operations */
+	void (*resume)(struct pci_dev *dev);
+};
+
+/* ---------------------------------------------------------------- */
+
 struct module;
 struct pci_driver {
 	struct list_head node;
@@ -245,6 +311,7 @@
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
 	void (*shutdown) (struct pci_dev *dev);
 
+	struct pci_error_handlers *err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
 };
