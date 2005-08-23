Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVHWXp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVHWXp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVHWXp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:45:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:44488 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751290AbVHWXp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:45:28 -0400
Date: Tue, 23 Aug 2005 18:45:23 -0500
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
       moilanen@austin.ibm.com, akpm@osdl.org, greg@kroah.com
Subject: [patch 5/8] PCI Error Recovery: e100 network device driver
Message-ID: <20050823234523.GF18113@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232141.286102000@bilge>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <20050823232141.286102000@bilge>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ethernet e100
device driver. The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/configs/pSeries_defconfig |    1=20
 drivers/net/Kconfig                  |    8 +++
 drivers/net/e100.c                   |   73 ++++++++++++++++++++++++++++++=
+++++
 3 files changed, 82 insertions(+)

Index: linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/arch/ppc64/configs/pSeries_defconfig	2005-08=
-19 14:18:39.000000000 -0500
+++ linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig	2005-08-19 1=
4:31:26.000000000 -0500
@@ -574,6 +574,7 @@
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=3Dy
+CONFIG_E100_EEH_RECOVERY=3Dy
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
Index: linux-2.6.13-rc6-git9/drivers/net/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/net/Kconfig	2005-08-17 15:13:33.0000=
00000 -0500
+++ linux-2.6.13-rc6-git9/drivers/net/Kconfig	2005-08-19 14:31:26.000000000=
 -0500
@@ -1392,6 +1392,14 @@
 	  <file:Documentation/networking/net-modules.txt>.  The module
 	  will be called e100.
=20
+config E100_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on E100 && PPC_PSERIES
+   help
+      If you say Y here, the driver will be able to recover from
+      PCI bus errors on many PowerPC platforms. IBM pSeries users
+      should answer Y.
+
 config LNE390
 	tristate "Mylex EISA LNE390A/B support (EXPERIMENTAL)"
 	depends on NET_PCI && EISA && EXPERIMENTAL
Index: linux-2.6.13-rc6-git9/drivers/net/e100.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/net/e100.c	2005-08-17 15:13:36.00000=
0000 -0500
+++ linux-2.6.13-rc6-git9/drivers/net/e100.c	2005-08-19 14:34:11.000000000 =
-0500
@@ -2459,6 +2459,76 @@
 #endif
 }
=20
+#ifdef CONFIG_E100_EEH_RECOVERY
+
+/** e100_io_error_detected() is called when PCI error is detected */
+static int e100_io_error_detected (struct pci_dev *pdev, enum pci_channel_=
state state)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+
+	/* Same as calling e100_down(netdev_priv(netdev)), but generic */
+	netdev->stop(netdev);
+
+	/* Is a detach needed ?? */
+	// netif_device_detach(netdev);
+
+	/* Request a slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** e100_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch. */
+static int e100_io_slot_reset (struct pci_dev *pdev)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	struct nic *nic =3D netdev_priv(netdev);
+
+	if(pci_enable_device(pdev)) {
+		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");
+		return PCIERR_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	/* Only one device per card can do a reset */
+	if (0 !=3D PCI_FUNC (pdev->devfn))
+		return PCIERR_RESULT_RECOVERED;
+
+	e100_hw_reset(nic);
+	e100_phy_init(nic);
+
+	if(e100_hw_init(nic)) {
+		DPRINTK(HW, ERR, "e100_hw_init failed\n");
+		return PCIERR_RESULT_DISCONNECT;
+	}
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** e100_io_resume is called when the error recovery driver
+ *  tells us that its OK to resume normal operation.
+ */
+static void e100_io_resume (struct pci_dev *pdev)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	struct nic *nic =3D netdev_priv(netdev);
+
+	/* ack any pending wake events, disable PME */
+	pci_enable_wake(pdev, 0, 0);
+
+	netif_device_attach(netdev);
+	if(netif_running(netdev))
+		e100_open (netdev);
+
+	mod_timer(&nic->watchdog, jiffies);
+}
+
+static struct pci_error_handlers e100_err_handler =3D {
+	.error_detected =3D e100_io_error_detected,
+	.slot_reset =3D e100_io_slot_reset,
+	.resume =3D e100_io_resume,
+};
+
+#endif /* CONFIG_E100_EEH_RECOVERY */
=20
 static struct pci_driver e100_driver =3D {
 	.name =3D         DRV_NAME,
@@ -2470,6 +2540,9 @@
 	.resume =3D       e100_resume,
 #endif
 	.shutdown =3D	e100_shutdown,
+#ifdef CONFIG_E100_EEH_RECOVERY
+	.err_handler =3D &e100_err_handler,
+#endif /* CONFIG_E100_EEH_RECOVERY */
 };
=20
 static int __init e100_init_module(void)

--

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDC7USZKmaggEEWTMRAnBPAJ9gmKaVOEgZSLGbAkpkuf/O728xqACfQXq2
+0RYzVxPaoSTEgjyl+9r/B4=
=XQWp
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
