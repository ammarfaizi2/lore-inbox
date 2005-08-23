Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVHWXje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVHWXje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVHWXjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:39:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:46225 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751269AbVHWXjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:39:33 -0400
Date: Tue, 23 Aug 2005 18:39:27 -0500
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
       moilanen@austin.ibm.com, akpm@osdl.org, greg@kroah.com
Subject: [patch 2/8] PCI Error Recovery: header file patch
Message-ID: <20050823233927.GC18113@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232140.337320000@bilge>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20050823232140.337320000@bilge>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Various PCI bus errors can be signaled by newer PCI controllers. Recovering=
=20
=66rom those errors requires an infrastructure to notify affected device dr=
ivers=20
of the error, and a way of walking through a reset sequence.  This patch ad=
ds=20
a set of callbacks to be used by error recovery routines to notify device=
=20
drivers of the various stages of recovery.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 include/linux/pci.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+)

Index: linux-2.6.13-rc6-git9/include/linux/pci.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/include/linux/pci.h	2005-08-19 13:03:27.0000=
00000 -0500
+++ linux-2.6.13-rc6-git9/include/linux/pci.h	2005-08-19 13:03:32.000000000=
 -0500
@@ -78,6 +78,16 @@
 #define PCI_UNKNOWN	((pci_power_t __force) 5)
 #define PCI_POWER_ERROR	((pci_power_t __force) -1)
=20
+/** The pci_channel state describes connectivity between the CPU and
+ *  the pci device.  If some PCI bus between here and the pci device
+ *  has crashed or locked up, this info is reflected here.
+ */
+enum pci_channel_state {
+	pci_channel_io_normal =3D 0, /* I/O channel is in normal state */
+	pci_channel_io_frozen =3D 1, /* I/O to channel is blocked */
+	pci_channel_io_perm_failure, /* PCI card is dead */
+};
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -110,6 +120,7 @@
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
=20
+	enum pci_channel_state error_state;  /* current connectivity state */
 	struct	device	dev;		/* Generic device interface */
=20
 	/* device is compatible with these IDs */
@@ -231,6 +242,33 @@
 	unsigned int use_driver_data:1; /* pci_driver->driver_data is used */
 };
=20
+/* ---------------------------------------------------------------- */
+/** PCI error recovery infrastructure.  If a PCI device driver provides
+ *  a set fof callbacks in struct pci_error_handlers, then that device dri=
ver
+ *  will be notified of PCI bus errors, and will be driven to recovery
+ *  when an error occurs.
+ */
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
+/* ---------------------------------------------------------------- */
+
 struct module;
 struct pci_driver {
 	struct list_head node;
@@ -244,6 +282,7 @@
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);=
   /* Enable wake event */
 	void (*shutdown) (struct pci_dev *dev);
=20
+	struct pci_error_handlers *err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
 };

--

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDC7OuZKmaggEEWTMRAlILAJ4lgyCG7dglQqLXE1UfFDZiXXhXrACffOpP
XFYZacZjwZ3wZacUGDIxuyQ=
=bG0l
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
