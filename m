Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143628AbRA1RHo>; Sun, 28 Jan 2001 12:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143627AbRA1RHf>; Sun, 28 Jan 2001 12:07:35 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:15886 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S143568AbRA1RHX>; Sun, 28 Jan 2001 12:07:23 -0500
Date: Sun, 28 Jan 2001 17:07:03 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <3A744CA7.AF41F05D@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0101281653020.26076-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Manfred Spraul wrote:

> It isn't wrong to call schedule() with disabled interrupts - it's a
> feature ;-)
> Those 10% sleep_on() users that aren't broken use it:
> 
>  for(;;) {
> 	cli();
> 	if(condition)
> 		break;
> 	sleep_on(&my_wait_queue);
> 	sti();
>  }

That's valid iff the wake_up() can only happen from an ISR.

> E.g. TIOCMIWAIT in drivers/char/serial.c - a nearly correct sleep_on()
> user.

TIOCMIWAIT does restore_flags() before interruptible_sleep_on(). It's 
broken too.

Anyway, if you're feeling pedantic, consider what happens if shutdown() is
called from rs_close() just before sleep_on() is called. Regardless of 
whether interrupts are disabled.

> But I doubt that 10% of the sleep_on() users are non-broken...

There are cases where you don't care if you miss a wakeup because you have
a timeout. So it's only suboptimal rather than broken. I did produce a 
patch to BUG() in sleep_on if the BKL isn't held, at one point. It was 
quite interesting.

> If you remove sleep_on(), then you can disallow calling schedule() with
> disabled local interrupts.

The remaining valid users of sleep_on are mainly filesystems - much fs
code gets called with the BKL held. I expect that to change during 2.5, at 
which point sleep_on can be terminated with extreme prejudice. 

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
