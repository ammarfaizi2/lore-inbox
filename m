Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTELJt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbTELJtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:49:11 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:28492 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262054AbTELJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:14 -0400
Date: Mon, 12 May 2003 11:54:42 +0200
Message-Id: <200305120954.h4C9sgJP001033@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [14/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k char drivers: Update to the new irq API (from Roman Zippel and me) [14/20]

--- linux-2.5.69/drivers/char/amiserial.c	Mon May  5 10:30:53 2003
+++ linux-m68k-2.5.69/drivers/char/amiserial.c	Tue May  6 13:50:50 2003
@@ -490,7 +490,7 @@
 	}
 }
 
-static void ser_vbl_int( int irq, void *data, struct pt_regs *regs)
+static irqreturn_t ser_vbl_int( int irq, void *data, struct pt_regs *regs)
 {
         /* vbl is just a periodic interrupt we tie into to update modem status */
 	struct async_struct * info = IRQ_ports;
@@ -500,9 +500,10 @@
 	 */
 	if(info->IER & UART_IER_MSI)
 	  check_modem_status(info);
+	return IRQ_HANDLED;
 }
 
-static void ser_rx_int(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t ser_rx_int(int irq, void *dev_id, struct pt_regs * regs)
 {
 	struct async_struct * info;
 
@@ -512,16 +513,17 @@
 
 	info = IRQ_ports;
 	if (!info || !info->tty)
-		return;
+		return IRQ_NONE;
 
 	receive_chars(info);
 	info->last_active = jiffies;
 #ifdef SERIAL_DEBUG_INTR
 	printk("end.\n");
 #endif
+	return IRQ_HANDLED;
 }
 
-static void ser_tx_int(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t ser_tx_int(int irq, void *dev_id, struct pt_regs * regs)
 {
 	struct async_struct * info;
 
@@ -532,7 +534,7 @@
 
 	  info = IRQ_ports;
 	  if (!info || !info->tty)
-	    return;
+		return IRQ_NONE;
 
 	  transmit_chars(info);
 	  info->last_active = jiffies;
@@ -540,6 +542,7 @@
 	  printk("end.\n");
 #endif
 	}
+	return IRQ_HANDLED;
 }
 
 /*
--- linux-2.5.69/drivers/char/ser_a2232.c	Mon May  5 10:31:01 2003
+++ linux-m68k-2.5.69/drivers/char/ser_a2232.c	Fri May  9 10:21:31 2003
@@ -116,7 +116,7 @@
 static __inline__ void a2232_receive_char(	struct a2232_port *port,
 						int ch, int err );
 /* The interrupt service routine */
-static void a2232_vbl_inter(int irq, void *data, struct pt_regs *fp);
+static irqreturn_t a2232_vbl_inter(int irq, void *data, struct pt_regs *fp);
 /* Initialize the port structures */
 static void a2232_init_portstructs(void);
 /* Initialize and register TTY drivers. */
@@ -539,7 +539,7 @@
 	tty_flip_buffer_push(tty);
 }
 
-static void a2232_vbl_inter(int irq, void *data, struct pt_regs *fp)
+static irqreturn_t a2232_vbl_inter(int irq, void *data, struct pt_regs *fp)
 {
 #if A2232_IOBUFLEN != 256
 #error "Re-Implement a2232_vbl_inter()!"
@@ -679,6 +679,7 @@
 		} // if events in CD queue
 		
 	} // for every completely initialized A2232 board
+	return IRQ_HANDLED;
 }
 
 static void a2232_init_portstructs(void)
--- linux-2.5.69/drivers/char/serial167.c	Mon May  5 10:31:02 2003
+++ linux-m68k-2.5.69/drivers/char/serial167.c	Fri May  9 10:21:31 2003
@@ -400,7 +400,7 @@
    whenever the card wants its hand held--chars
    received, out buffer empty, modem change, etc.
  */
