Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTBPNpQ>; Sun, 16 Feb 2003 08:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTBPNpQ>; Sun, 16 Feb 2003 08:45:16 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:61828 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266755AbTBPNpL>; Sun, 16 Feb 2003 08:45:11 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Organization: 
Message-Id: <1045403700.2068.199.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Feb 2003 13:55:01 +0000
Subject: [PATCH][CFT] High-speed PC serial ports.
Content-Type: multipart/mixed; boundary="=-kz14IR3yAFXJPENtbGeX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kz14IR3yAFXJPENtbGeX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Most PC superio chips have supported up to 460800 or 921600 baud for
years. 

This patch adds kernel support for the two most common ways of achieving
this -- the SMSC chips' "magic multipliers" where a value of 0x8001 or
0x8002 as divisor actually means _multiply_ by 2 or 4 respectively, and
the National Semiconductor version where you can set the baud_base to
any of three values, but whenever you touch the original
16550-compatible divisor registers, it reverts baud_base to 115200 for
compatibility. 

Although both of these modes are designed for backward-compatibility,
there's _also_ a bit in the superio chip which can disable them and
force _complete_ 16550A compatibility. If your BIOS doesn't enable
these, you may need Shsmod <http://www.devdrv.com/shsmod/> to do so for
you.

If you have an SMSC superio chip, the driver can't autodetect this --
you need the (also-attached) patch to setserial, and to run 
'setserial /dev/ttySx magic_multiplier' for each port. This will make it
support baud rates of up to 460800.

If you have a NatSemi chip and it's set to enable high-speed before the
8250 driver probes it, then its high-speed capability should be
automatically detected and you'll get up to 921600 baud from it without
having to do anything special. If your BIOS doesn't enable the
high-speed mode, then after using Shsmod to do so, run 
'setserial /dev/ttyS0 autoconfig'.

I've also had a hacked-up superio probe enabling high-speed mode on
these ports automatically so you can boot with 'console=ttyS0,460800'
etc., but that's an ugly hack and adds a _third_ set of superio probe
code to the kernel, so doing that can come later. Eventually we can do
the superio probe centrally and remove it from the parport, IrDA, SH
board setup, and other code where it's currently duplicated. That's
probably a 2.7 task though.

-- 
dwmw2



--=-kz14IR3yAFXJPENtbGeX
Content-Disposition: attachment; filename=hsserial-2.5.61.patch
Content-Type: text/plain; name=hsserial-2.5.61.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D drivers/serial/8250.c 1.26 vs edited =3D=3D=3D=3D=3D
--- 1.26/drivers/serial/8250.c	Mon Jan  6 22:30:21 2003
+++ edited/drivers/serial/8250.c	Sun Feb 16 08:35:37 2003
@@ -159,7 +159,8 @@
 	{ "16C950/954",	128,	UART_CLEAR_FIFO | UART_USE_FIFO },
 	{ "ST16654",	64,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
 	{ "XR16850",	128,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
-	{ "RSA",	2048,	UART_CLEAR_FIFO | UART_USE_FIFO }
+	{ "RSA",	2048,	UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "NS16550A",	16,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_NATSEMI }
 };
=20
 static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offs=
et)
@@ -482,6 +483,40 @@
 	}
=20
 	/*
+	 * Check for a National Semiconductor SuperIO chip.
+	 * Attempt to switch to bank 2, read the value of the LOOP bit
+	 * from EXCR1. Switch back to bank 0, change it in MCR. Then
+	 * switch back to bank 2, read it from EXCR1 again and check
+	 * it's changed. If so, set baud_base in EXCR2 to 921600.
+	 */
+	serial_outp(up, UART_LCR, 0);
+	status1 =3D serial_in(up, UART_MCR);
+	serial_outp(up, UART_LCR, 0xE0);
+	status2 =3D serial_in(up, 0x02); /* EXCR1 */
+
+	if (!((status2 ^ status1) & UART_MCR_LOOP)) {
+		serial_outp(up, UART_LCR, 0);
+		serial_outp(up, UART_MCR, status1 ^ UART_MCR_LOOP);
+		serial_outp(up, UART_LCR, 0xE0);
+		status2 =3D serial_in(up, 0x02); /* EXCR1 */
+		serial_outp(up, UART_LCR, 0);
+		serial_outp(up, UART_MCR, status1);
+
+		if ((status2 ^ status1) & UART_MCR_LOOP) {
+			serial_outp(up, UART_LCR, 0xE0);
+			status1 =3D serial_in(up, 0x04); /* EXCR1 */
+			status1 &=3D ~0xB0; /* Disable LOCK, mask out PRESL[01] */
+			status1 |=3D 0x10;  /* 1.625 divisor for baud_base --> 921600 */
+			serial_outp(up, 0x04, status1);
+			serial_outp(up, UART_LCR, 0);
+
+			up->port.type =3D PORT_NS16550A;
+			up->port.uartclk =3D 921600*16;
+			return;
+		}
+	}
+
+	/*
 	 * No EFR.  Try to detect a TI16750, which only sets bit 5 of
 	 * the IIR when 64 byte FIFO mode is enabled when DLAB is set.
 	 * Try setting it with and without DLAB set.  Cheap clones
@@ -1369,7 +1404,11 @@
 		quot ++;
=20
 	if (uart_config[up->port.type].flags & UART_USE_FIFO) {
-		if ((up->port.uartclk / quot) < (2400 * 16))
+		/* quot >=3D 0x8000 is almost certainly a magic multiplier
+		 * and is going to mean baud rates of over 2400 unless=20
+		 * the clock is insanely slow. What we actually want is
+		 *'if baud < 2400' but we don't have that info. Doh. */
+		if (quot < 0x8000 && (up->port.uartclk / quot) < (2400 * 16))
 			fcr =3D UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
 #ifdef CONFIG_SERIAL_8250_RSA
 		else if (up->port.type =3D=3D PORT_RSA)
