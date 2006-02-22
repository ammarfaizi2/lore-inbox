Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWBVKVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWBVKVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 05:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWBVKVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 05:21:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23561 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932579AbWBVKVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 05:21:15 -0500
Date: Wed, 22 Feb 2006 10:20:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] serial: kernel console should send CRLF not LFCR
Message-ID: <20060222102040.GA12606@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glen Turner reported that writing LFCR rather than the more
traditional CRLF causes issues with some terminals.

Since this aflicts many serial drivers, extract the common code
to a library function (uart_console_write) and arrange for each
driver to supply a "putchar" function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

The following drivers probably need attention:

- mpc52xx_uart.c - does not use uart_console_write() because there is
  no obvious uart_port structure.  However, the driver has been updated
  nevertheless.
- mpsc.c - has some odd buffering requirements.  Remains buggy.
- v850e_uart.c - does not use uart_console_write() because there is no
  obvious uart_port structure.  Not buggy.

That said, uart_console_write() should only be used if you're writing
characters directly to the port - eventually, uart_console_port() will
know about console flow control, which will rely on a close relationship
between putchar() writing characters and get_mctrl() returning the
current modem control line state.

diff --git a/drivers/serial/21285.c b/drivers/serial/21285.c
--- a/drivers/serial/21285.c
+++ b/drivers/serial/21285.c
@@ -375,23 +375,18 @@ static void serial21285_setup_ports(void
 }
 
 #ifdef CONFIG_SERIAL_21285_CONSOLE
+static void serial21285_console_putchar(struct uart_port *port, int ch)
+{
+	while (*CSR_UARTFLG & 0x20)
+		barrier();
+	*CSR_UARTDR = ch;
+}
 
 static void
 serial21285_console_write(struct console *co, const char *s,
 			  unsigned int count)
 {
-	int i;
-
-	for (i = 0; i < count; i++) {
-		while (*CSR_UARTFLG & 0x20)
-			barrier();
-		*CSR_UARTDR = s[i];
-		if (s[i] == '\n') {
-			while (*CSR_UARTFLG & 0x20)
-				barrier();
-			*CSR_UARTDR = '\r';
-		}
-	}
+	uart_console_write(&serial21285_port, s, count, serial21285_console_putchar);
 }
 
 static void __init
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2182,6 +2182,14 @@ static inline void wait_for_xmitr(struct
 	}
 }
 
+static void serial8250_console_putchar(struct uart_port *port, int ch)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+
+	wait_for_xmitr(up, UART_LSR_THRE);
+	serial_out(up, UART_TX, ch);
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -2193,7 +2201,6 @@ serial8250_console_write(struct console 
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 	unsigned int ier;
-	int i;
 
 	touch_nmi_watchdog();
 
@@ -2207,22 +2214,7 @@ serial8250_console_write(struct console 
 	else
 		serial_out(up, UART_IER, 0);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up, UART_LSR_THRE);
-
-		/*
-		 *	Send the character out.
-		 *	If a LF, also do CR...
-		 */
-		serial_out(up, UART_TX, *s);
-		if (*s == 10) {
-			wait_for_xmitr(up, UART_LSR_THRE);
-			serial_out(up, UART_TX, 13);
-		}
-	}
+	uart_console_write(&up->port, s, count, serial8250_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/8250_early.c b/drivers/serial/8250_early.c
--- a/drivers/serial/8250_early.c
+++ b/drivers/serial/8250_early.c
@@ -74,7 +74,7 @@ static void __init wait_for_xmitr(struct
 	}
 }
 
