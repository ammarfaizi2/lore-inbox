Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315695AbSENNEr>; Tue, 14 May 2002 09:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315699AbSENNEr>; Tue, 14 May 2002 09:04:47 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:2358 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S315695AbSENNEq>; Tue, 14 May 2002 09:04:46 -0400
Message-ID: <3CE10B2B.822CA194@ukaea.org.uk>
Date: Tue, 14 May 2002 14:03:39 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177b8s-0007lm-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> If the queue abstraction is right then the block layer should do all the
> synchronization work that is required. 

I think you're wrong Alan.  Take a good IDE chipset as an example: both
channels can be active at the same time, but you still can't talk to one
drive while the other drive on the same channel is DMAing.

I'm not a block layer expert, but it appears to me that the block layer
only synchronises requests by use of the spinlock.  If I'm right, then
the block layer has no way of knowing that hda is DMAing when a request
is initiated for hdb.  This was the whole reason (as I see it) that
hwgroup->busy existed: to prevent attempts to use the same IDE cable for
two things at the same time.

It doesn't matter how you perform the queue abstraction in this case:
the fact that the device+channel+cable is busy in an asynchronous manner
makes it impossible for the block layer to deal with this.  [[Or am I
way off base?!]]

The right way is the way it is being done at present surely: if the busy
flag on the hwgroup is set, then ide_do_request() just returns.  (NB:
When I say "right way", I don't mean to imply that the code is elegant,
desirable, or even bug-free, just that it correctly handles this busy
state.)

>It may cost a few cycles on the odd
> case you can do overlapped command setup but that versus a nasty locking
> mess its got to be better to lose those few cycles.

Well, Jens and others are busy implementing TCQ where things are just so
much easier to fsck up :-))

> I don't even Martin here, the ide locking is currently utterly vile

Agreed, but surely with some concerted effort we can truly fix the IDE
code.  Can't be beyond us all can it?

Neil
