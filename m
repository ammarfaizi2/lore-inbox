Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752276AbWCFIgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbWCFIgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbWCFIgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:36:54 -0500
Received: from mx1.suse.de ([195.135.220.2]:60834 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752263AbWCFIgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:36:53 -0500
Message-ID: <440BF49F.7020809@suse.de>
Date: Mon, 06 Mar 2006 09:36:47 +0100
From: Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jens Axboe <axboe@suse.de>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Fixup ahci suspend / resume
References: <44045FB1.5040408@suse.de>	<440468DB.5060605@pobox.com>	<20060228151928.GC24981@suse.de>	<44046AC2.1060002@pobox.com>	<20060228152847.GE24981@suse.de>	<44046DC3.4060508@pobox.com>	<440472F6.6090905@suse.de>	<20060228172542.GF24981@suse.de> <20060303233716.67ffaff6.rdunlap@xenotime.net>
In-Reply-To: <20060303233716.67ffaff6.rdunlap@xenotime.net>
Content-Type: multipart/mixed;
 boundary="------------010407040807000103060009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010407040807000103060009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Randy.Dunlap wrote:
> On Tue, 28 Feb 2006 18:25:43 +0100 Jens Axboe wrote:
>=20
>> On Tue, Feb 28 2006, Hannes Reinecke wrote:
>>> Jeff Garzik wrote:
>>>> Jens Axboe wrote:
>>>>> I'm sure Hannes will regenerate against upstream as well if necessa=
ry,
>>>>> however that depends on when this should be applied.
>>>> It's far too late and too intrusive for 2.6.16-rc.
>>>>
>>>> It's #upstream or <null>.
>>>>
>>> Calm down. Of course I will regenerate is against #upstream.
>>> In fact, I've done so initially but wasn't sure what the status of
>>> libata-dev is. So I've diffed it against linux-git instead.
>>>
>>> Updated patch to follow.
>> Thanks Hannes. I wasn't so much worried about it going directly in (I
>> have no problem waiting), just that there seemed to be some disagreeme=
nt
>> on where suspend is at and what we can "support".
>=20
> Hi Hannes,
>=20
> Did you ever send the updated patch?  I need it to use with the
> rest of the ata-acpi objects patchset for #upstream (actually for -mm).=

>=20
Oh, sorry. I got tangled up with other issues (namely ACPI integration
for IDE drives :-).
Patch against libata-dev is attached.

Please apply.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

--------------010407040807000103060009
Content-Type: text/plain;
 name="libata-ahci-update"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="libata-ahci-update"

ahci: Fixup ahci suspend / resume

The current ahci driver has the problem that it doesn't resume properly.
Or rather, that resuming is unstable.
Reason being that AHCI has 4 registers containing the DMA address it
should write things to. Of course there is no guarantee that Linux has
assigned the same address to the DMA area across reboots.
So we should better re-initialize those registers after resume.

The patch also improves the port_start / port_stop routines to be more
closely modelled after the spec. This also avoids a nasty msleep(500)
during initialisation.

And as we now have the individual routines split off we can as well
use them during startup and not rely on any hardcoded values here.

Signed-off-by: Hannes Reinecke <hare@suse.de>

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1c2ab3d..e0dc933 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -30,6 +30,12 @@
  * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
  * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
  *
+ * TODO:
+ * - Error handling; some routines might fail (eg port_suspend / _resume=
)
+ *   upon which a port reset should be done
+ * - Proper handling of additional features: cold-presence detection,
+ *   staggered spin-up, power modes. Currently we're calling those comma=
nds
+ *   as we pleas.
  */
=20
 #include <linux/kernel.h>
