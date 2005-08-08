Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVHHQl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVHHQl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVHHQl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:41:58 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:15573 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932109AbVHHQl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:41:58 -0400
Subject: Re: [PATCH] spi
From: dmitry pervushin <dpervushin@gmail.com>
To: Mark Underwood <basicmark@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050808131655.22499.qmail@web30307.mail.mud.yahoo.com>
References: <20050808131655.22499.qmail@web30307.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 20:41:54 +0400
Message-Id: <1123519315.4762.111.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Surely this should be locked with bus lock?
Why not ? Until the transfer on device is not finished, the bus will be
locked. Otherwise, the another device (on the same bus) might want to
transfer something...
> 
> -= snip =-
> 
> Some other comments:
> 1) I think you need to fix some of your comments
> especially those describing how the interfaces work.
> 2) I take it spi adaptor drivers now use
> spi_bus_register/spi_bus_unregister?
> 3) Different clients on one bus will want to run at
> different speeds, how will you handle this?
> 3) This subsystem can only handle small transfers like
> I2C. SPI peripherals like SPI Ethernet devices will
> have to do lots of large transfers and with your
> current subsystem the device will be forced to wait
> until its transfer has finished (as well as other
> clients) when it might have other important work to
> do.
Hmm.. In the sample (it needs some polishing!), the bus initiates the
DMA transfers and waits for completion on it. Do you want to have
something like state machine (the function that will be called upon the
end of transfer ?)


 Kconfig             |   12 +
 Makefile            |    7
 pnxalloc.c          |   70 ++++++
 pnxalloc.h          |    9
 spi-pnx010x_atmel.c |   91 ++++++++
 spipnx-resources.h  |  138 ++++++++++++
 spipnx.c            |  581 ++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 spipnx.h            |  309 +++++++++++++++++++++++++++
 8 files changed, 1455 insertions(+)

