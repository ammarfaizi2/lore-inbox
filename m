Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSCOUOV>; Fri, 15 Mar 2002 15:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293219AbSCOUON>; Fri, 15 Mar 2002 15:14:13 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:15844 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S293187AbSCOUN5>;
	Fri, 15 Mar 2002 15:13:57 -0500
Date: Fri, 15 Mar 2002 21:17:12 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
In-Reply-To: <20020315185722.GA920@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0203152102430.9609-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002, Andreas Dilger wrote:

> > +#define __SLOW_DOWN_IO_PORT 0x80
> > +#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
>
> You may want to change the above to:
> #define __SLOW_DOWN_IO_ASM	"\noutb %%al,$__SLOW_DOWN_IO_PORT"

Won't work, cpp doesn't substitute between double quotes.
(at least the one I'm using). Or am I gettimng something wrong here??

> You may also want to replace the above entirely with a macro, like:
> #define __SLOW_DOWN_IO		outb(3, __SLOW_DOWN_IO_PORT)
>
> so that on architectures that don't need/have this ISA nonsense can
> just replace __SLOW_DOWN_IO with something else like udelay.

I wanted to change as little as possible, generated code was intended
to be binary-identical with old code if the port is set to 0x80.

Currently source files can #define "SLOW_IO_BY_JUMPING" to avoid
writing to the dummy port. Perhaps someone should introduce
SLOW_IO_BY_UDELAY or so.

> May as well just stick with a single define here (i.e. remove DELAY_PORT).
OK.

Please take a look at the new version below.
(Changed only setup.S code, and some comments).

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy


--- ./include/asm-i386/io.h.orig	Fri Mar 15 17:23:15 2002
+++ ./include/asm-i386/io.h	Fri Mar 15 18:30:03 2002
@@ -221,17 +221,9 @@

 #endif /* __KERNEL__ */

-#ifdef SLOW_IO_BY_JUMPING
-#define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
-#else
-#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
-#endif
-
-#ifdef REALLY_SLOW_IO
-#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO
-#else
-#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
-#endif
+/* Moved the __SLOW_DOWN_IO macros to a separate file
+ * that can be included by setup.S */
+#include <asm/iodelay.h>

 #ifdef CONFIG_MULTIQUAD
 extern void *xquad_portio;    /* Where the IO area was mapped */
--- ./include/asm-i386/floppy.h.orig	Fri Mar 15 17:23:15 2002
+++ ./include/asm-i386/floppy.h	Fri Mar 15 17:55:04 2002
@@ -89,8 +89,7 @@
 	jmp 5f
 4:     	movb (%2),%0
 	outb %b0,%w4
-5:	decw %w4
-	outb %0,$0x80
+5:	decw %w4" __SLOW_DOWN_IO "
 	decl %1
 	incl %2
 	testl %1,%1
--- ./include/asm-i386/iodelay.h.orig	Fri Mar 15 18:31:01 2002
+++ ./include/asm-i386/iodelay.h	Fri Mar 15 21:14:17 2002
@@ -0,0 +1,28 @@
+#ifndef _ASM_IODELAY_H
+#define _ASM_IODELAY_H
+
+/* File suitable for inclusion by setup.S, normally included via <asm/io.h> */
+
+#ifdef SLOW_IO_BY_JUMPING
+#define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
+#else
+
+/*
+ * The dummy IO port to use for delays.
+ * Change only if you really know what you're doing
+ * Default value: 0x80
+ * Other values that have been suggested: 0x19, 0x42, 0xe2, 0xed
+ * Both macros must be changed to modify all IO delays in the kernel.
+ */
+
+#define __SLOW_DOWN_IO_PORT 0x80
+#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
+#endif
+
+#ifdef REALLY_SLOW_IO
+#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO
+#else
+#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
+#endif
+
+#endif
--- ./drivers/char/serial.c.orig	Fri Mar 15 17:23:15 2002
+++ ./drivers/char/serial.c	Fri Mar 15 17:24:13 2002
@@ -3661,12 +3661,12 @@
 		scratch = serial_inp(info, UART_IER);
 		serial_outp(info, UART_IER, 0);
 #ifdef __i386__
-		outb(0xff, 0x080);
+		outb(0xff,__SLOW_DOWN_IO_PORT);
 #endif
 		scratch2 = serial_inp(info, UART_IER);
 		serial_outp(info, UART_IER, 0x0F);
 #ifdef __i386__
-		outb(0, 0x080);
+		outb(0xff,__SLOW_DOWN_IO_PORT);
 #endif
 		scratch3 = serial_inp(info, UART_IER);
 		serial_outp(info, UART_IER, scratch);
--- ./drivers/char/riscom8.c.orig	Fri Mar 15 17:23:15 2002
+++ ./drivers/char/riscom8.c	Fri Mar 15 17:24:13 2002
@@ -278,10 +278,10 @@

 	/* Are the I/O ports here ? */
 	rc_out(bp, CD180_PPRL, 0x5a);
-	outb(0xff, 0x80);
+	outb(0xff, __SLOW_DOWN_IO_PORT);
 	val1 = rc_in(bp, CD180_PPRL);
 	rc_out(bp, CD180_PPRL, 0xa5);
-	outb(0x00, 0x80);
+	outb(0x00, __SLOW_DOWN_IO_PORT);
 	val2 = rc_in(bp, CD180_PPRL);

 	if ((val1 != 0x5a) || (val2 != 0xa5))  {
--- ./drivers/scsi/atp870u.c.orig	Fri Mar 15 17:23:15 2002
+++ ./drivers/scsi/atp870u.c	Fri Mar 15 17:24:13 2002
@@ -1042,7 +1042,7 @@
 	tmport = dev->ioport + 0x1b;
 	outb(0x02, tmport);

-	outb(0, 0x80);
+	outb(0, __SLOW_DOWN_IO_PORT);

 	val = 0x0080;		/* bsy	*/
 	tmport = dev->ioport + 0x1c;
@@ -1051,7 +1051,7 @@
 	outw(val, tmport);
 	val |= 0x0004;		/* msg	*/
 	outw(val, tmport);
-	inb(0x80);		/* 2 deskew delay(45ns*2=90ns) */
+	inb(__SLOW_DOWN_IO_PORT);  /* 2 deskew delay(45ns*2=90ns) */
 	val &= 0x007f;		/* no bsy  */
 	outw(val, tmport);
 	mydlyu(0xffff); 	/* recommanded SCAM selection response time */
@@ -1062,7 +1062,7 @@
 	if ((inb(tmport) & 0x04) != 0) {
 		goto wait_nomsg;
 	}
-	outb(1, 0x80);
+	outb(1, __SLOW_DOWN_IO_PORT);
 	mydlyu(100);
 	for (n = 0; n < 0x30000; n++) {
 		if ((inb(tmport) & 0x80) != 0) {	/* bsy ? */
@@ -1078,13 +1078,13 @@
 	}
 	goto TCM_SYNC;
 wait_io1:
-	inb(0x80);
+	inb(__SLOW_DOWN_IO_PORT);
 	val |= 0x8003;		/* io,cd,db7  */
 	outw(val, tmport);
-	inb(0x80);
+	inb(__SLOW_DOWN_IO_PORT);
 	val &= 0x00bf;		/* no sel     */
 	outw(val, tmport);
-	outb(2, 0x80);
+	outb(2, __SLOW_DOWN_IO_PORT);
 TCM_SYNC:
 	mydlyu(0x800);
 	if ((inb(tmport) & 0x80) == 0x00) {	/* bsy ? */
@@ -1103,18 +1103,18 @@
 	val &= 0x00ff;		/* synchronization  */
 	val |= 0x3f00;
 	fun_scam(dev, &val);
-	outb(3, 0x80);
+	outb(3, __SLOW_DOWN_IO_PORT);
 	val &= 0x00ff;		/* isolation	    */
 	val |= 0x2000;
 	fun_scam(dev, &val);
-	outb(4, 0x80);
+	outb(4, __SLOW_DOWN_IO_PORT);
 	i = 8;
 	j = 0;
 TCM_ID:
 	if ((inw(tmport) & 0x2000) == 0) {
 		goto TCM_ID;
 	}
-	outb(5, 0x80);
+	outb(5, __SLOW_DOWN_IO_PORT);
 	val &= 0x00ff;		/* get ID_STRING */
 	val |= 0x2000;
 	k = fun_scam(dev, &val);
--- ./drivers/video/sis/sis_main.c.orig	Fri Mar 15 17:23:15 2002
+++ ./drivers/video/sis/sis_main.c	Fri Mar 15 17:27:16 2002
@@ -2308,7 +2308,7 @@
 	u8 reg;
 	int nRes;

-	outb (0x77, 0x80);
+	outb (0x77, __SLOW_DOWN_IO_PORT);

 	if (sisfb_off)
 		return -ENXIO;
--- ./arch/i386/boot/setup.S.orig	Fri Mar 15 17:23:15 2002
+++ ./arch/i386/boot/setup.S	Fri Mar 15 20:50:13 2002
@@ -54,6 +54,7 @@
 #include <asm/boot.h>
 #include <asm/e820.h>
 #include <asm/page.h>
+#include <asm/iodelay.h>

 /* Signature words to ensure LILO loaded us right */
 #define SIG1	0xAA55
@@ -1001,7 +1002,7 @@

 # Delay is needed after doing I/O
 delay:
-	outb	%al,$0x80
+	outb    %al,$__SLOW_DOWN_IO_PORT
 	ret

 # Descriptor tables

