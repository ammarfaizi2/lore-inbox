Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422882AbWJYVU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422882AbWJYVU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWJYVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:20:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:37770 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030334AbWJYVUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:20:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hMQsutNMRbvjMJwz0Z9V4ngDRJKSn8XAvvJUdL4j23lNmnLZ8YFlzT9LunzUb00IEumKGjI5tAjW1fEm8UhevAxAyFcWlt5u2DQSzx+HzY/1Jy8DdQRrJmt8szFJ4EzNkhODb8G9P7kzJjWqs6Dx/vk/dBNltPSM6wnMRVdcokE=
Message-ID: <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com>
Date: Wed, 25 Oct 2006 14:20:22 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
Cc: linux-kernel@vger.kernel.org, randy.dunlap@oracle.com, clemens@ladisch.de,
       ak@muc.de, vojtech@suse.cz, bob.picco@hp.com
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/06, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
>
> General comment. I guess this patch will conflict with timer cleanups
> and hrt timer patches. This patch being smaller, it may be easier to
> rebase this against hrt timer patches.
Thanks for comments.
Rebasing against hrt and other cleanups is a good idea. I would wait
till they make it into mainline.
>
> >+       */
> >+      printk(KERN_INFO PREFIX "HPET id: %#x. ACPI LRR bit %s SET\n",
> >+                      hpet_tbl->id, acpi_hpet_lrr ? "": "NOT");
>
> I don't see acpi_hpet_lrr getting used anywhere in the patch? Are you
> planning to change it in any subsequent patches?

No. Let me explain what I observed.

I tested against five different bioses (some with 8132, some with
CK-804 ..etc) and I observed three different patterns.

1. HW is LRR capable, HPET ACPI it is 1, timer interrupt is on INT2.
Before the fix: Linux cannot get timer interrupts on INT0, goes for ACPI timer.
After the fix : Works fine. This is according to hpet spec.

2. HW is LRR capable, HPET ACPI bit is set to 0. timer interrupt is on INT2.
Before the fix :  Linux cannot get timer interrupts on INT0, goes for
ACPI timer.
After the fix: Faulty BIOS behavior. Introduced parameter
hpet_lrr_force to handle this situation.

3. HW is LRR capable, HPET ACPI bit is set to 1. timer interrupt is on INT0.
Before the fix: Linux works fine.
After the fix :  Faulty BIOS. No way to know which INT timer is connected to.

To handle case 3, I removed all references to acpi_hpet_lrr, explained
this case in the code and decided to solely rely on the command line
parameter for LRR capability. Rational for this approach is ,
1. At present, there are not many BIOSes which implement LRR (correctly)
2. People would see the bootup message (MP-BIOS bug...) if LRR is
enabled and no timer interrupt on INT0. They can pass the hpet_lrr=1
to make everything work fine.
Is it the right approach?

>
> >
> > #ifdef        CONFIG_X86_64
> >       vxtime.hpet_address = hpet_tbl->addr.addrl |
> >diff --git a/arch/i386/kernel/time_hpet.c
> >b/arch/i386/kernel/time_hpet.c
> >index 1a2a979..01b2f67 100644
> >--- a/arch/i386/kernel/time_hpet.c
> >+++ b/arch/i386/kernel/time_hpet.c
> >@@ -94,7 +94,8 @@ static int hpet_timer_stop_set_go(unsign
> >        * Go!
> >        */
> >       cfg = hpet_readl(HPET_CFG);
> >-      if (hpet_use_timer)
> >+      /* Ideally the following should be &&(acpi_hpet_lrr ||
> >hpet_lrr_force) */
> >+      if (hpet_use_timer && hpet_lrr_force)
>
> What will be the value of hpet_lrr_force if no boot parameter was used.
zero.
> It will end up coming from uninitialized data section. Right?
Since it is a global variable, I assumed it would be automatically
initialized to zero, and zero is the expected default. Did I miss
something obvious?

>
> So, CFG_LEGACY will not be set on any platforms unless lrr_force
> parameter is used? Is that the intention or am I missing something?
Yes. That is the way I could think of to handle faulty bios implementations.
>
> >-      setup_irq(0, &irq0);
> >+      printk(KERN_WARNING PREFIX "Registering Timer IRQ =
> >%d\n", timer_irq);
>
> Why is this an unconditional warning?
hmm... That is not required. I should have removed it.

Thanks,
Om.
