Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVHWXrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVHWXrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVHWXrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:47:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:61593 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751326AbVHWXrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:47:06 -0400
Date: Tue, 23 Aug 2005 18:47:02 -0500
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
       moilanen@austin.ibm.com, akpm@osdl.org, greg@kroah.com
Subject: [patch 7/8] PCI Error Recovery: ixgb network device driver
Message-ID: <20050823234702.GH18113@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232142.651390000@bilge>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Content-Disposition: inline
In-Reply-To: <20050823232142.651390000@bilge>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ten-gigabit
ethernet ixgb device driver. The patch has been tested, and appears
to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/configs/pSeries_defconfig |    1=20
 drivers/net/Kconfig                  |    8 +++
 drivers/net/ixgb/ixgb_main.c         |   78 ++++++++++++++++++++++++++++++=
+++++
 3 files changed, 87 insertions(+)

Index: linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/arch/ppc64/configs/pSeries_defconfig	2005-08=
-19 14:47:18.000000000 -0500
+++ linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig	2005-08-19 1=
4:57:35.000000000 -0500
@@ -610,6 +610,7 @@
 #
 CONFIG_IXGB=3Dm
 # CONFIG_IXGB_NAPI is not set
+CONFIG_IXGB_EEH_RECOVERY=3Dy
 CONFIG_S2IO=3Dm
 # CONFIG_S2IO_NAPI is not set
 # CONFIG_2BUFF_MODE is not set
Index: linux-2.6.13-rc6-git9/drivers/net/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/net/Kconfig	2005-08-19 14:47:18.0000=
00000 -0500
+++ linux-2.6.13-rc6-git9/drivers/net/Kconfig	2005-08-19 14:57:35.000000000=
 -0500
@@ -2146,6 +2146,14 @@
=20
 	  If in doubt, say N.
=20
+config IXGB_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on IXGB && PPC_PSERIES
+   help
+      If you say Y here, the driver will be able to recover from
+      PCI bus errors on many PowerPC platforms. IBM pSeries users
+      should answer Y.
+
 config S2IO
 	tristate "S2IO 10Gbe XFrame NIC"
 	depends on PCI
Index: linux-2.6.13-rc6-git9/drivers/net/ixgb/ixgb_main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/net/ixgb/ixgb_main.c	2005-08-17 15:1=
3:45.000000000 -0500
+++ linux-2.6.13-rc6-git9/drivers/net/ixgb/ixgb_main.c	2005-08-19 14:57:35.=
000000000 -0500
@@ -128,6 +128,18 @@
 static void ixgb_netpoll(struct net_device *dev);
 #endif
=20
+#ifdef CONFIG_IXGB_EEH_RECOVERY
+static int ixgb_io_error_detected (struct pci_dev *pdev, enum pci_channel_=
state state);
+static int ixgb_io_slot_reset (struct pci_dev *pdev);
+static void ixgb_io_resume (struct pci_dev *pdev);
+
+static struct pci_error_handlers ixgb_err_handler =3D {
+	.error_detected =3D ixgb_io_error_detected,
+	.slot_reset =3D ixgb_io_slot_reset,
+	.resume =3D ixgb_io_resume,
+};
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 /* Exported from other modules */
=20
 extern void ixgb_check_options(struct ixgb_adapter *adapter);
@@ -137,6 +149,10 @@
 	.id_table =3D ixgb_pci_tbl,
 	.probe    =3D ixgb_probe,
 	.remove   =3D __devexit_p(ixgb_remove),
+#ifdef CONFIG_IXGB_EEH_RECOVERY
+	.err_handler =3D &ixgb_err_handler,
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 };
=20
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -2119,4 +2135,66 @@
 }
 #endif
=20
+#ifdef CONFIG_IXGB_EEH_RECOVERY
+
+/** ixgb_io_error_detected() is called when PCI error is detected */
+static int ixgb_io_error_detected (struct pci_dev *pdev, enum pci_channel_=
state state)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter =3D netdev->priv;
+
+	if(netif_running(netdev))
+		ixgb_down(adapter, TRUE);
+
+	/* Request a slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** ixgb_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch.
+ *  Implementation resembles the first-half of the
+ *  ixgb_resume routine.
+ */
+static int ixgb_io_slot_reset (struct pci_dev *pdev)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter =3D netdev->priv;
+
+	if(pci_enable_device(pdev)) {
+		printk(KERN_ERR "ixgb: Cannot re-enable PCI device after reset.\n");
+		return PCIERR_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	/* Perform card reset only on one instance of the card */
+	if (0 !=3D PCI_FUNC (pdev->devfn))
+		return PCIERR_RESULT_RECOVERED;
+
+	ixgb_reset(adapter);
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** ixgb_io_resume is called when the error recovery driver
+ *  tells us that its OK to resume normal operation.
+ *  Implementation resembles the second-half of the
+ *  ixgb_resume routine.
+ */
+static void ixgb_io_resume (struct pci_dev *pdev)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter =3D netdev->priv;
+
+	if(netif_running(netdev)) {
+		if(ixgb_up(adapter)) {
+			printk ("ixgb: can't bring device back up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+	mod_timer(&adapter->watchdog_timer, jiffies);
+}
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 /* ixgb_main.c */

--

--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDC7V1ZKmaggEEWTMRAsqmAJ9fWqn7LMsXYEEWIKn53lsJMu83FgCfXW/n
n9DdeOjbv96FfqGgN8M/fk0=
=lqqt
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--
