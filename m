Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310776AbSCLLiM>; Tue, 12 Mar 2002 06:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310552AbSCLLiD>; Tue, 12 Mar 2002 06:38:03 -0500
Received: from [195.63.194.11] ([195.63.194.11]:6152 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S310604AbSCLLht>;
	Tue, 12 Mar 2002 06:37:49 -0500
Message-ID: <3C8DE847.1050905@evision-ventures.com>
Date: Tue, 12 Mar 2002 12:36:39 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111944090.18649-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 11 Mar 2002, Linus Torvalds wrote:
> 
>>One solution may be to have the whole raw cmd thing as a loadable module, 
>>and then I can make sure that it's not even available on the system so 
>>that I have to do some work to find it, and somebody elses program won't 
>>just know what to do.
>>
>>But in that case is should be far removed from the IDE driver - it would 
>>just be a module that inserts a raw request on the request queue, and NOT 
>>inside some subsystem driver that I obviously want to have available all 
>>the time.
>>
> 
> Let me put this proposal in more specific terms and see who hollers..
> 
> First, the actual assumptions:
>  - we should use the request queue, simply because that is the only thing 
>    that serializes access to all controllers - if we do not have any 
>    "sideband", there is no way to create the kind of confusion that we can
>    create right now.

Amen to this.

>  - we want the approach to be generic, even if the details will end up 
>    being IDE/SCSI/xxx-specific.

Could be done but seems to be very optimistic about the actual
detail. However stuff like flush/power up/power down/operate silent/operate fast
should be indeed generic.

>  - I personally believe that we want to be able to do filtering
>    independently of the controller driver, ie the filtering is not part of
>    the driver infrastructure at all, but at a higher level (ie the same 
>    way network filtering has _nothing_ to do with any actual network
>    drivers, regardless of what bus those drivers are on)
> 
> Thus I would suggest against a filter inside the IDE driver, and instead 
> suggest a loadable module that does
> 
>  - attach to one or more request queue(s). Notice that you should not have
>    _one_ module that handles all request queues, because the filter module
>    obviously has to be different for an ATA disk than for a SCSI disk, and
>    in fact it might be different for an IBM ATA disk than for a Maxtor ATA
>    disk, for example.
> 
>  - the module basically acts the way the SCSI generic driver does right 
>    now, except it acts on a higher level: instead of generating SCSI
>    requests and feeding them directly to the driver with a scsi_do_req(), 
>    it would generate the command requests and feed it to the request 
>    queue.
> 
>    In fact, don't think of it as the ATA thing at all: I'm more thinking 
>    along the lines of splitting up "sg.c" into the highlevel command 
>    generator (the biggest part) and a very _small_ part in the scsi 
>    request loop that understands about the generic command interface.

The last part could make the few above possible. But the layering problems
in ide are currently much preventig the most trivial kind of validation.
See for example problems in asynchornous commands, which turned out recently.

