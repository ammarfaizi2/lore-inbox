Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbVHZFER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbVHZFER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 01:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVHZFER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 01:04:17 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:32987 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751503AbVHZFEQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 01:04:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gS8bR+o28gO7srZZ9JDZROQ2R+02pnK8eekmBGf3r99watq76gw1ibx4CT7nPb53uIuo0ZtRKG03Z55FGDEpkAw1fXKrDMchYHMOWLjbt4zvFi2BthMBGIi8rXSMPL5L5T8RAkv/D6IyAIqaDwbyQH0RJI6dagSApMT0atXAbf4=
Message-ID: <253818670508252204b22e8c2@mail.gmail.com>
Date: Fri, 26 Aug 2005 01:04:15 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH: ide: ide-disk freeze support for hdaps
Cc: Jon Escombe <lists@dresco.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jens Axboe <axboe@suse.de>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
In-Reply-To: <58cb370e0508250859701ea571@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <253818670508250708a9075a0@mail.gmail.com>
	 <58cb370e0508250859701ea571@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

Thank you for your feedback :), as this is my first dabble in
ide/block drivers I certainly need it!

On 8/25/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> +config IDEDISK_FREEZE
> 
> Is there any advantage of having it as a config option?

The main reasons I added the config option:
- the freeze feature is really only useful to an (increasing) niche of
mobile computers with an accelerometer.

- it might actually be detrimental to most other systems, you would
never want to freeze the queue on most machines - especially a
production system, and for that reason alone it seemed sensible to me
to be able to selectively remove it completely.

- to re-inforce the experimental nature of the patch, and disable it
by default (although this could be achieved just with EXPERIMENTAL I
suppose).

> Please make the interface accept number of seconds (as suggested by Jens)
> and remove this module parameter. This way interface will be more flexible
> and cleaner.  I really don't see any advantage in doing "echo 1 > ..." instead
> of "echo x > ..." (Pavel, please explain).

Either way is pretty easy enough to implement. Note though that I'd
expect the userspace app should thaw the device when danger is out of
the way (the timeout is mainly there to ensure that the queue isn't
frozen forever, and should probably be higher). Personally I don't
have too much of an opinion either way though... what's the consensus?
:).

I can understand Pavel's opinion in that a enable/disable attribute in
sysfs seems the norm, and is more intuitive. Also what should 'cat
/sys/block/hda/device/freeze' return for a 'echo x >
/sys/block/hda/device/freeze' sysfs attribute? The seconds remaining?
1/0 for frozen/thawed?

> +static void freeze_expire(unsigned long data);
> +static struct timer_list freeze_timer =
> +       TIMER_INITIALIZER(freeze_expire, 0, 0);
> 
> There needs to be a timer per device not a global one
> (it works for a current special case of T42 but sooner
>  or later we will hit this problem).

I was considering that, but I am confused as to whether each drive has
it's own queue or not? (I really am a newbie to this stuff...). If so
then yes there should be a per-device timer.

> queue handling should be done through block layer helpers
> (as described in Jens' email) - we will need them for libata too.

Good point, I'll try to move as much as I can up to the block layer,
it helps when it comes to implementing freeze for libata as you point
out too.

> At this time attribute can still be in use (because refcounting is done
> on drive->gendev), you need to add "disk" class to ide-disk driver
> (drivers/scsi/st.c looks like a good example how to do it).

I missed that completely, I'll look at changing it.

> IMO this should also be handled by block layer
> which has all needed information, Jens?
> 
> While at it: I think that sysfs support should be moved to block layer (queue
> attributes) and storage driver should only need to provide queue_freeze_fn
> and queue_thaw_fn functions (similarly to cache flush support).  This should
> be done now not later because this stuff is exposed to the user-space.

I was actually considering using a queue attribute originally, but in
my indecision I decided to go with Jen's suggestion. A queue attribute
does make sense in that the attribute primarily is there to freeze the
queue, but it would also be performing the head park. Would a queue
attribute be confusing because of that?

> 
> +               /*
>                  * Sanity: don't accept a request that isn't a PM request
>                  * if we are currently power managed. This is very important as
>                  * blk_stop_queue() doesn't prevent the elv_next_request()
> @@ -1661,6 +1671,9 @@ int ide_do_drive_cmd (ide_drive_t *drive
>                 where = ELEVATOR_INSERT_FRONT;
>                 rq->flags |= REQ_PREEMPT;
>         }
> +       if (action == ide_next)
> +               where = ELEVATOR_INSERT_FRONT;
> +
>         __elv_add_request(drive->queue, rq, where, 0);
>         ide_do_request(hwgroup, IDE_NO_IRQ);
>         spin_unlock_irqrestore(&ide_lock, flags);
> 
> Why is this needed?

I think Jon discussed that in a previous thread, but basically
although ide_next is documented in the comment for ide_do_drive_cmd,
there isn't (as far as Jon or I could see) anything actually handling
it. This patch is carried over from Jon's work and adds the code to
handle ide_next by inserting the request at the front of the queue.

> Overall, very promising work!

Thanks :-), most of it is Jon's work, and Jen's suggestions though.

Yani

P.S. Sorry about the lack of [] around PATCH...lack of sleep. Its more
of a RFC anyway.
