Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBOX2T>; Thu, 15 Feb 2001 18:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBOX2A>; Thu, 15 Feb 2001 18:28:00 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:65296 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129066AbRBOX15>; Thu, 15 Feb 2001 18:27:57 -0500
Date: Thu, 15 Feb 2001 15:27:53 -0800
Message-Id: <200102152327.f1FNRrZ04871@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Richard A Nelson <cowboy@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-ac$x and timer oddities
In-Reply-To: <Pine.LNX.4.33.0102151510010.2238-100000@badlands.lexington.ibm.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001 15:57:09 -0500 (EST), Richard A Nelson <cowboy@vnet.ibm.com> wrote:
> The machine boots and runs for some time without problems, but then
> something makes the clock *very* jittery:
> 
> *  xscreensaver kicks in after almost no time (even betwixt quick
>    keystrokes and in the middle of mouse movement), and the password prompt
>    timer zips down to nothing post haste
> *  neworking apps gets a time-out on almost all connections (netscape, ftp, etc)
> *  It can take quite a while for focus to change after moving the mouse
> *  The machine will hang (hard - CAD or SYSREQ B do nothing) after a
>    variable amount of time (>8 hours)
> 
> I think this may've even started at 2.4.0, but seems to have gotten
> worse recently.

This patch (from Vojtech Pavlik) might help. Alan included it in 2.2.19pre,
so I'm not sure why he didn't add it to 2.4ac as well.

If it doesn't apply cleanly, do it by hand.

Hope this helps,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
------------------------
--- linux-2.2.17/arch/i386/kernel/time.c.old	Sat Oct 28 00:04:09 2000
+++ linux-2.2.17/arch/i386/kernel/time.c	Sat Oct 28 00:02:10 2000
@@ -452,6 +452,14 @@
 		count = inb_p(0x40);    /* read the latched count */
 		count |= inb(0x40) << 8;
 
+		if (count > LATCH-1) {
+			outb_p(0x34, 0x43);
+		        outb_p(LATCH & 0xff, 0x40);
+			outb(LATCH >> 8, 0x40);
+			count = LATCH - 1;
+		}
+
+
 		count = ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 	}
