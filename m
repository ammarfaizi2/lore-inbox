Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWIQHtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWIQHtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 03:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWIQHtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 03:49:33 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:15993 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750990AbWIQHtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 03:49:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=e7RLki6kjrHd4hIdg2cqeK5bZoWnnhf71c/RXn3XIb0JHLKbzHEeEXFnjcMIYU0IXeO/qB25ucke8Xkj2iiUSn60mKmfhEfyvgzN+L6gqza+n2N3p0hwOsx7Ylglqh4uUtbiARWboSq4cnusQ3JSn2/CgcecW8yXoKBgjmXXaxM=
Date: Sun, 17 Sep 2006 16:49:29 +0900
From: Tejun Heo <htejun@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20060917074929.GD25800@htj.dyndns.org>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916210857.GD30391@curie-int.orbis-terrarum.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 02:08:57PM -0700, Robin H. Johnson wrote:
> On Sat, Sep 16, 2006 at 01:38:12PM -0700, Robin H. Johnson wrote:
> > Ok, I picked up some SATA hard drives now, and the AHCI driver DOES see them.
> > However, it gets more interesting now.
> > 
> > The board has 4 SATA ports.
> > 
> > In the BIOS, all 4 of them work, and can start the bootloader from any
> > of them.
> > 
> > In the kernel, ONLY the first two ports work.
> > 
> > The only thing I see on this, is that in my original dmesg, when the DVD
> > drive was connected to the 4th port, and nothing connected on SATA1-3,
> > SControl was 300 for 1/2 and 0 for 3/4.
> 
> I recompiled libata and AHCI using the ATA_DEBUG and ATA_VERBOSE_DEBUG
> defines, and got an interesting trace.
> 
> In specific, look at port_idx 2/3, being all zeros in ahci_host_init.
> 
> I'm digging into it further now, but something makes me suspect that
> base addresses for ports 3/4 are wrong.
> 
> Full file at:
> http://orbis-terrarum.net/~robbat2/x86_64-mmconfig-failure/2.6.18-rc7-git1-libata-ahci-verbose-failure.dmesg

Can you please try the attached patch?

