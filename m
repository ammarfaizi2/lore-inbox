Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVHWXlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVHWXlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVHWXlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:41:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40867 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751269AbVHWXly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:41:54 -0400
Date: Tue, 23 Aug 2005 18:41:50 -0500
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
       moilanen@austin.ibm.com, akpm@osdl.org, greg@kroah.com
Subject: [patch 3/8] PCI Error Recovery: IPR SCSI device driver
Message-ID: <20050823234150.GD18113@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232140.520090000@bilge>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <20050823232140.520090000@bilge>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the IPR SCSI device driver.
The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/configs/pSeries_defconfig |    1=20
 drivers/scsi/Kconfig                 |    8 +++
 drivers/scsi/ipr.c                   |   93 ++++++++++++++++++++++++++++++=
+++++
 3 files changed, 102 insertions(+)

Index: linux-2.6.13-rc6-git9/drivers/scsi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/scsi/Kconfig	2005-08-19 13:39:32.000=
000000 -0500
+++ linux-2.6.13-rc6-git9/drivers/scsi/Kconfig	2005-08-19 13:40:10.00000000=
0 -0500
@@ -1065,6 +1065,14 @@
 	  If you enable this support, the iprdump daemon can be used
 	  to capture adapter failure analysis information.
=20
+config SCSI_IPR_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on SCSI_IPR && PPC_PSERIES
+	help
+		If you say Y here, the driver will be able to recover from
+		PCI bus errors on many PowerPC platforms. IBM pSeries users
+		should answer Y.
+
 config SCSI_ZALON
 	tristate "Zalon SCSI support"
 	depends on GSC && SCSI
Index: linux-2.6.13-rc6-git9/drivers/scsi/ipr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/scsi/ipr.c	2005-08-19 13:39:31.00000=
0000 -0500
+++ linux-2.6.13-rc6-git9/drivers/scsi/ipr.c	2005-08-19 13:40:09.000000000 =
-0500
@@ -5326,6 +5326,88 @@
 				shutdown_type);
 }
=20
+#ifdef CONFIG_SCSI_IPR_EEH_RECOVERY
+
+/** If the PCI slot is frozen, hold off all i/o
+ *  activity; then, as soon as the slot is available again,
+ *  initiate an adapter reset.
+ */
+static int ipr_reset_freeze(struct ipr_cmnd *ipr_cmd)
+{
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->ioa_cfg->pending_q);
+	ipr_cmd->done =3D ipr_reset_ioa_job;
+	return IPR_RC_JOB_RETURN;
+}
+
+/** ipr_eeh_frozen -- called when slot has experience PCI bus error.
+ *  This routine is called to tell us that the PCI bus is down.
+ *  Can't do anything here, except put the device driver into a
+ *  holding pattern, waiting for the PCI bus to come back.
+ */
+static void ipr_eeh_frozen (struct pci_dev *pdev)
+{
+	unsigned long flags =3D 0;
+	struct ipr_ioa_cfg *ioa_cfg =3D pci_get_drvdata(pdev);
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
+	_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_freeze, IPR_SHUTDOWN_NONE);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
+}
+
+/** ipr_eeh_slot_reset - called when pci slot has been reset.
+ *
+ * This routine is called by the pci error recovery recovery
+ * code after the PCI slot has been reset, just before we
+ * should resume normal operations.
+ */
+static int ipr_eeh_slot_reset (struct pci_dev *pdev)
+{
+	unsigned long flags =3D 0;
+	struct ipr_ioa_cfg *ioa_cfg =3D pci_get_drvdata(pdev);
+
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
+	enable_irq (pdev->irq);
+	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
+	_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_restore_cfg_space,
+	                                 IPR_SHUTDOWN_NONE);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** This routine is called when the PCI bus has permanently
+ *  failed.  This routine should purge all pending I/O and
+ *  shut down the device driver (close and unload).
+ *  XXX Needs to be implemented.
+ */
+static void ipr_eeh_perm_failure (struct pci_dev *pdev)
+{
+#if 0  // XXXXXXXXXXXXXXXXXXXXXXX
+	ipr_cmd->job_step =3D ipr_reset_shutdown_ioa;
+	rc =3D IPR_RC_JOB_CONTINUE;
+#endif
+}
+
+static int ipr_eeh_error_detected (struct pci_dev *pdev,
+                                enum pci_channel_state state)
+{
+	switch (state) {
+		case pci_channel_io_frozen:
+			ipr_eeh_frozen (pdev);
+			return PCIERR_RESULT_NEED_RESET;
+
+		case pci_channel_io_perm_failure:
+			ipr_eeh_perm_failure (pdev);
+			return PCIERR_RESULT_DISCONNECT;
+			break;
+		default:
+			break;
+	}
+	return PCIERR_RESULT_NEED_RESET;
+}
+#endif
+
 /**
  * ipr_probe_ioa_part2 - Initializes IOAs found in ipr_probe_ioa(..)
  * @ioa_cfg:	ioa cfg struct
@@ -6063,12 +6145,23 @@
 };
 MODULE_DEVICE_TABLE(pci, ipr_pci_table);
=20
+
+#ifdef CONFIG_SCSI_IPR_EEH_RECOVERY
+static struct pci_error_handlers ipr_err_handler =3D {
+	.error_detected =3D ipr_eeh_error_detected,
+	.slot_reset =3D ipr_eeh_slot_reset,
+};
+#endif /* CONFIG_SCSI_IPR_EEH_RECOVERY */
+
 static struct pci_driver ipr_driver =3D {
 	.name =3D IPR_NAME,
 	.id_table =3D ipr_pci_table,
 	.probe =3D ipr_probe,
 	.remove =3D ipr_remove,
 	.shutdown =3D ipr_shutdown,
+#ifdef CONFIG_SCSI_IPR_EEH_RECOVERY
+	.err_handler =3D &ipr_err_handler,
+#endif /* CONFIG_SCSI_IPR_EEH_RECOVERY */
 };
=20
 /**
Index: linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/arch/ppc64/configs/pSeries_defconfig	2005-08=
-19 13:39:32.000000000 -0500
+++ linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig	2005-08-19 1=
3:40:44.000000000 -0500
@@ -476,6 +476,7 @@
 CONFIG_SCSI_IPR=3Dy
 CONFIG_SCSI_IPR_TRACE=3Dy
 CONFIG_SCSI_IPR_DUMP=3Dy
+CONFIG_SCSI_IPR_EEH_RECOVERY=3Dy
 # CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 CONFIG_SCSI_QLA2XXX=3Dy

--

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDC7Q9ZKmaggEEWTMRAhc/AJ4wjqXmIk6dZjfXHtDcjrAPXVcTWwCeKNrK
TmEnYeWSx7Vw6OQ1PcA+k/c=
=20Tv
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
