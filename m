Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWFMN6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWFMN6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 09:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFMN6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 09:58:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751130AbWFMN6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 09:58:05 -0400
Date: Tue, 13 Jun 2006 06:54:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Fox <drfickle@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060613065443.7f302319.akpm@osdl.org>
In-Reply-To: <pan.2006.06.12.22.09.47.855327@us.ibm.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	<pan.2006.06.12.22.09.47.855327@us.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 17:09:52 -0500
Steve Fox <drfickle@us.ibm.com> wrote:

> On Fri, 09 Jun 2006 21:40:24 -0700, Andrew Morton wrote:
> 
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> 
> Boot fails on a ppc64 machine.
> 
> [snip]
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD8111: IDE controller at PCI slot 0000:00:04.1
> AMD8111: chipset revision 3
> AMD8111: 0000:00:04.1 (rev 03) UDMA133 controller
> AMD8111: 100% native mode on irq 32
>     ide0: BM-DMA at 0x7c00-0x7c07<3>AMD8111: -- Error, unable to allocate DMA table.
>     ide1: BM-DMA at 0x7c08-0x7c0f<3>AMD8111: -- Error, unable to allocate DMA table.
> hda: TOSHIBA MK4019GAXB, ATA DISK drive
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc000000000301240
> cpu 0x1: Vector: 300 (Data Access) at [c000000002a13600]
>     pc: c000000000301240: .ide_config_drive_speed+0x228/0x624
>     lr: c0000000002f6c34: .amd_set_drive+0x7c/0x538
>     sp: c000000002a13880
>    msr: 8000000000009032
>    dar: 0
>  dsisr: 40000000
>   current = 0xc00000000ffd6820
>   paca    = 0xc000000000590080
>     pid   = 1, comm = idle

Thanks.   Reverting the below might fix it.


From: Sergei Shtylylov <sshtylyov@ru.mvista.com>

Release the DMA engine for the custom mapping IDE drivers also (for
example, siimage.c does allocate it in both I/O-mapped and custom-mapped
modes).  Remove useless code from the error path of
ide_allocate_dma_engine().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ide/ide-dma.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff -puN drivers/ide/ide-dma.c~ide-always-release-dma-engine drivers/ide/ide-dma.c
--- devel/drivers/ide/ide-dma.c~ide-always-release-dma-engine	2006-05-11 15:19:36.000000000 -0700
+++ devel-akpm/drivers/ide/ide-dma.c	2006-05-11 15:19:36.000000000 -0700
@@ -808,15 +808,14 @@ static int ide_release_iomio_dma(ide_hwi
 /*
  * Needed for allowing full modular support of ide-driver
  */
-int ide_release_dma (ide_hwif_t *hwif)
+int ide_release_dma(ide_hwif_t *hwif)
 {
+	ide_release_dma_engine(hwif);
+
 	if (hwif->mmio == 2)
 		return 1;
-	if (hwif->chipset == ide_etrax100)
-		return 1;
-
-	ide_release_dma_engine(hwif);
-	return ide_release_iomio_dma(hwif);
+	else
+		return ide_release_iomio_dma(hwif);
 }
 
 static int ide_allocate_dma_engine(ide_hwif_t *hwif)
@@ -828,10 +827,9 @@ static int ide_allocate_dma_engine(ide_h
 	if (hwif->dmatable_cpu)
 		return 0;
 
-	printk(KERN_ERR "%s: -- Error, unable to allocate%s DMA table(s).\n",
-			hwif->cds->name, !hwif->dmatable_cpu ? " CPU" : "");
+	printk(KERN_ERR "%s: -- Error, unable to allocate DMA table.\n",
+	       hwif->cds->name);
 
-	ide_release_dma_engine(hwif);
 	return 1;
 }
 
_