@@ -1434,7 +1473,13 @@
 		serial_outp(up, UART_EFR,
 			    termios->c_cflag & CRTSCTS ? UART_EFR_CTS :0);
 	}
-	serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
+
+	if (uart_config[up->port.type].flags & UART_NATSEMI) {
+		/* Switch to bank 2 not bank 1, to avoid resetting EXCR2 */
+		serial_outp(up, UART_LCR, 0xe0);
+	} else {
+		serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
+	}
 	serial_outp(up, UART_DLL, quot & 0xff);		/* LS of divisor */
 	serial_outp(up, UART_DLM, quot >> 8);		/* MS of divisor */
 	if (up->port.type =3D=3D PORT_16750)
=3D=3D=3D=3D=3D drivers/serial/core.c 1.35 vs edited =3D=3D=3D=3D=3D
--- 1.35/drivers/serial/core.c	Thu Jan  9 22:14:40 2003
+++ edited/drivers/serial/core.c	Sun Feb 16 08:47:20 2003
@@ -274,6 +274,7 @@
 		    unsigned int quot)
 {
 	unsigned int bits;
+	unsigned int baud;
=20
 	/* byte size and parity */
 	switch (cflag & CSIZE) {
@@ -305,7 +306,14 @@
 	 * Figure the timeout to send the above number of bits.
 	 * Add .02 seconds of slop
 	 */
-	port->timeout =3D (HZ * bits) / (port->uartclk / (16 * quot)) + HZ/50;
+	baud =3D (port->uartclk / (16 * quot));
+	if (port->flags & UPF_MAGIC_MULTIPLIER) {
+		if (quot =3D=3D 0x8001)
+			baud =3D port->uartclk / 4;
+		if (quot =3D=3D 0x8002)
+			baud =3D port->uartclk / 8;
+	}
+	port->timeout =3D (HZ * bits) / baud + HZ/50;
 }
=20
 EXPORT_SYMBOL(uart_update_timeout);
@@ -405,10 +413,19 @@
 	baud =3D uart_get_baud_rate(port, termios, old_termios, 0, max);
=20
 	/*
-	 * Old custom speed handling.
+	 * Magic divisor and old custom speed handling. The magic
+	 * divisor at least should be in a port-specific driver, not
+	 * here in core.c. But the ports don't actually get told the
+	 * baud rate, just the divisor.
 	 */
 	if (baud =3D=3D 38400 && (port->flags & UPF_SPD_MASK) =3D=3D UPF_SPD_CUST=
)
 		quot =3D port->custom_divisor;
+	else if ((port->flags & UPF_MAGIC_MULTIPLIER) &&
+			baud =3D=3D (port->uartclk/4))
+		quot =3D 0x8001;
+	else if ((port->flags & UPF_MAGIC_MULTIPLIER) &&
+			baud =3D=3D (port->uartclk/8))
+		quot =3D 0x8002;
 	else
 		quot =3D port->uartclk / (16 * baud);
=20
=3D=3D=3D=3D=3D include/linux/serial.h 1.7 vs edited =3D=3D=3D=3D=3D
--- 1.7/include/linux/serial.h	Sun Dec  1 10:22:53 2002
+++ edited/include/linux/serial.h	Sun Feb 16 08:47:54 2003
@@ -91,6 +91,7 @@
 #define UART_CLEAR_FIFO		0x01
 #define UART_USE_FIFO		0x02
 #define UART_STARTECH		0x04
+#define UART_NATSEMI		0x08
=20
 /*
  * Definitions for async_struct (and serial_struct) flags field
=3D=3D=3D=3D=3D include/linux/serial_core.h 1.14 vs edited =3D=3D=3D=3D=3D
--- 1.14/include/linux/serial_core.h	Thu Jan  9 22:14:40 2003
+++ edited/include/linux/serial_core.h	Sun Feb 16 08:48:48 2003
@@ -37,7 +37,8 @@
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13
-#define PORT_MAX_8250	13	/* max port ID */
+#define PORT_NS16550A	14
+#define PORT_MAX_8250	14	/* max port ID */
=20
 /*
  * ARM specific type numbers.  These are not currently guaranteed
@@ -172,6 +173,7 @@
 #define UPF_LOW_LATENCY		(1 << 13)
 #define UPF_BUGGY_UART		(1 << 14)
 #define UPF_AUTOPROBE		(1 << 15)
+#define UPF_MAGIC_MULTIPLIER	(1 << 16)
 #define UPF_BOOT_ONLYMCA	(1 << 22)
 #define UPF_CONS_FLOW		(1 << 23)
 #define UPF_SHARE_IRQ		(1 << 24)
@@ -179,7 +181,7 @@
 #define UPF_RESOURCES		(1 << 30)
 #define UPF_IOREMAP		(1 << 31)
=20
-#define UPF_CHANGE_MASK		(0x7fff)
+#define UPF_CHANGE_MASK		(0x17fff)
 #define UPF_USR_MASK		(UPF_SPD_MASK|UPF_LOW_LATENCY)
=20
 	unsigned int		mctrl;			/* current modem ctrl settings */

--=-kz14IR3yAFXJPENtbGeX
Content-Disposition: attachment; filename=hsserial-setserial.patch
Content-Type: text/plain; name=hsserial-setserial.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

? autom4te-2.53.cache
Index: setserial.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /mnt/src/cvsroot/serial/setserial/setserial.c,v
retrieving revision 1.5
diff -u -p -r1.5 setserial.c
--- setserial.c	28 Jul 2002 21:10:30 -0000	1.5
+++ setserial.c	16 Feb 2003 12:28:53 -0000
@@ -84,6 +84,7 @@ struct serial_type_struct {
 	{ PORT_16654,		"16654",	},
 	{ PORT_16850,		"16850",	},
 	{ PORT_RSA,		"RSA",		},
+	{ PORT_NS16550A,	"NS16550A"	},
 	{ PORT_AMBA,		"AMBA",		},
 	{ PORT_CLPS711X,	"CLPS711x",	},
 	{ PORT_SA1100,		"SA11x0",	},
@@ -139,6 +140,7 @@ struct flag_type_table {
 	{ CMD_FLAG,	"session_lockout",	ASYNC_SESSION_LOCKOUT,	ASYNC_SESSION_LOCKO=
UT,	2, FLAG_CAN_INVERT, },
 	{ CMD_FLAG,	"pgrp_lockout",		ASYNC_PGRP_LOCKOUT,	ASYNC_PGRP_LOCKOUT,	2, F=
LAG_CAN_INVERT, },
 	{ CMD_FLAG,	"callout_nohup",	ASYNC_CALLOUT_NOHUP,	ASYNC_CALLOUT_NOHUP,	2,=
 FLAG_CAN_INVERT, },
+	{ CMD_FLAG,	"magic_multiplier",	ASYNC_MAGIC_MULTIPLIER,	ASYNC_MAGIC_MULTI=
PLIER,	2, FLAG_CAN_INVERT, },
 	{ CMD_FLAG,	"low_latency",		ASYNC_LOW_LATENCY,	ASYNC_LOW_LATENCY,	0, FLAG=
_CAN_INVERT, },
 	{ CMD_PORT,	"port",			0,			0,			0, FLAG_NEED_VALUE, },
 	{ CMD_IRQ,	"irq",			0,			0,			0, FLAG_NEED_VALUE, },
@@ -640,7 +642,7 @@ static int set_serial(const char *device
 		case CMD_TYPE:
 			info.serinfo.type =3D uart_type(*arg++);
 			if (info.serinfo.type < 0) {
-				fprintf(stderr, "Illegal UART type: %s", *--arg);
+				fprintf(stderr, "Illegal UART type: %s\n", *--arg);
 				exit(1);
 			}
 			break;
Index: linux/serial.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /mnt/src/cvsroot/serial/setserial/linux/serial.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 serial.h
--- linux/serial.h	12 Jul 2001 21:15:16 -0000	1.1.1.1
+++ linux/serial.h	16 Feb 2003 12:28:53 -0000
@@ -97,8 +97,9 @@ struct serial_uart_config {
 #define ASYNC_SPD_WARP	0x1010	/* Use 460800 instead of 38400 bps */
=20
 #define ASYNC_LOW_LATENCY 0x2000 /* Request low latency behaviour */
+#define ASYNC_MAGIC_MULTIPLIER 0x10000
=20
-#define ASYNC_FLAGS	0x3FFF	/* Possible legal async flags */
+#define ASYNC_FLAGS	0x13FFF	/* Possible legal async flags */
 #define ASYNC_USR_MASK	0x3430	/* Legal flags that non-privileged
 				 * users can set or reset */
=20
Index: linux/serial_core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /mnt/src/cvsroot/serial/setserial/linux/serial_core.h,v
retrieving revision 1.2
diff -u -p -r1.2 serial_core.h
--- linux/serial_core.h	28 Jul 2002 21:06:44 -0000	1.2
+++ linux/serial_core.h	16 Feb 2003 12:28:54 -0000
@@ -37,7 +37,8 @@
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13
-#define PORT_MAX_8250	13	/* max port ID */
+#define PORT_NS16550A	14
+#define PORT_MAX_8250	14	/* max port ID */
=20
 /*
  * ARM specific type numbers.  These are not currently guaranteed

--=-kz14IR3yAFXJPENtbGeX--
