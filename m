Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315598AbSENKeE>; Tue, 14 May 2002 06:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSENKeD>; Tue, 14 May 2002 06:34:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:54282 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315598AbSENKeD>; Tue, 14 May 2002 06:34:03 -0400
Message-ID: <3CE0D952.7080403@evision-ventures.com>
Date: Tue, 14 May 2002 11:30:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Neil Conway <nconway.list@ukaea.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <3CE0DDBE.F9EC80AC@ukaea.org.uk> <3CE0D067.6010302@evision-ventures.com> <3CE0E306.6171045B@ukaea.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Neil Conway napisa?:
> Martin Dalecki wrote:
> 
>>Uz.ytkownik Neil Conway napisa?:
>>
>>>The hwgroup was serialized so that in certain cases, it can contain BOTH
>>>channels, and thus only one channel is active at a time (e.g. cmd640).
>>>With this patch, you are now serializing only channels, not hwgroups
>>>(which makes hwgroup totally redundant, yes?), and I can't see which bit
>>>of your patch protects the chipsets that need both channels to be
>>>serialized.
>>>
>>>I think I see where you're going with the cleanup (and this isn't
>>>unrelated to the conversation about IDE-62) but as it stands, this patch
>>>will IMHO totally fsck any machines with dodgy chipsets.
>>
>>No it will not, since we act serialized on ide_lock anyway.
>>However I have right now per channel (or serialization group)
>>lock running right now / modulo locking order problems.
> 
> 
> One of us is missing the point (and I'm the newbie so blame me ;-)), so
> here goes:
> 
> Only the calls from the block layer to the request_fn are serialized by
> ide_lock. Not the actual data transfers.  Here's the scenario: 
> 
> Firstly, an I/O request is queued by ide_do_request(), and then it
> returns.  Let's assume that DMA is now in progress.  Once
> ide_do_request() returns, the lock is released by the block layer.  Now
> the corruption scenario: another request can come in for the other
> channel while our first I/O is in flight, and since the ide_lock isn't
> held, and the second channel isn't BUSY, ide_do_request() will be happy
> to try and start an I/O on that channel too.  BOOM.
> 
> Or is there a dumb mistake in my logic?

There is no problem to go in paralell on different channels for
requests. The serialization has only to be done
for the drive setup.

> Neil
> PS: I appreciate that your code is in a transition phase but I think
> it's desirable to avoid badly broken 2.5's all the same.
> 
> 


