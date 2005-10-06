Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVJFXcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVJFXcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVJFXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:32:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:44943 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932072AbVJFXcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:32:13 -0400
Date: Thu, 6 Oct 2005 18:32:09 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 7/22] PCI Error Recovery: header file patch
Message-ID: <20051006233208.GH29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI Error Recovery: header file patch

Various PCI bus errors can be signaled by newer PCI controllers. Recovering 
from those errors requires an infrastructure to notify affected device drivers 
of the error, and a way of walking through a reset sequence.  This patch adds 
a set of callbacks to be used by error recovery routines to notify device 
drivers of the various stages of recovery.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
 include/linux/pci.h |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+)

Index: linux-2.6.14-rc2-git6/include/linux/pci.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/include/linux/pci.h	2005-10-06 17:50:29.442032212 -0500
+++ linux-2.6.14-rc2-git6/include/linux/pci.h	2005-10-06 17:52:50.634221570 -0500
@@ -78,6 +78,16 @@
 #define PCI_UNKNOWN	((pci_power_t __force) 5)
 #define PCI_POWER_ERROR	((pci_power_t __force) -1)
 
+/** The pci_channel state describes connectivity between the CPU and
+ *  the pci device.  If some PCI bus between here and the pci device
+ *  has crashed or locked up, this info is reflected here.
+ */
+enum pci_channel_state {
+	pci_channel_io_normal = 0, /* I/O channel is in normal state */
+	pci_channel_io_frozen = 1, /* I/O to channel is blocked */
+	pci_channel_io_perm_failure, /* PCI card is dead */
+};
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -110,6 +120,7 @@
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
 
+	enum pci_channel_state error_state;  /* current connectivity state */
 	struct	device	dev;		/* Generic device interface */
 
 	/* device is compatible with these IDs */
@@ -231,6 +242,43 @@
 	unsigned int use_driver_data:1; /* pci_driver->driver_data is used */
 };
 
+/* ---------------------------------------------------------------- */
+/** PCI error recovery infrastructure.  If a PCI device driver provides
+ *  a set fof callbacks in struct pci_error_handlers, then that device driver
+ *  will be notified of PCI bus errors, and will be driven to recovery
+ *  when an error occurs.
+ */
+
+enum pcierr_result {
+	PCIERR_RESULT_NONE=0,        /* no result/none/not supported in device driver */
+	PCIERR_RESULT_CAN_RECOVER=1, /* Device driver can recover without slot reset */
+	PCIERR_RESULT_NEED_RESET,    /* Device driver wants slot to be reset. */
+	PCIERR_RESULT_DISCONNECT,    /* Device has completely failed, is unrecoverable */
+	PCIERR_RESULT_RECOVERED,     /* Device driver is fully recovered and operational */
+};
+
+/* PCI bus error event callbacks */
+struct pci_error_handlers
+{
+	/* PCI bus error detected on this device */
+	int (*error_detected)(struct pci_dev *dev,
+	                      enum pci_channel_state error);
+
+	/* MMIO has been re-enabled, but not DMA */
+	int (*mmio_enabled)(struct pci_dev *dev);
+
+	/* PCI Express link has been reset */
+	int (*link_reset)(struct pci_dev *dev);
+
+	/* PCI slot has been reset */
+	int (*slot_reset)(struct pci_dev *dev);
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
@@ -244,6 +292,7 @@
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
 	void (*shutdown) (struct pci_dev *dev);
 
+	struct pci_error_handlers *err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
 };
