Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263724AbTJCOmg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 10:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTJCOmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 10:42:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39131 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263724AbTJCOmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 10:42:33 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Aniket Malatpure <aniket@sgi.com>
Subject: Re: Patch to add support for SGI's IOC4 chipset
Date: Fri, 3 Oct 2003 16:45:57 +0200
User-Agent: KMail/1.5.4
Cc: akmp@osdl.org, gwh@sgi.com, jeremy@sgi.com, jbarnes@sgi.com,
       aniket_m@hotmail.com, linux-kernel@vger.kernel.org
References: <3F7CB4A9.3C1F1237@sgi.com>
In-Reply-To: <3F7CB4A9.3C1F1237@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200310031645.57341.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 of October 2003 01:28, Aniket Malatpure wrote:
> Hi
>
> This patch adds support for the ATAPI part of SGI's IOC4 chipset.
> A version of this patch for the 2.4 series has been accepted and is present
> in the tree. This patch is a slight modification of the earlier patch for
> the 2.4 series.
>
> Please merge this patch if there are no outstanding issues.

Please follow Documentation/CodingStyle and respect 80-columns limit.

+/**
+ * 	"Copied from drivers/ide/ide-dma.c"
+ *	sgiioc4_ide_build_sglist - map IDE scatter gather for DMA I/O
+ *	@hwif: the interface to build the DMA table for
+ *	@rq: the request holding the sg list
+ *	@ddir: data direction
+ *
+ *	Perform the PCI mapping magic neccessary to access the source
+ *	or target buffers of a request via PCI DMA. The lower layers
+ *	of the kernel provide the neccessary cache management so that
+ *	we can operate in a portable fashion.
+ *
+ *	This code is identical to ide_build_sglist in ide-dma.c
+ *	however that it not exported and even if it were would create
+ *	dependancy problems for modular drivers.
+ */

+/**
+ * 	Copied from drivers/ide/ide-dma.c
+ *	sgiioc4_ide_raw_build_sglist	-	map IDE scatter gather for DMA
+ *	@hwif: the interface to build the DMA table for
+ *	@rq: the request holding the sg list
+ *
+ *	Perform the PCI mapping magic neccessary to access the source or
+ *	target buffers of a taskfile request via PCI DMA. The lower layers
+ *	of the  kernel provide the neccessary cache management so that we can
+ *	operate in a portable fashion
+ *
+ *	This code is identical to ide_raw_build_sglist in ide-dma.c
+ *	however that it not exported and even if it were would create
+ *	dependancy problems for modular drivers.
+ */

What problems?
BTW during coping tabs were replaced by spaces in these functions.

+static int
+sgiioc4_get_info(char *buffer, char **addr, off_t offset, int count)
+{
+	char *p = buffer;
+	unsigned int class_rev;
+	int i = 0;
+
+	while (i < n_sgiioc4_devs) {
+		pci_read_config_dword(sgiioc4_devs[i], PCI_CLASS_REVISION,
+				      &class_rev);
+		class_rev &= 0xff;
+
+		if (sgiioc4_devs[i]->device == PCI_DEVICE_ID_SGI_IOC4) {
+			p += sprintf(p, "\n	SGI IOC4 Chipset rev %d. ", class_rev);
+			p += sprintf(p, "\n	Chipset has 1 IDE channel and supports 2 devices on that channel.");
+			p += sprintf(p, "\n	Chipset supports DMA in MultiMode-2 data transfer protocol.\n");
+			/* Do we need more info. here? */
+		}
+		i++;
+	}
+
+	return p - buffer;
+}

Do you really need /proc/ide/sgiioc4?
You can print revision number during init.

>From sgiioc4.h:

+static void sgiioc4_init_hwif_ports(hw_regs_t * hw, unsigned long data_port,
+				    unsigned long ctrl_port, unsigned long irq_port);
+static void sgiioc4_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d);
+static void sgiioc4_resetproc(ide_drive_t * drive);
+static void sgiioc4_maskproc(ide_drive_t * drive, int mask);
+static void sgiioc4_configure_for_dma(int dma_direction, ide_drive_t * drive);
+static void __init ide_init_sgiioc4(ide_hwif_t * hwif);
+static void __init ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dma_base);
+static int sgiioc4_checkirq(ide_hwif_t * hwif);
+static int sgiioc4_clearirq(ide_drive_t * drive);
+static int sgiioc4_get_info(char *buffer, char **addr, off_t offset, int count);
+static int sgiioc4_ide_dma_read(ide_drive_t * drive);
+static int sgiioc4_ide_dma_write(ide_drive_t * drive);
+static int sgiioc4_ide_dma_begin(ide_drive_t * drive);
+static int sgiioc4_ide_dma_end(ide_drive_t * drive);
+static int sgiioc4_ide_dma_check(ide_drive_t * drive);
+static int sgiioc4_ide_dma_on(ide_drive_t * drive);
+static int sgiioc4_ide_dma_off(ide_drive_t * drive);
+static int sgiioc4_ide_dma_off_quietly(ide_drive_t * drive);
+static int sgiioc4_ide_dma_test_irq(ide_drive_t * drive);
+static int sgiioc4_ide_dma_host_on(ide_drive_t * drive);
+static int sgiioc4_ide_dma_host_off(ide_drive_t * drive);
+static int sgiioc4_ide_dma_count(ide_drive_t * drive);
+static int sgiioc4_ide_dma_verbose(ide_drive_t * drive);
+static int sgiioc4_ide_dma_lostirq(ide_drive_t * drive);
+static int sgiioc4_ide_dma_timeout(ide_drive_t * drive);
+static int sgiioc4_ide_build_sglist(ide_drive_t *drive, struct request *rq);
+static int sgiioc4_ide_raw_build_sglist(ide_drive_t *drive, struct request *rq);
+
+static u8 sgiioc4_INB(unsigned long port);
+static inline void xide_delay(long ticks);
+extern int (*sgiioc4_display_info) (char *, char **, off_t, int);	/* ide-proc.c */
+static unsigned int sgiioc4_build_dma_table(ide_drive_t * drive, struct request *rq,
+					    int ddir);
+static unsigned int __init pci_init_sgiioc4(struct pci_dev *dev,ide_pci_device_t *d);

Most of this declarations are not needed as sgiioc4.h is only included from shiioc4.c.

Otherwise it looks okay.

Thanks.
--bartlomiej

