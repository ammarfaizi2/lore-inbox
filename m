Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVKGT5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVKGT5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVKGT5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:57:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:63460 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932325AbVKGT5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:57:35 -0500
Date: Mon, 7 Nov 2005 13:57:27 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7]: PCI revised [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051107195727.GF19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107182727.GD18861@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:27:27AM -0800, Greg KH was heard to remark:
> 3) realy strong typing that sparse can detect.


PCI Error Recovery: header file patch

Change enums and subroutine signatures to be strongly typed, per recent
discussion with GregKH. Also, change the acronym to the more unique, 
less generic "PERS" "PCI Error Recovery System".

Greg, Please apply.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
Index: linux-2.6.14-mm1/include/linux/pci.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/pci.h	2005-11-07 13:55:28.528843983 -0600
+++ linux-2.6.14-mm1/include/linux/pci.h	2005-11-07 13:55:35.745830682 -0600
@@ -82,11 +82,11 @@
  *  the pci device.  If some PCI bus between here and the pci device
  *  has crashed or locked up, this info is reflected here.
  */
-enum pci_channel_state {
+typedef enum {
 	pci_channel_io_normal = 0,	/* I/O channel is in normal state */
 	pci_channel_io_frozen = 1,	/* I/O to channel is blocked */
 	pci_channel_io_perm_failure,	/* PCI card is dead */
-};
+} pci_channel_state_t;
 
 /*
  * The pci_dev structure is used to describe PCI devices.
@@ -121,7 +121,7 @@
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
 
-	enum pci_channel_state error_state;	/* current connectivity state */
+	pci_channel_state_t error_state;	/* current connectivity state */
 	struct	device	dev;		/* Generic device interface */
 
 	/* device is compatible with these IDs */
@@ -245,35 +245,35 @@
 };
 
 /* ---------------------------------------------------------------- */
-/** PCI error recovery infrastructure.  If a PCI device driver provides
+/** PCI Error Recovery System (PERS).  If a PCI device driver provides
  *  a set fof callbacks in struct pci_error_handlers, then that device driver
  *  will be notified of PCI bus errors, and will be driven to recovery
  *  when an error occurs.
  */
 
-enum pcierr_result {
-	PCIERR_RESULT_NONE = 0,		/* no result/none/not supported in device driver */
-	PCIERR_RESULT_CAN_RECOVER=1,	/* Device driver can recover without slot reset */
-	PCIERR_RESULT_NEED_RESET,	/* Device driver wants slot to be reset. */
-	PCIERR_RESULT_DISCONNECT,	/* Device has completely failed, is unrecoverable */
-	PCIERR_RESULT_RECOVERED,	/* Device driver is fully recovered and operational */
-};
+typedef enum {
+	PERS_RESULT_NONE = 0,		/* no result/none/not supported in device driver */
+	PERS_RESULT_CAN_RECOVER=1,	/* Device driver can recover without slot reset */
+	PERS_RESULT_NEED_RESET,	/* Device driver wants slot to be reset. */
+	PERS_RESULT_DISCONNECT,	/* Device has completely failed, is unrecoverable */
+	PERS_RESULT_RECOVERED,	/* Device driver is fully recovered and operational */
+} pers_result_t;
 
 /* PCI bus error event callbacks */
 struct pci_error_handlers
 {
 	/* PCI bus error detected on this device */
-	int (*error_detected)(struct pci_dev *dev,
-	                      enum pci_channel_state error);
+	pers_result_t (*error_detected)(struct pci_dev *dev,
+	                      pci_channel_state_t error);
 
 	/* MMIO has been re-enabled, but not DMA */
-	int (*mmio_enabled)(struct pci_dev *dev);
+	pers_result_t (*mmio_enabled)(struct pci_dev *dev);
 
 	/* PCI Express link has been reset */
-	int (*link_reset)(struct pci_dev *dev);
+	pers_result_t (*link_reset)(struct pci_dev *dev);
 
 	/* PCI slot has been reset */
-	int (*slot_reset)(struct pci_dev *dev);
+	pers_result_t (*slot_reset)(struct pci_dev *dev);
 
 	/* Device driver may resume normal operations */
 	void (*resume)(struct pci_dev *dev);
