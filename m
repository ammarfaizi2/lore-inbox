Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVCPEj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVCPEj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVCPEj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:39:28 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:7322 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262513AbVCPEis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:38:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rNa73/ki57JfDTGS+UWktI5CZBz/c68Denbx+Ouosk861Paxf4RiW1sXFvPeYU1TCSiMFT3iLxLBXxDsREVurl1Tp+eav/vKzSS6RY/QVMygp11B6z2HuIHJhX0HzXi1Kkdrr5ETe2tv93nA27TN879klDiPxxQXuGES6AzHAZ8=
Date: Wed, 16 Mar 2005 13:38:43 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fw: [PATCH ide-dev-2.6] sata_sil: Mod15Write workaround
Message-ID: <20050316043843.GA7388@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Oops, I forgot to cc lkml.  Please cc to linux-ide@vger.kernel.org
and jgarzik@pobox.com when replying.  Sorry.

----- Forwarded message from Tejun Heo <htejun@gmail.com> -----

From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, kanniball@zmail.pt,
	david@industrialstrengthsolutions.com
Subject: [PATCH ide-dev-2.6] sata_sil: Mod15Write workaround
X-UID: 125
X-Keywords:                                                                                                    

 Hello, Jeff.

 I've finished the sata_sil workaround.  It turned out that libata
already has all the hooks needed.  Although I had to twist things a
bit, the workaround is completely contained inside sata_sil driver.

 The new work-around doesn't limit max sectors 15.  All read requests
and write requests <= 15 sectors are processed as-is.  Write requests
larger than 15 sectors are iterated inside the sata_sil driver using
the ops->qc_prep and qc->complete_fn hooks.  The work-around doesn't
map/unmap on each iteration, it just manipulates mapped sg table and
thus the PRD entries.

 I've been running tests (repeated mke2fs and bonnie) several hours
from yesterday and it hasn't caused any problem yet.  Read performance
is now unhampered.  Write performance doesn't look very good, but it's
still much better.  I'm having difficult time remembering results but
on ext2, I think the write performance was better (compared to other
controllers, in ratio).  If you have a siimage controller and seagate
drives with this problem, please don't hesitate benchmarking.

 Also, I think it would be very helpful if we can find out what the
Windows driver is doing to work around Mod15Write.  As now we can
split write requests at will without affecting upper layers, we can
easily replicate how they perform writes if we only know it.  So,
here are things I think might help.

 * Benchmarking new workaround.  I think there should be tools better
   suited for this purpose than bonnie.
 * Benchmarking Mod15Write affected drives' read/write performance on
   affected siimage controllers and on other controllers on Windows.
 * Finding out how Windows splits write requests on affected drives.
   The best way would be Silicon Image coming out of the closet and
   tells us what they did with their Windows driver, but that doesn't
   seem likely.  So, if somebody has the right equipment and time,
   please come forward and shed some light here.

 These sil3112/3114 controllers are way too common and so are 7200.7
Seagate drives.  I was shopping for a sata add-in card last week and
couldn't find any product which matches the price point of these sil
controllers and ended up buying one, even knowing about the Mod15Write
problem.  So, I think it would be great if we can get this thing to
work as fast as on Windows.  So, some inputs, please.  :-)

 Bonnie benchmark results follow and then the patch.  Per-char results
on P3 800 are capped by cpu, ignore them.

 The first one is the original sata_sil driver with max_sectors==15
work-around.  The second one is with the new work-around, and the last
one is on another machine with via controller.  I got confused about
the mount point so I'm not sure if it was a 3120026 or 3200822, but
either way, you can see the write performance is way better.

libata-dev-2.6			P3 800, Sil3112 rev 02, ST3120026AS
===============================================================================
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
                 2G  9633  95 15101  24  6135  10  9975  87 14536  12 215.8   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   590  99 +++++ +++ 27052  88   604  99 +++++ +++  1949  95

libata-dev-2.6 w/ workaround	P3 800, Sil3112 rev 02, ST3120026AS
===============================================================================
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
                 2G 10606  95 23736  34 14695  19 12581  90 52786  31 218.5   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   599  99 +++++ +++ 30161  99   579  98 +++++ +++  1971  97

linux-2.6.11			A64 3000+, VT6420, ST3120026AS or ST3200822AS
===============================================================================

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
                 2G 46304  93 60133  25 20935   8 34522  60 54533   6 238.0   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  1541  99 +++++ +++ +++++ +++  1895  98 +++++ +++  8682  99


 Signed-off-by: Tejun Heo <htejun@gmail.com>


