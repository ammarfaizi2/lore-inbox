Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755371AbWKMWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbWKMWRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbWKMWRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:17:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1951 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1755371AbWKMWRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:17:04 -0500
Date: Mon, 13 Nov 2006 22:56:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com, ak@suse.de
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
Message-ID: <20061113215614.GA1639@elf.ucw.cz>
References: <20061009215221.GC30702@elf.ucw.cz> <87ods6loe8.fsf-genuine-vii@john.fremlin.org> <20061025070920.GG5851@elf.ucw.cz> <87y7r3xlif.fsf-genuine-vii@john.fremlin.org> <20061026204655.GA1767@elf.ucw.cz> <87slgv6ccz.fsf-genuine-vii@john.fremlin.org> <20061112183614.GA5081@ucw.cz> <87hcx3adcd.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45589008.1080001@garzik.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >--- a/drivers/ata/ahci.c
> >+++ b/drivers/ata/ahci.c
> >@@ -148,6 +148,8 @@ enum {
> > 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
> > 
> > 	/* PORT_CMD bits */
> >+	PORT_CMD_ALPE		= (1 << 27), /* Aggressive Link Power 
> >Management Enable */
> >+	PORT_CMD_ASP		= (1 << 26), /* Aggressive entrance to 
> >Slumber or Partial power management states */
> > 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
> > 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running 
> > 	*/
> > 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
> >@@ -486,7 +488,7 @@ static void ahci_power_up(void __iomem *
> > 	}
> > 
> > 	/* wake up link */
> >-	writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
> >+	writel(cmd | PORT_CMD_ICC_ACTIVE | PORT_CMD_ALPE | PORT_CMD_ASP, 
> >port_mmio + PORT_CMD);
> 
> 
> Therein lies a key problem.  Turning on all of AHCI's aggressive power 
> management features DOES save a lot of power.  But at the same time, it 
> shortens the life of your hard drive, particularly hard drives that are 
> really PATA, but have a PATA<->SATA bridge glued on the drive to enable 
> connection to SATA controllers.

Well, it would be useful to do on notebooks. I believe notebook hard
drives are okay with this kind of use... Heck, I've seen notebooks
with 5 seconds of spindown time.

Anyway, I tried stopping the DMA engine when no requests are
processed. I expected to see that 1W power saving, but nothing.

ahci_stop_engine does ...

        tmp = readl(port_mmio + PORT_CMD);

        /* check if the HBA is idle */
        if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
                return 0;

        /* setting HBA to idle */
        tmp &= ~PORT_CMD_START;
        writel(tmp, port_mmio + PORT_CMD);
        printk("Stopping engine\n");

... is PORT_CMD_START that bit that was expected to save 1W?

								Pavel

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index cef2e70..060d4c9 100644
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
@@ -422,6 +425,7 @@ static int ahci_stop_engine(void __iomem
 	/* setting HBA to idle */
 	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
+	printk("Stopping engine\n");
 
 	/* wait for engine to stop. This could be as long as 500 msec */
 	tmp = ata_wait_register(port_mmio + PORT_CMD,
@@ -486,7 +490,7 @@ static void ahci_power_up(void __iomem *
 	}
 
 	/* wake up link */
-	writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
+	writel(cmd | PORT_CMD_ICC_ACTIVE | PORT_CMD_ALPE | PORT_CMD_ASP, port_mmio + PORT_CMD);
 }
 
 static void ahci_power_down(void __iomem *port_mmio, u32 cap)
@@ -917,6 +921,13 @@ static void ahci_qc_prep(struct ata_queu
 	const u32 cmd_fis_len = 5; /* five dwords */
 	unsigned int n_elem;
 
+#ifdef POWER_SAVE
+	void __iomem *mmio = ap->host->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+
+	ahci_start_engine(port_mmio);
+#endif
+
 	/*
 	 * Fill in command table information.  First, the header,
 	 * a SATA Register - Host to Device command FIS.
@@ -1029,8 +1040,15 @@ static void ahci_host_intr(struct ata_po
 		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
 
 	rc = ata_qc_complete_multiple(ap, qc_active, NULL);
-	if (rc > 0)
+	if (rc > 0) {
+#ifdef POWER_SAVE
+		void __iomem *mmio = ap->host->mmio_base;
+		void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+
+		ahci_stop_engine(port_mmio);
+#endif
 		return;
+	}
 	if (rc < 0) {
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
