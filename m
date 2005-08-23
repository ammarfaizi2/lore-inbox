Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVHWXnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVHWXnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVHWXnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:43:32 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:48549 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751283AbVHWXnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:43:31 -0400
Date: Tue, 23 Aug 2005 18:43:15 -0500
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
       moilanen@austin.ibm.com, akpm@osdl.org, greg@kroah.com
Subject: [patch 4/8] PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20050823234315.GE18113@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232140.903067000@bilge>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <20050823232140.903067000@bilge>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the Symbios SCSI device driv=
er.
The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/configs/pSeries_defconfig |    1=20
 drivers/scsi/Kconfig                 |    8 ++
 drivers/scsi/sym53c8xx_2/sym_glue.c  |  124 ++++++++++++++++++++++++++++++=
+++++
 drivers/scsi/sym53c8xx_2/sym_glue.h  |    4 +
 drivers/scsi/sym53c8xx_2/sym_hipd.c  |   16 ++++
 5 files changed, 153 insertions(+)

Index: linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/arch/ppc64/configs/pSeries_defconfig	2005-08=
-19 13:40:44.000000000 -0500
+++ linux-2.6.13-rc6-git9/arch/ppc64/configs/pSeries_defconfig	2005-08-19 1=
4:18:39.000000000 -0500
@@ -473,6 +473,7 @@
 CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
 # CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
+CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY=3Dy
 CONFIG_SCSI_IPR=3Dy
 CONFIG_SCSI_IPR_TRACE=3Dy
 CONFIG_SCSI_IPR_DUMP=3Dy
Index: linux-2.6.13-rc6-git9/drivers/scsi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/scsi/Kconfig	2005-08-19 13:40:10.000=
000000 -0500
+++ linux-2.6.13-rc6-git9/drivers/scsi/Kconfig	2005-08-19 14:18:09.00000000=
0 -0500
@@ -1040,6 +1040,14 @@
 	  the card.  This is significantly slower then using memory
 	  mapped IO.  Most people should answer N.
=20
+config SCSI_SYM53C8XX_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on SCSI_SYM53C8XX_2 && PPC_PSERIES
+	help
+		If you say Y here, the driver will be able to recover from
+		PCI bus errors on many PowerPC platforms. IBM pSeries users
+		should answer Y.
+
 config SCSI_IPR
 	tristate "IBM Power Linux RAID adapter support"
 	depends on PCI && SCSI
Index: linux-2.6.13-rc6-git9/drivers/scsi/sym53c8xx_2/sym_glue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-08-=
17 15:14:15.000000000 -0500
+++ linux-2.6.13-rc6-git9/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-08-19 14=
:23:02.000000000 -0500
@@ -685,6 +685,10 @@
 	struct sym_hcb *np =3D (struct sym_hcb *)dev_id;
=20
 	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+	if (np->s.io_state !=3D pci_channel_io_normal)
+		return IRQ_HANDLED;
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
=20
 	spin_lock_irqsave(np->s.host->host_lock, flags);
 	sym_interrupt(np);
