Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVGGO0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVGGO0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVGGOXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:23:49 -0400
Received: from mfep8.odn.ne.jp ([143.90.131.186]:24299 "EHLO t-mta8.odn.ne.jp")
	by vger.kernel.org with ESMTP id S261587AbVGGOXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:23:07 -0400
Date: Thu, 7 Jul 2005 23:23:02 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: sata_sil 3112 activity LED patch
Message-ID: <20050707142301.GA11182@alumni.uwaterloo.ca>
References: <20050706025136.GA15493@alumni.uwaterloo.ca> <42CBF3A1.1020508@pobox.com> <20050707124702.GB24401@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20050707124702.GB24401@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 07, 2005 at 02:47:03PM +0200, Jens Axboe wrote:
> On Wed, Jul 06 2005, Jeff Garzik wrote:
> > I don't think its ugly, necessarily.  I do worry about the flash memory=
=20
> > stuff, though, which is why I don't want to merge this upstream for now.
> >=20
> > For your patch specifically, it would be nice to follow the coding styl=
e=20
> > that is found in the rest of the driver (single-tab indents, etc., read=
=20
> > CodingStyle in kernel source tree).

I cleaned it up... it got quite a bit larger since I am attempting to
check for valid usage.  Unfortunately I do not know if the 3114 has a
similar GPIO mechanism, nor do I have an add on card with a 3112 to
verify with.  My new/improved patch is attached, tested on my system
with 2.6.12.

If anyone with either such devices could test (with caution!) I'd like
to hear the results.  Alternatively, I'd be interested in the value of
the MMIO register at BASE_ADDRESS_5 + 0x54 before the driver is
loaded.

> There's also an existing variant of this in the block layer, the
> activity_fn, that we use on the ibook/powerbook to use the sleep led as
> an activity light. Just in case you prefer that to overloading the bmdma
> start/stop handlers.

You suggestion at first looked to be incredibly nice... until I looked
at how much implementation was required.  I am considering trying it,
but I cannot find a place for an sata driver to call the
blk_queue_activity_fn() with meaningful parameters during init.

On a second look, I guess I would have to override
ata_scsi_slave_config() in the driver and hook up the activity light
there.  This would be fine I guess.  Unless I am interpreting this
incorrectly, however, I would need to use a timer or something to turn
the light back off?  I'm probably missing something, so is there a
simpler way to do this?

--=20
Aric Cyr <acyr at alumni dot uwaterloo dot ca>    (http://acyr.net)
gpg fingerprint: 943A 1549 47AC D766 B7F8  D551 6703 7142 C282 D542

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_sil-led.patch"
Content-Transfer-Encoding: quoted-printable

--- drivers/scsi/sata_sil.c.orig	2005-07-07 10:07:19.000000000 +0900
+++ drivers/scsi/sata_sil.c	2005-07-07 23:19:36.000000000 +0900
@@ -54,6 +54,7 @@
 	SIL_FIFO_W3		=3D 0x245,
=20
 	SIL_SYSCFG		=3D 0x48,
+	SIL_GPIO                =3D 0x54,
 	SIL_MASK_IDE0_INT	=3D (1 << 22),
 	SIL_MASK_IDE1_INT	=3D (1 << 23),
 	SIL_MASK_IDE2_INT	=3D (1 << 24),
@@ -74,6 +75,9 @@
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 v=
al);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_bmdma_start(struct ata_queued_cmd *qc);
+static void sil_bmdma_stop(struct ata_port *ap);
+static void sil_host_stop (struct ata_host_set *host_set);
=20
 static struct pci_device_id sil_pci_tbl[] =3D {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -149,8 +152,8 @@
 	.phy_reset		=3D sata_phy_reset,
 	.post_set_mode		=3D sil_post_set_mode,
 	.bmdma_setup            =3D ata_bmdma_setup,
-	.bmdma_start            =3D ata_bmdma_start,
-	.bmdma_stop		=3D ata_bmdma_stop,
+	.bmdma_start            =3D sil_bmdma_start,
+	.bmdma_stop		=3D sil_bmdma_stop,
 	.bmdma_status		=3D ata_bmdma_status,
 	.qc_prep		=3D ata_qc_prep,
 	.qc_issue		=3D ata_qc_issue_prot,
@@ -161,7 +164,7 @@
 	.scr_write		=3D sil_scr_write,
 	.port_start		=3D ata_port_start,
 	.port_stop		=3D ata_port_stop,
-	.host_stop		=3D ata_host_stop,
+	.host_stop		=3D sil_host_stop,
 };
