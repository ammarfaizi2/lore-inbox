Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965502AbWI0KEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965502AbWI0KEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 06:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965504AbWI0KEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 06:04:15 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:18030 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965502AbWI0KEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 06:04:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M0X0NrX9/yWz9X4kJC8TvBwOa4+gavmnP/ck5bZ46jJzRmwLfjOUbJNg+6j0PC1WNMo6viVf2x+RtshEzCCOy9IoTrB5F6tu/23QjW8dd7Xbrld8CkDo2HlPGq5tMRSqjP9/S1p53awznH2B/8iXE32xh+5cjEZZOr1xLUQp1J0=
Message-ID: <6d6a94c50609270304o79947064y3019dd5f82eb8373@mail.gmail.com>
Date: Wed, 27 Sep 2006 18:04:13 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>, "Getz, Robin" <Robin.Getz@analog.com>
In-Reply-To: <200609251905.22224.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609251126.17494.arnd@arndb.de>
	 <6d6a94c50609250839y7365e20ale6910e36b0ec9976@mail.gmail.com>
	 <200609251905.22224.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Sorry, I would say I made a logic mistake here. The schedule in the
return_from_int() will only be called when the process steps from the
user space into the kerner space( i.e. sys call). So, what you
described are all correct.

And, we have already had a solution to fix the issue you pointed out.
==================
inline static void default_idle(void)
{
       int flag;

       while (!need_resched()) {
               leds_switch(LED_OFF);
               local_irq_save(flag);
               if ( likely(!need_resched()) {
#if defined (ANOMALY_05000244) && defined (CONFIG_BLKFIN_CACHE)
                     __asm__("nop; nop;\n");
#endif
                     __asm__(".align 64;\n STI %0; IDLE;\n"
                             : %0 (flag): :"cc");
               }
               local_irq_restore(flag);
               leds_switch(LED_ON);
       }
}======================================

Here, according to design, it's not possible that interrupt occurs
between "STI %0"(enable interrupt) and "IDLE".

__asm__(".align 64; STI %0; IDLE;" : %0 (x):  :"cc");

Robin can explain more details.

-Aubrey

On 9/26/06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 25 September 2006 17:39, Aubrey wrote:
> > 1) Timer interrupt will call do_irq(), then return_from_int().
> >
> > 2) return_from_int() will check if there is interrupt pending or
> > signal pending, if so, it will call schedule_and_signal_from_int().
> >
> > 3) schedule_and_signal_from_int() will jump to resume_userspace()
> >
> > 4) resume_userspace() will call _schedule to run the user task.
>
> I have a little trouble reading your assembly code, but your
> return_from_int() function should normally not call
> schedule_and_signal_from_int() when the interrupt happened
> in kernel context (like in the idle function):
>
> +       /* if not return to user mode, get out */
> +       p2.l = lo(IPEND);
> +       p2.h = hi(IPEND);
> +       r0 = [p2];
> +       r1 = 0x17(Z);
> +       r2 = ~r1;
> +       r2.h = 0;
> +       r0 = r2 & r0;
> +       r1 = 1;
> +       r1 = r0 - r1;
> +       r2 = r0 & r1;
> +       cc = r2 == 0;
> +       if !cc jump 2f;
>
> This looks a lot like you user_mode() function, so you jump
> over schedule_and_signal_from_int() here.
>
> What you described would be a preemptive kernel
> (CONFIG_PREEMPT), but you clearly don't have that enabled.
>
>         Arnd <><
>