@@ -759,6 +763,27 @@
  */
 static void sym_eh_timeout(u_long p) { __sym_eh_done((struct scsi_cmnd *)p=
, 1); }
=20
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+static void sym_eeh_timeout(u_long p)
+{
+	struct sym_eh_wait *ep =3D (struct sym_eh_wait *) p;
+	if (!ep)
+		return;
+	complete(&ep->done);
+}
+
+static void sym_eeh_done(struct sym_eh_wait *ep)
+{
+	if (!ep)
+		return;
+	ep->timed_out =3D 0;
+	if (!del_timer(&ep->timer))
+		return;
+
+	complete(&ep->done);
+}
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+
 /*
  *  Generic method for our eh processing.
  *  The 'op' argument tells what we have to do.
@@ -799,6 +824,37 @@
=20
 	/* Try to proceed the operation we have been asked for */
 	sts =3D -1;
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+
+	/* We may be in an error condition because the PCI bus
+	 * went down. In this case, we need to wait until the
+	 * PCI bus is reset, the card is reset, and only then
+	 * proceed with the scsi error recovery.  We'll wait
+	 * for 15 seconds for this to happen.
+	 */
+#define WAIT_FOR_PCI_RECOVERY	15
+	if (np->s.io_state !=3D pci_channel_io_normal) {
+		struct sym_eh_wait eeh, *eep =3D &eeh;
+		np->s.io_reset_wait =3D eep;
+		init_completion(&eep->done);
+		init_timer(&eep->timer);
+		eep->to_do =3D SYM_EH_DO_WAIT;
+		eep->timer.expires =3D jiffies + (WAIT_FOR_PCI_RECOVERY*HZ);
+		eep->timer.function =3D sym_eeh_timeout;
+		eep->timer.data =3D (u_long)eep;
+		eep->timed_out =3D 1;	/* Be pessimistic for once :) */
+		add_timer(&eep->timer);
+		spin_unlock_irq(np->s.host->host_lock);
+		wait_for_completion(&eep->done);
+		spin_lock_irq(np->s.host->host_lock);
+		if (eep->timed_out) {
+			printk (KERN_ERR "%s: Timed out waiting for PCI reset\n",
+			       sym_name(np));
+		}
+		np->s.io_reset_wait =3D NULL;
+	}
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+
 	switch(op) {
 	case SYM_EH_ABORT:
 		sts =3D sym_abort_scsiio(np, cmd, 1);
@@ -1584,6 +1640,10 @@
 	np->maxoffs	=3D dev->chip.offset_max;
 	np->maxburst	=3D dev->chip.burst_max;
 	np->myaddr	=3D dev->host_id;
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+	np->s.io_state =3D pci_channel_io_normal;
+	np->s.io_reset_wait =3D NULL;
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
=20
 	/*
 	 *  Edit its name.
@@ -1916,6 +1976,59 @@
 	return 1;
 }
=20
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+/** sym2_io_error_detected() is called when PCI error is detected */
+static int sym2_io_error_detected (struct pci_dev *pdev, enum pci_channel_=
state state)
+{
+	struct sym_hcb *np =3D pci_get_drvdata(pdev);
+
+	np->s.io_state =3D state;
+	// XXX If slot is permanently frozen, then what?
+	// Should we scsi_remove_host() maybe ??
+
+	/* Request a slot slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** sym2_io_slot_reset is called when the pci bus has been reset.
+ *  Restart the card from scratch. */
+static int sym2_io_slot_reset (struct pci_dev *pdev)
+{
+	struct sym_hcb *np =3D pci_get_drvdata(pdev);
+
+	printk (KERN_INFO "%s: recovering from a PCI slot reset\n",
+	    sym_name(np));
+
+	if (pci_enable_device(pdev))
+		printk (KERN_ERR "%s: device setup failed most egregiously\n",
+			    sym_name(np));
+
+	pci_set_master(pdev);
+	enable_irq (pdev->irq);
+
+	/* Perform host reset only on one instance of the card */
+	if (0 =3D=3D PCI_FUNC (pdev->devfn))
+		sym_reset_scsi_bus(np, 0);
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** sym2_io_resume is called when the error recovery driver
+ *  tells us that its OK to resume normal operation.
+ */
+static void sym2_io_resume (struct pci_dev *pdev)
+{
+	struct sym_hcb *np =3D pci_get_drvdata(pdev);
+
+	/* Perform device startup only once for this card. */
+	if (0 =3D=3D PCI_FUNC (pdev->devfn))
+		sym_start_up (np, 1);
+
+	np->s.io_state =3D pci_channel_io_normal;
+	sym_eeh_done (np->s.io_reset_wait);
+}
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+
 /*
  * Driver host template.
  */
@@ -2169,11 +2282,22 @@
=20
 MODULE_DEVICE_TABLE(pci, sym2_id_table);
=20
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+static struct pci_error_handlers sym2_err_handler =3D {
+	.error_detected =3D sym2_io_error_detected,
+	.slot_reset =3D sym2_io_slot_reset,
+	.resume =3D sym2_io_resume,
+};
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+
 static struct pci_driver sym2_driver =3D {
 	.name		=3D NAME53C8XX,
 	.id_table	=3D sym2_id_table,
 	.probe		=3D sym2_probe,
 	.remove		=3D __devexit_p(sym2_remove),
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+	.err_handler =3D &sym2_err_handler,
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
 };
=20
 static int __init sym2_init(void)
Index: linux-2.6.13-rc6-git9/drivers/scsi/sym53c8xx_2/sym_glue.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/scsi/sym53c8xx_2/sym_glue.h	2005-08-=
17 15:14:15.000000000 -0500
+++ linux-2.6.13-rc6-git9/drivers/scsi/sym53c8xx_2/sym_glue.h	2005-08-19 14=
:18:09.000000000 -0500
@@ -181,6 +181,10 @@
 	char		chip_name[8];
 	struct pci_dev	*device;
=20
+	/* pci bus i/o state; waiter for clearing of i/o state */
+	enum pci_channel_state io_state;
+	struct sym_eh_wait *io_reset_wait;
+
 	struct Scsi_Host *host;
=20
 	void __iomem *	ioaddr;		/* MMIO kernel io address	*/
Index: linux-2.6.13-rc6-git9/drivers/scsi/sym53c8xx_2/sym_hipd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-08-=
17 15:14:15.000000000 -0500
+++ linux-2.6.13-rc6-git9/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-08-19 14=
:20:44.000000000 -0500
@@ -2806,6 +2806,7 @@
 	u_char	istat, istatc;
 	u_char	dstat;
 	u_short	sist;
+	u_int    icnt;
=20
 	/*
 	 *  interrupt on the fly ?
@@ -2847,6 +2848,7 @@
 	sist	=3D 0;
 	dstat	=3D 0;
 	istatc	=3D istat;
+	icnt =3D 0;
 	do {
 		if (istatc & SIP)
 			sist  |=3D INW(np, nc_sist);
@@ -2854,6 +2856,20 @@
 			dstat |=3D INB(np, nc_dstat);
 		istatc =3D INB(np, nc_istat);
 		istat |=3D istatc;
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+		/* Prevent deadlock waiting on a condition that may never clear. */
+		/* XXX this is a temporary kludge; the correct to detect
+		 * a PCI bus error would be to use the io_check interfaces
+		 * proposed by Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+		 * Problem with polling like that is the state flag might not
+		 * be set.
+		 */
+		icnt ++;
+		if (100 < icnt) {
+			if (np->s.device->error_state !=3D pci_channel_io_normal)
+				return;
+		}
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
 	} while (istatc & (SIP|DIP));
=20
 	if (DEBUG_FLAGS & DEBUG_TINY)

--

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDC7SSZKmaggEEWTMRAiE9AJ9Bmb2DiRf4P50j5TakIVA9C2kGRwCdGgpH
GtLl7vIRD+utzpb+096unnQ=
=8m07
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
