Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWIULzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWIULzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 07:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWIULzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 07:55:37 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:16587 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1751137AbWIULzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 07:55:35 -0400
Date: Thu, 21 Sep 2006 13:55:33 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
Message-ID: <20060921115533.GA26960@xi.wantstofly.org>
References: <44FC0779.9030405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FC0779.9030405@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 07:01:13AM -0400, Jeff Garzik wrote:

> * ARM, PPC and other non-x86 platform drivers are severely 
> under-represented.

Allessandro Zummo sent the patch below to me a while ago, for support
for the PATA controller (PIO only, although the hardware can also do
UDMA) in the cirrus logic ep93xx ARM cpu.

The driver has bitrotted somewhat, and apart from that it never honored
PIO timings properly and has some other issues, but Allessandro seems to
have disappeared off the face of the planet.  I'd still like to see
support for this go in at some point, so I'll have a try at cleaning it
up and updating it (and converting it to a platform driver, etc.)


cheers,
Lennert


Index: linux-2.6.16-rc5/drivers/scsi/Kconfig
===================================================================
--- linux-2.6.16-rc5.orig/drivers/scsi/Kconfig
+++ linux-2.6.16-rc5/drivers/scsi/Kconfig
@@ -912,6 +912,10 @@ config SCSI_PATA_TS7200
 	tristate "TS7200 Compact Flash support"
 	depends on MACH_TS72XX
 
+config SCSI_PATA_EP93XX
+	tristate "Cirrus Logic EP93XX PATA support"
+	depends on ARCH_EP93XX
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API
Index: linux-2.6.16-rc5/drivers/scsi/Makefile
===================================================================
--- linux-2.6.16-rc5.orig/drivers/scsi/Makefile
+++ linux-2.6.16-rc5/drivers/scsi/Makefile
@@ -175,6 +175,7 @@ obj-$(CONFIG_SCSI_PATA_WINBOND)	+= libat
 obj-$(CONFIG_SCSI_ATA_GENERIC)	+= libata.o ata_generic.o
 obj-$(CONFIG_SCSI_PATA_LEGACY)	+= libata.o pata_legacy.o
 obj-$(CONFIG_SCSI_PATA_TS7200)	+= libata.o pata_ts7200.o
+obj-$(CONFIG_SCSI_PATA_EP93XX)		+= libata.o pata_ep93xx.o
 
 obj-$(CONFIG_ARM)		+= arm/
 
