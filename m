Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289779AbSAWKaX>; Wed, 23 Jan 2002 05:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSAWKaH>; Wed, 23 Jan 2002 05:30:07 -0500
Received: from bs1.dnx.de ([213.252.143.130]:29860 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S289772AbSAWK3z>;
	Wed, 23 Jan 2002 05:29:55 -0500
Date: Wed, 23 Jan 2002 11:28:48 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: <marcelo@conectiva.com.br>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201111030130.25470-100000@callisto.local>
Message-ID: <Pine.LNX.4.33.0201231121380.893-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the changelog for -pre5 has my AMD Elan fixes included, but unfortunately
you seem to have forgotten to apply the patch...

Here is the most recent version, against 2.4.18-pre6. Please note that the
CPU frequency driver is not included in this patch (it will be ported to
the cpufreq interface first), so this is purely bug fixing stuff.

Changelog as always on

  http://www.pengutronix.de/software/elan_en.html

----------8<----------8<----------8<----------8<----------
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre6/CREDITS linux-2.4.18-pre6-elan/CREDITS
--- linux-2.4.18-pre6/CREDITS	Wed Jan 23 07:51:48 2002
+++ linux-2.4.18-pre6-elan/CREDITS	Wed Jan 23 09:58:10 2002
@@ -2653,6 +2653,16 @@
 S: Oldenburg
 S: Germany

+N: Robert Schwebel
+E: robert@schwebel.de
+W: http://www.schwebel.de
+D: Embedded hacker and book author,
+D: AMD Elan support for Linux
+S: Pengutronix
+S: Braunschweiger Strasse 79
+S: 31134 Hildesheim
+S: Germany
+
 N: Darren Senn
 E: sinster@darkwater.com
 D: Whatever I notice needs doing (so far: itimers, /proc)
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre6/Documentation/Configure.help linux-2.4.18-pre6-elan/Documentation/Configure.help
--- linux-2.4.18-pre6/Documentation/Configure.help	Wed Jan 23 07:51:48 2002
+++ linux-2.4.18-pre6-elan/Documentation/Configure.help	Wed Jan 23 10:02:51 2002
@@ -3813,6 +3829,7 @@
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
    - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+   - "Elan" for the AMD Elan family (Elan SC400/SC410).
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
    - "Winchip-2" for IDT Winchip 2.
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre6/arch/i386/boot/setup.S linux-2.4.18-pre6-elan/arch/i386/boot/setup.S
--- linux-2.4.18-pre6/arch/i386/boot/setup.S	Wed Jan 23 07:51:49 2002
+++ linux-2.4.18-pre6-elan/arch/i386/boot/setup.S	Wed Jan 23 10:02:51 2002
@@ -42,6 +42,9 @@
  * if CX/DX have been changed in the e801 call and if so use AX/BX .
  * Michael Miller, April 2001 <michaelm@mjmm.org>
  *
+ * New A20 code ported from SYSLINUX by H. Peter Anvin. AMD Elan bugfixes
+ * by Robert Schwebel, December 2001 <robert@schwebel.de>
+ *
  */

 #include <linux/config.h>
@@ -651,7 +654,18 @@
 #
 # Enable A20.  This is at the very best an annoying procedure.
 # A20 code ported from SYSLINUX 1.52-1.63 by H. Peter Anvin.
+# AMD Elan bug fix by Robert Schwebel.
 #
+
+#if defined(CONFIG_MELAN)
+	movb $0x02, %al			# alternate A20 gate
+	outb %al, $0x92			# this works on SC410/SC520
+a20_elan_wait:
+        call a20_test
+        jz a20_elan_wait
+	jmp a20_done
+#endif
+

 A20_TEST_LOOPS		=  32		# Iterations per wait
 A20_ENABLE_LOOPS	= 255		# Total loops to try
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre6/arch/i386/config.in linux-2.4.18-pre6-elan/arch/i386/config.in
--- linux-2.4.18-pre6/arch/i386/config.in	Fri Dec 21 18:41:53 2001
+++ linux-2.4.18-pre6-elan/arch/i386/config.in	Wed Jan 23 10:02:51 2002
@@ -37,6 +37,7 @@
 	 Pentium-4				CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III			CONFIG_MK6 \
 	 Athlon/Duron/K7			CONFIG_MK7 \
+	 Elan					CONFIG_MELAN \
 	 Crusoe					CONFIG_MCRUSOE \
 	 Winchip-C6				CONFIG_MWINCHIPC6 \
 	 Winchip-2				CONFIG_MWINCHIP2 \
@@ -125,6 +126,11 @@
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MELAN" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_bool CONFIG_X86_USE_STRING_486 y
+   define_bool CONFIG_X86_ALIGNMENT_16 y
 fi
 if [ "$CONFIG_MCYRIXIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre6/arch/i386/kernel/setup.c linux-2.4.18-pre6-elan/arch/i386/kernel/setup.c
--- linux-2.4.18-pre6/arch/i386/kernel/setup.c	Wed Jan 23 07:51:50 2002
+++ linux-2.4.18-pre6-elan/arch/i386/kernel/setup.c	Wed Jan 23 10:02:51 2002
@@ -329,6 +329,10 @@
 	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
 	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
 };
+#ifdef CONFIG_ELAN
+standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
+standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
+#endif

 #define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))

diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre6/drivers/char/serial.c linux-2.4.18-pre6-elan/drivers/char/serial.c
--- linux-2.4.18-pre6/drivers/char/serial.c	Wed Jan 23 07:52:03 2002
+++ linux-2.4.18-pre6-elan/drivers/char/serial.c	Wed Jan 23 10:02:51 2002
@@ -57,6 +57,10 @@
  * 10/00: add in optional software flow control for serial console.
  *	  Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)
  *
