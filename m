Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314362AbSEMSMh>; Mon, 13 May 2002 14:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314375AbSEMSMg>; Mon, 13 May 2002 14:12:36 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:4290 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S314362AbSEMSMf>; Mon, 13 May 2002 14:12:35 -0400
From: <benh@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
Date: Mon, 13 May 2002 20:13:07 +0100
Message-Id: <20020513191308.10469@mailhost.mipsys.com>
In-Reply-To: <3CDFE1EE.3050800@evision-ventures.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just to clarify it... From the host view it's not the chipset
>it's a channel we have to deal with. And there are typically two
>channels on a host. For the serialized parts, we have to
>possiblities:
>
>1. Preserve the current behaviour of using additionally a global
>lock.
>
>2. "Cheat" and reuse the lock from the primary channel during
>the initialization of the secondary channel.
>
>Hmmm.... Thinking a bit about it I'm now conviced that 2. is more
>elegant then 1. And finally this will
>just allow us to make the hwgroup_t go entierly away.

I would do things differently. From the common point of view,
what we deal with is

   controller
    /        \
 channel x, channel y, ....

That is an _arbitrary_ number of channels. So the host driver
should just register individual "channels" to the IDE layer, 
each one has it's queue lock, period.

Now, if for any reason, the host specific code has to synchronize
between several of it's channels when dealing with things like
chipset configuration, it's up to that host driver to know about
it and deal with it; which make perfect sense to be done with a
third lock specific to protecting those specific registers that
are shared and that is completely internal to the host chipset
driver.

The only case I see where the host may have to additionally go
and grab the other channel's locks (the queue lock or whatever
you call it) is if the actual setting change on one channel 
has side effect on a currently transferring other channel.

But that is completely internal to the host, and yes, I agree
that reusing the other channel's lock is probably the best solution.

But in cases where you just have 2 bitfields in the same register
that need serialized access from both channels, a simple lock
protecting only that register seems to be plenty enough.

What did I miss ?

Ben.