-static void __init putc(struct uart_port *port, unsigned char c)
+static void __init putc(struct uart_port *port, int c)
 {
 	wait_for_xmitr(port);
 	serial_out(port, UART_TX, c);
@@ -89,12 +89,7 @@ static void __init early_uart_write(stru
 	ier = serial_in(port, UART_IER);
 	serial_out(port, UART_IER, 0);
 
-	while (*s && count-- > 0) {
-		putc(port, *s);
-		if (*s == '\n')
-			putc(port, '\r');
-		s++;
-	}
+	uart_console_write(port, s, count, putc);
 
 	/* Wait for transmitter to become empty and restore the IER */
 	wait_for_xmitr(port);
diff --git a/drivers/serial/amba-pl010.c b/drivers/serial/amba-pl010.c
--- a/drivers/serial/amba-pl010.c
+++ b/drivers/serial/amba-pl010.c
@@ -591,12 +591,18 @@ static struct uart_amba_port amba_ports[
 
 #ifdef CONFIG_SERIAL_AMBA_PL010_CONSOLE
 
+static void pl010_console_putchar(struct uart_port *port, int ch)
+{
+	while (!UART_TX_READY(UART_GET_FR(port)))
+		barrier();
+	UART_PUT_CHAR(port, ch);
+}
+
 static void
 pl010_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_port *port = &amba_ports[co->index].port;
 	unsigned int status, old_cr;
-	int i;
 
 	/*
 	 *	First save the CR then disable the interrupts
@@ -604,21 +610,7 @@ pl010_console_write(struct console *co, 
 	old_cr = UART_GET_CR(port);
 	UART_PUT_CR(port, UART01x_CR_UARTEN);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++) {
-		do {
-			status = UART_GET_FR(port);
-		} while (!UART_TX_READY(status));
-		UART_PUT_CHAR(port, s[i]);
-		if (s[i] == '\n') {
-			do {
-				status = UART_GET_FR(port);
-			} while (!UART_TX_READY(status));
-			UART_PUT_CHAR(port, '\r');
-		}
-	}
+	uart_console_write(port, s, count, pl010_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -587,14 +587,12 @@ static struct uart_amba_port *amba_ports
 
 #ifdef CONFIG_SERIAL_AMBA_PL011_CONSOLE
 
-static inline void
-pl011_console_write_char(struct uart_amba_port *uap, char ch)
+static void pl011_console_putchar(struct uart_port *port, int ch)
 {
-	unsigned int status;
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 
-	do {
-		status = readw(uap->port.membase + UART01x_FR);
-	} while (status & UART01x_FR_TXFF);
+	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+		barrier();
 	writew(ch, uap->port.membase + UART01x_DR);
 }
 
@@ -603,7 +601,6 @@ pl011_console_write(struct console *co, 
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int status, old_cr, new_cr;
-	int i;
 
 	clk_enable(uap->clk);
 
@@ -615,14 +612,7 @@ pl011_console_write(struct console *co, 
 	new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
 	writew(new_cr, uap->port.membase + UART011_CR);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++) {
-		pl011_console_write_char(uap, s[i]);
-		if (s[i] == '\n')
-			pl011_console_write_char(uap, '\r');
-	}
+	uart_console_write(&uap->port, s, count, pl011_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/at91_serial.c b/drivers/serial/at91_serial.c
--- a/drivers/serial/at91_serial.c
+++ b/drivers/serial/at91_serial.c
@@ -711,6 +711,12 @@ void __init at91_register_uart(int idx, 
 }
 
 #ifdef CONFIG_SERIAL_AT91_CONSOLE
+static void at91_console_putchar(struct uart_port *port, int ch)
+{
+	while (!(UART_GET_CSR(port) & AT91_US_TXRDY))
+		barrier();
+	UART_PUT_CHAR(port, ch);
+}
 
 /*
  * Interrupts are disabled on entering
@@ -718,7 +724,7 @@ void __init at91_register_uart(int idx, 
 static void at91_console_write(struct console *co, const char *s, u_int count)
 {
 	struct uart_port *port = at91_ports + co->index;
-	unsigned int status, i, imr;
+	unsigned int status, imr;
 
 	/*
 	 *	First, save IMR and then disable interrupts
@@ -726,21 +732,7 @@ static void at91_console_write(struct co
 	imr = UART_GET_IMR(port);	/* get interrupt mask */
 	UART_PUT_IDR(port, AT91_US_RXRDY | AT91_US_TXRDY);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++) {
-		do {
-			status = UART_GET_CSR(port);
-		} while (!(status & AT91_US_TXRDY));
-		UART_PUT_CHAR(port, s[i]);
-		if (s[i] == '\n') {
-			do {
-				status = UART_GET_CSR(port);
-			} while (!(status & AT91_US_TXRDY));
-			UART_PUT_CHAR(port, '\r');
-		}
-	}
+	uart_console_write(port, s, count, at91_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/au1x00_uart.c b/drivers/serial/au1x00_uart.c
--- a/drivers/serial/au1x00_uart.c
+++ b/drivers/serial/au1x00_uart.c
@@ -1121,6 +1121,14 @@ static inline void wait_for_xmitr(struct
 	}
 }
 
+static void au1x00_console_putchar(struct uart_port *port, int ch)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+
+	wait_for_xmitr(up);
+	serial_out(up, UART_TX, ch);
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -1132,7 +1140,6 @@ serial8250_console_write(struct console 
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 	unsigned int ier;
-	int i;
 
 	/*
 	 *	First save the UER then disable the interrupts
@@ -1140,22 +1147,7 @@ serial8250_console_write(struct console 
 	ier = serial_in(up, UART_IER);
 	serial_out(up, UART_IER, 0);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up);
-
-		/*
-		 *	Send the character out.
-		 *	If a LF, also do CR...
-		 */
-		serial_out(up, UART_TX, *s);
-		if (*s == 10) {
-			wait_for_xmitr(up);
-			serial_out(up, UART_TX, 13);
-		}
-	}
+	uart_console_write(&up->port, s, count, au1x00_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/clps711x.c b/drivers/serial/clps711x.c
--- a/drivers/serial/clps711x.c
+++ b/drivers/serial/clps711x.c
@@ -424,6 +424,13 @@ static struct uart_port clps711x_ports[U
 };
 
 #ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
+static void clps711xuart_console_putchar(struct uart_port *port, int ch)
+{
+	while (clps_readl(SYSFLG(port)) & SYSFLG_UTXFF)
+		barrier();
+	clps_writel(ch, UARTDR(port));
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -438,7 +445,6 @@ clps711xuart_console_write(struct consol
 {
 	struct uart_port *port = clps711x_ports + co->index;
 	unsigned int status, syscon;
-	int i;
 
 	/*
 	 *	Ensure that the port is enabled.
@@ -446,21 +452,7 @@ clps711xuart_console_write(struct consol
 	syscon = clps_readl(SYSCON(port));
 	clps_writel(syscon | SYSCON_UARTEN, SYSCON(port));
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++) {
-		do {
-			status = clps_readl(SYSFLG(port));
-		} while (status & SYSFLG_UTXFF);
-		clps_writel(s[i], UARTDR(port));
-		if (s[i] == '\n') {
-			do {
-				status = clps_readl(SYSFLG(port));
-			} while (status & SYSFLG_UTXFF);
-			clps_writel('\r', UARTDR(port));
-		}
-	}
+	uart_console_write(port, s, count, clps711xuart_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/dz.c b/drivers/serial/dz.c
--- a/drivers/serial/dz.c
+++ b/drivers/serial/dz.c
@@ -673,11 +673,12 @@ static void dz_reset(struct dz_port *dpo
 }
 
 #ifdef CONFIG_SERIAL_DZ_CONSOLE
-static void dz_console_put_char(struct dz_port *dport, unsigned char ch)
+static void dz_console_putchar(struct uart_port *port, int ch)
 {
+	struct dz_port *dport = (struct dz_port *)uport;
 	unsigned long flags;
 	int loops = 2500;
-	unsigned short tmp = ch;
+	unsigned short tmp = (unsigned char)ch;
 	/* this code sends stuff out to serial device - spinning its
 	   wheels and waiting. */
 
@@ -693,6 +694,7 @@ static void dz_console_put_char(struct d
 
 	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
+
 /*
  * -------------------------------------------------------------------
  * dz_console_print ()
@@ -709,11 +711,7 @@ static void dz_console_print(struct cons
 #ifdef DEBUG_DZ
 	prom_printf((char *) str);
 #endif
-	while (count--) {
-		if (*str == '\n')
-			dz_console_put_char(dport, '\r');
-		dz_console_put_char(dport, *str++);
-	}
+	uart_console_write(&dport->port, str, count, dz_console_putchar);
 }
 
 static int __init dz_console_setup(struct console *co, char *options)
diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -743,6 +743,13 @@ static void __init imx_init_ports(void)
 }
 
 #ifdef CONFIG_SERIAL_IMX_CONSOLE
+static void imx_console_putchar(struct uart_port *port, int ch)
+{
+	struct imx_port *sport = (struct imx_port *)port;
+	while ((UTS((u32)sport->port.membase) & UTS_TXFULL))
+		barrier();
+	URTX0((u32)sport->port.membase) = ch;
+}
 
 /*
  * Interrupts are disabled on entering
@@ -751,7 +758,7 @@ static void
 imx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct imx_port *sport = &imx_ports[co->index];
-	unsigned int old_ucr1, old_ucr2, i;
+	unsigned int old_ucr1, old_ucr2;
 
 	/*
 	 *	First, save UCR1/2 and then disable interrupts
@@ -764,22 +771,7 @@ imx_console_write(struct console *co, co
 	                   & ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN);
 	UCR2((u32)sport->port.membase) = old_ucr2 | UCR2_TXEN;
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++) {
-
-		while ((UTS((u32)sport->port.membase) & UTS_TXFULL))
-			barrier();
-
-		URTX0((u32)sport->port.membase) = s[i];
-
-		if (s[i] == '\n') {
-			while ((UTS((u32)sport->port.membase) & UTS_TXFULL))
-				barrier();
-			URTX0((u32)sport->port.membase) = '\r';
-		}
-	}
+	uart_console_write(&sport->port, s, count, imx_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
--- a/drivers/serial/ip22zilog.c
+++ b/drivers/serial/ip22zilog.c
@@ -969,8 +969,9 @@ static struct zilog_layout * __init get_
 #define ZS_PUT_CHAR_MAX_DELAY	2000	/* 10 ms */
 
 #ifdef CONFIG_SERIAL_IP22_ZILOG_CONSOLE
-static void ip22zilog_put_char(struct zilog_channel *channel, unsigned char ch)
+static void ip22zilog_put_char(struct uart_port *port, int ch)
 {
+	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	int loops = ZS_PUT_CHAR_MAX_DELAY;
 
 	/* This is a timed polling loop so do not switch the explicit
@@ -994,16 +995,10 @@ static void
 ip22zilog_console_write(struct console *con, const char *s, unsigned int count)
 {
 	struct uart_ip22zilog_port *up = &ip22zilog_port_table[con->index];
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&up->port.lock, flags);
-	for (i = 0; i < count; i++, s++) {
-		ip22zilog_put_char(channel, *s);
-		if (*s == 10)
-			ip22zilog_put_char(channel, 13);
-	}
+	uart_console_write(&up->port, s, count, ip22zilog_put_char);
 	udelay(2);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
diff --git a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
--- a/drivers/serial/m32r_sio.c
+++ b/drivers/serial/m32r_sio.c
@@ -1039,6 +1039,14 @@ static inline void wait_for_xmitr(struct
 	}
 }
 
+static void m32r_sio_console_putchar(struct uart_port *port, int ch)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+
+	wait_for_xmitr(up);
+	sio_out(up, SIOTXB, ch);
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -1058,23 +1066,7 @@ static void m32r_sio_console_write(struc
 	ier = sio_in(up, SIOTRCR);
 	sio_out(up, SIOTRCR, 0);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up);
-
-		/*
-		 *	Send the character out.
-		 *	If a LF, also do CR...
-		 */
-		sio_out(up, SIOTXB, *s);
-
-		if (*s == 10) {
-			wait_for_xmitr(up);
-			sio_out(up, SIOTXB, 13);
-		}
-	}
+	uart_console_write(&up->port, s, count, m32r_sio_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -603,15 +603,14 @@ mpc52xx_console_write(struct console *co
 		udelay(1);
 
 	/* Write all the chars */
-	for ( i=0 ; i<count ; i++ ) {
-	
-		/* Send the char */
-		out_8(&psc->mpc52xx_psc_buffer_8, *s);
-
+	for (i = 0; i < count; i++, s++) {
 		/* Line return handling */
-		if ( *s++ == '\n' )
+		if (*s == '\n')
 			out_8(&psc->mpc52xx_psc_buffer_8, '\r');
 		
+		/* Send the char */
+		out_8(&psc->mpc52xx_psc_buffer_8, *s);
+
 		/* Wait the TX buffer to be empty */
 		j = 20000;	/* Maximum wait */	
 		while (!(in_be16(&psc->mpc52xx_psc_status) & 
diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -1916,6 +1916,16 @@ static void __exit exit_pmz(void)
 
 #ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
 
+static void pmz_console_putchar(struct uart_port *port, int ch)
+{
+	struct uart_pmac_port *uap = (struct uart_pmac_port *)port;
+
+	/* Wait for the transmit buffer to empty. */
+	while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
+		udelay(5);
+	write_zsdata(uap, ch);
+}
+
 /*
  * Print a string to the serial port trying not to disturb
  * any possible real use of the port...
@@ -1924,7 +1934,6 @@ static void pmz_console_write(struct con
 {
 	struct uart_pmac_port *uap = &pmz_ports[con->index];
 	unsigned long flags;
-	int i;
 
 	if (ZS_IS_ASLEEP(uap))
 		return;
@@ -1934,17 +1943,7 @@ static void pmz_console_write(struct con
 	write_zsreg(uap, R1, uap->curregs[1] & ~TxINT_ENAB);
 	write_zsreg(uap, R5, uap->curregs[5] | TxENABLE | RTS | DTR);
 
-	for (i = 0; i < count; i++) {
-		/* Wait for the transmit buffer to empty. */
-		while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
-			udelay(5);
-		write_zsdata(uap, s[i]);
-		if (s[i] == 10) {
-			while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
-				udelay(5);
-			write_zsdata(uap, R13);
-		}
-	}
+	uart_console_write(&uap->port, s, count, pmz_console_putchar);
 
 	/* Restore the values in the registers. */
 	write_zsreg(uap, R1, uap->curregs[1]);
diff --git a/drivers/serial/pxa.c b/drivers/serial/pxa.c
--- a/drivers/serial/pxa.c
+++ b/drivers/serial/pxa.c
@@ -619,6 +619,14 @@ static inline void wait_for_xmitr(struct
 	}
 }
 
+static void serial_pxa_console_putchar(struct uart_port *port, int ch)
+{
+	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
+
+	wait_for_xmitr(up);
+	serial_out(up, UART_TX, ch);
+}
+
 /*
  * Print a string to the serial port trying not to disturb
  * any possible real use of the port...
@@ -630,7 +638,6 @@ serial_pxa_console_write(struct console 
 {
 	struct uart_pxa_port *up = &serial_pxa_ports[co->index];
 	unsigned int ier;
-	int i;
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -638,22 +645,7 @@ serial_pxa_console_write(struct console 
 	ier = serial_in(up, UART_IER);
 	serial_out(up, UART_IER, UART_IER_UUE);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up);
-
-		/*
-		 *	Send the character out.
-		 *	If a LF, also do CR...
-		 */
-		serial_out(up, UART_TX, *s);
-		if (*s == 10) {
-			wait_for_xmitr(up);
-			serial_out(up, UART_TX, 13);
-		}
-	}
+	uart_console_write(&up->port, s, count, serial_pxa_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/s3c2410.c b/drivers/serial/s3c2410.c
--- a/drivers/serial/s3c2410.c
+++ b/drivers/serial/s3c2410.c
@@ -1580,25 +1580,19 @@ s3c24xx_serial_console_txrdy(struct uart
 }
 
 static void
-s3c24xx_serial_console_write(struct console *co, const char *s,
-			     unsigned int count)
+s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
 {
-	int i;
 	unsigned int ufcon = rd_regl(cons_uart, S3C2410_UFCON);
+	while (!s3c24xx_serial_console_txrdy(port, ufcon))
+		barrier();
+	wr_regb(cons_uart, S3C2410_UTXH, ch);
+}
 
-	for (i = 0; i < count; i++) {
-		while (!s3c24xx_serial_console_txrdy(cons_uart, ufcon))
-			barrier();
-
-		wr_regb(cons_uart, S3C2410_UTXH, s[i]);
-
-		if (s[i] == '\n') {
-			while (!s3c24xx_serial_console_txrdy(cons_uart, ufcon))
-				barrier();
-
-			wr_regb(cons_uart, S3C2410_UTXH, '\r');
-		}
-	}
+static void
+s3c24xx_serial_console_write(struct console *co, const char *s,
+			     unsigned int count)
+{
+	uart_console_write(cons_uart, s, count, s3c24xx_serial_console_putchar);
 }
 
 static void __init
diff --git a/drivers/serial/sa1100.c b/drivers/serial/sa1100.c
--- a/drivers/serial/sa1100.c
+++ b/drivers/serial/sa1100.c
@@ -689,6 +689,14 @@ void __init sa1100_register_uart(int idx
 
 
 #ifdef CONFIG_SERIAL_SA1100_CONSOLE
+static void sa1100_console_putchar(struct uart_port *port, int ch)
+{
+	struct sa1100_port *sport = (struct sa1100_port *)port;
+
+	while (!(UART_GET_UTSR1(sport) & UTSR1_TNF))
+		barrier();
+	UART_PUT_CHAR(sport, ch);
+}
 
 /*
  * Interrupts are disabled on entering
@@ -697,7 +705,7 @@ static void
 sa1100_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct sa1100_port *sport = &sa1100_ports[co->index];
-	unsigned int old_utcr3, status, i;
+	unsigned int old_utcr3, status;
 
 	/*
 	 *	First, save UTCR3 and then disable interrupts
@@ -706,21 +714,7 @@ sa1100_console_write(struct console *co,
 	UART_PUT_UTCR3(sport, (old_utcr3 & ~(UTCR3_RIE | UTCR3_TIE)) |
 				UTCR3_TXE);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++) {
-		do {
-			status = UART_GET_UTSR1(sport);
-		} while (!(status & UTSR1_TNF));
-		UART_PUT_CHAR(sport, s[i]);
-		if (s[i] == '\n') {
-			do {
-				status = UART_GET_UTSR1(sport);
-			} while (!(status & UTSR1_TNF));
-			UART_PUT_CHAR(sport, '\r');
-		}
-	}
+	uart_console_write(&sport->port, s, count, sa1100_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1729,6 +1729,27 @@ static int uart_read_proc(char *page, ch
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 /*
+ *	uart_console_write - write a console message to a serial port
+ *	@port: the port to write the message
+ *	@s: array of characters
+ *	@count: number of characters in string to write
+ *	@write: function to write character to port
+ */
+void uart_console_write(struct uart_port *port, const char *s,
+			unsigned int count,
+			void (*putchar)(struct uart_port *, int))
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++, s++) {
+		if (*s == '\n')
+			putchar(port, '\r');
+		putchar(port, *s);
+	}
+}
+EXPORT_SYMBOL(uart_console_write);
+
+/*
  *	Check whether an invalid uart number has been specified, and
  *	if so, search for the first available port that does have
  *	console support.
diff --git a/drivers/serial/serial_lh7a40x.c b/drivers/serial/serial_lh7a40x.c
--- a/drivers/serial/serial_lh7a40x.c
+++ b/drivers/serial/serial_lh7a40x.c
@@ -543,6 +543,12 @@ static struct uart_port_lh7a40x lh7a40x_
 #else
 # define LH7A40X_CONSOLE &lh7a40x_console
 
+static void lh7a40xuart_console_putchar(struct uart_port *port, int ch)
+{
+	while (UR(port, UART_R_STATUS) & nTxRdy)
+		;
+	UR(port, UART_R_DATA) = ch;
+}
 
 static void lh7a40xuart_console_write (struct console* co,
 				       const char* s,
@@ -556,16 +562,7 @@ static void lh7a40xuart_console_write (s
 	UR (port, UART_R_INTEN) = 0;		/* Disable all interrupts */
 	BIT_SET (port, UART_R_CON, UARTEN | SIRDIS); /* Enable UART */
 
-	for (; count-- > 0; ++s) {
-		while (UR (port, UART_R_STATUS) & nTxRdy)
-			;
-		UR (port, UART_R_DATA) = *s;
-		if (*s == '\n') {
-			while ((UR (port, UART_R_STATUS) & TxBusy))
-				;
-			UR (port, UART_R_DATA) = '\r';
-		}
-	}
+	uart_console_write(port, s, count, lh7a40xuart_console_putchar);
 
 				/* Wait until all characters are sent */
 	while (UR (port, UART_R_STATUS) & TxBusy)
diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -854,6 +854,14 @@ static inline void wait_for_xmitr(struct
 	}
 }
 
+static void serial_txx9_console_putchar(struct uart_port *port, int ch)
+{
+	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
+
+	wait_for_xmitr(up);
+	sio_out(up, TXX9_SITFIFO, ch);
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -865,7 +873,6 @@ serial_txx9_console_write(struct console
 {
 	struct uart_txx9_port *up = &serial_txx9_ports[co->index];
 	unsigned int ier, flcr;
-	int i;
 
 	/*
 	 *	First save the UER then disable the interrupts
@@ -879,22 +886,7 @@ serial_txx9_console_write(struct console
 	if (!(up->port.flags & UPF_CONS_FLOW) && (flcr & TXX9_SIFLCR_TES))
 		sio_out(up, TXX9_SIFLCR, flcr & ~TXX9_SIFLCR_TES);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up);
-
-		/*
-		 *	Send the character out.
-		 *	If a LF, also do CR...
-		 */
-		sio_out(up, TXX9_SITFIFO, *s);
-		if (*s == 10) {
-			wait_for_xmitr(up);
-			sio_out(up, TXX9_SITFIFO, 13);
-		}
-	}
+	uart_console_write(&up->port, s, count, serial_txx9_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -861,8 +861,9 @@ static int num_channels;
 
 #ifdef CONFIG_SERIAL_SUNSAB_CONSOLE
 
-static __inline__ void sunsab_console_putchar(struct uart_sunsab_port *up, char c)
+static void sunsab_console_putchar(struct uart_port *port, int c)
 {
+	struct uart_sunsab_port *up = (struct uart_sunsab_port *)port;
 	unsigned long flags;
 
 	spin_lock_irqsave(&up->port.lock, flags);
@@ -876,13 +877,8 @@ static __inline__ void sunsab_console_pu
 static void sunsab_console_write(struct console *con, const char *s, unsigned n)
 {
 	struct uart_sunsab_port *up = &sunsab_ports[con->index];
-	int i;
 
-	for (i = 0; i < n; i++) {
-		if (*s == '\n')
-			sunsab_console_putchar(up, '\r');
-		sunsab_console_putchar(up, *s++);
-	}
+	uart_console_write(&up->port, s, n, sunsab_console_putchar);
 	sunsab_tec_wait(up);
 }
 
diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1379,6 +1379,14 @@ static __inline__ void wait_for_xmitr(st
 	}
 }
 
+static void sunsu_console_putchar(struct uart_port *port, int ch)
+{
+	struct uart_sunsu_port *up = (struct uart_sunsu_port *)port;
+
+	wait_for_xmitr(up);
+	serial_out(up, UART_TX, ch);
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -1388,7 +1396,6 @@ static void sunsu_console_write(struct c
 {
 	struct uart_sunsu_port *up = &sunsu_ports[co->index];
 	unsigned int ier;
-	int i;
 
 	/*
 	 *	First save the UER then disable the interrupts
@@ -1396,22 +1403,7 @@ static void sunsu_console_write(struct c
 	ier = serial_in(up, UART_IER);
 	serial_out(up, UART_IER, 0);
 
-	/*
-	 *	Now, do each character
-	 */
-	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up);
-
-		/*
-		 *	Send the character out.
-		 *	If a LF, also do CR...
-		 */
-		serial_out(up, UART_TX, *s);
-		if (*s == 10) {
-			wait_for_xmitr(up);
-			serial_out(up, UART_TX, 13);
-		}
-	}
+	uart_console_write(&up->port, s, count, sunsu_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1252,8 +1252,9 @@ static struct zilog_layout __iomem * __i
 
 #define ZS_PUT_CHAR_MAX_DELAY	2000	/* 10 ms */
 
-static void sunzilog_put_char(struct zilog_channel __iomem *channel, unsigned char ch)
+static void sunzilog_putchar(struct uart_port *port, int ch)
 {
+	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	int loops = ZS_PUT_CHAR_MAX_DELAY;
 
 	/* This is a timed polling loop so do not switch the explicit
@@ -1284,7 +1285,7 @@ static int sunzilog_serio_write(struct s
 
 	spin_lock_irqsave(&sunzilog_serio_lock, flags);
 
-	sunzilog_put_char(ZILOG_CHANNEL_FROM_PORT(&up->port), ch);
+	sunzilog_putchar(&up->port, ch);
 
 	spin_unlock_irqrestore(&sunzilog_serio_lock, flags);
 
@@ -1325,16 +1326,10 @@ static void
 sunzilog_console_write(struct console *con, const char *s, unsigned int count)
 {
 	struct uart_sunzilog_port *up = &sunzilog_port_table[con->index];
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&up->port.lock, flags);
-	for (i = 0; i < count; i++, s++) {
-		sunzilog_put_char(channel, *s);
-		if (*s == 10)
-			sunzilog_put_char(channel, 13);
-	}
+	uart_console_write(&up->port, s, count, sunzilog_putchar);
 	udelay(2);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
diff --git a/drivers/serial/vr41xx_siu.c b/drivers/serial/vr41xx_siu.c
--- a/drivers/serial/vr41xx_siu.c
+++ b/drivers/serial/vr41xx_siu.c
@@ -821,25 +821,23 @@ static void wait_for_xmitr(struct uart_p
 	}
 }
 
+static void siu_console_putchar(struct uart_port *port, int ch)
+{
+	wait_for_xmitr(port);
+	siu_write(port, UART_TX, ch);
+}
+
 static void siu_console_write(struct console *con, const char *s, unsigned count)
 {
 	struct uart_port *port;
 	uint8_t ier;
-	unsigned i;
 
 	port = &siu_uart_ports[con->index];
 
 	ier = siu_read(port, UART_IER);
 	siu_write(port, UART_IER, 0);
 
-	for (i = 0; i < count && *s != '\0'; i++, s++) {
-		wait_for_xmitr(port);
-		siu_write(port, UART_TX, *s);
-		if (*s == '\n') {
-			wait_for_xmitr(port);
-			siu_write(port, UART_TX, '\r');
-		}
-	}
+	uart_console_write(port, s, count, siu_console_putchar);
 
 	wait_for_xmitr(port);
 	siu_write(port, UART_IER, ier);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -366,6 +366,9 @@ void uart_parse_options(char *options, i
 int uart_set_options(struct uart_port *port, struct console *co, int baud,
 		     int parity, int bits, int flow);
 struct tty_driver *uart_console_device(struct console *co, int *index);
+void uart_console_write(struct uart_port *port, const char *s,
+			unsigned int count,
+			void (*putchar)(struct uart_port *, int));
 
 /*
  * Port/driver registration/removal

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