+ * 12/01: Fix for AMD Elan bug in transmit irq routine, by
+ *	  Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
+ *	  Robert Schwebel <robert@schwebel.de>
+ *	  Juergen Beisert <jbeisert@eurodsn.de>
  */

 static char *serial_version = "5.05c";
@@ -802,6 +806,7 @@
 static void rs_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
 	int status;
+	int iir;
 	struct async_struct * info;
 	int pass_counter = 0;
 	struct async_struct *end_mark = 0;
@@ -825,12 +830,24 @@
 #endif

 	do {
-		if (!info->tty ||
-		    (serial_in(info, UART_IIR) & UART_IIR_NO_INT)) {
-			if (!end_mark)
-				end_mark = info;
+
+		/*
+		 * It seems to be important in a SC520 systems to read
+		 * the UART_IIR register only once per loop. But I think
+		 * this small correction does not disturb the normal
+		 * implementation.
+		 */
+
+		/* Something to test? */
+		/* Or is this UART the source of the interrupt? */
+
+		if (!info->tty ||
+		    ((iir=serial_inp(info, UART_IIR)) & 0x01)) {
+			if (!end_mark)			/* last reached?     */
+				end_mark = info;	/* ..yes, leave loop */
 			goto next;
-		}
+                }
+
 #ifdef SERIAL_DEBUG_INTR
 		printk("IIR = %x...", serial_in(info, UART_IIR));
 #endif
@@ -839,6 +856,24 @@
 		info->last_active = jiffies;

 		status = serial_inp(info, UART_LSR);
+
+#ifdef CONFIG_MELAN
+
+		/*
+		 * There is a bug (misfeature?) in the UART on the AMD Elan
+		 * SC4x0 and SC520 embedded processor series; the THRE bit of
+		 * the line status register seems to be delayed one bit
+		 * clock after the interrupt is generated, so kludge this
+		 * if the IIR indicates a Transmit Holding Register Interrupt
+		 */
+		if ((iir & UART_IIR_ID) == UART_IIR_THRI) {
+			status |= UART_LSR_THRE;
+#ifdef SERIAL_DEBUG_INTR
+			printk("|%x", status);
+#endif
+		}
+#endif /* CONFIG_MELAN */
+
 #ifdef SERIAL_DEBUG_INTR
 		printk("status = %x...", status);
 #endif
@@ -853,7 +888,7 @@
 		if (!info) {
 			info = IRQ_ports[irq];
 			if (pass_counter++ > RS_ISR_PASS_LIMIT) {
-#if 0
+#ifdef SERIAL_DEBUG_INTR
 				printk("rs loop break\n");
 #endif
 				break; 	/* Prevent infinite loops */
@@ -886,6 +921,9 @@
 	int first_multi = 0;
 	struct rs_multiport_struct *multi;
 #endif
+#ifdef CONFIG_MELAN
+	int iir;
+#endif

 #ifdef SERIAL_DEBUG_INTR
 	printk("rs_interrupt_single(%d)...", irq);
@@ -900,7 +938,9 @@
 	if (multi->port_monitor)
 		first_multi = inb(multi->port_monitor);
 #endif
-
+#ifdef CONFIG_MELAN
+	iir = serial_in(info, UART_IIR);
+#endif
 	do {
 		status = serial_inp(info, UART_LSR);
 #ifdef SERIAL_DEBUG_INTR
@@ -909,10 +949,25 @@
 		if (status & UART_LSR_DR)
 			receive_chars(info, &status, regs);
 		check_modem_status(info);
+
+#ifdef CONFIG_MELAN
+
+		/*
+		 * There is a bug (misfeature?) in the UART on the AMD Elan
+		 * SC4x0 and SC520 embedded processor series; the THRE bit of
+		 * the line status register seems to be delayed one bit
+		 * clock after the interrupt is generated, so kludge this
+		 * if the IIR indicates a Transmit Holding Register Interrupt
+		 */
+
+		if ((iir & UART_IIR_ID) == UART_IIR_THRI)
+			status |= UART_LSR_THRE;
+#endif
 		if (status & UART_LSR_THRE)
 			transmit_chars(info, 0);
+
 		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
-#if 0
+#ifdef SERIAL_DEBUG_INTR
 			printk("rs_single loop break.\n");
 #endif
 			break;
@@ -920,7 +975,7 @@
 #ifdef SERIAL_DEBUG_INTR
 		printk("IIR = %x...", serial_in(info, UART_IIR));
 #endif
-	} while (!(serial_in(info, UART_IIR) & UART_IIR_NO_INT));
+	} while (!((iir = serial_in(info, UART_IIR)) & UART_IIR_NO_INT));
 	info->last_active = jiffies;
 #ifdef CONFIG_SERIAL_MULTIPORT
 	if (multi->port_monitor)
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre6/include/asm-i386/timex.h linux-2.4.18-pre6-elan/include/asm-i386/timex.h
--- linux-2.4.18-pre6/include/asm-i386/timex.h	Thu Nov 22 20:46:18 2001
+++ linux-2.4.18-pre6-elan/include/asm-i386/timex.h	Wed Jan 23 10:02:51 2002
@@ -9,7 +9,12 @@
 #include <linux/config.h>
 #include <asm/msr.h>

-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#ifdef CONFIG_MELAN
+#  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
+#else
+#  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
+#endif
+
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
----------8<----------8<----------8<----------8<----------

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+


