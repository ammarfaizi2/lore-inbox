Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVAHIGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVAHIGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVAHIEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:04:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:20869 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261810AbVAHFr6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:58 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627742463@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:34 -0800
Message-Id: <1105162774201@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.51, 2005/01/06 15:05:54-08:00, dsaxena@plexity.net

[PATCH] Update IOP3xx I2C bus driver

The following patch is a major cleanup of the IOP3xx I2C bus driver
that is found on Intel's IOP and IXP chipsets. The existing driver in
the 2.6 tree uses hardcoded I/O addresses based on board configuration
which is just going to get ugly as more chips use this unit. The update
switches to using the driver model and passing in the I/O addresses
via platform_device resources. The patch also updates the ID name to
more closely match the actual usage of the device.

I have tested this new driver on IXP46x systems and Dave Jiang has
tested it on both IOP321 and IOP331 systems. ARM-specific patches
to provide platform-level hooks will go upstream after this patch
is integrated.

An example of using the new driver (from IXP46x ARM code) follows:

static struct resource ixp46x_i2c_resources[] = {
	[0] = {
		.start 	= 0xc8011000,
		.end	= 0xc801101c,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start 	= IRQ_IXP4XX_I2C,
		.end	= IRQ_IXP4XX_I2C,
		.flags	= IORESOURCE_IRQ
	}
};

static struct platform_device ixp46x_i2c_controller = {
	.name		= "IOP3xx-I2C",
	.id		= 0,
	.num_resources	= 2,
	.resource	= &ixp46x_i2c_resources
};

static struct platform_device *ixp46x_devices[] __initdata = {
	&ixp46x_i2c_controller
};

void __init ixp4xx_init(void)
{
	if (cpu_is_ixp46x()) {
		platform_add_devices(ixp46x_devices,
				ARRAY_SIZE(ixp46x_devices));
	}
}

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/Kconfig      |   10 
 drivers/i2c/busses/i2c-iop3xx.c |  545 ++++++++++++++++++++--------------------
 drivers/i2c/busses/i2c-iop3xx.h |  111 +++-----
 include/linux/i2c-id.h          |    4 
 4 files changed, 342 insertions(+), 328 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2005-01-07 14:54:03 -08:00
+++ b/drivers/i2c/busses/Kconfig	2005-01-07 14:54:03 -08:00
@@ -143,8 +143,14 @@
 	  will be called i2c-ibm_iic.
 
 config I2C_IOP3XX
-	tristate "Intel XScale IOP3xx on-chip I2C interface"
-	depends on ARCH_IOP3XX && I2C
+	tristate "Intel IOP3xx and IXP4xx on-chip I2C interface"
+	depends on (ARCH_IOP3XX || ARCH_IXP4XX) && I2C
+	help
+	  Say Y here if you want to use the IIC bus controller on
+	  the Intel IOP3xx I/O Processors or IXP4xx Network Processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-iop3xx.
 
 config I2C_ISA
 	tristate "ISA Bus support"
diff -Nru a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- a/drivers/i2c/busses/i2c-iop3xx.c	2005-01-07 14:54:03 -08:00
+++ b/drivers/i2c/busses/i2c-iop3xx.c	2005-01-07 14:54:03 -08:00
@@ -1,35 +1,30 @@
 /* ------------------------------------------------------------------------- */
-/* i2c-iop3xx.c i2c driver algorithms for Intel XScale IOP3xx                */
+/* i2c-iop3xx.c i2c driver algorithms for Intel XScale IOP3xx & IXP46x       */
 /* ------------------------------------------------------------------------- */
-/*   Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
- *                      <Peter dot Milne at D hyphen TACQ dot com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation, version 2.
-
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
-/* ------------------------------------------------------------------------- */
-/*
-   With acknowledgements to i2c-algo-ibm_ocp.c by 
-   Ian DaSilva, MontaVista Software, Inc. idasilva@mvista.com
-
-   And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Berglund:
-
-     Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
-   
-   And which acknowledged Kyösti Mälkki <kmalkki@cc.hut.fi>,
-   Frodo Looijaard <frodol@dds.nl>, Martin Bailey<mbailey@littlefeet-inc.com>
-
-  ---------------------------------------------------------------------------*/
+/* Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
+ *                    <Peter dot Milne at D hyphen TACQ dot com>
+ *
+ * With acknowledgements to i2c-algo-ibm_ocp.c by 
+ * Ian DaSilva, MontaVista Software, Inc. idasilva@mvista.com
+ *
+ * And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Berglund:
+ *
+ * Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
+ *  
+ * And which acknowledged Kyösti Mälkki <kmalkki@cc.hut.fi>,
+ * Frodo Looijaard <frodol@dds.nl>, Martin Bailey<mbailey@littlefeet-inc.com>
+ *
+ * Major cleanup by Deepak Saxena <dsaxena@plexity.net>, 01/2005:
+ *
+ * - Use driver model to pass per-chip info instead of hardcoding and #ifdefs
+ * - Use ioremap/__raw_readl/__raw_writel instead of direct dereference
+ * - Make it work with IXP46x chips
+ * - Cleanup function names, coding style, etc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2.
+ */
 
 #include <linux/config.h>
 #include <linux/interrupt.h>
@@ -40,24 +35,18 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include <linux/i2c.h>
 
+#include <asm/io.h>
 
