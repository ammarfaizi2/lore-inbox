Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVF2AhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVF2AhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVF1X7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:59:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29836 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262317AbVF1X62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:58:28 -0400
Date: Tue, 28 Jun 2005 18:58:17 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 1/13]: PCI Err: pci.h header file changes
Message-ID: <20050628235817.GA6324@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



pci-err-1-pci.h.patch

This patch adds PCI error recovery callbacks, error state and=20
error return codes to include/linux/pci.h.  These are closely=20
described in the next patch, a documentation file.

Signed-off-by: Linas Vepstas <linas@linas.org>

--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-1-pci.h.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.12-git10/include/linux/pci.h.linas-orig	2005-06-17 14:48:29.0=
00000000 -0500
+++ linux-2.6.12-git10/include/linux/pci.h	2005-06-24 14:44:59.000000000 -0=
500
@@ -660,6 +660,37 @@ struct pci_dynids {
 	unsigned int use_driver_data:1; /* pci_driver->driver_data is used */
 };
=20
+/* ---------------------------------------------------------------- */
+/** PCI error recovery infrastructure.  If a PCI device driver provides
+ *  a set fof callbacks in struct pci_error_handlers, then that device dri=
ver
+ *  will be notified of PCI bus errors, and can be driven to recovery.
+ */
+
+enum pci_channel_state {
+	pci_channel_io_normal =3D 0, /* I/O channel is in normal state */
+	pci_channel_io_frozen =3D 1, /* I/O to channel is blocked */
+	pci_channel_io_perm_failure, /* pci card is dead */
+};
+
+enum pcierr_result {
+	PCIERR_RESULT_NONE=3D0,        /* no result/none/not supported in device =
driver */
+	PCIERR_RESULT_CAN_RECOVER=3D1, /* Device driver can recover without slot =
reset */
+	PCIERR_RESULT_NEED_RESET,    /* Device driver wants slot to be reset. */
+	PCIERR_RESULT_DISCONNECT,    /* Device has completely failed, is unrecove=
rable */
+	PCIERR_RESULT_RECOVERED,     /* Device driver is fully recovered and oper=
ational */
+};
+
+/* PCI bus error event callbacks */
+struct pci_error_handlers
+{
+	enum pci_channel_state error_state;       /* current error state */
+	int (*error_detected)(struct pci_dev *dev, enum pci_channel_state error);
+	int (*mmio_enabled)(struct pci_dev *dev); /* MMIO has been reanbled, but =
not DMA */
+	int (*link_reset)(struct pci_dev *dev);   /* PCI Express link has been re=
set */
+	int (*slot_reset)(struct pci_dev *dev);   /* PCI slot has been reset */
+	void (*resume)(struct pci_dev *dev);      /* Device driver may resume nor=
mal operations */
+};
+
 struct module;
 struct pci_driver {
 	struct list_head node;
@@ -673,6 +704,7 @@ struct pci_driver {
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);=
   /* Enable wake event */
 	void (*shutdown) (struct pci_dev *dev);
=20
+	struct pci_error_handlers err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
 };

--8GpibOaaTibBMecb--
