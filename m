Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSGCWQ6>; Wed, 3 Jul 2002 18:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317265AbSGCWQ5>; Wed, 3 Jul 2002 18:16:57 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:56552 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S317264AbSGCWQ4>;
	Wed, 3 Jul 2002 18:16:56 -0400
Message-ID: <3D237870.7010600@colorfullife.com>
Date: Thu, 04 Jul 2002 00:19:28 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en, de
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: usb storage cleanup
References: <3D236950.5020307@colorfullife.com> <20020703144329.D8033@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> I don't understand what this patch is trying to do...
> 
> You're reverting our new state machine changes... why?
> 

Because the state machine doesn't work. I've degraded it into a 
debugging state.
I've described it in a mail I send to you and linux-usb-devel a few 
weeks ago, without any reply.

E.g. queue_command stored new commands in ->queue_srb. The worker thread 
then moved it from queue_srb to srb and set sm_state to RUNNING.

But what if command_abort() is called before the worker thread is scheduled?

State machines and asynchroneous command aborts are incompatible, that 
why I've moved command abortion out of sm_state.

>
> You're reverting the new mechanism to determine device state... why?
>

Unnesessary duplication. Device disconnected is equivalent to 
->pusb_dev==NULL. Why do you need a special variable?

>
> You're removing the entire bus_reset() logic... why?
>
You are right, that change is not correct.
Do you remember the reasons that lead to the current implementation?

Hmm. Are you sure that the code can't cause data losses with unrelated 
devices?
Suppose I have an usb hub installed, and behind that hub 2 usb disks. If 
bus_reset is called for the scsi controller that represents one disk, 
won't that affect the data transfer that go to the other disk?


> This patch undoes most of the work done in the last few months.  I
> _strongly_ oppose the patch without some better explanations.
> 

I've sent you a mail on 06/02 with details about all changes.

http://www.geocrawler.com/archives/3/2571/2002/6/600/8821396/

You did not reply, thus I assumed that you were too busy and I fixed 
everything myself.

The only new change is removing the call to usb_stor_CBI_irq() and 
replacing it with "up(&us->ip_waitq);" from usb_stor_abort_transport. 
Setting sm_state and then calling usb_stor_CBI_irq() is a 
synchronization nightmare.
Situation: command is completed by the hardware and aborted by the scsi 
midlayer at the same time. usb_stor_abort_transport() could run on cpu1, 
_CBI_irq() on cpu2. Now imagine you run on Alpha, where both reads and 
writes are reordered. Initially I tried to fix it with memory barriers, 
but the new version is much simpler.

--
	Manfred