-#include <asm/arch-iop3xx/iop321.h>
-#include <asm/arch-iop3xx/iop321-irqs.h>
 #include "i2c-iop3xx.h"
 
+/* global unit counter */
+static int i2c_id = 0;
 
-/* ----- global defines ----------------------------------------------- */
-#define PASSERT(x) do { if (!(x) ) \
-		printk(KERN_CRIT "PASSERT %s in %s:%d\n", #x, __FILE__, __LINE__ );\
-	} while (0)
-
-
-/* ----- global variables ---------------------------------------------	*/
-
-
-static inline unsigned char iic_cook_addr(struct i2c_msg *msg) 
+static inline unsigned char 
+iic_cook_addr(struct i2c_msg *msg) 
 {
 	unsigned char addr;
 
@@ -66,103 +55,110 @@
 	if (msg->flags & I2C_M_RD)
 		addr |= 1;
 
-	/* PGM: what is M_REV_DIR_ADDR - do we need it ?? */
+	/*
+	 * Read or Write?
+	 */
 	if (msg->flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 
 	return addr;   
 }
 
-
-static inline void iop3xx_adap_reset(struct i2c_algo_iop3xx_data *iop3xx_adap)
+static void 
+iop3xx_i2c_reset(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	/* Follows devman 9.3 */
-	*iop3xx_adap->biu->CR = IOP321_ICR_UNIT_RESET;
-	*iop3xx_adap->biu->SR = IOP321_ISR_CLEARBITS;
-	*iop3xx_adap->biu->CR = 0;
+	__raw_writel(IOP3XX_ICR_UNIT_RESET, iop3xx_adap->ioaddr + CR_OFFSET);
+	__raw_writel(IOP3XX_ISR_CLEARBITS, iop3xx_adap->ioaddr + SR_OFFSET);
+	__raw_writel(0, iop3xx_adap->ioaddr + CR_OFFSET);
 } 
 
-static inline void iop3xx_adap_set_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap)
+static void 
+iop3xx_i2c_set_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
-	*iop3xx_adap->biu->SAR = MYSAR;
+	__raw_writel(MYSAR, iop3xx_adap->ioaddr + SAR_OFFSET);
 }
 
-static inline void iop3xx_adap_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
+static void 
+iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
-	u32 cr = IOP321_ICR_GCD|IOP321_ICR_SCLEN|IOP321_ICR_UE;
+	u32 cr = IOP3XX_ICR_GCD | IOP3XX_ICR_SCLEN | IOP3XX_ICR_UE;
 
+	/* 
+	 * Everytime unit enable is asserted, GPOD needs to be cleared
+	 * on IOP321 to avoid data corruption on the bus.
+	 */
+#ifdef CONFIG_ARCH_IOP321
+#define IOP321_GPOD_I2C0    0x00c0  /* clear these bits to enable ch0 */
+#define IOP321_GPOD_I2C1    0x0030  /* clear these bits to enable ch1 */
+
+	*IOP321_GPOD &= (iop3xx_adap->id == 0) ? ~IOP321_GPOD_I2C0 : 
+		~IOP321_GPOD_I2C1;
+#endif
 	/* NB SR bits not same position as CR IE bits :-( */
-	iop3xx_adap->biu->SR_enabled = 
-		IOP321_ISR_ALD | IOP321_ISR_BERRD |
-		IOP321_ISR_RXFULL | IOP321_ISR_TXEMPTY;
+	iop3xx_adap->SR_enabled = 
+		IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD |
+		IOP3XX_ISR_RXFULL | IOP3XX_ISR_TXEMPTY;
 
-	cr |= IOP321_ICR_ALDIE | IOP321_ICR_BERRIE |
-		IOP321_ICR_RXFULLIE | IOP321_ICR_TXEMPTYIE;
+	cr |= IOP3XX_ICR_ALD_IE | IOP3XX_ICR_BERR_IE |
+		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE;
 
-	*iop3xx_adap->biu->CR = cr;
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
 
-static void iop3xx_adap_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
+static void 
+iop3xx_i2c_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
-	unsigned cr = *iop3xx_adap->biu->CR;
+	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
 	
-	cr &= ~(IOP321_ICR_MSTART | IOP321_ICR_TBYTE | 
-		IOP321_ICR_MSTOP | IOP321_ICR_SCLEN);
-	*iop3xx_adap->biu->CR = cr;
-}
+	cr &= ~(IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE | 
+		IOP3XX_ICR_MSTOP | IOP3XX_ICR_SCLEN);
 
-static void iop3xx_adap_final_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	unsigned cr = *iop3xx_adap->biu->CR;
-	
-	cr &= ~(IOP321_ICR_ALDIE | IOP321_ICR_BERRIE |
-		IOP321_ICR_RXFULLIE | IOP321_ICR_TXEMPTYIE);
-	iop3xx_adap->biu->SR_enabled = 0;
-	*iop3xx_adap->biu->CR = cr;
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
 
 /* 
  * NB: the handler has to clear the source of the interrupt! 
  * Then it passes the SR flags of interest to BH via adap data
  */
-static irqreturn_t iop3xx_i2c_handler(int this_irq, 
-				void *dev_id, 
-				struct pt_regs *regs) 
+static irqreturn_t 
+iop3xx_i2c_irq_handler(int this_irq, void *dev_id, struct pt_regs *regs) 
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = dev_id;
+	u32 sr = __raw_readl(iop3xx_adap->ioaddr + SR_OFFSET);
 