Index: linux-2.6.16-rc5/drivers/scsi/pata_ep93xx.c
===================================================================
--- /dev/null
+++ linux-2.6.16-rc5/drivers/scsi/pata_ep93xx.c
@@ -0,0 +1,375 @@
+/*
+ * EP93XX PATA controller driver.
+ * Copyright (c) 2006 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * An ATA driver to handle the embedded IDE controller
+ * of the Cirrus Logic EP93XX.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+#include <scsi/scsi_host.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME	"pata_ep93xx"
+#define DRV_VERSION	"0.1"
+
+struct ata_host_set *ep93xx_host;
+
+static inline void ep93xx_toggle_wr(register u32 ctrl)
+{
+	ctrl &= ~(EP93XX_IDE_CTRL_DIOWn);
+	__raw_writel(ctrl, EP93XX_IDE_CTRL);
+
+	ctrl |= EP93XX_IDE_CTRL_DIOWn;
+	__raw_writel(ctrl, EP93XX_IDE_CTRL);
+}
+
+static inline void ep93xx_toggle_rd(register u32 ctrl)
+{
+	ctrl &= ~(EP93XX_IDE_CTRL_DIORn);
+	__raw_writel(ctrl, EP93XX_IDE_CTRL);
+
+	ctrl |= EP93XX_IDE_CTRL_DIORn;
+	__raw_writel(ctrl, EP93XX_IDE_CTRL);
+}
+
+#define ep93xx_write_addr(ctrl,addr) { \
+	ctrl = (ctrl & ~(EP93XX_IDE_CTRL_DA_CS_MASK)) | EP93XX_IDE_CTRL_DA_CS(addr); \
+	__raw_writel(ctrl, EP93XX_IDE_CTRL); }
+
+static inline void ep93xx_writew(register u16 value, volatile void __iomem *p)
+{
+	register u32 ctrl = __raw_readl(EP93XX_IDE_CTRL);
+
+	ep93xx_write_addr(ctrl, (unsigned long) p);
+	__raw_writel(value, EP93XX_IDE_DATAOUT);
+	ep93xx_toggle_wr(ctrl);
+}
+
+#define ep93xx_writeb(value,addr) ep93xx_writew(value,addr)
+
+static inline unsigned short ep93xx_readw(volatile void __iomem *p)
+{
+	register u32 ctrl = __raw_readl(EP93XX_IDE_CTRL);
+
+	ep93xx_write_addr(ctrl, (unsigned long) p);
+	ep93xx_toggle_rd(ctrl);
+	return __raw_readl(EP93XX_IDE_DATAIN);
+}
+
+#define ep93xx_readb(addr) ep93xx_readw(addr)
+
+static unsigned int ep93xx_mode_filter(const struct ata_port *ap,
+	struct ata_device *adev, unsigned int mask, int shift)
+{
+	if (shift != ATA_SHIFT_PIO)
+		return 0;
+	return mask;
+}
+
+static void ep93xx_set_mode(struct ata_port *ap)
+{
+	int i;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		if (ata_dev_present(dev)) {
+			dev->pio_mode = XFER_PIO_0;
+			dev->xfer_mode = XFER_PIO_0;
+			dev->xfer_shift = ATA_SHIFT_PIO;
+			dev->flags |= ATA_DFLAG_PIO;
+		}
+	}
+}
+
+static void ep93xx_phy_reset(struct ata_port *ap)
+{
+	ap->cbl = ATA_CBL_PATA40;
+	ata_port_probe(ap);
+	ata_bus_reset(ap);
+}
+
+static void ep93xx_irq_clear(struct ata_port *ap)
+{
+}
+
+static void ep93xx_irq_on(struct ata_port *ap)
+{
+}
+
+static void ep93xx_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+
+	if (tf->ctl != ap->last_ctl) {
+		ep93xx_writeb(tf->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		ep93xx_writeb(tf->hob_feature, (void __iomem *) ioaddr->feature_addr);
+		ep93xx_writeb(tf->hob_nsect, (void __iomem *) ioaddr->nsect_addr);
+		ep93xx_writeb(tf->hob_lbal, (void __iomem *) ioaddr->lbal_addr);
+		ep93xx_writeb(tf->hob_lbam, (void __iomem *) ioaddr->lbam_addr);
+		ep93xx_writeb(tf->hob_lbah, (void __iomem *) ioaddr->lbah_addr);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+
+	if (is_addr) {
+		ep93xx_writeb(tf->feature, (void __iomem *) ioaddr->feature_addr);
+		ep93xx_writeb(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
+		ep93xx_writeb(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
+		ep93xx_writeb(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
+		ep93xx_writeb(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
+		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		ep93xx_writeb(tf->device, (void __iomem *) ioaddr->device_addr);
+		VPRINTK("device 0x%X\n", tf->device);
+	}
+
+	ata_wait_idle(ap);
+}
+
+static void ep93xx_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	tf->command = ap->ops->check_status(ap);
+	tf->feature = ep93xx_readb((void __iomem *)ioaddr->error_addr);
+	tf->nsect = ep93xx_readb((void __iomem *)ioaddr->nsect_addr);
+	tf->lbal = ep93xx_readb((void __iomem *)ioaddr->lbal_addr);
+	tf->lbam = ep93xx_readb((void __iomem *)ioaddr->lbam_addr);
+	tf->lbah = ep93xx_readb((void __iomem *)ioaddr->lbah_addr);
+	tf->device = ep93xx_readb((void __iomem *)ioaddr->device_addr);
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		ep93xx_writeb(tf->ctl | ATA_HOB, (void __iomem *) ap->ioaddr.ctl_addr);
+		tf->hob_feature = ep93xx_readb((void __iomem *)ioaddr->error_addr);
+		tf->hob_nsect = ep93xx_readb((void __iomem *)ioaddr->nsect_addr);
+		tf->hob_lbal = ep93xx_readb((void __iomem *)ioaddr->lbal_addr);
+		tf->hob_lbam = ep93xx_readb((void __iomem *)ioaddr->lbam_addr);
+		tf->hob_lbah = ep93xx_readb((void __iomem *)ioaddr->lbah_addr);
+	}
+}
+
+static u8 ep93xx_check_status(struct ata_port *ap)
+{
+	return ep93xx_readb((void __iomem *) ap->ioaddr.status_addr);
+}
+
+static u8 ep93xx_check_altstatus(struct ata_port *ap)
+{
+	return ep93xx_readb((void __iomem *)ap->ioaddr.altstatus_addr);
+}
+
+static void ep93xx_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+
+	ep93xx_writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
+	ata_pause(ap);
+}
+
+static unsigned int ep93xx_dev_check(struct ata_port *ap, unsigned int device)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 nsect, lbal;
+
+	ap->ops->dev_select(ap, device);
+
+	ep93xx_writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
+	ep93xx_writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
+
+	ep93xx_writeb(0xaa, (void __iomem *) ioaddr->nsect_addr);
+	ep93xx_writeb(0x55, (void __iomem *) ioaddr->lbal_addr);
+
+	ep93xx_writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
+	ep93xx_writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
+
+	nsect = ep93xx_readb((void __iomem *) ioaddr->nsect_addr);
+	lbal = ep93xx_readb((void __iomem *) ioaddr->lbal_addr);
+
+	if ((nsect == 0x55) && (lbal == 0xaa))
+		return 1;	/* we found a device */
+
+	return 0;		/* nothing found */
+}
+
+static void ep93xx_dev_select (struct ata_port *ap, unsigned int device)
+{
+	u8 tmp;
+
+	if (device == 0)
+		tmp = ATA_DEVICE_OBS;
+	else
+		tmp = ATA_DEVICE_OBS | ATA_DEV1;
+
+	ep93xx_writeb(tmp, (void __iomem *) ap->ioaddr.device_addr);
+
+	ata_pause(ap);	/* needed; also flushes, for mmio */
+}
+
+static void ep93xx_data_xfer(struct ata_port *ap, struct ata_device *adev,
+			unsigned char *buf, unsigned int buflen, int write_data)
+{
+	unsigned int i;
+	unsigned int words = buflen >> 1;
+	u16 *buf16 = (u16 *) buf;
+	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
+
+	/* Transfer multiple of 2 bytes */
+	if (write_data) {
+		for (i = 0; i < words; i++)
+			ep93xx_writew(le16_to_cpu(buf16[i]), mmio);
+	} else {
+		for (i = 0; i < words; i++)
+			buf16[i] = cpu_to_le16(ep93xx_readw(mmio));
+	}
+
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		u16 align_buf[1] = { 0 };
+		unsigned char *trailing_buf = buf + buflen - 1;
+
+		if (write_data) {
+			memcpy(align_buf, trailing_buf, 1);
+			ep93xx_writew(le16_to_cpu(align_buf[0]), mmio);
+		} else {
+			align_buf[0] = cpu_to_le16(ep93xx_readw(mmio));
+			memcpy(trailing_buf, align_buf, 1);
+		}
+	}
+}
+
+static struct scsi_host_template ep93xx_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations ep93xx_port_ops = {
+	.set_mode		= ep93xx_set_mode,
+	.mode_filter		= ep93xx_mode_filter,
+
+	.port_disable		= ata_port_disable,
+	.tf_load		= ep93xx_tf_load,
+	.tf_read		= ep93xx_tf_read,
+	.check_status 		= ep93xx_check_status,
+	.check_altstatus	= ep93xx_check_altstatus,
+	.exec_command		= ep93xx_exec_command,
+	.data_xfer		= ep93xx_data_xfer,
+
+	.dev_select 		= ep93xx_dev_select,
+	.dev_check		= ep93xx_dev_check,
+
+	.qc_prep 		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.eng_timeout		= ata_eng_timeout,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ep93xx_irq_clear,
+	.irq_on			= ep93xx_irq_on,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+
+	.phy_reset		= ep93xx_phy_reset,
+};
+
+/* Setup the addresses and encode CSx within them */
+static void ep93xx_ports(struct ata_ioports *ioaddr)
+{
+	ioaddr->cmd_addr	= 0 + 2; /* CS1 */
+	ioaddr->altstatus_addr	= (0x06 << 2) + 1; /* CS0 */
+	ioaddr->ctl_addr	= (0x06 << 2) + 1; /* CS0 */
+
+	ioaddr->data_addr	= (ATA_REG_DATA << 2) + 2;
+	ioaddr->error_addr	= (ATA_REG_ERR << 2) + 2;
+	ioaddr->feature_addr	= (ATA_REG_FEATURE << 2) + 2;
+	ioaddr->nsect_addr	= (ATA_REG_NSECT << 2) + 2;
+	ioaddr->lbal_addr	= (ATA_REG_LBAL << 2) + 2;
+	ioaddr->lbam_addr	= (ATA_REG_LBAM << 2) + 2;
+	ioaddr->lbah_addr	= (ATA_REG_LBAH << 2) + 2;
+	ioaddr->device_addr	= (ATA_REG_DEVICE << 2) + 2;
+	ioaddr->status_addr	= (ATA_REG_STATUS << 2) + 2;
+	ioaddr->command_addr	= (ATA_REG_CMD << 2) + 2;
+}
+
+static int __init ep93xx_pata_init(void)
+{
+	int ret;
+	struct ata_probe_ent ae;
+
+	memset(&ae, 0, sizeof(struct ata_probe_ent));
+	INIT_LIST_HEAD(&ae.node);
+
+	ae.dev		= NULL;
+	ae.private_data = NULL;
+	ae.port_ops	= &ep93xx_port_ops;
+	ae.sht		= &ep93xx_sht;
+	ae.n_ports	= 1;
+	ae.pio_mask	= 0x1f; /* PIO4 */
+	ae.irq		= 0;
+	ae.irq_flags	= 0;
+	ae.host_flags	= ATA_FLAG_IRQ_MASK | ATA_FLAG_MMIO;
+
+	ep93xx_ports(&ae.port[0]);
+
+	/* enable ide and set pio mode 4 */
+	__raw_writel(EP93XX_IDE_CFG_IDEEN | EP93XX_IDE_CFG_PIO |
+			EP93XX_IDE_CFG_WST(0) | EP93XX_IDE_CFG_MODE(4),
+			EP93XX_IDE_CFG);
+
+	ret = ata_device_add(&ae);
+	if (ret == 0)
+		return -ENODEV;
+
+	ep93xx_host = ae.host_set;
+
+	return 0;
+}
+
+static void __exit ep93xx_pata_exit(void)
+{
+	if (ep93xx_host)
+		ata_host_set_remove(ep93xx_host);
+}
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("low-level driver for ep93xx ATA");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(ep93xx_pata_init);
+module_exit(ep93xx_pata_exit);
Index: linux-2.6.16-rc5/include/asm-arm/arch-ep93xx/ep93xx-regs.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-arm/arch-ep93xx/ep93xx-regs.h
+++ linux-2.6.16-rc5/include/asm-arm/arch-ep93xx/ep93xx-regs.h
@@ -42,6 +42,32 @@
 #define EP93XX_BOOT_ROM_BASE		(EP93XX_AHB_VIRT_BASE + 0x00090000)
 
 #define EP93XX_IDE_BASE			(EP93XX_AHB_VIRT_BASE + 0x000a0000)
