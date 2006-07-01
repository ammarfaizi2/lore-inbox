Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932848AbWGARdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbWGARdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932855AbWGARdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:33:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:38879 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932848AbWGARdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:33:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jm+GC/2z4KiDIcH2PpEHZuC/xUTFC6UWhAG13FmALVpdqG97JswyiSCjN9WnDKxWMyk3TO7BFhwX6nGzt7oy1mQD7Ff6kxBZ8Qxz/F04z0W6OAbV8l/xBXStHBe15aKqK2sCaii9qiEmFZ0/Ytqt+tO7+LpLW6eMbQoYZtnkZTc=
Message-ID: <4807377b0607011033s3e329d7cy1081fb6c8be41e9b@mail.gmail.com>
Date: Sat, 1 Jul 2006 10:33:22 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "john stultz" <johnstul@us.ibm.com>
Subject: Re: 2.6.17-mm4
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1151713862.16221.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
	 <20060629120518.e47e73a9.akpm@osdl.org>
	 <4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
	 <20060630171212.50630182.akpm@osdl.org>
	 <4807377b0606301717t35d783cbgad6d67daeb163f5a@mail.gmail.com>
	 <1151713862.16221.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/06, john stultz <johnstul@us.ibm.com> wrote:
> >  <IRQ> [<ffffffff8100d442>] main_timer_handler+0x1ed/0x3ad
> >  [<ffffffff8100d614>] timer_interrupt+0x12/0x27
> >  [<ffffffff8105076a>] handle_IRQ_event+0x29/0x5a
> >  [<ffffffff81050837>] __do_IRQ+0x9c/0xfd
> >  [<ffffffff8100bf27>] do_IRQ+0x63/0x71
> >  [<ffffffff810098b8>] ret_from_intr+0x0/0xa
> >  <EOI>
>
> Hmmm. From that trace I suspect something is enabling interrupts (likely
> in time_init) before timekeeping_init() has chosen the clocksource.
>
> Does the following workaround the issue?
>
> thanks
> -john
>
> diff --git a/init/main.c b/init/main.c
> index ae04eb7..41adc97 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -497,8 +497,8 @@ asmlinkage void __init start_kernel(void
>         init_timers();
>         hrtimers_init();
>         softirq_init();
> -       time_init();
>         timekeeping_init();
> +       time_init();
>
>         /*
>          * HACK ALERT! This is early. We're enabling the console before
>

Yes it works, the previously failing bisect kernel boots with this
change. I'll take a look through andrew's suggestions next.
