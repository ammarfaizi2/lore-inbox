Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265311AbUFOGNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUFOGNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 02:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265312AbUFOGNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 02:13:18 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:22462 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265311AbUFOGNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 02:13:11 -0400
Date: Tue, 15 Jun 2004 08:11:09 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: akpm@osdl.org, torvalds@osdl.org, john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
Subject: [PATCH 1/3] mull'ify multiplication with HZ in __const_udelay() [Was: Re: Too much error in __const_udelay() ?]
Message-ID: <20040615061109.GA27541@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	akpm@osdl.org, torvalds@osdl.org, john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	george anzinger <george@mvista.com>, greg kh <greg@kroah.com>,
	Chris McDermott <lcm@us.ibm.com>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com> <20040605152326.GA11239@dominikbrodowski.de> <1086635568.2234.171.camel@cog.beaverton.ibm.com> <20040607212058.GA23106@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607212058.GA23106@dominikbrodowski.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stultz mentioned on lkml ( http://lkml.org/lkml/2004/6/5/15 ) that
calls to udelay() don't delay long enough, causing trouble e.g. in the USB
subsystem. The following patches address this issue.

Move the multiplication of (loops_per_jiffy * xloops) with HZ into
the "mull" asm operation. This increases the accuracy of the delay functions
largely:

n usec delay on a system with loops_per_jiffy = 1500000 : 

  n 	   before	  after
  1	 1000 ticks	 1499 ticks
 10	14000 ticks	14999 ticks

n usec delay on a system with loops_per_jiffy = 100000 : 

 n 	   before	  after
  1	    0 ticks	   99 ticks
 10	    0 ticks	  999 ticks
100	 9000 ticks	 9999 ticks

As noted by Kurt Garloff, it's necessary to adjust for large loops_per_jiffies,
as the multiplication of it with HZ fails for 4GHz or larger. So, John Stultz
suggested multiplying xloops with 4 first, and multiplying with (HZ/4).

Signed-off-by: Dominik Brodowski <linux@brodo.de>


diff -ruN linux-original/arch/i386/lib/delay.c linux/arch/i386/lib/delay.c
--- linux-original/arch/i386/lib/delay.c	2004-06-14 18:20:27.000000000 +0200
+++ linux/arch/i386/lib/delay.c	2004-06-15 07:48:57.302279400 +0200
@@ -31,10 +31,11 @@
 inline void __const_udelay(unsigned long xloops)
 {
 	int d0;
+	xloops *= 4;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy));
-        __delay(xloops * HZ);
+		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy * (HZ/4)));
+        __delay(xloops);
 }
 
 void __udelay(unsigned long usecs)
