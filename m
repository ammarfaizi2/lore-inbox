Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSKERgN>; Tue, 5 Nov 2002 12:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSKERgM>; Tue, 5 Nov 2002 12:36:12 -0500
Received: from NEUROSIS.MIT.EDU ([18.243.0.82]:1003 "EHLO neurosis.mit.edu")
	by vger.kernel.org with ESMTP id <S264907AbSKERgL>;
	Tue, 5 Nov 2002 12:36:11 -0500
Date: Tue, 5 Nov 2002 12:42:34 -0500
From: Jim Paris <jim@jtan.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105124234.A5837@neurosis.mit.edu>
References: <20021102013704.A24684@neurosis.mit.edu> <20021103143216.A27147@neurosis.mit.edu> <1036355418.30679.28.camel@irongate.swansea.linux.org.uk> <20021105113020.A5210@neurosis.mit.edu> <20021105171406.GC879@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021105171406.GC879@alpha.home.local>; from willy@w.ods.org on Tue, Nov 05, 2002 at 06:14:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, why not trying to resync, with something like :
> 
>    if (count >= LATCH)
> 	count = (count >> 8) | inb(0x40) << 8;

That's best if we really are out of sync, but it's hard to tell.  It
could be that the 8253's latch value got clobbered somehow, in which
case we definitely want to fix that or our timer interrupts will come
out at the wrong rate.  We also still need to double-check that
count < LATCH after your code.

Unless we assume that an unpaired read is more common than having the
latch value clobbered in some other way, then I think just resetting
the counter should be okay.  Since none of this _should_ ever happen
(but did on my system, grr), it's probably not worth making it too
complicated just to try to figure out what went wrong.

Updated patch with the printk and corrected conditional is below.

-jim

diff -urN linux-2.4.18/arch/i386/kernel/time.c linux-2.4.18-jim/arch/i386/kernel/time.c
--- linux-2.4.18/arch/i386/kernel/time.c	Fri Mar 15 18:28:53 2002
+++ linux-2.4.18-jim/arch/i386/kernel/time.c	Tue Nov  5 12:39:38 2002
@@ -501,6 +501,18 @@
 
 		count = inb_p(0x40);    /* read the latched count */
 		count |= inb(0x40) << 8;
+
+		/* Any unpaired read will cause the above to swap MSB/LSB
+		   forever.  Try to detect this and reset the counter. */
+		if (count >= LATCH) {
+			printk(KERN_WARNING 
+			       "i8253 count too high! resetting..\n");
+			outb_p(0x34, 0x43);
+			outb_p(LATCH & 0xff, 0x40);
+			outb(LATCH >> 8, 0x40);
+			count = LATCH - 1;
+		}
+
 		spin_unlock(&i8253_lock);
 
 		count = ((LATCH-1) - count) * TICK_SIZE;
