Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSL0QGT>; Fri, 27 Dec 2002 11:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSL0QFi>; Fri, 27 Dec 2002 11:05:38 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:44600 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265074AbSL0QDj>; Fri, 27 Dec 2002 11:03:39 -0500
Date: Fri, 27 Dec 2002 17:11:10 +0100
Message-Id: <200212271611.gBRGBADF008029@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k char local_irq*() updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert m68k char drivers to new local_irq*() framework:
  - Amiga builtin serial
  - Amiga A2232 multiserial
  - MVME167 serial
  - MVME147/162 and BVME6000 SCC

--- linux-2.5.53/drivers/char/amiserial.c	Sun Oct 13 10:55:56 2002
+++ linux-m68k-2.5.53/drivers/char/amiserial.c	Thu Nov  7 23:15:13 2002
@@ -211,7 +211,7 @@
 	if (serial_paranoia_check(info, tty->device, "rs_stop"))
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (info->IER & UART_IER_THRI) {
 		info->IER &= ~UART_IER_THRI;
 		/* disable Tx interrupt and remove any pending interrupts */
@@ -220,7 +220,7 @@
 		custom.intreq = IF_TBE;
 		mb();
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_start(struct tty_struct *tty)
@@ -231,7 +231,7 @@
 	if (serial_paranoia_check(info, tty->device, "rs_start"))
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (info->xmit.head != info->xmit.tail
 	    && info->xmit.buf
 	    && !(info->IER & UART_IER_THRI)) {
@@ -242,7 +242,7 @@
 		custom.intreq = IF_SETCLR | IF_TBE;
 		mb();
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -594,7 +594,7 @@
 	if (!page)
 		return -ENOMEM;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	if (info->flags & ASYNC_INITIALIZED) {
 		free_page(page);
@@ -665,11 +665,11 @@
 	change_speed(info, 0);
 
 	info->flags |= ASYNC_INITIALIZED;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 
 errout:
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return retval;
 }
 
@@ -691,7 +691,7 @@
 	printk("Shutting down serial port %d ....\n", info->line);
 #endif
 
-	save_flags(flags); cli(); /* Disable interrupts */
+	local_irq_save(flags); /* Disable interrupts */
 
 	/*
 	 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
@@ -727,7 +727,7 @@
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
 
 	info->flags &= ~ASYNC_INITIALIZED;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -855,7 +855,7 @@
 	 */
 	if ((cflag & CREAD) == 0)
 		info->ignore_status_mask |= UART_LSR_DR;
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	{
 	  short serper;
@@ -873,7 +873,7 @@
 	}
 
 	info->LCR = cval;				/* Save LCR */
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_put_char(struct tty_struct *tty, unsigned char ch)
@@ -887,17 +887,17 @@
 	if (!tty || !info->xmit.buf)
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (CIRC_SPACE(info->xmit.head,
 		       info->xmit.tail,
 		       SERIAL_XMIT_SIZE) == 0) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 
 	info->xmit.buf[info->xmit.head++] = ch;
 	info->xmit.head &= SERIAL_XMIT_SIZE-1;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_flush_chars(struct tty_struct *tty)
@@ -914,14 +914,14 @@
 	    || !info->xmit.buf)
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	info->IER |= UART_IER_THRI;
 	custom.intena = IF_SETCLR | IF_TBE;
 	mb();
 	/* set a pending Tx Interrupt, transmitter should restart now */
 	custom.intreq = IF_SETCLR | IF_TBE;
 	mb();
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static int rs_write(struct tty_struct * tty, int from_user,
@@ -937,7 +937,7 @@
 	if (!tty || !info->xmit.buf || !tmp_buf)
 		return 0;
 
-	save_flags(flags);
+	local_save_flags(flags);
 	if (from_user) {
 		down(&tmp_buf_sem);
 		while (1) {
@@ -954,7 +954,7 @@
 					ret = -EFAULT;
 				break;
 			}
-			cli();
+			local_irq_disable();
 			c1 = CIRC_SPACE_TO_END(info->xmit.head,
 					       info->xmit.tail,
 					       SERIAL_XMIT_SIZE);
@@ -963,14 +963,14 @@
 			memcpy(info->xmit.buf + info->xmit.head, tmp_buf, c);
 			info->xmit.head = ((info->xmit.head + c) &
 					   (SERIAL_XMIT_SIZE-1));
-			restore_flags(flags);
+			local_irq_restore(flags);
 			buf += c;
 			count -= c;
 			ret += c;
 		}
 		up(&tmp_buf_sem);
 	} else {
-		cli();
+		local_irq_disable();
 		while (1) {
 			c = CIRC_SPACE_TO_END(info->xmit.head,
 					      info->xmit.tail,
@@ -987,20 +987,20 @@
 			count -= c;
 			ret += c;
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	if (info->xmit.head != info->xmit.tail
 	    && !tty->stopped
 	    && !tty->hw_stopped
 	    && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
-		cli();
+		local_irq_disable();
 		custom.intena = IF_SETCLR | IF_TBE;
 		mb();
 		/* set a pending Tx Interrupt, transmitter should restart now */
 		custom.intreq = IF_SETCLR | IF_TBE;
 		mb();
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	return ret;
 }
@@ -1030,9 +1030,9 @@
 
 	if (serial_paranoia_check(info, tty->device, "rs_flush_buffer"))
 		return;
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	info->xmit.head = info->xmit.tail = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	wake_up_interruptible(&tty->write_wait);
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
 	    tty->ldisc.write_wakeup)
@@ -1056,8 +1056,7 @@
 		/* Make sure transmit interrupts are on */
 
 	        /* Check this ! */
-	        save_flags(flags);
-		cli();
+	        local_irq_save(flags);
 		if(!(custom.intenar & IF_TBE)) {
 		    custom.intena = IF_SETCLR | IF_TBE;
 		    mb();
@@ -1065,7 +1064,7 @@
 		    custom.intreq = IF_SETCLR | IF_TBE;
 		    mb();
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 		info->IER |= UART_IER_THRI;
 	}
@@ -1099,9 +1098,9 @@
 	if (tty->termios->c_cflag & CRTSCTS)
 		info->MCR &= ~SER_RTS;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	rtsdtr_ctrl(info->MCR);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_unthrottle(struct tty_struct * tty)
@@ -1126,9 +1125,9 @@
 	}
 	if (tty->termios->c_cflag & CRTSCTS)
 		info->MCR |= SER_RTS;
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	rtsdtr_ctrl(info->MCR);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -1249,10 +1248,10 @@
 	unsigned int result;
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	status = custom.serdatr;
 	mb();
-	restore_flags(flags);
+	local_irq_restore(flags);
 	result = ((status & SDR_TSRE) ? TIOCSER_TEMT : 0);
 	if (copy_to_user(value, &result, sizeof(int)))
 		return -EFAULT;
@@ -1267,9 +1266,9 @@
 	unsigned long flags;
 
 	control = info->MCR;
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	status = ciab.pra;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	result =  ((control & SER_RTS) ? TIOCM_RTS : 0)
 		| ((control & SER_DTR) ? TIOCM_DTR : 0)
 		| (!(status  & SER_DCD) ? TIOCM_CAR : 0)
@@ -1310,9 +1309,9 @@
 	default:
 		return -EINVAL;
 	}
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	rtsdtr_ctrl(info->MCR);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -1327,13 +1326,13 @@
 	if (serial_paranoia_check(info, tty->device, "rs_break"))
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (break_state == -1)
 	  custom.adkcon = AC_SETCLR | AC_UARTBRK;
 	else
 	  custom.adkcon = AC_UARTBRK;
 	mb();
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -1387,18 +1386,18 @@
 		 * Caller should use TIOCGICOUNT to see which one it was
 		 */
 		case TIOCMIWAIT:
-			save_flags(flags); cli();
+			local_irq_save(flags);
 			/* note the counters on entry */
 			cprev = info->state->icount;
-			restore_flags(flags);
+			local_irq_restore(flags);
 			while (1) {
 				interruptible_sleep_on(&info->delta_msr_wait);
 				/* see if a signal did it */
 				if (signal_pending(current))
 					return -ERESTARTSYS;
-				save_flags(flags); cli();
+				local_irq_save(flags);
 				cnow = info->state->icount; /* atomic copy */
-				restore_flags(flags);
+				local_irq_restore(flags);
 				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr && 
 				    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts)
 					return -EIO; /* no change => error */
@@ -1419,9 +1418,9 @@
 		 *     RI where only 0->1 is counted.
 		 */
 		case TIOCGICOUNT:
-			save_flags(flags); cli();
+			local_irq_save(flags);
 			cnow = info->state->icount;
-			restore_flags(flags);
+			local_irq_restore(flags);
 			icount.cts = cnow.cts;
 			icount.dsr = cnow.dsr;
 			icount.rng = cnow.rng;
@@ -1466,9 +1465,9 @@
 	if ((old_termios->c_cflag & CBAUD) &&
 	    !(cflag & CBAUD)) {
 		info->MCR &= ~(SER_DTR|SER_RTS);
-		save_flags(flags); cli();
+		local_irq_save(flags);
 		rtsdtr_ctrl(info->MCR);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 	/* Handle transition away from B0 status */
@@ -1479,9 +1478,9 @@
 		    !test_bit(TTY_THROTTLED, &tty->flags)) {
 			info->MCR |= SER_RTS;
 		}
-		save_flags(flags); cli();
+		local_irq_save(flags);
 		rtsdtr_ctrl(info->MCR);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 	/* Handle turning off CRTSCTS */
@@ -1525,12 +1524,12 @@
 
 	state = info->state;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
 		MOD_DEC_USE_COUNT;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -1557,7 +1556,7 @@
 	if (state->count) {
 		DBG_CNT("before DEC-2");
 		MOD_DEC_USE_COUNT;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 	info->flags |= ASYNC_CLOSING;
@@ -1617,7 +1616,7 @@
 			 ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
 	MOD_DEC_USE_COUNT;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -1790,19 +1789,19 @@
 	printk("block_til_ready before block: ttys%d, count = %d\n",
 	       state->line, state->count);
 #endif
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (!tty_hung_up_p(filp)) {
 		extra_count = 1;
 		state->count--;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 	info->blocked_open++;
 	while (1) {
-		save_flags(flags); cli();
+		local_irq_save(flags);
 		if (!(info->flags & ASYNC_CALLOUT_ACTIVE) &&
 		    (tty->termios->c_cflag & CBAUD))
 		        rtsdtr_ctrl(SER_DTR|SER_RTS);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(info->flags & ASYNC_INITIALIZED)) {
@@ -2001,10 +2000,10 @@
 		info->quot = 0;
 		info->tty = 0;
 	}
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	status = ciab.pra;
 	control = info ? info->MCR : status;
-	restore_flags(flags); 
+	local_irq_restore(flags);
 
 	stat_buf[0] = 0;
 	stat_buf[1] = 0;
@@ -2197,8 +2196,7 @@
 	state->baud_base = amiga_colorclock;
 	state->xmit_fifo_size = 1;
 
-	save_flags (flags);
-	cli();
+	local_irq_save(flags);
 
 	/* set ISRs, and then disable the rx interrupts */
 	request_irq(IRQ_AMIGA_TBE, ser_tx_int, 0, "serial TX", state);
@@ -2212,7 +2210,7 @@
 	custom.intreq = IF_RBF | IF_TBE;
 	mb();
 
-	restore_flags (flags);
+	local_irq_restore(flags);
 
 	/*
 	 * set the appropriate directions for the modem control flags,
--- linux-2.5.53/drivers/char/ser_a2232.c	Tue Jun 25 20:50:37 2002
+++ linux-m68k-2.5.53/drivers/char/ser_a2232.c	Thu Nov  7 23:05:19 2002
@@ -201,10 +201,9 @@
 	stat->OutDisable = -1;
 
 	/* Does this here really have to be? */
-	save_flags(flags);
-	cli(); 
+	local_irq_save(flags);
 	port->gs.flags &= ~GS_TX_INTEN;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void a2232_enable_tx_interrupts(void *ptr)
@@ -218,10 +217,9 @@
 	stat->OutDisable = 0;
 
 	/* Does this here really have to be? */
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	port->gs.flags |= GS_TX_INTEN;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void a2232_disable_rx_interrupts(void *ptr)
@@ -252,8 +250,7 @@
 	port = ptr;
 	stat = a2232stat(port->which_a2232, port->which_port_on_a2232);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	port->gs.flags &= ~GS_ACTIVE;
 	
@@ -266,7 +263,7 @@
 		stat->Setup = -1;
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	
 	/* After analyzing control flow, I think a2232_shutdown_port
 		is actually the last call from the system when at application
@@ -300,15 +297,14 @@
 	baud = port->gs.baud;
 	if (baud == 0) {
 		/* speed == 0 -> drop DTR, do nothing else */
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		// Clear DTR (and RTS... mhhh).
 		status->Command = (	(status->Command & ~A2232CMD_CMask) |
 					A2232CMD_Close );
 		status->OutFlush = -1;
 		status->Setup = -1;
 		
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return 0;
 	}
 	
@@ -387,8 +383,7 @@
 
 
 	/* Now we have all parameters and can go to set them: */
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	status->Param = a2232_param | A2232PARAM_RcvBaud;
 	status->Command = a2232_cmd | A2232CMD_Open |  A2232CMD_Enable;
@@ -396,7 +391,7 @@
 	status->OutDisable = 0;
 	status->Setup = -1;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
--- linux-2.5.53/drivers/char/vme_scc.c	Thu Oct 31 10:15:04 2002
+++ linux-m68k-2.5.53/drivers/char/vme_scc.c	Thu Nov  7 23:06:42 2002
@@ -624,11 +624,10 @@
 	unsigned long	flags;
 	SCC_ACCESS_INIT(port);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	SCCmod(INT_AND_DMA_REG, ~IDR_TX_INT_ENAB, 0);
 	port->gs.flags &= ~GS_TX_INTEN;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -638,12 +637,11 @@
 	unsigned long	flags;
 	SCC_ACCESS_INIT(port);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	SCCmod(INT_AND_DMA_REG, 0xff, IDR_TX_INT_ENAB);
 	/* restart the transmitter */
 	scc_tx_int (0, port, 0);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -653,11 +651,10 @@
 	unsigned long	flags;
 	SCC_ACCESS_INIT(port);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	SCCmod(INT_AND_DMA_REG,
 	    ~(IDR_RX_INT_MASK|IDR_PARERR_AS_SPCOND|IDR_EXTSTAT_INT_ENAB), 0);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -667,11 +664,10 @@
 	unsigned long	flags;
 	SCC_ACCESS_INIT(port);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	SCCmod(INT_AND_DMA_REG, 0xff,
 		IDR_EXTSTAT_INT_ENAB|IDR_PARERR_AS_SPCOND|IDR_RX_INT_ALL);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -717,10 +713,9 @@
 
 	if (baud == 0) {
 		/* speed == 0 -> drop DTR */
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		SCCmod(TX_CTRL_REG, ~TCR_DTR, 0);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return 0;
 	}
 	else if ((MACH_IS_MVME16x && (baud < 50 || baud > 38400)) ||
@@ -748,8 +743,7 @@
 		brgval = (BVME_SCC_RTxC + baud/2) / (16 * 2 * baud) - 2;
 #endif
 	/* Now we have all parameters and can go to set them: */
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	/* receiver's character size and auto-enables */
 	SCCmod(RX_CTRL_REG, ~(RCR_CHSIZE_MASK|RCR_AUTO_ENAB_MODE),
@@ -773,7 +767,7 @@
 	/* BRG enable, and clock source never changes */
 	SCCmod(DPLL_CTRL_REG, 0xff, DCR_BRG_ENAB);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -823,13 +817,12 @@
 	unsigned char t;
 	SCC_ACCESS_INIT(port);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	t = SCCread(TX_CTRL_REG);
 	if (dtr >= 0) t = dtr? (t | TCR_DTR): (t & ~TCR_DTR);
 	if (rts >= 0) t = rts? (t | TCR_RTS): (t & ~TCR_RTS);
 	SCCwrite(TX_CTRL_REG, t);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -914,8 +907,7 @@
 	};
 #endif
 	if (!(port->gs.flags & ASYNC_INITIALIZED)) {
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 #if defined(CONFIG_MVME147_SCC) || defined(CONFIG_MVME162_SCC)
 		if (MACH_IS_MVME147 || MACH_IS_MVME16x) {
 			for (i=0; i<sizeof(mvme_init_tab)/sizeof(*mvme_init_tab); ++i)
@@ -934,7 +926,7 @@
 
 		port->c_dcd = 0;	/* Prevent initial 1->0 interrupt */
 		scc_setsignals (port, 1,1);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 	tty->driver_data = port;
@@ -982,10 +974,9 @@
 	SCC_ACCESS_INIT(port);
 
 	if (tty->termios->c_cflag & CRTSCTS) {
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		SCCmod(TX_CTRL_REG, ~TCR_RTS, 0);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	if (I_IXOFF(tty))
 		scc_send_xchar(tty, STOP_CHAR(tty));
@@ -999,10 +990,9 @@
 	SCC_ACCESS_INIT(port);
 
 	if (tty->termios->c_cflag & CRTSCTS) {
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		SCCmod(TX_CTRL_REG, 0xff, TCR_RTS);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	if (I_IXOFF(tty))
 		scc_send_xchar(tty, START_CHAR(tty));
@@ -1022,11 +1012,10 @@
 	unsigned long	flags;
 	SCC_ACCESS_INIT(port);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	SCCmod(TX_CTRL_REG, ~TCR_SEND_BREAK, 
 			break_state ? TCR_SEND_BREAK : 0);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -1069,8 +1058,7 @@
 {
 	unsigned long	flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	while (count--)
 	{
@@ -1078,7 +1066,7 @@
 			scc_ch_write ('\r');
 		scc_ch_write (*str++);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static kdev_t scc_console_device(struct console *c)
--- linux-2.5.53/drivers/char/serial167.c	Mon Nov 11 10:19:16 2002
+++ linux-m68k-2.5.53/drivers/char/serial167.c	Mon Nov 11 11:13:26 2002
@@ -274,18 +274,18 @@
 void
 SP(char *data){
   unsigned long flags;
-    save_flags(flags); cli();
+    local_irq_save(flags);
         console_print(data);
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
 char scrn[2];
 void
 CP(char data){
   unsigned long flags;
-    save_flags(flags); cli();
+    local_irq_save(flags);
         scrn[0] = data;
         console_print(scrn);
-    restore_flags(flags);
+    local_irq_restore(flags);
 }/* CP */
 
 void CP1(int data) { (data<10)?  CP(data+'0'): CP(data+'A'-10); }/* CP1 */
@@ -305,7 +305,7 @@
   unsigned long flags;
   volatile int  i;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	/* Check to see that the previous command has completed */
 	for(i = 0 ; i < 100 ; i++){
 	    if (base_addr[CyCCR] == 0){
@@ -316,13 +316,13 @@
 	/* if the CCR never cleared, the previous command
 	    didn't finish within the "reasonable time" */
 	if ( i == 10 ) {
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	    return (-1);
 	}
 
 	/* Issue the new command */
 	base_addr[CyCCR] = cmd;
-    restore_flags(flags);
+    local_irq_restore(flags);
     return(0);
 } /* write_cy_cmd */
 
@@ -347,10 +347,10 @@
 	
     channel = info->line;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
         base_addr[CyCAR] = (u_char)(channel); /* index channel */
         base_addr[CyIER] &= ~(CyTxMpty|CyTxRdy);
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     return;
 } /* cy_stop */
@@ -372,10 +372,10 @@
 	
     channel = info->line;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
         base_addr[CyCAR] = (u_char)(channel);
         base_addr[CyIER] |= CyTxMpty;
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     return;
 } /* cy_start */
@@ -816,7 +816,7 @@
     printk("startup channel %d\n", channel);
 #endif
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	base_addr[CyCAR] = (u_char)channel;
 	write_cy_cmd(base_addr,CyENB_RCVR|CyENB_XMTR);
 
@@ -838,7 +838,7 @@
 	}
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 
 #ifdef SERIAL_DEBUG_OPEN
     printk(" done\n");
@@ -854,10 +854,10 @@
   int channel;
 
     channel = info->line;
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	base_addr[CyCAR] = channel;
 	base_addr[CyIER] |= CyTxMpty;
-    restore_flags(flags);
+    local_irq_restore(flags);
 } /* start_xmit */
 
 /*
@@ -888,7 +888,7 @@
        Other choices are to delay some fixed interval
        or schedule some later processing.
      */
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	if (info->xmit_buf){
 	    free_page((unsigned long) info->xmit_buf);
 	    info->xmit_buf = 0;
@@ -912,7 +912,7 @@
 	    set_bit(TTY_IO_ERROR, &info->tty->flags);
 	}
 	info->flags &= ~ASYNC_INITIALIZED;
-    restore_flags(flags);
+    local_irq_restore(flags);
 
 #ifdef SERIAL_DEBUG_OPEN
     printk(" done\n");
@@ -1079,7 +1079,7 @@
 
     channel = info->line;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	base_addr[CyCAR] = (u_char)channel;
 
 	/* CyCMR set once only in mvme167_init_serial() */
@@ -1159,7 +1159,7 @@
 	    clear_bit(TTY_IO_ERROR, &info->tty->flags);
 	}
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 
 } /* config_setup */
 
@@ -1180,16 +1180,16 @@
     if (!tty || !info->xmit_buf)
 	return;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	if (info->xmit_cnt >= PAGE_SIZE - 1) {
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	    return;
 	}
 
 	info->xmit_buf[info->xmit_head++] = ch;
 	info->xmit_head &= PAGE_SIZE - 1;
 	info->xmit_cnt++;
-    restore_flags(flags);
+    local_irq_restore(flags);
 } /* cy_put_char */
 
 
@@ -1214,10 +1214,10 @@
 
     channel = info->line;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	base_addr[CyCAR] = channel;
 	base_addr[CyIER] |= CyTxMpty;
-    restore_flags(flags);
+    local_irq_restore(flags);
 } /* cy_flush_chars */
 
 
@@ -1262,13 +1262,13 @@
 			    break;
 		    }
 
-		    save_flags(flags); cli();		
+		    local_irq_save(flags);
 		    c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 				   SERIAL_XMIT_SIZE - info->xmit_head));
 		    memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
 		    info->xmit_head = (info->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 		    info->xmit_cnt += c;
-		    restore_flags(flags);
+		    local_irq_restore(flags);
 
 		    buf += c;
 		    count -= c;
@@ -1277,18 +1277,18 @@
 	    up(&tmp_buf_sem);
     } else {
 	    while (1) {
-		    save_flags(flags); cli();		
+		    local_irq_save(flags);
 		    c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 				       SERIAL_XMIT_SIZE - info->xmit_head));
 		    if (c <= 0) {
-			    restore_flags(flags);
+			    local_irq_restore(flags);
 			    break;
 		    }
 
 		    memcpy(info->xmit_buf + info->xmit_head, buf, c);
 		    info->xmit_head = (info->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 		    info->xmit_cnt += c;
-		    restore_flags(flags);
+		    local_irq_restore(flags);
 
 		    buf += c;
 		    count -= c;
@@ -1352,9 +1352,9 @@
 
     if (serial_paranoia_check(info, tty->device, "cy_flush_buffer"))
 	return;
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-    restore_flags(flags);
+    local_irq_restore(flags);
     wake_up_interruptible(&tty->write_wait);
     if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP))
     && tty->ldisc.write_wakeup)
