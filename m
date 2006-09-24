Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWIXDfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWIXDfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 23:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWIXDfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 23:35:33 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:9797 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750889AbWIXDfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 23:35:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ecjzCQUgmLqDjV+hjndfCIQ8UWAQBsE9/pV7zPynw6b80u4Fc39QMblt48pQmTOz8TGsv+MntTnQxmnIv4uu3GCNfG6WfX9DuZjyeoTBzmBFmRsIbqOQ0CDtIsG2+kbbrtc5LMwGksNo6nfbn2UghCNe37tpkwwWxfrzKxKogXY=
Message-ID: <6d6a94c50609232035x4025672dg4f02b3bcceb6d531@mail.gmail.com>
Date: Sun, 24 Sep 2006 11:35:31 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200609230218.36894.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609230218.36894.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > +static uint32_t reloc_stack_operate(unsigned int oper, struct module *mod)
> > +{
> > +     uint32_t value;
> > +     switch (oper) {
> > +     case R_add:
> > +             {
> > +                     value =
> > +                         reloc_stack[reloc_stack_tos - 2] +
> > +                         reloc_stack[reloc_stack_tos - 1];
> > +                     reloc_stack_tos -= 2;
> > +                     break;
> > +             }
>
> no need for the curly braces here and below

Hmm, but we need one line < 80 columns, don't we?

>
> static inline void default_idle(void)
>
> > +{
> > +     while (!need_resched()) {
> > +             leds_switch(LED_OFF);
> > +           __asm__("nop;\n\t \
> > +                         nop;\n\t \
> > +                         nop;\n\t \
> > +                         idle;\n\t": : :"cc");
> > +             leds_switch(LED_ON);
> > +     }
> > +}
> > +
>
> This looks racy. What if you get an interrupt after testing need_resched()
> but before the idle instruction?
>
> Normally, this should look like
>
>         while(!need_resched()) {
>                 local_irq_disable();
>                 if (!need_resched())
>                         asm volatile("idle");
>                 local_irq_enable();
>         }
>
> Of course that only works if your idle instruction wakes up on pending
> interrupts.


No, that doesn't work on blackfin. Blackfin need interrupt(here is
timer interrupt) to wake up the core from IDLE mode. Once you disable
the interrupt, the core will sleep forever.

-Aubrey
