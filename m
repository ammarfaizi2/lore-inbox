Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266859AbUBGLxF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266873AbUBGLxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:53:05 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:52864 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266859AbUBGLwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:52:36 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Len Brown <len.brown@intel.com>
Subject: Re: swusp acpi
Date: Sat, 7 Feb 2004 19:50:15 +0800
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E83B3@hdsmsx402.hd.intel.com> <1076138717.2562.1801.camel@dhcppc4>
In-Reply-To: <1076138717.2562.1801.camel@dhcppc4>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3DNJAEEMk9eBwhS"
Message-Id: <200402071950.15360.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3DNJAEEMk9eBwhS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Len,

On Saturday 07 February 2004 15:25, Len Brown wrote:
> Michael,
> my serial console is toast on 2.6 after resume.  Can you point me to
> said patch?
> 

Patch for 2.4.[345] enclosed. Apply alpha than alpha2. 

software-suspend-linux-2.4.24-rev7-whole.bz2 on swsusp.sf.net
has some minor updates wrt tidyness and not resuming (PCMCIA) 
serial ports after being removed.

Please note that the 2.6 driver is very different.

Russel King may have some patches he called "too ugly" to be merged, 
perhaps these could be used even if not merged.

Regards
Michael


--Boundary-00=_3DNJAEEMk9eBwhS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="serial-2.4.23-pm-alpha2-incremental.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="serial-2.4.23-pm-alpha2-incremental.diff"

--- linux-2.4.23-mhf145/drivers/char/serial.c	2004-01-02 13:09:24.000000000 +0800
+++ linux-2.4.23-mhf146/drivers/char/serial.c	2004-01-03 03:38:49.000000000 +0800
@@ -1359,21 +1430,8 @@
 	unsigned short ICP;
 #endif
 
-  serial_outp(info, UART_LCR, UART_LCR_WLEN8);	/* reset DLAB */
+	serial_outp(info, UART_LCR, UART_LCR_WLEN8);	/* reset DLAB */
 
-	info->MCR = 0;
-	if (info->tty->termios->c_cflag & CBAUD)
-		info->MCR = UART_MCR_DTR | UART_MCR_RTS;
-#ifdef CONFIG_SERIAL_MANY_PORTS
-	if (info->flags & ASYNC_FOURPORT) {
-		if (state->irq == 0)
-			info->MCR |= UART_MCR_OUT1;
-	} else
-#endif
-	{
-		if (state->irq != 0)
-			info->MCR |= UART_MCR_OUT2;
-	}
 	info->MCR |= ALPHA_KLUDGE_MCR; 		/* Don't ask */
 	serial_outp(info, UART_MCR, info->MCR);
 	
@@ -1466,6 +1524,20 @@
 	printk("starting up ttys%d (irq %d)...", info->line, state->irq);
 #endif
 
+	info->MCR = 0;
+	if (info->tty->termios->c_cflag & CBAUD)
+		info->MCR = UART_MCR_DTR | UART_MCR_RTS;
+#ifdef CONFIG_SERIAL_MANY_PORTS
+	if (info->flags & ASYNC_FOURPORT) {
+		if (state->irq == 0)
+			info->MCR |= UART_MCR_OUT1;
+	} else
+#endif
+	{
+		if (state->irq != 0)
+			info->MCR |= UART_MCR_OUT2;
+	}
+
 	start_uart(info);
 
 	/*

--Boundary-00=_3DNJAEEMk9eBwhS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="serial-2.4.23-pm-alpha.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="serial-2.4.23-pm-alpha.diff"

diff -uN linux-2.4.23-mhf145/drivers/char/serial.c.mhf.orig linux-2.4.23-mhf145/drivers/char/serial.c
--- linux-2.4.23-mhf145/drivers/char/serial.c.mhf.orig	2003-12-02 05:37:49.000000000 +0800
+++ linux-2.4.23-mhf145/drivers/char/serial.c	2004-01-02 13:04:40.000000000 +0800
@@ -62,10 +62,14 @@
  *        Robert Schwebel <robert@schwebel.de>,
  *        Juergen Beisert <jbeisert@eurodsn.de>,
  *        Theodore Ts'o <tytso@mit.edu>
+ *
+ * 01/04: Verion: 5.1
+ *        Add PM suspend/resume support
+ *        Michael Frank <mhf@linuxmail.org>
  */
 
-static char *serial_version = "5.05c";
-static char *serial_revdate = "2001-07-08";
+static char *serial_version = "5.1-alpha";
+static char *serial_revdate = "2004-01-01";
 
 /*
  * Serial driver configuration section.  Here are the various options:
@@ -203,6 +207,9 @@
 #include <linux/ioport.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
 #if (LINUX_VERSION_CODE >= 131343)
 #include <linux/init.h>
 #endif
@@ -1208,44 +1215,16 @@
 }
 #endif /* CONFIG_SERIAL_RSA */
 
