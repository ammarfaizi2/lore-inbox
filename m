Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWINMrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWINMrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 08:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWINMrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 08:47:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:7578 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751287AbWINMrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 08:47:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IBpwYuD5AIFQhMA33oYcynbaCgnM15XvEsRMp8licgnWT0CbSYgduM+akc2WScNfjdmWoPMpAWieNmY2UoHSyAH7VEGM/9emYkyUz1oOEuK28CAR+YKOFd2dQmyjc0v8LKi+XVd0oUMtDVwGSYhLzfM9utv51WX81TeSZWzlVbg=
Message-ID: <a2ebde260609140547xff48956rcf610f208500b7d5@mail.gmail.com>
Date: Thu, 14 Sep 2006 20:47:10 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Question on The Timer Interrupt Dispatch
In-Reply-To: <a2ebde260609130826u12a82ffy2c71dd5ec7c4f6bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260609130826u12a82ffy2c71dd5ec7c4f6bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure whether this phenomena is an hardware-specific wired one
or is a result of some design intent. I observed there is fixed delay
since the init thread entered run_init_process() to the secondary CPU
got the first tick, that is, around 7000 tick.

If I add a sleep_on_timeout(), or a busy-loop before the
run_init_process(), the delay period will not change. So I am confused
because that seems something within the ram disk image trigger the
first tick on the secondary CPU.

Could anyone at least confirm whether this is any design intent?
Thanks in advance.



2006/9/13, Dong Feng <middle.fengdong@gmail.com>:
> One question confuses me for quiet a while about the initialization of
> the IO APIC.
>
> For my understanding, in i386 architecture, the timer interrupts are
> dispatched among every CPU in a roughly round-robin fashion
> *immediately* (or reasonably short) after the IO APIC has been
> initialized and a secondary CPU has enabled its local IRQ. Turning to
> code, I suppose the first condition should be met by [init() ->
> smp_prepare_cpus() -> smp_boot_cpus() -> smpboot_setup_io_apic() ->
> setup_IO_APIC()], and the second condition should be met by [
> start_secondary() -> local_irq_enable() ].
>
> I tried to confirm my guess by tracing the initialization code
> execution on my Dual-core laptop . However, I get very confusing
> result. While both the conditions had just been met as described
> above, CPU 0 has handled about 70 ticks (i.e. timer interrupt) and CPU
> 1 has handled 0 tick. I expected CPU 1 would get its first timer
> interrupt after few ticks. But the fact is that CPU 1 has not been
> interrupted by timer until CPU 0 has handled over 7000 ticks. Since
> CPU 1 gets the first interrupt, the subsequent timer interrupts are
> distributed on both CPU roughly equally.
>
> I still can not find any explanation myself for the gap between my
> presumption and the result from code tracing. According to the
> presumption, CPU 1 should get the first interrupt while CPU 0 handles
> 70 ticks, but CPU 1 does not until CPU 0 handles over 7000 ticks.
> Could you please pointed out which part I missed in my understanding?
>
> Thanks.
>
