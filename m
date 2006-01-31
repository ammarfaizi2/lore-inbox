Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWAaQV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWAaQV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAaQV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:21:29 -0500
Received: from tim.rpsys.net ([194.106.48.114]:14778 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751099AbWAaQV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:21:29 -0500
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com>
References: <1138714918.6869.139.camel@localhost.localdomain>
	 <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 16:21:19 +0000
Message-Id: <1138724479.6869.201.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-01-31 at 15:46 +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Why cannot existing block layer hook be used for this?

The trigger is supposed to be reflecting actual hardware activity, not
block layer activity.

I'll experiment with the feasibility of the block later as I've always
been uneasy about the hooks into the lower level layers. There are a
number of issues to consider though.

1. The block layer isn't always aware of device activity (eg. flash
block erasing in mtd devices) (is this the case for IDE?).

2. Default trigger naming becomes problematic for led devices. Currently
an MMC card reader's LED could set its trigger to say "mmc-disk" and end
up with some kind of sensible activity light. (ignoring the more than
one card reader case where all the lights would be synced :).

A potential solution would be to add individual gendisk triggers by
hooking add_disk/del_disk. The MMC read would presumably know its
major/minor number before registering its LED. 

I'm not sure how to intercept disk activity for a given gendisk offhand.
There is also a question of where the led_trigger pointers end up.
struct gendisk may or may not be acceptable.

3. Matching something like all IDE disks becomes hard (and is actually
more desirable than individual devices at times - see below). 

At first glance a potential solution would be to hook
register_blkdev/unregister_blkdev and create yet more triggers but where
do you hook the activity? There is no data structure the led trigger
pointer can be part of either.

These solutions are going to end up with a lot of unused led triggers on
any given system. 

> Why are you adding LED_FULL event handling to a specific
> device driver (ide-disk) but LED_OFF event handling to a generic
> IDE end request function?

The trigger started out as just being ide-disk.c based but there is no
place where the IDE end request function could be hooked within it due
to its use of generic functions. The trigger therefore had to move into
more generic code. If there was a point in ide-disk where an IDE end
request could be hooked it, it could be confined to that file.

Alternatively it could be made to apply to all ide activity if a
suitable start request point was found to hook into.

> This solution has very limited flexibility (disk accesses for
> all IDE ports will be registered as coming from the same
> source) but I guess it is fine?

For users in the handheld world, that's desirable as the trigger shows
any IDE disk activity. You normally only have a small number of leds to
work with (say 1 or 2).

I can imagine some users wanting to be able to get this information per
IDE port but the code to do that would be a lot more invasive with more
overhead. It might be easier and more flexible through the block layer
which is something I'll investigate. I get the feeling things start to
scale out of proportion and control though.

Regards,

Richard

