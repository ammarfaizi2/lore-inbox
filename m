Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSKEQXq>; Tue, 5 Nov 2002 11:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264887AbSKEQXq>; Tue, 5 Nov 2002 11:23:46 -0500
Received: from NEUROSIS.MIT.EDU ([18.243.0.82]:53994 "EHLO neurosis.mit.edu")
	by vger.kernel.org with ESMTP id <S264886AbSKEQXp>;
	Tue, 5 Nov 2002 11:23:45 -0500
Date: Tue, 5 Nov 2002 11:30:20 -0500
From: Jim Paris <jim@jtan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105113020.A5210@neurosis.mit.edu>
References: <20021102013704.A24684@neurosis.mit.edu> <20021103143216.A27147@neurosis.mit.edu> <1036355418.30679.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1036355418.30679.28.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 03, 2002 at 08:30:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any comments?
> 
> Have a play with it, if your idea works when you deliberately disturb it
> then send in a patch

This works well.

-jim

diff -urN linux-2.4.18/arch/i386/kernel/time.c linux-2.4.18-jim/arch/i386/kernel/time.c
--- linux-2.4.18/arch/i386/kernel/time.c	Fri Mar 15 18:28:53 2002
+++ linux-2.4.18-jim/arch/i386/kernel/time.c	Tue Nov  5 11:22:02 2002
@@ -501,6 +501,16 @@
 
 		count = inb_p(0x40);    /* read the latched count */
 		count |= inb(0x40) << 8;
+
+		/* Any unpaired read will cause the above to swap MSB/LSB
+		   forever.  Try to detect this and reset the counter. */
+		if (count > LATCH) {
+			outb_p(0x34, 0x43);
+			outb_p(LATCH & 0xff, 0x40);
+			outb(LATCH >> 8, 0x40);
+			count = LATCH - 1;
+		}
+
 		spin_unlock(&i8253_lock);
 
 		count = ((LATCH-1) - count) * TICK_SIZE;
