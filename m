Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSFCT2a>; Mon, 3 Jun 2002 15:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSFCT23>; Mon, 3 Jun 2002 15:28:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46860 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311749AbSFCT22>;
	Mon, 3 Jun 2002 15:28:28 -0400
Message-ID: <3CFBC307.70F0581A@zip.com.au>
Date: Mon, 03 Jun 2002 12:27:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/16] unplugging fix
In-Reply-To: <3CF88852.BCFBF774@zip.com.au> <3CF9CB92.A6BF921B@zip.com.au> <20020602081204.GD820@suse.de> <20020603083937.GA23527@suse.de> <3CFB3383.44A6CC96@zip.com.au> <20020603094121.GB23527@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Mon, Jun 03 2002, Andrew Morton wrote:
> > Jens Axboe wrote:
> > >
> > > ...
> > > Does this work? I can't poke holes in it, but then again...
> >
> > It survives a 30-minute test.  It would not have done that
> > before...
> 
> Excellent.

Hope so.  My Friday-night-notfix wouild have survived that long :(

> > Are you sure blk_stop_queue() and blk_run_queues() can't
> > race against each other?  Seems there's a window where
> > they could both do a list_del().
> 
> Hmm I'd prefer to just use the safe variant and not rely on the plugged
> flag when the lock isn't held, so here's my final version with just that
> change. Agree?

Not really ;)

There still seems to be a window where blk_run_queues() will
assume the queue is on local_plug_list while not holding
plug_list_lock.  The QUEUE_PLUGGED flag is set, so blk_stop_queue()
will remove the queue from local_plug_list.  Then blk_run_queues()
removes it as well.  The new list_head debug code will rudely
catch that.

I'd be more comfortable if the duplicated info in QUEUE_FLAG_PLUGGED
and "presence on a list" were made fully atomic/coherent via
blk_plug_lock?

-
