Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWCaTaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWCaTaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWCaTaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:30:10 -0500
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:10080 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751439AbWCaTaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:30:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Pgp-Agent:X-Mailer;
  b=JxjFk29l0DD8rZLAkuXVAXozOpuUZb9i4GkJkCA9uaePenUt4IUaIeHcY4VIvMZVAUAkhGEzlG/1+6M8hBg/KLvzACyT9suK5hue7zpDliA5QORrs4iFfwgHm8DxHjWvut5RnkyPPZMqMxVdE5gA8VOW4JLyWP/7otKPRgE9ms0=  ;
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-38-169959011"
Message-Id: <BC34AAD1-595C-4E8E-A8D0-D0F1A9E93C69@rogers.com>
Cc: rmk+serial@arm.linux.org.uk, Georg Nikodym <georgn@rogers.com>
Content-Transfer-Encoding: 7bit
From: Georg Nikodym <georgn@rogers.com>
Subject: [PATCH] 8250: yet another attempt at a serial console fix
Date: Fri, 31 Mar 2006 14:29:59 -0500
To: linux-kernel@vger.kernel.org
X-Pgp-Agent: GPGMail 1.1 (Tiger)
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-38-169959011
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Various people have reported a problem in which the serial console  
output gets stalled / stuck until a receive interrupt is received  
(typically somebody hitting return a couple of times in an attempt to  
see if the machine is still alive).

I'm working on an LSI based ARM SoC and as of 2.6.16, I too  
experience this.  For me the change that appears to have broken  
things is where Alan Cox changed the following line in  
serial8250_console_write() from:

	serial_out(up, UART_IER, ier);

to:

	serial_out(up, UART_IER, ier | UART_IER_THRI);

The documentation I have for my SoC, AMBA Multilayer Reference Design  
Rev 2.0 TECHNICAL MANUAL (cw001202_MLRD2.0_TechManual.pdf) covers the  
UART in chapter 10.  There it describes the UART as 16550D compatible  
with several listed behavioural changes.  Specific to the THRE  
interrupt, it says the following:

	The previous version of the ApUart would trigger the THRE interrupt if
	the THRE bit was set and the Enable Transmitter Holding Register Empty
	Interrupt bit was changed from 0 to 1.

	The new version does this only if the interrupt handler has not already
	reported this condition (by a read of the IIR when a THRE interrupt  
is the
	highest priority pending interrupt). A new interrupt will only be  
reported
	by the new version if one or more characters are written to, and
	eventually emptied out of, the THR or the Transmitter FIFO.

This appears to describe the behaviour observed by Alex Williamson  
and addressed in his backup-timer-for-uarts-that-lose-interrupts- 
take-3.patch (http://lkml.org/lkml/2006/1/21/93)

Since the old code worked I had trouble swallowing the backup timer  
idea.  But the detection logic worked a charm so I lifted that and  
offer up the attached patch for evisceration.

-g

===== 8250.h 1.27 vs edited =====
--- 1.27/drivers/serial/8250.h	2006-01-04 14:43:24 -05:00
+++ edited/8250.h	2006-03-30 16:26:56 -05:00
@@ -50,6 +50,7 @@ struct serial8250_config {
  #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
  #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
  #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits  
(Au1x00) */
+#define UART_BUG_THRI	(1 << 3)	/* UART has revised THRE int.  
semantics */

  #define PROBE_RSA	(1 << 0)
  #define PROBE_ANY	(~0)
===== 8250.c 1.140 vs edited =====
--- 1.140/drivers/serial/8250.c	2006-03-30 14:34:11 -05:00
+++ edited/8250.c	2006-03-30 18:36:35 -05:00
@@ -298,6 +298,10 @@ static inline int map_8250_out_reg(struc

  #endif

+#ifdef CONFIG_SERIAL_8250_CONSOLE
+static void thre_bug_test(struct uart_8250_port *up);
+#endif
+
  static unsigned int serial_in(struct uart_8250_port *up, int offset)
  {
  	offset = map_8250_in_reg(up, offset) << up->port.regshift;
@@ -1389,6 +1393,7 @@ static int serial_link_irq_chain(struct
  				  irq_flags, "serial", i);
  		if (ret < 0)
  			serial_do_unlink(i, up);
+
  	}

  	return ret;
@@ -1623,6 +1628,10 @@ static int serial8250_startup(struct uar
  		up->bugs &= ~UART_BUG_TXEN;
  	}

+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	thre_bug_test(up);
+#endif
+
  	spin_unlock_irqrestore(&up->port.lock, flags);

  	/*
@@ -2182,6 +2191,37 @@ static inline void wait_for_xmitr(struct
  	}
  }

+static void thre_bug_test(struct uart_8250_port *up)
+{
+	unsigned char iir;
+
+	if (is_real_interrupt(up->port.irq) && !timer_pending(&up->timer)) {
+		/*
+		 * Test for UARTs that do not reassert THRE when the
+		 * transmitter is idle and the interrupt has already
+		 * been cleared.  Real 16550s should always reassert
+		 * this interrupt whenever the transmitter is idle and
+		 * the interrupt is enabled.
+		 */
+		wait_for_xmitr(up, BOTH_EMPTY);
+		serial_outp(up, UART_IER, UART_IER_THRI);
+		(void)serial_in(up, UART_IIR);
+		serial_outp(up, UART_IER, 0);
+		serial_outp(up, UART_IER, UART_IER_THRI);
+		iir = serial_in(up, UART_IIR);
+		serial_outp(up, UART_IER, 0);
+
+		/*
+		 * If the interrupt is not reasserted, setup a timer to
+		 * kick the UART on a regular basis.
+		 */
+		if (iir & UART_IIR_NO_INT) {
+			pr_debug("ttyS%d - enabling THRI workaround\n",
+				 up->port.line);
+		}
+	}
+}
+
  /*
   *	Print a string to the serial port trying not to disturb
   *	any possible real use of the port...
@@ -2229,9 +2269,12 @@ serial8250_console_write(struct console
  	 *	and restore the IER
  	 */
  	wait_for_xmitr(up, BOTH_EMPTY);
-	// up->ier |= UART_IER_THRI;
-	// serial_out(up, UART_IER, ier | UART_IER_THRI);
-	serial_out(up, UART_IER, ier);
+	if (up->bugs & UART_BUG_THRI) {
+		serial_out(up, UART_IER, ier);
+	} else {
+		up->ier |= UART_IER_THRI;
+		serial_out(up, UART_IER, ier | UART_IER_THRI);
+	}
  }

  static int serial8250_console_setup(struct console *co, char *options)


--Apple-Mail-38-169959011
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (Darwin)

iD8DBQFELYM7oJNnikTddkMRAl9FAJ9Yth9rqs9vnZYewySIJGEsyAFDoQCfSmxc
Dg/2n81Cpz4mYp4Txr6Qdgo=
=m6vG
-----END PGP SIGNATURE-----

--Apple-Mail-38-169959011--
