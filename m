Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289013AbSAUHaM>; Mon, 21 Jan 2002 02:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSAUHaD>; Mon, 21 Jan 2002 02:30:03 -0500
Received: from bs1.dnx.de ([213.252.143.130]:8857 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S288949AbSAUH3x>;
	Mon, 21 Jan 2002 02:29:53 -0500
Date: Mon, 21 Jan 2002 08:28:00 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: <marcelo@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: New version of AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201111030130.25470-100000@callisto.local>
Message-ID: <Pine.LNX.4.33.0201210821570.21377-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo and Alan,

Here's a new version of the AMD Elan patch, against 2.4.18-pre4. Please
apply.

Description:

The following patch for linux-2.4.18-pre3 fixes problems with the AMD Elan
CPUs which are popular x86 devices for embedded applications.

Content of the patch:
---------------------

	1. add a new processor type "Elan" in "Processor type
	   and features", with CONFIG_MELAN, is introduced

	2. fix the A20 code which was broken since the cleanup
	   in 2.4.15

	3. correct the ioport resource registration for Elans
	   (standard kernel reserves ports which are special
	   function registers on Elans)

	4. fix UART transmit bug

	5. fix timer 0 frequency to correct the clock

Details:
--------

1. As discussed on LKML the Elan processors have some
   "features" which need to be fixed but should not live
   in a standard kernel. Therefore, we propose a new
   configuration option CONFIG_MELAN. Ideas for better
   places for this option in the configuration tree are
   welcome.

2. In 2.4.15 H. Peter Anvin ported the A20 gate code from
   syslinux to the kernel, which is much more sophisticated
   than the code we had before. This leads to the Elan
   processors not booting any more (they did before without
   any problem, but that was more luck than intention). If
   you try to boot kernels newer than 2.4.14 the system
   reboots right in the middle of the initialisation
   sequence. As the Elans don't have a keyboard controller
   a special A20 gate sequence is added according to the
   config option introduced in 1.

3. Due to the fact that the ports of the PIC of the original
   PC are mirrored to several adresses Linux normally reserves
   the areas 0x20..0x3f and 0xa0..0xbf for pic1 and pic2,
   although the PICs use only the first two adresses of each
   block. This part of the patch uses only the "real" adresses,
   (0x20,0x21 / 0xa0,0xa1) as the Elan processors have special
   function registers in these blocks for the integrated
   peripherals.

4. The on-chip serial interface has a bug: the UART_LSR_THRE
   bit is delayed one bit clock after the interrupt line is
   asserted, i.e. if the serial port is running at 1200 bps, and
   the tranmitter becomes empty and causes an interupt, the
   interrupt is signalled about a millisecond (1/1200second)
   _before_ the THRE bit is set. This means that when the
   interrupt handler is entered after the interrupt, the THRE
   bit is still clear, the handler believes that there is
   nothing to be done and returns.

5. A normal PC has a basic frequency for the system timer 0
   of 1.19318 MHz, whereas the Elans have 1.1892 MHz due to the
   fact that all clocks are derived from a single oscillator.
   Without the patch the clock is wrong.

Credits:
--------

- Anders Larsen <anders@alarsen.net>
  First attempt of a patch for the Elan series
  http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0667.html

- Jason Sodergren <jason@mugwump.taiga.com>
  Clock patch

- Christer Weinigel <wingel@hog.ctrl-c.liu.se>
  Serial interface patch, A20 patch

- H. Peter Anvin <hpa@zytor.com>
  Discussions and ideas about the A20 stuff

- Juergen Beisert <jbeisert@eurodsn.de>
  Tests on SC520, suggestions for boot sequence changes, RS232

Patch:
------

The latest version of this patch can always be found on

  http://www.pengutronix.de/software/elan_en.html

The following code is version 2.4.18-pre4.1 of the patch. Suggestions for
further improvement are welcome.

----------8<----------8<----------8<----------8<----------8<----------
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre4/CREDITS linux-2.4.18-pre4-elan/CREDITS
--- linux-2.4.18-pre4/CREDITS	Sun Jan 20 20:39:06 2002
+++ linux-2.4.18-pre4-elan/CREDITS	Sun Jan 20 21:35:37 2002
@@ -2659,6 +2659,16 @@
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
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre4/Documentation/Configure.help linux-2.4.18-pre4-elan/Documentation/Configure.help
--- linux-2.4.18-pre4/Documentation/Configure.help	Sun Jan 20 20:39:06 2002
+++ linux-2.4.18-pre4-elan/Documentation/Configure.help	Sun Jan 20 21:35:38 2002
@@ -3813,6 +3813,7 @@
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
    - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+   - "Elan" for the AMD Elan family (Elan SC400/SC410).
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
    - "Winchip-2" for IDT Winchip 2.
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre4/arch/i386/boot/setup.S linux-2.4.18-pre4-elan/arch/i386/boot/setup.S
--- linux-2.4.18-pre4/arch/i386/boot/setup.S	Sun Jan 20 20:39:07 2002
+++ linux-2.4.18-pre4-elan/arch/i386/boot/setup.S	Mon Jan 21 07:44:20 2002
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
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre4/arch/i386/config.in linux-2.4.18-pre4-elan/arch/i386/config.in
--- linux-2.4.18-pre4/arch/i386/config.in	Fri Dec 21 18:41:53 2001
+++ linux-2.4.18-pre4-elan/arch/i386/config.in	Sun Jan 20 21:35:38 2002
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
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre4/arch/i386/kernel/setup.c linux-2.4.18-pre4-elan/arch/i386/kernel/setup.c
--- linux-2.4.18-pre4/arch/i386/kernel/setup.c	Sun Jan 20 20:39:07 2002
+++ linux-2.4.18-pre4-elan/arch/i386/kernel/setup.c	Sun Jan 20 21:35:38 2002
@@ -329,6 +329,10 @@
 	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
 	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
 };
