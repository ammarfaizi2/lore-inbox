Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSENWwB>; Tue, 14 May 2002 18:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316114AbSENWwB>; Tue, 14 May 2002 18:52:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62992
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316113AbSENWwA>; Tue, 14 May 2002 18:52:00 -0400
Date: Tue, 14 May 2002 15:51:47 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Conway <nconway.list@ukaea.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020514225147.GP2392@matchmail.com>
Mail-Followup-To: Neil Conway <nconway.list@ukaea.org.uk>,
	Jens Axboe <axboe@suse.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <3CE11F90.5070701@evision-ventures.com> <3CE13943.FBD5B1D6@ukaea.org.uk> <20020514163241.GR17509@suse.de> <3CE13F99.5BDED3DF@ukaea.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 05:47:21PM +0100, Neil Conway wrote:
> Jens Axboe wrote:
> > To really serialize operations the queue _must_ be shared with whoever
> > requires serialiation.
> 
> Why will this help?  The hardware can still be doing DMA on hda while
> the queue's request_fn is called quite legitimately for a hdb request -
> and the IDE code MUST impose the serialization here to avoid hitting the
> cable with commands destined for hdb. (For example, by waiting for
> !channel->busy.)

First of all, why do you think that when a new request is queued it hits the
hardware immediately?  I mean, it is a queue after all...

I'd immagine that you would have one function that is triggered by DMA
completion interrupts that reads the queue and starts the hardware for a
request.

While that function is operating the hardware, it should't care about the
queue, so you can add requests to the queue for both (think hda and hdb)
devices on the channel.

channel = ide cable

There is a hardware limitation for IDE in that it doesn't allow more than
one device to be active on one channel at a time.  So, there is no point in
having seperate queues for each device on the channel since the two queues
would just be waiting on each other, and would probably end up a pretty big
mess.

If a host controller (think ide chipset with multiple channels 2,4,8 etc)
needs serialization between multiple channels, then you can simply use one
queue for each group of channels that need searialization between each other.

Mike

(OT, now that IDE is getting TCQ, will the main difference between SCSI and
IDE be just the number of devices per cable?  I'm not talking electrically
or about the protocol, but mainly performance from say the block layer's
perspective)
