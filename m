Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSGDRMY>; Thu, 4 Jul 2002 13:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSGDRMY>; Thu, 4 Jul 2002 13:12:24 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:61675 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S311710AbSGDRMW>;
	Thu, 4 Jul 2002 13:12:22 -0400
Message-ID: <3D248208.4060500@colorfullife.com>
Date: Thu, 04 Jul 2002 19:12:40 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en, de
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: usb storage cleanup
References: <3D236950.5020307@colorfullife.com> <20020703144329.D8033@one-eyed-alien.net> <3D237870.7010600@colorfullife.com> <20020703170521.E8033@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> 
>>E.g. queue_command stored new commands in ->queue_srb. The worker thread 
>>then moved it from queue_srb to srb and set sm_state to RUNNING.
>>
>>But what if command_abort() is called before the worker thread is scheduled?
> 
> 
> Then we have a serious problem, because the aborts are on the order of
> several seconds.  If the thread hasn't gotten scheduled by then it _should_
> cause a BUG_ON.
>

First of all, it's dead ugly. usb-storage crashes if the scheduler is 
overloaded. IMHO that's a bug, especially since it's simple to avoid it.

And what about storage_disconnect()?

Test case: user pulls out the usb cable while a transfer is in progress. 
urb submitted to the device, reply not yet received.
Result: storage_disconnect() would hang for 20 seconds until 
command_abort() is called.
I've fixed that by adding usb_stor_abort_transport() into 
storage_disconnect(). But that means that abort_transport() could run in 
the window between queuecommand() and the scheduling of the worker thread.

Read through my proposal: With current_urb_sem [I've called it urb_sem, 
but it's the same concept], the synchronization between abort and new 
commands is guaranteed.

The only difference is that I've moved testing ->abort_cmd and 
down(&->urb_sem) into usb_stor_msg_common: Requesting that the callers 
must acquire the semaphore and check abort_cmd() is unnecessary code 
duplication and just asks for bugs.

> 
>>>You're reverting the new mechanism to determine device state... why?
>>
>>Unnesessary duplication. Device disconnected is equivalent to 
>>->pusb_dev==NULL. Why do you need a special variable?
> 
> 
> Because relying on a pointer has caused problems in the past, especially
> when there are concerns that the pointer might be invalid.
> 

Could you explain a bit more? How could the pointer become invalid?

> 
>>>You're removing the entire bus_reset() logic... why?
>>>
>>
>>You are right, that change is not correct.
>>Do you remember the reasons that lead to the current implementation?
>>
>>Hmm. Are you sure that the code can't cause data losses with unrelated 
>>devices?
>>Suppose I have an usb hub installed, and behind that hub 2 usb disks. If 
>>bus_reset is called for the scsi controller that represents one disk, 
>>won't that affect the data transfer that go to the other disk?
> 
> 
> The hub isn't reset, only the target device is.
> 
You are right.

That leaves one problem: a real disconnect in the middle of 
host_reset(), i.e. after checking us->bitflags or reading pusb_dev.

It should be possible to handle that case, too: usb_device structures 
are refcounted.

> 
>>The only new change is removing the call to usb_stor_CBI_irq() and 
>>replacing it with "up(&us->ip_waitq);" from usb_stor_abort_transport. 
>>Setting sm_state and then calling usb_stor_CBI_irq() is a 
>>synchronization nightmare.
>>Situation: command is completed by the hardware and aborted by the scsi 
>>midlayer at the same time. usb_stor_abort_transport() could run on cpu1, 
>>_CBI_irq() on cpu2. Now imagine you run on Alpha, where both reads and 
>>writes are reordered. Initially I tried to fix it with memory barriers, 
>>but the new version is much simpler.
> 
> 
> The only requirement in this condition is that the command state be
> consistent at the end -- either completed or aborted.  I don't see how the
> current code fails this requirement...
> 

My version is shorter ;-)
usb_stor_CBI_irq() containes 2 independent parts: only part only for 
command aborts, one part for normal interrupts. By splitting the 
function several lines of exception handling became unnecessary.


--
	Manfred