-static int startup(struct async_struct * info)
+/*
+ * Starts the uart
+ */
+
+int start_uart(struct async_struct * info)
 {
-	unsigned long flags;
 	int	retval=0;
-	void (*handler)(int, void *, struct pt_regs *);
 	struct serial_state *state= info->state;
-	unsigned long page;
-#ifdef CONFIG_SERIAL_MANY_PORTS
-	unsigned short ICP;
-#endif
 
-	page = get_zeroed_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	save_flags(flags); cli();
-
-	if (info->flags & ASYNC_INITIALIZED) {
-		free_page(page);
-		goto errout;
-	}
-
-	if (!CONFIGURED_SERIAL_PORT(state) || !state->type) {
-		if (info->tty)
-			set_bit(TTY_IO_ERROR, &info->tty->flags);
-		free_page(page);
-		goto errout;
-	}
-	if (info->xmit.buf)
-		free_page(page);
-	else
-		info->xmit.buf = (unsigned char *) page;
-
-#ifdef SERIAL_DEBUG_OPEN
-	printk("starting up ttys%d (irq %d)...", info->line, state->irq);
-#endif
-
-	if (uart_config[state->type].flags & UART_STARTECH) {
+  if (uart_config[state->type].flags & UART_STARTECH) {
 		/* Wake up UART */
 		serial_outp(info, UART_LCR, 0xBF);
 		serial_outp(info, UART_EFR, UART_EFR_ECB);
@@ -1341,55 +1320,19 @@
 			retval = -ENODEV;
 		goto errout;
 	}
-	
-	/*
-	 * Allocate the IRQ if necessary
-	 */
-	if (state->irq && (!IRQ_ports[state->irq] ||
-			  !IRQ_ports[state->irq]->next_port)) {
-		if (IRQ_ports[state->irq]) {
-#ifdef CONFIG_SERIAL_SHARE_IRQ
-			free_irq(state->irq, &IRQ_ports[state->irq]);
-#ifdef CONFIG_SERIAL_MULTIPORT				
-			if (rs_multiport[state->irq].port1)
-				handler = rs_interrupt_multi;
-			else
-#endif
-				handler = rs_interrupt;
-#else
-			retval = -EBUSY;
-			goto errout;
-#endif /* CONFIG_SERIAL_SHARE_IRQ */
-		} else 
-			handler = rs_interrupt_single;
-
-		retval = request_irq(state->irq, handler, SA_SHIRQ,
-				     "serial", &IRQ_ports[state->irq]);
-		if (retval) {
-			if (capable(CAP_SYS_ADMIN)) {
-				if (info->tty)
-					set_bit(TTY_IO_ERROR,
-						&info->tty->flags);
-				retval = 0;
-			}
-			goto errout;
-		}
-	}
+errout:
+	return retval;
+}
 
-	/*
-	 * Insert serial port into IRQ chain.
-	 */
-	info->prev_port = 0;
-	info->next_port = IRQ_ports[state->irq];
-	if (info->next_port)
-		info->next_port->prev_port = info;
-	IRQ_ports[state->irq] = info;
-	figure_IRQ_timeout(state->irq);
+int init_uart(struct async_struct * info)
+{
+	int	retval=0;
+	struct serial_state *state= info->state;
+#ifdef CONFIG_SERIAL_MANY_PORTS
+	unsigned short ICP;
+#endif
 
-	/*
-	 * Now, initialize the UART 
-	 */
-	serial_outp(info, UART_LCR, UART_LCR_WLEN8);	/* reset DLAB */
+  serial_outp(info, UART_LCR, UART_LCR_WLEN8);	/* reset DLAB */
 
 	info->MCR = 0;
 	if (info->tty->termios->c_cflag & CBAUD)
@@ -1459,6 +1402,94 @@
 	 * and set the speed of the serial port
 	 */
 	change_speed(info, 0);
+	return retval;
+}
+
+static int startup(struct async_struct * info)
+{
+	unsigned long flags;
+	int	retval=0;
+	void (*handler)(int, void *, struct pt_regs *);
+	struct serial_state *state= info->state;
+	unsigned long page;
+
+	page = get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	save_flags(flags); cli();
+
+	if (info->flags & ASYNC_INITIALIZED) {
+		free_page(page);
+		goto errout;
+	}
+
+	if (!CONFIGURED_SERIAL_PORT(state) || !state->type) {
+		if (info->tty)
+			set_bit(TTY_IO_ERROR, &info->tty->flags);
+		free_page(page);
+		goto errout;
+	}
+	if (info->xmit.buf)
+		free_page(page);
+	else
+		info->xmit.buf = (unsigned char *) page;
+
+#ifdef SERIAL_DEBUG_OPEN
+	printk("starting up ttys%d (irq %d)...", info->line, state->irq);
+#endif
+
+	start_uart(info);
+
+	/*
+	 * Allocate the IRQ if necessary
+	 */
+	if (state->irq && (!IRQ_ports[state->irq] ||
+			  !IRQ_ports[state->irq]->next_port)) {
+		if (IRQ_ports[state->irq]) {
+#ifdef CONFIG_SERIAL_SHARE_IRQ
+			free_irq(state->irq, &IRQ_ports[state->irq]);
+#ifdef CONFIG_SERIAL_MULTIPORT				
+			if (rs_multiport[state->irq].port1)
+				handler = rs_interrupt_multi;
+			else
+#endif
+				handler = rs_interrupt;
+#else
+			retval = -EBUSY;
+			goto errout;
+#endif /* CONFIG_SERIAL_SHARE_IRQ */
+		} else 
+			handler = rs_interrupt_single;
+
+		retval = request_irq(state->irq, handler, SA_SHIRQ,
+				     "serial", &IRQ_ports[state->irq]);
+		if (retval) {
+			if (capable(CAP_SYS_ADMIN)) {
+				if (info->tty)
+					set_bit(TTY_IO_ERROR,
+						&info->tty->flags);
+				retval = 0;
+			}
+			goto errout;
+		}
+	}
+
+	/*
+	 * Insert serial port into IRQ chain.
+	 */
+	info->prev_port = 0;
+	info->next_port = IRQ_ports[state->irq];
+	if (info->next_port)
+		info->next_port->prev_port = info;
+	IRQ_ports[state->irq] = info;
+	figure_IRQ_timeout(state->irq);
+
+	/*
+	 * Now, initialize the UART 
+	 */
+
+	init_uart(info);
 
 	info->flags |= ASYNC_INITIALIZED;
 	restore_flags(flags);
@@ -1470,6 +1501,33 @@
 }
 
 /*
+ * Sleep capable UART
+ */
+
+static void sleep_uart(struct async_struct * info)
+{
+	(void)serial_in(info, UART_RX);    /* read data port to reset things */
+	
+	if (info->tty)
+		set_bit(TTY_IO_ERROR, &info->tty->flags);
+
+	if (uart_config[info->state->type].flags & UART_STARTECH) {
+		/* Arrange to enter sleep mode */
+		serial_outp(info, UART_LCR, 0xBF);
+		serial_outp(info, UART_EFR, UART_EFR_ECB);
+		serial_outp(info, UART_LCR, 0);
+		serial_outp(info, UART_IER, UART_IERX_SLEEP);
+		serial_outp(info, UART_LCR, 0xBF);
+		serial_outp(info, UART_EFR, 0);
+		serial_outp(info, UART_LCR, 0);
+	}
+	if (info->state->type == PORT_16750) {
+		/* Arrange to enter sleep mode */
+		serial_outp(info, UART_IER, UART_IERX_SLEEP);
+	}
+}
+
+/*
  * This routine will shutdown a serial port; interrupts are disabled, and
  * DTR is dropped if the hangup on close termio flag is on.
  */
@@ -1566,27 +1624,9 @@
 	     disable_rsa(info)))
 		state->baud_base = SERIAL_RSA_BAUD_BASE_LO;
 #endif
