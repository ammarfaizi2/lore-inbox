Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUFGU1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUFGU1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265042AbUFGU1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:27:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:26813 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265038AbUFGU1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:27:11 -0400
Subject: Re: Too much error in __const_udelay() ?
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1086635568.2234.171.camel@cog.beaverton.ibm.com>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com>
	 <20040605152326.GA11239@dominikbrodowski.de>
	 <1086635568.2234.171.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1086640044.2234.176.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 07 Jun 2004 13:27:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 12:12, john stultz wrote:
> I'm also spinning up a patch w/ these changes to test, let me know how
> your testing went and I'll do the same.

The following patch of your suggestions resolves the USB problem for me.
I'd be interested if anyone else could test this to insure it doesn't
open up any other issues.

thanks
-john

===== arch/i386/lib/delay.c 1.5 vs edited =====
--- 1.5/arch/i386/lib/delay.c	Wed Jul  2 21:21:32 2003
+++ edited/arch/i386/lib/delay.c	Mon Jun  7 12:17:26 2004
@@ -33,13 +33,13 @@
 	int d0;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy));
-        __delay(xloops * HZ);
+		:"1" (xloops),"0" (HZ*current_cpu_data.loops_per_jiffy));
+        __delay(xloops?xloops:1);
 }
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
+	__const_udelay(usecs * 0x000010c7);  /* 2**32 / 1000000 */
 }
 
 void __ndelay(unsigned long nsecs)
===== include/asm-i386/delay.h 1.2 vs edited =====
--- 1.2/include/asm-i386/delay.h	Tue Feb 18 06:40:31 2003
+++ edited/include/asm-i386/delay.h	Mon Jun  7 12:16:42 2004
@@ -16,7 +16,7 @@
 extern void __delay(unsigned long loops);
 
 #define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
+	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
 	__udelay(n))
 	
 #define ndelay(n) (__builtin_constant_p(n) ? \





