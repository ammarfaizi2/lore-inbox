Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132728AbRDEVKK>; Thu, 5 Apr 2001 17:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbRDEVKA>; Thu, 5 Apr 2001 17:10:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132728AbRDEVJv>; Thu, 5 Apr 2001 17:09:51 -0400
Date: Thu, 5 Apr 2001 17:08:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
cc: John Fremlin <chief@bandits.org>, linux-kernel@vger.kernel.org
Subject: Re: how to let all others run
In-Reply-To: <Pine.SOL.4.31.0104052232001.5537-100000@sun4.lrz-muenchen.de>
Message-ID: <Pine.LNX.3.95.1010405164713.2321A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001 Oliver.Neukum@lrz.uni-muenchen.de wrote:

> > Doesn't even show on `top`. Further, it gets the CPU about 100 times
> > a second (HZ). This is normally what you want for something that
> > polls, buts needs to give up the CPU so that whatever it's waiting
> > for can get done as soon as possible.
> 
> Hi,
> 
> first of all I want to do this in kernel.
> I need to do this to prevent a race. To handle removal of a hotpluggable
> scsi device. On SMP there's a race between the task blocking the scsi
> device and killing obsolete requests and other tasks queueing no requests.
> If a task has passed the block before it comes into effect, but the
> killing task is done with killing requests before the new request can be
> queued the system will oops.
> Simply calling the kernel equivalent of sched_yield() is not an option as
> the number of runnable tasks can be smaller than the number of CPUs in
> which case sched_yield is a nop.
> 

You never mentioned doing things within the kernel. It's a lot easier
within the kernel.

cd ../linux/drivers/char
grep schedule *.c | more

This will give an idea of the many options available. In the simpist
case, you can spin-lock entry into your code, set a semaphore, then
schedule() until it changes. You have down(&semaphore) to do the
whole thing, or you can do it yourself as in serial.c:

		When the last requst to the device has been
		aborted, your code sets "my_semaphore" to FALSE.
		You have to do in under the "my_lock" lock to
		be free of all races.

		spin_lock_irqsave(&my_lock, flags);
                my_semaphore = FALSE;
                spin_lock_irqrestore(&my_lock, flags);


		driver wait-thread does:
		spin_lock_irqsave(&my_lock, flags);
                my_semaphore = TRUE;
                spin_lock_irqrestore(&my_lock, flags);

		set_current_state(TASK_INTERRUPTIBLE);
                while(my_semaphore == TRUE)
                    schedule();

Note that you can even schedule with the interrupts OFF, but you can't
schedule from an interrupt-service routine. There is a difference!

Even if queued requests get cleared before you even look at your
semaphore, there is no race.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


