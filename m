Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030882AbWKULpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030882AbWKULpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030892AbWKULpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:45:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5294 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030882AbWKULpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:45:08 -0500
Date: Tue, 21 Nov 2006 12:32:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>,
       Andi Kleen <ak@suse.de>, John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, jim.kardach@intel.com
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
Message-ID: <20061121113252.GB1900@elf.ucw.cz>
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de> <455893E5.4010001@garzik.org> <4558B232.8080600@rtr.ca> <45628358.8080504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45628358.8080504@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>How does it shorten its life?
> >>
> >>Parks your hard drive heads many thousands of times more often than it 
> >>does without the aggressive PM features.
> >
> >Spinning-down would definitely shorten the drive lifespan.  Does it do 
> >that?
> >
> >Parking heads is more like just doing some extra (long) seeks.
> >Is this documented somewhere as being a life-shortening action?
> 
> I wrote this in the other thread but writing here too for documentation 
> purpose.
> 
> * HL-DT-ST DVD-RAM GSA-H30N locks up completely on slumber.  Physical 
> power removal and reapply is the only to recover it.
> 
> * Some WD raptors spin down (yeap, that's right, it spins down) on slumber.
> 
> Wonderful world of ATA.  :-P

Do you have some patches to play with? I tried this to get links down,
and it did not save much (if any) power.

(Last hunk is actually tiny cleanup...)
								Pavel

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index cef2e70..13ef1c5 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -50,6 +50,7 @@ #include <asm/io.h>
 #define DRV_NAME	"ahci"
 #define DRV_VERSION	"2.0"
 
+#define POWER_SAVE
 
 enum {
 	AHCI_PCI_BAR		= 5,
@@ -148,6 +149,8 @@ enum {
 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
+	PORT_CMD_ALPE		= (1 << 27), /* Aggressive Link Power Management Enable */
+	PORT_CMD_ASP		= (1 << 26), /* Aggressive entrance to Slumber or Partial power management states */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
@@ -407,6 +410,9 @@ static void ahci_start_engine(void __iom
 	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
+#ifdef POWER_SAVE_V
+	printk("Starting engine\n");
+#endif
 }
 
 static int ahci_stop_engine(void __iomem *port_mmio)
@@ -422,6 +428,9 @@ static int ahci_stop_engine(void __iomem
 	/* setting HBA to idle */
 	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
+#ifdef POWER_SAVE_V
+	printk("Stopping engine\n");
+#endif
 
 	/* wait for engine to stop. This could be as long as 500 msec */
 	tmp = ata_wait_register(port_mmio + PORT_CMD,
@@ -486,7 +495,7 @@ static void ahci_power_up(void __iomem *
 	}
 
 	/* wake up link */
-	writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
+	writel(cmd | PORT_CMD_ICC_ACTIVE | PORT_CMD_ALPE | PORT_CMD_ASP, port_mmio + PORT_CMD);
 }
 
 static void ahci_power_down(void __iomem *port_mmio, u32 cap)
@@ -917,6 +926,14 @@ static void ahci_qc_prep(struct ata_queu
 	const u32 cmd_fis_len = 5; /* five dwords */
 	unsigned int n_elem;
 
+#ifdef POWER_SAVE
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = ap->host->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+
+	ahci_port_resume(ap);
+#endif
+
 	/*
 	 * Fill in command table information.  First, the header,
 	 * a SATA Register - Host to Device command FIS.
@@ -1029,8 +1046,17 @@ static void ahci_host_intr(struct ata_po
 		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
 
 	rc = ata_qc_complete_multiple(ap, qc_active, NULL);
-	if (rc > 0)
+	if (rc > 0) {
+#ifdef POWER_SAVE
+		struct ahci_host_priv *hpriv = ap->host->private_data;
+		void __iomem *mmio = ap->host->mmio_base;
+		void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+
+		hpriv->cap &= ~HOST_CAP_SSC;
+		ahci_port_suspend(ap, PMSG_SUSPEND);
+#endif
 		return;
+	}
 	if (rc < 0) {
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;
@@ -1367,7 +1393,7 @@ static int ahci_host_init(struct ata_pro
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
-	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
+	probe_ent->n_ports = 1; /* (hpriv->cap & 0x1f) + 1; */
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
 		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
@@ -1543,12 +1569,11 @@ static int ahci_init_one (struct pci_dev
 	}
 	base = (unsigned long) mmio_base;
 
-	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
 		rc = -ENOMEM;
 		goto err_out_iounmap;
 	}
-	memset(hpriv, 0, sizeof(*hpriv));
 
 	probe_ent->sht		= ahci_port_info[board_idx].sht;
 	probe_ent->port_flags	= ahci_port_info[board_idx].flags;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