+#ifdef CONFIG_ELAN
+standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
+standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
+#endif

 #define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))

diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre4/drivers/char/serial.c linux-2.4.18-pre4-elan/drivers/char/serial.c
--- linux-2.4.18-pre4/drivers/char/serial.c	Sun Jan 20 20:39:13 2002
+++ linux-2.4.18-pre4-elan/drivers/char/serial.c	Sun Jan 20 21:35:38 2002
@@ -57,6 +57,9 @@
  * 10/00: add in optional software flow control for serial console.
  *	  Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)
  *
+ * 12/01: Fix for AMD Elan bug in transmit irq routine, by
+ *	  Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
+ *	  Robert Schwebel <robert@schwebel.de>
  */

 static char *serial_version = "5.05c";
@@ -853,7 +856,7 @@
 		if (!info) {
 			info = IRQ_ports[irq];
 			if (pass_counter++ > RS_ISR_PASS_LIMIT) {
-#if 0
+#ifdef SERIAL_DEBUG_INTR
 				printk("rs loop break\n");
 #endif
 				break; 	/* Prevent infinite loops */
@@ -886,6 +889,9 @@
 	int first_multi = 0;
 	struct rs_multiport_struct *multi;
 #endif
+#ifdef CONFIG_MELAN
+	int iir;
+#endif

 #ifdef SERIAL_DEBUG_INTR
 	printk("rs_interrupt_single(%d)...", irq);
@@ -900,7 +906,9 @@
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
@@ -909,10 +917,24 @@
 		if (status & UART_LSR_DR)
 			receive_chars(info, &status, regs);
 		check_modem_status(info);
+
+#ifdef CONFIG_M_ELAN
+		/*
+		 * There is a bug in the UART on the AMD Elan SC4x0
+		 * embedded processor series; the THRE bit of the line
+		 * status register seems to be delayed one bit clock after
+		 * the interrupt is generated, so kludge this if the
+		 * IIR indicates a Transmit Holding Register Interrupt
+		 *
+		 */
+		if (status & UART_LSR_THRE || (iir & UART_IIR_ID) == UART_IIR_THRI)
+			transmit_chars(info, 0);
+#else
 		if (status & UART_LSR_THRE)
 			transmit_chars(info, 0);
+#endif
 		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
-#if 0
+#ifdef SERIAL_DEBUG_INTR
 			printk("rs_single loop break.\n");
 #endif
 			break;
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre4/include/asm-i386/timex.h linux-2.4.18-pre4-elan/include/asm-i386/timex.h
--- linux-2.4.18-pre4/include/asm-i386/timex.h	Thu Nov 22 20:46:18 2001
+++ linux-2.4.18-pre4-elan/include/asm-i386/timex.h	Sun Jan 20 21:41:35 2002
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
----------8<----------8<----------8<----------8<----------8<----------

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+


