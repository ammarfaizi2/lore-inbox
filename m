Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135924AbREJAfY>; Wed, 9 May 2001 20:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135939AbREJAfQ>; Wed, 9 May 2001 20:35:16 -0400
Received: from haneman.dialup.fu-berlin.de ([160.45.224.9]:38784 "EHLO
	haneman.dialup.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S135924AbREJAey>; Wed, 9 May 2001 20:34:54 -0400
Date: Thu, 10 May 2001 02:31:26 +0200
From: AmigaLinux A2232 Driver Project 
	<a2232@haneman.dialup.fu-berlin.de>
Message-Id: <200105100031.CAA03671@haneman.dialup.fu-berlin.de>
To: torvalds@transmeta.com
Subject: New Amiga Driver
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        geert@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I've written a driver for the Amiga multi-serial ZorroII board "A2232"
that I'd like to see included into the main kernel tree.
This is the driver HPA allocated majors 224 and 225 for.

Greetings,
Enver

diff -urN linux/CREDITS linux-2.4.4-a2232/CREDITS
--- linux/CREDITS	Sat Apr 21 01:23:12 2001
+++ linux-2.4.4-a2232/CREDITS	Thu May 10 01:13:28 2001
@@ -1043,6 +1043,11 @@
 S: 2400 AG, Alphen aan den Rijn
 S: The Netherlands
 
+N: Enver Haase
+E: ehaase@inf.fu-berlin.de
+W: http://www.inf.fu-berlin.de/~ehaase
+D: Driver for the Commodore A2232 serial board
+
 N: Bruno Haible
 E: haible@ma2s2.mathematik.uni-karlsruhe.de
 D: SysV FS, shm swapping, memory management fixes
diff -urN linux/Documentation/Configure.help linux-2.4.4-a2232/Documentation/Configure.help
--- linux/Documentation/Configure.help	Sat Apr 21 01:23:12 2001
+++ linux-2.4.4-a2232/Documentation/Configure.help	Thu May 10 01:18:21 2001
@@ -16185,6 +16185,16 @@
   inserted in and removed from the running kernel whenever you want).
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.
+ 
+Commodore A2232 serial support
+CONFIG_A2232
+  If you want to enable support for Commodore A2232 seven-port
+  serial boards, answer Y.
+ 
+  This driver can be built as a module; but then "generic_serial.o"
+  will also be built as a module. This has to be loaded before
+  "ser_a2232.o". If you want to do this, answer M here and read
+  "Documentation/modules.txt".
 
 Atari DMA sound support
 CONFIG_DMASOUND_ATARI
diff -urN linux/Documentation/devices.txt linux-2.4.4-a2232/Documentation/devices.txt
--- linux/Documentation/devices.txt	Sat Dec 30 20:26:10 2000
+++ linux-2.4.4-a2232/Documentation/devices.txt	Thu May 10 01:14:46 2001
@@ -2436,7 +2436,7 @@
 
 224 char	A2232 serial card
 		  0 = /dev/ttyY0		First A2232 port
-		  1 = /dev/cuy0			Second A2232 port
+		  1 = /dev/ttyY1		Second A2232 port
 		    ...
 
 225 char	A2232 serial card (alternate devices)
diff -urN linux/MAINTAINERS linux-2.4.4-a2232/MAINTAINERS
--- linux/MAINTAINERS	Wed Apr 25 23:35:25 2001
+++ linux-2.4.4-a2232/MAINTAINERS	Thu May 10 01:27:38 2001
@@ -106,6 +106,13 @@
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
+A2232 SERIAL BOARD DRIVER
+P:      Enver Haase
+M:      ehaase@inf.fu-berlin.de
+M:      A2232@gmx.net
+L:      linux-m68k@lists.linux-m68k.org
+S:      Maintained
+
 ACI MIXER DRIVER
 P:	Robert Siemer
 M:	Robert.Siemer@gmx.de
diff -urN linux/drivers/char/Config.in linux-2.4.4-a2232/drivers/char/Config.in
--- linux/drivers/char/Config.in	Wed Mar  7 04:44:34 2001
+++ linux-2.4.4-a2232/drivers/char/Config.in	Thu May 10 01:23:30 2001
@@ -60,6 +60,9 @@
      tristate '    Stallion EC8/64, ONboard, Brumby support' CONFIG_ISTALLION
    fi
 fi
+if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_ZORRO" = "y" ]; then
+   tristate 'Commodore A2232 serial support (EXPERIMENTAL)' CONFIG_A2232
+fi
 if [ "$CONFIG_FOOTBRIDGE" = "y" ]; then
    bool 'DC21285 serial port support' CONFIG_SERIAL_21285
    if [ "$CONFIG_SERIAL_21285" = "y" ]; then
diff -urN linux/drivers/char/Makefile linux-2.4.4-a2232/drivers/char/Makefile
--- linux/drivers/char/Makefile	Thu Apr 26 23:11:29 2001
+++ linux-2.4.4-a2232/drivers/char/Makefile	Thu May 10 01:19:35 2001
@@ -139,6 +139,7 @@
 obj-$(CONFIG_N_HDLC) += n_hdlc.o
 obj-$(CONFIG_SPECIALIX) += specialix.o
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
+obj-$(CONFIG_A2232) += ser_a2232.o generic_serial.o
 obj-$(CONFIG_SX) += sx.o generic_serial.o
 obj-$(CONFIG_RIO) += rio/rio.o generic_serial.o
 obj-$(CONFIG_SH_SCI) += sh-sci.o generic_serial.o
