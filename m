Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUAWFzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 00:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUAWFzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 00:55:41 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:5578 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265282AbUAWFzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 00:55:21 -0500
From: Michael Frank <mhf@linuxmail.org>
To: ncunningham@users.sourceforge.net, Pavel Machek <pavel@ucw.cz>
Subject: Re: swusp acpi
Date: Fri, 23 Jan 2004 13:51:49 +0800
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401211143.51585.tuxakka@yahoo.co.uk> <20040122102655.GC200@elf.ucw.cz> <1074794904.12773.72.camel@laptop-linux>
In-Reply-To: <1074794904.12773.72.camel@laptop-linux>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401231351.49870.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 January 2004 02:08, Nigel Cunningham wrote:
> Hi.
> 
> Michael Frank has done a patch giving 2.4 PM support for serial ports
> (my serial console now works flawlessly). Perhaps it could be ported to
> 2.6 and the driver model...
> 
> Nigel
> 
> On Thu, 2004-01-22 at 23:26, Pavel Machek wrote:
> > Hi!
> > 
> > > > Not only serial console... Noone wrote serial port support.
> > > 
> > > Incorrect.  I never merged the changes because it's rather too hacky.
> > 
> > Who wrote them? Do you have that patch somewhere?
> > 								Pavel
> -- 
> My work on Software Suspend is graciously brought to you by
> LinuxFund.org.
> 

This patch works fine for standerd serial ports with serial.c compiled in.

We use it mainly to suspend/resume serial consoles.

The patch was implemented with the objective to just move code around
in testable blocks to prevent breaking devices unavailable for testing.

However this patch is not suitable for 2.6 as the 2.6 drivers are 
a rewrite and the old driver and this patch have a number of issues.

- The patch does not touch interupts and relies on the resuming kernel
  to init them for standard serial ports with serial.c compiled in.

- Terefor, device resume would not work with serial.c as a module 
  or some non-standard serial ports because of the foregoing.

- The old driver initializes serial ports in a non-standard way.
  Notably MCR lines and interrupts are enabled prior to setting 
  baud rate. This is unsuitable for suspending while hardware 
  handshaked transfers are ongoing.

- No suspend support for software handshaked transmissions. I think
  the driver should send the current XOFF character in this case.

- The patch does not attempt to fix the above problem to minimize
  disruption and the likelyhood of break device that can't be test.

Another fundamental limitation is that only open ports are resumed, 
  this will  not resume DOSEMU/Win4Lin ports for example. I got a 
  utility for this which reads back the ports from userspace and writes 
  them back on resume. This is a bad fix as some registers can't be 
  read back (FIFO control) and must be set with generic  settings.


Regards
Michael

--- linux-2.4.23-Vanilla/drivers/char/serial.c	2003-12-02 05:37:49.000000000 +0800
+++ linux-2.4.23-mhf156/drivers/char/serial.c	2004-01-17 18:05:43.000000000 +0800
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
@@ -99,6 +103,13 @@
 
 #include <linux/config.h>
 #include <linux/version.h>
+#include <linux/completion.h>
+#include <linux/suspend.h>
+#include <linux/suspend-debug.h>
+
+#ifdef CONFIG_PM
+extern struct completion swsusp_wait_for_shift;
+#endif
 
 #undef SERIAL_PARANOIA_CHECK
 #define CONFIG_SERIAL_NOPAUSE_IO
@@ -203,6 +214,9 @@
 #include <linux/ioport.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
 #if (LINUX_VERSION_CODE >= 131343)
 #include <linux/init.h>
 #endif
@@ -223,6 +237,21 @@
 #include <linux/sysrq.h>
 #endif
 
+#ifdef	CONFIG_KDB
+#include <linux/kdb.h>
+#ifdef	CONFIG_SERIAL_CONSOLE
+/*
+ * kdb_serial_line records the serial line number of the first serial console.
+ * NOTE: The kernel ignores characters on the serial line unless a user space
+ * program has opened the line first.  To enter kdb before user space has opened
+ * the serial line, you can use the 'kdb=early' flag to lilo and set the
+ * appropriate breakpoints.
+ */
+
+static int  kdb_serial_line = -1;
+static const char *kdb_serial_ptr = kdb_serial_str;
+#endif	/* CONFIG_SERIAL_CONSOLE */
+#endif	/* CONFIG_KDB */
 /*
  * All of the compatibilty code so we can compile serial.c against
  * older kernels is hidden in serial_compat.h
@@ -577,6 +606,18 @@
 				return;		// if TTY_DONT_FLIP is set
 		}
 		ch = serial_inp(info, UART_RX);
+#if	defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_KDB)
+		if ((info->line == kdb_serial_line) && kdb_on) {
+		    if (ch == *kdb_serial_ptr) {
+			if (!(*++kdb_serial_ptr)) {
+			    kdb(KDB_REASON_KEYBOARD, 0, regs);
+			    kdb_serial_ptr = kdb_serial_str;
+			    break;
+			}
+		    } else
+			kdb_serial_ptr = kdb_serial_str;
+		}
+#endif	/* CONFIG_SERIAL_CONSOLE && CONFIG_KDB */
 		*tty->flip.char_buf_ptr = ch;
 		icount->rx++;
 		
@@ -638,7 +679,8 @@
 			else if (*status & UART_LSR_FE)
 				*tty->flip.flag_buf_ptr = TTY_FRAME;
 		}
-#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#if defined(CONFIG_SERIAL_CONSOLE)
+#if defined(CONFIG_MAGIC_SYSRQ)
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
@@ -648,7 +690,71 @@
 			}
 			break_pressed = 0;
 		}
