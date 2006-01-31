Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWAaRop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWAaRop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWAaRop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:44:45 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:39962 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751304AbWAaRoo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:44:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d4iq67Bv0YPO53YWro/ERjUhtZiPQt/9eEeehv4gUVf4zTqDhvMuYRCiqEjoLti/l+bS9vg1hojdP48JVFKf3/DVQ2f8ywpryjKL8jOqgnldnPqDYfiQogy9MJ2tAuIvUYEw8M15eZ5zK1aOR7U4mu3BzN9qjp9SZAKcnoHSIrw=
Message-ID: <58cb370e0601310944l421174f8j1802d94f1ae93a01@mail.gmail.com>
Date: Tue, 31 Jan 2006 18:44:41 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
Cc: LKML <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <1138724479.6869.201.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138714918.6869.139.camel@localhost.localdomain>
	 <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com>
	 <1138724479.6869.201.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/31/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> Hi,
>
> On Tue, 2006-01-31 at 15:46 +0100, Bartlomiej Zolnierkiewicz wrote:
> >
> > Why cannot existing block layer hook be used for this?
>
> The trigger is supposed to be reflecting actual hardware activity, not
> block layer activity.

Ben, code in pmac.c (+ block layer) seems to be doing something
different then Kconfig help entry states ("Blink laptop LED on drive
activity")?

> I'll experiment with the feasibility of the block later as I've always
> been uneasy about the hooks into the lower level layers. There are a
> number of issues to consider though.

At worst it should be handled at host driver level not device driver
(like pmac.c and hwif->act_led).

> 1. The block layer isn't always aware of device activity (eg. flash
> block erasing in mtd devices) (is this the case for IDE?).

Same is true for ide-disk changes - they are aware only of filesystem
activity (no flush cache, special commands, I/O taskfiles etc.).

> 2. Default trigger naming becomes problematic for led devices. Currently
> an MMC card reader's LED could set its trigger to say "mmc-disk" and end
> up with some kind of sensible activity light. (ignoring the more than
> one card reader case where all the lights would be synced :).
>
> A potential solution would be to add individual gendisk triggers by
> hooking add_disk/del_disk. The MMC read would presumably know its
> major/minor number before registering its LED.
>
> I'm not sure how to intercept disk activity for a given gendisk offhand.
> There is also a question of where the led_trigger pointers end up.
> struct gendisk may or may not be acceptable.

gendisk presents device at filesystem layer and it is
probably not the appropriate place to add LED handling

> 3. Matching something like all IDE disks becomes hard (and is actually
> more desirable than individual devices at times - see below).
>
> At first glance a potential solution would be to hook
> register_blkdev/unregister_blkdev and create yet more triggers but where
> do you hook the activity? There is no data structure the led trigger
> pointer can be part of either.
>
> These solutions are going to end up with a lot of unused led triggers on
> any given system.
>
> > Why are you adding LED_FULL event handling to a specific
> > device driver (ide-disk) but LED_OFF event handling to a generic
> > IDE end request function?
>
> The trigger started out as just being ide-disk.c based but there is no
> place where the IDE end request function could be hooked within it due
> to its use of generic functions. The trigger therefore had to move into
> more generic code. If there was a point in ide-disk where an IDE end
> request could be hooked it, it could be confined to that file.

Isn't ->end_request hook in ide_driver_t enough?

I see no reason why the custom ->end_request function cannot
be added to ide-disk.  All needed infrastructure is there.

> Alternatively it could be made to apply to all ide activity if a
> suitable start request point was found to hook into.

start_request() in ide-io.c

Thanks,
Bartlomiej