-	u32 sr = *iop3xx_adap->biu->SR;
-
-	if ((sr &= iop3xx_adap->biu->SR_enabled)) {
-		*iop3xx_adap->biu->SR = sr;
-		iop3xx_adap->biu->SR_received |= sr;
+	if ((sr &= iop3xx_adap->SR_enabled)) {
+		__raw_writel(sr, iop3xx_adap->ioaddr + SR_OFFSET);
+		iop3xx_adap->SR_received |= sr;
 		wake_up_interruptible(&iop3xx_adap->waitq);
 	}
 	return IRQ_HANDLED;
 }
 
 /* check all error conditions, clear them , report most important */
-static int iop3xx_adap_error(u32 sr)
+static int 
+iop3xx_i2c_error(u32 sr)
 {
 	int rc = 0;
 
-	if ((sr&IOP321_ISR_BERRD)) {
+	if ((sr & IOP3XX_ISR_BERRD)) {
 		if ( !rc ) rc = -I2C_ERR_BERR;
 	}
-	if ((sr&IOP321_ISR_ALD)) {
+	if ((sr & IOP3XX_ISR_ALD)) {
 		if ( !rc ) rc = -I2C_ERR_ALD;		
 	}
 	return rc;	
 }
 
-static inline u32 get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
+static inline u32 
+iop3xx_i2c_get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	unsigned long flags;
 	u32 sr;
 
 	spin_lock_irqsave(&iop3xx_adap->lock, flags);
-	sr = iop3xx_adap->biu->SR_received;
-	iop3xx_adap->biu->SR_received = 0;
+	sr = iop3xx_adap->SR_received;
+	iop3xx_adap->SR_received = 0;
 	spin_unlock_irqrestore(&iop3xx_adap->lock, flags);
 
 	return sr;
@@ -175,9 +171,10 @@
 typedef int (* compare_func)(unsigned test, unsigned mask);
 /* returns 1 on correct comparison */
 
-static int iop3xx_adap_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap, 
-				  unsigned flags, unsigned* status,
-				  compare_func compare)
+static int 
+iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap, 
+			  unsigned flags, unsigned* status,
+			  compare_func compare)
 {
 	unsigned sr = 0;
 	int interrupted;
@@ -187,13 +184,13 @@
 	do {
 		interrupted = wait_event_interruptible_timeout (
 			iop3xx_adap->waitq,
-			(done = compare( sr = get_srstat(iop3xx_adap),flags )),
-			iop3xx_adap->timeout
+			(done = compare( sr = iop3xx_i2c_get_srstat(iop3xx_adap)					,flags )),
+			1 * HZ;
 			);
-		if ((rc = iop3xx_adap_error(sr)) < 0) {
+		if ((rc = iop3xx_i2c_error(sr)) < 0) {
 			*status = sr;
 			return rc;
-		}else if (!interrupted) {
+		} else if (!interrupted) {
 			*status = sr;
 			return -ETIMEDOUT;
 		}
@@ -207,141 +204,131 @@
 /*
  * Concrete compare_funcs 
  */
-static int all_bits_clear(unsigned test, unsigned mask)
+static int 
+all_bits_clear(unsigned test, unsigned mask)
 {
 	return (test & mask) == 0;
 }
-static int any_bits_set(unsigned test, unsigned mask)
+
+static int 
+any_bits_set(unsigned test, unsigned mask)
 {
 	return (test & mask) != 0;
 }
 
-static int iop3xx_adap_wait_tx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
+static int 
+iop3xx_i2c_wait_tx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
 {
-	return iop3xx_adap_wait_event( 
+	return iop3xx_i2c_wait_event( 
 		iop3xx_adap, 
-	        IOP321_ISR_TXEMPTY|IOP321_ISR_ALD|IOP321_ISR_BERRD,
+	        IOP3XX_ISR_TXEMPTY | IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD,
 		status, any_bits_set);
 }
 
-static int iop3xx_adap_wait_rx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
+static int 
+iop3xx_i2c_wait_rx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
 {
-	return iop3xx_adap_wait_event( 
+	return iop3xx_i2c_wait_event( 
 		iop3xx_adap, 
-		IOP321_ISR_RXFULL|IOP321_ISR_ALD|IOP321_ISR_BERRD,
+		IOP3XX_ISR_RXFULL | IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD,
 		status,	any_bits_set);
 }
 
-static int iop3xx_adap_wait_idle(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
-{
-	return iop3xx_adap_wait_event( 
-		iop3xx_adap, IOP321_ISR_UNITBUSY, status, all_bits_clear);
-}
-
-/*
- * Description: This performs the IOP3xx initialization sequence
- * Valid for IOP321. Maybe valid for IOP310?.
- */
-static int iop3xx_adap_init (struct i2c_algo_iop3xx_data *iop3xx_adap)
+static int 
+iop3xx_i2c_wait_idle(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
 {
-	*IOP321_GPOD &= ~(iop3xx_adap->channel==0 ?
-			  IOP321_GPOD_I2C0:
-			  IOP321_GPOD_I2C1);
-
-	iop3xx_adap_reset(iop3xx_adap);
-	iop3xx_adap_set_slave_addr(iop3xx_adap);
-	iop3xx_adap_enable(iop3xx_adap);
-	
-        return 0;
+	return iop3xx_i2c_wait_event( 
+		iop3xx_adap, IOP3XX_ISR_UNITBUSY, status, all_bits_clear);
 }
 
-static int iop3xx_adap_send_target_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
-					      struct i2c_msg* msg)
+static int 
+iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap, 
+				struct i2c_msg* msg)
 {
-	unsigned cr = *iop3xx_adap->biu->CR;
+	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
 	int status;
 	int rc;
 
-	*iop3xx_adap->biu->DBR = iic_cook_addr(msg);
+	__raw_writel(iic_cook_addr(msg), iop3xx_adap->ioaddr + DBR_OFFSET);
 	
-	cr &= ~(IOP321_ICR_MSTOP | IOP321_ICR_NACK);
-	cr |= IOP321_ICR_MSTART | IOP321_ICR_TBYTE;
+	cr &= ~(IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK);
+	cr |= IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE;
+
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
+	rc = iop3xx_i2c_wait_tx_done(iop3xx_adap, &status);
 
-	*iop3xx_adap->biu->CR = cr;
-	rc = iop3xx_adap_wait_tx_done(iop3xx_adap, &status);
-	/* this assert fires every time, contrary to IOP manual	
-	PASSERT((status&IOP321_ISR_UNITBUSY)!=0);
-	*/
-	PASSERT((status&IOP321_ISR_RXREAD)==0);
-	     
 	return rc;
 }
 
-static int iop3xx_adap_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char byte, int stop)
+static int 
+iop3xx_i2c_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char byte, 
+				int stop)
 {
-	unsigned cr = *iop3xx_adap->biu->CR;
+	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
 	int status;
 	int rc = 0;
 
-	*iop3xx_adap->biu->DBR = byte;
-	cr &= ~IOP321_ICR_MSTART;
+	__raw_writel(byte, iop3xx_adap->ioaddr + DBR_OFFSET);
+	cr &= ~IOP3XX_ICR_MSTART;
 	if (stop) {
-		cr |= IOP321_ICR_MSTOP;
+		cr |= IOP3XX_ICR_MSTOP;
 	} else {
-		cr &= ~IOP321_ICR_MSTOP;
+		cr &= ~IOP3XX_ICR_MSTOP;
 	}
-	*iop3xx_adap->biu->CR = cr |= IOP321_ICR_TBYTE;
-	rc = iop3xx_adap_wait_tx_done(iop3xx_adap, &status);
+	cr |= IOP3XX_ICR_TBYTE;
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
+	rc = iop3xx_i2c_wait_tx_done(iop3xx_adap, &status);
 
 	return rc;
 } 
 
-static int iop3xx_adap_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap,
-				 char* byte, int stop)
+static int 
+iop3xx_i2c_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char* byte, 
+				int stop)
 {
-	unsigned cr = *iop3xx_adap->biu->CR;
+	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
 	int status;
 	int rc = 0;
 
-	cr &= ~IOP321_ICR_MSTART;
+	cr &= ~IOP3XX_ICR_MSTART;
 
 	if (stop) {
-		cr |= IOP321_ICR_MSTOP|IOP321_ICR_NACK;
+		cr |= IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK;
 	} else {
-		cr &= ~(IOP321_ICR_MSTOP|IOP321_ICR_NACK);
+		cr &= ~(IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK);
 	}
-	*iop3xx_adap->biu->CR = cr |= IOP321_ICR_TBYTE;
+	cr |= IOP3XX_ICR_TBYTE;
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 
-	rc = iop3xx_adap_wait_rx_done(iop3xx_adap, &status);
+	rc = iop3xx_i2c_wait_rx_done(iop3xx_adap, &status);
 
-	*byte = *iop3xx_adap->biu->DBR;
+	*byte = __raw_readl(iop3xx_adap->ioaddr + DBR_OFFSET);
 
 	return rc;
 }
 
-static int iop3xx_i2c_writebytes(struct i2c_adapter *i2c_adap, 
-				 const char *buf, int count)
+static int 
+iop3xx_i2c_writebytes(struct i2c_adapter *i2c_adap, const char *buf, int count)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
 	int ii;
 	int rc = 0;
 
-	for (ii = 0; rc == 0 && ii != count; ++ii) {
-		rc = iop3xx_adap_write_byte(iop3xx_adap, buf[ii], ii==count-1);
-	}
+	for (ii = 0; rc == 0 && ii != count; ++ii) 
+		rc = iop3xx_i2c_write_byte(iop3xx_adap, buf[ii], ii==count-1);
 	return rc;
 }
 
