Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265316AbUFOGOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUFOGOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 02:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265312AbUFOGOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 02:14:54 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:7359 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265313AbUFOGNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 02:13:36 -0400
Date: Tue, 15 Jun 2004 08:13:15 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: akpm@osdl.org, torvalds@osdl.org, john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
Subject: [PATCH 3/3] add 1 in __const_udelay() [Was: Re: Too much error in __const_udelay() ?]
Message-ID: <20040615061315.GD27541@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	akpm@osdl.org, torvalds@osdl.org, john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	george anzinger <george@mvista.com>, greg kh <greg@kroah.com>,
	Chris McDermott <lcm@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "mull" instruction in __const_udelay() cuts off the lower 32 bits -- so,
it is "rounding down". This is both an issue for small ndelay()s for _all_ 
values for loops_per_jiffy and for certain {n,u}delay()s for many loops_per_jiffy
values.

Assuming

LPJ = 1501115

udelay(87)

results in

130597 loops to be spent.

However, 1000 * 130597 / 1501115 is 86.999997 us, so we're actually
_rounding down_. 1000 * 130598 / 1501115 is 87.000662841, which would be the
technically correct thing to do. Of course, for the TSC case this won't
matter as the maths take some time, so the actual delay is

1000 * __udelay(x) / lpj + __OVERHEAD(x)


Anybody worried about both the additional overhead and the fact that the
overhead takes some time to run should add a check

        if (unlikely(xloops < OVERHEAD))
                return;
        xloops -= OVERHEAD;


to the delay() routines in arch/i386/kernel/timers/*.c and determine
what the OVERHEAD is.

Signed-off-by: Dominik Brodowski <linux@brodo.de>

diff -ruN linux-original/arch/i386/lib/delay.c linux/arch/i386/lib/delay.c
--- linux-original/arch/i386/lib/delay.c	2004-06-15 07:54:16.938687280 +0200
+++ linux/arch/i386/lib/delay.c	2004-06-15 07:54:36.275747600 +0200
@@ -35,7 +35,7 @@
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
 		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy * (HZ/4)));
-        __delay(xloops);
+        __delay(++xloops);
 }
 
 void __udelay(unsigned long usecs)
