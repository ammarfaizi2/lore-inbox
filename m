Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273345AbTHPPYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273906AbTHPPYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:24:12 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:6893 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S273345AbTHPPYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:24:06 -0400
Date: Sat, 16 Aug 2003 17:23:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus serial port ttyS02
In-Reply-To: <Pine.GSO.4.21.0308132305210.11378-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.4.21.0308161722030.12665-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Geert Uytterhoeven wrote:
> On Wed, 13 Aug 2003, Russell King wrote:
> > You could enable DEBUG_AUTOCONF in 8250.c in 2.6.0-test3 and give
> > further probing information. 8)

This patch kills a warning if DEBUG_AUTOCONF is enabled:

--- linux-ppc-2.6.0-test3/drivers/serial/8250.c	Mon Aug 11 02:20:41 2003
+++ linux-longtrail-2.6.0-test3/drivers/serial/8250.c	Wed Aug 13 22:31:07 2003
@@ -557,7 +557,7 @@
 	if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
 		return;
 
-	DEBUG_AUTOCONF("ttyS%d: autoconf (0x%04x, 0x%08lx): ",
+	DEBUG_AUTOCONF("ttyS%d: autoconf (0x%04x, %p): ",
 			up->port.line, up->port.iobase, up->port.membase);
 
 	/*
> > Looking at PPC's pc_serial.h, it seems that you've told it to probe
> > there using ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ.
> > 
> > ASYNC_SKIP_TEST means that we use a reduced test to probe for a port -
> > we just check that we can read back a value written to 0x3e9.  If this
> > suceeds, we decide that there is a port present, and go on to try and
> > derive its type.
> > 
> > If you want to enable the more rigorous tests, remove ASYNC_SKIP_TEST
> > from the port flags.  This will make us check that the device behaves
> > like a UART before deciding that it is one.
> 
> If I remove the ASYNC_SKIP_TEST flag, I get
> 
> ttyS2: autoconf (0x03e8, 00000000): LOOP test failed (10) type=unknown
> 
> and only the 2 existing ports are detected! Thanks!
> 
> Why is the ASYNC_SKIP_TEST flag needed? Would it be safe to remove it for PPC,
> or are there possible side effects?

This patch removes the ASYNC_SKIP_TEST flag on PPC:

--- linux-ppc-2.6.0-test3/include/asm-ppc/pc_serial.h	Mon Aug 11 02:21:00 2003
+++ linux-longtrail-2.6.0-test3/include/asm-ppc/pc_serial.h	Wed Aug 13 23:01:50 2003
@@ -28,10 +28,10 @@
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
 #define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
 #else
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF)
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
OK to apply?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

