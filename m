Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWB1Ofc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWB1Ofc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWB1Ofc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:35:32 -0500
Received: from ns2.suse.de ([195.135.220.15]:27361 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750757AbWB1Ofb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:35:31 -0500
Message-ID: <44045FB1.5040408@suse.de>
Date: Tue, 28 Feb 2006 15:35:29 +0100
From: Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] Fixup ahci suspend / resume
Content-Type: multipart/mixed;
 boundary="------------090306060601030200050602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306060601030200050602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

the current ahci doesn't handle suspend / resume cycles too well.
On certain machines the disk just locks up and refuses to work after a
resume.

This is due to a initialisation error after resume; ahci has for
registers containing DMA addresses (which are obviously allocated by the
kernel). Of course there is no guarantee that these addresses are
unchanged across reboots. So ahci loads the suspended image, and after
the suspended image is started the driver is presented with different
DMA addresses, whereas the chip still uses the original ones.

This patch rearranges the suspend / resume code to properly initialise
those registers after a resume. It also contains some initialisation
fixes to make the driver behave more spec-compliant.

Comments etc. are welcome.

Oh, patch is against linux-2.6 git.
Please apply.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

--------------090306060601030200050602
Content-Type: text/plain;
 name="ahci-suspend"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ahci-suspend"

From: Hannes Reinecke <hare@suse.de>
Subject: AHCI suspend / resume fixes.

The current ahci driver has the problem that it doesn't resume properly.
Or rather, that resuming is unstable.
Reason being is that AHCI has 4 registers containing the DMA address it
should write things to. Of course there is no guarantee that Linux has
assigned the same address to the DMA area across reboots.
So we should better re-initialize those registers after resume.

The patch also improves the port_start / port_stop routines to be more
closely modelled after the spec. This also avoids a nasty msleep(500)
during initialisation.

Signed-off-by: Hannes Reinecke <hare@suse.de>

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a800fb5..cb2c9e5 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -44,6 +44,7 @@
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 #include <asm/io.h>
=20
@@ -186,15 +187,21 @@ static void ahci_scr_write (struct ata_p
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_=
id *ent);
 static int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct p=
