Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318717AbSHAJ61>; Thu, 1 Aug 2002 05:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318718AbSHAJ61>; Thu, 1 Aug 2002 05:58:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25092 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318717AbSHAJ60>; Thu, 1 Aug 2002 05:58:26 -0400
Message-ID: <3D4905DB.70305@evision.ag>
Date: Thu, 01 Aug 2002 11:56:43 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
References: <9B9F331783@vcnet.vc.cvut.cz> <3D48420F.5050407@evision.ag> <20020801095609.GE1096@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Jul 31 2002, Marcin Dalecki wrote:
> 
>>>Unfortunately, problem is still here: when kernel was in idedisk_do_request
>>>performed on channel 0, IRQ for channel 1 arrived, and this irq found 
>>>channel 1 DMA engine ready, but drive had DRQ set... oops. Shortly after 
>>>that IRQ for channel 1 arrived again, but as it was unexpected, nothing 
>>>happened. 
>>>
>>>I hope that i845 is not simplex device, but first (unexpected) IRQ arrived 
>>>just when channel 0 code wrote new value to its IDE_SELECT_REG register. 
>>>Now I even disconnected DVD drive, so it is simple two masters, two
>>>channels configuration, but it still happens.
>>
>>One idea and one experiment I was already thinking about is
>>to change do_ide_request to actually *not* select delibreately which 
>>device do handle. (The big for loop found there...)
>>One can instead search for a device on the channel which is matching
>>the queue for which do_ide_request() was called.
>>
>>for (unit = 0; unit < MAX_DEVICES; ++unit) {
>>  ....
>>  if (tmp->queue == q) {
>>        drive = tmp;
>>	break;
>>  }
>>}
>>if (!drive)
>>  BUG();
> 
> 
> hey that sucks :-)

Since IDE 111 not any more...

> seriously, the better way to do this would be to change the q->queuedata
> to be a pointer to drive instead of the channel.

... becouse this is already *done* there :-).

> that would work, but I think it would seriously starve the other device
> on the same channel.

We starve anyway, becouse the kernel isn't real time and we can't
guarantee "sleeping" for some maximum time and comming back.
We don't reschedule the kernel during this kind of "sleeping".
And we can't know that a command on the "mate" will not take 
extraordinary amounts of time. It's only a problem if mixing travan
tapes with disks on a channel.