-	
 
-	(void)serial_in(info, UART_RX);    /* read data port to reset things */
-	
-	if (info->tty)
-		set_bit(TTY_IO_ERROR, &info->tty->flags);
+	sleep_uart(info);
 
-	if (uart_config[info->state->type].flags & UART_STARTECH) {
-		/* Arrange to enter sleep mode */
-		serial_outp(info, UART_LCR, 0xBF);
-		serial_outp(info, UART_EFR, UART_EFR_ECB);
-		serial_outp(info, UART_LCR, 0);
-		serial_outp(info, UART_IER, UART_IERX_SLEEP);
-		serial_outp(info, UART_LCR, 0xBF);
-		serial_outp(info, UART_EFR, 0);
-		serial_outp(info, UART_LCR, 0);
-	}
-	if (info->state->type == PORT_16750) {
-		/* Arrange to enter sleep mode */
-		serial_outp(info, UART_IER, UART_IERX_SLEEP);
-	}
 	info->flags &= ~ASYNC_INITIALIZED;
 	restore_flags(flags);
 }
@@ -3250,6 +3290,110 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM
+
+/*
+ * Suspend an UART
+ */
+
+static int rs_suspend_uart(struct async_struct *info)
+{
+	int retval = 0;
+	printk("serio: Suspending %lx\n", info->port);
+
+	/* disable all intrs */
+	serial_outp(info, UART_IER, 0x00);
+
+	/* disable break condition */
+	serial_out(info, UART_LCR, serial_inp(info, UART_LCR) & ~UART_LCR_SBC);
+
+	/* Disable line */
+	if (!info->tty || (info->tty->termios->c_cflag & HUPCL))
+		serial_outp(info, UART_MCR,(info->MCR & ~(UART_MCR_DTR|UART_MCR_RTS)));
+
+	/* put UART to sleep */
+	sleep_uart(info);
+
+	if (retval)
+		info->flags &= ~ASYNC_INITIALIZED;
+	return retval;
+}
+static int rs_suspend(struct tty_struct *tty)
+{
+	int retval = 0;
+	unsigned long flags;
+	save_flags(flags); cli();
+
+	retval = rs_suspend_uart((struct async_struct *)tty->driver_data);
+
+	restore_flags(flags);
+	return retval;
+}
+
+/*
+ * Resume an UART
+ */
+
+/* Todo: eval multiport interrupt resume */
+
+static int rs_resume_uart(struct async_struct *info)
+{
+	int retval = 0;
+
+	printk("serio: Resuming %lx\n", info->port);
+
+  if ((retval = start_uart(info)))
+		goto out;
+	retval = init_uart(info);
+out:
+	if (retval)
+		info->flags &= ~ASYNC_INITIALIZED;
+	return retval;
+}
+
+static int rs_resume(struct tty_struct *tty)
+{
+	int retval = 0;
+	unsigned long flags;
+	save_flags(flags); cli();
+
+	retval = rs_resume_uart((struct async_struct *)tty->driver_data);
+
+	restore_flags(flags);
+	return retval;
+}
+
+/*
+ * Suspend or Resume all UARTs
+ */
+
+static int rs_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
+	struct serial_state *state = rs_table;
+	int i;
+	unsigned long flags; /* Interrupts will be reenabled once per iteration */
+
+	printk("serio: pm event 0x%x received\n", rqst);
+
+	for (i =0; i < NR_PORTS; i++, state++) {
+		if (!state->info) /* info is NULL unless port opened */
+			continue;
+
+		save_flags(flags); cli();
+
+		switch (rqst) {
+		case PM_SUSPEND:
+			rs_suspend_uart(state->info);
+			break;
+		case PM_RESUME:
+			rs_resume_uart(state->info);
+		}
+		restore_flags(flags);
+	}
+	return 0;
+}
+#endif
+
 /*
  * /proc fs routines....
  */
