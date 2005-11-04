Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbVKDAv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbVKDAv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbVKDAvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:51:05 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:58003
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161019AbVKDAux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:50:53 -0500
Date: Thu, 3 Nov 2005 18:50:35 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051104005035.GA26929@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

16-pci-error-recovery_header.patch

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

Index: linux-2.6.14-git3/include/linux/pci.h
===================================================================
--- linux-2.6.14-git3.orig/include/linux/pci.h	2005-11-02 14:29:18.856338553 -0600
+++ linux-2.6.14-git3/include/linux/pci.h	2005-11-02 14:34:32.272401512 -0600
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
@@ -232,6 +243,43 @@
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
@@ -245,6 +293,7 @@
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
 	void (*shutdown) (struct pci_dev *dev);
 
+	struct pci_error_handlers *err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
 };