@@ -44,6 +50,7 @@
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 #include <asm/io.h>
=20
@@ -194,11 +201,21 @@ static int ahci_probe_reset(struct ata_p
 static void ahci_irq_clear(struct ata_port *ap);
 static void ahci_eng_timeout(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
+static int ahci_port_resume(struct ata_port *ap);
+static int ahci_port_suspend(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
+static int ahci_start_engine(void __iomem *port_mmio);
+static int ahci_stop_engine(void __iomem *port_mmio);
+static void ahci_start_fis_rx(void __iomem *port_mmio,=20
+			      struct ahci_port_priv *pp,
+			      struct ahci_host_priv *hpriv);
+static int ahci_stop_fis_rx(void __iomem *port_mmio);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_=
cmd *qc);
+static int ahci_scsi_device_suspend(struct scsi_device *sdev);
+static int ahci_scsi_device_resume(struct scsi_device *sdev);
 static void ahci_remove_one (struct pci_dev *pdev);
=20
 static struct scsi_host_template ahci_sht =3D {
@@ -218,6 +235,8 @@ static struct scsi_host_template ahci_sh
 	.dma_boundary		=3D AHCI_DMA_BOUNDARY,
 	.slave_configure	=3D ata_scsi_slave_config,
 	.bios_param		=3D ata_std_bios_param,
+	.resume			=3D ahci_scsi_device_resume,
+	.suspend		=3D ahci_scsi_device_suspend,
 };
=20
 static const struct ata_port_operations ahci_ops =3D {
@@ -302,6 +321,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		=3D ahci_pci_tbl,
 	.probe			=3D ahci_init_one,
 	.remove			=3D ahci_remove_one,
+	.suspend		=3D ata_pci_device_suspend,
+	.resume			=3D ata_pci_device_resume,      =20
 };
=20
=20
@@ -375,42 +396,24 @@ static int ahci_port_start(struct ata_po
=20
 	ap->private_data =3D pp;
=20
-	if (hpriv->cap & HOST_CAP_64)
-		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
-	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
-	readl(port_mmio + PORT_LST_ADDR); /* flush */
-
-	if (hpriv->cap & HOST_CAP_64)
-		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
-	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
-	readl(port_mmio + PORT_FIS_ADDR); /* flush */
-
-	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
-	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
-	       PORT_CMD_START, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
-	return 0;
+	/*
+	 * Driver is setup, now initialize the HBA
+	 */
+	ahci_start_fis_rx(port_mmio, pp, hpriv);
+=09
+	rc =3D ahci_start_engine(port_mmio);
+	if (rc)
+		printk(KERN_WARNING "ata%u: could not start DMA engine\n",=20
+		       ap->id);
+	return rc;
 }
=20
-
 static void ahci_port_stop(struct ata_port *ap)
 {
 	struct device *dev =3D ap->host_set->dev;
 	struct ahci_port_priv *pp =3D ap->private_data;
-	void __iomem *mmio =3D ap->host_set->mmio_base;
-	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
-	u32 tmp;
=20
-	tmp =3D readl(port_mmio + PORT_CMD);
-	tmp &=3D ~(PORT_CMD_START | PORT_CMD_FIS_RX);
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
-	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
-	 * this is slightly incorrect.
-	 */
-	msleep(500);
+	ahci_port_suspend(ap);
=20
 	ap->private_data =3D NULL;
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
@@ -419,6 +422,45 @@ static void ahci_port_stop(struct ata_po
 	kfree(pp);
 }
=20
+static int ahci_port_resume(struct ata_port *ap)
+{
+	void __iomem *mmio =3D ap->host_set->mmio_base;
+	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv =3D ap->host_set->private_data;
+	struct ahci_port_priv *pp =3D ap->private_data;
+
+	/*
+	 * Enable FIS reception
+	 */
+	ahci_start_fis_rx(port_mmio, pp, hpriv);
+
+	/*
+	 * Enable DMA
+	 */
+	return ahci_start_engine(port_mmio);
+}
+
+static int ahci_port_suspend(struct ata_port *ap)
+{
+	void __iomem *mmio =3D ap->host_set->mmio_base;
+	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
+	int rc;
+
+	/*
+	 * Disable DMA
+	 */
+	rc =3D ahci_stop_engine(port_mmio);
+	if (rc) {
+		printk(KERN_WARNING "ata%u: DMA engine busy\n", ap->id);
+		return rc;
+	}
+
+	/*
+	 * Disable FIS reception
+	 */
+	return ahci_stop_fis_rx(port_mmio);
+}
+
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
@@ -453,19 +495,23 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
=20
-static int ahci_stop_engine(struct ata_port *ap)
+static int ahci_stop_engine(void __iomem *port_mmio)
 {
-	void __iomem *mmio =3D ap->host_set->mmio_base;
-	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
 	int work;
 	u32 tmp;
=20
 	tmp =3D readl(port_mmio + PORT_CMD);
+	/* Check if the HBA is idle */
+	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) =3D=3D 0)
+		return 0;
+
+	/* Setting HBA to idle */
 	tmp &=3D ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
=20
-	/* wait for engine to stop.  TODO: this could be
-	 * as long as 500 msec
+	/*=20
+	 * wait for engine to stop.
+	 * This could be as long as 500 msec
 	 */
 	work =3D 1000;
 	while (work-- > 0) {
@@ -478,16 +524,120 @@ static int ahci_stop_engine(struct ata_p
 	return -EIO;
 }
=20
-static void ahci_start_engine(struct ata_port *ap)
+static int ahci_start_engine(void __iomem *port_mmio)
 {
-	void __iomem *mmio =3D ap->host_set->mmio_base;
-	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
+	int work =3D 1000;
=20
+	/*
+	 * Get current status
+	 */
 	tmp =3D readl(port_mmio + PORT_CMD);
+
+	/*
+	 * AHCI rev 1.1 section 10.3.1:
+	 * Software shall not set PxCMD.ST to =E2=80=981=E2=80=99 until it veri=
fies
+	 * that PxCMD.CR is =E2=80=980=E2=80=99 and has set PxCMD.FRE to =E2=80=
=981=E2=80=99.
+	 */
+	if ((tmp & PORT_CMD_FIS_RX) =3D=3D 0) {
+		return -EIO;
+	}
+
+	/*=20
+	 * wait for DMA engine to become idle.
+	 */
+	if (tmp & PORT_CMD_LIST_ON) {
+		while (work-- > 0) {
+			tmp =3D readl(port_mmio + PORT_CMD);
+			if ((tmp & PORT_CMD_LIST_ON) =3D=3D 0)
+				break;
+			udelay(10);
+		}
+	}
+
+	if (!work) {
+		/*
+		 * We need to do a port reset / HBA reset here.
+		 */
+		return -EIO;
+	}
+
+	/*
+	 * Start DMA
+	 */
 	tmp |=3D PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
+
+	return 0;
+}
+
+static int ahci_stop_fis_rx(void __iomem *port_mmio)
+{
+	u32 tmp;
+	int work =3D 1000;
+
+	/*
+	 * Get current status
+	 */
+	tmp =3D readl(port_mmio + PORT_CMD);
+
+	/*
+	 * Disable FIS reception
+	 */
+	if (tmp & PORT_CMD_FIS_RX) {
+		tmp &=3D ~(PORT_CMD_FIS_RX);
+		writel(tmp, port_mmio + PORT_CMD);
+		tmp =3D readl(port_mmio + PORT_CMD); /* flush */
+	}
+
+	/*
+	 * Wait for HBA to become idle.
+	 * This could be as long as 500 msec
+	 */
+	if (tmp & PORT_CMD_FIS_ON) {
+		work =3D 1000;
+		while (work-- > 0) {
+			tmp =3D readl(port_mmio + PORT_CMD);
+			if ((tmp & PORT_CMD_FIS_ON) =3D=3D 0)
+				return 0;
+			udelay(10);
+		}
+	}
+=09
+	return -EIO;
+}
+
+static void ahci_start_fis_rx(void __iomem *port_mmio,=20
+			      struct ahci_port_priv *pp,
+			      struct ahci_host_priv *hpriv)
+{
+	/*
+	 * Enable FIS reception
+	 */
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
+	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
+	readl(port_mmio + PORT_LST_ADDR); /* flush */
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
+	readl(port_mmio + PORT_FIS_ADDR); /* flush */
+
+	/*
+	 * This is wrong. We should only activate
+	 * FIX_RX here; everything else should be handled
+	 * separately.
+	 * Some bits might not even be settable here
+	 * as they depend on the respective feature to be
+	 * implemented (Staggered Spin-up,=20
+	 * Cold-presence detection etc.)
+	 */
+	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
+	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP,
+	       port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
 }
=20
 static unsigned int ahci_dev_classify(struct ata_port *ap)
@@ -515,13 +665,16 @@ static void ahci_fill_cmd_slot(struct ah
=20
 static int ahci_hardreset(struct ata_port *ap, int verbose, unsigned int=
 *class)
 {
+	void __iomem *mmio =3D ap->host_set->mmio_base;
+	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
 	int rc;
=20
 	DPRINTK("ENTER\n");
=20
-	ahci_stop_engine(ap);
+	ahci_stop_engine(port_mmio);
 	rc =3D sata_std_hardreset(ap, verbose, class);
-	ahci_start_engine(ap);
+	if (!rc)
+		rc =3D ahci_start_engine(port_mmio);
=20
 	if (rc =3D=3D 0)
 		*class =3D ahci_dev_classify(ap);
@@ -641,6 +794,7 @@ static void ahci_restart_port(struct ata
 	void __iomem *mmio =3D ap->host_set->mmio_base;
 	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
+	int rc;
=20
 	if ((ap->device[0].class !=3D ATA_DEV_ATAPI) ||
 	    ((irq_stat & PORT_IRQ_TF_ERR) =3D=3D 0))
@@ -656,7 +810,7 @@ static void ahci_restart_port(struct ata
 			readl(port_mmio + PORT_SCR_ERR));
=20
 	/* stop DMA */
-	ahci_stop_engine(ap);
+	rc =3D ahci_stop_engine(port_mmio);
=20
 	/* clear SATA phy error, if any */
 	tmp =3D readl(port_mmio + PORT_SCR_ERR);
@@ -666,7 +820,7 @@ static void ahci_restart_port(struct ata
 	 * if so, issue COMRESET
 	 */
 	tmp =3D readl(port_mmio + PORT_TFDATA);
-	if (tmp & (ATA_BUSY | ATA_DRQ)) {
+	if (rc || (tmp & (ATA_BUSY | ATA_DRQ))) {
 		writel(0x301, port_mmio + PORT_SCR_CTL);
 		readl(port_mmio + PORT_SCR_CTL); /* flush */
 		udelay(10);
@@ -675,7 +829,7 @@ static void ahci_restart_port(struct ata
 	}
=20
 	/* re-start DMA */
-	ahci_start_engine(ap);
+	rc =3D ahci_start_engine(port_mmio);
 }
=20
 static void ahci_eng_timeout(struct ata_port *ap)
@@ -823,6 +977,31 @@ static unsigned int ahci_qc_issue(struct
 	return 0;
 }
=20
+int ahci_scsi_device_suspend(struct scsi_device *sdev)
+{
+	struct ata_port *ap =3D (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev =3D &ap->device[sdev->id];
+	int rc;
+
+	rc =3D ata_device_suspend(ap, dev);
+
+	if (!rc) {
+		rc =3D ahci_port_suspend(ap);
+	}
+
+	return rc;
+}
+
+int ahci_scsi_device_resume(struct scsi_device *sdev)
+{
+	struct ata_port *ap =3D (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev =3D &ap->device[sdev->id];
+
+	ahci_port_resume(ap);
+
+	return ata_device_resume(ap, dev);
+}
+
 static void ahci_setup_port(struct ata_ioports *port, unsigned long base=
,
 			    unsigned int port_idx)
 {
@@ -930,23 +1109,18 @@ static int ahci_host_init(struct ata_pro
 				(unsigned long) mmio, i);
=20
 		/* make sure port is not active */
-		tmp =3D readl(port_mmio + PORT_CMD);
-		VPRINTK("PORT_CMD 0x%x\n", tmp);
-		if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
-			   PORT_CMD_FIS_RX | PORT_CMD_START)) {
-			tmp &=3D ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
-				 PORT_CMD_FIS_RX | PORT_CMD_START);
-			writel(tmp, port_mmio + PORT_CMD);
-			readl(port_mmio + PORT_CMD); /* flush */
-
-			/* spec says 500 msecs for each bit, so
-			 * this is slightly incorrect.
-			 */
-			msleep(500);
-		}
+		ahci_stop_engine(port_mmio);
+		ahci_stop_fis_rx(port_mmio);
+
+		/*
+		 * TODO: port / HBA reset if the above fails
+		 */
=20
 		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
=20
+		/*
+		 * Wait for communications link to establish
+		 */
 		j =3D 0;
 		while (j < 100) {
 			msleep(10);

--------------010407040807000103060009--
