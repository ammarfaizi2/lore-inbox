Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276074AbRJGDYW>; Sat, 6 Oct 2001 23:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276073AbRJGDYM>; Sat, 6 Oct 2001 23:24:12 -0400
Received: from hermes.toad.net ([162.33.130.251]:7132 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276060AbRJGDYA>;
	Sat, 6 Oct 2001 23:24:00 -0400
Subject: Re: Question about rtc_lock
From: Thomas Hood <jdthood@mail.com>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p05100304b7e4d1f5b152@[207.213.214.37]>
In-Reply-To: <E15prGs-0001G3-00@the-village.bc.nu>
	<1002379256.857.3.camel@thanatos>  <p05100304b7e4d1f5b152@[207.213.214.37]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 06 Oct 2001 23:24:02 -0400
Message-Id: <1002425044.978.57.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 11:24, Jonathan Lundell wrote:
> rtc_interrupt(), you mean.

Right.

> Even if there weren't current interrupt code doing CMOS accesses, it 
> would seem prudent to assume that there might be eventually, the 
> RTC/NVRAM being a multi-purpose shared resource.

I'm not concerned about an irq handler (present or future)
interfering with us as we write to the CMOS RAM.  What I'm
concerned about is getting a rtc interrupt while we hold rtc_lock,
with deadlock being the result (since rtc_interrupt will spin on
the lock).

Either (1) we need to change these spinlocks to _irq, or (2) we
need to know that this bit of code runs only with irqs disabled.
My question is: Is it (1) or (2)?

Or is it (3) Thomas Hood is failing to understand something here?

Assuming the answer is (1), I append a patch that changes the
spinlock calls to _irqsave versions.

Cheers,
Thomas

The patch:
--- linux-2.4.10-ac5-fix/arch/i386/kernel/bootflag.c_PREV	Fri Oct  5 23:20:43 2001
+++ linux-2.4.10-ac5-fix/arch/i386/kernel/bootflag.c	Sat Oct  6 23:15:33 2001
@@ -81,26 +81,30 @@
 
 static void __init sbf_write(u8 v)
 {
+	unsigned long flags;
+
 	if(sbf_port != -1)
 	{
 		v &= ~(1<<7);
 		if(!parity(v))
 			v|=1<<7;
 			
-		spin_lock(&rtc_lock);
+		spin_lock_irqsave(&rtc_lock, flags);
 		CMOS_WRITE(v, sbf_port);
-		spin_unlock(&rtc_lock);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 	}
 }
 
 static u8 __init sbf_read(void)
 {
 	u8 v;
+	unsigned long flags;
+
 	if(sbf_port == -1)
 		return 0;
-	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 	v = CMOS_READ(sbf_port);
-	spin_unlock(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 	return v;
 }
 

