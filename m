Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316347AbSEOGSx>; Wed, 15 May 2002 02:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316348AbSEOGSw>; Wed, 15 May 2002 02:18:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59586 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316347AbSEOGSv>;
	Wed, 15 May 2002 02:18:51 -0400
Date: Wed, 15 May 2002 08:16:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020515061654.GC11948@suse.de>
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14 2002, Anton Altaparmakov wrote:
> At 15:30 14/05/02, Martin Dalecki wrote:
> >Uz.ytkownik Alan Cox napisa?:
> >>I think you are way off base. If you have a single queue for both hda and
> >>hdb then requests will get dumped into that in a way that processing that
> >>queue implicitly does the ordering you require.
> >>From an abstract hardware point of view each ide controller is a queue not
> >>each device. Not following that is I think the cause of much of the 
> >>existing
> >>pain and suffering.
> >
> >Yes thinking about it longer and longer I tend to the same conclusion,
> >that we just shouldn't have per device queue but per channel queues 
> >instead.
> >The only problem here is the fact that some device properties
> >are attached to the queue right now. Like for example sector size and 
> >friends.
> >
> >I didn't have a too deep look in to the generic blk layer. But I would
> >rather expect that since the lower layers are allowed to pass
> >an spin lock up to the queue intialization, sharing a spin lock
> >between two request queues should just serialize them with respect to
> >each other. And this is precisely what 63 does.
> 
> Hi Martin,
> 
> instead of having per channel queue, you could have per device queue, but 
> use the same lock for both, i.e. don't make the lock part of "struct queue" 
> (or whatever it is called) but instead make the address of the lock be 
> attached to "struct queue".

See request_queue_t, the lock can already be shared. And in fact the ide
layer used a global ide_lock shared between all queues until just
recently.

> Further if a controller is truly broken and you need to synchronize 
> multiple channels you could share the lock among those.

Again, this is not enough! The lock will only, at best, serialize direct
queue actions. So I can share a lock between queue A and B and only one
of them will start a request at any given time, but as soon as request X
is started for queue A, then we can happily start request Y for queue B.

This is what the hwgroup busy flag protects right now, only one queue is
allowed to mark the hwgroup busy naturally. So only when request X for
queue A completes will the hwgroup busy flag be cleared, and queue B can
start request Y.

-- 
Jens Axboe

