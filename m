Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265309AbUFOGNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUFOGNA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 02:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUFOGNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 02:13:00 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:59581 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265309AbUFOGM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 02:12:58 -0400
Date: Tue, 15 Jun 2004 08:11:48 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: akpm@osdl.org, torvalds@osdl.org, john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
Subject: [PATCH 2/3] round up  in __udelay() [Was: Re: Too much error in __const_udelay() ?]
Message-ID: <20040615061148.GB27541@dominikbrodowski.de>
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

Round up in __udelay(): 2**32 / 100000 is 4294.97, so it's more intuitive
to round up, and it causes more predictable results:

n usec delay on a 1500000 BogoMIPS system: 

  n 	   before	  -mull		after
  1	 1000 ticks	 1499 ticks	 1500 ticks
 10	14000 ticks	14999 ticks	15000 ticks

n usec delay on a 100000 BogoMIPS system: 

 n 	   before	  -mull		after
  1	    0 ticks	   99 ticks	  100 ticks
 10	    0 ticks	  999 ticks	 1000 ticks
100	 9000 ticks	 9999 ticks	10000 ticks


While it can be argued that some time is also spent in the delay 
functions, it's better to spend _at least_ the specified time sleeping, 
in my humble opinion. And the overhead of a specific ->delay() implementation
should be substracted in the specific ->delay() implementation.


Signed-off-by: Dominik Brodowski <linux@brodo.de>

diff -ruN linux-original/arch/i386/lib/delay.c linux/arch/i386/lib/delay.c
--- linux-original/arch/i386/lib/delay.c	2004-06-15 07:53:07.046312536 +0200
+++ linux/arch/i386/lib/delay.c	2004-06-15 07:51:42.792121120 +0200
@@ -40,7 +40,7 @@
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
+	__const_udelay(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up) */
 }
 
 void __ndelay(unsigned long nsecs)
diff -ruN linux-original/include/asm-i386/delay.h linux/include/asm-i386/delay.h
--- linux-original/include/asm-i386/delay.h	2004-06-14 18:20:29.000000000 +0200
+++ linux/include/asm-i386/delay.h	2004-06-15 07:51:42.878108048 +0200
@@ -16,7 +16,7 @@
 extern void __delay(unsigned long loops);
 
 #define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
+	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
 	__udelay(n))
 	
 #define ndelay(n) (__builtin_constant_p(n) ? \
