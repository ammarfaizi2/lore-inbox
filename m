Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbSKFXPT>; Wed, 6 Nov 2002 18:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266202AbSKFXPT>; Wed, 6 Nov 2002 18:15:19 -0500
Received: from NEUROSIS.MIT.EDU ([18.243.0.82]:1005 "EHLO neurosis.mit.edu")
	by vger.kernel.org with ESMTP id <S266200AbSKFXPS>;
	Wed, 6 Nov 2002 18:15:18 -0500
Date: Wed, 6 Nov 2002 18:21:44 -0500
From: Jim Paris <jim@jtan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: root@chaos.analogic.com, Willy Tarreau <willy@w.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021106182144.A13751@neurosis.mit.edu>
References: <Pine.LNX.3.95.1021106074128.3698A-100000@chaos.analogic.com> <1036589124.9781.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1036589124.9781.6.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 06, 2002 at 01:25:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recommendations about outb versus outb_p may be valid, but I think
this patch should go in anyway in its current form.  I'm resetting the
i8253 in the same way it was initially set in i8259.c, and so Dick, if
you want to change how that's done, it needs to get changed in both
places; that's outside the scope of what I'm trying to fix right now.

To summarize, this patch will fix:

1) An unpaired read to the i8253 causes time to jump around forever
2) A buggy i8253 causes time to jump around 0.008% of the time

#1 is reported whenever it occurs.  #2 is only reported the first few
times because it's likely to occur every two minutes or so on affected
chips.

Patch is against 2.4.18.  It applies cleanly (but is untested) on 2.4.19
and 2.4.20-rc1.

-jim

diff -urN linux-2.4.18/arch/i386/kernel/time.c linux-2.4.18-jim/arch/i386/kernel/time.c
--- linux-2.4.18/arch/i386/kernel/time.c	Fri Mar 15 18:28:53 2002
+++ linux-2.4.18-jim/arch/i386/kernel/time.c	Wed Nov  6 17:18:28 2002
@@ -501,7 +501,30 @@
 
 		count = inb_p(0x40);    /* read the latched count */
 		count |= inb(0x40) << 8;
+
+		/* Any unpaired read will cause the above to swap MSB/LSB
+		   forever.  Try to detect this and reset the counter. */
+		if (count > LATCH) {
+			printk(KERN_WARNING 
+			       "i8253 count too high! resetting..\n");
+			outb_p(0x34, 0x43);
+			outb_p(LATCH & 0xff, 0x40);
+			outb(LATCH >> 8, 0x40);
+			count = LATCH - 1;
+		}
+
 		spin_unlock(&i8253_lock);
+
+		/* Buggy i8253s might hold the LATCH value. */
+		if (count == LATCH) {
+			static int reported = 0;
+			if(reported<3) {
+				printk(KERN_WARNING
+				       "i8253 count too high! adjusting..\n");
+				reported++;
+			}
+			count--;
+		}
 
 		count = ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