-static int iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, 
-				char *buf, int count)
+static int 
+iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
 	int ii;
 	int rc = 0;
 
-	for (ii = 0; rc == 0 && ii != count; ++ii) {
-		rc = iop3xx_adap_read_byte(iop3xx_adap, &buf[ii], ii==count-1);
-	}
+	for (ii = 0; rc == 0 && ii != count; ++ii)
+		rc = iop3xx_i2c_read_byte(iop3xx_adap, &buf[ii], ii==count-1);
+	
 	return rc;
 }
 
@@ -352,12 +339,13 @@
  * Each transfer (i.e. a read or a write) is separated by a repeated start
  * condition.
  */
-static int iop3xx_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg) 
+static int 
+iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg) 
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
 	int rc;
 
-	rc = iop3xx_adap_send_target_slave_addr(iop3xx_adap, pmsg);
+	rc = iop3xx_i2c_send_target_addr(iop3xx_adap, pmsg);
 	if (rc < 0) {
 		return rc;
 	}
@@ -372,22 +360,24 @@
 /*
  * master_xfer() - main read/write entry
  */
-static int iop3xx_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+static int 
+iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], 
+				int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
 	int im = 0;
 	int ret = 0;
 	int status;
 
-	iop3xx_adap_wait_idle(iop3xx_adap, &status);
-	iop3xx_adap_reset(iop3xx_adap);
-	iop3xx_adap_enable(iop3xx_adap);
+	iop3xx_i2c_wait_idle(iop3xx_adap, &status);
+	iop3xx_i2c_reset(iop3xx_adap);
+	iop3xx_i2c_enable(iop3xx_adap);
 
 	for (im = 0; ret == 0 && im != num; im++) {
-		ret = iop3xx_handle_msg(i2c_adap, &msgs[im]);
+		ret = iop3xx_i2c_handle_msg(i2c_adap, &msgs[im]);
 	}
 
