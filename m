Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbULTKiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbULTKiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 05:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULTKiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 05:38:12 -0500
Received: from NK210-202-245-3.vdsl.static.apol.com.tw ([210.202.245.3]:46288
	"EHLO uli.com.tw") by vger.kernel.org with ESMTP id S261298AbULTKh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 05:37:58 -0500
Subject: [patch] scsi/ahci: Add support for ULi M5287 
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andrebalsa@mailingaddress.org, Clear.Zhang@uli.com.tw,
       Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw
X-Mailer: Lotus Notes R5.0 (Intl) 30 March 1999
Message-ID: <OFFB59EB4E.1CCBBD25-ON48256F70.003999B0@uli.com.tw>
From: Peer.Chen@uli.com.tw
Date: Mon, 20 Dec 2004 18:37:25 +0800
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on ulicnm01/ULI(Release 5.0.11  |July 24, 2002) at 2004-12-20
 18:37:27,
	Itemize by SMTP Server on ulim01/ULI(Release 5.0.11  |July 24, 2002) at
 2004/12/20 06:37:27 PM,
	Serialize by Router on ulim01/ULI(Release 5.0.11  |July 24, 2002) at 2004/12/20
 06:37:30 PM,
	Serialize complete at 2004/12/20 06:37:30 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Jeff

We add the support for ULi's AHCI controller M5287 in drivers/scsi/ahci.c,
This patch is applied to kernel 2.6.10-rc3. Please apply to new kernels.

Signed-off-by: Peer Chen <peer.chen@uli.com.tw>

Thanks

Best Regards
Peer

--- linux-2.6.10-rc3/drivers/scsi/ahci.c.orig   2004-12-11
03:14:17.170955840 +0800
+++ linux-2.6.10-rc3/drivers/scsi/ahci.c  2004-12-11 03:31:40.979272856
+0800
@@ -241,6 +241,8 @@ static struct pci_device_id ahci_pci_tbl
        board_ahci },
      { PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
        board_ahci },
+     { PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+       board_ahci },
      { }   /* terminate list */
 };

@@ -555,7 +557,6 @@ static void ahci_intr_error(struct ata_p
            writel(0x300, port_mmio + PORT_SCR_CTL);
            readl(port_mmio + PORT_SCR_CTL); /* flush */
      }
-
      /* re-start DMA */
      tmp = readl(port_mmio + PORT_CMD);
      tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
@@ -711,12 +712,29 @@ static int ahci_host_init(struct ata_pro
      unsigned int i, j, using_dac;
      int rc;
      void __iomem *port_mmio;
+     u8 rev_id;        //peer add for m5287 rev 02h

+     pci_read_config_byte(pdev, PCI_REVISION_ID, &rev_id);
      cap_save = readl(mmio + HOST_CAP);
      cap_save &= ( (1<<28) | (1<<17) );
      cap_save |= (1 << 27);

      /* global controller reset */
+//peer add for m5287 rev 02h
+     if(pdev->vendor==PCI_VENDOR_ID_AL && pdev->device==0x5287 && rev_id
==0x02)
+     {
+           tmp = readl(mmio + HOST_CTL);
+           writel(tmp & ~HOST_RESET, mmio + HOST_CTL);
+           readl(mmio + HOST_CTL); /* flush */
+           writel(tmp | HOST_RESET, mmio + HOST_CTL);
+           readl(mmio + HOST_CTL); /* flush */
+           writel(tmp & ~HOST_RESET, mmio + HOST_CTL);
+           readl(mmio + HOST_CTL); /* flush */
+
+     }
+//peer add end
+     else
+     {
      tmp = readl(mmio + HOST_CTL);
      if ((tmp & HOST_RESET) == 0) {
            writel(tmp | HOST_RESET, mmio + HOST_CTL);
@@ -735,6 +753,7 @@ static int ahci_host_init(struct ata_pro
            return -EIO;
      }

+     }
      writel(HOST_AHCI_EN, mmio + HOST_CTL);
      (void) readl(mmio + HOST_CTL);      /* flush */
      writel(cap_save, mmio + HOST_CAP);
@@ -796,6 +815,18 @@ static int ahci_host_init(struct ata_pro
            /* make sure port is not active */
            tmp = readl(port_mmio + PORT_CMD);
            VPRINTK("PORT_CMD 0x%x\n", tmp);
+//peer add for m5287 rev 02h
+           if(pdev->vendor==PCI_VENDOR_ID_AL && pdev->device==0x5287 &&
rev_id==0x02)
+           {
+                 //set start bit then issue comreset when initialize
+                 writel((tmp|PORT_CMD_START), port_mmio + PORT_CMD);
+                 writel(0x01, port_mmio + PORT_SCR_CTL);
+                 readl(port_mmio + PORT_SCR_CTL); /* flush */
+                 msleep(1);
+                 writel(0x0, port_mmio + PORT_SCR_CTL);
+                 readl(port_mmio + PORT_SCR_CTL); /* flush */
+           }
+//peer add end
            if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
                     PORT_CMD_FIS_RX | PORT_CMD_START)) {
                  tmp &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |


