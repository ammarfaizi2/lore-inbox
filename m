Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVKVS4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVKVS4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbVKVS4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:56:05 -0500
Received: from nm02mta.dion.ne.jp ([61.117.3.69]:50436 "HELO
	nm02omta02d.dion.ne.jp") by vger.kernel.org with SMTP
	id S965108AbVKVS4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:56:04 -0500
Date: Wed, 23 Nov 2005 03:56:41 +0900
From: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
To: Ingo Molnar <mingo@elte.hu>
Subject: Fw: [PATCH] fix to clock running too fast
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051123035256.684C.AKIRA-T@s9.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Are you still the maintainer of IO-APIC support?
I really appreciated if you could forward the following patch to 
a right person.


Forwarded by Akira Tsukamoto <akira-t@suna-asobi.com>
----------------------- Original Message -----------------------
 From:    Akira Tsukamoto <akira-t@s9.dion.ne.jp>
 To:      linux-kernel@vger.kernel.org
 Date:    Sun, 20 Nov 2005 23:41:07 +0900
 Subject: [PATCH] fix to clock running too fast
----


This one line patch adds upper bound testing inside timer_irq_works()
when evaluating whether irq timer works or not on boot up.

It fix the machines having problem with clock running too fast.

What this patch do is,
if  timer interrupts running too fast through IO-APIC IRQ then false back to 
i8259A IRQ.

I really appreciate for the feedback from ATI Xpress 200 chipset user,
It should eliminate the needs of adding no_timer_check on kernel options.

I have NEC laptop using ATI Xpress 200 chipset with Pentium M 1.8GHz and 
its clock keep going forward when kernel compiled with local APIC support.
Many machines based on RS200 chipset seem to have the same problem, 
including Acer Ferrari 400X AMD notebook or Compaq R4000.

Also I would like to have comments on upper bound limit, 16 ticks, which 
I chose in this patch. My laptop always reports around 20, which is double from normal.


--- linux-2.6.14/arch/i386/kernel/io_apic.c	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.14-io_apic-atifix/arch/i386/kernel/io_apic.c	2005-11-09 00:31:56.000000000 +0900
@@ -1798,21 +1798,21 @@
 	/* Let ten ticks pass... */
 	mdelay((10 * 1000) / HZ);
 
 	/*
 	 * Expect a few ticks at least, to be sure some possible
 	 * glue logic does not lock up after one or two first
 	 * ticks in a non-ExtINT mode.  Also the local APIC
 	 * might have cached one ExtINT interrupt.  Finally, at
 	 * least one tick may be lost due to delays.
 	 */
-	if (jiffies - t1 > 4)
+	if (jiffies - t1 > 4 && jiffies - t1 < 16)
 		return 1;
 
 	return 0;
 }
 
 /*
  * In the SMP+IOAPIC case it might happen that there are an unspecified
  * number of pending IRQ events unhandled. These cases are very rare,
  * so we 'resend' these IRQs via IPIs, to the same CPU. It's much
  * better to do it this way as thus we do not have to be aware of


-- 
Akira Tsukamoto <akira-t@s9.dion.ne.jp> <akira-t@suna-asobi.com>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


--------------------- Original Message Ends --------------------

-- 
Akira Tsukamoto <akira-t@s9.dion.ne.jp> <>


