Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUFGVWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUFGVWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUFGVWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:22:39 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:32984 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265073AbUFGVWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:22:36 -0400
Date: Mon, 7 Jun 2004 23:23:03 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
Subject: [PATCH 3/3] fix for small xloops [Was: Re: Too much error in __const_udelay() ?]
Message-ID: <20040607212303.GC23106@dominikbrodowski.de>
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

The const_udelay calculation relies on the "overflow" of the lower 32 bits
of the mull operation. What's in the lower 32 bits is "cut off", so that a
"rounding down" phenomenon exists. For large arguments to {n,u}delay, this does
not matter, as udelay and ndelay round _up_ themselves. However, for small
delays (for cyclone timer: up to 20ns; for pmtmr-based delay timer it's even
up to 1500ns or 1us) it _is_ a critical error. Empirical testing has shown that
it happens only (for usual values of loops_per_jiffies) if xloops is lower or
equal to six. Let's be safe, and double that value, and add one xloop if
xloop is smaller than 13.

Signed-off-by: Dominik Brodowski <linux@brodo.de>

diff -ruN linux-original/arch/i386/lib/delay.c linux/arch/i386/lib/delay.c
--- linux-original/arch/i386/lib/delay.c	2004-06-07 23:02:02.472656160 +0200
+++ linux/arch/i386/lib/delay.c	2004-06-07 22:55:40.063791144 +0200
@@ -34,6 +34,8 @@
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
 		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy * HZ));
+	if (unlikely(xloops < 13))
+		xloops++;
         __delay(xloops);
 }
 
