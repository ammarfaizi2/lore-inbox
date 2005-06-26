Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVFZTlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVFZTlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVFZTl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:41:27 -0400
Received: from [82.148.30.74] ([82.148.30.74]:63240 "EHLO abc.pervushin.pp.ru")
	by vger.kernel.org with ESMTP id S261597AbVFZTgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:36:22 -0400
From: <dpervushin@ru.mvista.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC] SPI core -- revisited
Date: Sun, 26 Jun 2005 23:36:13 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcV6hJ5MDkWWP+8BRGyPnjrta0adFgAADXhAAABZG8A=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

Here is the sample of usage of our SPI core; this is the driver of atmel
chip connected to the pnx spi bus; 

Index: linux-2.6.10/drivers/spi/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/spi/Kconfig
+++ linux-2.6.10/drivers/spi/Kconfig
@@ -27,5 +27,14 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called spi-dev.
 
+config SPI_PNX010X
+	tristate "PNX010x SPI bus support"
+	depends on SPI
+
+config SPI_PNX010X_ATMEL
+	tristate "Atmel Flash chip on PNX010x SPI support"
+	depends on SPI_PNX010X
+
+
 endmenu
 
Index: linux-2.6.10/drivers/spi/Makefile
===================================================================
--- linux-2.6.10.orig/drivers/spi/Makefile
+++ linux-2.6.10/drivers/spi/Makefile
@@ -6,4 +6,6 @@
 
 obj-$(CONFIG_SPI) += spi-core.o helpers.o
 obj-$(CONFIG_SPI_CHARDEV) += spi-dev.o
+obj-$(CONFIG_SPI_PNX010X)     += spi-pnx010x.o
+obj-$(CONFIG_SPI_PNX010X_ATMEL)       += spi-pnx010x_atmel.o
 
