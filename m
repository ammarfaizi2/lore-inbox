Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136475AbREIOHI>; Wed, 9 May 2001 10:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136473AbREIOG6>; Wed, 9 May 2001 10:06:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6154 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136472AbREIOGs>; Wed, 9 May 2001 10:06:48 -0400
Subject: Re: 
To: root@chaos.analogic.com
Date: Wed, 9 May 2001 15:10:31 +0100 (BST)
Cc: george@mvista.com (george anzinger),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <Pine.LNX.3.95.1010509085529.8159A-100000@chaos.analogic.com> from "Richard B. Johnson" at May 09, 2001 09:04:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xUfi-0002PB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     while(!!time_before(jiffies, timer))
>     {
>         if(!!(*event & mask))
>         {
>             stat = 0;
>             break;
>         }
>         schedule();

You want to yield as well otherwise you may just spin anyway

> Both of these procedures schedule() while waiting for something to
> happen. The wait can be very long (1 second) so I don't want to
> just spin eating CPU cycles. I have to give the CPU to somebody.

So use a timer


void tick_tick_boom(unsigned long l)
{
	struct my_device *d = (struct my_device *)l;

	if(its_still_busy(d))
	{
		d->timer_count--;
		if(d->timer_count)
		{
			/* Try again until timer_count hits zero */
			add_timer(&t->timer, jiffies+1);
			return;
		}
		else
		{
			/* Lose some .. */
			d->event_status = TIMEOUT;
		}
	}
	else
	{
		/* Win some .. */
		d->event_status = OK;
	}
	/* Wake up the invoker */
	wake_up(&d->timer_wait);
}