+#endif	/* CONFIG_MAGIC_SYSRQ */
+
+#ifdef CONFIG_PM
+	if ((software_suspend_state & SOFTWARE_SUSPEND_RUNNING) ||
+		waitqueue_active(&swsusp_wait_for_shift.wait)) {
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+		extern void prepare_status(int printalways, int clearbar, const char *fmt, ...);
+		extern unsigned long swsusp_action;
+		extern void request_abort_suspend(void);
+		
+		switch (ch) {
+			case 27:
+				/* Abort suspend */
+				if (TEST_ACTION_STATE(SUSPEND_CAN_CANCEL))
+					request_abort_suspend();
+				break;
+			case 49:
+				console_loglevel = 1;
+				break;
+			case 48:
+				console_loglevel = 0;
+				break;
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+			case 80:
+			case 112:
+				/* During suspend, toggle pausing with Pause or Break if kdb active */
+				swsusp_action ^= (1 << SUSPEND_PAUSE);
+				prepare_status(1, 0, "Pausing %s.\n", 
+					TEST_ACTION_STATE(SUSPEND_PAUSE) ? "enabled" : "disabled");
+				if (!TEST_ACTION_STATE(SUSPEND_PAUSE))
+					complete(&swsusp_wait_for_shift);
+				break;
+			case 82:
+			case 114:
+				/* Otherwise, if R pressed, toggle rebooting */
+				swsusp_action ^= (1 << SUSPEND_REBOOT);
+				prepare_status(1, 0, "Rebooting %s.\n", 
+					TEST_ACTION_STATE(SUSPEND_REBOOT) ? "enabled" : "disabled");
+				break;
+			case 76:
+			case 108:
+				/* Otherwise, if L pressed, toggle logging everything */
+				swsusp_action ^= (1 << SUSPEND_LOGALL);
+				prepare_status(1, 0, "Logging all output %s.\n", 
+					TEST_ACTION_STATE(SUSPEND_LOGALL) ? "enabled" : "disabled");
+				break;
+			case 50:
+			case 51:
+			case 52:
+			case 53:
+			case 54:
+			case 55:
+				console_loglevel = ((ch - 48));
+				break;
+#endif
+		}
 #endif
+		if (ch == 32)
+			complete(&swsusp_wait_for_shift);
+
+		goto ignore_char;
+	}
+#endif /* CONFIG_PM */
+#endif /* CONFIG_SERIAL_CONSOLE */
+
 		if ((*status & info->ignore_status_mask) == 0) {
 			tty->flip.flag_buf_ptr++;
 			tty->flip.char_buf_ptr++;
@@ -666,7 +772,7 @@
 			tty->flip.flag_buf_ptr++;
 			tty->flip.char_buf_ptr++;
 		}
-#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#if defined(CONFIG_SERIAL_CONSOLE) && ( defined(CONFIG_MAGIC_SYSRQ) || defined(CONFIG_PM))
 	ignore_char:
 #endif
 		*status = serial_inp(info, UART_LSR);
@@ -1208,44 +1314,16 @@
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
-
-	page = get_zeroed_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
 
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
@@ -1341,69 +1419,20 @@
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
 	serial_outp(info, UART_LCR, UART_LCR_WLEN8);	/* reset DLAB */
 
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
 	
@@ -1459,6 +1488,108 @@
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
@@ -1470,6 +1601,33 @@
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
@@ -1566,27 +1724,9 @@
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
@@ -3250,6 +3390,108 @@
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
@@ -5475,6 +5717,10 @@
 	serial_driver.wait_until_sent = rs_wait_until_sent;
 	serial_driver.read_proc = rs_read_proc;
 #endif
+#ifdef CONFIG_PM
+	serial_driver.suspend = rs_suspend;
+	serial_driver.resume = rs_resume;
+#endif
 	
 	/*
 	 * The callout device is just like normal device except for
@@ -5554,8 +5800,13 @@
 	probe_serial_pci();
 #endif
 #ifdef ENABLE_SERIAL_PNP
-       probe_serial_pnp();
+	probe_serial_pnp();
+#endif
+#ifdef CONFIG_PM
+	if (!pm_register(PM_UNKNOWN_DEV, 0, rs_pm_callback))
+		panic("Couldn't register with PM subsystem\n");
 #endif
+
 	return 0;
 }
 
@@ -5726,6 +5977,7 @@
 	struct async_struct *info;
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
+	pm_unregister_all(rs_pm_callback);
 	del_timer_sync(&serial_timer);
 	save_flags(flags); cli();
         remove_bh(SERIAL_BH);
@@ -6001,6 +6253,30 @@
 	if (serial_in(info, UART_LSR) == 0xff)
 		return -1;
 
+#if	defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_KDB)
+	/*
+	 * Remember the line number of the first serial
+	 * console.  We'll make this the kdb serial console too.
+	 */
+	if (kdb_serial_line == -1) {
+		kdb_serial_line = co->index;
+		kdb_serial.io_type = info->io_type;
+		switch (info->io_type) {
+		case SERIAL_IO_MEM:
+#ifdef  SERIAL_IO_MEM32
+		case SERIAL_IO_MEM32:
+#endif
+			kdb_serial.iobase = (unsigned long)(info->iomem_base);
+			kdb_serial.ioreg_shift = info->iomem_reg_shift;
+			break;
+		default:
+			kdb_serial.iobase = state->port;
+			kdb_serial.ioreg_shift = 0;
+			break;
+		}
+	}
+#endif	/* CONFIG_SERIAL_CONSOLE && CONFIG_KDB */
+
 	return 0;
 }
 