@@ -1393,10 +1393,10 @@
 
     channel = info->line;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	base_addr[CyCAR] = (u_char)channel;
 	base_addr[CyMSVR1] = 0;
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     return;
 } /* cy_throttle */
@@ -1429,10 +1429,10 @@
 
     channel = info->line;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 	base_addr[CyCAR] = (u_char)channel;
 	base_addr[CyMSVR1] = CyRTS;
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     return;
 } /* cy_unthrottle */
@@ -1514,10 +1514,10 @@
 
     channel = info->line;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
         base_addr[CyCAR] = (u_char)channel;
         status = base_addr[CyMSVR1] | base_addr[CyMSVR2];
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     result =  ((status  & CyRTS) ? TIOCM_RTS : 0)
             | ((status  & CyDTR) ? TIOCM_DTR : 0)
@@ -1543,13 +1543,13 @@
     switch (cmd) {
     case TIOCMBIS:
 	if (arg & TIOCM_RTS){
-	    save_flags(flags); cli();
+	    local_irq_save(flags);
 		base_addr[CyCAR] = (u_char)channel;
 		base_addr[CyMSVR1] = CyRTS;
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	}
 	if (arg & TIOCM_DTR){
-	    save_flags(flags); cli();
+	    local_irq_save(flags);
 	    base_addr[CyCAR] = (u_char)channel;
 /* CP('S');CP('2'); */
 	    base_addr[CyMSVR2] = CyDTR;
@@ -1557,18 +1557,18 @@
             printk("cyc: %d: raising DTR\n", __LINE__);
             printk("     status: 0x%x, 0x%x\n", base_addr[CyMSVR1], base_addr[CyMSVR2]);
 #endif
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	}
 	break;
     case TIOCMBIC:
 	if (arg & TIOCM_RTS){
-	    save_flags(flags); cli();
+	    local_irq_save(flags);
 		base_addr[CyCAR] = (u_char)channel;
 		base_addr[CyMSVR1] = 0;
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	}
 	if (arg & TIOCM_DTR){
-	    save_flags(flags); cli();
+	    local_irq_save(flags);
 	    base_addr[CyCAR] = (u_char)channel;
 /* CP('C');CP('2'); */
 	    base_addr[CyMSVR2] = 0;
@@ -1576,23 +1576,23 @@
             printk("cyc: %d: dropping DTR\n", __LINE__);
             printk("     status: 0x%x, 0x%x\n", base_addr[CyMSVR1], base_addr[CyMSVR2]);
 #endif
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	}
 	break;
     case TIOCMSET:
 	if (arg & TIOCM_RTS){
-	    save_flags(flags); cli();
+	    local_irq_save(flags);
 		base_addr[CyCAR] = (u_char)channel;
 		base_addr[CyMSVR1] = CyRTS;
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	}else{
-	    save_flags(flags); cli();
+	    local_irq_save(flags);
 		base_addr[CyCAR] = (u_char)channel;
 		base_addr[CyMSVR1] = 0;
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	}
 	if (arg & TIOCM_DTR){
-	    save_flags(flags); cli();
+	    local_irq_save(flags);
 	    base_addr[CyCAR] = (u_char)channel;
 /* CP('S');CP('3'); */
 	    base_addr[CyMSVR2] = CyDTR;
@@ -1600,9 +1600,9 @@
             printk("cyc: %d: raising DTR\n", __LINE__);
             printk("     status: 0x%x, 0x%x\n", base_addr[CyMSVR1], base_addr[CyMSVR2]);
 #endif
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	}else{
-	    save_flags(flags); cli();
+	    local_irq_save(flags);
 	    base_addr[CyCAR] = (u_char)channel;
 /* CP('C');CP('3'); */
 	    base_addr[CyMSVR2] = 0;
@@ -1610,7 +1610,7 @@
             printk("cyc: %d: dropping DTR\n", __LINE__);
             printk("     status: 0x%x, 0x%x\n", base_addr[CyMSVR1], base_addr[CyMSVR2]);
 #endif
-	    restore_flags(flags);
+	    local_irq_restore(flags);
 	}
 	break;
     default:
@@ -2060,7 +2060,7 @@
     channel = info->line;
 
     while (1) {
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	    if (!(info->flags & ASYNC_CALLOUT_ACTIVE)){
 		base_addr[CyCAR] = (u_char)channel;
 		base_addr[CyMSVR1] = CyRTS;
@@ -2071,7 +2071,7 @@
                 printk("     status: 0x%x, 0x%x\n", base_addr[CyMSVR1], base_addr[CyMSVR2]);
 #endif
 	    }
-	restore_flags(flags);
+	local_irq_restore(flags);
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (tty_hung_up_p(filp)
 	|| !(info->flags & ASYNC_INITIALIZED) ){
@@ -2082,17 +2082,17 @@
 	    }
 	    break;
 	}
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	    base_addr[CyCAR] = (u_char)channel;
 /* CP('L');CP1(1 && C_CLOCAL(tty)); CP1(1 && (base_addr[CyMSVR1] & CyDCD) ); */
 	    if (!(info->flags & ASYNC_CALLOUT_ACTIVE)
 	    && !(info->flags & ASYNC_CLOSING)
 	    && (C_CLOCAL(tty)
 	        || (base_addr[CyMSVR1] & CyDCD))) {
-		    restore_flags(flags);
+		    local_irq_restore(flags);
 		    break;
 	    }
-	restore_flags(flags);
+	local_irq_restore(flags);
 	if (signal_pending(current)) {
 	    retval = -ERESTARTSYS;
 	    break;
@@ -2238,7 +2238,7 @@
 	u_char rcor, rbpr, badspeed = 0;
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	/*
 	 * First probe channel zero of the chip, to see what speed has
@@ -2263,7 +2263,7 @@
 
         my_udelay(20000L);	/* Allow time for any active o/p to complete */
         if(base_addr[CyCCR] != 0x00){
-            restore_flags(flags);
+            local_irq_restore(flags);
             /* printk(" chip is never idle (CCR != 0)\n"); */
             return;
         }
@@ -2272,7 +2272,7 @@
         my_udelay(1000L);
 
         if(base_addr[CyGFRCR] == 0x00){
-            restore_flags(flags);
+            local_irq_restore(flags);
             /* printk(" chip is not responding (GFRCR stayed 0)\n"); */
             return;
         }
@@ -2331,7 +2331,7 @@
 	base_addr[CyIER] = CyRxData;
 	write_cy_cmd(base_addr,CyENB_RCVR|CyENB_XMTR);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	my_udelay(20000L);	/* Let it all settle down */
 
@@ -2606,7 +2606,7 @@
              info->session, info->pgrp, (long)info->open_wait);
 
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 
 /* Global Registers */
 
@@ -2664,7 +2664,7 @@
 	printk(" CyTBPR %x\n", base_addr[CyTBPR]);
 	printk(" CyTCOR %x\n", base_addr[CyTCOR]);
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 } /* show_status */
 #endif
 
@@ -2764,7 +2764,7 @@
 	u_char do_lf = 0;
 	int i = 0;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	/* Ensure transmitter is enabled! */
 
@@ -2811,7 +2811,7 @@
 
 	base_addr[CyIER] = ier;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static kdev_t serial167_console_device(struct console *c)
@@ -2855,7 +2855,7 @@
 	u_char ier;
 	int port;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	/* Ensure transmitter is enabled! */
 
@@ -2885,7 +2885,7 @@
 
 	base_addr[CyIER] = ier;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 int getDebugChar()
@@ -2907,7 +2907,7 @@
 	}
 	/* OK, nothing in queue, wait in poll loop */
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	/* Ensure receiver is enabled! */
 
@@ -2953,7 +2953,7 @@
 
 	base_addr[CyIER] = ier;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return (c);
 }
@@ -2979,7 +2979,7 @@
 
     cflag = B19200;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 
     for (i = 0; i < 4; i++)
     {
@@ -3034,7 +3034,7 @@
 
     base_addr[CyIER] = CyRxData;
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 
 } /* debug_setup */
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
