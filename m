Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVHWXqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVHWXqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVHWXqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:46:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57057 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751312AbVHWXqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:46:15 -0400
Date: Tue, 23 Aug 2005 18:46:08 -0500
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
       moilanen@austin.ibm.com, akpm@osdl.org, greg@kroah.com
Subject: [patch 6/8] PCI Error Recovery: e1000 network device driver
Message-ID: <20050823234608.GG18113@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232141.925586000@bilge>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <20050823232141.925586000@bilge>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel gigabit
ethernet e1000 device driver. The patch has been tested, and appears
to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/configs/pSeries_defconfig |    1=20
 drivers/net/Kconfig                  |    8 ++
 drivers/net/e1000/e1000_main.c       |  103 ++++++++++++++++++++++++++++++=
++++-
 3 files changed, 111 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/arch/ppc64/configs/pSeries_defconfig	2005-08=
-19 14:47:01.000000000 -0500
+++ linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig	2005-08-19 1=
4:47:18.000000000 -0500
@@ -593,6 +593,7 @@
 # CONFIG_DL2K is not set
 CONFIG_E1000=3Dy
 # CONFIG_E1000_NAPI is not set
+CONFIG_E1000_EEH_RECOVERY=3Dy
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
Index: linux-2.6.13-rc6-git9/drivers/net/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/net/Kconfig	2005-08-19 14:47:01.0000=
00000 -0500
+++ linux-2.6.13-rc6-git9/drivers/net/Kconfig	2005-08-19 14:47:18.000000000=
 -0500
@@ -1847,6 +1847,14 @@
=20
 	  If in doubt, say N.
=20
+config E1000_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on E1000 && PPC_PSERIES
+   help
+      If you say Y here, the driver will be able to recover from
+      PCI bus errors on many PowerPC platforms. IBM pSeries users
+      should answer Y.
+
 config MYRI_SBUS
 	tristate "MyriCOM Gigabit Ethernet support"
 	depends on SBUS
Index: linux-2.6.13-rc6-git9/drivers/net/e1000/e1000_main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/net/e1000/e1000_main.c	2005-08-19 14=
:47:01.000000000 -0500
+++ linux-2.6.13-rc6-git9/drivers/net/e1000/e1000_main.c	2005-08-19 14:51:1=
2.000000000 -0500
@@ -172,6 +172,18 @@
 static void e1000_netpoll (struct net_device *netdev);
 #endif
=20
+#ifdef CONFIG_E1000_EEH_RECOVERY
+static int e1000_io_error_detected (struct pci_dev *pdev, enum pci_channel=
_state state);
+static int e1000_io_slot_reset (struct pci_dev *pdev);
+static void e1000_io_resume (struct pci_dev *pdev);
+
+static struct pci_error_handlers e1000_err_handler =3D {
+	.error_detected =3D e1000_io_error_detected,
+	.slot_reset =3D e1000_io_slot_reset,
+	.resume =3D e1000_io_resume,
+};
+#endif /* CONFIG_E1000_EEH_RECOVERY */
+
 /* Exported from other modules */
=20
 extern void e1000_check_options(struct e1000_adapter *adapter);
@@ -184,8 +196,11 @@
 	/* Power Managment Hooks */
 #ifdef CONFIG_PM
 	.suspend  =3D e1000_suspend,
-	.resume   =3D e1000_resume
+	.resume   =3D e1000_resume,
 #endif
+#ifdef CONFIG_E1000_EEH_RECOVERY
+	.err_handler =3D &e1000_err_handler,
+#endif /* CONFIG_E1000_EEH_RECOVERY */
=20
 };
=20
@@ -3796,4 +3811,90 @@
 }
 #endif
=20
+#ifdef CONFIG_E1000_EEH_RECOVERY
+
+/** e1000_io_error_detected() is called when PCI error is detected */
+static int e1000_io_error_detected (struct pci_dev *pdev, enum pci_channel=
_state state)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter =3D netdev->priv;
+
+	if(netif_running(netdev))
+		e1000_down(adapter);
+
+	/* Request a slot slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** e1000_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch.
+ *  Implementation resembles the first-half of the
+ *  e1000_resume routine.
+ */
+static int e1000_io_slot_reset (struct pci_dev *pdev)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter =3D netdev->priv;
+
+	if(pci_enable_device(pdev)) {
+		printk(KERN_ERR "e1000: Cannot re-enable PCI device after reset.\n");
+		return PCIERR_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	pci_enable_wake(pdev, 3, 0);
+	pci_enable_wake(pdev, 4, 0); /* 4 =3D=3D D3 cold */
+
+	/* Perform card reset only on one instance of the card */
+	if (0 !=3D PCI_FUNC (pdev->devfn))
+		return PCIERR_RESULT_RECOVERED;
+
+	e1000_reset(adapter);
+	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** e1000_io_resume is called when the error recovery driver
+ *  tells us that its OK to resume normal operation.
+ *  Implementation resembles the second-half of the
+ *  e1000_resume routine.
+ */
+static void e1000_io_resume (struct pci_dev *pdev)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter =3D netdev->priv;
+	uint32_t manc, swsm;
+
+	if(netif_running(netdev)) {
+		if(e1000_up(adapter)) {
+			printk ("e1000: can't bring device back up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+
+	if(adapter->hw.mac_type >=3D e1000_82540 &&
+	   adapter->hw.media_type =3D=3D e1000_media_type_copper) {
+		manc =3D E1000_READ_REG(&adapter->hw, MANC);
+		manc &=3D ~(E1000_MANC_ARP_EN);
+		E1000_WRITE_REG(&adapter->hw, MANC, manc);
+	}
+
+	switch(adapter->hw.mac_type) {
+	case e1000_82573:
+		swsm =3D E1000_READ_REG(&adapter->hw, SWSM);
+		E1000_WRITE_REG(&adapter->hw, SWSM,
+				swsm | E1000_SWSM_DRV_LOAD);
+		break;
+	default:
+		break;
+	}
+
+	mod_timer(&adapter->watchdog_timer, jiffies);
+}
+
+#endif /* CONFIG_E1000_EEH_RECOVERY */
+
 /* e1000_main.c */

--

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDC7U/ZKmaggEEWTMRAqDcAJ90Y5mKps4rMB7SnYDS1c4+QLUUJACfb4TG
MpiZALsc5bZ2J96UUVIXHmo=
=MBs4
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
