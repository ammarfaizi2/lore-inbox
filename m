Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSFTLWX>; Thu, 20 Jun 2002 07:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSFTLWW>; Thu, 20 Jun 2002 07:22:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56074 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313563AbSFTLWV> convert rfc822-to-8bit; Thu, 20 Jun 2002 07:22:21 -0400
Message-ID: <3D11BAEB.1090502@evision-ventures.com>
Date: Thu, 20 Jun 2002 13:22:19 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE booting problems with 2.5.23
References: <16471.1024566396@warthog.cambridge.redhat.com> <3D11A6BB.8030705@evision-ventures.com> <20020620103532.GA812@suse.de> <3D11B551.9090201@evision-ventures.com> <20020620110525.GB812@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> On Thu, Jun 20 2002, Martin Dalecki wrote:
> 
>>>BTW, I see you renamed the flags to channel->active. I think that's a
>>>bit misleading, can't you just call it ->state or ->flags (or
>>>->state_flags? :-)
>>
>>My reasoning behind this is - state is for device state
>>register and active is well for the state of the driver. All the other
>>names seemed for me to be too opaque for the purpose of it or already used.
>>flags souns static to me.
>>And you have to agree that it is *very* special
>>purpose if you look at the IDE_BUSY bit.
>>And finally - I took this name from the FreeBSD
>>code to make it look a bit more similar.
> 
> 
> How about busy_flags or busy_state, then? Active sounds like a bool to
> me, and frankly what FreeBSD uses really has no bearing on what we
> should choose :-)
> 
> 
>>Another tought:
>>
>>- We will have then an IDE_DMA which will indicate clearly
>>that we are expecting some async event for the sake of DMA.
> 
> 
> Right
> 
> 
>>But we have IDE_BUSY overloaded with both:
>>
>>- Flagging that we are expecting an IRQ to arrive during
>>  PIO io (in conjencture with ->handler != NULL).
>>
>>- Flagging that the do_request code path should be reentered
>>  immediately or is busy.
>>
>>I thihink its hard but worth it to split the semantic overload.
>>In esp. a very fragile change. But I *feel* like it would
>>be worth it. Suggestions opinnions?
> 
> 
> Keep IDE_BUSY as saying 'we are busy handling an event', ie expecting an
> interrupt at some point. This is what is serializing access to the
> channel, not the spin lock btw. Only one 'user' can flag the channel as
> busy and then proceed to setup a command etc.
> 
> I dunno about your #2, that sounds a bit confusing.

I try to clarify a bit. After looking closer at the code I noticed
that IDE_BUSY is not just idicating that we should not
reenter the request handling. It is used to indicate that
we should reenter the request handling immediately after return
and it is used to indicate that a PIO transfer is in progress.
What I think about is to invent IDE_PIO as a first cut, which
would serve the same purpose as IDE_DMA for PIO transfers.
In esp. indicating that there is PIO IO in progress waiting for
an IRQ to happen. Stalling the request queue reentry should
be a different sotry then this I think. Hope this makes it more
clear.

> 