diff -urN linux/drivers/char/ser_a2232.c linux-2.4.4-a2232/drivers/char/ser_a2232.c
--- linux/drivers/char/ser_a2232.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.4-a2232/drivers/char/ser_a2232.c	Thu May 10 01:24:53 2001
@@ -0,0 +1,880 @@
+/* drivers/char/ser_a2232.c */
+
+/* $Id: ser_a2232.c,v 0.4 2000/01/25 12:00:00 ehaase Exp $ */
+
+/* Linux serial driver for the Amiga A2232 board */
+
+/* This driver is MAINTAINED. Before applying any changes, please contact
+ * the author.
+ */
+
+/* Copyright (c) 2000-2001 Enver Haase    <ehaase@inf.fu-berlin.de>
+ *                   alias The A2232 driver project <A2232@gmx.net>
+ * All rights reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+/***************************** Documentation ************************/
+/*
+ * This driver is in EXPERIMENTAL state. That means I could not find
+ * someone with five A2232 boards with 35 ports running at 19200 bps
+ * at the same time and test the machine's behaviour.
+ * However, I know that you can performance-tweak this driver (see
+ * the source code).
+ * One thing to consider is the time this driver consumes during the
+ * Amiga's vertical blank interrupt. Everything that is to be done
+ * _IS DONE_ when entering the vertical blank interrupt handler of
+ * this driver.
+ * However, it would be more sane to only do the job for only ONE card
+ * instead of ALL cards at a time; or, more generally, to handle only
+ * SOME ports instead of ALL ports at a time.
+ * However, as long as no-one runs into problems I guess I shouldn't
+ * change the driver as it runs fine for me :) .
+ *
+ * Version history of this file:
+ * 0.4	Resolved licensing issues.
+ * 0.3	Inclusion in the Linux/m68k tree, small fixes.
+ * 0.2	Added documentation, minor typo fixes.
+ * 0.1	Initial release.
+ *
+ * TO DO:
+ * -	Handle incoming BREAK events. I guess "Stevens: Advanced
+ *	Programming in the UNIX(R) Environment" is a good reference
+ *	on what is to be done.
+ * -	When installing as a module, don't simply 'printk' text, but
+ *	send it to the TTY used by the user.
+ *
+ * THANKS TO:
+ * -	Jukka Marin (65EC02 code).
+ * -	The other NetBSD developers on whose A2232 driver I had a
+ *	pretty close look. However, I didn't copy any code so it
+ *	is okay to put my code under the GPL and include it into
+ *	Linux.
+ */
+/***************************** End of Documentation *****************/
+
+/***************************** Defines ******************************/
+/*
+ * Enables experimental 115200 (normal) 230400 (turbo) baud rate.
+ * The A2232 specification states it can only operate at speeds up to
+ * 19200 bits per second, and I was not able to send a file via
+ * "sz"/"rz" and a null-modem cable from one A2232 port to another
+ * at 115200 bits per second.
+ * However, this might work for you.
+ */
+#undef A2232_SPEEDHACK
+/*
+ * Default is not to use RTS/CTS so you could be talked to death.
+ */
+#define A2232_SUPPRESS_RTSCTS_WARNING
+/************************* End of Defines ***************************/
+
+/***************************** Includes *****************************/
+#include <linux/module.h>
+
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+
+#include <asm/setup.h>
+#include <asm/amigaints.h>
+#include <asm/amigahw.h>
+#include <linux/zorro.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+
+#include <linux/delay.h>
+
+#include <linux/serial.h>
+#include <linux/generic_serial.h>
+
+#include "ser_a2232.h"
+#include "ser_a2232fw.h"
+/************************* End of Includes **************************/
+
+/***************************** Prototypes ***************************/
+/* Helper functions */
+static __inline__ volatile struct a2232status *a2232stat(unsigned int board,
+						unsigned int portonboard);
+static __inline__ volatile struct a2232memory *a2232mem (unsigned int board); 
+static __inline__ void a2232_receive_char(	struct a2232_port *port,
+						int ch, int err );
+/* The interrupt service routine */
+static void a2232_vbl_inter(int irq, void *data, struct pt_regs *fp);
+/* Initialize the port structures */
+static void a2232_init_portstructs(void);
+/* Initialize and register TTY drivers. */
+/* returns 0 IFF successful */
+static int a2232_init_drivers(void); 
+/* Initialize all A2232 boards; main entry point. */
+int a2232board_init(void);
+
+/* BEGIN GENERIC_SERIAL PROTOTYPES */
+static void a2232_disable_tx_interrupts(void *ptr);
+static void a2232_enable_tx_interrupts(void *ptr);
+static void a2232_disable_rx_interrupts(void *ptr);
+static void a2232_enable_rx_interrupts(void *ptr);
+static int  a2232_get_CD(void *ptr);
+static void a2232_shutdown_port(void *ptr);
+static int  a2232_set_real_termios(void *ptr);
+static int  a2232_chars_in_buffer(void *ptr);
+static void a2232_close(void *ptr);
+static void a2232_hungup(void *ptr);
+/* static void a2232_getserial (void *ptr, struct serial_struct *sp); */
+/* END GENERIC_SERIAL PROTOTYPES */
+
+/* Functions that the TTY driver struct expects */
+static int  a2232_ioctl(struct tty_struct *tty, struct file *file,
+										unsigned int cmd, unsigned long arg);
+static void a2232_throttle(struct tty_struct *tty);
+static void a2232_unthrottle(struct tty_struct *tty);
+static int  a2232_open(struct tty_struct * tty, struct file * filp);
+/************************* End of Prototypes ************************/
+
+/***************************** Global variables *********************/
+/*---------------------------------------------------------------------------
+ * Interface from generic_serial.c back here
+ *--------------------------------------------------------------------------*/
+static struct real_driver a2232_real_driver = {
+        a2232_disable_tx_interrupts,
+        a2232_enable_tx_interrupts,
+        a2232_disable_rx_interrupts,
+        a2232_enable_rx_interrupts,
+        a2232_get_CD,
+        a2232_shutdown_port,
+        a2232_set_real_termios,
+        a2232_chars_in_buffer,
+        a2232_close,
+        a2232_hungup,
+	NULL	/* a2232_getserial */
+};
+
+static void *a2232_driver_ID = &a2232_driver_ID; // Some memory address WE own.
+
+/* Ports structs */
+static struct a2232_port a2232_ports[MAX_A2232_BOARDS*NUMLINES];
+
+/* TTY driver structs */
+static struct tty_driver a2232_driver;
+static struct tty_driver a2232_callout_driver;
+
+/* Variables used by the TTY driver */
+static int a2232_refcount;
+static struct tty_struct *a2232_table[MAX_A2232_BOARDS*NUMLINES] = { NULL, };
+static struct termios *a2232_termios[MAX_A2232_BOARDS*NUMLINES];
+static struct termios *a2232_termios_locked[MAX_A2232_BOARDS*NUMLINES];
+
+/* nr of cards completely (all ports) and correctly configured */
+static int nr_a2232; 
+
+/* zorro_dev structs for the A2232's */
+static struct zorro_dev *zd_a2232[MAX_A2232_BOARDS]; 
+/***************************** End of Global variables **************/
+
+/***************************** Functions ****************************/
+/*** BEGIN OF REAL_DRIVER FUNCTIONS ***/
+
+static void a2232_disable_tx_interrupts(void *ptr)
+{
+	struct a2232_port *port;
+	volatile struct a2232status *stat;
+	unsigned long flags;
+  
+	port = ptr;
+	stat = a2232stat(port->which_a2232, port->which_port_on_a2232);
+	stat->OutDisable = -1;
+
+	/* Does this here really have to be? */
+	save_flags(flags);
+	cli(); 
+	port->gs.flags &= ~GS_TX_INTEN;
+	restore_flags(flags);
+}
+
+static void a2232_enable_tx_interrupts(void *ptr)
+{
+	struct a2232_port *port;
+	volatile struct a2232status *stat;
+	unsigned long flags;
+
+	port = ptr;
+	stat = a2232stat(port->which_a2232, port->which_port_on_a2232);
+	stat->OutDisable = 0;
+
+	/* Does this here really have to be? */
+	save_flags(flags);
+	cli();
+	port->gs.flags |= GS_TX_INTEN;
+	restore_flags(flags);
+}
+
+static void a2232_disable_rx_interrupts(void *ptr)
+{
+	struct a2232_port *port;
+	port = ptr;
+	port->disable_rx = -1;
+}
+
+static void a2232_enable_rx_interrupts(void *ptr)
+{
+	struct a2232_port *port;
+	port = ptr;
+	port->disable_rx = 0;
+}
+
+static int  a2232_get_CD(void *ptr)
+{
+	return ((struct a2232_port *) ptr)->cd_status;
+}
+
+static void a2232_shutdown_port(void *ptr)
+{
+	struct a2232_port *port;
+	volatile struct a2232status *stat;
+	unsigned long flags;
+
+	port = ptr;
+	stat = a2232stat(port->which_a2232, port->which_port_on_a2232);
+
+	save_flags(flags);
+	cli();
+
+	port->gs.flags &= ~GS_ACTIVE;
+	
+	if (port->gs.tty && port->gs.tty->termios->c_cflag & HUPCL) {
+		/* Set DTR and RTS to Low, flush output.
+		   The NetBSD driver "msc.c" does it this way. */
+		stat->Command = (	(stat->Command & ~A2232CMD_CMask) | 
+					A2232CMD_Close );
+		stat->OutFlush = -1;
+		stat->Setup = -1;
+	}
+
+	restore_flags(flags);
+	
+	/* After analyzing control flow, I think a2232_shutdown_port
+		is actually the last call from the system when at application
+		level someone issues a "echo Hello >>/dev/ttyY0".
+		Therefore I think the MOD_DEC_USE_COUNT should be here and
+		not in "a2232_close()". See the comment in "sx.c", too.
+		If you run into problems, compile this driver into the
+		kernel instead of compiling it as a module. */
+	MOD_DEC_USE_COUNT;
+}
+
+static int  a2232_set_real_termios(void *ptr)
+{
+	unsigned int cflag, baud, chsize, stopb, parity, softflow;
+	int rate;
+	int a2232_param, a2232_cmd;
+	unsigned long flags;
+	unsigned int i;
+	struct a2232_port *port = ptr;
+	volatile struct a2232status *status;
+	volatile struct a2232memory *mem;
+
+	if (!port->gs.tty || !port->gs.tty->termios) return 0;
+
+	status = a2232stat(port->which_a2232, port->which_port_on_a2232);
+	mem = a2232mem(port->which_a2232);
+	
+	a2232_param = a2232_cmd = 0;
+
+	// get baud rate
+	baud = port->gs.baud;
+	if (baud == 0) {
+		/* speed == 0 -> drop DTR, do nothing else */
+		save_flags(flags);
+		cli();
+		// Clear DTR (and RTS... mhhh).
+		status->Command = (	(status->Command & ~A2232CMD_CMask) |
+					A2232CMD_Close );
+		status->OutFlush = -1;
+		status->Setup = -1;
+		
+		restore_flags(flags);
+		return 0;
+	}
+	
+	rate = A2232_BAUD_TABLE_NOAVAIL;
+	for (i=0; i < A2232_BAUD_TABLE_NUM_RATES * 3; i += 3){
+		if (a2232_baud_table[i] == baud){
+			if (mem->Common.Crystal == A2232_TURBO) rate = a2232_baud_table[i+2];
+			else                                    rate = a2232_baud_table[i+1];
+		}
+	}
+	if (rate == A2232_BAUD_TABLE_NOAVAIL){
+		printk("a2232: Board %d Port %d unsupported baud rate: %d baud. Using another.\n",port->which_a2232,port->which_port_on_a2232,baud);
+		// This is useful for both (turbo or normal) Crystal versions.
+		rate = A2232PARAM_B9600;
+	}
+	a2232_param |= rate;
+
+	cflag  = port->gs.tty->termios->c_cflag;
+
+	// get character size
+	chsize = cflag & CSIZE;
+	switch (chsize){
+		case CS8: 	a2232_param |= A2232PARAM_8Bit; break;
+		case CS7: 	a2232_param |= A2232PARAM_7Bit; break;
+		case CS6: 	a2232_param |= A2232PARAM_6Bit; break;
+		case CS5: 	a2232_param |= A2232PARAM_5Bit; break;
+		default:	printk("a2232: Board %d Port %d unsupported character size: %d. Using 8 data bits.\n",
+					port->which_a2232,port->which_port_on_a2232,chsize);
+				a2232_param |= A2232PARAM_8Bit; break;
+	}
+
+	// get number of stop bits
+	stopb  = cflag & CSTOPB;
+	if (stopb){ // two stop bits instead of one
+		printk("a2232: Board %d Port %d 2 stop bits unsupported. Using 1 stop bit.\n",
+			port->which_a2232,port->which_port_on_a2232);
+	}
+
+	// Warn if RTS/CTS not wanted
+	if (!(cflag & CRTSCTS)){
+#ifndef A2232_SUPPRESS_RTSCTS_WARNING
+		printk("a2232: Board %d Port %d cannot switch off firmware-implemented RTS/CTS hardware flow control.\n",
+			port->which_a2232,port->which_port_on_a2232);
+#endif
+	}
+
+	/*	I think this is correct.
+		However, IXOFF means _input_ flow control and I wonder
+		if one should care about IXON _output_ flow control,
+		too. If this makes problems, one should turn the A2232
+		firmware XON/XOFF "SoftFlow" flow control off and use
+		the conventional way of inserting START/STOP characters
+		by hand in throttle()/unthrottle().
+	*/
+	softflow = !!( port->gs.tty->termios->c_iflag & IXOFF );
+
+	// get Parity (Enabled/Disabled? If Enabled, Odd or Even?)
+	parity = cflag & (PARENB | PARODD);
+	if (parity & PARENB){
+		if (parity & PARODD){
+			a2232_cmd |= A2232CMD_OddParity;
+		}
+		else{
+			a2232_cmd |= A2232CMD_EvenParity;
+		}
+	}
+	else a2232_cmd |= A2232CMD_NoParity;
+
+
+	/*	Hmm. Maybe an own a2232_port structure
+		member would be cleaner?	*/
+	if (cflag & CLOCAL)
+		port->gs.flags &= ~ASYNC_CHECK_CD;
+	else
+		port->gs.flags |= ASYNC_CHECK_CD;
+
+
+	/* Now we have all parameters and can go to set them: */
+	save_flags(flags);
+	cli();
+
+	status->Param = a2232_param | A2232PARAM_RcvBaud;
+	status->Command = a2232_cmd | A2232CMD_Open |  A2232CMD_Enable;
+	status->SoftFlow = softflow;
+	status->OutDisable = 0;
+	status->Setup = -1;
+
+	restore_flags(flags);
+	return 0;
+}
+
+static int  a2232_chars_in_buffer(void *ptr)
+{
+	struct a2232_port *port;
+	volatile struct a2232status *status; 
+	unsigned char ret; /* we need modulo-256 arithmetics */
+	port = ptr;
+	status = a2232stat(port->which_a2232, port->which_port_on_a2232);
+#if A2232_IOBUFLEN != 256
+#error "Re-Implement a2232_chars_in_buffer()!"
+#endif
+	ret = (status->OutHead - status->OutTail);
+	return ret;
+}
+
+static void a2232_close(void *ptr)
+{
+	a2232_disable_tx_interrupts(ptr);
+	a2232_disable_rx_interrupts(ptr);
+	/* see the comment in a2232_shutdown_port above. */
+	/* MOD_DEC_USE_COUNT; */
+}
+
+static void a2232_hungup(void *ptr)
+{
+	a2232_close(ptr);
+}
+/*** END   OF REAL_DRIVER FUNCTIONS ***/
+
+/*** BEGIN  FUNCTIONS EXPECTED BY TTY DRIVER STRUCTS ***/
+static int a2232_ioctl(	struct tty_struct *tty, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	return -ENOIOCTLCMD;
+}
+
+static void a2232_throttle(struct tty_struct *tty)
+{
+/* Throttle: System cannot take another chars: Drop RTS or
+             send the STOP char or whatever.
+   The A2232 firmware does RTS/CTS anyway, and XON/XOFF
+   if switched on. So the only thing we can do at this
+   layer here is not taking any characters out of the
+   A2232 buffer any more. */
+	struct a2232_port *port = (struct a2232_port *) tty->driver_data;
+	port->throttle_input = -1;
+}
+
+static void a2232_unthrottle(struct tty_struct *tty)
+{
+/* Unthrottle: dual to "throttle()" above. */
+	struct a2232_port *port = (struct a2232_port *) tty->driver_data;
+	port->throttle_input = 0;
+}
+
+static int  a2232_open(struct tty_struct * tty, struct file * filp)
+{
+/* More or less stolen from other drivers. */
+	int line;
+	int retval;
+	struct a2232_port *port;
+
+	line = MINOR(tty->device);
+	port = &a2232_ports[line];
+	
+	tty->driver_data = port;
+	port->gs.tty = tty;
+	port->gs.count++;
+	retval = gs_init_port(&port->gs);
+	if (retval) {
+		port->gs.count--;
+		return retval;
+	}
+	port->gs.flags |= GS_ACTIVE;
+	if (port->gs.count == 1) {
+		MOD_INC_USE_COUNT;
+	}
+	retval = gs_block_til_ready(port, filp);
+
+	if (retval) {
+		MOD_DEC_USE_COUNT;
+		port->gs.count--;
+		return retval;
+	}
+
+	if ((port->gs.count == 1) && (port->gs.flags & ASYNC_SPLIT_TERMIOS)){
+		if (tty->driver.subtype == A2232_TTY_SUBTYPE_NORMAL)
+			*tty->termios = port->gs.normal_termios;
+		else 
+			*tty->termios = port->gs.callout_termios;
+		a2232_set_real_termios (port);
+	}
+
+	port->gs.session = current->session;
+	port->gs.pgrp = current->pgrp;
+
+	a2232_enable_rx_interrupts(port);
+	
+	return 0;
+}
+/*** END OF FUNCTIONS EXPECTED BY TTY DRIVER STRUCTS ***/
+
+static __inline__ volatile struct a2232status *a2232stat(unsigned int board, unsigned int portonboard)
+{
+	volatile struct a2232memory *mem = a2232mem(board);
+	return &(mem->Status[portonboard]);
+}
+
+static __inline__ volatile struct a2232memory *a2232mem (unsigned int board)
+{
+	return (volatile struct a2232memory *) ZTWO_VADDR( zd_a2232[board]->resource.start );
+}
+
+static __inline__ void a2232_receive_char(	struct a2232_port *port,
+						int ch, int err )
+{
+/* 	Mostly stolen from other drivers.
+	Maybe one could implement a more efficient version by not only
+	transferring one character at a time.
+*/
+	struct tty_struct *tty = port->gs.tty;
+	
+	if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+		return;
+
+	tty->flip.count++;
+
+#if 0
+	switch(err) {
+	case TTY_BREAK:
+		break;
+	case TTY_PARITY:
+		break;
+	case TTY_OVERRUN:
+		break;
+	case TTY_FRAME:
+		break;
+	}
+#endif
+
+	*tty->flip.flag_buf_ptr++ = err;
+	*tty->flip.char_buf_ptr++ = ch;
+	tty_flip_buffer_push(tty);
+}
+
+static void a2232_vbl_inter(int irq, void *data, struct pt_regs *fp)
+{
+#if A2232_IOBUFLEN != 256
+#error "Re-Implement a2232_vbl_inter()!"
+#endif
+
+struct a2232_port *port;
+volatile struct a2232memory *mem;
+volatile struct a2232status *status;
+unsigned char newhead;
+unsigned char bufpos; /* Must be unsigned char. We need the modulo-256 arithmetics */
+unsigned char ncd, ocd, ccd; /* names consistent with the NetBSD driver */
+volatile u_char *ibuf, *cbuf, *obuf;
+int ch, err, n, p;
+	for (n = 0; n < nr_a2232; n++){		/* for every completely initialized A2232 board */
+		mem = a2232mem(n);
+		for (p = 0; p < NUMLINES; p++){	/* for every port on this board */
+			err = 0;
+			port = &a2232_ports[n*NUMLINES+p];
+			if ( port->gs.flags & GS_ACTIVE ){ /* if the port is used */
+
+				status = a2232stat(n,p);
+
+				if (!port->disable_rx && !port->throttle_input){ /* If input is not disabled */
+					newhead = status->InHead;               /* 65EC02 write pointer */
+					bufpos = status->InTail;
+
+					/* check for input for this port */
+					if (newhead != bufpos) {
+						/* buffer for input chars/events */
+						ibuf = mem->InBuf[p];
+ 
+						/* data types of bytes in ibuf */
+						cbuf = mem->InCtl[p];
+ 
+						/* do for all chars */
+						while (bufpos != newhead) {
+							/* which type of input data? */
+							switch (cbuf[bufpos]) {
+								/* switch on input event (CD, BREAK, etc.) */
+							case A2232INCTL_EVENT:
+								switch (ibuf[bufpos++]) {
+								case A2232EVENT_Break:
+									/* TODO: Handle BREAK signal */
+									break;
+									/*	A2232EVENT_CarrierOn and A2232EVENT_CarrierOff are
+										handled in a separate queue and should not occur here. */
+								case A2232EVENT_Sync:
+									printk("A2232: 65EC02 software sent SYNC event, don't know what to do. Ignoring.");
+									break;
+								default:
+									printk("A2232: 65EC02 software broken, unknown event type %d occured.\n",ibuf[bufpos-1]);
+								} /* event type switch */
+								break;
+ 							case A2232INCTL_CHAR:
+								/* Receive incoming char */
+								a2232_receive_char(port, ibuf[bufpos], err);
+								bufpos++;
+								break;
+ 							default:
+								printk("A2232: 65EC02 software broken, unknown data type %d occured.\n",cbuf[bufpos]);
+								bufpos++;
+							} /* switch on input data type */
+						} /* while there's something in the buffer */
+
+						status->InTail = bufpos;            /* tell 65EC02 what we've read */
+						
+					} /* if there was something in the buffer */                          
+				} /* If input is not disabled */
+
+				/* Now check if there's something to output */
+				obuf = mem->OutBuf[p];
+				bufpos = status->OutHead;
+				while ( (port->gs.xmit_cnt > 0)		&&
+					(!port->gs.tty->stopped)	&&
+					(!port->gs.tty->hw_stopped) ){	/* While there are chars to transmit */
+					if (((bufpos+1) & A2232_IOBUFLENMASK) != status->OutTail) { /* If the A2232 buffer is not full */
+						ch = port->gs.xmit_buf[port->gs.xmit_tail];					/* get the next char to transmit */
+						port->gs.xmit_tail = (port->gs.xmit_tail+1) & (SERIAL_XMIT_SIZE-1); /* modulo-addition for the gs.xmit_buf ring-buffer */
+						obuf[bufpos++] = ch;																/* put it into the A2232 buffer */
+						port->gs.xmit_cnt--;
+					}
+					else{																									/* If A2232 the buffer is full */
+						break;																							/* simply stop filling it. */
+					}													
+				}					
+				status->OutHead = bufpos;
+					
+				/* WakeUp if output buffer runs low */
+				if ((port->gs.xmit_cnt <= port->gs.wakeup_chars) && port->gs.tty) {
+					if ((port->gs.tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && port->gs.tty->ldisc.write_wakeup){
+						(port->gs.tty->ldisc.write_wakeup)(port->gs.tty);
+					}
+					wake_up_interruptible(&port->gs.tty->write_wait);
+				}
+			} // if the port is used
+		} // for every port on the board
+			
+		/* Now check the CD message queue */
+		newhead = mem->Common.CDHead;
+		bufpos = mem->Common.CDTail;
+		if (newhead != bufpos){				/* There are CD events in queue */
+			ocd = mem->Common.CDStatus; 		/* get old status bits */
+			while (newhead != bufpos){		/* read all events */
+				ncd = mem->CDBuf[bufpos++]; 	/* get one event */
+				ccd = ncd ^ ocd; 		/* mask of changed lines */
+				ocd = ncd; 			/* save new status bits */
+				for(p=0; p < NUMLINES; p++){	/* for all ports */
+					if (ccd & 1){		/* this one changed */
+
+						struct a2232_port *port = &a2232_ports[n*7+p];
+						port->cd_status = !(ncd & 1); /* ncd&1 <=> CD is now off */
+
+						if (!(port->gs.flags & ASYNC_CHECK_CD))
+							;	/* Don't report DCD changes */
+						else if (port->cd_status) { // if DCD on: DCD went UP!
+							if (~(port->gs.flags & ASYNC_NORMAL_ACTIVE) ||
+							    ~(port->gs.flags & ASYNC_CALLOUT_ACTIVE)) {
+								/* Are we blocking in open?*/
+								wake_up_interruptible(&port->gs.open_wait);
+							}
+						}
+						else { // if DCD off: DCD went DOWN!
+							if (!((port->gs.flags & ASYNC_CALLOUT_ACTIVE) &&
+							      (port->gs.flags & ASYNC_CALLOUT_NOHUP))) {
+								if (port->gs.tty)
+									tty_hangup (port->gs.tty);
+							}
+						}
+						
+					} // if CD changed for this port
+					ccd >>= 1;
+					ncd >>= 1;									/* Shift bits for next line */
+				} // for every port
+			} // while CD events in queue
+			mem->Common.CDStatus = ocd; /* save new status */
+			mem->Common.CDTail = bufpos; /* remove events */
+		} // if events in CD queue
+		
+	} // for every completely initialized A2232 board
+}
+
+static void a2232_init_portstructs(void)
+{
+	struct a2232_port *port;
+	int i;
+
+	for (i = 0; i < MAX_A2232_BOARDS*NUMLINES; i++) {
+		port = a2232_ports + i;
+		port->which_a2232 = i/NUMLINES;
+		port->which_port_on_a2232 = i%NUMLINES;
+		port->disable_rx = port->throttle_input = port->cd_status = 0;
+		port->gs.callout_termios = tty_std_termios;
+		port->gs.normal_termios = tty_std_termios;
+		port->gs.magic = A2232_MAGIC;
+		port->gs.close_delay = HZ/2;
+		port->gs.closing_wait = 30 * HZ;
+		port->gs.rd = &a2232_real_driver;
+#ifdef NEW_WRITE_LOCKING
+		init_MUTEX(&(port->gs.port_write_sem));
+#endif
+		init_waitqueue_head(&port->gs.open_wait);
+		init_waitqueue_head(&port->gs.close_wait);
+	}
+}
+
+static int a2232_init_drivers(void)
+{
+	int error;
+
+	memset(&a2232_driver, 0, sizeof(a2232_driver));
+	a2232_driver.magic = TTY_DRIVER_MAGIC;
+	a2232_driver.driver_name = "commodore_a2232";
+	a2232_driver.name = "ttyY";
+	a2232_driver.major = A2232_NORMAL_MAJOR;
+	a2232_driver.num = NUMLINES * nr_a2232;
+	a2232_driver.type = TTY_DRIVER_TYPE_SERIAL;
+	a2232_driver.subtype = A2232_TTY_SUBTYPE_NORMAL;
+	a2232_driver.init_termios = tty_std_termios;
+	a2232_driver.init_termios.c_cflag =
+		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	a2232_driver.flags = TTY_DRIVER_REAL_RAW;
+	a2232_driver.refcount = &a2232_refcount;
+	a2232_driver.table = a2232_table;
+	a2232_driver.termios = a2232_termios;
+	a2232_driver.termios_locked = a2232_termios_locked;
+
+	a2232_driver.open = a2232_open;
+	a2232_driver.close = gs_close;
+	a2232_driver.write = gs_write;
+	a2232_driver.put_char = gs_put_char;
+	a2232_driver.flush_chars = gs_flush_chars;
+	a2232_driver.write_room = gs_write_room;
+	a2232_driver.chars_in_buffer = gs_chars_in_buffer;
+	a2232_driver.flush_buffer = gs_flush_buffer;
+	a2232_driver.ioctl = a2232_ioctl;
+	a2232_driver.throttle = a2232_throttle;
+	a2232_driver.unthrottle = a2232_unthrottle;
+	a2232_driver.set_termios = gs_set_termios;
+	a2232_driver.stop = gs_stop;
+	a2232_driver.start = gs_start;
+	a2232_driver.hangup = gs_hangup;
+
+	a2232_callout_driver = a2232_driver;
+	a2232_callout_driver.name = "cuy";
+	a2232_callout_driver.major = A2232_CALLOUT_MAJOR;
+	a2232_callout_driver.subtype = A2232_TTY_SUBTYPE_CALLOUT;
+
+	if ((error = tty_register_driver(&a2232_driver))) {
+		printk(KERN_ERR "A2232: Couldn't register A2232 driver, error = %d\n",
+		       error);
+		return 1;
+	}
+	if ((error = tty_register_driver(&a2232_callout_driver))) {
+		tty_unregister_driver(&a2232_driver);
+		printk(KERN_ERR "A2232: Couldn't register A2232 callout driver, error = %d\n",
+		       error);
+		return 1;
+	}
+	return 0;
+}
+
+int a2232board_init(void)
+{
+	struct zorro_dev *z;
+
+	unsigned int boardaddr;
+	int bcount;
+	short start;
+	u_char *from;
+	volatile u_char *to;
+	volatile struct a2232memory *mem;
+
+#ifdef __SMP__
+	return -ENODEV;	/* This driver is not SMP aware. Is there an SMP ZorroII-bus-machine? */
+#endif
+
+	if (!MACH_IS_AMIGA){
+		return -ENODEV;
+	}
+
+	printk("Commodore A2232 driver initializing.\n"); /* Say that we're alive. */
+
+	z = NULL;
+	nr_a2232 = 0;
+	while ( (z = zorro_find_device(ZORRO_WILDCARD, z)) ){
+		if (	(z->id != ZORRO_PROD_CBM_A2232_PROTOTYPE) && 
+			(z->id != ZORRO_PROD_CBM_A2232)	){
+			continue;	// The board found was no A2232
+		}
+		if (!zorro_request_device(z,"A2232 driver"))
+			continue;
+
+		printk("Commodore A2232 found (#%d).\n",nr_a2232);
+
+		zd_a2232[nr_a2232] = z;
+
+		boardaddr = ZTWO_VADDR( z->resource.start );
+		printk("Board is located at address 0x%x, size is 0x%x.\n", boardaddr, (unsigned int) ((z->resource.end+1) - (z->resource.start)));
+
+		mem = (volatile struct a2232memory *) boardaddr;
+
+		(void) mem->Enable6502Reset;   /* copy the code across to the board */
+		to = (u_char *)mem;  from = a2232_65EC02code; bcount = sizeof(a2232_65EC02code) - 2;
+		start = *(short *)from;
+		from += sizeof(start);
+		to += start;
+		while(bcount--) *to++ = *from++;
+		printk("65EC02 software uploaded to the A2232 memory.\n");
+  
+		mem->Common.Crystal = A2232_UNKNOWN;  /* use automatic speed check */
+  
+		/* start 6502 running */
+		(void) mem->ResetBoard;
+		printk("A2232's 65EC02 CPU up and running.\n");
+  
+		/* wait until speed detector has finished */
+		for (bcount = 0; bcount < 2000; bcount++) {
+			udelay(1000);
+			if (mem->Common.Crystal)
+				break;
+		}
+		printk((mem->Common.Crystal?"A2232 oscillator crystal detected by 65EC02 software: ":"65EC02 software could not determine A2232 oscillator crystal: "));
+		switch (mem->Common.Crystal){
+		case A2232_UNKNOWN:
+			printk("Unknown crystal.\n");
+			break;
+ 		case A2232_NORMAL:
+			printk ("Normal crystal.\n");
+			break;
+		case A2232_TURBO:
+			printk ("Turbo crystal.\n");
+			break;
+		default:
+			printk ("0x%x. Huh?\n",mem->Common.Crystal);
+		}
+
+		nr_a2232++;
+
+	}	
+
+	printk("Total: %d A2232 boards initialized.\n.", nr_a2232); /* Some status report if no card was found */
+
+	a2232_init_portstructs();
+
+	/*
+		a2232_init_drivers also registers the drivers. Must be here because all boards
+		have to be detected first.
+	*/
+	if (a2232_init_drivers()) return -ENODEV; // maybe we should use a different -Exxx?
+
+	request_irq(IRQ_AMIGA_VERTB, a2232_vbl_inter, 0, "A2232 serial VBL", a2232_driver_ID);
+	return 0;
+}
+
+#ifdef MODULE
+int init_module(void)
+{
+	return a2232board_init();
+}
+
+void cleanup_module(void)
+{
+	int i;
+
+	for (i = 0; i < nr_a2232; i++) {
+		zorro_release_device(zd_a2232[i]);
+	}
+
+	tty_unregister_driver(&a2232_driver);
+	tty_unregister_driver(&a2232_callout_driver);
+	free_irq(IRQ_AMIGA_VERTB, a2232_driver_ID);
+}
+#endif
+/***************************** End of Functions *********************/
diff -urN linux/drivers/char/ser_a2232.h linux-2.4.4-a2232/drivers/char/ser_a2232.h
--- linux/drivers/char/ser_a2232.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.4-a2232/drivers/char/ser_a2232.h	Thu May 10 01:57:04 2001
@@ -0,0 +1,206 @@
+/* drivers/char/ser_a2232.h */
+
+/* $Id: ser_a2232.h,v 0.4 2000/01/25 12:00:00 ehaase Exp $ */
+
+/* Linux serial driver for the Amiga A2232 board */
+
+/* This driver is MAINTAINED. Before applying any changes, please contact
+ * the author.
+ */
+   
+/* Copyright (c) 2000-2001 Enver Haase    <ehaase@inf.fu-berlin.de>
+ *                   alias The A2232 driver project <A2232@gmx.net>
+ * All rights reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *  
+ */
+
+#ifndef _SER_A2232_H_
+#define _SER_A2232_H_
+
+/*
+	How many boards are to be supported at maximum;
+	"up to five A2232 Multiport Serial Cards may be installed in a
+	single Amiga 2000" states the A2232 User's Guide. If you have
+	more slots available, you might want to change the value below.
+*/
+#define MAX_A2232_BOARDS 5
+
+#ifndef A2232_NORMAL_MAJOR
+/* This allows overriding on the compiler commandline, or in a "major.h" 
+   include or something like that */
+#define A2232_NORMAL_MAJOR  224	/* /dev/ttyY* */
+#define A2232_CALLOUT_MAJOR 225	/* /dev/cuy*  */
+#endif
+
+/* Some magic is always good - Who knows :) */
+#define A2232_MAGIC 0x000a2232
+
+/* for the tty_struct subtype field */
+#define A2232_TTY_SUBTYPE_NORMAL	1
+#define A2232_TTY_SUBTYPE_CALLOUT	2
+
+/* A2232 port structure to keep track of the
+   status of every single line used */
+struct a2232_port{
+	struct gs_port gs;
+	unsigned int which_a2232;
+	unsigned int which_port_on_a2232;
+	short disable_rx;
+	short throttle_input;
+	short cd_status;
+};
+
+#define	NUMLINES		7	/* number of lines per board */
+#define	A2232_IOBUFLEN		256	/* number of bytes per buffer */
+#define	A2232_IOBUFLENMASK	0xff	/* mask for maximum number of bytes */
+
+
+#define	A2232_UNKNOWN	0	/* crystal not known */
+#define	A2232_NORMAL	1	/* normal A2232 (1.8432 MHz oscillator) */
+#define	A2232_TURBO	2	/* turbo A2232 (3.6864 MHz oscillator) */
+
+
+struct a2232common {
+	char   Crystal;	/* normal (1) or turbo (2) board? */
+	u_char Pad_a;
+	u_char TimerH;	/* timer value after speed check */
+	u_char TimerL;
+	u_char CDHead;	/* head pointer for CD message queue */
+	u_char CDTail;	/* tail pointer for CD message queue */
+	u_char CDStatus;
+	u_char Pad_b;
+};
+
+struct a2232status {
+	u_char InHead;		/* input queue head */
+	u_char InTail;		/* input queue tail */
+	u_char OutDisable;	/* disables output */
+	u_char OutHead;		/* output queue head */
+	u_char OutTail;		/* output queue tail */
+	u_char OutCtrl;		/* soft flow control character to send */
+	u_char OutFlush;	/* flushes output buffer */
+	u_char Setup;		/* causes reconfiguration */
+	u_char Param;		/* parameter byte - see A2232PARAM */
+	u_char Command;		/* command byte - see A2232CMD */
+	u_char SoftFlow;	/* enables xon/xoff flow control */
+	/* private 65EC02 fields: */
+	u_char XonOff;		/* stores XON/XOFF enable/disable */
+};
+
+#define	A2232_MEMPAD1	\
+	(0x0200 - NUMLINES * sizeof(struct a2232status)	-	\
+	sizeof(struct a2232common))
+#define	A2232_MEMPAD2	(0x2000 - NUMLINES * A2232_IOBUFLEN - A2232_IOBUFLEN)
+
+struct a2232memory {
+	struct a2232status Status[NUMLINES];	/* 0x0000-0x006f status areas */
+	struct a2232common Common;		/* 0x0070-0x0077 common flags */
+	u_char Dummy1[A2232_MEMPAD1];		/* 0x00XX-0x01ff */
+	u_char OutBuf[NUMLINES][A2232_IOBUFLEN];/* 0x0200-0x08ff output bufs */
+	u_char InBuf[NUMLINES][A2232_IOBUFLEN];	/* 0x0900-0x0fff input bufs */
+	u_char InCtl[NUMLINES][A2232_IOBUFLEN];	/* 0x1000-0x16ff control data */
+	u_char CDBuf[A2232_IOBUFLEN];		/* 0x1700-0x17ff CD event buffer */
+	u_char Dummy2[A2232_MEMPAD2];		/* 0x1800-0x2fff */
+	u_char Code[0x1000];			/* 0x3000-0x3fff code area */
+	u_short InterruptAck;			/* 0x4000        intr ack */
+	u_char Dummy3[0x3ffe];			/* 0x4002-0x7fff */
+	u_short Enable6502Reset;		/* 0x8000 Stop board, */
+						/*  6502 RESET line held low */
+	u_char Dummy4[0x3ffe];			/* 0x8002-0xbfff */
+	u_short ResetBoard;			/* 0xc000 reset board & run, */
+						/*  6502 RESET line held high */
+};
+
+#undef A2232_MEMPAD1
+#undef A2232_MEMPAD2
+
+#define	A2232INCTL_CHAR		0	/* corresponding byte in InBuf is a character */
+#define	A2232INCTL_EVENT	1	/* corresponding byte in InBuf is an event */
+
+#define	A2232EVENT_Break	1	/* break set */
+#define	A2232EVENT_CarrierOn	2	/* carrier raised */
+#define	A2232EVENT_CarrierOff	3	/* carrier dropped */
+#define A2232EVENT_Sync		4	/* don't know, defined in 2232.ax */
+
+#define	A2232CMD_Enable		0x1	/* enable/DTR bit */
+#define	A2232CMD_Close		0x2	/* close the device */
+#define	A2232CMD_Open		0xb	/* open the device */
+#define	A2232CMD_CMask		0xf	/* command mask */
+#define	A2232CMD_RTSOff		0x0  	/* turn off RTS */
+#define	A2232CMD_RTSOn		0x8	/* turn on RTS */
+#define	A2232CMD_Break		0xd	/* transmit a break */
+#define	A2232CMD_RTSMask	0xc	/* mask for RTS stuff */
+#define	A2232CMD_NoParity	0x00	/* don't use parity */
+#define	A2232CMD_OddParity	0x20	/* odd parity */
+#define	A2232CMD_EvenParity	0x60	/* even parity */
+#define	A2232CMD_ParityMask	0xe0	/* parity mask */
+
+#define	A2232PARAM_B115200	0x0	/* baud rates */
+#define	A2232PARAM_B50		0x1
+#define	A2232PARAM_B75		0x2
+#define	A2232PARAM_B110		0x3
+#define	A2232PARAM_B134		0x4
+#define	A2232PARAM_B150		0x5
+#define	A2232PARAM_B300		0x6
+#define	A2232PARAM_B600		0x7
+#define	A2232PARAM_B1200	0x8
+#define	A2232PARAM_B1800	0x9
+#define	A2232PARAM_B2400	0xa
+#define	A2232PARAM_B3600	0xb
+#define	A2232PARAM_B4800	0xc
+#define	A2232PARAM_B7200	0xd
+#define	A2232PARAM_B9600	0xe
+#define	A2232PARAM_B19200	0xf
+#define	A2232PARAM_BaudMask	0xf	/* baud rate mask */
+#define	A2232PARAM_RcvBaud	0x10	/* enable receive baud rate */
+#define	A2232PARAM_8Bit		0x00	/* numbers of bits */
+#define	A2232PARAM_7Bit		0x20
+#define	A2232PARAM_6Bit		0x40
+#define	A2232PARAM_5Bit		0x60
+#define	A2232PARAM_BitMask	0x60	/* numbers of bits mask */
+
+
+/* Standard speeds tables, -1 means unavailable, -2 means 0 baud: switch off line */
+#define A2232_BAUD_TABLE_NOAVAIL -1
+#define A2232_BAUD_TABLE_NUM_RATES (18)
+static int a2232_baud_table[A2232_BAUD_TABLE_NUM_RATES*3] = {
+		//Baud		//Normal			//Turbo
+		50,		A2232PARAM_B50,			A2232_BAUD_TABLE_NOAVAIL,
+		75,		A2232PARAM_B75,			A2232_BAUD_TABLE_NOAVAIL,
+		110,		A2232PARAM_B110,		A2232_BAUD_TABLE_NOAVAIL,
+		134,		A2232PARAM_B134,		A2232_BAUD_TABLE_NOAVAIL,
+		150,		A2232PARAM_B150,		A2232PARAM_B75,
+		200,		A2232_BAUD_TABLE_NOAVAIL,	A2232_BAUD_TABLE_NOAVAIL,
+		300,		A2232PARAM_B300,		A2232PARAM_B150,
+		600,		A2232PARAM_B600,		A2232PARAM_B300,
+		1200,		A2232PARAM_B1200,		A2232PARAM_B600,
+		1800,		A2232PARAM_B1800,		A2232_BAUD_TABLE_NOAVAIL,
+		2400,		A2232PARAM_B2400,		A2232PARAM_B1200,
+		4800,		A2232PARAM_B4800,		A2232PARAM_B2400,
+		9600,		A2232PARAM_B9600,		A2232PARAM_B4800,
+		19200,		A2232PARAM_B19200,		A2232PARAM_B9600,
+		38400,		A2232_BAUD_TABLE_NOAVAIL,	A2232PARAM_B19200,
+		57600,		A2232_BAUD_TABLE_NOAVAIL,	A2232_BAUD_TABLE_NOAVAIL,
+#ifdef A2232_SPEEDHACK
+		115200,		A2232PARAM_B115200,		A2232_BAUD_TABLE_NOAVAIL,
+		230400,		A2232_BAUD_TABLE_NOAVAIL,	A2232PARAM_B115200
+#else
+		115200,		A2232_BAUD_TABLE_NOAVAIL,	A2232_BAUD_TABLE_NOAVAIL,
+		230400,		A2232_BAUD_TABLE_NOAVAIL,	A2232_BAUD_TABLE_NOAVAIL
+#endif
+};
+#endif
diff -urN linux/drivers/char/ser_a2232fw.h linux-2.4.4-a2232/drivers/char/ser_a2232fw.h
--- linux/drivers/char/ser_a2232fw.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.4-a2232/drivers/char/ser_a2232fw.h	Thu May 10 01:24:53 2001
@@ -0,0 +1,306 @@
+/* drivers/char/ser_a2232fw.h */
+
+/* $Id: ser_a2232fw.h,v 0.4 2000/01/25 12:00:00 ehaase Exp $ */
+
+/*
+ * Copyright (c) 1995 Jukka Marin <jmarin@jmp.fi>.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, and the entire permission notice in its entirety,
+ *    including the disclaimer of warranties.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. The name of the author may not be used to endorse or promote
+ *    products derived from this software without specific prior
+ *    written permission.
+ *
+ * ALTERNATIVELY, this product may be distributed under the terms of
+ * the GNU Public License, in which case the provisions of the GPL are
+ * required INSTEAD OF the above restrictions.  (This clause is
+ * necessary due to a potential bad interaction between the GPL and
+ * the restrictions contained in a BSD-style copyright.)
+ *
+ * THIS SOFTWARE IS PROVIDED `AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+                                      
+/* This is the 65EC02 code by Jukka Marin that is executed by
+   the A2232's 65EC02 processor (base address: 0x3800)
+   Source file:	2232.ax (ask Jukka Marin <jmarin@jmp.fi> if you want it!)
+   Version:			1.3 (951029)
+   Known Bugs:	Cannot send a break yet
+*/
+static unsigned char a2232_65EC02code[] = {
+	0x38, 0x00, 0xA2, 0xFF, 0x9A, 0xD8, 0xA2, 0x00, 
+	0xA9, 0x00, 0xA0, 0x54, 0x95, 0x00, 0xE8, 0x88, 
+	0xD0, 0xFA, 0x64, 0x5C, 0x64, 0x5E, 0x64, 0x58, 
+	0x64, 0x59, 0xA9, 0x00, 0x85, 0x55, 0xA9, 0xAA, 
+	0xC9, 0x64, 0x90, 0x02, 0xE6, 0x55, 0xA5, 0x54, 
+	0xF0, 0x03, 0x4C, 0x92, 0x38, 0xA9, 0x98, 0x8D, 
+	0x06, 0x44, 0xA9, 0x0B, 0x8D, 0x04, 0x44, 0xAD, 
+	0x02, 0x44, 0xA9, 0x80, 0x8D, 0x1A, 0x7C, 0xA9, 
+	0xFF, 0x8D, 0x08, 0x7C, 0x8D, 0x0A, 0x7C, 0xA2, 
+	0x00, 0x8E, 0x00, 0x44, 0xEA, 0xEA, 0xAD, 0x02, 
+	0x44, 0xEA, 0xEA, 0x8E, 0x00, 0x44, 0xAD, 0x02, 
+	0x44, 0x29, 0x10, 0xF0, 0xF9, 0xA9, 0x11, 0x8E, 
+	0x00, 0x44, 0x8D, 0x1C, 0x7C, 0xAD, 0x02, 0x44, 
+	0x29, 0x10, 0xF0, 0xF9, 0x8E, 0x1C, 0x7C, 0xAD, 
+	0x08, 0x7C, 0x85, 0x57, 0xAD, 0x0A, 0x7C, 0x85, 
+	0x56, 0xC9, 0xD0, 0x90, 0x05, 0xA9, 0x02, 0x4C, 
+	0x82, 0x38, 0xA9, 0x01, 0x85, 0x54, 0xA9, 0x00, 
+	0x8D, 0x02, 0x44, 0x8D, 0x06, 0x44, 0x8D, 0x04, 
+	0x44, 0x4C, 0x92, 0x38, 0xAD, 0x00, 0x7C, 0xC5, 
+	0x5C, 0xF0, 0x1F, 0xC5, 0x5E, 0xF0, 0x09, 0x85, 
+	0x5E, 0xA9, 0x40, 0x85, 0x5D, 0x4C, 0xB8, 0x38, 
+	0xC6, 0x5D, 0x10, 0x0E, 0xA6, 0x58, 0x9D, 0x00, 
+	0x17, 0xE8, 0xE4, 0x59, 0xF0, 0x04, 0x86, 0x58, 
+	0x85, 0x5C, 0x20, 0x23, 0x3A, 0xA5, 0x07, 0xF0, 
+	0x0F, 0xA5, 0x0A, 0x85, 0x0B, 0xA5, 0x08, 0x09, 
+	0x10, 0x8D, 0x06, 0x44, 0x64, 0x02, 0x64, 0x07, 
+	0xA5, 0x00, 0xE5, 0x01, 0xC9, 0xC8, 0xA5, 0x09, 
+	0x29, 0xF3, 0xB0, 0x02, 0x09, 0x08, 0x8D, 0x04, 
+	0x44, 0xA5, 0x06, 0xF0, 0x08, 0xA5, 0x03, 0x85, 
+	0x04, 0x64, 0x02, 0x64, 0x06, 0x20, 0x23, 0x3A, 
+	0xA5, 0x13, 0xF0, 0x0F, 0xA5, 0x16, 0x85, 0x17, 
+	0xA5, 0x14, 0x09, 0x10, 0x8D, 0x06, 0x4C, 0x64, 
+	0x0E, 0x64, 0x13, 0xA5, 0x0C, 0xE5, 0x0D, 0xC9, 
+	0xC8, 0xA5, 0x15, 0x29, 0xF3, 0xB0, 0x02, 0x09, 
+	0x08, 0x8D, 0x04, 0x4C, 0xA5, 0x12, 0xF0, 0x08, 
+	0xA5, 0x0F, 0x85, 0x10, 0x64, 0x0E, 0x64, 0x12, 
+	0x20, 0x23, 0x3A, 0xA5, 0x1F, 0xF0, 0x0F, 0xA5, 
+	0x22, 0x85, 0x23, 0xA5, 0x20, 0x09, 0x10, 0x8D, 
+	0x06, 0x54, 0x64, 0x1A, 0x64, 0x1F, 0xA5, 0x18, 
+	0xE5, 0x19, 0xC9, 0xC8, 0xA5, 0x21, 0x29, 0xF3, 
+	0xB0, 0x02, 0x09, 0x08, 0x8D, 0x04, 0x54, 0xA5, 
+	0x1E, 0xF0, 0x08, 0xA5, 0x1B, 0x85, 0x1C, 0x64, 
+	0x1A, 0x64, 0x1E, 0x20, 0x23, 0x3A, 0xA5, 0x2B, 
+	0xF0, 0x0F, 0xA5, 0x2E, 0x85, 0x2F, 0xA5, 0x2C, 
+	0x09, 0x10, 0x8D, 0x06, 0x5C, 0x64, 0x26, 0x64, 
+	0x2B, 0xA5, 0x24, 0xE5, 0x25, 0xC9, 0xC8, 0xA5, 
+	0x2D, 0x29, 0xF3, 0xB0, 0x02, 0x09, 0x08, 0x8D, 
+	0x04, 0x5C, 0xA5, 0x2A, 0xF0, 0x08, 0xA5, 0x27, 
+	0x85, 0x28, 0x64, 0x26, 0x64, 0x2A, 0x20, 0x23, 
+	0x3A, 0xA5, 0x37, 0xF0, 0x0F, 0xA5, 0x3A, 0x85, 
+	0x3B, 0xA5, 0x38, 0x09, 0x10, 0x8D, 0x06, 0x64, 
+	0x64, 0x32, 0x64, 0x37, 0xA5, 0x30, 0xE5, 0x31, 
+	0xC9, 0xC8, 0xA5, 0x39, 0x29, 0xF3, 0xB0, 0x02, 
+	0x09, 0x08, 0x8D, 0x04, 0x64, 0xA5, 0x36, 0xF0, 
+	0x08, 0xA5, 0x33, 0x85, 0x34, 0x64, 0x32, 0x64, 
+	0x36, 0x20, 0x23, 0x3A, 0xA5, 0x43, 0xF0, 0x0F, 
+	0xA5, 0x46, 0x85, 0x47, 0xA5, 0x44, 0x09, 0x10, 
+	0x8D, 0x06, 0x6C, 0x64, 0x3E, 0x64, 0x43, 0xA5, 
+	0x3C, 0xE5, 0x3D, 0xC9, 0xC8, 0xA5, 0x45, 0x29, 
+	0xF3, 0xB0, 0x02, 0x09, 0x08, 0x8D, 0x04, 0x6C, 
+	0xA5, 0x42, 0xF0, 0x08, 0xA5, 0x3F, 0x85, 0x40, 
+	0x64, 0x3E, 0x64, 0x42, 0x20, 0x23, 0x3A, 0xA5, 
+	0x4F, 0xF0, 0x0F, 0xA5, 0x52, 0x85, 0x53, 0xA5, 
+	0x50, 0x09, 0x10, 0x8D, 0x06, 0x74, 0x64, 0x4A, 
+	0x64, 0x4F, 0xA5, 0x48, 0xE5, 0x49, 0xC9, 0xC8, 
+	0xA5, 0x51, 0x29, 0xF3, 0xB0, 0x02, 0x09, 0x08, 
+	0x8D, 0x04, 0x74, 0xA5, 0x4E, 0xF0, 0x08, 0xA5, 
+	0x4B, 0x85, 0x4C, 0x64, 0x4A, 0x64, 0x4E, 0x20, 
+	0x23, 0x3A, 0x4C, 0x92, 0x38, 0xAD, 0x02, 0x44, 
+	0x89, 0x08, 0xF0, 0x3B, 0x89, 0x02, 0xF0, 0x1B, 
+	0xAD, 0x00, 0x44, 0xD0, 0x32, 0xA6, 0x00, 0xA9, 
+	0x01, 0x9D, 0x00, 0x10, 0xA9, 0x01, 0x9D, 0x00, 
+	0x09, 0xE8, 0xE4, 0x01, 0xF0, 0x02, 0x86, 0x00, 
+	0x4C, 0x65, 0x3A, 0xA6, 0x00, 0xAD, 0x00, 0x44, 
+	0x9D, 0x00, 0x09, 0x9E, 0x00, 0x10, 0xE8, 0xE4, 
+	0x01, 0xF0, 0x02, 0x86, 0x00, 0x29, 0x7F, 0xC9, 
+	0x13, 0xD0, 0x04, 0xA5, 0x0B, 0x85, 0x02, 0xAD, 
+	0x02, 0x44, 0x29, 0x10, 0xF0, 0x2C, 0xA6, 0x05, 
+	0xF0, 0x0F, 0xAD, 0x02, 0x7C, 0x29, 0x01, 0xD0, 
+	0x21, 0x8E, 0x00, 0x44, 0x64, 0x05, 0x4C, 0x98, 
+	0x3A, 0xA6, 0x04, 0xE4, 0x03, 0xF0, 0x13, 0xA5, 
+	0x02, 0xD0, 0x0F, 0xAD, 0x02, 0x7C, 0x29, 0x01, 
+	0xD0, 0x08, 0xBD, 0x00, 0x02, 0x8D, 0x00, 0x44, 
+	0xE6, 0x04, 0xAD, 0x02, 0x4C, 0x89, 0x08, 0xF0, 
+	0x3B, 0x89, 0x02, 0xF0, 0x1B, 0xAD, 0x00, 0x4C, 
+	0xD0, 0x32, 0xA6, 0x0C, 0xA9, 0x01, 0x9D, 0x00, 
+	0x11, 0xA9, 0x01, 0x9D, 0x00, 0x0A, 0xE8, 0xE4, 
+	0x0D, 0xF0, 0x02, 0x86, 0x0C, 0x4C, 0xDA, 0x3A, 
+	0xA6, 0x0C, 0xAD, 0x00, 0x4C, 0x9D, 0x00, 0x0A, 
+	0x9E, 0x00, 0x11, 0xE8, 0xE4, 0x0D, 0xF0, 0x02, 
+	0x86, 0x0C, 0x29, 0x7F, 0xC9, 0x13, 0xD0, 0x04, 
+	0xA5, 0x17, 0x85, 0x0E, 0xAD, 0x02, 0x4C, 0x29, 
+	0x10, 0xF0, 0x2C, 0xA6, 0x11, 0xF0, 0x0F, 0xAD, 
+	0x02, 0x7C, 0x29, 0x02, 0xD0, 0x21, 0x8E, 0x00, 
+	0x4C, 0x64, 0x11, 0x4C, 0x0D, 0x3B, 0xA6, 0x10, 
+	0xE4, 0x0F, 0xF0, 0x13, 0xA5, 0x0E, 0xD0, 0x0F, 
+	0xAD, 0x02, 0x7C, 0x29, 0x02, 0xD0, 0x08, 0xBD, 
+	0x00, 0x03, 0x8D, 0x00, 0x4C, 0xE6, 0x10, 0xAD, 
+	0x02, 0x54, 0x89, 0x08, 0xF0, 0x3B, 0x89, 0x02, 
+	0xF0, 0x1B, 0xAD, 0x00, 0x54, 0xD0, 0x32, 0xA6, 
+	0x18, 0xA9, 0x01, 0x9D, 0x00, 0x12, 0xA9, 0x01, 
+	0x9D, 0x00, 0x0B, 0xE8, 0xE4, 0x19, 0xF0, 0x02, 
+	0x86, 0x18, 0x4C, 0x4F, 0x3B, 0xA6, 0x18, 0xAD, 
+	0x00, 0x54, 0x9D, 0x00, 0x0B, 0x9E, 0x00, 0x12, 
+	0xE8, 0xE4, 0x19, 0xF0, 0x02, 0x86, 0x18, 0x29, 
+	0x7F, 0xC9, 0x13, 0xD0, 0x04, 0xA5, 0x23, 0x85, 
+	0x1A, 0xAD, 0x02, 0x54, 0x29, 0x10, 0xF0, 0x2C, 
+	0xA6, 0x1D, 0xF0, 0x0F, 0xAD, 0x02, 0x7C, 0x29, 
+	0x04, 0xD0, 0x21, 0x8E, 0x00, 0x54, 0x64, 0x1D, 
+	0x4C, 0x82, 0x3B, 0xA6, 0x1C, 0xE4, 0x1B, 0xF0, 
+	0x13, 0xA5, 0x1A, 0xD0, 0x0F, 0xAD, 0x02, 0x7C, 
+	0x29, 0x04, 0xD0, 0x08, 0xBD, 0x00, 0x04, 0x8D, 
+	0x00, 0x54, 0xE6, 0x1C, 0xAD, 0x02, 0x5C, 0x89, 
+	0x08, 0xF0, 0x3B, 0x89, 0x02, 0xF0, 0x1B, 0xAD, 
+	0x00, 0x5C, 0xD0, 0x32, 0xA6, 0x24, 0xA9, 0x01, 
+	0x9D, 0x00, 0x13, 0xA9, 0x01, 0x9D, 0x00, 0x0C, 
+	0xE8, 0xE4, 0x25, 0xF0, 0x02, 0x86, 0x24, 0x4C, 
+	0xC4, 0x3B, 0xA6, 0x24, 0xAD, 0x00, 0x5C, 0x9D, 
+	0x00, 0x0C, 0x9E, 0x00, 0x13, 0xE8, 0xE4, 0x25, 
+	0xF0, 0x02, 0x86, 0x24, 0x29, 0x7F, 0xC9, 0x13, 
+	0xD0, 0x04, 0xA5, 0x2F, 0x85, 0x26, 0xAD, 0x02, 
+	0x5C, 0x29, 0x10, 0xF0, 0x2C, 0xA6, 0x29, 0xF0, 
+	0x0F, 0xAD, 0x02, 0x7C, 0x29, 0x08, 0xD0, 0x21, 
+	0x8E, 0x00, 0x5C, 0x64, 0x29, 0x4C, 0xF7, 0x3B, 
+	0xA6, 0x28, 0xE4, 0x27, 0xF0, 0x13, 0xA5, 0x26, 
+	0xD0, 0x0F, 0xAD, 0x02, 0x7C, 0x29, 0x08, 0xD0, 
+	0x08, 0xBD, 0x00, 0x05, 0x8D, 0x00, 0x5C, 0xE6, 
+	0x28, 0xAD, 0x02, 0x64, 0x89, 0x08, 0xF0, 0x3B, 
+	0x89, 0x02, 0xF0, 0x1B, 0xAD, 0x00, 0x64, 0xD0, 
+	0x32, 0xA6, 0x30, 0xA9, 0x01, 0x9D, 0x00, 0x14, 
+	0xA9, 0x01, 0x9D, 0x00, 0x0D, 0xE8, 0xE4, 0x31, 
+	0xF0, 0x02, 0x86, 0x30, 0x4C, 0x39, 0x3C, 0xA6, 
+	0x30, 0xAD, 0x00, 0x64, 0x9D, 0x00, 0x0D, 0x9E, 
+	0x00, 0x14, 0xE8, 0xE4, 0x31, 0xF0, 0x02, 0x86, 
+	0x30, 0x29, 0x7F, 0xC9, 0x13, 0xD0, 0x04, 0xA5, 
+	0x3B, 0x85, 0x32, 0xAD, 0x02, 0x64, 0x29, 0x10, 
+	0xF0, 0x2C, 0xA6, 0x35, 0xF0, 0x0F, 0xAD, 0x02, 
+	0x7C, 0x29, 0x10, 0xD0, 0x21, 0x8E, 0x00, 0x64, 
+	0x64, 0x35, 0x4C, 0x6C, 0x3C, 0xA6, 0x34, 0xE4, 
+	0x33, 0xF0, 0x13, 0xA5, 0x32, 0xD0, 0x0F, 0xAD, 
+	0x02, 0x7C, 0x29, 0x10, 0xD0, 0x08, 0xBD, 0x00, 
+	0x06, 0x8D, 0x00, 0x64, 0xE6, 0x34, 0xAD, 0x02, 
+	0x6C, 0x89, 0x08, 0xF0, 0x3B, 0x89, 0x02, 0xF0, 
+	0x1B, 0xAD, 0x00, 0x6C, 0xD0, 0x32, 0xA6, 0x3C, 
+	0xA9, 0x01, 0x9D, 0x00, 0x15, 0xA9, 0x01, 0x9D, 
+	0x00, 0x0E, 0xE8, 0xE4, 0x3D, 0xF0, 0x02, 0x86, 
+	0x3C, 0x4C, 0xAE, 0x3C, 0xA6, 0x3C, 0xAD, 0x00, 
+	0x6C, 0x9D, 0x00, 0x0E, 0x9E, 0x00, 0x15, 0xE8, 
+	0xE4, 0x3D, 0xF0, 0x02, 0x86, 0x3C, 0x29, 0x7F, 
+	0xC9, 0x13, 0xD0, 0x04, 0xA5, 0x47, 0x85, 0x3E, 
+	0xAD, 0x02, 0x6C, 0x29, 0x10, 0xF0, 0x2C, 0xA6, 
+	0x41, 0xF0, 0x0F, 0xAD, 0x02, 0x7C, 0x29, 0x20, 
+	0xD0, 0x21, 0x8E, 0x00, 0x6C, 0x64, 0x41, 0x4C, 
+	0xE1, 0x3C, 0xA6, 0x40, 0xE4, 0x3F, 0xF0, 0x13, 
+	0xA5, 0x3E, 0xD0, 0x0F, 0xAD, 0x02, 0x7C, 0x29, 
+	0x20, 0xD0, 0x08, 0xBD, 0x00, 0x07, 0x8D, 0x00, 
+	0x6C, 0xE6, 0x40, 0xAD, 0x02, 0x74, 0x89, 0x08, 
+	0xF0, 0x3B, 0x89, 0x02, 0xF0, 0x1B, 0xAD, 0x00, 
+	0x74, 0xD0, 0x32, 0xA6, 0x48, 0xA9, 0x01, 0x9D, 
+	0x00, 0x16, 0xA9, 0x01, 0x9D, 0x00, 0x0F, 0xE8, 
+	0xE4, 0x49, 0xF0, 0x02, 0x86, 0x48, 0x4C, 0x23, 
+	0x3D, 0xA6, 0x48, 0xAD, 0x00, 0x74, 0x9D, 0x00, 
+	0x0F, 0x9E, 0x00, 0x16, 0xE8, 0xE4, 0x49, 0xF0, 
+	0x02, 0x86, 0x48, 0x29, 0x7F, 0xC9, 0x13, 0xD0, 
+	0x04, 0xA5, 0x53, 0x85, 0x4A, 0xAD, 0x02, 0x74, 
+	0x29, 0x10, 0xF0, 0x2C, 0xA6, 0x4D, 0xF0, 0x0F, 
+	0xAD, 0x02, 0x7C, 0x29, 0x40, 0xD0, 0x21, 0x8E, 
+	0x00, 0x74, 0x64, 0x4D, 0x4C, 0x56, 0x3D, 0xA6, 
+	0x4C, 0xE4, 0x4B, 0xF0, 0x13, 0xA5, 0x4A, 0xD0, 
+	0x0F, 0xAD, 0x02, 0x7C, 0x29, 0x40, 0xD0, 0x08, 
+	0xBD, 0x00, 0x08, 0x8D, 0x00, 0x74, 0xE6, 0x4C, 
+	0x60, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
+	0xFF, 0xFF, 0xFF, 0xFF, 0xD0, 0xD0, 0x00, 0x38, 
+	0xCE, 0xC0, 
+};
diff -urN linux/drivers/char/tty_io.c linux-2.4.4-a2232/drivers/char/tty_io.c
--- linux/drivers/char/tty_io.c	Fri Apr 27 02:35:49 2001
+++ linux-2.4.4-a2232/drivers/char/tty_io.c	Thu May 10 01:21:22 2001
@@ -2359,4 +2359,7 @@
 #ifdef CONFIG_HWC
 	hwc_tty_init();
 #endif
+#ifdef CONFIG_A2232
+	a2232board_init();
+#endif
 }
diff -urN linux/include/linux/tty.h linux-2.4.4-a2232/include/linux/tty.h
--- linux/include/linux/tty.h	Sat Apr 28 00:48:32 2001
+++ linux-2.4.4-a2232/include/linux/tty.h	Thu May 10 01:26:06 2001
@@ -366,6 +366,7 @@
 extern int specialix_init(void);
 extern int espserial_init(void);
 extern int macserial_init(void);
+extern int a2232board_init(void);
 
 extern int tty_paranoia_check(struct tty_struct *tty, kdev_t device,
 			      const char *routine);
