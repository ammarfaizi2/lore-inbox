Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSFTLFa>; Thu, 20 Jun 2002 07:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSFTLF3>; Thu, 20 Jun 2002 07:05:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29907 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313711AbSFTLF2>;
	Thu, 20 Jun 2002 07:05:28 -0400
Date: Thu, 20 Jun 2002 13:05:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE booting problems with 2.5.23
Message-ID: <20020620110525.GB812@suse.de>
References: <16471.1024566396@warthog.cambridge.redhat.com> <3D11A6BB.8030705@evision-ventures.com> <20020620103532.GA812@suse.de> <3D11B551.9090201@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D11B551.9090201@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20 2002, Martin Dalecki wrote:
> >BTW, I see you renamed the flags to channel->active. I think that's a
> >bit misleading, can't you just call it ->state or ->flags (or
> >->state_flags? :-)
> 
> My reasoning behind this is - state is for device state
> register and active is well for the state of the driver. All the other
> names seemed for me to be too opaque for the purpose of it or already used.
> flags souns static to me.
> And you have to agree that it is *very* special
> purpose if you look at the IDE_BUSY bit.
> And finally - I took this name from the FreeBSD
> code to make it look a bit more similar.

How about busy_flags or busy_state, then? Active sounds like a bool to
me, and frankly what FreeBSD uses really has no bearing on what we
should choose :-)

> Another tought:
> 
> - We will have then an IDE_DMA which will indicate clearly
> that we are expecting some async event for the sake of DMA.

Right

> But we have IDE_BUSY overloaded with both:
> 
> - Flagging that we are expecting an IRQ to arrive during
>   PIO io (in conjencture with ->handler != NULL).
> 
> - Flagging that the do_request code path should be reentered
>   immediately or is busy.
> 
> I thihink its hard but worth it to split the semantic overload.
> In esp. a very fragile change. But I *feel* like it would
> be worth it. Suggestions opinnions?

Keep IDE_BUSY as saying 'we are busy handling an event', ie expecting an
interrupt at some point. This is what is serializing access to the
channel, not the spin lock btw. Only one 'user' can flag the channel as
busy and then proceed to setup a command etc.

I dunno about your #2, that sounds a bit confusing.

-- 
Jens Axboe