=20
 static struct ata_port_info sil_port_info[] =3D {
@@ -204,6 +207,10 @@
 	/* ... port 3 */
 };
=20
+struct sil_host_priv {
+	u8			use_gpio;
+};
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
 MODULE_LICENSE("GPL");
@@ -217,6 +224,48 @@
 	return cache_line;
 }
=20
+static void sil_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct sil_host_priv* hpriv =3D qc->ap->host_set->private_data;
+	if (hpriv->use_gpio) {
+		void* mmio_base =3D qc->ap->host_set->mmio_base;
+		u32 gpio =3D readl(mmio_base + SIL_GPIO);
+
+		/* set the lower 8 bits to activate the LED */
+		gpio |=3D 0xff;
+		writel(gpio, mmio_base + SIL_GPIO);
+		readl(mmio_base + SIL_GPIO);	/* flush */
+	}
+
+	ata_bmdma_start(qc);
+}
+
+static void sil_bmdma_stop(struct ata_port *ap)
+{
+	struct sil_host_priv* hpriv =3D ap->host_set->private_data;
+
+	ata_bmdma_stop(ap);
+
+	if (hpriv->use_gpio) {
+		void* mmio_base =3D ap->host_set->mmio_base;
+		u32 gpio =3D readl(mmio_base + SIL_GPIO);
+
+		/* set bits [15:8] to disable the LED */
+		gpio |=3D 0xff00;
+		writel(gpio, mmio_base + SIL_GPIO);
+		readl(mmio_base + SIL_GPIO);	/* flush */
+	}
+}
+
+static void sil_host_stop (struct ata_host_set *host_set)
+{
+	if (host_set->private_data)
+		kfree(host_set->private_data);
+
+	ata_host_stop(host_set);
+}
+
+
 static void sil_post_set_mode (struct ata_port *ap)
 {
 	struct ata_host_set *host_set =3D ap->host_set;
@@ -353,6 +402,7 @@
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent =3D NULL;
+	struct sil_host_priv *hpriv =3D NULL;
 	unsigned long base;
 	void *mmio_base;
 	int rc;
@@ -391,6 +441,13 @@
 		goto err_out_regions;
 	}
=20
+	hpriv =3D kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv) {
+		rc =3D -ENOMEM;
+		goto err_out_free_ent;
+	}
+	memset(hpriv, 0, sizeof(*hpriv));
+
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
 	probe_ent->dev =3D pci_dev_to_dev(pdev);
@@ -408,10 +465,11 @@
 		            pci_resource_len(pdev, 5));
 	if (mmio_base =3D=3D NULL) {
 		rc =3D -ENOMEM;
-		goto err_out_free_ent;
+		goto err_out_free_hpriv;
 	}
=20
 	probe_ent->mmio_base =3D mmio_base;
+	probe_ent->private_data =3D hpriv;
=20
 	base =3D (unsigned long) mmio_base;
=20
@@ -456,6 +514,12 @@
 		irq_mask =3D SIL_MASK_2PORT;
 	}
=20
+	/* check for LED GPIO on 3112 parts */
+	tmp =3D readl(mmio_base + SIL_GPIO);
+	if ((ent->driver_data =3D=3D sil_3112) && ((tmp & 0xff) =3D=3D 0xff)) {
+		hpriv->use_gpio =3D 1;
+	}
+
 	/* make sure IDE0/1/2/3 interrupts are not masked */
 	tmp =3D readl(mmio_base + SIL_SYSCFG);
 	if (tmp & irq_mask) {
@@ -477,6 +541,8 @@
=20
 	return 0;
=20
+err_out_free_hpriv:
+	kfree(hpriv);
 err_out_free_ent:
 	kfree(probe_ent);
 err_out_regions:

--9jxsPFA5p3P2qPhR--

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCzTrFZwNxQsKC1UIRAsYbAKCCJxZhdUVZxpMVddgfktZ6FX9MVwCgjK60
s7VIfzNAgvGw/4dJrVV7D30=
=sp2M
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
