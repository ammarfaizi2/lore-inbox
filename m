Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136750AbREIRBw>; Wed, 9 May 2001 13:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136679AbREIRBk>; Wed, 9 May 2001 13:01:40 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:21268 "EHLO
	c0mailgw09.prontomail.com") by vger.kernel.org with ESMTP
	id <S136747AbREIRA6>; Wed, 9 May 2001 13:00:58 -0400
Message-ID: <3AF97773.80DAFFC0@mvista.com>
Date: Wed, 09 May 2001 09:59:31 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <E14xUfi-0002PB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >     while(!!time_before(jiffies, timer))
> >     {
> >         if(!!(*event & mask))
> >         {
> >             stat = 0;
> >             break;
> >         }
> >         schedule();
> 
> You want to yield as well otherwise you may just spin anyway
> 
> > Both of these procedures schedule() while waiting for something to
> > happen. The wait can be very long (1 second) so I don't want to
> > just spin eating CPU cycles. I have to give the CPU to somebody.
> 
> So use a timer
> 
> void tick_tick_boom(unsigned long l)
> {
>         struct my_device *d = (struct my_device *)l;
> 
>         if(its_still_busy(d))
>         {
>                 d->timer_count--;
>                 if(d->timer_count)
>                 {
>                         /* Try again until timer_count hits zero */
>                         add_timer(&t->timer, jiffies+1);
>                         return;
>                 }
>                 else
>                 {
>                         /* Lose some .. */
>                         d->event_status = TIMEOUT;
>                 }
>         }
>         else
>         {
>                 /* Win some .. */
>                 d->event_status = OK;
>         }
>         /* Wake up the invoker */
>         wake_up(&d->timer_wait);
> }

To clarify this a bit, the above code invokes itself with the timer and
thus runs under the timer interrupt.  The first call to it would be made
from your driver which would then sleep waiting for the wake_up, which
will come either on success or when the timer_count has expired.  This
code will poll each jiffie.

The key here is to use the wake_up/ sleep combination to pass control
from the interrupt back to the driver.  This is not unlike what you must
already be doing for interrupt completion.

Do pay attention to getting the timer (&t->timer above) properly set up
(see my first response or most any usage in the kernel).

Have I got this right Alan?

George