Index: linux-2.6.10/drivers/spi/spipnx-resources.h
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/spipnx-resources.h
@@ -0,0 +1,138 @@
+#ifdef CONFIG_MACH_PNX0106_GH450
+struct resource spipnx_010x_resources_0[] = 
+{
+	{ 
+	  .start = BLAS_SPI0_BASE, 
+	  .end = BLAS_SPI0_BASE + SZ_4K, 
+	  .flags = IORESOURCE_MEM,
+	}, { 
+	  .start = SPI0_FIFO_DMA_SLAVE_NR, 
+	  .flags = IORESOURCE_DMA,
+	},
+	/*
+	 * Note that the clocks are shutdown in this order and resumed
+	 * in the opposite order.
+	 */
+       	{ 
+	  .start = CGU_SWITCHBOX_BLAS_SPI0_PCLK_ID, 
+	  .flags = IORESOURCE_CLOCK_ID,
+	}, {
+	  .start = CGU_SWITCHBOX_BLAS_SPI0_PCLK_GAT_ID,
+	  .flags = IORESOURCE_CLOCK_ID,
+	}, {
+	  .start = CGU_SWITCHBOX_BLAS_SPI0_FIFO_PCLK_ID,
+	  .flags = IORESOURCE_CLOCK_ID,
+	}, { 
+	   .start = CGU_SWITCHBOX_BLAS_SPI0_DUMMY_VPBCLK_ID, 
+	  .flags = IORESOURCE_CLOCK_ID,
+	}, {
+	  .start = VH_INTC_INT_NUM_BLAS_SPI0_INT, 
+	  .flags =  IORESOURCE_IRQ,
+	}, {
+	   .flags = 0,
+	}
+};
+
+struct resource spipnx_010x_resources_1[] = 
+{
+	{ 
+	  .start = BLAS_SPI1_BASE, 
+	  .end = BLAS_SPI1_BASE + SZ_4K, 
+	  .flags = IORESOURCE_MEM,
+	}, { 
+	  .start = SPI1_FIFO_DMA_SLAVE_NR, 
+	  .flags = IORESOURCE_DMA,
+	}, 
+	/*
+	 * Note that the clocks are shutdown in this order and resumed
+	 * in the opposite order.
+	 */
+	{ 
+	  .start = CGU_SWITCHBOX_BLAS_SPI1_PCLK_ID, 
+	  .flags = IORESOURCE_CLOCK_ID,
+	}, { 
+	   .start = CGU_SWITCHBOX_BLAS_SPI1_PCLK_GAT_ID,
+	   .flags = IORESOURCE_CLOCK_ID,
+	}, { 
+	  .start = CGU_SWITCHBOX_BLAS_SPI1_FIFO_PCLK_ID,
+	  .flags = IORESOURCE_CLOCK_ID,
+	}, {
+	   .start = CGU_SWITCHBOX_BLAS_SPI1_DUMMY_VPBCLK_ID, 
+	  .flags = IORESOURCE_CLOCK_ID,
+	}, {
+	  .start = VH_INTC_INT_NUM_BLAS_SPI1_INT, 
+	  .flags =  IORESOURCE_IRQ,
+	}, {
+	   .flags = 0,
+	}
+};
+#endif
+
+#ifdef CONFIG_MACH_PNX0105_GH448
+struct resource spipnx_010x_resources[] = 
+{
+	{ 
+	  .start = BLAS_SPI_BASE, 
+	  .end = BLAS_SPI_BASE + SZ_4K, 
+	  .flags = IORESOURCE_MEM,
+	}, { 
+	  .start = BLAS_SPI_DMA_SLAVE_NR, 
+	  .flags = IORESOURCE_DMA,
+	}, 
+	/*
+	 * Note that the clocks are shutdown in this order and resumed
+	 * in the opposite order.
+	 */
+	{
+	   .start =  CGU_SWITCHBOX_BLAS_SPI_PCLK_ID,
+	   .flags = IORESOURCE_CLOCK_ID,
+	}, {
+	   .start = CGU_SWITCHBOX_BLAS_SPI_PCLK_GAT_ID,
+	   .flags = IORESOURCE_CLOCK_ID,
+	}, {
+	   .start = CGU_SWITCHBOX_BLAS_SPI_FIFO_PCLK_ID,
+	   .flags = IORESOURCE_CLOCK_ID,
+	}, { 
+	  .start = VH_INTC_INT_NUM_BLAS_SPI_INT, 
+	  .flags =  IORESOURCE_IRQ,
+	}, {
+	   .flags = 0,
+	}
+};
+#endif
+
+#ifdef CONFIG_ARCH_PNX4008
+struct resource spipnx_4008_resources_0[] = 
+{
+	{ 	      
+	  .start = PNX4008_SPI1_BASE, 
+	  .end = PNX4008_SPI1_BASE + SZ_4K, 
+	  .flags = IORESOURCE_MEM,
+	}, { 
+	  .start = 11 /* SPI1_DMA_PERIPHERAL_ID */, 
+	  .flags = IORESOURCE_DMA,
+	}, { 
+	  .start = SPI1_INT, 
+	  .flags =  IORESOURCE_IRQ,
+	}, {
+	   .flags = 0,
+	}
+};
+
+struct resource spipnx_4008_resources_1[] = 
+{
+	{ 	      
+	  .start = PNX4008_SPI2_BASE, 
+	  .end = PNX4008_SPI2_BASE + SZ_4K, 
+	  .flags = IORESOURCE_MEM,
+	}, { 
+	  .start = 12 /* SPI2_DMA_PERIPHERAL_ID */, 
+	  .flags = IORESOURCE_DMA,
+	}, { 
+	  .start = SPI2_INT, 
+	  .flags =  IORESOURCE_IRQ,
+	}, {
+	   .flags = 0,
+	}
+};
+#endif
Index: linux-2.6.10/drivers/spi/spipnx.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/spipnx.c
@@ -0,0 +1,581 @@
+/*
+ * drivers/spi/spi-pnx.c
+ *
+ * SPI support for PNX 010x/4008 boards.
+ *
+ * Author: dmitry pervushin <dpervushin@ru.mvista.com>
+ * Based on Dennis Kovalev's <dkovalev@ru.mvista.com> bus driver for pnx010x
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#define CONFIG_ARCH_PNX4008_R2
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/spi.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/dma.h>
+
+#if defined(CONFIG_ARCH_PNX010X)
+#include <asm/arch/sdma.h>
+#include <asm/arch/cgu.h>
+#include <vhal/cgu_switchbox.h>
+#endif
+
+#if defined (CONFIG_ARCH_PNX4008)
+#include <asm/arch/dma.h>
+#include <asm/arch/gpio.h>
+#endif
+
+#define IORESOURCE_CLOCK_ID 0x80000000
+#include "spipnx.h"
+#include "spipnx-resources.h"
+#include "spi_locals.h"
+
+
+#define SPIPNX_BUS_TAG "spipnx"
+
+extern int spi_bus_match(struct device *dev, struct device_driver *driver);
+static int spipnx_interrupt( int irq, void* context, struct pt_regs* regs );
+static void spipnx_spi_init( struct spipnx_bus* );
+static int spipnx_xfer_nondma( struct spi_bus* bus, struct spi_device* device, struct spi_msg msgs[], int len, int flags );
+static int spipnx_xfer_dma( struct spi_bus* bus, struct spi_device* device, struct spi_msg msgs[], int len, int flags );
+static int spipnx_xfer( struct spi_bus* bus, struct spi_device* device, struct spi_msg msgs[], int len, int flags );
+static int spipnx_probe( struct device* dev );
+static int spipnx_remove( struct device* dev );
+static int spipnx_suspend(struct device *dev, u32 state, u32 level);
+static int spipnx_resume(struct device *dev, u32 level);
+
+struct bus_type spipnx_template = 
+{
+	.match = spi_bus_match,
+};
+
+struct device_driver spipnx_platform_driver = {
+	.bus = &platform_bus_type,
+	.name = SPIPNX_BUS_TAG,
+	.probe = spipnx_probe,
+	.remove = spipnx_remove,
+	.suspend = spipnx_suspend,
+	.resume = spipnx_resume,
+};
+
+
+static void spipnx_bus_set_mode( struct spipnx_bus* bus, int mode )
+{
+	bus->dma_mode = mode;
+}
+
+struct spipnx_bus spipnx_busses[] = 
+{
+#if defined( CONFIG_MACH_PNX0105_GH448 )
+	[0] = { 
+		.bus = { .rsrc = spipnx_010x_resources },
+		.set_mode = spipnx_bus_set_mode,
+		.state = SPIPNX_STATE_UNINITIALIZED,
+	},
+#elif defined( CONFIG_MACH_PNX0106_GH450 )	
+	[0] = { 
+		.bus = { .rsrc = spipnx_010x_resources_0 },
+		.set_mode = spipnx_bus_set_mode,
+		.state = SPIPNX_STATE_UNINITIALIZED,
+	},
+	[1] = { 
+		.bus = { .rsrc = spipnx_010x_resources_1 },
+		.set_mode = spipnx_bus_set_mode,
+		.state = SPIPNX_STATE_UNINITIALIZED,
+	},
+#elif defined( CONFIG_ARCH_PNX4008 )
+	[0] = { 
+		.bus = { .rsrc = spipnx_4008_resources_0 },
+		.set_mode = spipnx_bus_set_mode,
+		.state = SPIPNX_STATE_UNINITIALIZED,
+	},
+	[1] = { 
+		.bus = { .rsrc = spipnx_4008_resources_1 },
+		.set_mode = spipnx_bus_set_mode,
+		.state = SPIPNX_STATE_UNINITIALIZED,
+	},
+#endif
+};
+
+static void spipnx_free_hardware( struct spipnx_bus* pnx_bus )
+{
+	struct spi_bus *bus = &pnx_bus->bus;
+	struct resource* rsrc = bus->rsrc;
+	
+	down( &bus->lock );
+	for( rsrc = bus->rsrc; rsrc->flags; rsrc ++ ) {
+		if( rsrc->flags & IORESOURCE_IRQ ) {
+			free_irq( rsrc->start, bus->the_bus.name );
+		}
+		else if( rsrc->flags & IORESOURCE_MEM ) {
+			pnx_bus->spi_regs = ioremap( rsrc->start, SZ_4K );
+			release_mem_region( 
+					rsrc->start,
+					rsrc->end - rsrc->start + 1 );
+		}
+		else if( rsrc->flags & IORESOURCE_DMA ) {
+			spipnx_release_dma( pnx_bus );
+		}
+	}
+	up( &bus->lock );
+}
+int spipnx_request_hardware( struct spipnx_bus* pnx_bus )
+{	
+	struct spi_bus *bus = &pnx_bus->bus;
+	int err = 0;
+	struct resource* rsrc;
+	int* clk = pnx_bus->clk_id;
+	
+	down( &bus->lock );
+	pnx_bus->clk_id_num = 0;
+	for( rsrc = bus->rsrc; rsrc->flags; rsrc ++ ) {
+		if( rsrc->flags & IORESOURCE_IRQ ) {
+			pnx_bus->spi_regs->ier = 0;
+			if( !request_irq( 
+					rsrc->start, 
+					spipnx_interrupt,
+					SA_INTERRUPT,
+					bus->the_bus.name,
+					pnx_bus ) ) {
+				err = -ENODEV;
+			}
+		}
+		else if( rsrc->flags & IORESOURCE_MEM ) {
+			pnx_bus->phys_data_reg = (void*)rsrc->start + SPIPNX_DATA;
+			pnx_bus->spi_regs = ioremap( rsrc->start, SZ_4K );
+			if( NULL == request_mem_region( 
+					rsrc->start, 
+					rsrc->end - rsrc->start + 1, 
+					bus->the_bus.name ) ) {
+				err = -ENODEV;
+			}
+		}
+		else if( rsrc->flags & IORESOURCE_DMA ) {
+			pnx_bus->slave_nr = rsrc->start;
+			err = spipnx_request_dma( pnx_bus );
+		}
+		else if( rsrc->flags & IORESOURCE_CLOCK_ID ) {
+			if( pnx_bus->clk_id_num >= ARRAY_SIZE( pnx_bus->clk_id )) {
+				printk( KERN_ERR"%s: too many clocks defined\n", __FUNCTION__ );
+				err = -ENODEV;
+			} else {
+				*clk++ = rsrc->start;
+				pnx_bus->clk_id_num++;
+			}
+		}
+		else {
+			printk( "Unknown resource type 0x%08lx\n", rsrc->flags );
+		}
+	}
+	up( &bus->lock );
+	return err;
+}
+
+void spipnx_set_mode( struct spi_bus* bus, int mode )
+{
+	struct spipnx_bus* spipnx = TO_SPIPNX_BUS( bus );
+
+	down( &bus->lock );	
+	if( bus && spipnx->set_mode ) 
+		spipnx->set_mode( spipnx, mode );
+	up( &bus->lock );
+}
+
+int __init spipnx_init( void )
+{
+	int i;
+	int status;
+	
+	printk( "SPI bus driver for PNX010x\n" );
+	spipnx_platform_driver.name = SPIPNX_BUS_TAG;
+	for( i = 0; i < ARRAY_SIZE( spipnx_busses ); i ++ ) {
+		spipnx_busses[ i ].bus.the_bus = spipnx_template;
+		spipnx_busses[ i ].bus.xfer = spipnx_xfer;
+		spipnx_busses[ i ].dma_mode = 0;
+		spipnx_busses[ i ].dma_channel = -1;
+		status = spi_bus_register( &spipnx_busses[ i ].bus, SPIPNX_BUS_TAG );
+		if( status ) {
+			printk( "SPI Bus#%d cannot be registered: error %d\n", i, status );
+			continue;
+		}
+		spipnx_request_hardware( &spipnx_busses[ i ] );
+		spipnx_busses[ i ].state = SPIPNX_STATE_READY;
+	}
+	driver_register( &spipnx_platform_driver );
+	return 0;	
+}
+
+void __exit spipnx_cleanup( void )
+{
+	int i;
+	
+	driver_unregister( &spipnx_platform_driver );
+	for( i = 0; i < ARRAY_SIZE( spipnx_busses );  i ++ ) {
+		spipnx_busses[ i ].state = SPIPNX_STATE_UNINITIALIZED;
+		spi_bus_unregister( &spipnx_busses[ i ].bus );
+		spipnx_free_hardware( &spipnx_busses[ i ] );
+	}
+}
+
+static irqreturn_t spipnx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct spipnx_bus *bus = dev_id;
+	unsigned int i_stat = bus->spi_regs->stat;
+	unsigned int ier = bus->spi_regs->ier;
+
+	if ((i_stat & SPIPNX_STAT_EOT) &&
+	    (ier & SPIPNX_IER_EOT)) {
+		bus->spi_regs->ier &= ~SPIPNX_IER_EOT;
+		complete(&bus->op_complete);
+	}
+	if ((i_stat & SPIPNX_STAT_THR) &&
+	    (ier & SPIPNX_IER_THR)) {
+		bus->spi_regs->ier &= ~SPIPNX_IER_THR;
+		complete(&bus->threshold);
+	}
+	bus->spi_regs->stat |= SPIPNX_STAT_CLRINT;	/*     clear interrupt   */
+	bus->spi_regs->timer_status = 0L;
+
+	return IRQ_HANDLED;
+}
+
+static void spipnx_spi_init( struct spipnx_bus* bus)
+{
+	bus->spi_regs->global = SPIPNX_GLOBAL_RESET_SPI |
+	                        SPIPNX_GLOBAL_SPI_ON;	
+	mdelay(5);
+	bus->spi_regs->global = SPIPNX_GLOBAL_SPI_ON;
+	bus->spi_regs->con =
+		SPIPNX_CON_MS | SPIPNX_CLOCK;
+	bus->spi_regs->con |= SPIPNX_CON_BIDIR | ( 7<<9 );
+#ifdef CONFIG_ARCH_PNX4008	
+	bus->spi_regs->stat |= SPIPNX_STAT_CLRINT;
+	bus->spi_regs->con |= SPI_CON_SPI_MODE0 |  SPI_CON_RATE_13 | SPI_CON_THR; 
+#endif	
+}
+
+void  spipnx_default_cs( int type, struct spi_device* device )
+{
+#ifdef CONFIG_MACH_PNX0105_GH448
+	unsigned reg;
+	
+	switch( type ) 
+	{
+	case SELECT:
+	    reg = gpio_read_reg(PADMUX1_MODE0);
+	    gpio_write_reg((reg & ~GPIO_PIN_SPI_CE), PADMUX1_MODE0);
+	    break;
+	case UNSELECT:
+	    reg = gpio_read_reg(PADMUX1_MODE0);
+	    gpio_write_reg(reg | GPIO_PIN_SPI_CE, PADMUX1_MODE0);
+	    break;
+	}
+#endif
+}
+
+static int spipnx_xfer_nondma(struct spi_bus *spibus, struct spi_device* dev, struct spi_msg msgs[],
+			int num, int flags )
+{
+	struct spi_msg *pmsg;
+	int i, j, bptr;
+	raw_spinlock_t lock;
+	void (*chip_cs) ( int type, struct spi_device *device ) = dev->select ? dev->select : spipnx_default_cs;
+	struct spipnx_bus* bus = TO_SPIPNX_BUS( spibus );
+
+	pr_debug("Non-SDMA processing %d messages ...\n", num);
+
+	chip_cs(SELECT, dev );
+	bus->spi_regs->con |= SPIPNX_CON_THR; 
+
+	for (i = 0; i < num; i++) {
+		pmsg = &msgs[i];
+		
+		chip_cs( SPIMSG_FLAGS | ( pmsg->flags & SPI_M_CS ), dev );
+		if (pmsg->flags & SPI_M_RD) {	
+			/*  here we have to read data */
+			chip_cs(BEFORE_READ, dev );
+			bptr = 0;
+			init_completion(&bus->op_complete);
+			bus->spi_regs->frm = 0x0000FFFF & (pmsg->len);	
+			bus->spi_regs->con &= ~SPIPNX_CON_RXTX; 
+			bus->spi_regs->con |= SPIPNX_CON_SHIFT_OFF; 
+			bus->spi_regs->ier = SPIPNX_IER_EOT; 
+			bus->spi_regs->dat = 0x00;
+
+			while (bptr < pmsg->len) {
+				if ((pmsg->len) - bptr > FIFO_CHUNK_SIZE) {	/*  if there's data left for another  */
+					init_completion(&bus->threshold);	/*  init wait queue for another chunk */
+					spin_lock_irq(&lock);
+					bus->spi_regs->ier |= SPIPNX_IER_THR; 	/*  chunk, then enable THR interrupt  */
+					spin_unlock_irq(&lock);
+					wait_for_completion(&bus->threshold);
+				} else {
+					wait_for_completion(&bus->op_complete);
+				}
+				for (j = bptr;
+				     j <
+				     (((pmsg->len) - bptr <
+				       FIFO_CHUNK_SIZE) ? (pmsg->len) : (bptr +
+									 FIFO_CHUNK_SIZE));
+				     j++)
+					pmsg->buf[j] = bus->spi_regs->dat;
+				bptr +=
+				    ((pmsg->len) - bptr <
+				     FIFO_CHUNK_SIZE) ? (pmsg->len -
+							 bptr) :
+				    FIFO_CHUNK_SIZE;
+			}
+			pr_debug("[i]:SPI_M_RD: %x\n", *pmsg->buf);
+			chip_cs(AFTER_READ, dev);
+		} 
+		else if( pmsg->flags & SPI_M_WR ) {
+			/*  now we have to transmit data        */
+			chip_cs(BEFORE_WRITE, dev);
+			bus->spi_regs->con |= SPIPNX_CON_RXTX;
+			bus->spi_regs->frm = 0x0000FFFF & (pmsg->len);
+			bptr = 0;
+			init_completion(&bus->op_complete);
+			bus->spi_regs->ier = SPIPNX_IER_EOT;
+
+			while (bptr < pmsg->len) {
+				for (j = bptr;
+				     j <
+				     (((pmsg->len) - bptr <
+				       FIFO_CHUNK_SIZE) ? (pmsg->len) : (bptr +
+									 FIFO_CHUNK_SIZE));
+				     j++) {
+					bus->spi_regs->dat = pmsg->buf[j];
+				}
+				if ((pmsg->len) - bptr > FIFO_CHUNK_SIZE) {
+					init_completion(&bus->threshold);
+					spin_lock_irq(&lock);
+					bus->spi_regs->ier |= SPIPNX_IER_THR;
+					spin_unlock_irq(&lock);
+					wait_for_completion(&bus->threshold);
+				}
+				bptr +=
+				    ((pmsg->len) - bptr <
+				     FIFO_CHUNK_SIZE) ? (pmsg->len -
+							 bptr) :
+				    FIFO_CHUNK_SIZE;
+			}
+			wait_for_completion(&bus->op_complete);
+			pr_debug("[i]:SPI_M_WR: %x\n", *pmsg->buf);
+			chip_cs(AFTER_WRITE, dev);
+		}
+		chip_cs( SPIMSG_FLAGS | ( pmsg->flags & SPI_M_CSREL ), dev );
+	}	
+	chip_cs(UNSELECT, dev);
+	bus->spi_regs->ier &= ~SPIPNX_IER_EOT;
+
+	return num;
+}
+
+int spipnx_xfer_dma(struct spi_bus *spibus, struct spi_device* dev, struct spi_msg msgs[], int num, int flags)
+{
+	struct spi_msg *pmsg;
+	int i;
+	spi_pnx_msg_buff_t *buff;
+	void (*chip_cs) (int type, struct spi_device *device) = dev->select ? dev->select : spipnx_default_cs;
+	struct spipnx_bus *bus = TO_SPIPNX_BUS( spibus );
+
+	pr_debug("SDMA processing %d messages ...\n", num);
+
+	chip_cs(SELECT, dev);
+
+	for (i = 0; i < num; i++) {
+		pmsg = &msgs[i];
+		buff = (spi_pnx_msg_buff_t *) pmsg->buf;
+		pr_debug("SDMA processing [%d] message ...\n", i);
+
+		chip_cs( SPIMSG_FLAGS | ( pmsg->flags & SPI_M_CS ), dev );
+
+		if (pmsg->flags & SPI_M_RD) {
+			chip_cs(BEFORE_READ, dev);
+
+			init_completion(&bus->op_complete);
+			bus->spi_regs->con &= ~SPIPNX_CON_RXTX; 
+			bus->spi_regs->con |= SPIPNX_CON_SHIFT_OFF; 
+			bus->spi_regs->frm = 0x0000FFFF & (pmsg->len);
+			bus->spi_regs->ier = SPIPNX_IER_EOT; 
+
+			bus->spi_regs->dat = 0;
+			while (!
+			       (bus->spi_regs->
+				stat & SPIPNX_STAT_THR)) {
+					cpu_relax();
+			}
+			spipnx_setup_dma( bus, DMA_MODE_READ, buff,  pmsg->len  );
+			spipnx_start_dma( bus->dma_channel ); 
+			wait_for_completion(&bus->op_complete);
+			spipnx_stop_dma( bus->dma_channel ); 
+			pr_debug("[i]:SPI_M_RD: %x\n", *buff->io_buffer);
+			chip_cs(AFTER_READ, dev);
+		} else {
+			chip_cs(BEFORE_WRITE, dev );
+			bus->spi_regs->con |= SPIPNX_CON_RXTX; 
+			bus->spi_regs->frm = 0x0000FFFF & (pmsg->len);
+			bus->spi_regs->con &= ~SPIPNX_CON_SHIFT_OFF; 
+
+			spipnx_setup_dma( bus, DMA_MODE_WRITE, buff, pmsg->len );
+			bus->spi_regs->ier = SPIPNX_IER_EOT; 
+			init_completion(&bus->op_complete);
+			spipnx_start_dma( bus->dma_channel );
+			wait_for_completion(&bus->op_complete);
+			spipnx_stop_dma( bus->dma_channel);
+			pr_debug("[i]:SPI_M_WR: %x\n", *buff->io_buffer);
+			chip_cs(AFTER_WRITE, dev);
+		}
+		chip_cs( SPIMSG_FLAGS | ( pmsg->flags & SPI_M_CSREL ), dev );
+	}
+	chip_cs(UNSELECT, dev );
+
+	return num;
+}
+
+int spipnx_xfer(struct spi_bus *spibus, struct spi_device* dev, struct spi_msg msgs[], int num, int flags)
+{
+	int  i;
+	struct spi_msg *pmsg;
+	struct spipnx_bus* bus = TO_SPIPNX_BUS( spibus );
+	int status;
+
+	down( &spibus->lock );
+	if( !SPIPNX_IS_READY( bus ) ) {
+		status = -EIO;
+		goto unlock_and_out;
+	}
+	pr_debug("processing %d messages ...\n", num);
+	for (i = 0; i < num; i++) {
+		pmsg = &msgs[i];
+		if ((pmsg->len >= 0xFFFF) || (!pmsg->buf))
+			return -EINVAL;
+		pr_debug("%d) %c - %d bytes\n", i, pmsg->flags ? 'R' : 'W',
+			 pmsg->len);
+	}
+#ifdef CONFIG_ARCH_PNX010X		
+	if (bus->dma_mode) {
+		bus->sdma_config.transfer_size = SDMA_TRANSFER_BYTE;
+		bus->sdma_config.invert_endian = SDMA_INVERT_ENDIAN_NO;
+		bus->sdma_config.companion_channel = 0;
+		bus->sdma_config.companion_enable = SDMA_COMPANION_DISABLE;
+		bus->sdma_config.circular_buffer = SDMA_CIRC_BUF_DISABLE;
+	}
+#endif
+	spipnx_spi_init( bus );
+
+	status =  bus->dma_mode ? 
+		spipnx_xfer_dma( spibus, dev, msgs, num, flags) : 
+		spipnx_xfer_nondma( spibus, dev, msgs, num, flags );
+unlock_and_out:	
+	up( &spibus->lock );
+	return status;
+}
+
+static int spipnx_probe( struct device* dev )
+{
+	struct platform_device *pldev = to_platform_device( dev );
+
+	if( strncmp( pldev->name, SPIPNX_BUS_TAG, strlen( SPIPNX_BUS_TAG ) ) != 0 ) {
+		return -ENODEV;
+	}
+	spipnx_resume( dev, RESUME_POWER_ON );
+	spipnx_resume( dev, RESUME_ENABLE );
+	return 0;
+}
+
+static int spipnx_remove( struct device* dev )
+{
+	spipnx_suspend( dev, SUSPEND_DISABLE, 0 );
+	spipnx_suspend( dev, SUSPEND_POWER_DOWN, 0 );
+	return 0;
+}
+
+static int spipnx_suspend(struct device *dev, u32 state, u32 level)
+{
+	int err = 0;
+#ifdef CONFIG_PM
+	int c;
+	struct platform_device* pldev = to_platform_device(dev);
+	struct spi_bus *spibus = TO_SPI_BUS_PLDEV( pldev );
+	struct spipnx_bus* bus = TO_SPIPNX_BUS( spibus );
+
+	down( &spibus->lock );
+	switch (level) 
+	{
+	case SUSPEND_DISABLE:
+		spipnx_release_dma( bus );
+		bus->state = SPIPNX_STATE_SUSPENDED;              
+		break;
+	case SUSPEND_SAVE_STATE:
+		break;
+	case SUSPEND_POWER_DOWN:
+		for( c = 0; c < bus->clk_id_num; c ++ ) {
+		    cgu_set_clock_run( bus->clk_id[ c ], 0 );
+		}
+		break;
+	}
+	up( &spibus->lock );
+#endif
+	return err;
+}
+
+static int spipnx_resume(struct device *dev, u32 level)
+{
+	int err = 0;
+#ifdef CONFIG_PM
+	int c;
+	struct platform_device* pldev = to_platform_device(dev);
+	struct spi_bus *spibus = TO_SPI_BUS_PLDEV( pldev );
+	struct spipnx_bus* bus = TO_SPIPNX_BUS( spibus );
+
+	down( &spibus->lock );	
+	switch (level) 
+	{
+	case RESUME_POWER_ON:
+		for( c = bus->clk_id_num - 1; c >= 0; c -- ) {
+			cgu_set_clock_run(bus->clk_id[ c ], 1);
+		}
+		break;
+	case RESUME_RESTORE_STATE:
+		break;
+	case RESUME_ENABLE:
+		spipnx_request_dma( bus );
+		bus->state = SPIPNX_STATE_READY;
+		break;
+	}
+	up( &spibus->lock );
+#endif				/* CONFIG_PM */
+	return err;
+}
+
+
+EXPORT_SYMBOL_GPL( spipnx_set_mode );
+MODULE_AUTHOR("dmitry pervushin <dpervushin@ru.mvista.com>");
+MODULE_DESCRIPTION("SPI driver for Philips' PNX boards");
+MODULE_LICENSE("GPL");
+module_init(spipnx_init);
+module_exit(spipnx_cleanup);
Index: linux-2.6.10/drivers/spi/spi-pnx010x_atmel.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/spi-pnx010x_atmel.c
@@ -0,0 +1,91 @@
+/*
+ * drivers/spi/spi-pnx010x_atmel.c
+ *
+ * Provides Atmel SPI chip support for pnx010x.
+ *
+ * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/spi.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+// #include <asm/arch/sdma.h>
+
+#include "spipnx.h"
+#include "spi_locals.h"
+#include "pnxalloc.h"
+
+static int mode = 0;
+static int sdma_mode = 0;
+static char* spi_bus_atmel = "spipnx_00"; 
+MODULE_PARM( sdma_mode, "i" );
+MODULE_PARM( spi_bus_atmel, "s" );
+
+static struct spi_device atmel = {
+	.alloc = NULL,
+	.free = NULL,
+	.copy_from_user = NULL,
+	.copy_to_user = NULL,
+};
+
+int __init atmel_init( void )
+{
+        struct spi_bus* bus = spi_bus_find( spi_bus_atmel );
+        int err;
+
+        if( NULL == bus ) {
+                err = -ENODEV;
+                goto out;
+	}
+				
+	if (sdma_mode) {
+		atmel.alloc = pnx_memory_alloc;
+		atmel.free = pnx_memory_free;
+		atmel.copy_from_user = pnx_copy_from_user;
+		atmel.copy_to_user = pnx_copy_to_user;
+		spipnx_set_mode( bus, 1 );
+	}
+	
+	err = spi_device_add( bus, &atmel, "atmel" );
+	if( err ) {
+		goto out;
+	}
+	printk( "ATMEL driver for the SPI bus loaded.\n" );
+out:
+	if( err ) {
+		printk( "ATMEL driver for the SPI bus: error = %d\n", err );
+	}
+	return err;
+}
+
+void __exit atmel_exit( void )
+{
+	spi_device_del( &atmel );
+}
+
+module_init( atmel_init );
+module_exit( atmel_exit );
+
Index: linux-2.6.10/drivers/spi/spipnx.h
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/spipnx.h
@@ -0,0 +1,309 @@
+/*
+ * SPI support for pnx010x.
+ *
+ * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+//#ifndef CONFIG_ARCH_PNX010X
+//#error This driver cannot be run on non-pnx010x
+//#endif
+
+#ifndef _SPI_PNX_BUS_DRIVER
+#define _SPI_PNX_BUS_DRIVER
+
+#include <asm/arch/platform.h>
+#include <asm/arch/dma.h>
+#include <asm/dma.h>
+
+
+
+#if defined (CONFIG_ARCH_PNX010X)
+#include <vhal/spi_pnx0105.h>
+#include <vhal/ioconf.h>
+#elif defined( CONFIG_ARCH_PNX4008)
+typedef volatile struct  {
+        u32 global ;			/* 0x000             */
+        u32 con ;			/* 0x004             */
+        u32 frm ;			/* 0x008             */
+        u32 ier ;			/* 0x00C             */
+        u32 stat ;			/* 0x010             */
+        u32 dat ;			/* 0x014             */
+        u32 dat_msk ;		/* 0x018             */
+        u32 mask ;			/* 0x01C             */
+        u32 addr ;			/* 0x020             */
+    	u32 _d0[(SPI_ADR_OFFSET_TIMER_CTRL_REG - (SPI_ADR_OFFSET_ADDR + sizeof( u32))) / sizeof( u32 )];
+        u32 timer_ctrl ;		/* 0x400             */
+        u32 timer_count ;		/* 0x404             */
+        u32 timer_status ;		/* 0x408             */
+} vhblas_spiregs, *pvhblas_spiregs;
+#endif
+
+#if defined( CONFIG_ARCH_PNX010X )
+#define SPIPNX_STAT_EOT (1 << VH_BLASSPI_STAT_REG_SPI_EOT_POS )
+#define SPIPNX_STAT_THR (1 << VH_BLASSPI_STAT_REG_SPI_THR_POS )
+#define SPIPNX_IER_EOT  (1 << VH_BLASSPI_IER_REG_SPI_INTEOT_POS )
+#define SPIPNX_IER_THR  (1 << VH_BLASSPI_IER_REG_SPI_INTTHR_POS )
+#define SPIPNX_STAT_CLRINT (1 << VH_BLASSPI_STAT_REG_SPI_INTCLR_POS )
+#define SPIPNX_GLOBAL_RESET_SPI (1 << VH_BLASSPI_GLOBAL_REG_BLRES_SPI_POS)
+#define SPIPNX_GLOBAL_SPI_ON (1 << VH_BLASSPI_GLOBAL_REG_SPI_ON_POS)
+#define SPIPNX_CON_MS (1 << VH_BLASSPI_CON_REG_MS_POS)
+#define SPIPNX_CON_BIDIR (1 << VH_BLASSPI_CON_REG_SPI_BIDIR_POS) 
+#define SPIPNX_CON_RXTX VH_BLASSPI_CON_REG_RXTX_MSK 
+#define SPIPNX_CON_THR  (1 << VH_BLASSPI_CON_REG_THR_POS)
+#define SPIPNX_CON_SHIFT_OFF (1 << VH_BLASSPI_CON_REG_SHIFT_OFF_POS)
+#define SPIPNX_DATA  VH_BLASSPI_ADDR_REG
+#define SPIPNX_CLOCK SPI_CLOCK
+
+#elif defined( CONFIG_ARCH_PNX4008 )
+#define SPIPNX_STAT_EOT SPI_STAT_SPI_EOT
+#define SPIPNX_STAT_THR SPI_STAT_SPI_THR
+#define SPIPNX_IER_EOT SPI_IER_SPI_INTEOT
+#define SPIPNX_IER_THR SPI_IER_SPI_INTTHR
+#define SPIPNX_STAT_CLRINT SPI_STAT_SPI_INTCLR
+
+#define SPIPNX_GLOBAL_RESET_SPI SPI_GLOBAL_BLRES_SPI
+#define SPIPNX_GLOBAL_SPI_ON 	SPI_GLOBAL_SPI_ON
+#define SPIPNX_CON_MS		SPI_CON_MS
+#define SPIPNX_CON_BIDIR	SPI_CON_SPI_BIDIR
+#define SPIPNX_CON_RXTX		SPI_CON_RxTx
+#define SPIPNX_CON_THR		SPI_CON_THR
+#define SPIPNX_CON_SHIFT_OFF	SPI_CON_SHIFT_OFF
+#define SPIPNX_DATA		SPI_ADR_OFFSET_DAT
+#define SPI_PNX4008_CLOCK_IN  104000000
+#define SPI_PNX4008_CLOCK 2670000
+#define SPIPNX_CLOCK ((((SPI_PNX4008_CLOCK_IN / SPI_PNX4008_CLOCK) - 2) / 2) & SPI_CON_RATE_MASK )
+#endif
+
+/* exports */
+extern void spipnx_set_mode( struct spi_bus* bus, int mode );
+
+/* structures */
+#define TO_SPIPNX_BUS(spipnx) container_of( spipnx, struct spipnx_bus, bus )
+struct spipnx_bus 
+{
+	int dma_mode;
+	void (*set_mode)( struct spipnx_bus* this, int dma );
+	struct spi_bus bus;
+	void* phys_data_reg;	
+	int dma_channel;
+#ifdef CONFIG_ARCH_PNX010X
+	sdma_setup_t sdma_setup;
+	sdma_config_t sdma_config;
+#endif	
+ 	vhblas_spiregs*	spi_regs;
+	int slave_nr;
+	int clk_id[ 4 ];
+	int clk_id_num;
+	int sdma_use_count;
+	struct completion threshold;
+	struct completion op_complete;
+	int state;
+};
+#define SPIPNX_STATE_UNINITIALIZED 0
+#define SPIPNX_STATE_READY         1
+#define SPIPNX_STATE_SUSPENDED     2
+
+#define SPIPNX_IS_READY( bus )  ( (bus)->state == SPIPNX_STATE_READY )
+
+typedef enum {
+	SELECT = 0,
+	UNSELECT,
+	INIT,
+	BEFORE_READ,
+	AFTER_READ,
+	BEFORE_WRITE,
+	AFTER_WRITE,
+} spi_pnx010x_cb_type_t;
+#define SPIMSG_FLAGS 0x80
+
+typedef struct {
+	char *io_buffer;
+	dma_addr_t dma_buffer;
+	size_t size;
+} spi_pnx_msg_buff_t;
+
+static inline int spipnx_request_dma ( struct spipnx_bus* bus )
+{
+ 	int err;
+	
+	if( bus->dma_channel != -1 ) {
+		err = bus->dma_channel;
+		goto out;
+	}
+#if defined ( CONFIG_ARCH_PNX010X )
+      	err = sdma_request_channel( bus->bus.the_bus.name, NULL, NULL );
+#elif defined( CONFIG_ARCH_PNX4008 )
+	err = pnx4008_request_channel( bus->bus.the_bus.name, -1, NULL, NULL );
+#endif
+	if( err >= 0 ) {
+		bus->dma_channel = err;
+	}
+out:	
+	return err < 0 ? err : 0;
+}
+
+static inline void spipnx_release_dma( struct spipnx_bus* bus )
+{
+	if( bus->dma_channel >= 0 ) {
+#if defined ( CONFIG_ARCH_PNX010X )
+	      	sdma_release_channel( bus->dma_channel );
+#elif defined( CONFIG_ARCH_PNX4008 )
+		pnx4008_free_channel( bus->dma_channel );
+#endif	
+	}
+	bus->dma_channel = -1;
+}
+
+static inline void spipnx_start_dma( int dma_channel ) 
+{
+#if defined( CONFIG_ARCH_PNX010X )
+	sdma_start_channel( dma_channel );
+#elif defined( CONFIG_ARCH_PNX4008 )
+	pnx4008_dma_ch_enable( dma_channel );
+#else
+#warning spipnx_start_dma does nothing
+	dma_channel = dma_channel;
+#endif	
+}
+
+static inline void spipnx_stop_dma( int dma_channel )
+{
+#if defined( CONFIG_ARCH_PNX010X )
+	sdma_stop_channel( dma_channel );
+#elif defined( CONFIG_ARCH_PNX4008 )
+	pnx4008_dma_ch_disable( dma_channel );
+#else
+#warning spipnx_stop_dma does nothing
+	dma_channel = dma_channel;
+#endif	
+}
+
+static inline int spipnx_setup_dma( struct spipnx_bus* bus, int mode, spi_pnx_msg_buff_t* buff, int len )
+{
+	int err = 0;
+
+#if defined( CONFIG_ARCH_PNX010X )
+	if( mode == DMA_MODE_READ ) {
+		bus->sdma_setup.src_address =  
+			    (unsigned int)bus->phys_data_reg;
+		bus->sdma_setup.dest_address =
+			    (unsigned int)buff->dma_buffer;
+		bus->sdma_setup.trans_length = len;
+		bus->sdma_config.write_slave_nr = MEMORY_DMA_SLAVE_NR;
+		bus->sdma_config.read_slave_nr = bus->slave_nr;
+	}
+	else if( mode == DMA_MODE_WRITE ) {
+		bus->sdma_setup.dest_address =  
+			    (unsigned int)bus->phys_data_reg;
+		bus->sdma_setup.src_address =
+			    (unsigned int)buff->dma_buffer;
+		bus->sdma_setup.trans_length = len;
+		bus->sdma_config.read_slave_nr = MEMORY_DMA_SLAVE_NR;
+		bus->sdma_config.write_slave_nr = bus->slave_nr;
+	}
+	else {
+		err = -EINVAL;
+		goto out;	
+	}
+	err = sdma_pack_config(&bus->sdma_config,
+			 &bus->sdma_setup.packed_config);
+	if( err ) {
+		goto out;
+	}
+	err = sdma_prog_channel(bus->dma_channel, &bus->sdma_setup);
+#elif defined( CONFIG_ARCH_PNX4008 )
+        pnx4008_dma_config_t cfg;
+	pnx4008_dma_ch_config_t ch_cfg;
+        pnx4008_dma_ch_ctrl_t ch_ctrl;
+
+	memset( &cfg, 0, sizeof( cfg ) );
+
+	if( mode == DMA_MODE_READ ) {
+ 	        cfg.dest_addr = buff->dma_buffer;
+		cfg.src_addr = (u32)bus->phys_data_reg;
+	        ch_cfg.flow_cntrl = FC_PER2MEM_DMA;
+		ch_cfg.src_per = bus->slave_nr;
+		ch_cfg.dest_per = 0;
+		ch_ctrl.di = 1;
+	        ch_ctrl.si = 0;
+	}
+	else if ( mode == DMA_MODE_WRITE ) {
+ 	        cfg.src_addr = buff->dma_buffer;
+		cfg.dest_addr = (u32)bus->phys_data_reg;
+	        ch_cfg.flow_cntrl = FC_MEM2PER_DMA;
+		ch_cfg.dest_per = bus->slave_nr;
+		ch_cfg.src_per = 0;
+		ch_ctrl.di = 0;
+	        ch_ctrl.si = 1;
+	}
+	else {
+		err = -EINVAL;
+	}
+
+	ch_cfg.halt = 0;
+        ch_cfg.active = 1;
+	ch_cfg.lock = 0;
+	ch_cfg.itc = 1;
+	ch_cfg.ie = 1;
+        ch_ctrl.tc_mask = 1;
+        ch_ctrl.cacheable = 0;
+        ch_ctrl.bufferable = 0;
+        ch_ctrl.priv_mode = 1;
+	ch_ctrl.dest_ahb1 = 0;
+	ch_ctrl.src_ahb1 = 0;
+	ch_ctrl.dwidth = WIDTH_BYTE;
+        ch_ctrl.swidth = WIDTH_BYTE;
+        ch_ctrl.dbsize = 1;
+        ch_ctrl.sbsize = 1;
+        ch_ctrl.tr_size = len;
+        if( 0 > ( err = pnx4008_dma_pack_config(&ch_cfg, &cfg.ch_cfg) ) ) {
+		goto out;
+	}
+        if( 0 > ( err = pnx4008_dma_pack_control(&ch_ctrl, &cfg.ch_ctrl) ) ) {
+		goto out;
+	}
+        err = pnx4008_config_channel( bus->dma_channel, &cfg);
+#endif
+out:
+	return err;
+}
+
+#define IORESOURCE_CLOCK_ID 0x80000000
+#define FIFO_CHUNK_SIZE		56
+#define SPI_RECEIVE                        0
+#define SPI_TRANSMIT                       1
+
+#define SPI_ENDIAN_SWAP_NO                 0
+#define SPI_ENDIAN_SWAP_YES                1
+
+#if defined( CONFIG_ARCH_PNX010X )
+#define SPI_CLOCK		0x10
+
+/*  GPIO related definitions  */
+#define PADMUX1_PINS		(IOCONF_PNX0105_PADMUX0 + VH_IOCONF_REG_PINS)
+#define PADMUX1_MODE0		(IOCONF_PNX0105_PADMUX0 + VH_IOCONF_REG_MODE0)
+#define PADMUX1_MODE0SET	(IOCONF_PNX0105_PADMUX0 + VH_IOCONF_REG_MODE0_SET)
+#define PADMUX1_MODE0RESET	(IOCONF_PNX0105_PADMUX0 + VH_IOCONF_REG_MODE0_RESET)
+#define PADMUX1_MODE1		(IOCONF_PNX0105_PADMUX0 + VH_IOCONF_REG_MODE1)
+#define PADMUX1_MODE1SET	(IOCONF_PNX0105_PADMUX0 + VH_IOCONF_REG_MODE1_SET)
+#define PADMUX1_MODE1RESET	(IOCONF_PNX0105_PADMUX0 + VH_IOCONF_REG_MODE1_RESET)
+
+#define GPIO_PIN_SPI_CE			(1<<VH_IOCONF_PNX0105_PADMUX1_MSPI_CE_POS)
+#define PADMUX1_BASE_ADDR		IO_ADDRESS(IOCONF_BASE)
+
+#define GPIO_PIN_SPI_CE			(1<<VH_IOCONF_PNX0105_PADMUX1_MSPI_CE_POS)
+#define PADMUX1_BASE_ADDR		IO_ADDRESS(IOCONF_BASE)
+
+#define gpio_write_reg(val,reg)		writel (val, PADMUX1_BASE_ADDR + reg)
+#define gpio_read_reg(reg)		readl (PADMUX1_BASE_ADDR + reg)
+#endif
+
+#endif // __SPI_PNX_BUS_DRIVER
+
+
+
Index: linux-2.6.10/drivers/spi/pnxalloc.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/pnxalloc.c
@@ -0,0 +1,70 @@
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <asm/uaccess.h>
+#include <asm/dma.h>
+
+#include <linux/spi.h>
+
+#include "spipnx.h"
+#include "pnxalloc.h"
+
+void *pnx_memory_alloc(size_t size, int base)
+{
+	spi_pnx_msg_buff_t *buff;
+
+	buff = (spi_pnx_msg_buff_t *) kmalloc(sizeof(spi_pnx_msg_buff_t), base);
+	buff->size = size;
+	buff->io_buffer =
+	    dma_alloc_coherent(NULL, size, &buff->dma_buffer, base);
+
+	pr_debug
+	    ("%s:allocated memory(%p) for io_buffer = %p dma_buffer = %08x\n",
+	     __FUNCTION__, buff, buff->io_buffer, buff->dma_buffer);
+
+	return (void *)buff;
+}
+
+void pnx_memory_free(const void *data)
+{
+	spi_pnx_msg_buff_t *buff;
+
+	buff = (spi_pnx_msg_buff_t *) data;
+	pr_debug("%s:deleted memory(%p) for io_buffer = %p dma_buffer = %08x\n",
+		 __FUNCTION__, buff, buff->io_buffer, buff->dma_buffer);
+
+	dma_free_coherent(NULL, buff->size, buff->io_buffer, buff->dma_buffer);
+	kfree(buff);
+}
+
+unsigned long pnx_copy_from_user(void *to, const void *from_user,
+				 unsigned long len)
+{
+	spi_pnx_msg_buff_t *buff;
+	int ret;
+
+	buff = (spi_pnx_msg_buff_t *) to;
+	ret = copy_from_user(buff->io_buffer, from_user, len);
+
+	return ret;
+}
+
+unsigned long pnx_copy_to_user(void *to_user, const void *from,
+			       unsigned long len)
+{
+	spi_pnx_msg_buff_t *buff;
+	int ret;
+
+	buff = (spi_pnx_msg_buff_t *) from;
+	ret = copy_to_user(to_user, buff->io_buffer, len);
+
+	return ret;
+}
+
+EXPORT_SYMBOL( pnx_copy_to_user );
+EXPORT_SYMBOL( pnx_copy_from_user );
+EXPORT_SYMBOL( pnx_memory_alloc );
+EXPORT_SYMBOL( pnx_memory_free );
Index: linux-2.6.10/drivers/spi/pnxalloc.h
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/pnxalloc.h
@@ -0,0 +1,9 @@
+#ifndef __PNX_ALLOC_H
+#define __PNX_ALLOC_H
+void *pnx_memory_alloc(size_t size, int base);
+void pnx_memory_free(const void *data);
+unsigned long pnx_copy_from_user(void *to, const void *from_user,
+				 unsigned long len);
+unsigned long pnx_copy_to_user(void *to_user, const void *from,
+			       unsigned long len);
+#endif
Index: linux-2.6.10/drivers/spi/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/spi/Kconfig
+++ linux-2.6.10/drivers/spi/Kconfig
@@ -29,5 +29,17 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called spi-dev.
 
