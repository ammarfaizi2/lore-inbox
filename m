Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271311AbRHZMzb>; Sun, 26 Aug 2001 08:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271319AbRHZMzW>; Sun, 26 Aug 2001 08:55:22 -0400
Received: from pf107.gdansk.sdi.tpnet.pl ([213.77.129.107]:24078 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S271311AbRHZMzK>; Sun, 26 Aug 2001 08:55:10 -0400
Subject: [patch] serial.c ALI/SMSC/VIA high speed support
To: linux-kernel@vger.kernel.org
Date: Sun, 26 Aug 2001 14:54:42 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E15azR5-0006Za-00@mm.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was a bit surprised when I learned that _many_ motherboards
support high speed (usually max 460800 bps) serial ports, but
this fact is not advertised in any motherboard manuals!

This patch adds support for high speed mode (baud_base*2 and *4
by using divisors 0x8002 and 0x8001) supported by many UARTs
integrated in motherboard chipsets.  VIA VT82C686 is detected
(easy PCI probe) and high speed mode is enabled automatically.

No detection of other chips for now, because there are so many
and ISA probes are potentially unsafe.  But you can enable the
high speed mode from a simple user level program you can write
after looking at the datasheet for the chip on your motherboard.
Some chips also need setting baud_base to 921600 with setserial.

Without this patch, you could still use spd_cust to set custom
divisor 0x8002, but the timeout was much too long, baud rate
was not reported correctly in /proc, etc.  Also, this patch
fixes possible 32-bit integer overflow in timeout calculation.

Earlier version of this patch (without VT82C686 detection)
was sent to the linux-serial list, which does not seem to be
very active.  Comments and suggestions are welcome.

Some places to look at:

http://www.devdrv.com/shsmod/ - DOS/Win* high speed mode
enabler, old Linux (2.0.x and 2.2.x) and FreeBSD patches.
Some people in Japan discovered all this a few years before
I did...  (Unfortunately, latest version of this program
is closed source Windows-only, but old sources are still
available.)

http://www.kati.fi/viahss/ - this is where I found the code to
enable high speed mode on the VT82C686.  (Unfortunately, VIA
does not make the full datasheet available for download.)

Since there is a lot of hardware that may benefit from this
(potentially almost all current x86 Linux boxes in fact -
not old 386/486 but quite possibly newer 486 too), I'd like
to see this (after more testing) in the standard kernel.

Thanks,
Marek


--- serial.c.orig	Tue Aug 14 01:37:33 2001
+++ serial.c	Sun Aug 26 14:32:41 2001
@@ -57,6 +57,8 @@
  * 10/00: add in optional software flow control for serial console.
  *	  Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)
  *
+ * 08/01: initial support for high speed mode on ALI/SMSC/VIA chips.
+ *        Marek Michalkiewicz <marekm@amelek.gda.pl>
  */
 
 static char *serial_version = "5.05c";
@@ -1601,6 +1603,62 @@
 #endif
 
 /*
+ * Special divisor values may be used for (otherwise 16550A compatible)
+ * UARTs in ALI/SMSC/VIA super I/O chips found on _many_ motherboards.
+ * Other popular chips (NSC/Winbond) can support high speeds by simply
+ * changing the UART clock (baud_base 921600 instead of 115200).
+ *
+ * Note that the serial driver itself does not enable high speed mode.
+ * This can be done by a separate program, specific to the chip type.
+ */
+
+static int baud_from_quot(int baud_base, int quot)
+{
+	int baud = 0;
+
+	if (quot == 0x8001)
+		baud = baud_base * 4;
+	else if (quot == 0x8002)
+		baud = baud_base * 2;
+	else if (quot > 0)
+		baud = baud_base / quot;
+	return baud;
+}
+
+static int quot_from_baud(int baud_base, int baud)
+{
+	int quot = 0;
+
+	if (baud == 134)
+		/* Special case since 134 is really 134.5 */
+		quot = (2*baud_base / 269);
+	else if (baud == baud_base * 4)
+		quot = 0x8001;
+	else if (baud == baud_base * 2)
+		quot = 0x8002;
+	else if (baud > 0)
+		quot = baud_base / baud;
+	return quot;
+}
+
+static int timeout_from_quot(int fifo_bits, int quot, int baud_base)
+{
+	int timeout;
+
+	if (quot == 0x8001)
+		timeout = (fifo_bits * HZ) / (baud_base * 4);
+	else if (quot == 0x8002)
+		timeout = (fifo_bits * HZ) / (baud_base * 2);
+	else if ((fifo_bits * quot) > (INT_MAX / HZ))
+		/* Avoid potential 32-bit integer overflow.  */
+		timeout = ((HZ * quot) / baud_base) * fifo_bits;
+	else
+		timeout = (fifo_bits * HZ * quot) / baud_base;
+
+	return timeout + HZ/50;  /* Add .02 seconds of slop.  */
+}
+
+/*
  * This routine is called to set the UART divisor registers to match
  * the specified baud rate for a serial port.
  */