-static void
+static irqreturn_t
 cd2401_rxerr_interrupt(int irq, void *dev_id, struct pt_regs *fp)
 {
     struct tty_struct *tty;
@@ -418,7 +418,7 @@
     if ((err = base_addr[CyRISR]) & CyTIMEOUT) {
 	/* This is a receive timeout interrupt, ignore it */
 	base_addr[CyREOIR] = CyNOTRANS;
-	return;
+	return IRQ_HANDLED;
     }
 
     /* Read a byte of data if there is any - assume the error
@@ -432,13 +432,13 @@
     /* if there is nowhere to put the data, discard it */
     if(info->tty == 0) {
 	base_addr[CyREOIR] = rfoc ? 0 : CyNOTRANS;
-	return;
+	return IRQ_HANDLED;
     }
     else { /* there is an open port for this data */
 	tty = info->tty;
 	if(err & info->ignore_status_mask){
 	    base_addr[CyREOIR] = rfoc ? 0 : CyNOTRANS;
-	    return;
+	    return IRQ_HANDLED;
 	}
 	if (tty->flip.count < TTY_FLIPBUF_SIZE){
 	    tty->flip.count++;
@@ -488,9 +488,10 @@
     queue_task(&tty->flip.tqueue, &tq_timer);
     /* end of service */
     base_addr[CyREOIR] = rfoc ? 0 : CyNOTRANS;
+    return IRQ_HANDLED;
 } /* cy_rxerr_interrupt */
 
-static void
+static irqreturn_t
 cd2401_modem_interrupt(int irq, void *dev_id, struct pt_regs *fp)
 {
     struct cyclades_port *info;
@@ -543,9 +544,10 @@
 	}
     }
     base_addr[CyMEOIR] = 0;
+    return IRQ_HANDLED;
 } /* cy_modem_interrupt */
 
-static void
+static irqreturn_t
 cd2401_tx_interrupt(int irq, void *dev_id, struct pt_regs *fp)
 {
     struct cyclades_port *info;
@@ -569,7 +571,7 @@
     if( (channel < 0) || (NR_PORTS <= channel) ){
 	base_addr[CyIER] &= ~(CyTxMpty|CyTxRdy);
 	base_addr[CyTEOIR] = CyNOTRANS;
-	return;
+	return IRQ_HANDLED;
     }
     info->last_active = jiffies;
     if(info->tty == 0){
@@ -578,7 +580,7 @@
 	    cy_sched_event(info, Cy_EVENT_WRITE_WAKEUP);
         }
 	base_addr[CyTEOIR] = CyNOTRANS;
-	return;
+	return IRQ_HANDLED;
     }
 
     /* load the on-chip space available for outbound data */
@@ -662,9 +664,10 @@
 	cy_sched_event(info, Cy_EVENT_WRITE_WAKEUP);
     }
     base_addr[CyTEOIR] = (char_count != saved_cnt) ? 0 : CyNOTRANS;
+    return IRQ_HANDLED;
 } /* cy_tx_interrupt */
 
-static void
+static irqreturn_t
 cd2401_rx_interrupt(int irq, void *dev_id, struct pt_regs *fp)
 {
     struct tty_struct *tty;
@@ -722,6 +725,7 @@
     }
     /* end of service */
     base_addr[CyREOIR] = save_cnt ? 0 : CyNOTRANS;
+    return IRQ_HANDLED;
 } /* cy_rx_interrupt */
 
 /*
--- linux-2.5.69/drivers/char/vme_scc.c	Mon May  5 10:31:05 2003
+++ linux-m68k-2.5.69/drivers/char/vme_scc.c	Fri May  9 10:21:31 2003
@@ -83,10 +83,10 @@
                      unsigned int cmd, unsigned long arg);
 static void scc_throttle(struct tty_struct *tty);
 static void scc_unthrottle(struct tty_struct *tty);
-static void scc_tx_int(int irq, void *data, struct pt_regs *fp);
-static void scc_rx_int(int irq, void *data, struct pt_regs *fp);
-static void scc_stat_int(int irq, void *data, struct pt_regs *fp);
-static void scc_spcond_int(int irq, void *data, struct pt_regs *fp);
+static irqreturn_t scc_tx_int(int irq, void *data, struct pt_regs *fp);
+static irqreturn_t scc_rx_int(int irq, void *data, struct pt_regs *fp);
+static irqreturn_t scc_stat_int(int irq, void *data, struct pt_regs *fp);
+static irqreturn_t scc_spcond_int(int irq, void *data, struct pt_regs *fp);
 static void scc_setsignals(struct scc_port *port, int dtr, int rts);
 static void scc_break_ctl(struct tty_struct *tty, int break_state);
 
@@ -447,7 +447,7 @@
  * Interrupt handlers
  *--------------------------------------------------------------------------*/
 