+#define EP93XX_IDE_REG(x)		(EP93XX_IDE_BASE + (x))
+#define EP93XX_IDE_CTRL			EP93XX_IDE_REG(0x0000)
+#define EP93XX_IDE_CFG			EP93XX_IDE_REG(0x0004)
+#define EP93XX_IDE_DATAOUT		EP93XX_IDE_REG(0x0010)
+#define EP93XX_IDE_DATAIN		EP93XX_IDE_REG(0x0014)
+
+#define EP93XX_IDE_CTRL_CS0n		(1L << 0)
+#define EP93XX_IDE_CTRL_CS1n		(1L << 1)
+#define EP93XX_IDE_CTRL_DA_MASK		0x1C
+#define EP93XX_IDE_CTRL_DA(x)		((x << 2) & EP93XX_IDE_CTRL_DA_MASK)
+#define EP93XX_IDE_CTRL_DA_CS_MASK	(EP93XX_IDE_CTRL_DA_MASK | EP93XX_IDE_CTRL_CS0n | EP93XX_IDE_CTRL_CS1n)
+#define EP93XX_IDE_CTRL_DA_CS(x)	(((x)) & EP93XX_IDE_CTRL_DA_CS_MASK)
+#define EP93XX_IDE_CTRL_DIORn		(1L << 5)
+#define EP93XX_IDE_CTRL_DIOWn		(1L << 6)
+#define EP93XX_IDE_CTRL_DASPn		(1L << 7)
+#define EP93XX_IDE_CTRL_DMARQ		(1L << 8)
+#define EP93XX_IDE_CTRL_INTRQ		(1L << 9)
+#define EP93XX_IDE_CTRL_IORDY		(1L << 10)
+
+#define EP93XX_IDE_CFG_IDEEN		(1L << 0)
+#define EP93XX_IDE_CFG_PIO		(1L << 1)
+#define EP93XX_IDE_CFG_MDMA		(1L << 2)
+#define EP93XX_IDE_CFG_UDMA		(1L << 3)
+#define EP93XX_IDE_CFG_MODE(x)		((x & 0x0F) << 4)
+#define EP93XX_IDE_CFG_WST(x)		((x & 0x03) << 8)
+
 
 #define EP93XX_VIC1_BASE		(EP93XX_AHB_VIRT_BASE + 0x000b0000)
 
