Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWGAPFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWGAPFd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWGAPEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:04:22 -0400
Received: from www.osadl.org ([213.239.205.134]:2981 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751634AbWGAO5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:38 -0400
Message-Id: <20060701145227.896790000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:07 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, rmk+serial@arm.linux.org.uk
Subject: [RFC][patch 40/44] serial: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-serial.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/serial/8250.c           |    4 ++--
 drivers/serial/at91_serial.c    |    2 +-
 drivers/serial/crisv10.c        |   22 +++++++++++-----------
 drivers/serial/dz.c             |    2 +-
 drivers/serial/icom.c           |    2 +-
 drivers/serial/imx.c            |    2 +-
 drivers/serial/ioc4_serial.c    |    2 +-
 drivers/serial/jsm/jsm_driver.c |    2 +-
 drivers/serial/m32r_sio.c       |    2 +-
 drivers/serial/mcfserial.c      |    2 +-
 drivers/serial/mpc52xx_uart.c   |    2 +-
 drivers/serial/mpsc.c           |    2 +-
 drivers/serial/pmac_zilog.c     |    2 +-
 drivers/serial/serial_txx9.c    |    2 +-
 drivers/serial/sh-sci.c         |    4 ++--
 drivers/serial/sn_console.c     |    2 +-
 drivers/serial/sunsab.c         |    2 +-
 drivers/serial/sunsu.c          |    4 ++--
 drivers/serial/sunzilog.c       |    2 +-
 drivers/serial/v850e_uart.c     |    4 ++--
 20 files changed, 34 insertions(+), 34 deletions(-)

Index: linux-2.6.git/drivers/serial/8250.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/8250.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/8250.c	2006-07-01 16:51:48.000000000 +0200
@@ -48,7 +48,7 @@
 
 /*
  * Configuration:
- *   share_irqs - whether we pass SA_SHIRQ to request_irq().  This option
+ *   share_irqs - whether we pass IRQF_SHARED to request_irq().  This option
  *                is unsafe when used on edge-triggered interrupts.
  */
 static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
@@ -1400,7 +1400,7 @@ static void serial_do_unlink(struct irq_
 static int serial_link_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i = irq_lists + up->port.irq;
-	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? SA_SHIRQ : 0;
+	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? IRQF_SHARED : 0;
 
 	spin_lock_irq(&i->lock);
 
Index: linux-2.6.git/drivers/serial/at91_serial.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/at91_serial.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/at91_serial.c	2006-07-01 16:51:48.000000000 +0200
@@ -387,7 +387,7 @@ static int at91_startup(struct uart_port
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(port->irq, at91_interrupt, SA_SHIRQ, "at91_serial", port);
+	retval = request_irq(port->irq, at91_interrupt, IRQF_SHARED, "at91_serial", port);
 	if (retval) {
 		printk("at91_serial: at91_startup - Can't get irq\n");
 		return retval;
Index: linux-2.6.git/drivers/serial/crisv10.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/crisv10.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/crisv10.c	2006-07-01 16:51:48.000000000 +0200
@@ -415,7 +415,7 @@
  * Fixed DEF_TX value that caused the serial transmitter pin (txd) to go to 0 when
  * closing the last filehandle, NASTY!.
  * Added break generation, not tested though!
- * Use SA_SHIRQ when request_irq() for ser2 and ser3 (shared with) par0 and par1.
+ * Use IRQF_SHARED when request_irq() for ser2 and ser3 (shared with) par0 and par1.
  * You can't use them at the same time (yet..), but you can hopefully switch
  * between ser2/par0, ser3/par1 with the same kernel config.
  * Replaced some magic constants with defines
@@ -4942,55 +4942,55 @@ rs_init(void)
 	/* Not needed in simulator.  May only complicate stuff. */
 	/* hook the irq's for DMA channel 6 and 7, serial output and input, and some more... */
 
-	if (request_irq(SERIAL_IRQ_NBR, ser_interrupt, SA_SHIRQ | SA_INTERRUPT, "serial ", NULL))
+	if (request_irq(SERIAL_IRQ_NBR, ser_interrupt, IRQF_SHARED | IRQF_DISABLED, "serial ", NULL))
 		panic("irq8");
 
 #ifdef CONFIG_ETRAX_SERIAL_PORT0
 #ifdef CONFIG_ETRAX_SERIAL_PORT0_DMA6_OUT
-	if (request_irq(SER0_DMA_TX_IRQ_NBR, tr_interrupt, SA_INTERRUPT, "serial 0 dma tr", NULL))
+	if (request_irq(SER0_DMA_TX_IRQ_NBR, tr_interrupt, IRQF_DISABLED, "serial 0 dma tr", NULL))
 		panic("irq22");
 #endif
 #ifdef CONFIG_ETRAX_SERIAL_PORT0_DMA7_IN
-	if (request_irq(SER0_DMA_RX_IRQ_NBR, rec_interrupt, SA_INTERRUPT, "serial 0 dma rec", NULL))
+	if (request_irq(SER0_DMA_RX_IRQ_NBR, rec_interrupt, IRQF_DISABLED, "serial 0 dma rec", NULL))
 		panic("irq23");
 #endif
 #endif
 
 #ifdef CONFIG_ETRAX_SERIAL_PORT1
 #ifdef CONFIG_ETRAX_SERIAL_PORT1_DMA8_OUT
-	if (request_irq(SER1_DMA_TX_IRQ_NBR, tr_interrupt, SA_INTERRUPT, "serial 1 dma tr", NULL))
+	if (request_irq(SER1_DMA_TX_IRQ_NBR, tr_interrupt, IRQF_DISABLED, "serial 1 dma tr", NULL))
 		panic("irq24");
 #endif
 #ifdef CONFIG_ETRAX_SERIAL_PORT1_DMA9_IN
-	if (request_irq(SER1_DMA_RX_IRQ_NBR, rec_interrupt, SA_INTERRUPT, "serial 1 dma rec", NULL))
+	if (request_irq(SER1_DMA_RX_IRQ_NBR, rec_interrupt, IRQF_DISABLED, "serial 1 dma rec", NULL))
 		panic("irq25");
 #endif
 #endif
 #ifdef CONFIG_ETRAX_SERIAL_PORT2
 	/* DMA Shared with par0 (and SCSI0 and ATA) */
 #ifdef CONFIG_ETRAX_SERIAL_PORT2_DMA2_OUT
-	if (request_irq(SER2_DMA_TX_IRQ_NBR, tr_interrupt, SA_SHIRQ | SA_INTERRUPT, "serial 2 dma tr", NULL))
+	if (request_irq(SER2_DMA_TX_IRQ_NBR, tr_interrupt, IRQF_SHARED | IRQF_DISABLED, "serial 2 dma tr", NULL))
 		panic("irq18");
 #endif
 #ifdef CONFIG_ETRAX_SERIAL_PORT2_DMA3_IN
-	if (request_irq(SER2_DMA_RX_IRQ_NBR, rec_interrupt, SA_SHIRQ | SA_INTERRUPT, "serial 2 dma rec", NULL))
+	if (request_irq(SER2_DMA_RX_IRQ_NBR, rec_interrupt, IRQF_SHARED | IRQF_DISABLED, "serial 2 dma rec", NULL))
 		panic("irq19");
 #endif
 #endif
 #ifdef CONFIG_ETRAX_SERIAL_PORT3
 	/* DMA Shared with par1 (and SCSI1 and Extern DMA 0) */
 #ifdef CONFIG_ETRAX_SERIAL_PORT3_DMA4_OUT
-	if (request_irq(SER3_DMA_TX_IRQ_NBR, tr_interrupt, SA_SHIRQ | SA_INTERRUPT, "serial 3 dma tr", NULL))
+	if (request_irq(SER3_DMA_TX_IRQ_NBR, tr_interrupt, IRQF_SHARED | IRQF_DISABLED, "serial 3 dma tr", NULL))
 		panic("irq20");
 #endif
 #ifdef CONFIG_ETRAX_SERIAL_PORT3_DMA5_IN
-	if (request_irq(SER3_DMA_RX_IRQ_NBR, rec_interrupt, SA_SHIRQ | SA_INTERRUPT, "serial 3 dma rec", NULL))
+	if (request_irq(SER3_DMA_RX_IRQ_NBR, rec_interrupt, IRQF_SHARED | IRQF_DISABLED, "serial 3 dma rec", NULL))
 		panic("irq21");
 #endif
 #endif
 
 #ifdef CONFIG_ETRAX_SERIAL_FLUSH_DMA_FAST
-	if (request_irq(TIMER1_IRQ_NBR, timeout_interrupt, SA_SHIRQ | SA_INTERRUPT,
+	if (request_irq(TIMER1_IRQ_NBR, timeout_interrupt, IRQF_SHARED | IRQF_DISABLED,
 		       "fast serial dma timeout", NULL)) {
 		printk(KERN_CRIT "err: timer1 irq\n");
 	}
Index: linux-2.6.git/drivers/serial/dz.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/dz.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/dz.c	2006-07-01 16:51:48.000000000 +0200
@@ -797,7 +797,7 @@ int __init dz_init(void)
 	restore_flags(flags);
 
 	if (request_irq(dz_ports[0].port.irq, dz_interrupt,
-			SA_INTERRUPT, "DZ", &dz_ports[0]))
+			IRQF_DISABLED, "DZ", &dz_ports[0]))
 		panic("Unable to register DZ interrupt");
 
 	ret = uart_register_driver(&dz_reg);
Index: linux-2.6.git/drivers/serial/icom.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/icom.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/icom.c	2006-07-01 16:51:48.000000000 +0200
@@ -1563,7 +1563,7 @@ static int __devinit icom_probe(struct p
 
 	 /* save off irq and request irq line */
 	 if ( (retval = request_irq(dev->irq, icom_interrupt,
-				   SA_INTERRUPT | SA_SHIRQ, ICOM_DRIVER_NAME,
+				   IRQF_DISABLED | IRQF_SHARED, ICOM_DRIVER_NAME,
 				   (void *) icom_adapter))) {
 		  goto probe_exit2;
 	 }
Index: linux-2.6.git/drivers/serial/imx.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/imx.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/imx.c	2006-07-01 16:51:48.000000000 +0200
@@ -404,7 +404,7 @@ static int imx_startup(struct uart_port 
 	if (retval) goto error_out2;
 
 	retval = request_irq(sport->rtsirq, imx_rtsint,
-			     SA_TRIGGER_FALLING | SA_TRIGGER_RISING,
+			     IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			     DRIVER_NAME, sport);
 	if (retval) goto error_out3;
 
Index: linux-2.6.git/drivers/serial/ioc4_serial.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/ioc4_serial.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/ioc4_serial.c	2006-07-01 16:51:48.000000000 +0200
@@ -2855,7 +2855,7 @@ ioc4_serial_attach_one(struct ioc4_drive
 	control->ic_soft = soft;
 
 	/* Hook up interrupt handler */
-	if (!request_irq(idd->idd_pdev->irq, ioc4_intr, SA_SHIRQ,
+	if (!request_irq(idd->idd_pdev->irq, ioc4_intr, IRQF_SHARED,
 				"sgi-ioc4serial", soft)) {
 		control->ic_irq = idd->idd_pdev->irq;
 	} else {
Index: linux-2.6.git/drivers/serial/m32r_sio.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/m32r_sio.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/m32r_sio.c	2006-07-01 16:51:48.000000000 +0200
@@ -542,7 +542,7 @@ static void serial_do_unlink(struct irq_
 static int serial_link_irq_chain(struct uart_sio_port *up)
 {
 	struct irq_info *i = irq_lists + up->port.irq;
-	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? SA_SHIRQ : 0;
+	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? IRQF_SHARED : 0;
 
 	spin_lock_irq(&i->lock);
 
Index: linux-2.6.git/drivers/serial/mcfserial.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/mcfserial.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/mcfserial.c	2006-07-01 16:51:48.000000000 +0200
@@ -1596,7 +1596,7 @@ static void mcfrs_irqinit(struct mcf_ser
 	/* Clear mask, so no surprise interrupts. */
 	uartp[MCFUART_UIMR] = 0;
 
-	if (request_irq(info->irq, mcfrs_interrupt, SA_INTERRUPT,
+	if (request_irq(info->irq, mcfrs_interrupt, IRQF_DISABLED,
 	    "ColdFire UART", NULL)) {
 		printk("MCFRS: Unable to attach ColdFire UART %d interrupt "
 			"vector=%d\n", info->line, info->irq);
Index: linux-2.6.git/drivers/serial/mpc52xx_uart.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/mpc52xx_uart.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/mpc52xx_uart.c	2006-07-01 16:51:48.000000000 +0200
@@ -190,7 +190,7 @@ mpc52xx_uart_startup(struct uart_port *p
 
 	/* Request IRQ */
 	ret = request_irq(port->irq, mpc52xx_uart_int,
-		SA_INTERRUPT | SA_SAMPLE_RANDOM, "mpc52xx_psc_uart", port);
+		IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "mpc52xx_psc_uart", port);
 	if (ret)
 		return ret;
 
Index: linux-2.6.git/drivers/serial/mpsc.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/mpsc.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/mpsc.c	2006-07-01 16:51:48.000000000 +0200
@@ -1412,7 +1412,7 @@ mpsc_startup(struct uart_port *port)
 
 		/* If irq's are shared, need to set flag */
 		if (mpsc_ports[0].port.irq == mpsc_ports[1].port.irq)
-			flag = SA_SHIRQ;
+			flag = IRQF_SHARED;
 
 		if (request_irq(pi->port.irq, mpsc_sdma_intr, flag,
 				"mpsc-sdma", pi))
Index: linux-2.6.git/drivers/serial/pmac_zilog.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/pmac_zilog.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/pmac_zilog.c	2006-07-01 16:51:48.000000000 +0200
@@ -934,7 +934,7 @@ static int pmz_startup(struct uart_port 
 	}	
 
 	pmz_get_port_A(uap)->flags |= PMACZILOG_FLAG_IS_IRQ_ON;
-	if (request_irq(uap->port.irq, pmz_interrupt, SA_SHIRQ, "PowerMac Zilog", uap)) {
+	if (request_irq(uap->port.irq, pmz_interrupt, IRQF_SHARED, "PowerMac Zilog", uap)) {
 		dev_err(&uap->dev->ofdev.dev,
 			"Unable to register zs interrupt handler.\n");
 		pmz_set_scc_power(uap, 0);
Index: linux-2.6.git/drivers/serial/serial_txx9.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/serial_txx9.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/serial_txx9.c	2006-07-01 16:51:48.000000000 +0200
@@ -495,7 +495,7 @@ static int serial_txx9_startup(struct ua
 	sio_out(up, TXX9_SIDISR, 0);
 
 	retval = request_irq(up->port.irq, serial_txx9_interrupt,
-			     SA_SHIRQ, "serial_txx9", up);
+			     IRQF_SHARED, "serial_txx9", up);
 	if (retval)
 		return retval;
 
Index: linux-2.6.git/drivers/serial/sh-sci.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/sh-sci.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/sh-sci.c	2006-07-01 16:51:48.000000000 +0200
@@ -841,7 +841,7 @@ static int sci_request_irq(struct sci_po
 			printk(KERN_ERR "sci: Cannot allocate irq.(IRQ=0)\n");
 			return -ENODEV;
 		}
-		if (request_irq(port->irqs[0], sci_mpxed_interrupt, SA_INTERRUPT,
+		if (request_irq(port->irqs[0], sci_mpxed_interrupt, IRQF_DISABLED,
 				"sci", port)) {
 			printk(KERN_ERR "sci: Cannot allocate irq.\n");
 			return -ENODEV;
@@ -850,7 +850,7 @@ static int sci_request_irq(struct sci_po
 		for (i = 0; i < ARRAY_SIZE(handlers); i++) {
 			if (!port->irqs[i])
 				continue;
-			if (request_irq(port->irqs[i], handlers[i], SA_INTERRUPT,
+			if (request_irq(port->irqs[i], handlers[i], IRQF_DISABLED,
 					desc[i], port)) {
 				printk(KERN_ERR "sci: Cannot allocate irq.\n");
 				return -ENODEV;
Index: linux-2.6.git/drivers/serial/sn_console.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/sn_console.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/sn_console.c	2006-07-01 16:51:48.000000000 +0200
@@ -648,7 +648,7 @@ static irqreturn_t sn_sal_interrupt(int 
 static int sn_sal_connect_interrupt(struct sn_cons_port *port)
 {
 	if (request_irq(SGI_UART_VECTOR, sn_sal_interrupt,
-			SA_INTERRUPT | SA_SHIRQ,
+			IRQF_DISABLED | IRQF_SHARED,
 			"SAL console driver", port) >= 0) {
 		return SGI_UART_VECTOR;
 	}
Index: linux-2.6.git/drivers/serial/sunsab.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/sunsab.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/sunsab.c	2006-07-01 16:51:48.000000000 +0200
@@ -1027,7 +1027,7 @@ static int __devinit sunsab_init_one(str
 		int err;
 
 		err = request_irq(up->port.irq, sunsab_interrupt,
-				  SA_SHIRQ, "sab", up);
+				  IRQF_SHARED, "sab", up);
 		if (err) {
 			of_iounmap(up->port.membase,
 				   sizeof(union sab82532_async_regs));
Index: linux-2.6.git/drivers/serial/sunsu.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/sunsu.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/sunsu.c	2006-07-01 16:51:48.000000000 +0200
@@ -667,10 +667,10 @@ static int sunsu_startup(struct uart_por
 
 	if (up->su_type != SU_PORT_PORT) {
 		retval = request_irq(up->port.irq, sunsu_kbd_ms_interrupt,
-				     SA_SHIRQ, su_typev[up->su_type], up);
+				     IRQF_SHARED, su_typev[up->su_type], up);
 	} else {
 		retval = request_irq(up->port.irq, sunsu_serial_interrupt,
-				     SA_SHIRQ, su_typev[up->su_type], up);
+				     IRQF_SHARED, su_typev[up->su_type], up);
 	}
 	if (retval) {
 		printk("su: Cannot register IRQ %d\n", up->port.irq);
Index: linux-2.6.git/drivers/serial/sunzilog.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/sunzilog.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/sunzilog.c	2006-07-01 16:51:48.000000000 +0200
@@ -1354,7 +1354,7 @@ static int __devinit zs_probe(struct of_
 
 	if (zilog_irq == -1) {
 		zilog_irq = op->irqs[0];
-		err = request_irq(zilog_irq, sunzilog_interrupt, SA_SHIRQ,
+		err = request_irq(zilog_irq, sunzilog_interrupt, IRQF_SHARED,
 				  "zs", sunzilog_irq_chain);
 		if (err) {
 			of_iounmap(rp, sizeof(struct zilog_layout));
Index: linux-2.6.git/drivers/serial/v850e_uart.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/v850e_uart.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/v850e_uart.c	2006-07-01 16:51:48.000000000 +0200
@@ -372,13 +372,13 @@ static int v850e_uart_startup (struct ua
 
 	/* Alloc RX irq.  */
 	err = request_irq (V850E_UART_RX_IRQ (port->line), v850e_uart_rx_irq,
-			   SA_INTERRUPT, "v850e_uart", port);
+			   IRQF_DISABLED, "v850e_uart", port);
 	if (err)
 		return err;
 
 	/* Alloc TX irq.  */
 	err = request_irq (V850E_UART_TX_IRQ (port->line), v850e_uart_tx_irq,
-			   SA_INTERRUPT, "v850e_uart", port);
+			   IRQF_DISABLED, "v850e_uart", port);
 	if (err) {
 		free_irq (V850E_UART_RX_IRQ (port->line), port);
 		return err;
Index: linux-2.6.git/drivers/serial/jsm/jsm_driver.c
===================================================================
--- linux-2.6.git.orig/drivers/serial/jsm/jsm_driver.c	2006-07-01 16:51:10.000000000 +0200
+++ linux-2.6.git/drivers/serial/jsm/jsm_driver.c	2006-07-01 16:51:48.000000000 +0200
@@ -121,7 +121,7 @@ static int jsm_probe_one(struct pci_dev 
 	}
 
 	rc = request_irq(brd->irq, brd->bd_ops->intr,
-			SA_INTERRUPT|SA_SHIRQ, "JSM", brd);
+			IRQF_DISABLED|IRQF_SHARED, "JSM", brd);
 	if (rc) {
 		printk(KERN_WARNING "Failed to hook IRQ %d\n",brd->irq);
 		goto out_iounmap;

--

