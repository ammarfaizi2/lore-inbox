Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUFGVYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUFGVYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbUFGVYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:24:11 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:41955 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S265069AbUFGVXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:23:18 -0400
Date: Mon, 7 Jun 2004 23:20:58 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
Subject: [PATCH 1/3] mull'ify multiplication with HZ in __const_udelay() [Was: Re: Too much error in __const_udelay() ?]
Message-ID: <20040607212058.GA23106@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	george anzinger <george@mvista.com>, greg kh <greg@kroah.com>,
	Chris McDermott <lcm@us.ibm.com>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com> <20040605152326.GA11239@dominikbrodowski.de> <1086635568.2234.171.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086635568.2234.171.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the multiplication of (loops_per_jiffy * xloops) with HZ into
the "mull" asm operation. This increases the accuracy of the delay functions
largely:

n usec delay on a 1500000 BogoMIPS system: 

  n 	   before	  after
  1	 1000 ticks	 1499 ticks
 10	14000 ticks	14999 ticks

n usec delay on a 100000 BogoMIPS system: 

 n 	   before	  after
  1	    0 ticks	   99 ticks
 10	    0 ticks	  999 ticks
100	 9000 ticks	 9999 ticks


Signed-off-by: Dominik Brodowski <linux@brodo.de>


diff -ruN linux-original/arch/i386/lib/delay.c linux/arch/i386/lib/delay.c
--- linux-original/arch/i386/lib/delay.c	2004-06-07 22:01:46.608351088 +0200
+++ linux/arch/i386/lib/delay.c	2004-06-07 22:05:03.299449496 +0200
@@ -33,8 +33,8 @@
 	int d0;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy));
-        __delay(xloops * HZ);
+		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy * HZ));
+        __delay(xloops);
 }
 
 void __udelay(unsigned long usecs)