Thanks.

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 904c25f..dba99a5 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -53,6 +53,7 @@ #define DRV_VERSION	"2.0"
 
 enum {
 	AHCI_PCI_BAR		= 5,
+	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
@@ -186,9 +187,11 @@ struct ahci_host_priv {
 	unsigned long		flags;
 	u32			cap;	/* cache of HOST_CAP register */
 	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
+	int			port_tbl[AHCI_MAX_PORTS];
 };
 
 struct ahci_port_priv {
+	void __iomem		*mmio;
 	struct ahci_cmd_hdr	*cmd_slot;
 	dma_addr_t		cmd_slot_dma;
 	void			*cmd_tbl;
@@ -378,7 +381,8 @@ static int ahci_port_start(struct ata_po
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	struct ahci_port_priv *pp;
 	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = ahci_port_base(mmio,
+						 hpriv->port_tbl[ap->port_no]);
 	void *mem;
 	dma_addr_t mem_dma;
 	int rc;
@@ -394,6 +398,8 @@ static int ahci_port_start(struct ata_po
 		return rc;
 	}
 
+	pp->mmio = port_mmio;
+
 	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
 	if (!mem) {
 		ata_pad_free(ap, dev);
@@ -453,8 +459,7 @@ static void ahci_port_stop(struct ata_po
 {
 	struct device *dev = ap->host_set->dev;
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = pp->mmio;
 	u32 tmp;
 
 	tmp = readl(port_mmio + PORT_CMD);
@@ -510,8 +515,8 @@ static void ahci_scr_write (struct ata_p
 
 static int ahci_stop_engine(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 	int work;
 	u32 tmp;
 
@@ -535,8 +540,8 @@ static int ahci_stop_engine(struct ata_p
 
 static void ahci_start_engine(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 	u32 tmp;
 
 	tmp = readl(port_mmio + PORT_CMD);
@@ -547,7 +552,8 @@ static void ahci_start_engine(struct ata
 
 static unsigned int ahci_dev_classify(struct ata_port *ap)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 	struct ata_taskfile tf;
 	u32 tmp;
 
@@ -575,8 +581,9 @@ static void ahci_fill_cmd_slot(struct ah
 
 static int ahci_clo(struct ata_port *ap)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 	u32 tmp;
 
 	if (!(hpriv->cap & HOST_CAP_CLO))
@@ -608,8 +615,7 @@ static int ahci_prereset(struct ata_port
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = pp->mmio;
 	const u32 cmd_fis_len = 5; /* five dwords */
 	const char *reason = NULL;
 	struct ata_taskfile tf;
@@ -743,7 +749,8 @@ static int ahci_hardreset(struct ata_por
 
 static void ahci_postreset(struct ata_port *ap, unsigned int *class)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 	u32 new_tmp, tmp;
 
 	ata_std_postreset(ap, class);
@@ -904,9 +911,9 @@ static void ahci_error_intr(struct ata_p
 
 static void ahci_host_intr(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
 	struct ata_eh_info *ehi = &ap->eh_info;
+	void __iomem *port_mmio = pp->mmio;
 	u32 status, qc_active;
 	int rc;
 
@@ -978,7 +985,7 @@ static irqreturn_t ahci_interrupt(int ir
         for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap;
 
-		if (!(irq_stat & (1 << i)))
+		if (!(irq_stat & (1 << hpriv->port_tbl[i])))
 			continue;
 
 		ap = host_set->ports[i];
@@ -992,7 +999,7 @@ static irqreturn_t ahci_interrupt(int ir
 					"interrupt on disabled port %u\n", i);
 		}
 
-		irq_ack |= (1 << i);
+		irq_ack |= (1 << hpriv->port_tbl[i]);
 	}
 
 	if (irq_ack) {
@@ -1010,7 +1017,8 @@ static irqreturn_t ahci_interrupt(int ir
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
@@ -1022,8 +1030,8 @@ static unsigned int ahci_qc_issue(struct
 
 static void ahci_freeze(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 
 	/* turn IRQ off */
 	writel(0, port_mmio + PORT_IRQ_MASK);
@@ -1031,14 +1039,16 @@ static void ahci_freeze(struct ata_port 
 
 static void ahci_thaw(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = pp->mmio;
 	u32 tmp;
 
 	/* clear IRQ */
 	tmp = readl(port_mmio + PORT_IRQ_STAT);
 	writel(tmp, port_mmio + PORT_IRQ_STAT);
-	writel(1 << ap->id, mmio + HOST_IRQ_STAT);
+	writel(1 << hpriv->port_tbl[ap->id], mmio + HOST_IRQ_STAT);
 
 	/* turn IRQ back on */
 	writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
@@ -1090,7 +1100,7 @@ static int ahci_host_init(struct ata_pro
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->mmio_base;
 	u32 tmp, cap_save;
-	unsigned int i, j, using_dac;
+	unsigned int i, j, n_ports, using_dac;
 	int rc;
 	void __iomem *port_mmio;
 
@@ -1133,7 +1143,27 @@ static int ahci_host_init(struct ata_pro
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
-	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
+
+	/* determine number of ports and port table */
+	n_ports = 0;
+	for (i = 0; i < AHCI_MAX_PORTS; i++)
+		if (hpriv->port_map & (1 << i))
+			hpriv->port_tbl[n_ports++] = i;
+
+	i = (hpriv->cap & 0x1f) + 1;
+	if (n_ports > i) {
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "n_ports in PI (%d) > CAP.NP (%d), using %d\n",
+			   n_ports, i, i);
+		n_ports = i;
+	}
+
+	if (n_ports == 0) {
+		dev_printk(KERN_ERR, &pdev->dev, "0 port implemented\n");
+		return -EINVAL;
+	}
+
+	probe_ent->n_ports = n_ports;
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
 		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
@@ -1166,16 +1196,18 @@ static int ahci_host_init(struct ata_pro
 	}
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
+		int port_idx = hpriv->port_tbl[i];
+
 #if 0 /* BIOSen initialize this incorrectly */
 		if (!(hpriv->port_map & (1 << i)))
 			continue;
 #endif
 
-		port_mmio = ahci_port_base(mmio, i);
+		port_mmio = ahci_port_base(mmio, port_idx);
 		VPRINTK("mmio %p  port_mmio %p\n", mmio, port_mmio);
 
 		ahci_setup_port(&probe_ent->port[i],
-				(unsigned long) mmio, i);
+				(unsigned long) mmio, port_idx);
 
 		/* make sure port is not active */
 		tmp = readl(port_mmio + PORT_CMD);
@@ -1214,7 +1246,7 @@ #endif
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 
-		writel(1 << i, mmio + HOST_IRQ_STAT);
+		writel(1 << port_idx, mmio + HOST_IRQ_STAT);
 	}
 
 	tmp = readl(mmio + HOST_CTL);
diff --git a/include/linux/libata.h b/include/linux/libata.h


-- 
tejun
