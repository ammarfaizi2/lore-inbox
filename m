Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVHIDlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVHIDlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 23:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVHIDll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 23:41:41 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:32451 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932427AbVHIDll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 23:41:41 -0400
Date: Mon, 8 Aug 2005 22:40:40 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, vbordug@ru.mvista.com,
       panto@intracom.gr, marcelo.tosatti@cyclades.com
Subject: [PATCH] cpm_uart: Fix dpram allocation and non-console uarts
Message-ID: <Pine.LNX.4.61.0508082239180.5117@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(A believe Marcelo would like to see this in 2.6.13, but I'll let him 
fight over that ;)

* Makes dpram allocations work
* Makes non-console UART work on both 8xx and 82xx
* Fixed whitespace in files that were touched

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Pantelis Antoniou <panto@intracom.gr>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1de80554bcae877dce3b6d878053eb092ef65c72
tree aba124824607fea1070e86501ddccc9decce362d
parent ad81111fd554c9d3c14c0a50885e076af2f9ac9b
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:35:39 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:35:39 -0500

 drivers/serial/cpm_uart/cpm_uart.h      |   10 ++-
 drivers/serial/cpm_uart/cpm_uart_core.c |  118 +++++++++++++++++++++----------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |   53 ++++++++------
 3 files changed, 116 insertions(+), 65 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -40,13 +40,15 @@
 #define TX_NUM_FIFO	4
 #define TX_BUF_SIZE	32
 