+config SPI_PNX
+	tristate "PNX SPI bus support"
+	depends on SPI
+
+config SPI_PNX010X_ATMEL
+	tristate "Atmel Flash chip on PNX010x SPI support"
+	depends on SPI_PNX && ARCH_PNX010X
+
+config SPI_PNX4008_EEPROM
+	tristate "Dummy EEPROM driver"
+	depends on SPI_PNX && ARCH_PNX4008
+
 endmenu
 
Index: linux-2.6.10/drivers/spi/Makefile
===================================================================
--- linux-2.6.10.orig/drivers/spi/Makefile
+++ linux-2.6.10/drivers/spi/Makefile
@@ -4,6 +4,13 @@
 
 obj-$(CONFIG_SPI) += spi-core.o helpers.o
 
+obj-$(CONFIG_SPI_PNX)            += spipnx.o 
+obj-$(CONFIG_SPI_PNX010X_ATMEL)  += spi-pnx010x_atmel.o 
+
+obj-$(CONFIG_ARCH_PNX4008)       += pnxalloc.o
+obj-$(CONFIG_ARCH_PNX010X)       += pnxalloc.o
+
 obj-$(CONFIG_SPI_CHARDEV) += spi-dev.o
 
 ifeq ($(CONFIG_SPI_DEBUG),y)


