Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754149AbWKGJnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbWKGJnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbWKGJnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:43:55 -0500
Received: from www.osadl.org ([213.239.205.134]:671 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1754149AbWKGJnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:43:53 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162891737.4715.354.camel@localhost.localdomain>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
	 <1162830033.4715.201.camel@localhost.localdomain>
	 <20061106205825.GA26755@rhlx01.hs-esslingen.de>
	 <200611070141.16593.len.brown@intel.com> <20061107080733.GB9910@elte.hu>
	 <1162887935.4715.349.camel@localhost.localdomain>
	 <20061107091628.GA5399@rhlx01.hs-esslingen.de>
	 <1162891737.4715.354.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 10:45:58 +0100
Message-Id: <1162892758.4715.362.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 10:28 +0100, Thomas Gleixner wrote:
> > That's what I didn't understand all that time:
> > I do get the "C2 unusable, kills APIC timer" message, so I expected the code
> > to not use C2, but it seems it did use it (causing hangs) and I didn't
> > fully analyze the code whether it truly tried to prevent C2 here
> > (handling was a bit opaque to me, should have analyzed it
> > more thoroughly to get to know exactly what happens).
> > 
> > And like I said, brutally hard-wiring max_cstate to C1 already fixed
> > dynticks things for me, so it seems as if it still touched C2 before.
> 
> Yes, it leaves the C states untouched, it uses (should use) PIT instead
> of the local APIC timer. I'm a bit confused, why this does not work on
> your box.

Can you try the patch below please ? I just noticed, that the local APIC
gets reprogrammed before we switch back from PIT, which is perfectly
fine, but maybe your box does not like that treatment. If this does not
help, I'm going to do the never switch back from PIT hackery which I
wanted to avoid for performance reasons.

	tglx

Index: linux-2.6.19-rc4-mm1/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.19-rc4-mm1.orig/arch/i386/kernel/apic.c	2006-11-07 10:33:56.000000000 +0100
+++ linux-2.6.19-rc4-mm1/arch/i386/kernel/apic.c	2006-11-07 10:33:18.000000000 +0100
@@ -100,6 +100,7 @@ static struct clock_event_device lapic_c
  */
 struct lapic_event_device {
 	struct clock_event_device	evdev;
+	enum clock_event_mode		mode;
 	unsigned long			last_delta;
 	unsigned long			counter;
 };
@@ -224,9 +225,11 @@ static void lapic_next_event(unsigned lo
 	struct lapic_event_device *ldev;
 
 	ldev = container_of(evt, struct lapic_event_device, evdev);
-	ldev->last_delta = delta;
 
-	apic_write_around(APIC_TMICT, delta);
+	if (ldev->mode == CLOCK_EVT_PERIODIC) {
+		ldev->last_delta = delta;
+		apic_write_around(APIC_TMICT, delta);
+	}
 }
 
 /*
@@ -257,7 +260,7 @@ static void lapic_timer_setup(enum clock
 		apic_write_around(APIC_LVTT, v);
 		break;
 	}
-
+	ldev->mode = mode;
 	local_irq_restore(flags);
 }
 


