Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310818AbSCHMBJ>; Fri, 8 Mar 2002 07:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310821AbSCHMA7>; Fri, 8 Mar 2002 07:00:59 -0500
Received: from [195.63.194.11] ([195.63.194.11]:12036 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310818AbSCHMAz>; Fri, 8 Mar 2002 07:00:55 -0500
Message-ID: <3C88A796.2070301@evision-ventures.com>
Date: Fri, 08 Mar 2002 12:59:18 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <Pine.LNX.4.44.0203081258500.5383-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please let me elaborate a bit on this, to give you may be
some hints about where to look for an actual solution of
the problem:

Zwane Mwaikambo wrote:
> Please refer to Subject [PANIC] 2.5.5-pre1 elevator.c for more detailed 
> explanation.
> 
> I don't really like this patch mainly because it _really_ feels like a 
> bandaid for a larger problem in ide-cd, namely it violating the ide 
> layers command requirements. But it does stop my box from oopsing and 
> lets it finish the "dd" i was doing. Oops is at the end.
> 
> diffed against 2.5.6-pre3 (one down 2 quadrillion to go ;)
> 
> --- linux-2.5.6-pre/drivers/ide/ide-cd.c.orig	Fri Mar  8 12:09:10 2002
> +++ linux-2.5.6-pre/drivers/ide/ide-cd.c	Fri Mar  8 12:04:08 2002
> @@ -666,9 +666,11 @@
>  			cdrom_end_request(drive, 0);
>  		}
>  
> -		/* If we got a CHECK_CONDITION status,
> -		   queue a request sense command. */
> -		if ((stat & ERR_STAT) != 0)
> +		/* If we got a CHECK_CONDITION status, queue a request sense command,
> +		   however if we're generating spurious errors, make sure we don't
> +		   attempt to queue an an already started request.
> +		*/
> +		if (((stat & ERR_STAT) != 0) && !(rq->flags & REQ_STARTED))
>  			cdrom_queue_request_sense(drive, NULL, NULL, NULL);
>  	} else
>  		blk_dump_rq_flags(rq, "ide-cd bad flags");
> 

After having a look at the oops I think that this may be very well a
symptom of another problem in the ide-cd.c drivers overall
way of working. Please let me elaborate a bit.

In ide.c there is one central interrupt handler, namely:

void ide_timer_expiry(unsigned long data)

This function is called upon finish of every command.

However for cd-rom there are commands, which can
take quite a long time. Therefore there is the possiblity there
to provide a polling function, which will be engaged after the
interrupt happens in the above function:

	/* continue */
				if ((wait = expiry(drive)) != 0) {
					/* reengage timer */
					hwgroup->timer.expires  = jiffies + wait;
					add_timer(&hwgroup->timer);
					spin_unlock_irqrestore(&ide_lock, flags);
					return;
				}
And plase guess whot? CD-ROM is the only driver which is using
this facility. Please have a look at the last
argument of ide_set_handler(). The second argument is the
interrutp handler for a command. The third is supposed to be
the poll timerout function. But if you look at the
actual poll function found in ide-cd.c (and only there).
You may as well feel to try to just execute its commands directly in
ide_timer_expiry, thus reducing tons of possible races ind the
overall intr handling found currently there.

