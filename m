Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315815AbSENQ2X>; Tue, 14 May 2002 12:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315816AbSENQ2W>; Tue, 14 May 2002 12:28:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11411 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315815AbSENQ1e>;
	Tue, 14 May 2002 12:27:34 -0400
Date: Tue, 14 May 2002 18:26:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020514162641.GO17509@suse.de>
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <3CE11F90.5070701@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14 2002, Martin Dalecki wrote:
> Yes thinking about it longer and longer I tend to the same conclusion,
> that we just shouldn't have per device queue but per channel queues instead.

Right, I see that as the only right way to get the right synchronization
too.

> The only problem here is the fact that some device properties
> are attached to the queue right now. Like for example sector size and 
> friends.

Hmm yes, hardsect_size comes to mind. It will just have to be 'lowest
common denominator' for a while I suppose.

> I didn't have a too deep look in to the generic blk layer. But I would
> rather expect that since the lower layers are allowed to pass
> an spin lock up to the queue intialization, sharing a spin lock
> between two request queues should just serialize them with respect to
> each other. And this is precisely what 63 does.

I think you are mixing up two very different serialization issues. A
shared queue lock will indeed protect however much you want, but only at
the queue level. It will _not_ provide synchronization for hardware
access in any sane way, like a shared queue between two devices will.

You could alternatively move requests to an internal queue of your own
width, that would synchronize drive operations at any level you want
(you set the rules). The block layer can still sanely handle the locking
for you, the scope of that lock will just be a bit wider.

-- 
Jens Axboe

