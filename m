Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUIKRPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUIKRPW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268224AbUIKRPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:15:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:9167 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S268218AbUIKRNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:13:47 -0400
Date: Sat, 11 Sep 2004 10:13:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.9-rc1-bk8] ppc32: Fix arch/ppc/boot/common/ns16550.c
Message-ID: <20040911171339.GA16753@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  When <linux/timex.h> started including <asm/io.h> this exposed
one of the fragilities of the code in arch/ppc/boot/, namely that it is
tied to the kernel headers for some information, yet not really the
kernel.  The following starts us in the direction of being less tied to
the kernel by providing our own serial_state definition (all we care
about is the ability to grab information from SERIAL_PORT_DFNS).

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.7/arch/ppc/boot/common/ns16550.c	2003-10-08 14:29:22 -07:00
+++ edited/arch/ppc/boot/common/ns16550.c	2004-09-11 10:05:47 -07:00
@@ -5,14 +5,14 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/serial.h>
-#include <linux/serialP.h>
 #include <linux/serial_reg.h>
 #include <asm/serial.h>
 
+#include "nonstdio.h"
+#include "serial.h"
+
 #define SERIAL_BAUD	9600
 
-extern void outb(int port, unsigned char val);
-extern unsigned char inb(int port);
 extern unsigned long ISA_io;
 
 static struct serial_state rs_table[RS_TABLE_SIZE] = {
--- /dev/null	2004-09-11 02:23:35.739868360 -0700
+++ b/arch/ppc/boot/include/serial.h	2004-09-11 10:08:24.591280340 -0700
@@ -0,0 +1,46 @@
+/*
+ * A really private header file for the (dumb) serial driver in arch/ppc/boot
+ *
+ * Shamelessly taken from include/linux/serialP.h:
+ *
+ * Copyright (C) 1997 by Theodore Ts'o.
+ * 
+ * Redistribution of this file is permitted under the terms of the GNU 
+ * Public License (GPL)
+ */
+
+#ifndef _PPC_BOOT_SERIALP_H
+#define _PPC_BOOT_SERIALP_H
+
+/*
+ * This is our internal structure for each serial port's state.
+ * 
+ * Many fields are paralleled by the structure used by the serial_struct
+ * structure.
+ *
+ * Given that this is how SERIAL_PORT_DFNS are done, and that we need
+ * to use a few of their fields, we need to have our own copy of it.
+ */
+struct serial_state {
+	int	magic;
+	int	baud_base;
+	unsigned long	port;
+	int	irq;
+	int	flags;
+	int	hub6;
+	int	type;
+	int	line;
+	int	revision;	/* Chip revision (950) */
+	int	xmit_fifo_size;
+	int	custom_divisor;
+	int	count;
+	u8	*iomem_base;
+	u16	iomem_reg_shift;
+	unsigned short	close_delay;
+	unsigned short	closing_wait; /* time to wait before closing */
+	unsigned long	icount;	
+	int	io_type;
+	void    *info;
+	void    *dev;
+};
+#endif /* _PPC_BOOT_SERIAL_H */

-- 
Tom Rini
http://gate.crashing.org/~trini/