@@ -1668,13 +1726,9 @@
 	if (baud == 38400 &&
 	    ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST))
 		quot = info->state->custom_divisor;
-	else {
-		if (baud == 134)
-			/* Special case since 134 is really 134.5 */
-			quot = (2*baud_base / 269);
-		else if (baud)
-			quot = baud_base / baud;
-	}
+	else if (baud)
+		quot = quot_from_baud(baud_base, baud);
+
 	/* If the quotient is zero refuse the change */
 	if (!quot && old_termios) {
 		info->tty->termios->c_cflag &= ~CBAUD;
@@ -1685,17 +1739,12 @@
 		if (baud == 38400 &&
 		    ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST))
 			quot = info->state->custom_divisor;
-		else {
-			if (baud == 134)
-				/* Special case since 134 is really 134.5 */
-				quot = (2*baud_base / 269);
-			else if (baud)
-				quot = baud_base / baud;
-		}
+		else if (baud)
+			quot = quot_from_baud(baud_base, baud);
 	}
 	/* As a last resort, if the quotient is zero, default to 9600 bps */
 	if (!quot)
-		quot = baud_base / 9600;
+		quot = quot_from_baud(baud_base, 9600);
 	/*
 	 * Work around a bug in the Oxford Semiconductor 952 rev B
 	 * chip which causes it to seriously miscalculate baud rates
@@ -1706,12 +1755,12 @@
 		quot++;
 	
 	info->quot = quot;
-	info->timeout = ((info->xmit_fifo_size*HZ*bits*quot) / baud_base);
-	info->timeout += HZ/50;		/* Add .02 seconds of slop */
+	info->timeout = timeout_from_quot(info->xmit_fifo_size * bits,
+					  quot, baud_base);
 
 	/* Set up FIFO's */
 	if (uart_config[info->state->type].flags & UART_USE_FIFO) {
-		if ((info->state->baud_base / quot) < 2400)
+		if (baud_from_quot(info->state->baud_base, quot) < 2400)
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
 #ifdef CONFIG_SERIAL_RSA
 		else if (info->state->type == PORT_RSA)
@@ -3288,8 +3337,8 @@
 		strcat(stat_buf, "|RI");
 
 	if (info->quot) {
-		ret += sprintf(buf+ret, " baud:%d",
-			       state->baud_base / info->quot);
+		int baud = baud_from_quot(state->baud_base, info->quot);
+		ret += sprintf(buf+ret, " baud:%d", baud);
 	}
 
 	ret += sprintf(buf+ret, " tx:%d rx:%d",
@@ -5335,6 +5384,41 @@
 
 #endif /* ENABLE_SERIAL_PNP */
 
+
+static void __init enable_high_speed_mode(void)
+{
+#ifdef ENABLE_SERIAL_PCI
+	struct pci_dev *pcidev;
+	unsigned char confval, val;
+
+	/*
+	 * Based on the VT82C686[AB] high speed serial port enabler
+	 * by Juhani Rautiainen <jrauti@iki.fi>.
+	 */
+	pcidev = pci_find_device(PCI_VENDOR_ID_VIA,
+				 PCI_DEVICE_ID_VIA_82C686,
+				 NULL);
+	if (pcidev) {
+		cli();
+		pci_read_config_byte(pcidev, 0x85, &confval);
+		pci_write_config_byte(pcidev, 0x85, confval | 0x02);
+		outb(0xEE, 0x3F0);
+		val = inb(0x3F1);
+		val |= 0xC0;  /* high speed mode (divisor > 0x8000) on both UARTs */
+		outb(0xEE, 0x3F0);
+		outb(val, 0x3F1);
+		pci_write_config_byte(pcidev, 0x85, confval);
+		sti();
+		printk(KERN_INFO "VIA VT82C686[AB] serial port high speed mode enabled\n");
+	}
+#endif
+	/*
+	 * TODO: enable high speed mode on ALI/SMSC (divisor > 0x8000)
+	 * and NSC/Winbond (baud_base 921600) chips - probably should be
+	 * optional, because of potentially unsafe ISA I/O port probes.
+	 */
+}
+
 /*
  * The serial driver boot-time initialization code!
  */
@@ -5485,6 +5569,7 @@
 		tty_register_devfs(&callout_driver, 0,
 				   callout_driver.minor_start + state->line);
 	}
+	enable_high_speed_mode();
 #ifdef ENABLE_SERIAL_PCI
 	probe_serial_pci();
 #endif
@@ -5935,7 +6020,7 @@
 	info->io_type = state->io_type;
 	info->iomem_base = state->iomem_base;
 	info->iomem_reg_shift = state->iomem_reg_shift;
-	quot = state->baud_base / baud;
+	quot = quot_from_baud(state->baud_base, baud);
 	cval = cflag & (CSIZE | CSTOPB);
 #if defined(__powerpc__) || defined(__alpha__)
 	cval >>= 8;


