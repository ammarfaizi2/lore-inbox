Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSGXKcs>; Wed, 24 Jul 2002 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSGXKcs>; Wed, 24 Jul 2002 06:32:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29964 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316971AbSGXKcq>; Wed, 24 Jul 2002 06:32:46 -0400
Message-ID: <3D3E81CA.2080605@evision.ag>
Date: Wed, 24 Jul 2002 12:30:34 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: martin@dalecki.de, Morten Helgesen <morten.helgesen@nextframe.net>,
       linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <Pine.SOL.4.30.0207231617410.10916-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>  Tue, 23 Jul 2002, Marcin Dalecki wrote:
> 
> 
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>
>>>Martin why aren't you telling people all facts?
>>>It was the default behaviour before your change in IDE 99.
>>>This patch in practice reverts IDE 99 change.
>>>
>>>You have INTRODUCED a bug and now you try to
>>>pretend that it wasn't your fault and it was somehow broken before.
>>
>>Never said that. Sure it was my fault I looked in the wrong direction
>>I looked at the ide-tcq code, becouse I still dont like the
>>idea that we pass a pointer for a struct on the local stack down.
>>(It's preventing the futile hope to make this thingee somehow
>>asynchronous form ever taking place.)
>>
>>I should have looked at SCSI in first place instead indeed.
>>
>>
>>>Before 2.5.27 code had the same functionality as scsi version.
>>
>>That's actually not true... At least the setting of the
>>request rq->flags is significantly different here and there.
> 
> 
> You are right here...
> Actually IDE request should have REQ_BARRIER bit also set for safety
> and coherency.
> Without barrier requests added after special command can be merged
> with requests added before special command.
> 
> 
>>However I think but I'm not sure that the fact aht we have rq->special
>>!= NULL here has the hidded side effect that we indeed accomplish the
>>same semantics.
> 
> 
> No.

There are some nasty checks for it != NULL in the generic BIO code.
And REQ_BARRIER got introduced just recently, so we can see the
error will have been propagated.

>>>And yes it will be useful to move it to block layer.
>>
>>Done. Just needs testing. I have at least an ZIP parport drive, which
>>allows me to do some basic checks.
> 
> 
> Test everything on your production machine + main hdd.
> Will make you care more about code correctness ;-).

Nah... that's just for the SCSI code "move around". The rest
I usually run continuously on two systems.

>>BTW.> Having a fill up request queue trashing data transfers
>>is indicating that there may be are bugs in the generic block layer too.
>>If it gets pushed to boundary conditions it's apparently not very
> 
> 
> No it wasn't "pushed to boundary conditions", you screwed it, sorry.
> 
> 
>>robust... BTW.> I never ever will understand why
>>request_fn returns void instead of an status value.
> 
> 
> So look at ide.c for example.

So look at drivers which call blk_start_queue() from within 
q->request_fn context, which is, well, causing deliberate *recursion*.