Index: linux-2.6.10/drivers/spi/spi-pnx010x.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/spi-pnx010x.c
@@ -0,0 +1,385 @@
+/*
+ * drivers/spi/spi-pnx010x.c
+ *
+ * SPI support for PNX0105.
+ *
+ * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether 
+express
+ * or implied.
+ */
+
+/*  Uncomment the following line for debugging info  */
+/*
+#define SPIPNX_DEBUG
+*/
+#ifdef SPIPNX_DEBUG
+#define DEBUG 1
+#endif
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
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
+#include <asm/arch/sdma.h>
+
+#define DBG(args...)	pr_debug(args)
+#include <linux/spi/spi-pnx010x.h>
+
+static struct completion threshold;
+static struct completion op_complete;
+static void		*phys_spi_data_reg = 0;
+static unsigned int	 spi_sdma_channel = 0;
+static char		 sdma_ch_name[] = "SDMA channel";
+static sdma_setup_t	 sdma_setup;
+static sdma_config_t	 sdma_config;
+static int		 sdma_use_count = 0;
+
+static void default_spipnx_cs (int type, void *data);
+
+static irqreturn_t spipnx_interrupt (int irq, void *dev_id, struct 
+pt_regs *regs) {
+	unsigned int i_stat = spi_regs.stat;
+	
+	if ( (i_stat & VH_BLASSPI_STAT_REG_SPI_EOT_MSK) && 
+	     (spi_regs.ier & VH_BLASSPI_IER_REG_SPI_INTEOT_MSK) ) {
+		spi_regs.ier &= ~VH_BLASSPI_IER_REG_SPI_INTEOT_MSK;
+		complete (&op_complete);
+	}
+	if ( (i_stat & VH_BLASSPI_STAT_REG_SPI_THR_MSK) && 
+	     (spi_regs.ier & VH_BLASSPI_IER_REG_SPI_INTTHR_MSK) ) {
+		spi_regs.ier &= ~VH_BLASSPI_IER_REG_SPI_INTTHR_MSK;
+		complete (&threshold);
+	}
+	spi_regs.stat |= (1 << VH_BLASSPI_STAT_REG_SPI_INTCLR_POS);    /*
clear interrupt   */
+	spi_regs.timer_status = 0L;
+
+	return IRQ_HANDLED;
+}
+
+void spipnx_select_chip (void)
+{
+	unsigned reg = gpio_read_reg (PADMUX1_MODE0);
+	gpio_write_reg ((reg & ~GPIO_PIN_SPI_CE), PADMUX1_MODE0); }
+
+void spipnx_unselect_chip (void)
+{
+	unsigned reg = gpio_read_reg (PADMUX1_MODE0);
+	gpio_write_reg (reg | GPIO_PIN_SPI_CE, PADMUX1_MODE0); }
+
+static void spipnx_spi_init (void *algo_data) {
+	spi_pnx0105_algo_data_t *alg_data;
+	alg_data = (spi_pnx0105_algo_data_t *) algo_data;
+
+	spipnx_select_chip();
+	spi_regs.global = (1 << VH_BLASSPI_GLOBAL_REG_BLRES_SPI_POS) | 
+			  (1 << VH_BLASSPI_GLOBAL_REG_SPI_ON_POS);
+
+	mdelay (5);
+    
+	spi_regs.global = 1 << VH_BLASSPI_GLOBAL_REG_SPI_ON_POS;
/*  enable device once more             */
+	spi_regs.con =  (alg_data->mode << 16) | 
+			(1 << VH_BLASSPI_CON_REG_MS_POS) | 
+			SPI_CLOCK;
+	spi_regs.con |= (1 << VH_BLASSPI_CON_REG_SPI_BIDIR_POS) | (7 << 9);
/*  internal MUX setup(!) and set 8 bit transfers   */
+
+	spipnx_unselect_chip();
+}
+
+static void default_spipnx_cs (int type, void *data) {
+	switch (type) {
+		case SELECT:
+			spipnx_select_chip();
+			break;
+		case UNSELECT:
+			spipnx_unselect_chip();
+			break;
+		default:
+			break;
+	}
+}
+int spipnx_register (spi_pnx0105_algo_data_t *algo_data) {
+	int status;
+
+	if (!algo_data->sdma_mode)
+		return 0;
+
+	if (!sdma_use_count) {
+		status = sdma_request_channel (sdma_ch_name, NULL, NULL);
+		if (status < 0) {
+			printk ("No SDMA channel available\n");
+			return -EBUSY;
+		} else {
+			spi_sdma_channel = (unsigned int)status;
+			DBG ("acquired SDMA channel #%d\n",
spi_sdma_channel);
+		}
+	}
+
+	sdma_use_count++;
+	DBG("%s: sdma_use_count = %d\n", __FUNCTION__, sdma_use_count);
+
+	return 0;
+}
+
+void spipnx_unregister (spi_pnx0105_algo_data_t *algo_data) {
+	int status;
+
+	if (!algo_data->sdma_mode)
+		return;
+
+	if (sdma_use_count == 1) {
+		status = sdma_release_channel(spi_sdma_channel);
+		if (status < 0)
+			DBG ("Unable to release SDMA channel #%d\n",
spi_sdma_channel);
+	}
+
+	sdma_use_count--;
+	DBG("%s: sdma_use_count = %d\n", __FUNCTION__, sdma_use_count); }
+
+int spipnx_xfer_nonsdma (struct spi_adapter *adap, struct spi_msg 
+msgs[], int num) {
+	struct spi_msg *pmsg;
+	int i, j, bptr;
+	spinlock_t lock;
+	spi_pnx0105_algo_data_t *alg_data;
+	void (*chip_cs)(int type, void *data);
+
+	alg_data = (spi_pnx0105_algo_data_t *) adap->algo_data;
+	chip_cs = alg_data->chip_cs_callback? alg_data->chip_cs_callback :
default_spipnx_cs;
+	DBG ("Non-SDMA processing %d messages ...\n", num);
+
+	chip_cs(SELECT, alg_data->cb_data);
+	spi_regs.con |= (1 << VH_BLASSPI_CON_REG_THR_POS);
+
+	for (i=0; i<num; i++) {
+		pmsg = &msgs[i];
+		if ( pmsg->flags & SPI_M_RD ) {                      /*
here we have to read data         */
+			chip_cs(BEFORE_READ, alg_data->cb_data);
+			bptr = 0;
+			init_completion (&op_complete);
+			spi_regs.frm = 0x0000FFFF & (pmsg->len);     /*
tell the SPI how much we need     */
+			spi_regs.con &= ~VH_BLASSPI_CON_REG_RXTX_MSK;
/*  set mode to RX                    */
+			spi_regs.con |= (1 <<
VH_BLASSPI_CON_REG_SHIFT_OFF_POS);           /*  this could affect, but how?
*/
+			spi_regs.ier = (1 <<
VH_BLASSPI_IER_REG_SPI_INTEOT_POS);           /*  enable end of transfer
interrupt  */
+			spi_regs.dat = 0x00;                         /*
dummy write to start transfer     */
+			
+			while (bptr < pmsg->len) {
+				if ((pmsg->len)-bptr > FIFO_CHUNK_SIZE) {
/*  if there's data left for another  */
+					init_completion (&threshold);
/*  init wait queue for another chunk */
+					spin_lock_irq(&lock);
+					spi_regs.ier |= (1 <<
VH_BLASSPI_IER_REG_SPI_INTTHR_POS);  /*  chunk, then enable THR interrupt
*/
+					spin_unlock_irq(&lock);
+					wait_for_completion (&threshold);
+				} else
+					wait_for_completion (&op_complete);
+				for
(j=bptr;j<(((pmsg->len)-bptr<FIFO_CHUNK_SIZE)?(pmsg->len):(bptr+FIFO_CHUNK_S
IZE));j++)
+					pmsg->buf[j] = spi_regs.dat;
+				bptr += ((pmsg->len)-bptr
<FIFO_CHUNK_SIZE)?(pmsg->len - bptr):FIFO_CHUNK_SIZE;
+			}
+			DBG ("[i]:SPI_M_RD: %x\n", *pmsg->buf);
+			chip_cs(AFTER_READ, alg_data->cb_data);
+		} else {                                           /*  now
we have to transmit data        */
+			chip_cs(BEFORE_WRITE, alg_data->cb_data);
+			spi_regs.con |= (1 << VH_BLASSPI_CON_REG_RXTX_POS);
+			spi_regs.frm = 0x0000FFFF & (pmsg->len);
+			bptr = 0;
+			init_completion (&op_complete);
+			spi_regs.ier = (1 <<
VH_BLASSPI_IER_REG_SPI_INTEOT_POS);
+
+			while (bptr < pmsg->len) {
+				for
(j=bptr;j<(((pmsg->len)-bptr<FIFO_CHUNK_SIZE)?(pmsg->len):(bptr+FIFO_CHUNK_S
IZE));j++) {
+					spi_regs.dat = pmsg->buf[j];
+				}
+				if ((pmsg->len)-bptr > FIFO_CHUNK_SIZE) {
+					init_completion (&threshold);
+					spin_lock_irq(&lock);
+					spi_regs.ier |= (1 <<
VH_BLASSPI_IER_REG_SPI_INTTHR_POS);
+					spin_unlock_irq(&lock);
+					wait_for_completion (&threshold);
+				}
+				bptr += ((pmsg->len)-bptr
<FIFO_CHUNK_SIZE)?(pmsg->len - bptr):FIFO_CHUNK_SIZE;
+			}
+			wait_for_completion (&op_complete);
+			DBG ("[i]:SPI_M_WR: %x\n", *pmsg->buf);
+			chip_cs(AFTER_WRITE, alg_data->cb_data);
+		}
+	}
+	chip_cs(UNSELECT, alg_data->cb_data);
+	spi_regs.ier &= ~VH_BLASSPI_IER_REG_SPI_INTEOT_MSK;
+	
+	return num;
+}
+
+int spipnx_xfer_sdma (struct spi_adapter *adap, struct spi_msg msgs[], 
+int num) {
+	struct spi_msg *pmsg;
+	int i;
+	spi_pnx0105_algo_data_t *alg_data;
+	spi_pnx_msg_buff_t *buff;
+ 	void (*chip_cs)(int type, void *data);
+
+	alg_data = (spi_pnx0105_algo_data_t *) adap->algo_data;
+	chip_cs = alg_data->chip_cs_callback? alg_data->chip_cs_callback :
default_spipnx_cs;
+	DBG ("SDMA processing %d messages ...\n", num);
+	
+	chip_cs(SELECT, alg_data->cb_data);
+	
+	for (i=0; i<num; i++) {
+		pmsg = &msgs[i];
+		buff = (spi_pnx_msg_buff_t *) pmsg->buf;
+		DBG ("SDMA processing [%d] message ...\n", i);
+		
+		if ( pmsg->flags & SPI_M_RD ) {
+			chip_cs(BEFORE_READ, alg_data->cb_data);
+
+			init_completion (&op_complete);
+			spi_regs.con &= ~VH_BLASSPI_CON_REG_RXTX_MSK;
+			spi_regs.con |= (1 <<
VH_BLASSPI_CON_REG_SHIFT_OFF_POS);    /*  disable generating clock while
reading DAT reg  */
+			spi_regs.frm = 0x0000FFFF & (pmsg->len);
+			spi_regs.ier = (1 <<
VH_BLASSPI_IER_REG_SPI_INTEOT_POS);           /*  enable end of transfer
interrupt  */
+
+			spi_regs.dat = 0;
+			while (!(spi_regs.stat &
VH_BLASSPI_STAT_REG_SPI_THR_MSK))
+				cpu_relax();
+
+			sdma_setup.src_address      = (unsigned
int)phys_spi_data_reg;
+			sdma_setup.dest_address     = (unsigned
int)buff->dma_buffer;
+			sdma_setup.trans_length     = pmsg->len;
+			sdma_config.write_slave_nr  = MEMORY_DMA_SLAVE_NR;
+			sdma_config.read_slave_nr   = BLAS_SPI_DMA_SLAVE_NR;
+			sdma_pack_config(&sdma_config,
&sdma_setup.packed_config);
+			sdma_prog_channel (spi_sdma_channel, &sdma_setup);
+			
+			sdma_start_channel (spi_sdma_channel);
+			wait_for_completion (&op_complete);
+			sdma_stop_channel(spi_sdma_channel);
+			DBG ("[i]:SPI_M_RD: %x\n", *buff->io_buffer);
+			chip_cs(AFTER_READ, alg_data->cb_data);
+		} else {
+			chip_cs(BEFORE_WRITE, alg_data->cb_data);
+			spi_regs.con |= (1 << VH_BLASSPI_CON_REG_RXTX_POS);
+			spi_regs.frm = 0x0000FFFF & (pmsg->len);
+			spi_regs.con &= ~VH_BLASSPI_CON_REG_SHIFT_OFF_MSK;
+			
+			sdma_setup.src_address      = (unsigned
int)buff->dma_buffer;
+			sdma_setup.dest_address     = (unsigned
int)phys_spi_data_reg;
+			sdma_setup.trans_length     = pmsg->len;
+			sdma_config.write_slave_nr  = MEMORY_DMA_SLAVE_NR;
+			sdma_config.read_slave_nr   = BLAS_SPI_DMA_SLAVE_NR;
+			sdma_pack_config(&sdma_config,
&sdma_setup.packed_config);
+			sdma_prog_channel (spi_sdma_channel, &sdma_setup);
+
+			spi_regs.ier = (1 <<
VH_BLASSPI_IER_REG_SPI_INTEOT_POS);           /*  enable end of transfer
interrupt  */
+			init_completion (&op_complete);
+
+			sdma_start_channel (spi_sdma_channel);
+			wait_for_completion (&op_complete);
+			sdma_stop_channel(spi_sdma_channel);
+			DBG ("[i]:SPI_M_WR: %x\n", *buff->io_buffer);
+			chip_cs(AFTER_WRITE, alg_data->cb_data);
+		}
+	}
+	chip_cs(UNSELECT, alg_data->cb_data);
+	
+	return num;
+}
+
+int spipnx_xfer (struct spi_adapter *adap, struct spi_msg msgs[], int 
+num) {
+	int retval, i;
+	struct spi_msg *pmsg;
+	spi_pnx0105_algo_data_t *alg_data;
+
+	alg_data = (spi_pnx0105_algo_data_t *) adap->algo_data;
+	
+	DBG ("processing %d messages ...\n", num);
+	for (i=0; i<num; i++) {
+		pmsg = &msgs[i];
+		if ((pmsg->len >= 0xFFFF) || (!pmsg->buf))
+			return -EINVAL;
+		DBG ("%d) %c - %d bytes\n", i, pmsg->flags?'R':'W',
pmsg->len);
+	}
+	if (alg_data->sdma_mode) {
+		sdma_config.transfer_size     = SDMA_TRANSFER_BYTE;
+		sdma_config.invert_endian     = SDMA_INVERT_ENDIAN_NO;
+		sdma_config.companion_channel = 0;
+		sdma_config.companion_enable  = SDMA_COMPANION_DISABLE;
+		sdma_config.circular_buffer   = SDMA_CIRC_BUF_DISABLE;
+	}
+	if (alg_data->chip_cs_callback)
+		alg_data->chip_cs_callback(INIT, alg_data->cb_data);
+	else
+		spipnx_spi_init (alg_data);
+
+	if (alg_data->sdma_mode) 
+		retval = spipnx_xfer_sdma (adap, msgs, num);
+	else
+		retval = spipnx_xfer_nonsdma (adap, msgs, num);
+	return retval;
+}
+
+static void __exit spipnx_cleanup(void) {
+	free_irq(VH_INTC_INT_NUM_BLAS_SPI_INT, NULL);
+
+	printk ("SPI module for PNX0105 unloaded.\n"); }
+
+
+static int __init spipnx_init(void)
+{
+	if (request_irq(VH_INTC_INT_NUM_BLAS_SPI_INT, spipnx_interrupt,
SA_INTERRUPT, "SPI", NULL) ) {
+		DBG ("Unable to register IRQ\n");
+		return -EBUSY;
+	}
+
+	phys_spi_data_reg = &(((vhblas_spiregs *)BLAS_SPI_BASE)->dat);
+
+	memset(&sdma_config, 0, sizeof(sdma_config));
+	memset(&sdma_setup, 0, sizeof(sdma_setup));
+
+	printk ("SPI module for PNX0105 loaded.\n");
+	return 0;
+}
+
+
+EXPORT_SYMBOL(spipnx_xfer);
+EXPORT_SYMBOL(spipnx_select_chip);
+EXPORT_SYMBOL(spipnx_unselect_chip);
+EXPORT_SYMBOL(spipnx_register);
+EXPORT_SYMBOL(spipnx_unregister);
+
+
+MODULE_AUTHOR("Dennis Kovalev <dkovalev@ru.mvista.com>"); 
+MODULE_DESCRIPTION("SPI driver for PNX0105."); MODULE_LICENSE("GPL");
+
+module_init(spipnx_init);
+module_exit(spipnx_cleanup);
Index: linux-2.6.10/drivers/spi/spi-pnx010x_atmel.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/spi-pnx010x_atmel.c
@@ -0,0 +1,199 @@
+/*
+ * drivers/spi/spi-pnx010x_atmel.c
+ *
+ * Provides Atmel SPI chip support for PNX0105.
+ *
+ * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether 
+express
+ * or implied.
+ */
+
+/*  Uncomment the following line for debugging info  */
+/*
+#define SPIPNX_DEBUG
+*/
+#ifdef SPIPNX_DEBUG
+#define DEBUG 1
+#endif
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
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
+#include <asm/arch/sdma.h>
+
+#include <linux/spi/spi-pnx010x.h>
+
+
+#define DBG(args...)	pr_debug(args)
+
+static int		 mode = 0;
+static int		 sdma_mode = 0;
+static int		 spipnx_initialized;
+
+static struct spi_algorithm spipnx_algorithm = {
+	name:		ALGORITHM_NAME,
+	xfer:		spipnx_xfer,
+};
+
+static spi_pnx0105_algo_data_t spi_pnx_algo_data = {
+	cb_data:		NULL,
+	chip_cs_callback:	NULL,
+};
+
+static struct spi_adapter spipnx_adapter = {
+	name:		ADAPTER_NAME,
+	algo:		&spipnx_algorithm,
+	algo_data:	(void *) &spi_pnx_algo_data,
+	owner:		THIS_MODULE,
+	alloc:		NULL,
+	free:		NULL,
+	copy_from_user:	NULL,
+	copy_to_user:	NULL,
+};
+
+void *pnx_memory_alloc(size_t size, int base) {
+	spi_pnx_msg_buff_t *buff;
+
+	buff = (spi_pnx_msg_buff_t *) kmalloc(sizeof(spi_pnx_msg_buff_t),
base);
+	buff->size = size;
+	buff->io_buffer = dma_alloc_coherent (NULL, size, &buff->dma_buffer,

+base);
+	
+	DBG("%s:allocated memory(%x) for io_buffer = %x dma_buffer = %x\n",
+		__FUNCTION__, buff, buff->io_buffer,buff->dma_buffer );
+
+	return (void *) buff;
+}
+
+void pnx_memory_free(const void *data)
+{
+	spi_pnx_msg_buff_t *buff;
+
+	buff = (spi_pnx_msg_buff_t *) data;
+	DBG("%s:deleted memory(%x) for io_buffer = %x dma_buffer = %x\n",
+		__FUNCTION__, buff, buff->io_buffer,buff->dma_buffer );
+
+	dma_free_coherent (NULL, buff->size, buff->io_buffer,
buff->dma_buffer);
+	kfree(buff);
+}
+
+unsigned long pnx_copy_from_user(void *to, const void *from_user, 
+unsigned long len) {
+	spi_pnx_msg_buff_t *buff;
+	int ret;
+
+	buff = (spi_pnx_msg_buff_t *) to;
+	ret = copy_from_user(buff->io_buffer, from_user,len);
+
+	return ret;
+}
+
+unsigned long pnx_copy_to_user(void *to_user, const void *from, 
+unsigned long len) {
+	spi_pnx_msg_buff_t *buff;
+	int ret;
+
+	buff = (spi_pnx_msg_buff_t *) from;
+	ret = copy_to_user(to_user, buff->io_buffer, len);
+
+	return ret;
+}
+
+int spi_pnx_set_cs_callback (void (*cs_callback)(int, void*), void 
+*algo_data) {
+	spi_pnx0105_algo_data_t *alg_data;
+  
+	alg_data = (spi_pnx0105_algo_data_t *) algo_data;
+	alg_data->chip_cs_callback = cs_callback;
+
+	pr_debug ("%s: callback installed\n", __FUNCTION__);
+	return 0;
+}
+
+void spi_pnx_set_cs_callback_data (void *cb_data, void *algo_data) {
+	spi_pnx0105_algo_data_t *alg_data;
+  
+	alg_data = (spi_pnx0105_algo_data_t *) algo_data;
+	alg_data->cb_data = cb_data;
+}
+
+static int __init spi_sv_init (void)
+{
+ 	unsigned int reg;
+	int ret;
+	spipnx_initialized = 0;
+
+	if ((mode < 0) || (mode > 3)) {
+		DBG ("Warning: value of mode = %d is out of range. Mode is
set to default: mode = 0", mode);
+		spi_pnx_algo_data.mode = 0;
+	} else
+		spi_pnx_algo_data.mode = mode;
+	spi_pnx_algo_data.sdma_mode = sdma_mode;
+	
+	reg = gpio_read_reg (PADMUX1_MODE1);                    /*  Select
mode 1 on SPI_CE pin  */
+	gpio_write_reg (reg | GPIO_PIN_SPI_CE, PADMUX1_MODE1);
+	
+	if (spi_pnx_algo_data.sdma_mode) {
+		spipnx_adapter.alloc = pnx_memory_alloc;
+		spipnx_adapter.free = pnx_memory_free;
+		spipnx_adapter.copy_from_user = pnx_copy_from_user;
+		spipnx_adapter.copy_to_user = pnx_copy_to_user;
+	}
+
+	if (spi_add_adapter(&spipnx_adapter)) {
+		DBG ("adding adapter '%s' failed\n", ADAPTER_NAME);
+		return -EFAULT;
+	}
+
+	ret = spipnx_register(&spi_pnx_algo_data);
+	if (ret < 0)
+		return ret;
+
+	DBG ("Loaded spi-pnx010x.o in %s mode, MODE%d, SPI clock =
PCLK/%d\n",\
+		spi_pnx_algo_data.sdma_mode?"SMDA":"non-SDMA", 
+spi_pnx_algo_data.mode, (SPI_CLOCK+1)*2);
+
+	return 0;
+}
+
+static void __exit spi_sv_cleanup (void) {
+
+	spi_regs.global = 0L;     /* disable SPI periph   */
+
+	spipnx_unregister(&spi_pnx_algo_data);	
+	spi_del_adapter(&spipnx_adapter);
+
+	DBG ("module removed\n");
+}
+
+MODULE_AUTHOR("Dennis Kovalev <dkovalev@ru.mvista.com>"); 
+MODULE_DESCRIPTION("SPI driver high level for PNX0105."); 
+MODULE_LICENSE("GPL");
+
+
+MODULE_PARM(mode, "i");
+MODULE_PARM(sdma_mode, "i");
+module_init (spi_sv_init);
+module_exit (spi_sv_cleanup);
Index: linux-2.6.10/include/linux/spi/spi-pnx010x.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/linux/spi/spi-pnx010x.h
@@ -0,0 +1,100 @@
+/*
+ * SPI support for PNX0105.
+ *
+ * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether 
+express
+ * or implied.
+ */
+
+
+#ifndef CONFIG_ARCH_PNX010X
+#error This driver cannot be run on non-PNX0105 #endif
+
+#ifndef _SPI_PNX0105_DRIVER
+#define _SPI_PNX0105_DRIVER
+
+#include <asm/arch/platform.h>
+#include <vhal/spi_pnx0105.h>
+
+#define ADAPTER_NAME	"SWIFT SPI"
+#define ALGORITHM_NAME	"PNX0105 SPI"
+
+#define SPI_CLOCK		0x10
+#define FIFO_CHUNK_SIZE		56
+
+/*  GPIO related definitions  */
+#include <vhal/ioconf.h>
+#define PADMUX1_PINS		(IOCONF_PNX0105_PADMUX0 +
VH_IOCONF_REG_PINS)
+#define PADMUX1_MODE0		(IOCONF_PNX0105_PADMUX0 +
VH_IOCONF_REG_MODE0)
+#define PADMUX1_MODE0SET	(IOCONF_PNX0105_PADMUX0 +
VH_IOCONF_REG_MODE0_SET)
+#define PADMUX1_MODE0RESET	(IOCONF_PNX0105_PADMUX0 +
VH_IOCONF_REG_MODE0_RESET)
+#define PADMUX1_MODE1		(IOCONF_PNX0105_PADMUX0 +
VH_IOCONF_REG_MODE1)
+#define PADMUX1_MODE1SET	(IOCONF_PNX0105_PADMUX0 +
VH_IOCONF_REG_MODE1_SET)
+#define PADMUX1_MODE1RESET	(IOCONF_PNX0105_PADMUX0 +
VH_IOCONF_REG_MODE1_RESET)
+
+#define GPIO_PIN_SPI_CE
(1<<VH_IOCONF_PNX0105_PADMUX1_MSPI_CE_POS)
+#define PADMUX1_BASE_ADDR		IO_ADDRESS(IOCONF_BASE)
+
+#define GPIO_PIN_SPI_CE
(1<<VH_IOCONF_PNX0105_PADMUX1_MSPI_CE_POS)
+#define PADMUX1_BASE_ADDR		IO_ADDRESS(IOCONF_BASE)
+
+#define gpio_write_reg(val,reg)		writel (val,
PADMUX1_BASE_ADDR + reg)
+#define gpio_read_reg(reg)		readl (PADMUX1_BASE_ADDR + reg)
+
+#if 0
+typedef enum {
+	SELECT,
+	UNSELECT,
+	INIT,
+	BEFORE_READ,
+	AFTER_READ,
+	BEFORE_WRITE,
+	AFTER_WRITE,
+} spi_pnx0105_cb_type_t;
+#endif
+
+#define spi_pnx0105_cb_type_t int
+
+typedef struct {
+int		 mode;
+int		 sdma_mode;
+void		*cb_data;
+void		(*chip_cs_callback)(int, void*);
+} spi_pnx0105_algo_data_t;
+
+typedef struct {
+	char		*io_buffer;
+	dma_addr_t	dma_buffer;
+	size_t		size;
+} spi_pnx_msg_buff_t;
+
+
+#define SPI_BASE_ADDR		IO_ADDRESS(BLAS_SPI_BASE)
+
+#define spi_regs		(*((vhblas_spiregs *)SPI_BASE_ADDR))
+
+#define SPI_INTERRUPT		IRQ_SPI
+
+
+/*******************************************************************/
+/* ----- Types and defines:  -----     */
+
+#define SPI_RECEIVE                        0
+#define SPI_TRANSMIT                       1
+
+#define SPI_ENDIAN_SWAP_NO                 0
+#define SPI_ENDIAN_SWAP_YES                1
+
+extern int spi_pnx_set_cs_callback (void (*cs_callback)(int, void *), 
+void *algo_data); extern void spi_pnx_set_cs_callback_data (void 
+*cb_data, void *algo_data); extern int spipnx_xfer (struct spi_adapter 
+*adap, struct spi_msg msgs[], int num); extern int spipnx_register 
+(spi_pnx0105_algo_data_t *); extern void spipnx_unregister 
+(spi_pnx0105_algo_data_t *); extern void spipnx_select_chip (void); 
+extern void spipnx_unselect_chip (void);
+
+#endif