@@ -5475,6 +5619,10 @@
 	serial_driver.wait_until_sent = rs_wait_until_sent;
 	serial_driver.read_proc = rs_read_proc;
 #endif
+#ifdef CONFIG_PM
+	serial_driver.suspend = rs_suspend;
+	serial_driver.resume = rs_resume;
+#endif
 	
 	/*
 	 * The callout device is just like normal device except for
@@ -5554,8 +5702,13 @@
 	probe_serial_pci();
 #endif
 #ifdef ENABLE_SERIAL_PNP
-       probe_serial_pnp();
+	probe_serial_pnp();
 #endif
+#ifdef CONFIG_PM
+	if (!pm_register(PM_UNKNOWN_DEV, 0, rs_pm_callback))
+		panic("Couldn't register with PM subsystem\n");
+#endif
+
 	return 0;
 }
 
@@ -5726,6 +5879,7 @@
 	struct async_struct *info;
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
+	pm_unregister_all(rs_pm_callback);
 	del_timer_sync(&serial_timer);
 	save_flags(flags); cli();
         remove_bh(SERIAL_BH);
diff -uN linux-2.4.23-mhf145/include/linux/tty_driver.h.mhf.orig linux-2.4.23-mhf145/include/linux/tty_driver.h
--- linux-2.4.23-mhf145/include/linux/tty_driver.h.mhf.orig	2004-01-02 13:06:39.000000000 +0800
+++ linux-2.4.23-mhf145/include/linux/tty_driver.h	2004-01-02 13:04:40.000000000 +0800
@@ -170,7 +170,10 @@
 			  int count, int *eof, void *data);
 	int (*write_proc)(struct file *file, const char *buffer,
 			  unsigned long count, void *data);
-
+#ifdef CONFIG_PM
+	int (*suspend) (struct tty_struct *tty);
+	int (*resume) (struct tty_struct *tty);
+#endif
 	/*
 	 * linked list pointers
 	 */

--Boundary-00=_3DNJAEEMk9eBwhS--