t_regs *regs);
+static void ahci_start_engine(struct ata_port *ap);
+static int ahci_stop_engine(struct ata_port *ap);
 static void ahci_phy_reset(struct ata_port *ap);
 static void ahci_irq_clear(struct ata_port *ap);
 static void ahci_eng_timeout(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
+static void ahci_port_suspend(struct ata_port *ap);
+static void ahci_port_resume(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
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
@@ -214,6 +221,8 @@ static struct scsi_host_template ahci_sh
 	.dma_boundary		=3D AHCI_DMA_BOUNDARY,
 	.slave_configure	=3D ata_scsi_slave_config,
 	.bios_param		=3D ata_std_bios_param,
+	.resume			=3D ahci_scsi_device_resume,
+	.suspend		=3D ahci_scsi_device_suspend,
 };
=20
 static const struct ata_port_operations ahci_ops =3D {
@@ -299,6 +308,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		=3D ahci_pci_tbl,
 	.probe			=3D ahci_init_one,
 	.remove			=3D ahci_remove_one,
+	.suspend		=3D ata_pci_device_suspend,
+	.resume			=3D ata_pci_device_resume,
 };
=20
=20
@@ -315,10 +326,7 @@ static inline void __iomem *ahci_port_ba
 static int ahci_port_start(struct ata_port *ap)
 {
 	struct device *dev =3D ap->host_set->dev;
-	struct ahci_host_priv *hpriv =3D ap->host_set->private_data;
 	struct ahci_port_priv *pp;
-	void __iomem *mmio =3D ap->host_set->mmio_base;
-	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
 	void *mem;
 	dma_addr_t mem_dma;
 	int rc;
@@ -372,6 +380,22 @@ static int ahci_port_start(struct ata_po
=20
 	ap->private_data =3D pp;
=20
+	/*
+	 * Internal structures are initialized,
+	 * we can now do a simple resume()
+	 */
+	ahci_port_resume(ap);
+
+	return 0;
+}
+
+static void ahci_port_resume(struct ata_port *ap)
+{
+	void *mmio =3D ap->host_set->mmio_base;
+	void *port_mmio =3D ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv =3D ap->host_set->private_data;
+	struct ahci_port_priv *pp =3D ap->private_data;
+
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
 	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
@@ -383,31 +407,49 @@ static int ahci_port_start(struct ata_po
 	readl(port_mmio + PORT_FIS_ADDR); /* flush */
=20
 	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
-	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
-	       PORT_CMD_START, port_mmio + PORT_CMD);
+	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP,
+	       port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
=20
-	return 0;
+	ahci_start_engine(ap);
 }
=20
-
-static void ahci_port_stop(struct ata_port *ap)
+static void ahci_port_suspend(struct ata_port *ap)
 {
-	struct device *dev =3D ap->host_set->dev;
-	struct ahci_port_priv *pp =3D ap->private_data;
-	void __iomem *mmio =3D ap->host_set->mmio_base;
-	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
+	void *mmio =3D ap->host_set->mmio_base;
+	void *port_mmio =3D ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
+	int work;
=20
+	ahci_stop_engine(ap);
+
+	/*
+	 * Disable FIS reception
+	 */
 	tmp =3D readl(port_mmio + PORT_CMD);
-	tmp &=3D ~(PORT_CMD_START | PORT_CMD_FIS_RX);
+	tmp &=3D ~(PORT_CMD_FIS_RX);
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
=20
-	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
-	 * this is slightly incorrect.
+	/*
+	 * Wait for HBA to acknowledge.
+	 * This could be as long as 500 msec
 	 */
-	msleep(500);
+	work =3D 1000;
+	while (work-- > 0) {
+		tmp =3D readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_FIS_ON) =3D=3D 0)
+			break;
+		udelay(10);
+	}
+}
+
+static void ahci_port_stop(struct ata_port *ap)
+{
+	struct device *dev =3D ap->host_set->dev;
+	struct ahci_port_priv *pp =3D ap->private_data;
+
+	ahci_port_suspend(ap);
=20
 	ap->private_data =3D NULL;
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
@@ -457,11 +499,19 @@ static void ahci_phy_reset(struct ata_po
 	struct ata_device *dev =3D &ap->device[0];
 	u32 new_tmp, tmp;
=20
+	ahci_stop_engine(ap);
+
 	__sata_phy_reset(ap);
=20
+	/* clear SATA phy error, if any */
+	tmp =3D readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
=20
+	ahci_start_engine(ap);
+
 	tmp =3D readl(port_mmio + PORT_SIG);
 	tf.lbah		=3D (tmp >> 24)	& 0xff;
 	tf.lbam		=3D (tmp >> 16)	& 0xff;
@@ -571,6 +621,65 @@ static void ahci_qc_prep(struct ata_queu
 	pp->cmd_slot[0].opts |=3D cpu_to_le32(n_elem << 16);
 }
=20
+static void ahci_start_engine(struct ata_port *ap)
+{
+	void __iomem *mmio =3D ap->host_set->mmio_base;
+	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+	int work;
+
+	tmp =3D readl(port_mmio + PORT_CMD);
+	/*
+	 * AHCI rev 1.1 section 10.3.1:
+	 * Software shall not set PxCMD.ST to =E2=80=981=E2=80=99 until it veri=
fies
+	 * that PxCMD.CR is =E2=80=980=E2=80=99 and has set PxCMD.FRE to =E2=80=
=981=E2=80=99.
+	 */
+	if ((tmp & PORT_CMD_FIS_RX) =3D=3D 0)
+		printk(KERN_WARNING "ata%d: dma not running\n",ap->id);
+	/*=20
+	 * wait for engine to become idle.
+	 */
+	work =3D 1000;
+	while (work-- > 0) {
+		tmp =3D readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) =3D=3D 0)
+			break;
+		udelay(10);
+	}
+=09
+	/*
+	 * Start DMA
+	 */
+	tmp |=3D PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+}
+
+static int ahci_stop_engine(struct ata_port *ap)
+{
+	void __iomem *mmio =3D ap->host_set->mmio_base;
+	void __iomem *port_mmio =3D ahci_port_base(mmio, ap->port_no);
+	int work;
+	u32 tmp;
+
+	tmp =3D readl(port_mmio + PORT_CMD);
+	tmp &=3D ~PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/*=20
+	 * wait for engine to become idle
+	 */
+	work =3D 1000;
+	while (work-- > 0) {
+		tmp =3D readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) =3D=3D 0)
+			return 0;
+		udelay(10);
+	}
+
+	return -EIO;
+}
+
 static void ahci_restart_port(struct ata_port *ap, u32 irq_stat)
 {
 	void __iomem *mmio =3D ap->host_set->mmio_base;
@@ -592,20 +701,7 @@ static void ahci_restart_port(struct ata
 			readl(port_mmio + PORT_SCR_ERR));
=20
 	/* stop DMA */
-	tmp =3D readl(port_mmio + PORT_CMD);
-	tmp &=3D ~PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-
-	/* wait for engine to stop.  TODO: this could be
-	 * as long as 500 msec
-	 */
-	work =3D 1000;
-	while (work-- > 0) {
-		tmp =3D readl(port_mmio + PORT_CMD);
-		if ((tmp & PORT_CMD_LIST_ON) =3D=3D 0)
-			break;
-		udelay(10);
-	}
+	ahci_stop_engine(ap);
=20
 	/* clear SATA phy error, if any */
 	tmp =3D readl(port_mmio + PORT_SCR_ERR);
@@ -624,10 +720,7 @@ static void ahci_restart_port(struct ata
 	}
=20
 	/* re-start DMA */
-	tmp =3D readl(port_mmio + PORT_CMD);
-	tmp |=3D PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
+	ahci_start_engine(ap);
 }
=20
 static void ahci_eng_timeout(struct ata_port *ap)
@@ -787,6 +880,30 @@ static int ahci_qc_issue(struct ata_queu
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
+	if (!rc)
+		ahci_port_suspend(ap);
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
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c

--------------090306060601030200050602--
