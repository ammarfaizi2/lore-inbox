Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWCXREk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWCXREk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWCXREk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:04:40 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:15794 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751150AbWCXREk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:04:40 -0500
Date: Fri, 24 Mar 2006 18:04:36 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, Dominik Brodowski <linux@brodo.de>
Subject: delay_tsc(): inefficient delay loop (2.6.16-mm1)
Message-ID: <20060324170436.GA1568@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I discovered that the delay loop used there (which simply found a new place
in 2.6.16-mm1; it existed much longer) is inefficient,
since it does an unnecessary subtraction *in the main loop* which also hits
asm code:

00000024 <delay_tsc>:
  24:   53                      push   %ebx
  25:   89 c3                   mov    %eax,%ebx
  27:   0f 31                   rdtsc
  29:   89 c1                   mov    %eax,%ecx
  2b:   f3 90                   pause
  2d:   0f 31                   rdtsc
  2f:   29 c8                   sub    %ecx,%eax
  31:   39 d8                   cmp    %ebx,%eax
  33:   72 f6                   jb     2b <delay_tsc+0x7>
  35:   5b                      pop    %ebx
  36:   c3                      ret

With such a patch:

--- linux-2.6.16-mm1/arch/i386/lib/delay.c.orig	2006-03-23 12:52:45.000000000 +0100
+++ linux-2.6.16-mm1/arch/i386/lib/delay.c	2006-03-24 12:53:01.000000000 +0100
@@ -44,10 +44,12 @@
 	unsigned long bclock, now;
 
 	rdtscl(bclock);
+	/* offset with bclock to have very simple comparison below */
+	loops += bclock;
 	do {
 		rep_nop();
 		rdtscl(now);
-	} while ((now-bclock) < loops);
+	} while (now < loops);
 }
 
 /*

the result is:

00000024 <delay_tsc>:
  24:   89 c1                   mov    %eax,%ecx
  26:   0f 31                   rdtsc
  28:   01 c1                   add    %eax,%ecx
  2a:   f3 90                   pause
  2c:   0f 31                   rdtsc
  2e:   39 c8                   cmp    %ecx,%eax
  30:   72 f8                   jb     2a <delay_tsc+0x6>
  32:   c3                      ret

Improvement: no unnecessary stuff after having hit the timer target value
(read: faster), better power saving, 4 bytes less opcodes.

The patch above could be considered weird since it fiddles with "loops"
directly. A possibly cleaner way would be to introduce a new variable
end = bclock + loops.

Comments? Anything that I'm missing here as to why it hasn't been done that
way before?

If this holds water then I'll submit a final patch soon.

Thanks!

Andreas Mohr
