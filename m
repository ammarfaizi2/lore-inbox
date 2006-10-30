Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWJ3MBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWJ3MBn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWJ3MBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:01:43 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:9096 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750820AbWJ3MBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:01:42 -0500
From: "Peter Pearse" <peter.pearse@arm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC 3/7][PATCH] AMBA DMA: Add in functionality to provide AMBA DMA 
Date: Mon, 30 Oct 2006 12:01:38 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: Acb8Gyc5PDB2Av52TaOtv0tvH0SyLA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <CAM-OWA13aC6Y728f0P00000004@cam-owa1.Emea.Arm.com>
X-OriginalArrivalTime: 30 Oct 2006 12:01:41.0096 (UTC) FILETIME=[2920A680:01C6FC1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI DMA API is implemented for the AMBA bus.
The board registers callback functions with the AMBA DMA.
A platform level example is provided for the ARM Versatile development
board.

Signed-off-by: Peter M Pearse <peter.pearse@arm.com> 

---

diff -purN arm_amba_proc_dma/arch/arm/kernel/dma.c
arm_amba_dma/arch/arm/kernel/dma.c
--- arm_amba_proc_dma/arch/arm/kernel/dma.c	2006-10-17
17:05:21.000000000 +0100
+++ arm_amba_dma/arch/arm/kernel/dma.c	2006-10-17 17:10:15.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 
 #include <asm/dma.h>
@@ -73,7 +74,10 @@ int request_dma(dmach_t channel, const c
 	return ret;
 
 bad_dma:
-	printk(KERN_ERR "dma: trying to allocate DMA%d\n", channel);
+	/* 
+	 * Don't report an error - channels may be in use by other devices
+	 * printk(KERN_ERR "dma: trying to allocate DMA%d\n", channel);
+	 */
 	return -EINVAL;
 
 busy:
@@ -141,8 +145,14 @@ void __set_dma_addr (dmach_t channel, vo
 		printk(KERN_ERR "dma%d: altering DMA address while "
 		       "DMA active\n", channel);
 
+#ifdef CONFIG_ARM_AMBA_DMA
+ 	dma->sg = &dma->buf;
+ 	dma->sgcount = 1;
+	dma->buf.dma_address = virt_to_bus(addr);
+#else
 	dma->sg = NULL;
 	dma->addr = addr;
+#endif
 	dma->invalid = 1;
 }
 EXPORT_SYMBOL(__set_dma_addr);
@@ -229,6 +239,7 @@ int dma_channel_active(dmach_t channel)
 {
 	return dma_chan[channel].active;
 }
+EXPORT_SYMBOL(dma_channel_active);
 
 void set_dma_page(dmach_t channel, char pagenr)
 {
diff -purN arm_amba_proc_dma/drivers/amba/Kconfig
arm_amba_dma/drivers/amba/Kconfig
--- arm_amba_proc_dma/drivers/amba/Kconfig	2006-10-17
17:01:20.000000000 +0100
+++ arm_amba_dma/drivers/amba/Kconfig	2006-10-17 17:10:15.000000000 +0100
@@ -30,3 +30,10 @@ config HAS_ARM_AMBA_PL080
 
 endmenu
 
+config ARM_AMBA_DMA
+	bool "AMBA DMA support" if(ARCH_VERSATILE_PB || MACH_VERSATILE_AB)
+	depends on ARM_AMBA
+	select ISA_DMA_API
+	---help---
+	 Select to build ARM AMBA DMA support into the kernel.
+
diff -purN arm_amba_proc_dma/drivers/amba/Makefile
arm_amba_dma/drivers/amba/Makefile
--- arm_amba_proc_dma/drivers/amba/Makefile	2006-10-17
13:28:57.000000000 +0100
+++ arm_amba_dma/drivers/amba/Makefile	2006-10-17 17:10:15.000000000 +0100
@@ -1,2 +1,4 @@
-obj-y		+= bus.o
+obj-y				+= bus.o
+obj-$(CONFIG_ARM_AMBA_DMA)	+= dma.o
+
 
diff -purN arm_amba_proc_dma/drivers/amba/bus.c
arm_amba_dma/drivers/amba/bus.c
--- arm_amba_proc_dma/drivers/amba/bus.c	2006-10-17
13:28:57.000000000 +0100
+++ arm_amba_dma/drivers/amba/bus.c	2006-10-17 17:10:15.000000000 +0100
@@ -13,6 +13,9 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/amba/bus.h>
+#ifdef CONFIG_ARM_AMBA_DMA
+# include <linux/amba/dma.h>
+#endif
 
 #include <asm/io.h>
 #include <asm/sizes.h>
@@ -241,6 +244,18 @@ int amba_device_register(struct amba_dev
  out:
 			release_resource(&dev->res);
 		}
+#ifdef CONFIG_ARM_AMBA_DMA
+		/*
+		 *  Inform AMBA DMA ontrol code of the board ops to be
called
+		 */
+		if(dev->board_ops){
+			amba_set_ops(dev->board_ops);
+		} 
+		/*
+		 *  Provide the AMBA device with access to the DMA channel
data
+		 */
+		dev->chans = amba_get_chans();
+#endif
 	}
 	return ret;
 }
@@ -321,6 +336,54 @@ amba_find_device(const char *busid, stru
 	return data.dev;
 }
 
+/*
+ * In the request & free we want to call versatile routines with the
amba_device *
+ * We need this so we can pass the driver the interrupt etc DMAC driver
routines
+ * & to identify the amba_device for e.g setting the DMA mapping register
+ */
+typedef struct _query_data {
+	struct amba_device * ad;
+	char * name;
+} query_data;
+
+static int match_name(struct device * dev, void * data){
+	query_data * d = (query_data*)data;
+	int ret = 0;
+
+	if(dev && data){
+		if(dev->driver){
+			if(dev->driver->name){
+				if(0 == strncmp(dev->driver->name, (const
char *)d->name, strlen(dev->driver->name))){
+					get_device(dev);
+					d->ad = to_amba_device(dev);
+					ret = 1;
+				}
+			} else {
+				printk(KERN_ERR "amba.c::match_name() - no
driver name for device %p, driver %p\n", dev, dev->driver);
+			}
+		} /* else no driver attached */
+	} else  {
+		printk(KERN_ERR "amba.c::match_name() - void pointer(s) dev
%p, data %p\n", dev, data);
+	}
+	return ret;
+}
+
+/*
+ * Attempt to match the passed name to the driver, if any, of each AMBA
device on the bus
+ */
+struct amba_device * amba_get_device_with_name(char * name){
+
+	query_data d;
+
+	d.ad = NULL;
+	d.name = name;
+
+	bus_for_each_dev(&amba_bustype, NULL, &d, match_name);
+
+	return d.ad;
+}
+EXPORT_SYMBOL(amba_get_device_with_name);
+
 /**
  *	amba_request_regions - request all mem regions associated with
device
  *	@dev: amba_device structure for device
diff -purN arm_amba_proc_dma/drivers/amba/dma.c
arm_amba_dma/drivers/amba/dma.c
--- arm_amba_proc_dma/drivers/amba/dma.c	1970-01-01
01:00:00.000000000 +0100
+++ arm_amba_dma/drivers/amba/dma.c	2006-10-17 17:10:15.000000000 +0100
@@ -0,0 +1,141 @@
+/*
+ * drivers/amba/dma.c
+ *
+ * Copyright (C) 2006 ARM Ltd, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Shim for the AMBA DMA API
+ * Calls the board functions which may also call the controller, if any.
+ *
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/amba/bus.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/sizes.h>
+
+DEFINE_SPINLOCK(amba_dma_spin_lock);
+
+/* DMA operations of the board */
+struct dma_ops * board_ops = NULL;
+/* The DMA channel data */
+static dma_t * chans;
+
+void amba_set_ops(struct dma_ops * ops){
+	board_ops = ops;
+}
+
+/* Allow access to the DMA channel data held in arch/arm/kernel/dma.c */
+void __init arch_dma_init(dma_t *dma){
+	chans = dma;
+}
+
+dma_t * amba_get_chans(void){
+	return chans;
+}
+
+/*
+ * Successful int functions return 0
+ * - unless otherwise detailed
+ */
+
+static int	amba_request(dmach_t chan_num, dma_t * chan_data)
+{
+	int status = 0;
+
+	if((board_ops) && (board_ops->request)){
+		status = board_ops->request(chan_num, chan_data);
+	}
+
+	return status;
+}
+
+static void	amba_free(dmach_t chan_num, dma_t * chan_data)
+{
+	if((board_ops) && (board_ops->free)){
+		board_ops->free(chan_num, chan_data);
+	}
+}
+
+static void	amba_enable(dmach_t chan_num, dma_t * chan_data)
+{
+	if((board_ops) && (board_ops->enable)){
+		board_ops->enable(chan_num, chan_data);
+	}
+}
+
+static void 	amba_disable(dmach_t chan_num, dma_t * chan_data)
+{
+	if((board_ops) && (board_ops->disable)){
+		board_ops->disable(chan_num, chan_data);
+	}
+}
+
+/* ASSUME returns number of bytes */
+static int	amba_residue(dmach_t chan_num, dma_t * chan_data)
+{
+	int res = 0;
+	if((board_ops) && (board_ops->residue)){
+		res = board_ops->residue(chan_num, chan_data);
+	}
+	return res;
+}
+
+static int	amba_setspeed(dmach_t chan_num, dma_t * chan_data, int
speed)
+{
+	int new_speed = 0;
+	if((board_ops) && (board_ops->setspeed)){
+		new_speed = board_ops->setspeed(chan_num, chan_data, speed);
+	}
+	return new_speed;
+}
+
+/*
+ * AMBA ops to be called by kernel DMA functions
+ */
+static struct dma_ops amba_dma_ops = {
+	amba_request,	/* optional */
+	amba_free, 	/* optional */
+	amba_enable, 	/* mandatory */
+	amba_disable,	/* mandatory */
+	amba_residue,	/* optional */
+	amba_setspeed,	/* optional */
+	"AMBA DMA"
+};
+
+/*
+ * Initialize the dma channels, as far as we can
+ */
+void amba_init_dma(dma_t *channels)
+{
+	int i;
+
+	for(i = 0; i < MAX_DMA_CHANNELS; i++){
+		channels[i].sgcount = 0;
+		channels[i].sg = NULL;
+		channels[i].active = 0;
+		channels[i].invalid = 1;
+		// Disappeared channels[i].using_sg = 0;
+		channels[i].dma_mode = DMA_NONE;
+		channels[i].speed = 0;
+		channels[i].lock = 0;
+		channels[i].device_id = "UNASSIGNED";
+		channels[i].dma_base = (unsigned int)NULL;
+		channels[i].dma_irq = IRQ_DMAINT;
+		channels[i].state = 0;
+		channels[i].d_ops = &amba_dma_ops;
+	}
+}
+EXPORT_SYMBOL(amba_init_dma);
+
+
diff -purN arm_amba_proc_dma/include/asm-arm/arch-versatile/dma.h
arm_amba_dma/include/asm-arm/arch-versatile/dma.h
--- arm_amba_proc_dma/include/asm-arm/arch-versatile/dma.h	2006-10-17
13:29:29.000000000 +0100
+++ arm_amba_dma/include/asm-arm/arch-versatile/dma.h	2006-10-17
17:10:15.000000000 +0100
@@ -18,3 +18,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA
  */
+#define MAX_DMA_CHANNELS 0
diff -purN arm_amba_proc_dma/include/asm-arm/mach/dma.h
arm_amba_dma/include/asm-arm/mach/dma.h
--- arm_amba_proc_dma/include/asm-arm/mach/dma.h	2006-10-17
13:29:29.000000000 +0100
+++ arm_amba_dma/include/asm-arm/mach/dma.h	2006-10-17
17:10:15.000000000 +0100
@@ -10,6 +10,8 @@
  *  This header file describes the interface between the generic DMA
handler
  *  (dma.c) and the architecture-specific DMA backends (dma-*.c)
  */
+#ifndef _ASMARM_MACH_DMA_H_
+#define _ASMARM_MACH_DMA_H_
 
 struct dma_struct;
 typedef struct dma_struct dma_t;
@@ -22,6 +24,13 @@ struct dma_ops {
 	int	(*residue)(dmach_t, dma_t *);		/* optional */
 	int	(*setspeed)(dmach_t, dma_t *, int);	/* optional */
 	char	*type;
+#ifdef CONFIG_ARM_AMBA_DMA
+	/* 
+	 * Extra operations required by some particular AMBA DMA controller 
+	 * e.g. PL080
+	 */
+	void    * extra_ops;
+#endif
 };
 
 struct dma_struct {
@@ -55,3 +64,5 @@ struct dma_struct {
 extern void arch_dma_init(dma_t *dma);
 
 extern void isa_init_dma(dma_t *dma);
+
+#endif
diff -purN arm_amba_proc_dma/include/linux/amba/bus.h
arm_amba_dma/include/linux/amba/bus.h
--- arm_amba_proc_dma/include/linux/amba/bus.h	2006-10-17
13:29:40.000000000 +0100
+++ arm_amba_dma/include/linux/amba/bus.h	2006-10-17
17:10:16.000000000 +0100
@@ -10,6 +10,12 @@
 #ifndef ASMARM_AMBA_H
 #define ASMARM_AMBA_H
 
+#ifdef CONFIG_ARM_AMBA_DMA
+# include <asm/dma.h>
+# include <asm/mach/dma.h>
+# include <linux/amba/dma.h>
+#endif
+
 #define AMBA_NR_IRQS	2
 
 struct amba_device {
@@ -18,6 +24,12 @@ struct amba_device {
 	u64			dma_mask;
 	unsigned int		periphid;
 	unsigned int		irq[AMBA_NR_IRQS];
+#ifdef CONFIG_ARM_AMBA_DMA
+	struct amba_dma_data	dma_data;
+	struct dma_ops * 	board_ops;
+	struct dma_ops * 	dmac_ops;
+	dma_t *			chans;
+#endif
 };
 
 struct amba_id {
@@ -34,6 +46,9 @@ struct amba_driver {
 	int			(*suspend)(struct amba_device *,
pm_message_t);
 	int			(*resume)(struct amba_device *);
 	struct amba_id		*id_table;
+#ifdef CONFIG_ARM_AMBA_DMA
+	struct dma_ops * 	dmac_ops;
+#endif
 };
 
 #define amba_get_drvdata(d)	dev_get_drvdata(&d->dev)
@@ -47,9 +62,33 @@ struct amba_device *amba_find_device(con
 int amba_request_regions(struct amba_device *, const char *);
 void amba_release_regions(struct amba_device *);
 
+#ifdef CONFIG_ARM_AMBA_DMA
+struct amba_device * amba_get_device_with_name(char * name);
+#endif
+
 #define amba_config(d)	(((d)->periphid >> 24) & 0xff)
 #define amba_rev(d)	(((d)->periphid >> 20) & 0x0f)
 #define amba_manf(d)	(((d)->periphid >> 12) & 0xff)
 #define amba_part(d)	((d)->periphid & 0xfff)
 
+/* 
+ * AMBA ARM PrimeCell peripheral ids 
+ *
+ * Note that the hex number is that from the PrimeCell id
+ * e.g. pl041 has id 0x41 NOT 0x29
+ * hence OEM peripherals may use 0x<n>[a - f]
+ */
+#define AMBA_PERIPHID_UART	0x11
+#define AMBA_PERIPHID_SSI	0x22
+#define AMBA_PERIPHID_RTC	0x31
+#define AMBA_PERIPHID_AACI	0x40
+#define AMBA_PERIPHID_AACI_97	0x41
+#define AMBA_PERIPHID_KMI	0x50
+#define AMBA_PERIPHID_GPIO	0x61
+#define AMBA_PERIPHID_DMAC2	0x80
+#define AMBA_PERIPHID_DMAC1	0x81
+#define AMBA_PERIPHID_CLCD	0x110
+#define AMBA_PERIPHID_VIC	0x190
+#define AMBA_PERIPHID_CIM	0x321
+
 #endif
diff -purN arm_amba_proc_dma/include/linux/amba/dma.h
arm_amba_dma/include/linux/amba/dma.h
--- arm_amba_proc_dma/include/linux/amba/dma.h	1970-01-01
01:00:00.000000000 +0100
+++ arm_amba_dma/include/linux/amba/dma.h	2006-10-17
17:10:16.000000000 +0100
@@ -0,0 +1,35 @@
+/*
+ *  linux/include/linux/amba/dma.h
+ *
+ * Copyright (C) 2006 ARM Ltd, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *	DMA API for any AMBA system supporting DMA
+ *      i.e. there may or may not be an AMBA DMA controller in the system
+ */
+#ifndef LINUX_AMBA_DMA_H
+#define LINUX_AMBA_DMA_H
+
+/*
+ *  Data from the peripheral using DMA, required by the AMBA DMA manager
+ */
+struct amba_dma_data {
+	/* DMAC interrupt data as known by the board */
+	int  (*irq_ignore)(dmach_t chan);	/* Requesting device should
ignore this interrupt */
+	void (*irq_pre)   (dmach_t chan);	/* Any necessary DMA
operations e.g error checking */
+	void (*irq_post)  (dmach_t chan);	/* Clear the interrupt and
carry out any necessary DMA operations e.g re-enable DMAC channel */
+	unsigned int packet_size;		/* Size, in bytes, of each
DMA transfer packet */
+	void * dmac_data; 			/* DMA controller specific
data e.g. for pl080/pl041 TX transfers, the pl040 TX FIFO offset */ 
+};
+
+extern dma_t *		amba_get_chans	(void);
+extern void		amba_init_dma	(dma_t *channels);
+struct amba_device *	amba_get_device_with_name(char * name);
+void			amba_set_ops	(struct dma_ops * ops);
+
+#endif
+
+