-static void scc_rx_int(int irq, void *data, struct pt_regs *fp)
+static irqreturn_t scc_rx_int(int irq, void *data, struct pt_regs *fp)
 {
 	unsigned char	ch;
 	struct scc_port *port = data;
@@ -458,7 +458,7 @@
 	if (!tty) {
 		printk(KERN_WARNING "scc_rx_int with NULL tty!\n");
 		SCCwrite_NB(COMMAND_REG, CR_HIGHEST_IUS_RESET);
-		return;
+		return IRQ_HANDLED;
 	}
 	if (tty->flip.count < TTY_FLIPBUF_SIZE) {
 		*tty->flip.char_buf_ptr = ch;
@@ -475,16 +475,17 @@
 	if (SCCread(INT_PENDING_REG) &
 	    (port->channel == CHANNEL_A ? IPR_A_RX : IPR_B_RX)) {
 		scc_spcond_int (irq, data, fp);
-		return;
+		return IRQ_HANDLED;
 	}
 
 	SCCwrite_NB(COMMAND_REG, CR_HIGHEST_IUS_RESET);
 
 	tty_flip_buffer_push(tty);
+	return IRQ_HANDLED;
 }
 
 
-static void scc_spcond_int(int irq, void *data, struct pt_regs *fp)
+static irqreturn_t scc_spcond_int(int irq, void *data, struct pt_regs *fp)
 {
 	struct scc_port *port = data;
 	struct tty_struct *tty = port->gs.tty;
@@ -497,7 +498,7 @@
 		printk(KERN_WARNING "scc_spcond_int with NULL tty!\n");
 		SCCwrite(COMMAND_REG, CR_ERROR_RESET);
 		SCCwrite_NB(COMMAND_REG, CR_HIGHEST_IUS_RESET);
-		return;
+		return IRQ_HANDLED;
 	}
 	do {
 		stat = SCCread(SPCOND_STATUS_REG);
@@ -531,10 +532,11 @@
 	SCCwrite_NB(COMMAND_REG, CR_HIGHEST_IUS_RESET);
 
 	tty_flip_buffer_push(tty);
+	return IRQ_HANDLED;
 }
 
 
-static void scc_tx_int(int irq, void *data, struct pt_regs *fp)
+static irqreturn_t scc_tx_int(int irq, void *data, struct pt_regs *fp)
 {
 	struct scc_port *port = data;
 	SCC_ACCESS_INIT(port);
@@ -544,7 +546,7 @@
 		SCCmod (INT_AND_DMA_REG, ~IDR_TX_INT_ENAB, 0);
 		SCCwrite(COMMAND_REG, CR_TX_PENDING_RESET);
 		SCCwrite_NB(COMMAND_REG, CR_HIGHEST_IUS_RESET);
-		return;
+		return IRQ_HANDLED;
 	}
 	while ((SCCread_NB(STATUS_REG) & SR_TX_BUF_EMPTY)) {
 		if (port->x_char) {
@@ -576,10 +578,11 @@
 	}
 
 	SCCwrite_NB(COMMAND_REG, CR_HIGHEST_IUS_RESET);
+	return IRQ_HANDLED;
 }
 
 
-static void scc_stat_int(int irq, void *data, struct pt_regs *fp)
+static irqreturn_t scc_stat_int(int irq, void *data, struct pt_regs *fp)
 {
 	struct scc_port *port = data;
 	unsigned channel = port->channel;
@@ -611,6 +614,7 @@
 	}
 	SCCwrite(COMMAND_REG, CR_EXTSTAT_RESET);
 	SCCwrite_NB(COMMAND_REG, CR_HIGHEST_IUS_RESET);
+	return IRQ_HANDLED;
 }
 
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
