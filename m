Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUJ3XaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUJ3XaV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUJ3X3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:29:52 -0400
Received: from zwaan.xs4all.nl ([213.84.190.116]:38461 "EHLO zwaan.xs4all.nl")
	by vger.kernel.org with ESMTP id S261377AbUJ3X3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:29:17 -0400
Message-ID: <418423C8.309@xs4all.nl>
Date: Sun, 31 Oct 2004 01:29:12 +0200
From: Matthijs Melchior <mmelchior@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en, nl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.10-rc1] ahci: Intel ICH6R (925X) corrections
References: <417A7E0D.6060704@xs4all.nl>
In-Reply-To: <417A7E0D.6060704@xs4all.nl>
Content-Type: multipart/mixed;
 boundary="------------080908090008050501030509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080908090008050501030509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch makes the following changes to drivers/scsi/ahci.c

 - Add definition for SActive register
 - Add most interrupt sources to default interrupt mask
 - Write low 32 bits of FIS address to PxFB, where they belong
 - Set command active bit in PxSACT before setting command issue bit in PxCI
 - Announce Sub Class Code in driver info message [IDE, SATA or RAID]

-- 
 Signed-off-by: Matthijs Melchior <mmelchior@xs4all.nl>



--------------080908090008050501030509
Content-Type: text/plain;
 name="ahci-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ahci-patch"

--- a/drivers/scsi/ahci.c	2004-10-23 01:37:22.000000000 +0200
+++ b/drivers/scsi/ahci.c	2004-10-31 00:20:13.000000000 +0200
@@ -90,6 +90,7 @@
 	PORT_SCR_STAT		= 0x28, /* SATA phy register: SStatus */
 	PORT_SCR_CTL		= 0x2c, /* SATA phy register: SControl */
 	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
+        PORT_SCR_ACT            = 0x34, /* SATA phy register: SActive */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
 	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
@@ -116,6 +117,9 @@
 				  PORT_IRQ_HBUS_DATA_ERR |
 				  PORT_IRQ_IF_ERR,
 	DEF_PORT_IRQ		= PORT_IRQ_FATAL | PORT_IRQ_PHYRDY |
+                                  PORT_IRQ_CONNECT | PORT_IRQ_SG_DONE |
+                                  PORT_IRQ_UNK_FIS | PORT_IRQ_SDB_FIS |
+                                  PORT_IRQ_DMAS_FIS | PORT_IRQ_PIOS_FIS |
 				  PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
@@ -329,8 +333,8 @@
 
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
-	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
-	readl(port_mmio + PORT_LST_ADDR); /* flush */
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
+	readl(port_mmio + PORT_FIS_ADDR); /* flush */
 
 	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
 	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
@@ -673,10 +677,13 @@
 static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void *mmio = (void *) ap->ioaddr.cmd_addr;
+	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
-	writel(1, mmio + PORT_CMD_ISSUE);
-	readl(mmio + PORT_CMD_ISSUE);	/* flush */
+	writel(1, port_mmio + PORT_SCR_ACT);
+	readl(port_mmio + PORT_SCR_ACT);	/* flush */
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
 }
@@ -859,6 +866,8 @@
 	void *mmio = probe_ent->mmio_base;
 	u32 vers, cap, impl, speed;
 	const char *speed_s;
+        u16 cc;
+        const char *scc_s;
 
 	vers = readl(mmio + HOST_VERSION);
 	cap = hpriv->cap;
@@ -872,8 +881,18 @@
 	else
 		speed_s = "?";
 
+        pci_read_config_word(pdev, 0x0a, &cc);
+        if (cc == 0x0101)
+                scc_s = "IDE";
+        else if (cc == 0x0106)
+                scc_s = "SATA";
+        else if (cc == 0x0104)
+                scc_s = "RAID";
+        else
+                scc_s = "unknown";
+
 	printk(KERN_INFO DRV_NAME "(%s) AHCI %02x%02x.%02x%02x "
-		"%u slots %u ports %s Gbps 0x%x impl\n"
+		"%u slots %u ports %s Gbps 0x%x impl %s mode\n"
 	       	,
 	       	pci_name(pdev),
 
@@ -885,7 +904,8 @@
 		((cap >> 8) & 0x1f) + 1,
 		(cap & 0x1f) + 1,
 		speed_s,
-		impl);
+		impl,
+                scc_s);
 
 	printk(KERN_INFO DRV_NAME "(%s) flags: "
 	       	"%s%s%s%s%s%s"

--------------080908090008050501030509--
