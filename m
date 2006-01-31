Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWAaU1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWAaU1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWAaU1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:27:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63077 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751458AbWAaU1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:27:30 -0500
Date: Tue, 31 Jan 2006 21:29:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
Message-ID: <20060131202944.GE4215@suse.de>
References: <1138714918.6869.139.camel@localhost.localdomain> <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com> <1138724479.6869.201.camel@localhost.localdomain> <58cb370e0601310944l421174f8j1802d94f1ae93a01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0601310944l421174f8j1802d94f1ae93a01@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2006, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On 1/31/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> > Hi,
> >
> > On Tue, 2006-01-31 at 15:46 +0100, Bartlomiej Zolnierkiewicz wrote:
> > >
> > > Why cannot existing block layer hook be used for this?
> >
> > The trigger is supposed to be reflecting actual hardware activity, not
> > block layer activity.
> 
> Ben, code in pmac.c (+ block layer) seems to be doing something
> different then Kconfig help entry states ("Blink laptop LED on drive
> activity")?

I doubt it really matters a lot, since either the activity will be done
right after (the LED will likely still be on), or the drive is already
busy doing stuff (in which case the LED is on anyways). So while the
trigger point might not be at the instant we start drive activity, it's
really close.

You could move the block layer trigger from add_request() to
elevator.c:elv_next_request() instead, right where it sets REQ_STARTED
to improve the start trigger point. Since that can happen at irq time
(whereas the add_request() cannot), it's likely more expensive.

The goal of the activity led for powerbook was not really to be 100%
accurate, but be able to tell whether the drive was doing io or not.
It's nice feedback to have for the user.

That said, the LED stuff should be able to handle pmac as well, so why
not add it generically instead of clamping it into the ide layer in odd
places?

-- 
Jens Axboe