Index: libata-export/drivers/scsi/sata_sil.c
===================================================================
--- libata-export.orig/drivers/scsi/sata_sil.c	2005-03-16 12:22:13.000000000 +0900
+++ libata-export/drivers/scsi/sata_sil.c	2005-03-16 12:24:01.000000000 +0900
@@ -62,9 +62,12 @@ enum {
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
+static void sil_qc_prep (struct ata_queued_cmd *qc);
+static void sil_eng_timeout (struct ata_port *ap);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_host_stop (struct ata_host_set *host_set);
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -141,15 +144,16 @@ static struct ata_port_operations sil_op
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
+	.qc_prep		= sil_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.eng_timeout		= sil_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= sil_host_stop,
 };
 
 static struct ata_port_info sil_port_info[] = {
@@ -192,6 +196,36 @@ static const struct {
 	/* ... port 3 */
 };
 
+/*
+ * Context to loop over write requests > 15 sectors for Mod15Write bug.
+ *
+ * The following libata layer fields are saved at the beginning and
+ * mangled as necessary.
+ *
+ * qc->sg		: To fool ata_fill_sg().
+ * qc->n_elem		: ditto.
+ * qc->flags		: Except for the last iteration, ATA_QCFLAG_DMAMAP
+ *			  should be turned on entering ata_interrupt() such
+ *			  that ata_qc_complete() doesn't call ata_sg_clean()
+ *			  before sil_m15w_chunk_complete(), but the flags
+ *			  should be set for ata_qc_prep() to work.  This flag
+ *			  handling is the hackiest part of this workaround.
+ * qc->complete_fn	: Overrided to sil_m15w_chunk_complete().
+ */
+struct sil_m15w_cxt {
+	u64			next_block;
+	struct scatterlist *	next_sg;
+	unsigned int		left;
+	unsigned int		next_sg_ofs;
+	unsigned int		next_sg_len;
+	int			timedout;
+
+	struct scatterlist *	orig_sg;
+	unsigned int		orig_nelem;
+	unsigned long		orig_flags;
+	ata_qc_cb_t		orig_complete_fn;
+};
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
 MODULE_LICENSE("GPL");
@@ -225,6 +259,179 @@ static void sil_post_set_mode (struct at
 	readl(addr);	/* flush */
 }
 
+static inline u64 sil_m15w_read_tf_block (struct ata_taskfile *tf)
+{
+	u64 block = 0;
+
+	BUG_ON(!(tf->flags & ATA_TFLAG_LBA));
+
+	block |= (u64)tf->lbal;
+	block |= (u64)tf->lbam << 8;
+	block |= (u64)tf->lbah << 16;
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		block |= (u64)tf->hob_lbal << 24;
+		block |= (u64)tf->hob_lbam << 32;
+		block |= (u64)tf->hob_lbah << 40;
+	} else
+		block |= (u64)(tf->device & 0xf) << 24;
+
+	return block;
+}
+
+static inline void sil_m15w_rewrite_tf (struct ata_taskfile *tf,
+					u64 block, u16 nsect)
+{
+	BUG_ON(!(tf->flags & ATA_TFLAG_LBA));
+
+	tf->nsect = nsect & 0xff;
+	tf->lbal = block & 0xff;
+	tf->lbam = (block >> 8) & 0xff;
+	tf->lbah = (block >> 16) & 0xff;
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		tf->hob_nsect = (nsect >> 8) & 0xff;
+		tf->hob_lbal = (block >> 24) & 0xff;
+		tf->hob_lbam = (block >> 32) & 0xff;
+		tf->hob_lbah = (block >> 40) & 0xff;
+	} else {
+		tf->device &= ~0xf;
+		tf->device |= (block >> 24) & 0xf;
+	}
+}
+
+static void sil_m15w_next(struct ata_queued_cmd *qc)
+{
+	struct sil_m15w_cxt *cxt = qc->private_data;
+	struct scatterlist *sg;
+	unsigned int todo, res, nelem;
+
+	qc->sg = sg = cxt->next_sg;
+	sg_dma_address(sg) += cxt->next_sg_ofs;
+	sg_dma_len(sg) = cxt->next_sg_len;
+
+	res = todo = min_t(unsigned int, cxt->left, 15 << 9);
+
+	nelem = 0;
+	while (sg_dma_len(sg) <= res) {
+		res -= sg_dma_len(sg);
+		sg++;
+		nelem++;
+	}
+
+	if (todo < cxt->left) {
+		cxt->next_sg = sg;
+		cxt->next_sg_ofs = res;
+		cxt->next_sg_len = sg_dma_len(sg) - res;
+		if (res) {
+			nelem++;
+			sg_dma_len(sg) = res;
+		}
+	}
+
+	DPRINTK("block=%llu nelem=%u todo=%u left=%u\n",
+		cxt->next_block, nelem, todo, cxt->left);
+
+	qc->n_elem = nelem;
+	sil_m15w_rewrite_tf(&qc->tf, cxt->next_block, todo >> 9);
+	cxt->left -= todo;
+	cxt->next_block += todo >> 9;
+}
+
+static inline void sil_m15w_restore_qc (struct ata_queued_cmd *qc)
+{
+	struct sil_m15w_cxt *cxt = qc->private_data;
+
+	DPRINTK("ENTER\n");
+
+	qc->sg = cxt->orig_sg;
+	qc->n_elem = cxt->orig_nelem;
+	qc->flags |= cxt->orig_flags;
+	qc->complete_fn = cxt->orig_complete_fn;
+}
+
+static int sil_m15w_chunk_complete (struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct sil_m15w_cxt *cxt = qc->private_data;
+
+	DPRINTK("ENTER\n");
+
+	if (unlikely(cxt->timedout))
+		drv_stat |= ATA_BUSY;	/* Any better error status? */
+
+	/* Complete the command immediately on error */
+	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
+		sil_m15w_restore_qc(qc);
+		ata_qc_complete(qc, drv_stat);
+		return 1;
+	}
+
+	sil_m15w_next(qc);
+	
+	qc->flags |= cxt->orig_flags;
+	ata_qc_prep(qc);
+	qc->flags &= ~ATA_QCFLAG_DMAMAP;
+
+	/* On last iteration, restore fields such that normal
+	 * completion path is run */
+	if (!cxt->left)
+		sil_m15w_restore_qc(qc);
+	sil_ops.qc_issue(qc);
+	return 1;
+}
+
+static void sil_qc_prep (struct ata_queued_cmd *qc)
+{
+	struct sil_m15w_cxt *cxt = qc->private_data;
+
+	if (unlikely(cxt && qc->tf.flags & ATA_TFLAG_WRITE && qc->nsect > 15)) {
+		BUG_ON(cxt->left);
+		if (qc->tf.protocol == ATA_PROT_DMA) {
+			/* Okay, begin mod15write workaround */
+			cxt->left = qc->nsect << 9;
+			cxt->next_block = sil_m15w_read_tf_block(&qc->tf);
+			cxt->next_sg = qc->sg;
+			cxt->next_sg_ofs = 0;
+			cxt->next_sg_len = sg_dma_len(qc->sg);
+			cxt->timedout = 0;
+
+			/* Save fields we're gonna mess with.  Read comments
+			 * above struct sil_m15w_cxt for more info. */
+			cxt->orig_sg = qc->sg;
+			cxt->orig_nelem = qc->n_elem;
+			cxt->orig_flags = qc->flags & ATA_QCFLAG_DMAMAP;
+			cxt->orig_complete_fn = qc->complete_fn;
+			qc->complete_fn = sil_m15w_chunk_complete;
+
+			DPRINTK("MOD15WRITE, block=%llu nsect=%u\n",
+				cxt->next_block, qc->nsect);
+			sil_m15w_next(qc);
+
+			ata_qc_prep(qc);
+			qc->flags &= ~ATA_QCFLAG_DMAMAP;
+			return;
+		} else
+			printk(KERN_WARNING "ata%u(%u): write request > 15 "
+			       "issued using non-DMA protocol.  Drive may "
+			       "lock up.\n", qc->ap->id, qc->dev->devno);
+	}
+
+	ata_qc_prep(qc);
+}
+
+static void sil_eng_timeout (struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+
+	if (qc && qc->private_data) {
+		struct sil_m15w_cxt *cxt = qc->private_data;
+		if (cxt->left)
+			cxt->timedout = 1;
+	}
+
+	ata_eng_timeout(ap);
+}
+
 static inline unsigned long sil_scr_addr(struct ata_port *ap, unsigned int sc_reg)
 {
 	unsigned long offset = ap->ioaddr.scr_addr;
@@ -259,6 +466,12 @@ static void sil_scr_write (struct ata_po
 		writel(val, mmio);
 }
 
+static void sil_host_stop (struct ata_host_set *host_set)
+{
+	/* Free mod15write context array. */
+	kfree(host_set->private_data);
+}
+
 /**
  *	sil_dev_config - Apply device/host-specific errata fixups
  *	@ap: Port containing device to be examined
@@ -269,17 +482,12 @@ static void sil_scr_write (struct ata_po
  *	We apply two errata fixups which are specific to Silicon Image,
  *	a Seagate and a Maxtor fixup.
  *
- *	For certain Seagate devices, we must limit the maximum sectors
- *	to under 8K.
+ *	For certain Seagate devices, we cannot issue write requests
+ *	larger than 15 sectors.
  *
  *	For certain Maxtor devices, we must not program the drive
  *	beyond udma5.
  *
- *	Both fixups are unfairly pessimistic.  As soon as I get more
- *	information on these errata, I will create a more exhaustive
- *	list, and apply the fixups to only the specific
- *	devices/hosts/firmwares that need it.
- *
  *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
  *	The Maxtor quirk is in the blacklist, but I'm keeping the original
  *	pessimistic fix for the following reasons...
@@ -287,6 +495,15 @@ static void sil_scr_write (struct ata_po
  *	Windows	driver, maybe only one is affected.  More info would be greatly
  *	appreciated.
  *	- But then again UDMA5 is hardly anything to complain about
+ *
+ *	20050316 Tejun Heo - Proper Mod15Write workaround implemented.
+ *	sata_sil doesn't report affected Seagate drives as having max
+ *	sectors of 15 anymore, but handle write requests larger than
+ *	15 sectors by looping over it inside this driver proper.  This
+ *	is messy but it's better to isolate this kind of peculiar bug
+ *	handling inside individual drivers than tainting libata layer.
+ *	This workaround results in unhampered read performance and
+ *	much better write performance.
  */
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
@@ -294,6 +511,7 @@ static void sil_dev_config(struct ata_po
 	unsigned char model_num[40];
 	const char *s;
 	unsigned int len;
+	int i;
 
 	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
@@ -311,15 +529,23 @@ static void sil_dev_config(struct ata_po
 			break;
 		}
 	
-	/* limit requests to 15 sectors */
+	/* Activate mod15write quirk workaround */
 	if (quirks & SIL_QUIRK_MOD15WRITE) {
+		struct sil_m15w_cxt *cxt;
+
 		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
 		       ap->id, dev->devno);
-		ap->host->max_sectors = 15;
-		ap->host->hostt->max_sectors = 15;
-		dev->flags |= ATA_DFLAG_LOCK_SECTORS;
+
+		cxt = ap->host_set->private_data;
+		cxt += ap->port_no * ATA_MAX_QUEUE;
+		for (i = 0; i < ATA_MAX_QUEUE; i++)
+			ap->qcmd[i].private_data = cxt++;
+
 		return;
 	}
+	/* Clear qcmd->private_data if mod15write quirk isn't present */
+	for (i = 0; i < ATA_MAX_QUEUE; i++)
+		ap->qcmd[i].private_data = NULL;
 
 	/* limit to udma5 */
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
@@ -333,7 +559,8 @@ static void sil_dev_config(struct ata_po
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct ata_probe_ent *probe_ent;
+	struct sil_m15w_cxt *m15w_cxt;
 	unsigned long base;
 	void *mmio_base;
 	int rc;
@@ -365,11 +592,17 @@ static int sil_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
+	rc = -ENOMEM;
+
+	tmp = sizeof(m15w_cxt[0]) * ATA_MAX_PORTS * ATA_MAX_QUEUE;
+	m15w_cxt = kmalloc(tmp, GFP_KERNEL);
+	if (m15w_cxt == NULL)
 		goto err_out_regions;
-	}
+	memset(m15w_cxt, 0, tmp);
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		goto err_out_free_m15w;
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
@@ -383,6 +616,7 @@ static int sil_init_one (struct pci_dev 
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->host_flags = sil_port_info[ent->driver_data].host_flags;
+	probe_ent->private_data = m15w_cxt;
 
 	mmio_base = ioremap(pci_resource_start(pdev, 5),
 		            pci_resource_len(pdev, 5));
@@ -440,6 +674,8 @@ static int sil_init_one (struct pci_dev 
 
 err_out_free_ent:
 	kfree(probe_ent);
+err_out_free_m15w:
+	kfree(m15w_cxt);
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:

----- End forwarded message -----

-- 
tejun

