Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWI0Q0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWI0Q0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWI0Q0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:26:09 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:39260 "EHLO
	nwd2mail10.analog.com") by vger.kernel.org with ESMTP
	id S1751215AbWI0Q0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:26:08 -0400
X-IronPort-AV: i="4.09,225,1157342400"; 
   d="scan'208"; a="12218281:sNHT21509740"
Message-Id: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Wed, 27 Sep 2006 12:25:17 -0400
To: arnd Bergmann <arnd@arndb.de>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd wrote:
>Ok, looks good now. Just a few details that don't impact the
>functionality:

[snip]

What I committed (to our source) is:

+++ process.c   27 Sep 2006 15:32:46 -0000      1.42
@@ -101,10 +101,10 @@
  {
         while (!need_resched()) {
                 leds_switch(LED_OFF);
-             __asm__("nop;\n\t \
-                         nop;\n\t \
-                         nop;\n\t \
-                         idle;\n\t": : :"cc");
+               local_irq_disable();
+               if (likely( !need_resched()))
+                       idle_with_irq_disabled();
+               local_irq_enable();
                 leds_switch(LED_ON);
         }
  }

And in system.h, this was added (because this is where all the other 
inlines is which messes with the interrupts are - and irq_flags is already 
defined here)

+++ system.h    27 Sep 2006 15:32:51 -0000      1.24

+#define idle_with_irq_disabled() do {   \
+        __asm__ __volatile__ (          \
+                "nop; nop;\n"           \
+                ".align 8;\n"           \
+                "sti %0; idle;\n"       \
+                ::"d" (irq_flags));     \
+} while (0)

It seems to work OK.

Thanks for your help on this.

I think we have been weeding through everyone's comments, and have most 
things fixed up.

Are there any other major issues that you can see (that have not been 
pointed out).

-Robin
