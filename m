Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270519AbTGSIbY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270521AbTGSIbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 04:31:24 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:1801 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270519AbTGSIap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 04:30:45 -0400
Date: Sat, 19 Jul 2003 09:45:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Aniket Malatpure <aniket@sgi.com>
Cc: marcelo@conectiva.com.br, alan@redhat.com, wildos@sgi.com,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] (2.4.22-pre6 BK) new & changed (IDE) driver: SGI IOC4]
Message-ID: <20030719094540.A22258@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Aniket Malatpure <aniket@sgi.com>, marcelo@conectiva.com.br,
	alan@redhat.com, wildos@sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <20030718020431.GA19018@taniwha.engr.sgi.com> <3F187E67.227651F@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F187E67.227651F@sgi.com>; from aniket@sgi.com on Fri, Jul 18, 2003 at 04:10:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 04:10:31PM -0700, Aniket Malatpure wrote:
> Hi
> 
> This patch  (against the 2.4 BK tree as of yesterday evening) adds
> support for SGI IOC4 IDE driver as found in SN2/Altix systems
>  (http://sgi.com/altix for more details).
> 
> No generic/non-sn2 code paths should be affected by this.

A few comments:

+	    dep_tristate '    SGI IOC4 chipset support' CONFIG_BLK_DEV_SGIIOC4 $CONFIG_BLK_DEV_IDEDMA_PCI

	This probably wants a depency on CONFIG_IA64_SGI_SN2?

+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/hdreg.h>
+#include <linux/init.h>
+#include <asm/io.h>

	<asm/*> includes after <linux/*> ones please.

+#ifdef CONFIG_PROC_FS
+static u8 sgiioc4_proc = 0;
+#endif /* CONFIG_PROC_FS */

	As all procfs code is properly stubbed out you can probably
	nuke the ifdef.

+
+static int n_sgiioc4_devs = 0;

	Also both of these don't need zero initialization, Linux takes
	care of that for you.

+#define SGIIOC4_HD_SUPPORT 0

	Please make this either a config とption or nuke it.

+
+static inline void
+xide_delay(long ticks)

	Documentation/CodingStyle says

static inline void xide_delay(long ticks)

	The same is true for many other function in this file.

+		printk(KERN_INFO "%s: %s Bus-Master DMA disabled \n", hwif->name, name);

	Please linewrap after 80 chars.

+static unsigned int __init
+pci_init_sgiioc4(struct pci_dev *dev, const char *name)
+{
+	extern pciio_endian_t snia_pciio_endian_set(struct pci_dev *pci_dev,
+						    pciio_endian_t device_end,
+						    pciio_endian_t desired_end);

	Shouldn't this be in a header?  

+#if defined(CONFIG_IA64_SGI_SN2) || defined(CONFIG_IA64_GENERIC)
+	/* Enable Byte Swapping in the PIC */
+	snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE, PCIDMA_ENDIAN_BIG);
+#endif

	Currentl 2.4 mainline doesn't seem to include SN2 in IA64_GENERIC
	so compilation will fail for this case.

+static void __init
+ide_init_sgiioc4(ide_hwif_t * hwif)
+{
+	hwif->autodma = 1;
+	hwif->index = 0;	/* Channel 0 */
+	hwif->channel = 0;
+	hwif->atapi_dma = 1;
+	hwif->ultra_mask = 0x0;	/* Disable Ultra DMA */

	Use a memset here so you only have to initialize the non-NULL fields?

