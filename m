Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131507AbRAZPJE>; Fri, 26 Jan 2001 10:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131883AbRAZPIy>; Fri, 26 Jan 2001 10:08:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131507AbRAZPIj>; Fri, 26 Jan 2001 10:08:39 -0500
Date: Fri, 26 Jan 2001 10:07:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <13AEBF842896@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.3.95.1010126095653.762A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Petr Vandrovec wrote:

> On 26 Jan 01 at 8:58, Richard B. Johnson wrote:
> > On Thu, 25 Jan 2001, H. Peter Anvin wrote:
> > > > You could use the DMA scratch register at 0x19. I'm sure Linux doesn't
> > > > "save" stuff there when setting up the DMA controller.
> > > > 
> > I will change the port on my machines and run them for a week. I
> > don't have any DEC Rainbows or other such. Yes, I know Linux will
> > not run on a '286.
> > 
> > Since 0x19 is a hardware register in a DMA controller, specifically
> > called a "scratch" register, it is unlikely to hurt anything. Note
> > that the BIOS saves stuff in CMOS. It never expects hardware registers
> > to survive a "warm boot". It even checks in CMOS to see if it should
> > preserve RAM.
> 
> Unless there are chips which need DELAY between accesses to DMA 
> controller ;-) And I'm sure there are such. Also, if DMA controller
> is integrated on board, outb is done in different speed than ISA 
> forwarded cycle to postcode port.
> 
> Just in case, on my VIA, 1e6 outb(0,0x80) tooks 2.07s, 1e6 outb(0,0x19)
> tooks 2.33s - so there is definitely difference - although in other 
> direction than I expected. (What you can expect from this ....)
>                                             Petr Vandrovec
>                                             vandrove@vc.cvut.cz

Each board has its own implimentation. This is what bothers Peter and
others. Embedded chip-sets don't do ISA bus-cycles. Some DMA controllers
now are accessed through a PCI/ISA bridge. Some are not, etc. Even
if you try to use a "spare" port existing in a Super I/O chip, this
if it exists at all, will run at a different speed than the old
board-mounted MFG port (where POST codes are written).

So. Here's stuff to test with.  The only thing on most machines that
actually uses the DMA controller is the floppy disk. I have done the
following.

(1)	Made a Linux floppy boot disk.
(2)	Did the following RAW copy:
	cp /dev/fd0 /tmp/foo
	cp /tmp/foo /dev/fd0
... A script that does this ten times.

Then I booted the machine from the floppy. It works okay. From this
I deduce that using the DMA scratch register doesn't hurt anything.

Here is a patch to try:




--- linux-2.4.0/include/asm/floppy.h.orig	Fri Jan 26 09:03:40 2001
+++ linux-2.4.0/include/asm/floppy.h	Fri Jan 26 09:05:50 2001
@@ -20,6 +20,9 @@
  * Went back to the 1MB limit, as some people had problems with the floppy
  * driver otherwise. It doesn't matter much for performance anyway, as most
  * floppy accesses go through the track buffer.
+ *
+ * Changed slow-down I/O port from 0x80 to 0x19.   rjohnson@analogic.com
+ *
  */
 #define _CROSS_64KB(a,s,vdma) \
 (!vdma && ((unsigned long)(a)/K_64 != ((unsigned long)(a) + (s) - 1) / K_64))
@@ -90,7 +93,7 @@
 4:     	movb (%2),%0
 	outb %b0,%w4
 5:	decw %w4
-	outb %0,$0x80
+	outb %0,$0x19
 	decl %1
 	incl %2
 	testl %1,%1
--- linux-2.4.0/include/asm/io.h.orig	Fri Jan 26 08:59:53 2001
+++ linux-2.4.0/include/asm/io.h	Fri Jan 26 09:06:21 2001
@@ -32,12 +32,15 @@
   *  isa_memset_io, isa_memcpy_fromio, isa_memcpy_toio added,
   *  isa_read[wl] and isa_write[wl] fixed
   *  - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+  *
+  *  Changed the slow-down I/O port from 0x80 to 0x19. 0x19 is a
+  *  DMA controller scratch register.  rjohnson@analogic.com
   */
 
 #ifdef SLOW_IO_BY_JUMPING
 #define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
 #else
-#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
+#define __SLOW_DOWN_IO "\noutb %%al,$0x19"
 #endif
 
 #ifdef REALLY_SLOW_IO






Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
