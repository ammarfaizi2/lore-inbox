Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWIZDm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWIZDm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 23:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWIZDm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 23:42:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:3421 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750804AbWIZDm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 23:42:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=COrPzd8ZpjFV2mIhJSDDv29mfKMzmEZOp+SycfQqmORHr6VSbvglBm46YNQs1B489ZX1gATvymdeSIse2GA8+G88k0iA2FW23cXDj0oAgQ3XxozykRmpA40emfvRv2efs924WnrPbfRCp8pVex8CiE3Zt6Kcbh7tcuxh23PmCDU=
Message-ID: <6d6a94c50609252042g72f676a9s609095e2f1187ada@mail.gmail.com>
Date: Tue, 26 Sep 2006 11:42:25 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
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

No, schedule_and_signal_from_int will be called.
The above code is checking if there are at least two bits set on, if
so, schedule_and_signal_from_int will be called.

Blackfin supports 3 processor mode: (1) user mode (2) supervisor mode
(3) emulation mode. In the kernel space, the processor should be in
the supervisor mode. To keep the processor in the supervisor mode, we
raise the lowest priority interrupt event. Kerenl actually in the
interrupt handler of the lowest priority interrupt event. See
arch/blackfin/mach-bf53x/head.S.
=================================
/* This section keeps the processor in supervisor mode
         * during kernel boot.  Switches to user mode at end of boot.
         * See page 3-9 of Hardware Reference manual for documentation.
         */

        /* EVT15 = _real_start */

        p0.l = lo(EVT15);
        p0.h = hi(EVT15);
        p1.l = _real_start;
        p1.h = _real_start;
        [p0] = p1;
        csync;

        p0.l = lo(IMASK);
        p0.h = hi(IMASK);
        p1.l = IMASK_IVG15;
        p1.h = 0x0;
        [p0] = p1;
        csync;

        raise 15;
        p0.l = .LWAIT_HERE;
        p0.h = .LWAIT_HERE;
        reti = p0;
        rti;
===============================================
So, in the kernel space, there is always one bit in the IPEND register
is set. And if there comes a timer interrupt event, in the timer
interrupt handler, there should be two bits set in the IPEND register.
Therefore, schedule happens in the return_from_int.

So, I still say there is no latency here.

-Aubrey