-	iop3xx_adap_transaction_cleanup(iop3xx_adap);
+	iop3xx_i2c_transaction_cleanup(iop3xx_adap);
 	
 	if(ret)
 		return ret;
@@ -395,136 +385,165 @@
 	return im;   
 }
 
-static int algo_control(struct i2c_adapter *adapter, unsigned int cmd,
+static int 
+iop3xx_i2c_algo_control(struct i2c_adapter *adapter, unsigned int cmd,
 			unsigned long arg)
 {
 	return 0;
 }
 
-static u32 iic_func(struct i2c_adapter *adap)
+static u32 
+iop3xx_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static struct i2c_algorithm iic_algo = {
+static struct i2c_algorithm iop3xx_i2c_algo = {
 	.name		= "IOP3xx I2C algorithm",
-	.id		= I2C_ALGO_OCP_IOP3XX,
-	.master_xfer	= iop3xx_master_xfer,
-	.algo_control	= algo_control,
-	.functionality	= iic_func,
+	.id		= I2C_ALGO_IOP3XX,
+	.master_xfer	= iop3xx_i2c_master_xfer,
+	.algo_control	= iop3xx_i2c_algo_control,
+	.functionality	= iop3xx_i2c_func,
 };
 
-/* 
- * registering functions to load algorithms at runtime 
- */
-static int i2c_iop3xx_add_bus(struct i2c_adapter *iic_adap)
+static int 
+iop3xx_i2c_remove(struct device *device)
+{
+	struct platform_device *pdev = to_platform_device(device);
+	struct i2c_adapter *padapter = dev_get_drvdata(&pdev->dev);
+	struct i2c_algo_iop3xx_data *adapter_data = 
+		(struct i2c_algo_iop3xx_data *)padapter->algo_data;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	unsigned long cr = __raw_readl(adapter_data->ioaddr + CR_OFFSET);
+
+	/*
+	 * Disable the actual HW unit
+	 */
+	cr &= ~(IOP3XX_ICR_ALD_IE | IOP3XX_ICR_BERR_IE |
+		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE);
+	__raw_writel(cr, adapter_data->ioaddr + CR_OFFSET);
+
+	iounmap((void __iomem*)adapter_data->ioaddr);
+	release_mem_region(res->start, IOP3XX_I2C_IO_SIZE);
+	kfree(adapter_data);
+	kfree(padapter);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	return 0;
+}
+
+static int 
+iop3xx_i2c_probe(struct device *dev)
 {
-	struct i2c_algo_iop3xx_data *iop3xx_adap = iic_adap->algo_data;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	int ret;
+	struct i2c_adapter *new_adapter;
+	struct i2c_algo_iop3xx_data *adapter_data;
 
-	if (!request_region( REGION_START(iop3xx_adap), 
-			      REGION_LENGTH(iop3xx_adap),
-			      iic_adap->name)) {
-		return -ENODEV;
+	new_adapter = kmalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (!new_adapter) {
+		ret = -ENOMEM;
+		goto out;
 	}
+	memset((void*)new_adapter, 0, sizeof(*new_adapter));
 
-	init_waitqueue_head(&iop3xx_adap->waitq);
-	spin_lock_init(&iop3xx_adap->lock);
+	adapter_data = kmalloc(sizeof(struct i2c_algo_iop3xx_data), GFP_KERNEL);
+	if (!adapter_data) {
+		ret = -ENOMEM;
+		goto free_adapter;
+	}
+	memset((void*)adapter_data, 0, sizeof(*adapter_data));
 
-	if (request_irq( 
-		     iop3xx_adap->biu->irq,
-		     iop3xx_i2c_handler,
-		     /* SA_SAMPLE_RANDOM */ 0,
-		     iic_adap->name,
-		     iop3xx_adap)) {
-		return -ENODEV;
-	}			  
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto free_both;
+	}
 
-	/* register new iic_adapter to i2c module... */
-	iic_adap->id |= iic_algo.id;
-	iic_adap->algo = &iic_algo;
+	if (!request_mem_region(res->start, IOP3XX_I2C_IO_SIZE, pdev->name)) {
+		ret = -EBUSY;
+		goto free_both;
+	}
 
-	iic_adap->timeout = 100;	/* default values, should */
-	iic_adap->retries = 3;		/* be replaced by defines */
+	/* set the adapter enumeration # */
+	adapter_data->id = i2c_id++;
 
-	iop3xx_adap_init(iic_adap->algo_data);
-	i2c_add_adapter(iic_adap);
-	return 0;
-}
+	adapter_data->ioaddr = (u32)ioremap(res->start, IOP3XX_I2C_IO_SIZE);
+	if (!adapter_data->ioaddr) {
+		ret = -ENOMEM;
+		goto release_region;
+	}
 
-static int i2c_iop3xx_del_bus(struct i2c_adapter *iic_adap)
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap = iic_adap->algo_data;
+	res = request_irq(platform_get_irq(pdev, 0), iop3xx_i2c_irq_handler, 0, 
+				pdev->name, adapter_data);
+	if (res) {
+		ret = -EIO;
+		goto unmap;
+	}
 
-	iop3xx_adap_final_cleanup(iop3xx_adap);
-	free_irq(iop3xx_adap->biu->irq, iop3xx_adap);
+	memcpy(new_adapter->name, pdev->name, strlen(pdev->name));
+	new_adapter->id = I2C_HW_IOP3XX;
+	new_adapter->owner = THIS_MODULE;
+	new_adapter->dev.parent = &pdev->dev;
 
-	release_region(REGION_START(iop3xx_adap), REGION_LENGTH(iop3xx_adap));
+	/*
+	 * Default values...should these come in from board code?
+	 */
+	new_adapter->timeout = 100;	
+	new_adapter->retries = 3;
+	new_adapter->algo = &iop3xx_i2c_algo;
 
-	return i2c_del_adapter(iic_adap);
-}
+	init_waitqueue_head(&adapter_data->waitq);
+	spin_lock_init(&adapter_data->lock);
 
-#ifdef CONFIG_ARCH_IOP321
+	iop3xx_i2c_reset(adapter_data);
+	iop3xx_i2c_set_slave_addr(adapter_data);
+	iop3xx_i2c_enable(adapter_data);
 
-static struct iop3xx_biu biu0 = {
-	.CR	= IOP321_ICR0,
-	.SR	= IOP321_ISR0,
-	.SAR	= IOP321_ISAR0,
-	.DBR	= IOP321_IDBR0,
-	.BMR	= IOP321_IBMR0,
-	.irq	= IRQ_IOP321_I2C_0,
-};
+	dev_set_drvdata(&pdev->dev, new_adapter);
+	new_adapter->algo_data = adapter_data;
 
-static struct iop3xx_biu biu1 = {
-	.CR	= IOP321_ICR1,
-	.SR	= IOP321_ISR1,
-	.SAR	= IOP321_ISAR1,
-	.DBR	= IOP321_IDBR1,
-	.BMR	= IOP321_IBMR1,
-	.irq	= IRQ_IOP321_I2C_1,
-};
+	i2c_add_adapter(new_adapter);
 
-#define ADAPTER_NAME_ROOT "IOP321 i2c biu adapter "
-#else
-#error Please define the BIU struct iop3xx_biu for your processor arch
-#endif
+	return 0;
 
-static struct i2c_algo_iop3xx_data algo_iop3xx_data0 = {
-	.channel		= 0,
-	.biu			= &biu0,
-	.timeout		= 1*HZ,
-};
-static struct i2c_algo_iop3xx_data algo_iop3xx_data1 = {
-	.channel		= 1,
-	.biu			= &biu1,
-	.timeout		= 1*HZ,
-};
+unmap:
+	iounmap((void __iomem*)adapter_data->ioaddr);
 
-static struct i2c_adapter iop3xx_ops0 = {
-	.owner			= THIS_MODULE,
-	.name			= ADAPTER_NAME_ROOT "0",
-	.id			= I2C_HW_IOP321,
-	.algo_data		= &algo_iop3xx_data0,
-};
-static struct i2c_adapter iop3xx_ops1 = {
-	.owner			= THIS_MODULE,
-	.name			= ADAPTER_NAME_ROOT "1",
-	.id			= I2C_HW_IOP321,
-	.algo_data		= &algo_iop3xx_data1,
+release_region:
+	release_mem_region(res->start, IOP3XX_I2C_IO_SIZE);
+
+free_both:
+	kfree(adapter_data);
+
+free_adapter:
+	kfree(new_adapter);
+
+out:
+	return ret;
+}
+
+
+static struct device_driver iop3xx_i2c_driver = {
+	.name		= "IOP3xx-I2C",
+	.bus		= &platform_bus_type,
+	.probe		= iop3xx_i2c_probe,
+	.remove		= iop3xx_i2c_remove
 };
 
-static int __init i2c_iop3xx_init (void)
+static int __init 
+i2c_iop3xx_init (void)
 {
-	return i2c_iop3xx_add_bus(&iop3xx_ops0) ||
-		i2c_iop3xx_add_bus(&iop3xx_ops1);
+	return driver_register(&iop3xx_i2c_driver);
 }
 
-static void __exit i2c_iop3xx_exit (void)
+static void __exit 
+i2c_iop3xx_exit (void)
 {
-	i2c_iop3xx_del_bus(&iop3xx_ops0);
-	i2c_iop3xx_del_bus(&iop3xx_ops1);
+	driver_unregister(&iop3xx_i2c_driver);
+	return;
 }
 
 module_init (i2c_iop3xx_init);
diff -Nru a/drivers/i2c/busses/i2c-iop3xx.h b/drivers/i2c/busses/i2c-iop3xx.h
--- a/drivers/i2c/busses/i2c-iop3xx.h	2005-01-07 14:54:03 -08:00
+++ b/drivers/i2c/busses/i2c-iop3xx.h	2005-01-07 14:54:03 -08:00
@@ -25,20 +25,20 @@
 /*
  * iop321 hardware bit definitions
  */
-#define IOP321_ICR_FAST_MODE	0x8000	/* 1=400kBps, 0=100kBps */
-#define IOP321_ICR_UNIT_RESET	0x4000	/* 1=RESET */
-#define IOP321_ICR_SADIE	0x2000	/* 1=Slave Detect Interrupt Enable */
-#define IOP321_ICR_ALDIE	0x1000	/* 1=Arb Loss Detect Interrupt Enable */
-#define IOP321_ICR_SSDIE	0x0800	/* 1=Slave STOP Detect Interrupt Enable */
-#define IOP321_ICR_BERRIE	0x0400	/* 1=Bus Error Interrupt Enable */
-#define IOP321_ICR_RXFULLIE	0x0200	/* 1=Receive Full Interrupt Enable */
-#define IOP321_ICR_TXEMPTYIE	0x0100	/* 1=Transmit Empty Interrupt Enable */
-#define IOP321_ICR_GCD		0x0080	/* 1=General Call Disable */
+#define IOP3XX_ICR_FAST_MODE	0x8000	/* 1=400kBps, 0=100kBps */
+#define IOP3XX_ICR_UNIT_RESET	0x4000	/* 1=RESET */
+#define IOP3XX_ICR_SAD_IE	0x2000	/* 1=Slave Detect Interrupt Enable */
+#define IOP3XX_ICR_ALD_IE	0x1000	/* 1=Arb Loss Detect Interrupt Enable */
+#define IOP3XX_ICR_SSD_IE	0x0800	/* 1=Slave STOP Detect Interrupt Enable */
+#define IOP3XX_ICR_BERR_IE	0x0400	/* 1=Bus Error Interrupt Enable */
+#define IOP3XX_ICR_RXFULL_IE	0x0200	/* 1=Receive Full Interrupt Enable */
+#define IOP3XX_ICR_TXEMPTY_IE	0x0100	/* 1=Transmit Empty Interrupt Enable */
+#define IOP3XX_ICR_GCD		0x0080	/* 1=General Call Disable */
 /*
- * IOP321_ICR_GCD: 1 disables response as slave. "This bit must be set
+ * IOP3XX_ICR_GCD: 1 disables response as slave. "This bit must be set
  * when sending a master mode general call message from the I2C unit"
  */
-#define IOP321_ICR_UE		0x0040	/* 1=Unit Enable */
+#define IOP3XX_ICR_UE		0x0040	/* 1=Unit Enable */
 /*
  * "NOTE: To avoid I2C bus integrity problems, 
  * the user needs to ensure that the GPIO Output Data Register - 
@@ -47,38 +47,38 @@
  * The user prepares to enable I2C port 0 and 
  * I2C port 1 by clearing GPOD bits 7:6 and GPOD bits 5:4, respectively.
  */
-#define IOP321_ICR_SCLEN	0x0020	/* 1=SCL enable for master mode */
-#define IOP321_ICR_MABORT	0x0010	/* 1=Send a STOP with no data 
+#define IOP3XX_ICR_SCLEN	0x0020	/* 1=SCL enable for master mode */
+#define IOP3XX_ICR_MABORT	0x0010	/* 1=Send a STOP with no data 
 					 * NB TBYTE must be clear */
-#define IOP321_ICR_TBYTE	0x0008	/* 1=Send/Receive a byte. i2c clears */
-#define IOP321_ICR_NACK		0x0004	/* 1=reply with NACK */
-#define IOP321_ICR_MSTOP	0x0002	/* 1=send a STOP after next data byte */
-#define IOP321_ICR_MSTART	0x0001	/* 1=initiate a START */
-
-
-#define IOP321_ISR_BERRD	0x0400	/* 1=BUS ERROR Detected */
-#define IOP321_ISR_SAD		0x0200	/* 1=Slave ADdress Detected */
-#define IOP321_ISR_GCAD		0x0100	/* 1=General Call Address Detected */
-#define IOP321_ISR_RXFULL	0x0080	/* 1=Receive Full */
-#define IOP321_ISR_TXEMPTY	0x0040	/* 1=Transmit Empty */
-#define IOP321_ISR_ALD		0x0020	/* 1=Arbitration Loss Detected */
-#define IOP321_ISR_SSD		0x0010	/* 1=Slave STOP Detected */
-#define IOP321_ISR_BBUSY	0x0008	/* 1=Bus BUSY */
-#define IOP321_ISR_UNITBUSY	0x0004	/* 1=Unit Busy */
-#define IOP321_ISR_NACK		0x0002	/* 1=Unit Rx or Tx a NACK */
-#define IOP321_ISR_RXREAD	0x0001	/* 1=READ 0=WRITE (R/W bit of slave addr */
-
-#define IOP321_ISR_CLEARBITS	0x07f0
-
-#define IOP321_ISAR_SAMASK	0x007f
+#define IOP3XX_ICR_TBYTE	0x0008	/* 1=Send/Receive a byte. i2c clears */
+#define IOP3XX_ICR_NACK		0x0004	/* 1=reply with NACK */
+#define IOP3XX_ICR_MSTOP	0x0002	/* 1=send a STOP after next data byte */
+#define IOP3XX_ICR_MSTART	0x0001	/* 1=initiate a START */
+
+
+#define IOP3XX_ISR_BERRD	0x0400	/* 1=BUS ERROR Detected */
+#define IOP3XX_ISR_SAD		0x0200	/* 1=Slave ADdress Detected */
+#define IOP3XX_ISR_GCAD		0x0100	/* 1=General Call Address Detected */
+#define IOP3XX_ISR_RXFULL	0x0080	/* 1=Receive Full */
+#define IOP3XX_ISR_TXEMPTY	0x0040	/* 1=Transmit Empty */
+#define IOP3XX_ISR_ALD		0x0020	/* 1=Arbitration Loss Detected */
+#define IOP3XX_ISR_SSD		0x0010	/* 1=Slave STOP Detected */
+#define IOP3XX_ISR_BBUSY	0x0008	/* 1=Bus BUSY */
+#define IOP3XX_ISR_UNITBUSY	0x0004	/* 1=Unit Busy */
+#define IOP3XX_ISR_NACK		0x0002	/* 1=Unit Rx or Tx a NACK */
+#define IOP3XX_ISR_RXREAD	0x0001	/* 1=READ 0=WRITE (R/W bit of slave addr */
+
+#define IOP3XX_ISR_CLEARBITS	0x07f0
+
+#define IOP3XX_ISAR_SAMASK	0x007f
 
-#define IOP321_IDBR_MASK	0x00ff
+#define IOP3XX_IDBR_MASK	0x00ff
 
-#define IOP321_IBMR_SCL		0x0002
-#define IOP321_IBMR_SDA		0x0001
+#define IOP3XX_IBMR_SCL		0x0002
+#define IOP3XX_IBMR_SDA		0x0001
 
-#define IOP321_GPOD_I2C0	0x00c0	/* clear these bits to enable ch0 */
-#define IOP321_GPOD_I2C1	0x0030	/* clear these bits to enable ch1 */
+#define IOP3XX_GPOD_I2C0	0x00c0	/* clear these bits to enable ch0 */
+#define IOP3XX_GPOD_I2C1	0x0030	/* clear these bits to enable ch1 */
 
 #define MYSAR			0x02	/* SWAG a suitable slave address */
 
@@ -87,32 +87,21 @@
 #define I2C_ERR_ALD		(I2C_ERR+1)
 
 
-struct iop3xx_biu {                /* Bus Interface Unit - the hardware */
-/* physical hardware defs - regs*/
-	u32 *CR;
-	u32 *SR;
-	u32 *SAR;
-	u32 *DBR;
-	u32 *BMR;
-/* irq bit vector */
-	u32 irq;
-/* stored flags */
-	u32 SR_enabled, SR_received;
-};
+#define	CR_OFFSET		0
+#define	SR_OFFSET		0x4
+#define	SAR_OFFSET		0x8
+#define	DBR_OFFSET		0xc
+#define	CCR_OFFSET		0x10
+#define	BMR_OFFSET		0x14
 
-struct i2c_algo_iop3xx_data {
-	int channel;
+#define	IOP3XX_I2C_IO_SIZE	0x18
 
+struct i2c_algo_iop3xx_data {
+	u32 ioaddr;
 	wait_queue_head_t waitq;
 	spinlock_t lock;
-	int timeout;
-	struct iop3xx_biu* biu;
+	u32 SR_enabled, SR_received;
+	int id;
 };
-
-#define REGION_START(adap)	((u32)((adap)->biu->CR))
-#define REGION_END(adap)	((u32)((adap)->biu->BMR+1))
-#define REGION_LENGTH(adap)	(REGION_END(adap)-REGION_START(adap))
-
-#define IRQ_STATUS_MASK(adap)	(1<<adap->biu->irq)
 
 #endif /* I2C_IOP3XX_H */
diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	2005-01-07 14:54:03 -08:00
+++ b/include/linux/i2c-id.h	2005-01-07 14:54:03 -08:00
@@ -194,7 +194,7 @@
 #define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
 #define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm */
 #define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
-#define I2C_ALGO_OCP_IOP3XX  0x140000	/* XSCALE IOP3XX On-chip I2C alg */
+#define I2C_ALGO_IOP3XX	0x140000	/* XSCALE IOP3XX On-chip I2C alg */
 #define I2C_ALGO_PCA	0x150000	/* PCA 9564 style adapters	*/
 
 #define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
@@ -270,7 +270,7 @@
 #define I2C_HW_SGI_MACE	0x01
 
 /* --- XSCALE on-chip adapters                          */
-#define I2C_HW_IOP321 0x00
+#define I2C_HW_IOP3XX 0x00
 
 /* --- SMBus only adapters						*/
 #define I2C_HW_SMBUS_PIIX4	0x00

