Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318188AbSHNJIJ>; Wed, 14 Aug 2002 05:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318974AbSHNJIJ>; Wed, 14 Aug 2002 05:08:09 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:7693 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S318188AbSHNJII>; Wed, 14 Aug 2002 05:08:08 -0400
Subject: Re: parport_serial / serial init order wrong?
In-Reply-To: <20020805225805.C16793@flint.arm.linux.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Date: Wed, 14 Aug 2002 11:11:52 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, twaugh@redhat.com,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17euC0-0000Bs-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately its all controlled by the link ordering, and serial is
> buried in within drivers/char.  Moving it before parport needs some
> careful analysis and may very well end up breaking other stuff.
> 
> The simple answer for 2.4 may well be to move serial.c into
> drivers/serial so it can be ordered into the right place on its own.

How about making register_serial() initialize the serial driver by
calling rs_init(), if it was not initialized yet?  Works for me -
see below.  Do you see any problems with this?

Marek

parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport_pc: Via 686A parallel port: io=0x378
PCI parallel port detected: 9710:9835, I/O at 0xb400(0x0)
parport1: PC-style at 0xb400 [PCSPP,TRISTATE,EPP]
register_serial(): calling rs_init()
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS04 at port 0xac00 (irq = 5) is a 16550A
ttyS05 at port 0xb000 (irq = 5) is a 16550A

--- drivers/char/serial.c.orig	2002-08-03 02:39:43.000000000 +0200
+++ drivers/char/serial.c	2002-08-14 00:16:00.000000000 +0200
@@ -254,6 +254,7 @@
 
 static struct tty_driver serial_driver, callout_driver;
 static int serial_refcount;
+static int serial_initialized;
 
 static struct timer_list serial_timer;
 
@@ -5385,6 +5386,10 @@
 	int i;
 	struct serial_state * state;
 
+	if (serial_initialized)
+		return;
+	serial_initialized++;
+
 	init_bh(SERIAL_BH, do_serial_bh);
 	init_timer(&serial_timer);
 	serial_timer.function = rs_timer;
@@ -5603,6 +5608,11 @@
 	struct async_struct *info;
 	unsigned long port;
 
+	if (!serial_initialized) {
+		printk("register_serial(): calling rs_init()\n");
+		rs_init();
+	}
+
 	port = req->port;
 	if (HIGH_BITS_OFFSET)
 		port += (unsigned long) req->port_high << HIGH_BITS_OFFSET;