+#define SCC_WAIT_CLOSING 100
+
 struct uart_cpm_port {
 	struct uart_port	port;
-	u16			rx_nrfifos;	
+	u16			rx_nrfifos;
 	u16			rx_fifosize;
-	u16			tx_nrfifos;	
+	u16			tx_nrfifos;
 	u16			tx_fifosize;
-	smc_t			*smcp;	
+	smc_t			*smcp;
 	smc_uart_t		*smcup;
 	scc_t			*sccp;
 	scc_uart_t		*sccup;
@@ -67,6 +69,8 @@ struct uart_cpm_port {
 	int			 bits;
 	/* Keep track of 'odd' SMC2 wirings */
 	int			is_portb;
+	/* wait on close if needed */
+	int 			wait_closing;
 };
 
 extern int cpm_uart_port_map[UART_NR];
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -9,9 +9,10 @@
  *
  *  Maintainer: Kumar Gala (kumar.gala@freescale.com) (CPM2)
  *              Pantelis Antoniou (panto@intracom.gr) (CPM1)
- * 
+ *
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
+ *            (C) 2005 MontaVista Software, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -70,8 +71,22 @@ static void cpm_uart_initbd(struct uart_
 
 /**************************************************************/
 
+static inline unsigned long cpu2cpm_addr(void *addr)
+{
+	if ((unsigned long)addr >= CPM_ADDR)
+		return (unsigned long)addr;
+	return virt_to_bus(addr);
+}
+
+static inline void *cpm2cpu_addr(unsigned long addr)
+{
+	if (addr >= CPM_ADDR)
+		return (void *)addr;
+	return bus_to_virt(addr);
+}
+
 /*
- * Check, if transmit buffers are processed		
+ * Check, if transmit buffers are processed
 */
 static unsigned int cpm_uart_tx_empty(struct uart_port *port)
 {
@@ -143,15 +158,18 @@ static void cpm_uart_start_tx(struct uar
 	}
 
 	if (cpm_uart_tx_pump(port) != 0) {
-		if (IS_SMC(pinfo))
+		if (IS_SMC(pinfo)) {
 			smcp->smc_smcm |= SMCM_TX;
-		else
+			smcp->smc_smcmr |= SMCMR_TEN;
+		} else {
 			sccp->scc_sccm |= UART_SCCM_TX;
+			pinfo->sccp->scc_gsmrl |= SCC_GSMRL_ENT;
+		}
 	}
 }
 
 /*
- * Stop receiver 
+ * Stop receiver
  */
 static void cpm_uart_stop_rx(struct uart_port *port)
 {
@@ -176,7 +194,7 @@ static void cpm_uart_enable_ms(struct ua
 }
 
 /*
- * Generate a break. 
+ * Generate a break.
  */
 static void cpm_uart_break_ctl(struct uart_port *port, int break_state)
 {
@@ -231,7 +249,7 @@ static void cpm_uart_int_rx(struct uart_
 		/* get number of characters, and check spce in flip-buffer */
 		i = bdp->cbd_datlen;
 
-		/* If we have not enough room in tty flip buffer, then we try 
+		/* If we have not enough room in tty flip buffer, then we try
 		 * later, which will be the next rx-interrupt or a timeout
 		 */
 		if ((tty->flip.count + i) >= TTY_FLIPBUF_SIZE) {
@@ -243,7 +261,7 @@ static void cpm_uart_int_rx(struct uart_
 		}
 
 		/* get pointer */
-		cp = (unsigned char *)bus_to_virt(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
@@ -265,13 +283,14 @@ static void cpm_uart_int_rx(struct uart_
 		}		/* End while (i--) */
 
 		/* This BD is ready to be used again. Clear status. get next */
-		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV);
+		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV | BD_SC_ID);
 		bdp->cbd_sc |= BD_SC_EMPTY;
 
 		if (bdp->cbd_sc & BD_SC_WRAP)
 			bdp = pinfo->rx_bd_base;
 		else
 			bdp++;
+
 	} /* End for (;;) */
 
 	/* Write back buffer pointer */
@@ -336,22 +355,22 @@ static irqreturn_t cpm_uart_int(int irq,
 
 	if (IS_SMC(pinfo)) {
 		events = smcp->smc_smce;
+		smcp->smc_smce = events;
 		if (events & SMCM_BRKE)
 			uart_handle_break(port);
 		if (events & SMCM_RX)
 			cpm_uart_int_rx(port, regs);
 		if (events & SMCM_TX)
 			cpm_uart_int_tx(port, regs);
-		smcp->smc_smce = events;
 	} else {
 		events = sccp->scc_scce;
+		sccp->scc_scce = events;
 		if (events & UART_SCCM_BRKE)
 			uart_handle_break(port);
 		if (events & UART_SCCM_RX)
 			cpm_uart_int_rx(port, regs);
 		if (events & UART_SCCM_TX)
 			cpm_uart_int_tx(port, regs);
-		sccp->scc_scce = events;
 	}
 	return (events) ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -360,6 +379,7 @@ static int cpm_uart_startup(struct uart_
 {
 	int retval;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
+	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:startup\n", port->line);
 
@@ -376,9 +396,19 @@ static int cpm_uart_startup(struct uart_
 		pinfo->sccp->scc_sccm |= UART_SCCM_RX;
 	}
 
+	if (!(pinfo->flags & FLAG_CONSOLE))
+		cpm_line_cr_cmd(line,CPM_CR_INIT_TRX);
 	return 0;
 }
 
+inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
+{
+	unsigned long target_jiffies = jiffies + pinfo->wait_closing;
+
+	while (!time_after(jiffies, target_jiffies))
+   		schedule();
+}
+
 /*
  * Shutdown the uart
  */
@@ -394,6 +424,12 @@ static void cpm_uart_shutdown(struct uar
 
 	/* If the port is not the console, disable Rx and Tx. */
 	if (!(pinfo->flags & FLAG_CONSOLE)) {
+		/* Wait for all the BDs marked sent */
+		while(!cpm_uart_tx_empty(port))
+			schedule_timeout(2);
+		if(pinfo->wait_closing)
+			cpm_uart_wait_until_send(pinfo);
+
 		/* Stop uarts */
 		if (IS_SMC(pinfo)) {
 			volatile smc_t *smcp = pinfo->smcp;
@@ -502,7 +538,7 @@ static void cpm_uart_set_termios(struct 
 	 */
 	if ((termios->c_cflag & CREAD) == 0)
 		port->read_status_mask &= ~BD_SC_EMPTY;
-	
+
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Start bit has not been added (so don't, because we would just
@@ -569,7 +605,8 @@ static int cpm_uart_tx_pump(struct uart_
 		/* Pick next descriptor and fill from buffer */
 		bdp = pinfo->tx_cur;
 
-		p = bus_to_virt(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr);
+
 		*p++ = xmit->buf[xmit->tail];
 		bdp->cbd_datlen = 1;
 		bdp->cbd_sc |= BD_SC_READY;
@@ -595,7 +632,7 @@ static int cpm_uart_tx_pump(struct uart_
 
 	while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail != xmit->head)) {
 		count = 0;
-		p = bus_to_virt(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr);
 		while (count < pinfo->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -606,6 +643,7 @@ static int cpm_uart_tx_pump(struct uart_
 		}
 		bdp->cbd_datlen = count;
 		bdp->cbd_sc |= BD_SC_READY;
+		__asm__("eieio");
 		/* Get next BD. */
 		if (bdp->cbd_sc & BD_SC_WRAP)
 			bdp = pinfo->tx_bd_base;
@@ -643,12 +681,12 @@ static void cpm_uart_initbd(struct uart_
 	mem_addr = pinfo->mem_addr;
 	bdp = pinfo->rx_cur = pinfo->rx_bd_base;
 	for (i = 0; i < (pinfo->rx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
 		bdp->cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT;
 		mem_addr += pinfo->rx_fifosize;
 	}
-	
-	bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+
+	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;
 
 	/* Set the physical address of the host memory
@@ -658,12 +696,12 @@ static void cpm_uart_initbd(struct uart_
 	mem_addr = pinfo->mem_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize);
 	bdp = pinfo->tx_cur = pinfo->tx_bd_base;
 	for (i = 0; i < (pinfo->tx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
 		bdp->cbd_sc = BD_SC_INTRPT;
 		mem_addr += pinfo->tx_fifosize;
 	}
-	
-	bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+
+	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_INTRPT;
 }
 
@@ -763,6 +801,8 @@ static void cpm_uart_init_smc(struct uar
 	/* Using idle charater time requires some additional tuning.  */
 	up->smc_mrblr = pinfo->rx_fifosize;
 	up->smc_maxidl = pinfo->rx_fifosize;
+	up->smc_brklen = 0;
+	up->smc_brkec = 0;
 	up->smc_brkcr = 1;
 
 	cpm_line_cr_cmd(line, CPM_CR_INIT_TRX);
@@ -796,7 +836,7 @@ static int cpm_uart_request_port(struct 
 	/*
 	 * Setup any port IO, connect any baud rate generators,
 	 * etc.  This is expected to be handled by board
-	 * dependant code 
+	 * dependant code
 	 */
 	if (pinfo->set_lineif)
 		pinfo->set_lineif(pinfo);
@@ -815,6 +855,10 @@ static int cpm_uart_request_port(struct 
 		return ret;
 
 	cpm_uart_initbd(pinfo);
+	if (IS_SMC(pinfo))
+		cpm_uart_init_smc(pinfo);
+	else
+		cpm_uart_init_scc(pinfo);
 
 	return 0;
 }
@@ -869,7 +913,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = smc1_lineif,
 	},
@@ -883,7 +927,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = smc2_lineif,
 #ifdef CONFIG_SERIAL_CPM_ALT_SMC2
@@ -899,9 +943,10 @@ struct uart_cpm_port cpm_uart_ports[UART
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc1_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC2] = {
 		.port = {
@@ -912,9 +957,10 @@ struct uart_cpm_port cpm_uart_ports[UART
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc2_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC3] = {
 		.port = {
@@ -925,9 +971,10 @@ struct uart_cpm_port cpm_uart_ports[UART
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc3_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC4] = {
 		.port = {
@@ -938,9 +985,10 @@ struct uart_cpm_port cpm_uart_ports[UART
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc4_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 };
 
@@ -983,11 +1031,8 @@ static void cpm_uart_console_write(struc
 		 * If the buffer address is in the CPM DPRAM, don't
 		 * convert it.
 		 */
-		if ((uint) (bdp->cbd_bufaddr) > (uint) CPM_ADDR)
-			cp = (unsigned char *) (bdp->cbd_bufaddr);
-		else
-			cp = bus_to_virt(bdp->cbd_bufaddr);
-		
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+
 		*cp = *s;
 
 		bdp->cbd_datlen = 1;
@@ -1003,10 +1048,7 @@ static void cpm_uart_console_write(struc
 			while ((bdp->cbd_sc & BD_SC_READY) != 0)
 				;
 
-			if ((uint) (bdp->cbd_bufaddr) > (uint) CPM_ADDR)
-				cp = (unsigned char *) (bdp->cbd_bufaddr);
-			else
-				cp = bus_to_virt(bdp->cbd_bufaddr);
+			cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 
 			*cp = 13;
 			bdp->cbd_datlen = 1;
@@ -1045,7 +1087,7 @@ static int __init cpm_uart_console_setup
 	port =
 	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
 	pinfo = (struct uart_cpm_port *)port;
-	
+
 	pinfo->flags |= FLAG_CONSOLE;
 
 	if (options) {
@@ -1062,7 +1104,7 @@ static int __init cpm_uart_console_setup
 	/*
 	 * Setup any port IO, connect any baud rate generators,
 	 * etc.  This is expected to be handled by board
-	 * dependant code 
+	 * dependant code
 	 */
 	if (pinfo->set_lineif)
 		pinfo->set_lineif(pinfo);
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -5,7 +5,7 @@
  *
  *  Maintainer: Kumar Gala (kumar.gala@freescale.com) (CPM2)
  *              Pantelis Antoniou (panto@intracom.gr) (CPM1)
- * 
+ *
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
  *
@@ -82,6 +82,17 @@ void cpm_line_cr_cmd(int line, int cmd)
 void smc1_lineif(struct uart_cpm_port *pinfo)
 {
 	volatile cpm8xx_t *cp = cpmp;
+
+	(void)cp;	/* fix warning */
+#if defined (CONFIG_MPC885ADS)
+	/* Enable SMC1 transceivers */
+	{
+		cp->cp_pepar |= 0x000000c0;
+		cp->cp_pedir &= ~0x000000c0;
+		cp->cp_peso &= ~0x00000040;
+		cp->cp_peso |= 0x00000080;
+	}
+#elif defined (CONFIG_MPC86XADS)
 	unsigned int iobits = 0x000000c0;
 
 	if (!pinfo->is_portb) {
@@ -93,41 +104,33 @@ void smc1_lineif(struct uart_cpm_port *p
 		((immap_t *)IMAP_ADDR)->im_ioport.iop_padir &= ~iobits;
 		((immap_t *)IMAP_ADDR)->im_ioport.iop_paodr &= ~iobits;
 	}
-
-#ifdef CONFIG_MPC885ADS
-	/* Enable SMC1 transceivers */
-	{
-		volatile uint __iomem *bcsr1 = ioremap(BCSR1, 4);
-		uint tmp;
-
-		tmp = in_be32(bcsr1);
-		tmp &= ~BCSR1_RS232EN_1;
-		out_be32(bcsr1, tmp);
-		iounmap(bcsr1);
-	}
 #endif
-
 	pinfo->brg = 1;
 }
 
 void smc2_lineif(struct uart_cpm_port *pinfo)
 {
-#ifdef CONFIG_MPC885ADS
 	volatile cpm8xx_t *cp = cpmp;
-	volatile uint __iomem *bcsr1;
-	uint tmp;
 
+	(void)cp;	/* fix warning */
+#if defined (CONFIG_MPC885ADS)
 	cp->cp_pepar |= 0x00000c00;
 	cp->cp_pedir &= ~0x00000c00;
 	cp->cp_peso &= ~0x00000400;
 	cp->cp_peso |= 0x00000800;
+#elif defined (CONFIG_MPC86XADS)
+	unsigned int iobits = 0x00000c00;
+
+	if (!pinfo->is_portb) {
+		cp->cp_pbpar |= iobits;
+		cp->cp_pbdir &= ~iobits;
+		cp->cp_pbodr &= ~iobits;
+	} else {
+		((immap_t *)IMAP_ADDR)->im_ioport.iop_papar |= iobits;
+		((immap_t *)IMAP_ADDR)->im_ioport.iop_padir &= ~iobits;
+		((immap_t *)IMAP_ADDR)->im_ioport.iop_paodr &= ~iobits;
+	}
 
-	/* Enable SMC2 transceivers */
-	bcsr1 = ioremap(BCSR1, 4);
-	tmp = in_be32(bcsr1);
-	tmp &= ~BCSR1_RS232EN_2;
-	out_be32(bcsr1, tmp);
-	iounmap(bcsr1);
 #endif
 
 	pinfo->brg = 2;
@@ -158,7 +161,7 @@ void scc4_lineif(struct uart_cpm_port *p
 }
 
 /*
- * Allocate DP-Ram and memory buffers. We need to allocate a transmit and 
+ * Allocate DP-Ram and memory buffers. We need to allocate a transmit and
  * receive buffer descriptors from dual port ram, and a character
  * buffer area from host mem. If we are allocating for the console we need
  * to do it from bootmem
@@ -185,6 +188,8 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
 	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
 	if (is_con) {
+		/* was hostalloc but changed cause it blows away the */
+		/* large tlb mapping when pinning the kernel area    */
 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
 		dma_addr = 0;
 	} else
