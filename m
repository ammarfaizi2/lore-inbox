Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315794AbSENQJt>; Tue, 14 May 2002 12:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315796AbSENQJs>; Tue, 14 May 2002 12:09:48 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:63530 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S315795AbSENQJq>; Tue, 14 May 2002 12:09:46 -0400
Message-ID: <3CE1356A.B09C62F1@ukaea.org.uk>
Date: Tue, 14 May 2002 17:03:54 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I think you're wrong Alan.  Take a good IDE chipset as an example: both
> > channels can be active at the same time, but you still can't talk to one
> > drive while the other drive on the same channel is DMAing.
> 
> Sure.

Phew, at least we agree on something.  In fact I _think_ we were maybe
talking at cross-purposes and not disagreeing about anything that
actually mattered :-)

> > It doesn't matter how you perform the queue abstraction in this case:
> > the fact that the device+channel+cable is busy in an asynchronous manner
> > makes it impossible for the block layer to deal with this.  [[Or am I
> > way off base?!]]
> 
> I think you are way off base. If you have a single queue for both hda and
> hdb then requests will get dumped into that in a way that processing that
> queue implicitly does the ordering you require.

Hmm, OK. So the queue will potentially fill up with requests for both
hda and hdb.  The request_fn for this queue will get called, sometimes
by the block layer, sometimes not, and can handle all/some/none of the
requests at each call.  If it decides to handle (say) one of the
requests by initiating DMA and then returns while bytes are
transferring, then let's think what happens next time it gets called... 
If it's called as a result of the DMA-complete interrupt, then no
worries because the DMAing is finished.  If it's called instead by the
block-layer because another request has been added, it needs to know
that it shouldn't do anything until the DMAing finishes.  It could find
that out by looking at a channel->busy flag.  If it doesn't use a busy
flag, then what provides the locking?

I'm slowly growing more sure that I've missed the point.  But please
point to the mistake in the above logic to help me learn...

> From an abstract hardware point of view each ide controller is a queue not
> each device. Not following that is I think the cause of much of the existing
> pain and suffering.

Agreed.  And in the case of a cmd640 (etc.), the queue should handle
both channels.

cheers
Neil
