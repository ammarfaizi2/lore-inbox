Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261681AbSI2Dzp>; Sat, 28 Sep 2002 23:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSI2Dzp>; Sat, 28 Sep 2002 23:55:45 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:64782 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S261681AbSI2Dzo>; Sat, 28 Sep 2002 23:55:44 -0400
Date: Sat, 28 Sep 2002 22:00:30 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
Message-ID: <1262792704.1033272030@aslan.scsiguy.com>
In-Reply-To: <200209281552.g8SFqKS04855@localhost.localdomain>
References: <200209281552.g8SFqKS04855@localhost.localdomain>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gibbs@scsiguy.com said:
>> 1) Device returns queue full with no outstanding commands from us
>>    (usually occurs in multi-initiator environments). 
> 
> That's another manifestation of the problem I referred to.
> 
>> 2) No delay after busy status so devices that will continually
>>    report BUSY if you hammer them with commands never come ready. 
> 
> I think Eric did that because the spec makes BUSY look less severe than
> QUEUE  FULL.  We can easily treat busy as QUEUE FULL.  That will cause a
> short delay  as the cmd goes back into the block queue and gets reissued.

The delay should be on the order of 500ms.  The turn around time for
re-issuing the command is not a sufficient delay.

>> 3) Queue is restarted as soon as any command completes even if
>>    you really need to throttle down the number of tags supported
>>    by the device. 
> 
> That's a valid flow control response.  Given the variability of queue
> depths,  particularly in multi-initiator/FC environments, it's not clear
> that  attempting to implement high/low water marks would buy anything.

It is exactly because of the variability of the queue depth that you must
implement a policy that will not only lower the depth but also raise it.
Soft/transient limits (e.g. Atlas II write cache fills and the tag depth
drops to 1 - or bursty behavior by another initiator) don't prevent you
from maximizing concurency on the device.  There can be no low-water mark,
only a high water mark based on repeated queue fulls at a certain level so
you optimize the common case where the device has a hard limit and you are
operating in a single initiator environment.  Queue fulls are not free.
This is even more the case if actually handle the retransmission ordering
case correctly (may require QErr or ECA/ACA recovery).
 
>> 4) No tag throttling.  If tag throttling is in 2.5, does it ever
>>    increment the tag depth to handle devices that report temporary
>>    resource shortages (Atlas II and III do this all the time, other
>>    devices usually do this only in multi-initiator environments). 
> 
> That depends on the tag philosophy, which is partly what this thread is
> all  about.  If you regard tags as simply a transport engine to the
> device and tend  to keep the number of tags much less than the number the
> device could accept,  then this isn't necessary.

There are complaints about read latency, and speculations about the cause.
You can't really argue "tag philosophy" without more information on why one
philosophy would perform differently in the given situation.

> Since this feature is one you particularly want for the aic, send us some
> code  and it can probably go in the mid-layer.

I think you misunderstand me.  If the aic drivers behave as best as they
can in Linux, then I'm mostly happy.  I've already written one OpenSource
SCSI mid-layer, given presentations on how to fix the Linux mid-layer, and
try to discuss these issues with Linux developers.  I just don't have the
energy to go implement a real solution for Linux only to have it thrown
away.  Life's too short.  8-)

> (or actually, if you want
> to talk to  Jens about it, the block layer).

I don't believe that much of the stuff that has recently been put into the
block layer has any reason to be there, but I'm not going to press my
"philosophical differences" in that area. 8-)

>> 5) Proper transaction ordering across a queue full.  The aic7xxx
>>    driver "requeues" all transactions that have not yet been sent
>>    to the device replacing the transaction that experienced the queue
>>    full back at the head so that ordering is maintained. 
> 
> I'm lost here.  We currently implement TCQ with simple tags which have no 
> guarantee of execution order in the drive I/O scheduler.

Do you run all of your devices with a queue algorithm modifier of 0?  If
not, then there certainly are guarantees on "effective ordering" even
in the simple queue task case.  For example, writes ands reads
to the same location must never occur out of order from the viewpoint of
the initiator - a sync cache command will only flush the commands that
have occurred before it, etc, etc.

As you note, this is even more important in the case of implementing
barriers.  Since you basically told me I should implement this support
in my drivers, I figured that ordering must be important. 8-)

>> No thought was put into any of these issues in 2.4, so I decided not
>> to even think about trusting the mid-layer for this functionality. 
> 
> Apart from the TCQ pieces, these are all edge cases which are rarely (if
> ever)  seen.

Handling the edge cases is what makes an OS enterprise worthy.  The
edge cases do happen, they are tested for (by Adaptec and the OEMs
that it supports) and the expectation is that they will be handled
gracefully.

> They afflict all drivers and the only one that causes any
> problems is  the mid-layer assumption that all devices can accept at
> least one command.

Actually, they affect very few "important" drivers because they implement
their own queuing (sym, aic7*, isp*, AdvanSys).

> By not using any of the mid-layer queueing, you've got into a catch-22 
> situation where we don't have any bug reports for these problems and you
> don't  see them because you don't use the generic infrastructure.

Oh come on.  These bugs have been known and talked about for at least three
years now.  The concensus has always been to continue to hack around this
stuff or just brush it off as "edge cases".  That is why the situation has
never improved.

> How about I look at fixing the above and you look at using the generic 
> infrastructure?

Once the generic infrastructure handles these cases and does proper
throttling (code for this is pretty easy to steal out of the aic7xxx
driver if you're interested) I'd be more than happy to rip out this extra
logic in my driver.  Its really sad to have to constantly lie to the
mid-layer in order to get reasonable results, but right now there is no
other option.

--
Justin
