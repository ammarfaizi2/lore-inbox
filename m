Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUCSCQL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbUCSCQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:16:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:12260 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261997AbUCSCPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:15:53 -0500
Subject: Re: [PATCH] Consistently translate LF to CRLF on serial console
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jeekrpbun3.fsf@sykes.suse.de>
References: <jeekrpbun3.fsf@sykes.suse.de>
Content-Type: text/plain
Message-Id: <1079661779.1947.81.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Mar 2004 13:03:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 10:30, Andreas Schwab wrote:
> Some serial console drivers translate LF to CRLF, some do LFCR.  This
> patch changes them to consistently translate to CRLF.

macserial is obsolete (and will be soon removed), please look
into pmac zilog rather. Also, why did you move the test for
the transmit buffer empty ? You should at least check there
is room in it _before_ writing to it

> Andreas.
> 
> diff -ur linux-2.6.4.orig/drivers/macintosh/macserial.c linux-2.6.4/drivers/macintosh/macserial.c
> --- linux-2.6.4.orig/drivers/macintosh/macserial.c	2004-03-11 03:55:49.000000000 +0100
> +++ linux-2.6.4/drivers/macintosh/macserial.c	2004-03-19 00:24:04.179275348 +0100
> @@ -2736,12 +2736,6 @@
>  	write_zsreg(info->zs_channel, R5, info->curregs[5] | TxENAB | RTS | DTR);
>  
>  	for (i=0; i<count; i++) {
> -		/* Wait for the transmit buffer to empty. */
> -		while ((read_zsreg(info->zs_channel, 0) & Tx_BUF_EMP) == 0) {
> -			eieio();
> -		}
> -
> -		write_zsdata(info->zs_channel, s[i]);
>  		if (s[i] == 10) {
>  			while ((read_zsreg(info->zs_channel, 0) & Tx_BUF_EMP)
>                                  == 0)
> @@ -2749,6 +2743,12 @@
>  
>  			write_zsdata(info->zs_channel, 13);
>  		}
> +		/* Wait for the transmit buffer to empty. */
> +		while ((read_zsreg(info->zs_channel, 0) & Tx_BUF_EMP) == 0) {
> +			eieio();
> +		}
> +
> +		write_zsdata(info->zs_channel, s[i]);
>  	}
>  
>  	/* Restore the values in the registers. */
> diff -ur linux-2.6.4.orig/drivers/serial/21285.c linux-2.6.4/drivers/serial/21285.c
> --- linux-2.6.4.orig/drivers/serial/21285.c	2004-03-11 03:55:37.000000000 +0100
> +++ linux-2.6.4/drivers/serial/21285.c	2004-03-19 00:24:04.191970668 +0100
> @@ -409,14 +409,14 @@
>  	int i;
>  
>  	for (i = 0; i < count; i++) {
> -		while (*CSR_UARTFLG & 0x20)
> -			barrier();
> -		*CSR_UARTDR = s[i];
>  		if (s[i] == '\n') {
>  			while (*CSR_UARTFLG & 0x20)
>  				barrier();
>  			*CSR_UARTDR = '\r';
>  		}
> +		while (*CSR_UARTFLG & 0x20)
> +			barrier();
> +		*CSR_UARTDR = s[i];
>  	}
>  }
>  
> diff -ur linux-2.6.4.orig/drivers/serial/68360serial.c linux-2.6.4/drivers/serial/68360serial.c
> --- linux-2.6.4.orig/drivers/serial/68360serial.c	2004-03-11 03:55:49.000000000 +0100
> +++ linux-2.6.4/drivers/serial/68360serial.c	2004-03-19 00:24:04.202712861 +0100
> @@ -2193,6 +2193,22 @@
>  	 * buffer, but we would just wait longer between accesses......
>  	 */
>  	for (i = 0; i < count; i++, s++) {
> +		/* if a LF, also do CR... */
> +		if (*s == 10) {
> +			while (bdp->status & BD_SC_READY);
> +			/* cp = __va(bdp->buf); */
> +			cp = bdp->buf;
> +			*cp = 13;
> +			bdp->length = 1;
> +			bdp->status |= BD_SC_READY;
> +
> +			if (bdp->status & BD_SC_WRAP) {
> +				bdp = bdbase;
> +			}
> +			else {
> +				bdp++;
> +			}
> +		}
>  		/* Wait for transmitter fifo to empty.
>  		 * Ready indicates output is ready, and xmt is doing
>  		 * that, not that it is ready for us to send.
> @@ -2212,22 +2228,6 @@
>  		else
>  			bdp++;
>  
> -		/* if a LF, also do CR... */
> -		if (*s == 10) {
> -			while (bdp->status & BD_SC_READY);
> -			/* cp = __va(bdp->buf); */
> -			cp = bdp->buf;
> -			*cp = 13;
> -			bdp->length = 1;
> -			bdp->status |= BD_SC_READY;
> -
> -			if (bdp->status & BD_SC_WRAP) {
> -				bdp = bdbase;
> -			}
> -			else {
> -				bdp++;
> -			}
> -		}
>  	}
>  
>  	/*
> diff -ur linux-2.6.4.orig/drivers/serial/8250.c linux-2.6.4/drivers/serial/8250.c
> --- linux-2.6.4.orig/drivers/serial/8250.c	2004-03-11 03:55:21.000000000 +0100
> +++ linux-2.6.4/drivers/serial/8250.c	2004-03-19 00:24:04.210525366 +0100
> @@ -1935,17 +1935,16 @@
>  	 *	Now, do each character
>  	 */
>  	for (i = 0; i < count; i++, s++) {
> -		wait_for_xmitr(up);
> -
>  		/*
>  		 *	Send the character out.
>  		 *	If a LF, also do CR...
>  		 */
> -		serial_out(up, UART_TX, *s);
>  		if (*s == 10) {
>  			wait_for_xmitr(up);
>  			serial_out(up, UART_TX, 13);
>  		}
> +		wait_for_xmitr(up);
> +		serial_out(up, UART_TX, *s);
>  	}
>  
>  	/*
> diff -ur linux-2.6.4.orig/drivers/serial/amba.c linux-2.6.4/drivers/serial/amba.c
> --- linux-2.6.4.orig/drivers/serial/amba.c	2004-03-11 03:55:22.000000000 +0100
> +++ linux-2.6.4/drivers/serial/amba.c	2004-03-19 00:24:04.212478492 +0100
> @@ -620,16 +620,16 @@
>  	 *	Now, do each character
>  	 */
>  	for (i = 0; i < count; i++) {
> -		do {
> -			status = UART_GET_FR(port);
> -		} while (!UART_TX_READY(status));
> -		UART_PUT_CHAR(port, s[i]);
>  		if (s[i] == '\n') {
>  			do {
>  				status = UART_GET_FR(port);
>  			} while (!UART_TX_READY(status));
>  			UART_PUT_CHAR(port, '\r');
>  		}
> +		do {
> +			status = UART_GET_FR(port);
> +		} while (!UART_TX_READY(status));
> +		UART_PUT_CHAR(port, s[i]);
>  	}
>  
>  	/*
> diff -ur linux-2.6.4.orig/drivers/serial/anakin.c linux-2.6.4/drivers/serial/anakin.c
> --- linux-2.6.4.orig/drivers/serial/anakin.c	2004-03-11 03:55:23.000000000 +0100
> +++ linux-2.6.4/drivers/serial/anakin.c	2004-03-19 00:24:04.214431618 +0100
> @@ -411,16 +411,10 @@
>  	 *	Now, do each character
>  	 */
>  	for (i = 0; i < count; i++, s++) {
> -		while (!(anakin_in(port, 0x10) & TXEMPTY))
> -			barrier();
> -
>  		/*
>  		 *	Send the character out.
>  		 *	If a LF, also do CR...
>  		 */
> -		anakin_out(port, 0x14, *s);
> -		anakin_out(port, 0x18, anakin_in(port, 0x18) | SENDREQUEST);
> -
>  		if (*s == 10) {
>  			while (!(anakin_in(port, 0x10) & TXEMPTY))
>  				barrier();
> @@ -428,6 +422,10 @@
>  			anakin_out(port, 0x18, anakin_in(port, 0x18)
>  					| SENDREQUEST);
>  		}
> +		while (!(anakin_in(port, 0x10) & TXEMPTY))
> +			barrier();
> +		anakin_out(port, 0x14, *s);
> +		anakin_out(port, 0x18, anakin_in(port, 0x18) | SENDREQUEST);
>  	}
>  
>  	/*
> diff -ur linux-2.6.4.orig/drivers/serial/clps711x.c linux-2.6.4/drivers/serial/clps711x.c
> --- linux-2.6.4.orig/drivers/serial/clps711x.c	2004-03-11 03:55:24.000000000 +0100
> +++ linux-2.6.4/drivers/serial/clps711x.c	2004-03-19 00:24:04.217361308 +0100
> @@ -473,16 +473,16 @@
>  	 *	Now, do each character
>  	 */
>  	for (i = 0; i < count; i++) {
> -		do {
> -			status = clps_readl(SYSFLG(port));
> -		} while (status & SYSFLG_UTXFF);
> -		clps_writel(s[i], UARTDR(port));
>  		if (s[i] == '\n') {
>  			do {
>  				status = clps_readl(SYSFLG(port));
>  			} while (status & SYSFLG_UTXFF);
>  			clps_writel('\r', UARTDR(port));
>  		}
> +		do {
> +			status = clps_readl(SYSFLG(port));
> +		} while (status & SYSFLG_UTXFF);
> +		clps_writel(s[i], UARTDR(port));
>  	}
>  
>  	/*
> diff -ur linux-2.6.4.orig/drivers/serial/pmac_zilog.c linux-2.6.4/drivers/serial/pmac_zilog.c
> --- linux-2.6.4.orig/drivers/serial/pmac_zilog.c	2004-03-11 03:55:21.000000000 +0100
> +++ linux-2.6.4/drivers/serial/pmac_zilog.c	2004-03-19 00:24:04.220290997 +0100
> @@ -1892,15 +1892,15 @@
>  	write_zsreg(uap, R5, uap->curregs[5] | TxENABLE | RTS | DTR);
>  
>  	for (i = 0; i < count; i++) {
> -		/* Wait for the transmit buffer to empty. */
> -		while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
> -			udelay(5);
> -		write_zsdata(uap, s[i]);
>  		if (s[i] == 10) {
>  			while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
>  				udelay(5);
>  			write_zsdata(uap, R13);
>  		}
> +		/* Wait for the transmit buffer to empty. */
> +		while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
> +			udelay(5);
> +		write_zsdata(uap, s[i]);
>  	}
>  
>  	/* Restore the values in the registers. */
> diff -ur linux-2.6.4.orig/drivers/serial/sa1100.c linux-2.6.4/drivers/serial/sa1100.c
> --- linux-2.6.4.orig/drivers/serial/sa1100.c	2004-03-11 03:55:22.000000000 +0100
> +++ linux-2.6.4/drivers/serial/sa1100.c	2004-03-19 00:24:04.222244123 +0100
> @@ -740,16 +740,16 @@
>  	 *	Now, do each character
>  	 */
>  	for (i = 0; i < count; i++) {
> -		do {
> -			status = UART_GET_UTSR1(sport);
> -		} while (!(status & UTSR1_TNF));
> -		UART_PUT_CHAR(sport, s[i]);
>  		if (s[i] == '\n') {
>  			do {
>  				status = UART_GET_UTSR1(sport);
>  			} while (!(status & UTSR1_TNF));
>  			UART_PUT_CHAR(sport, '\r');
>  		}
> +		do {
> +			status = UART_GET_UTSR1(sport);
> +		} while (!(status & UTSR1_TNF));
> +		UART_PUT_CHAR(sport, s[i]);
>  	}
>  
>  	/*
> diff -ur linux-2.6.4.orig/drivers/serial/serial98.c linux-2.6.4/drivers/serial/serial98.c
> --- linux-2.6.4.orig/drivers/serial/serial98.c	2004-03-11 03:55:36.000000000 +0100
> +++ linux-2.6.4/drivers/serial/serial98.c	2004-03-19 00:24:04.233962880 +0100
> @@ -963,17 +963,16 @@
>  	 *	Now, do each character
>  	 */
>  	for (i = 0; i < count; i++, s++) {
> -		wait_for_xmitr(port);
> -
>  		/*
>  		 *	Send the character out.
>  		 *	If a LF, also do CR...
>  		 */
> -		outb(*s, PORT.iobase);
>  		if (*s == 10) {
>  			wait_for_xmitr(port);
>  			outb(13, PORT.iobase);
>  		}
> +		wait_for_xmitr(port);
> +		outb(*s, PORT.iobase);
>  	}
>  
>  	/*
> diff -ur linux-2.6.4.orig/drivers/serial/sunsu.c linux-2.6.4/drivers/serial/sunsu.c
> --- linux-2.6.4.orig/drivers/serial/sunsu.c	2004-03-11 03:55:23.000000000 +0100
> +++ linux-2.6.4/drivers/serial/sunsu.c	2004-03-19 00:24:04.238845695 +0100
> @@ -1382,17 +1382,16 @@
>  	 *	Now, do each character
>  	 */
>  	for (i = 0; i < count; i++, s++) {
> -		wait_for_xmitr(up);
> -
>  		/*
>  		 *	Send the character out.
>  		 *	If a LF, also do CR...
>  		 */
> -		serial_out(up, UART_TX, *s);
>  		if (*s == 10) {
>  			wait_for_xmitr(up);
>  			serial_out(up, UART_TX, 13);
>  		}
> +		wait_for_xmitr(up);
> +		serial_out(up, UART_TX, *s);
>  	}
>  
>  	/*
> diff -ur linux-2.6.4.orig/drivers/serial/sunzilog.c linux-2.6.4/drivers/serial/sunzilog.c
> --- linux-2.6.4.orig/drivers/serial/sunzilog.c	2004-03-11 03:55:51.000000000 +0100
> +++ linux-2.6.4/drivers/serial/sunzilog.c	2004-03-19 00:24:04.241775384 +0100
> @@ -1338,9 +1338,9 @@
>  
>  	spin_lock_irqsave(&up->port.lock, flags);
>  	for (i = 0; i < count; i++, s++) {
> -		sunzilog_put_char(channel, *s);
>  		if (*s == 10)
>  			sunzilog_put_char(channel, 13);
> +		sunzilog_put_char(channel, *s);
>  	}
>  	udelay(2);
>  	spin_unlock_irqrestore(&up->port.lock, flags);
> diff -ur linux-2.6.4.orig/drivers/serial/uart00.c linux-2.6.4/drivers/serial/uart00.c
> --- linux-2.6.4.orig/drivers/serial/uart00.c	2004-03-11 03:55:26.000000000 +0100
> +++ linux-2.6.4/drivers/serial/uart00.c	2004-03-19 00:24:04.243728511 +0100
> @@ -553,16 +553,16 @@
>  	 *	Now, do each character
>  	 */
>  	for (i = 0; i < count; i++) {
> -		do {
> -			status = UART_GET_TSR(port);
> -		} while (!UART_TX_READY(status));
> -		UART_PUT_CHAR(port, s[i]);
>  		if (s[i] == '\n') {
>  			do {
>  				status = UART_GET_TSR(port);
>  			} while (!UART_TX_READY(status));
>  			UART_PUT_CHAR(port, '\r');
>  		}
> +		do {
> +			status = UART_GET_TSR(port);
> +		} while (!UART_TX_READY(status));
> +		UART_PUT_CHAR(port, s[i]);
>  	}
>  
>  	/*
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

