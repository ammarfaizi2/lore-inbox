Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315797AbSENQUz>; Tue, 14 May 2002 12:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315800AbSENQUy>; Tue, 14 May 2002 12:20:54 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:1323 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S315797AbSENQUw>; Tue, 14 May 2002 12:20:52 -0400
Message-ID: <3CE13943.FBD5B1D6@ukaea.org.uk>
Date: Tue, 14 May 2002 17:20:19 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <3CE11F90.5070701@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Uz.ytkownik Alan Cox napisa?:
> >>From an abstract hardware point of view each ide controller is a queue not
> > each device. Not following that is I think the cause of much of the existing
> > pain and suffering.
> 
> Yes thinking about it longer and longer I tend to the same conclusion,
> that we just shouldn't have per device queue but per channel queues instead.
> The only problem here is the fact that some device properties
> are attached to the queue right now. Like for example sector size and friends.

OK..

> I didn't have a too deep look in to the generic blk layer. But I would
> rather expect that since the lower layers are allowed to pass
> an spin lock up to the queue intialization, sharing a spin lock
> between two request queues should just serialize them with respect to
> each other. And this is precisely what 63 does.

(You're planning to have two queues per channel but sharing the same
lock?)

On the serialisation issue: what does serialisation of the queues with
respect to each other mean to you?  I understand it to mean that we
won't ever call the request_fn of both queues at the same time - because
that's all the actual spinlock buys you.  It does not IIUC mean that you
can't get a call to request_fn of one queue while the other queue has
lots of requests in it (which are potentially being serviced by DMA). 
Or does it?  Does the block layer track which requests are "active"
somehow?

My main question could be posed thus: am I right in thinking that we
MUST track the busy-ness of the channel at all times?  (and for broken
chipsets, track the logical OR of both channels' busy-ness)

Neil
PS: I'm hoping someone will either say "here's why you're wrong" or
"you're right" RSN...
